Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B44CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2447112297;
	Fri,  9 Oct 2026 20:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B8gA4aSN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB951122A2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1837D43DD9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC709C2BCFC
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 20:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791577727;
 bh=v2TpcX2Hf1V2FDKuw7vDm1uLRrjMcEKJTY0urnFlxbw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=B8gA4aSNsOrXquq12TqJCUUXPj3X6vQ35pjJDiMny5Et4dTOuyldVn7NFEwwrLCF6
 lKj3v61R29Zh3SzxvXaEKQy1WsYgklqJ1zUWHjZ1A+a44/Am8LE1FtPB9cdUpE7z3d
 32vbxr+w3Gs/T4VO1JFkeXrCNk+3Y+x/2nO9sSf1Fs2u9URdyur5wb0W+ICCiPvHRH
 Ri6UQOanrKyS/WO71hh8zjotOpYmglqfcVRu1zFl7tC67pw49fRZ/WJFNUXd1xjkGs
 ydn8RggPsBxcZsfUzAhidMvl8l9En3Piz/ZNKF6GWoQwkjS+v0otVShz7ntKzm786g
 F4B/6Zj0y+CSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DDB48C41612; Fri,  9 Oct 2026 20:28:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222109] [amdgpu Picasso 1002:15d8] gfxhub UTCL2 SQC permission
 fault -> ring gfx timeout when DPM forced high (repro on LTS 6.18 too)
Date: Fri, 09 Oct 2026 20:28:46 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aleksey16.11.2000@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-222109-2300-ydhqBheQue@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222109-2300@https.bugzilla.kernel.org/>
References: <bug-222109-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222109

--- Comment #7 from Alex (aleksey16.11.2000@gmail.com) ---
Additional confirmation from reporter (to use all triage info):

- Reproduces on stock Arch LTS kernel 6.18.55-1 as well, same cold-boot + h=
igh
+ immediate-GUI pattern. So NOT CachyOS/sched_ext specific (CachyOS 7.2.9 h=
as
lavd warnings, LTS does not, both wedge).
- No RADV involvement: faulting CS are kitty (OpenGL) and kwin_wayland (Ope=
nGL
radeonsi raven ACO). RADV installed but idle in this repro.
- devcoredump: kernel printed `[drm] AMDGPU device coredump file has been
created` twice in faulty boot, but it is RAM-only and expired after reboot
(nothing in /sys now). Reporter will set a udev rule to auto-save
`/sys/class/drm/card*/device/devcoredump/data` on next `high` repro if you =
need
it - please tell which artifact you prefer (devcoredump vs umr register dum=
p vs
full dmesg with drm.debug=3D0x1ff).
- Will run memtest86+ to fully exclude shared DDR4 (VRAM is carved from sys=
tem
RAM) and `amdgpu.vm_update_mode` / `cwsr_enable` tests on request. Currently
stable on `auto`, so can A/B on demand.
- 3.9MB full journal of faulty boot retained locally (attached trimmed
kernel-only 109KB due to size); can provide compressed full log or split on
request.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
