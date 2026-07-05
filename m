Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10AFC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 10:04:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AFAB10E188;
	Sun,  5 Jul 2026 10:04:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ATeJOGbT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1787110E188
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 10:04:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0418407E5
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 10:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90F24C2BCB8
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783245890;
 bh=+3qCXLMtEDYIm4qGQHrQlATilWXuWYppqLSLBGb83tE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=ATeJOGbTbtjZ4PeD0HSmEmCeLE7EU0uJrF+xGhrkCreL+eYmJxUkhWdyx99FZ+iFo
 qp5wrKbvJ0531JDTumR+YNbz4zW1cpHcTccbX7F/7iGkyxAmvTxgW0rtbAOwr3obPD
 6D/p2sdlVNHl16ToME3Hz4q8TzIkeIDnSpGlvBebTrWbLgDFtoEkkC2PQGW1l5xWCr
 /ONKoTm9Wfpbn6PDJ+t+MI/DxWHLCcbxb0Gdta/s1UnNEHSAe21DwhIqjy4MzYY0hM
 sl/QjWm4HfXwQ8zRPOv778nrB8u3I2qPImceS6eV7yTgpidEKKZAwSxH9jlkXnpyEU
 HA7E/AimbuAXQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 81FB7C41614; Sun,  5 Jul 2026 10:04:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221719] kernel crash after resuming from hibernate -
 amdgpu_vm_move_to_lru_tail+0x29/0x40 - 100% reproducible
Date: Sun, 05 Jul 2026 10:04:50 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221719-2300-eOBpMDYxOJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221719-2300@https.bugzilla.kernel.org/>
References: <bug-221719-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221719

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please report here: https://gitlab.freedesktop.org/drm/amd/-/issues

If it's a regression, bisection is extremely advised:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
