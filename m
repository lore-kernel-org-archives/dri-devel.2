Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77472EBFD20
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0D7C10E399;
	Mon, 13 Apr 2026 09:06:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VBI6IkSM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F0610E399
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:06:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F0A1444408
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D275CC2BCB4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776071187;
 bh=dlAkdMvL4vAKvpdn+oDVBYBU/sMM+AGKiqKXH2/CeY0=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VBI6IkSMsbTUURdv9fCyGVPLJgyXpPunANd/CmO3hFv48Vl+KICip3hFaCXhZYPYq
 +0FAIBvi0DaZuPSDrnMWZPysf5O2Qydfck/fgGKTUUIMnn3P9fystpO+dqvCfYb593
 CTPPZK/ruVgoyRcWo/VNxilrYDBXhtsfU4dgmz9Gm6XgVXoCzTWHCxgUTy+HRnx5DD
 rHCq7tmwM/jorMd+ZxLIFQknJJZYjBBqGZJrRumsHh3So1D27OKjBO6G7IJ6hHhvng
 RtotuB+LdbOcFORql01QXnBi1zYTspjd9eHrZ40jypfpxhqzhCH7LQbC2L6xVRm6G2
 A5S1uN/CF5OsA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id CB708C41612; Mon, 13 Apr 2026 09:06:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 200517] Vega 8/Radeon 535 hybrid graphics - amdgpu crash on
 modesetting
Date: Mon, 13 Apr 2026 09:06:27 +0000
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
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-200517-2300-8U59vd75bV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200517-2300@https.bugzilla.kernel.org/>
References: <bug-200517-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D200517

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #17 from Artem S. Tashkinov (aros@gmx.com) ---
Reopen here https://gitlab.freedesktop.org/drm/amd/-/issues if this is
reproducible in 7.0/6.18.22 with the latest firmware.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
