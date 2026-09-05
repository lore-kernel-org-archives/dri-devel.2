Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6449C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C7FE10E214;
	Sat,  5 Sep 2026 09:25:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nXl1ThKt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FC210E214
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 09:25:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 18B39600E2
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 09:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A59C1C2BCB3
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788600299;
 bh=NkzUSXO8VawoP3DvkF3eeiRP9EoRLpJYGCjK0zLP4Yc=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=nXl1ThKtYRnrF+yM7yT9eZY7kbB1xZH7xTK31jPi4iq8wnGtH2MiyYU8LbUfnzzLl
 3KTtMPEg/IbbYs6qGhAy9Ol9TGwblrJJ8rTq9lLRcNNxMZn8Lbc9DrZ9VWSDuUO7RA
 4jmfAzhu5hBQyquGpbJkzZHt3RTEz7JtfnT+JcBPBOzDwTWVWDtDaJGJgcc/Mx4qo+
 P9cUrSObrWLR3PjOBGDlL+cbcnn4iDrnmBGOCuV+VSIlymYiwVdKPPD4k7IjdUzAiI
 1vc9aE3P2kKuz0Mqnp3TuV6YE6zFAN6Jr+nKqG/OsMU76pkmmnoBMZHGIQCrNcv5Oz
 d6+7TjAogOIRA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 89BB1C3279F; Sat,  5 Sep 2026 09:24:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221959] ttm_lru_bulk_move_tail cause CPU stuck
Date: Sat, 05 Sep 2026 09:24:59 +0000
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
Message-ID: <bug-221959-2300-qc86LqunS9@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221959-2300@https.bugzilla.kernel.org/>
References: <bug-221959-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221959

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
If this is reproducible without the NVIDIA kernel module?

> Tainted: [O]=3DOOT_MODULE

If it is, refile here:

https://gitlab.freedesktop.org/drm/amd/-/issues

There are quite a lot of related reports:
https://gitlab.freedesktop.org/drm/amd/-/work_items?sort=3Dcreated_date&sta=
te=3Dall&search=3Damdgpu_vm_move_to_lru_tail&first_page_size=3D20

Maybe yours is the same/similar - check 'em first please.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
