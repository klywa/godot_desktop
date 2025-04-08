using Godot;
using System;
using System.Runtime.InteropServices;

public partial class WallpaperMode : Node
{
	[DllImport("user32.dll", EntryPoint = "SetWindowPos")]
	public static extern IntPtr SetWindowPos(IntPtr hWnd, int hWndInsertAfter, int x, int Y, int cx, int cy, int wFlags);
	
	[DllImport("user32.dll")]
	private static extern bool SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);
	
	[DllImport("user32.dll")]
	private static extern int GetWindowLong(IntPtr hWnd, int nIndex);
	
	// Window style constants
	private const int GWL_STYLE = -16;
	private const int GWL_EXSTYLE = -20;
	private const int WS_EX_NOACTIVATE = 0x08000000;
	private const int WS_EX_LAYERED = 0x00080000;
	private const int WS_EX_TRANSPARENT = 0x00000020;
	
	// SetWindowPos constants
	private const short SWP_NOZORDER = 0X4;
	private const short SWP_NOMOVE = 0X2;
	private const short SWP_NOSIZE = 1;
	private const int SWP_SHOWWINDOW = 0x0040;
	private const int SWP_NOACTIVATE = 0x0010;
	private const int SWP_FRAMECHANGED = 0x0020;
	
	// HWND constants for window positioning
	private const int HWND_TOP = 0;
	private const int HWND_BOTTOM = 1;
	private const int HWND_TOPMOST = -1;
	private const int HWND_NOTOPMOST = -2;
	
	private bool _wallpaperModeActive = false;
	private IntPtr _windowHandle;
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		// Get the windows handle of the game window
		_windowHandle = new IntPtr(DisplayServer.WindowGetNativeHandle(DisplayServer.HandleType.WindowHandle));
		
		// Enable wallpaper mode by default
		EnableWallpaperMode();
	}
	
	public void EnableWallpaperMode()
	{
		if (_wallpaperModeActive)
			return;
			
		// Get current window style
		int exStyle = GetWindowLong(_windowHandle, GWL_EXSTYLE);
		
		// Add WS_EX_NOACTIVATE style to prevent window activation
		exStyle |= WS_EX_NOACTIVATE;
		
		// Set the new window style
		SetWindowLong(_windowHandle, GWL_EXSTYLE, exStyle);
		
		// Move window to bottom of z-order
		SetWindowPos(_windowHandle, HWND_BOTTOM, 0, 0, 0, 0, 
			SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE | SWP_FRAMECHANGED);
			
		_wallpaperModeActive = true;
	}
	
	public void DisableWallpaperMode()
	{
		if (!_wallpaperModeActive)
			return;
			
		// Get current window style
		int exStyle = GetWindowLong(_windowHandle, GWL_EXSTYLE);
		
		// Remove WS_EX_NOACTIVATE style
		exStyle &= ~WS_EX_NOACTIVATE;
		
		// Set the new window style
		SetWindowLong(_windowHandle, GWL_EXSTYLE, exStyle);
		
		// Restore normal window position
		SetWindowPos(_windowHandle, HWND_TOP, 0, 0, 0, 0, 
			SWP_NOMOVE | SWP_NOSIZE | SWP_FRAMECHANGED);
			
		_wallpaperModeActive = false;
	}
	
	public override void _Process(double delta)
	{
		// We can add more logic here if needed, but we are deliberately NOT
		// calling SetWindowPos every frame as per the requirements
	}
	
	public override void _ExitTree()
	{
		// Restore normal window behavior when exiting
		DisableWallpaperMode();
	}
}