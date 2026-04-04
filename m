Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B97E63FF6
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 20:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69DB010E0A8;
	Sat,  4 Apr 2026 20:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bg3ElQAD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6C610E0A8
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:09:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DB5C360008
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85420C19421
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 20:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775333351;
 bh=8pcTsj9JPvC0679FHtRxOCTXMYSEpYZllPfLZ07AShY=;
 h=From:To:Subject:Date:From;
 b=Bg3ElQADbaTjch8mrhe8U6wk1hGwE24TLIhS36ZsEXZHP1lvYlWHogrll+dvaaJVZ
 0JJu37qzUl/0YDOnvRzZKkoS6Pofk3Zi6EkaeW+SP3y58hdoC2gsMxvkCFlCcEY5wR
 WH5VlRw4sOdzjhSh5uufo/r+I0bQKpj/xQ1RvKD/OkhB2VRMWCj4nmC+vY8ZhPNmDk
 onhiT8yW7pB2oQfw8rGfx+gH2bfTgfI4bNmczmhegmy1yAt6NDhvCLv5jU5GfR3C8J
 DIaBuMlp7hvWVIfZvbyyMusNAIonV7374w+9OP/54dhkS3SEqCrfkejEB+vg42FVG7
 zu1hLc0mWxSig==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7BFDFC433E1; Sat,  4 Apr 2026 20:09:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] New: ring gfx_0.1.0 timeout, signaled seq=5855035,
 emitted seq=5855037
Date: Sat, 04 Apr 2026 20:09:11 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: witold.baryluk+kernel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221320-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221320

            Bug ID: 221320
           Summary: ring gfx_0.1.0 timeout, signaled seq=3D5855035, emitted
                    seq=3D5855037
           Product: Drivers
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: witold.baryluk+kernel@gmail.com
        Regression: No

kernel 7.0.0-rc5

Possibly related to use of LM Studio, with partial GPU and partial CPU usag=
e.
(Started using LM Studio today, and otherwise this kernel and previous ones
were doing fine, for many days on this rc, and weeeks on other kernels).

Using `LM-Studio-0.4.9-1-x64.AppImage` - it is a likely source of issue (had
few hours session with `google/gemma-4-26b-a4b` model with full context win=
dow
size), as reset happened just after I pressed enter in the prompt window (b=
ut
previous ~50 prompts did not show any issues).

Mesa 26.0.3-1, but appimage and the tooling inside appimage might be using =
some
other version.

firmware-amd-graphics    20260221-1

Using gnome shell wayland as desktop manager. Also Firefox running in a
background. But nothing special was happening during the gpu timeout (i.e. =
no
video playback, but some videos maybe were paused).

Linux debian 7.0.0-rc5 #2 SMP PREEMPT Fri Mar 27 00:34:39 UTC 2026 x86_64
GNU/Linux


6900 XT

0c:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] N=
avi
21 [Radeon RX 6800/6800 XT / 6900 XT] (rev c0)

CPU: AMD Ryzen Threadripper 2950X 16-Core Processor

I also do have zram enabled (80GB, no backing_dev), on top of 256GB of ECC =
RAM.
But probably unrelated.

[673923.157491] amdgpu 0000:0c:00.0: Dumping IP State
[673923.160063] amdgpu 0000:0c:00.0: Dumping IP State Completed
[673923.160138] amdgpu 0000:0c:00.0: [drm] AMDGPU device coredump file has =
been
created
[673923.160142] amdgpu 0000:0c:00.0: [drm] Check your
/sys/class/drm/card0/device/devcoredump/data
[673923.160146] amdgpu 0000:0c:00.0: ring gfx_0.1.0 timeout, signaled
seq=3D5855035, emitted seq=3D5855037
[673923.160150] amdgpu 0000:0c:00.0:  Process gnome-shell pid 9084 thread
gnome-shel:cs0 pid 9106
[673923.160153] amdgpu 0000:0c:00.0: Starting gfx_0.1.0 ring reset
[673923.404103] amdgpu 0000:0c:00.0: Ring gfx_0.1.0 reset failed
[673923.404112] amdgpu 0000:0c:00.0: GPU reset begin!. Source:  1
[673923.704012] amdgpu 0000:0c:00.0: MODE1 reset
[673923.704018] amdgpu 0000:0c:00.0: GPU mode1 reset
[673923.704084] amdgpu 0000:0c:00.0: GPU smu mode1 reset
[673924.205560] amdgpu 0000:0c:00.0: GPU reset succeeded, trying to resume
[673924.205736] amdgpu 0000:0c:00.0: [drm] PCIE GART of 512M enabled (table=
 at
0x0000008000300000).
[673924.205760] amdgpu 0000:0c:00.0: VRAM is lost due to GPU reset!
[673924.205762] amdgpu 0000:0c:00.0: PSP is resuming...
[673924.284210] amdgpu 0000:0c:00.0: reserve 0xa00000 from 0x83fd000000 for=
 PSP
TMR
[673924.421395] amdgpu 0000:0c:00.0: SECUREDISPLAY: optional securedisplay =
ta
ucode is not available
[673924.421403] amdgpu 0000:0c:00.0: SMU is resuming...
[673924.421409] amdgpu 0000:0c:00.0: smu driver if version =3D 0x00000040, =
smu fw
if version =3D 0x00000041, smu fw program =3D 0, version =3D 0x003a5a00 (58=
.90.0)
[673924.421419] amdgpu 0000:0c:00.0: SMU driver if version not matched
[673924.421450] amdgpu 0000:0c:00.0: use vbios provided pptable
[673924.497199] amdgpu 0000:0c:00.0: SMU is resumed successfully!
[673924.497873] amdgpu 0000:0c:00.0: kiq ring mec 2 pipe 1 q 0
[673924.507153] amdgpu 0000:0c:00.0: [drm] DMUB hardware initialized:
version=3D0x02020021
[673924.652432] amdgpu 0000:0c:00.0: ring gfx_0.0.0 uses VM inv eng 0 on hu=
b 0
[673924.652437] amdgpu 0000:0c:00.0: ring gfx_0.1.0 uses VM inv eng 1 on hu=
b 0
[673924.652439] amdgpu 0000:0c:00.0: ring comp_1.0.0 uses VM inv eng 4 on h=
ub 0
[673924.652440] amdgpu 0000:0c:00.0: ring comp_1.1.0 uses VM inv eng 5 on h=
ub 0
[673924.652442] amdgpu 0000:0c:00.0: ring comp_1.2.0 uses VM inv eng 6 on h=
ub 0
[673924.652444] amdgpu 0000:0c:00.0: ring comp_1.3.0 uses VM inv eng 7 on h=
ub 0
[673924.652445] amdgpu 0000:0c:00.0: ring comp_1.0.1 uses VM inv eng 8 on h=
ub 0
[673924.652446] amdgpu 0000:0c:00.0: ring comp_1.1.1 uses VM inv eng 9 on h=
ub 0
[673924.652447] amdgpu 0000:0c:00.0: ring comp_1.2.1 uses VM inv eng 10 on =
hub
0
[673924.652449] amdgpu 0000:0c:00.0: ring comp_1.3.1 uses VM inv eng 11 on =
hub
0
[673924.652450] amdgpu 0000:0c:00.0: ring kiq_0.2.1.0 uses VM inv eng 12 on=
 hub
0
[673924.652451] amdgpu 0000:0c:00.0: ring sdma0 uses VM inv eng 13 on hub 0
[673924.652452] amdgpu 0000:0c:00.0: ring sdma1 uses VM inv eng 14 on hub 0
[673924.652454] amdgpu 0000:0c:00.0: ring sdma2 uses VM inv eng 15 on hub 0
[673924.652455] amdgpu 0000:0c:00.0: ring sdma3 uses VM inv eng 16 on hub 0
[673924.652456] amdgpu 0000:0c:00.0: ring vcn_dec_0 uses VM inv eng 0 on hu=
b 8
[673924.652457] amdgpu 0000:0c:00.0: ring vcn_enc_0.0 uses VM inv eng 1 on =
hub
8
[673924.652458] amdgpu 0000:0c:00.0: ring vcn_enc_0.1 uses VM inv eng 4 on =
hub
8
[673924.652459] amdgpu 0000:0c:00.0: ring vcn_dec_1 uses VM inv eng 5 on hu=
b 8
[673924.652460] amdgpu 0000:0c:00.0: ring vcn_enc_1.0 uses VM inv eng 6 on =
hub
8
[673924.652461] amdgpu 0000:0c:00.0: ring vcn_enc_1.1 uses VM inv eng 7 on =
hub
8
[673924.652462] amdgpu 0000:0c:00.0: ring jpeg_dec uses VM inv eng 8 on hub=
 8
[673924.661748] amdgpu 0000:0c:00.0: GPU reset(1) succeeded!
[673924.661840] amdgpu 0000:0c:00.0: [drm] device wedged, but recovered thr=
ough
reset
[673924.671004] amdgpu 0000:0c:00.0: [drm] *ERROR* Failed to initialize par=
ser
-125!

After the reset, LM studio operates fine after starting it again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
