Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA54DF428CD
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 20:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B9C10E740;
	Wed, 15 Apr 2026 20:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FaiobBc+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790EC10E740
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:02:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 86B2460120
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DDDEC19424
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776283353;
 bh=VR1zj63HNWFRKPAK52aMPiWbCjSIdrZ3AscaUP93bl8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=FaiobBc+9rbMYQyUiOAKsuDEQ+qxXEBnSB/PIoCUQvIhUzRfww0KPN1VvJRFVBr4F
 OECzSdXOaMIudqRD/kmS1Xo+TQEZ2xka++9dsyUabpCsWR78BpLwQs9qBRMoC7vbaM
 Zxa6oCetV5OqPdLqEYS/XSih0Di26f7BO1tcc5PGY6cuT+ssj47ediimI35+SuOcKx
 hvB76HTFYV3p1J9fPi4z5HJs5c+Viu/+9CuQDcrKnS8OCotZOp21CPVRGTJgQvKeXU
 lQhObqYU9BqAlw0CZ1397rfcUFerDTjdM3pskbia1cQS6vsi+/GBSsLanzi3v5LGWn
 VPod5TFAcRkPQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 38D09C41614; Wed, 15 Apr 2026 20:02:33 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221369] AMDGPU VM_L2_PROTECTION_FAULT causes GPU hang and full
 system freeze (Firefox/WebRender)
Date: Wed, 15 Apr 2026 20:02:33 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221369-2300-RqoPdrf9G8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221369-2300@https.bugzilla.kernel.org/>
References: <bug-221369-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221369

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DISTRO_KERNEL

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Report here if that's reproducible under 7.0 or 6.18.22.

Your kernel is not supported.

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
