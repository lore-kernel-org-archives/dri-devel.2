Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA0ACD98D6
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 08:24:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F77610E04B;
	Sun, 14 Jun 2026 08:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i98yjZ9I";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2060010E04B
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 08:24:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4D26F601DD
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 08:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 033DAC2BCC7
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 08:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781425475;
 bh=3Te565K0gUy9KVFTA4F+Y98WUnS+0aqu2sBRRCLvIFE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=i98yjZ9IEMWlxRl7r846HD6Euwd988VE0lma3oj7ej8pBlJbQZNYhop/3JOGKE/Fr
 vp7cT3sWjETzELKTKdMfNY58lk4hruI8JElKP5MniL3Kn2zDot/vJzm2Zevg40CGe2
 HQ6oZ27mbuzBzykXgztRuTFmMoELf8gDYBxBToUhVQjnRw6BTiClFFmwBEfH/kX3po
 EDHjONqT+wKJcvbYqOhXp03XGffqOirg1yFq3KJ/CrlctNKYh56Y+29gjnQSB8rDSj
 ooQu0dmj50AXzNbd8eVLhAzbIflINsaiVnHGkJ8LeqvjwSSiVBkWP7hoENcKDeIraC
 Sz+aTQ3z8byoA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id EBD4AC53BBF; Sun, 14 Jun 2026 08:24:34 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221649] amdgpu regression on RX 5700 (Navi10): 6.17.9 works,
 6.18.x causes GPU hangs
Date: Sun, 14 Jun 2026 08:24:34 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221649-2300-BApoKS7GcZ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221649-2300@https.bugzilla.kernel.org/>
References: <bug-221649-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221649

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Please refile here:

https://gitlab.freedesktop.org/drm/amd/-/issues

Would be great if you bisected first:

https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
