Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E25C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2F710F320;
	Thu, 13 Aug 2026 13:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qTQeSfuB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C59A10F320
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A4B31600AD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57968C2BCF5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786626350;
 bh=x0EE9e/K2QmSc7oXKdSHhGGMZ+Y9KlPg9weD1LLTB7E=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qTQeSfuBTBmgbyuEVXDle1GCk7kGfQprXez4t9P/pBQOBYclB4200xqQi/uu19ySZ
 Slm71XgN+KVcyXLUGI6NHPr7Kn0x1oxOF2pJtAXy8CKow6dXi8T1jVfrqm2lxe0VRW
 HtzUJibjLbp0thwzKWyUHacGUX1v8KkkbiZwri/BMJsoQ4fiOfrOpsu1KOL/JK4PcY
 rlszcmsUvzY+dR+tu/z/wCDObgCncTNmFlbDvpvO18fVJvV9oLr1Rr9WDnUUaQHHrJ
 sjKnfIcShG6qFR2xJD4jOgY8bgwZLKNZ4YTHj2MOgMx8qq5DSfNv2FO2MfVVrQFr/W
 PFxsNQGKjHqIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 45FC7C41614; Thu, 13 Aug 2026 13:05:50 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221879] Max brightness broken since 6.18.42 / 7.1.6
Date: Thu, 13 Aug 2026 13:05:50 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: augustin@trancart.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_bisect_commit cf_kernel_version cf_regression
Message-ID: <bug-221879-2300-nwiJNN3uqG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221879-2300@https.bugzilla.kernel.org/>
References: <bug-221879-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221879

Augustin Trancart (augustin@trancart.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
 Bisected commit-id|                            |1191285ecb4233e5bf907da7e93
                   |                            |94d7999055566
     Kernel Version|                            |6.18.43, 7.1.6
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
