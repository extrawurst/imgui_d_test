/*
 * Copyright (c) 2015 Derelict Developers
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * * Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the distribution.
 *
 * * Neither the names 'Derelict', 'DerelictILUT', nor the names of its contributors
 *   may be used to endorse or promote products derived from this software
 *   without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
module derelict.imgui.imgui;

public
{
	import derelict.imgui.types;
	import derelict.imgui.funcs;
}

private
{
    import derelict.util.loader;

    version(darwin)
        version = MacOSX;
    version(OSX)
        version = MacOSX;
}

private
{
    import derelict.util.loader;
    import derelict.util.system;

    static if(Derelict_OS_Windows)
        enum libNames = "cimgui.dll";    
    else static if (Derelict_OS_Mac)
        enum libNames = "cimgui.dylib";
    else static if (Derelict_OS_Linux)
		enum libNames = "cimgui.so";
    else
        static assert(0, "Need to implement imgui libNames for this operating system.");
}

class DerelictImguiLoader : SharedLibLoader
{

    protected
    {
        override void loadSymbols()
        {
			{
				//search: (ig_\S+)
				//replace: bindFunc\(cast\(void**\)&$1, "$1"\);
			
				bindFunc(cast(void**)&ig_GetIO, "ig_GetIO");
				bindFunc(cast(void**)&ig_GetStyle, "ig_GetStyle");
				bindFunc(cast(void**)&ig_NewFrame, "ig_NewFrame");
				bindFunc(cast(void**)&ig_Render, "ig_Render");
				bindFunc(cast(void**)&ig_Shutdown, "ig_Shutdown");
				bindFunc(cast(void**)&ig_ShowUserGuide, "ig_ShowUserGuide");
				bindFunc(cast(void**)&ig_ShowStyleEditor, "ig_ShowStyleEditor");
				bindFunc(cast(void**)&ig_ShowTestWindow, "ig_ShowTestWindow");
				bindFunc(cast(void**)&ig_ShowMetricsWindow, "ig_ShowMetricsWindow");

				// Window
				bindFunc(cast(void**)&ig_Begin, "ig_Begin");
				bindFunc(cast(void**)&ig_Begin2, "ig_Begin2");
				bindFunc(cast(void**)&ig_End, "ig_End");
				bindFunc(cast(void**)&ig_BeginChild, "ig_BeginChild");
				bindFunc(cast(void**)&ig_BeginChild2, "ig_BeginChild2");
				bindFunc(cast(void**)&ig_EndChild, "ig_EndChild");
				bindFunc(cast(void**)&ig_GetContentRegionMax, "ig_GetContentRegionMax");
				bindFunc(cast(void**)&ig_GetWindowContentRegionMin, "ig_GetWindowContentRegionMin");
				bindFunc(cast(void**)&ig_GetWindowContentRegionMax, "ig_GetWindowContentRegionMax");
				bindFunc(cast(void**)&ig_GetWindowDrawList, "ig_GetWindowDrawList");
				bindFunc(cast(void**)&ig_GetWindowFont, "ig_GetWindowFont");
				bindFunc(cast(void**)&ig_GetWindowFontSize, "ig_GetWindowFontSize");
				bindFunc(cast(void**)&ig_SetWindowFontScale, "ig_SetWindowFontScale");
				bindFunc(cast(void**)&ig_GetWindowPos, "ig_GetWindowPos");
				bindFunc(cast(void**)&ig_GetWindowSize, "ig_GetWindowSize");
				bindFunc(cast(void**)&ig_GetWindowWidth, "ig_GetWindowWidth");
				bindFunc(cast(void**)&ig_GetWindowCollapsed, "ig_GetWindowCollapsed");

				bindFunc(cast(void**)&ig_SetNextWindowPos, "ig_SetNextWindowPos");
				bindFunc(cast(void**)&ig_SetNextWindowSize, "ig_SetNextWindowSize");
				bindFunc(cast(void**)&ig_SetNextWindowCollapsed, "ig_SetNextWindowCollapsed");
				bindFunc(cast(void**)&ig_SetNextWindowFocus, "ig_SetNextWindowFocus");
				bindFunc(cast(void**)&ig_SetWindowPos, "ig_SetWindowPos");
				bindFunc(cast(void**)&ig_SetWindowSize, "ig_SetWindowSize");
				bindFunc(cast(void**)&ig_SetWindowCollapsed, "ig_SetWindowCollapsed");
				bindFunc(cast(void**)&ig_SetWindowFocus, "ig_SetWindowFocus");
				bindFunc(cast(void**)&ig_SetWindowPos2, "ig_SetWindowPos2");
				bindFunc(cast(void**)&ig_SetWindowSize2, "ig_SetWindowSize2");
				bindFunc(cast(void**)&ig_SetWindowCollapsed2, "ig_SetWindowCollapsed2");
				bindFunc(cast(void**)&ig_SetWindowFocus2, "ig_SetWindowFocus2");
			}

			bindFunc(cast(void**)&ig_Text, "ig_Text");
			bindFunc(cast(void**)&ig_SliderFloat, "ig_SliderFloat");
            bindFunc(cast(void**)&ig_ColorEdit3, "ig_ColorEdit3");

			bindFunc(cast(void**)&ig_Button, "ig_Button");
            bindFunc(cast(void**)&ig_SmallButton, "ig_SmallButton");

			bindFunc(cast(void**)&ImFontAtlas_GetTexDataAsRGBA32, "ImFontAtlas_GetTexDataAsRGBA32");
            bindFunc(cast(void**)&ImFontAtlas_SetTexID, "ImFontAtlas_SetTexID");
			bindFunc(cast(void**)&ImDrawList_GetVertexBufferSize, "ImDrawList_GetVertexBufferSize");
			bindFunc(cast(void**)&ImDrawList_GetVertexPtr, "ImDrawList_GetVertexPtr");
			bindFunc(cast(void**)&ImDrawList_GetCmdSize, "ImDrawList_GetCmdSize");
			bindFunc(cast(void**)&ImDrawList_GetCmdPtr, "ImDrawList_GetCmdPtr");
            bindFunc(cast(void**)&ImGuiIO_AddInputCharacter, "ImGuiIO_AddInputCharacter");

            bindFunc(cast(void**)&ig_TreeNode, "ig_TreeNode");
            bindFunc(cast(void**)&ig_TreeNode_IdFmt, "ig_TreeNode_IdFmt");
            bindFunc(cast(void**)&ig_TreePop, "ig_TreePop");

            bindFunc(cast(void**)&ig_SameLine, "ig_SameLine");
        }
    }

    public
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictImguiLoader DerelictImgui;

shared static this()
{
	DerelictImgui = new DerelictImguiLoader();
}
