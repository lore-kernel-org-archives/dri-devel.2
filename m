Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF4210D14AC
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 13:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324AE10E764;
	Mon, 30 Mar 2026 13:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IEGHZ+aU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B94610E764
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:01:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E658F404C0
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6F2FC4CEF7
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774875687;
 bh=g7B/k1jGGiIMLcwrrkq8TFmeTqGjJi7nZociL6Zn5GM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=IEGHZ+aU8uEe11DYZ7YnsH4mtZxyzbKuFjfa1HqSTWiz9qCAAIs6FxtsqF+O9lFsf
 tRlibYGCIJwM9vcJ6kDeEGkrVPLKVjpp47fMHuB1Iz9JCEtsBuRkSEhh4q/5lj0xL6
 I2uZnLj5VfuyXzmapu/toOTb71AbgNmFKHMZtErKkjuxLDjgSnn4Mr81SaefHTkHG9
 oBxfJIi8ktQbCNqL7Wo84LxQ/d1XoiajOdcaX44hRzZWyHEcWCujscjpe/sNs5gHHs
 tVkJqhxaXoTySXEIp1g/dW5kuDgEOIfhN2KPNHItevTnfWEvOtVpwM/DKKvjBPVEUw
 ImqyUWabcFuhw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BD5E5C41614; Mon, 30 Mar 2026 13:01:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221297] AMDGPU SMU driver interface version mismatch on R9700 -
 fan control broken under load
Date: Mon, 30 Mar 2026 13:01:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regbob.home@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221297-2300-JnW1eW3sMi@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221297-2300@https.bugzilla.kernel.org/>
References: <bug-221297-2300@https.bugzilla.kernel.org/>
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

--- Comment #2 from lobsterman (regbob.home@gmail.com) ---
Reporting results of kernel testing as requested.

Hardware: ASUS Turbo Radeon AI Pro R9700 32GB
vBIOS: 115-G287BP00-100
OS: Ubuntu 24.04
ROCm: 7.2.1
AMDGPU driver: 6.16.13
Current kernel: 6.17.0-19

SMU MISMATCH (persists across all tested configurations):

amdgpu 0000:2d:00.0: amdgpu: smu driver if version =3D 0x0000002e (46)
amdgpu 0000:2d:00.0: amdgpu: smu fw if version =3D 0x00000032 (50)
amdgpu 0000:2d:00.0: amdgpu: smu fw version =3D 0x00684b00 (104.75.0)
amdgpu 0000:2d:00.0: amdgpu: SMU driver if version not matched

KERNEL TESTING RESULTS:

Kernel 6.17.0-19:
- SMU mismatch confirmed present
- Fan does not spin under any load
- GPU reached 109C and thermally throttled during AI training with fan
physically stationary

Kernel 6.18.20 mainline:
- AMDGPU 6.16.13 DKMS fails to build against this kernel
- NVIDIA 535 DKMS fails to build against this kernel=20=20
- Kernel panics on boot: VFS: Unable to mount root fs on unknown-block(0,0)
- NVMe storage drivers absent from mainline build
- Testing blocked =E2=80=94 system unbootable

Kernel 6.19.10 mainline:
- Same DKMS build failures as 6.18.20
- Kernel panic on boot
- Testing blocked =E2=80=94 system unbootable

CONCLUSION:
Mainline kernel testing on 6.18.20 and 6.19.10 is not feasible on this hard=
ware
due to VFS/NVMe boot failures in the minimal mainline builds. The SMU inter=
face
version mismatch (driver if version 46 vs firmware if version 50) persists =
on
kernel 6.17 with AMDGPU 6.16.13 under ROCm 7.2.1.

A fix in the AMDGPU driver to support SMU interface version 50 is required.
Mainline kernel testing cannot be used to validate this fix on this system.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
