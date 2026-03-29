Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F94AF3D605
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 16:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7AF810E55F;
	Sun, 29 Mar 2026 16:18:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pKkK9rYM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA4C110E55F
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:18:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A81E41AED
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BEB1C2BC9E
 for <dri-devel@lists.freedesktop.org>; Sun, 29 Mar 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774801120;
 bh=ff2MMpI1VVbMZKCXtpxd3SxstFZWUAmPhiPxzGv5XGM=;
 h=From:To:Subject:Date:From;
 b=pKkK9rYMNsrQMvQxOV9f8ufFZjQExolhc7/tJ2alToEFQ1mzuwcBY+Gd2e0fA4Ffh
 idu8LgCgW6x2A1h2ZE2yWF1tMMMlvF5j33EPXwYzKXujtFv22uVlRZctQ9kMQSFZfC
 1JDISvguioteaTlGTGJWz+FAICi0qtYcAVU/Zox+35vqirpUJSF1PQ919d81p620zd
 Hg8BejKOWZduoM/hMtJArhV5uIQm5az8BWRSjWinuQJkDAkqShaCG9tGUGfl0syIwK
 Wils5R8OtevbRhxxd/SRCO1YmN3EZhkpnboVPkJKt0dyt7FvMPbMuw+OWzpNpHuYRZ
 x7K8CAiFxxSfw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F2DDFC3279F; Sun, 29 Mar 2026 16:18:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221297] New: AMDGPU SMU driver interface version mismatch on
 R9700 - fan control broken under load
Date: Sun, 29 Mar 2026 16:18:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regbob.home@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221297-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221297

            Bug ID: 221297
           Summary: AMDGPU SMU driver interface version mismatch on R9700
                    - fan control broken under load
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: regbob.home@gmail.com
        Regression: No

Hardware: ASUS Turbo Radeon AI Pro R9700 32GB
vBIOS: 115-G287BP00-100
OS: Ubuntu 24.04
Kernel: 6.17.0-19
ROCm: 7.2.1
AMDGPU driver: 6.16.13

BUG:
The GPU fan does not spin up automatically under thermal load. During AI
training the GPU reached 109=C2=B0C and thermally throttled with the fan ph=
ysically
stationary throughout.

ROOT CAUSE - SMU interface version mismatch (from dmesg):

amdgpu 0000:2d:00.0: amdgpu: smu driver if version =3D 0x0000002e (46)
amdgpu 0000:2d:00.0: amdgpu: smu fw if version =3D 0x00000032 (50)
amdgpu 0000:2d:00.0: amdgpu: smu fw version =3D 0x00684b00 (104.75.0)
amdgpu 0000:2d:00.0: amdgpu: SMU driver if version not matched

The card firmware is 4 interface versions ahead of what the AMDGPU driver
supports. As a result all fan control registers are inaccessible:
- rocm-smi --setfan returns 'Not supported on this system'
- sysfs pwm1 node is READ-ONLY (-r--r--r--)
- fan1_enable returns 'Invalid argument' when read
- GPU enters runtime power suspend under load, further suppressing fan resp=
onse

Confirmed on AMDGPU 6.16.6 and 6.16.13 under ROCm 7.2.1.

FIX REQUIRED:
The amdgpu kernel driver needs to be updated to support SMU interface versi=
on
50 (0x00000032) as shipped on the R9700 (gfx1201, RDNA 4).

Related ROCm issue: https://github.com/ROCm/ROCm/issues/5908

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
