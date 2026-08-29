Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AFAC61DD6
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B3510E092;
	Sat, 29 Aug 2026 06:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GASuo+0b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB9E10E092
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:11:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AC79A43783
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E74FC2BCF7
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787983887;
 bh=CflGm107JU7yOMzaJ2kmhugdwlj1yCwaFjOm1qbNios=;
 h=From:To:Subject:Date:From;
 b=GASuo+0biLb4p80TE/awBIO0/Trxa5od3Hu5zEjr2lqtwLOQE1mwvxP4ltIAmjJaL
 y8TVccAZ3pirI4g9euaXU5Y+hN4diPwjGO68gFKx+HR8kJ1CRKJZ4mdMPT2zSt7xXy
 UwdVet7VeaS+FZLPKxs5enj0E7S9qV4r/G/rWn6X+XK4qAno45LG5ddO5gMzTTt/Gr
 uCavsiA69u4/+grm1cz/SXjlHObxSYEF5tpy7mRcRbghndt6Fa2QM6iIk4aLbGdgfk
 CtkWB2zn3tAJFWmSedhDWANZo7l3a717pHUQVjk1Mhxq5ZEwR6nhoJBLgrLlsM1zGa
 5mkhpZptpxVGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6EFE5C41613; Sat, 29 Aug 2026 06:11:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221933] New: Screen brightness dimmer since kernel 7.2 (amdgpu)
Date: Sat, 29 Aug 2026 06:11:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 3lefji@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221933-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221933

            Bug ID: 221933
           Summary: Screen brightness dimmer since kernel 7.2 (amdgpu)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Video(DRI - non Intel)
          Assignee: drivers_video-dri@kernel-bugs.osdl.org
          Reporter: 3lefji@gmail.com
        Regression: No

Hi everyone,

Follow-up on a brightness issue I've been having since the kernel 7.2 update
(still present in 7.2.2). Sharing what I found in case it helps others or
points to the root cause.

System info:
- Laptop: Lenovo IdeaPad Gaming 3
- CPU: AMD Ryzen 5 5500H (iGPU handles the internal display backlight)
- GPU: Nvidia RTX 2050 (hybrid AMD/Nvidia, PRIME render offload setup)
- OS: Fedora 44, GNOME 50, Wayland
- Kernel: 7.2.2-cachyos
- Backlight device: amdgpu_bl1

Issue: since kernel 7.2, the same brightness percentage looks much dimmer t=
han
before. I used to sit around 30% in dim rooms, now I need about 60% for the
same visual result. Raw values:
```
cat /sys/class/backlight/amdgpu_bl1/brightness -> 45755
cat /sys/class/backlight/amdgpu_bl1/max_brightness -> 65535
```
So roughly 70% reported but visually much closer to what used to be ~30-35%.
Looks like a mapping/curve change in the amdgpu backlight handling, similar=
 to
reports I found for other kernel versions affecting amdgpu_bl on AMD laptops
(both integrated and hybrid setups).

I tried the common workaround of adding amdgpu.backlight=3Dvendor to
GRUB_CMDLINE_LINUX. Brightness mapping did go back to normal after that cha=
nge,
BUT it caused severe system instability right after the password screen:
extreme lag, barely able to move the mouse, a strange fade/scanline artifac=
t on
the lock screen, GPU idle at 32=C2=B0C while CPU sat at 13% doing nothing. =
Had to
revert the kernel parameter to get a usable system again.

So amdgpu.backlight=3Dvendor is not a safe workaround at least on this hybr=
id
AMD/Nvidia + Wayland + GNOME 50 combination.

Has anyone found a fix that doesn't cause this kind of freeze, or is this a
case where we just need to wait for an upstream amdgpu fix? Happy to test
patches or provide more logs if useful.

Thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
