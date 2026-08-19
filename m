Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE3FC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231B010E0F4;
	Wed, 19 Aug 2026 11:26:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ow+YF9zX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B2910E0F4
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:26:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D57060A59
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 533EEC2BCB3
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787138790;
 bh=FNQ86FC/3dApba/vQHQrXcFobNOgZ12XMacXkz+IZHI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Ow+YF9zXFX5zwpv1k993Wu/H3+9/2OKj0aIadvKn7UXyvAj3rhV27uKhlTiDbnjPD
 jdSMjZwsaTOV9+lteNU0DB0mvqy2nvXATam4pT3EMlvKRIQiwxLjx6+8ATGKjJ00vu
 /QDb2tU+M+ZXK62tGFmpbJ0p13ldZ60rIKUhznI+ygmIoSo3zLw2U+acr2h0ZXPD5R
 4W+kLafyyULr3CWsx3G5cqATeScjL20Jv6eiD3flDDZcFsq1+wtFamyhodehZ7SM57
 +3+pl+XanXSDgtiVaws29ZPAlqnro3t4eWJMl4vMg4E9Km7oJ9+mxDYrXC30eoHe8A
 EZlY2HZUWm7Ug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 3ACEDC4160E; Wed, 19 Aug 2026 11:26:30 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 219492] amdgpu: failed to write reg 28b4 wait reg 28c6 and
 amdgpu: failed to write reg 1a6f4 wait reg 1a706
Date: Wed, 19 Aug 2026 11:26:29 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pisarevden+bugzilla@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-219492-2300-1wRrnkUF3G@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219492-2300@https.bugzilla.kernel.org/>
References: <bug-219492-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219492

Denis Pisarev (pisarevden+bugzilla@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pisarevden+bugzilla@gmail.c
                   |                            |om

--- Comment #5 from Denis Pisarev (pisarevden+bugzilla@gmail.com) ---
"failed to write reg 28b4 wait reg 28c6" persists for hours after every S4
(hibernate) resume, Cezanne, kernel 7.1.8

Adding another reproduction on a different setup (desktop use, no ROCm),
with two observations that go beyond the original report:

1. The failures are NOT limited to early resume. They continue
   indefinitely (80-140 per hour for 9+ hours) until reboot.
2. On this machine there are no "TLB flush failed for PASID" lines at
   all - only the two reg write/wait pairs.

HARDWARE / ENVIRONMENT
----------------------
CPU:     AMD Ryzen 7 PRO 5850U
GPU:     AMD Cezanne iGPU [1002:1638] (rev d1), amdgpu, DMUB 0x0101002B
Kernel:  7.1.8-1-MANJARO
Desktop: KDE Plasma / KWin Wayland, no ROCm or compute workloads
Trigger: resume from hibernation (S4), 100% reproducible over multiple
         cycles across two days; does not occur on a fresh boot

LOG EXCERPT (resume at Aug 19 10:52:39)
---------------------------------------
Aug 19 10:52:39 horsehead kernel: Freezing remaining freezable tasks comple=
ted
(elapsed 0.001 seconds)
Aug 19 10:52:39 horsehead kernel: amdgpu 0000:07:00.0: failed to write reg =
28b4
wait reg 28c6
Aug 19 10:52:39 horsehead kernel: amdgpu 0000:07:00.0: failed to write reg
1a6f4 wait reg 1a706
Aug 19 10:52:39 horsehead kernel: amdgpu 0000:07:00.0: failed to write reg =
28b4
wait reg 28c6
Aug 19 10:52:39 horsehead kernel: amdgpu 0000:07:00.0: failed to write reg
1a6f4 wait reg 1a706
Aug 19 10:52:39 horsehead systemd-sleep[1062034]: System returned from sleep
operation 'hibernate'.

The first failures appear in the same second as the thaw, interleaved
with the hibernation-exit messages. On an earlier cycle the resume also
produced:

Aug 18 10:04:42 horsehead kernel: amdgpu 0000:07:00.0: MODE2 reset
Aug 18 10:04:42 horsehead kernel: usb usb5: root hub lost power or was reset
(... usb6, usb7, usb1 ...)

ONGOING RATE AFTER RESUME (Aug 19, single cycle)
------------------------------------------------
hour 10 (resume 10:52): 138 errors
hour 11:               140 errors
hour 12:                78 errors (still ongoing at time of writing)
Previous cycle (Aug 18, resumed 10:04): 1414 errors over the day,
still occurring 9+ hours later. No "TLB flush failed for PASID"
messages appear on this machine, only the 28b4/28c6 and 1a6f4/1a706
pairs, always together.

USER-VISIBLE IMPACT
-------------------
The retry path makes the whole desktop sluggish (stalls in the
compositor and apps). CPU and memory are idle; the disk is not involved
(NVMe <2% busy, fsync latency normal), yet PSI "some" io pressure reads
~80% because tasks spend their time sleeping in the retry loop.

WORKAROUND
----------
Reboot clears it until the next S4 resume. Using suspend-to-RAM avoids
triggering it (S4 is the only trigger observed).

NOTE
---------------
the resume_gpu_stable proposal from January
(https://lore.kernel.org/amd-gfx/20260106125929.25214-6-sunlightlinux@gmail=
.com/)
was rejected because it disabled the KIQ path permanently, but the
persistent-hours-long failure pattern seen here suggests KIQ does not
recover on its own after S4 resume on gmc_v9 + Cezanne - at least not
under a plain Wayland desktop workload.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
