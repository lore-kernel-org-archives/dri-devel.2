Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A4FC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D2910EF23;
	Thu, 20 Aug 2026 07:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qxjNdX2R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C55BA10EF23
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:14:34 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 88BB043E98
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A891C2BCC7
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787210074;
 bh=NPdo1K1bZvXW5s8A56yptX47+3cKWC5IJGe76xkG9Ao=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qxjNdX2RkZpje4TOLfxLaqrz/WVk0AFXay+RtSkRhkmWpnU30LMimE3J07BgWpAaK
 JWVKv/od9kQ+X7uZIys4akMnp6VZvQD0KhS3ZVZoO4HtiMGU1ZwHzxzYqZe6Swr/T4
 2eYHs1k3/qz8CjTP/DwTWcJafrRH2WzRkH4AZd4DYh7oerPMoAnYnF+3TsarS2b117
 NLaCUXMKPRQgp2Fkz+6LyqAmZi0D/Vf4sDX2NZpWZrxd4RvzswLbf0d1D5Uxy8+/pm
 +8Y7Y+NoiUn/yy+XkzU+soi53gWHmrmGJgtymZyXtAvXfTkQcetPBLHpYYghm+uun5
 bU3IlrvSjX/pA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 4F59DC433E1; Thu, 20 Aug 2026 07:14:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221897] [Regression] Half screen renders black with active
 cursor after upgrading to linux-firmware 20240318.git3b128b60-0ubuntu2.29
Date: Thu, 20 Aug 2026 07:14:34 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DISTRO_KERNEL
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit bug_status resolution
Message-ID: <bug-221897-2300-ZR32hdojj8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221897-2300@https.bugzilla.kernel.org/>
References: <bug-221897-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221897

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|20240318.git3b128b60-0ubunt |
                   |u2.27 ->                    |
                   |20240318.git3b128b60-0ubunt |
                   |u2.29                       |
             Status|NEW                         |RESOLVED
         Resolution|---                         |DISTRO_KERNEL

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
1. Unsupported kernel.
2. Unknown HW configuration.

If you can reproduce this under 7.1.9 or 7.2, with the latest firmware, ple=
ase
reopen.

No, you didn't bisect. Removing the tag.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
