Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99B8C98325
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9FE10E1D3;
	Fri, 25 Sep 2026 16:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G6jUDRZj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A79C10E1D3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:03:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D9496022F
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01F90C2BCB8
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790352212;
 bh=DNpSFzbmxykQUrGF9cOrA5SpLJlN0IMStONgomq5RJQ=;
 h=From:To:Subject:Date:From;
 b=G6jUDRZjJaRGFYvZgwF36q0hMGhP6o8Ip5Mwgb0cCkBAYr7E/4/Np7ba/53v6D0A5
 VGX7vMeOyZSQFoz/lOqQ4RdqIbduYouqyoozXzLrLMDT66x0Bk44+gwtclRHD71MGP
 7ox+BGfyeNgsoKceERmrZrclUDWBXFn8XHqQxAV/k7pNLSwmjj6/7vXNCgqX5A6g0G
 lLO2+l1mQ3HFmJNQ8rYpQltH+OLH4WK/8IkPDj+W1+AWV99eALt9u2+/DCh0Byow5J
 3I0vL0TVY4utOaz936yQn5sJ9ye8kFLGPChaQh+P4yDcIDTaYaPN6AK8hA18TLrbMy
 0+yW+eEPeIj3A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id D9AABC41612; Fri, 25 Sep 2026 16:03:31 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222061] New: [REGRESSION 7.1.8 -> 7.2] Strix Halo HDMI 1080p
 black after login (kwin framebuffer EINVAL). Full report on drm/amd#5893
Date: Fri, 25 Sep 2026 16:03:31 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: miguel@miguelmesa.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_file_loc bug_id short_desc product version
 cf_kernel_version rep_platform op_sys bug_status bug_severity priority
 component assigned_to reporter cf_regression
Message-ID: <bug-222061-2300@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D222061

               URL: https://gitlab.freedesktop.org/drm/amd/-/work_items/58
                    93
            Bug ID: 222061
           Summary: [REGRESSION 7.1.8 -> 7.2] Strix Halo HDMI 1080p black
                    after login (kwin framebuffer EINVAL). Full report on
                    drm/amd#5893
           Product: Drivers
           Version: 2.5
    Kernel Version: 7.2.6 (works on 7.1.8; 7.2.7 not tested)
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: miguel@miguelmesa.com
        Regression: Yes

Pointer only. The full report, hardware, and the isolation table are here:

https://gitlab.freedesktop.org/drm/amd/-/work_items/5893

Strix Halo iGPU (Radeon 8060S, PCI 1002:1586, DCN 3.5), single HDMI-A-1 at
1920x1080. Kernel 7.1.8 works (Display Core v3.2.378). Kernels 7.2.0 through
7.2.6 leave Plasma and Hyprland black immediately after the greeter. The
greeter and a TTY still work. Log line: kwin_wayland_drm: Failed to create
framebuffer (EINVAL). The LTS kernel did not restore the desktop. This is n=
ot
the 7.2 4K YCbCr 4:2:0 HDMI regression (drm/amd#5720, #5743).

Please track the bug on the drm/amd issue above.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
