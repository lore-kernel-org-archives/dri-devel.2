Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BEEC5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80CD010EBDF;
	Tue, 18 Aug 2026 15:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQFzjF3b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0149310EBE4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:54:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8050D43D7B
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66768C2BCFC
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787068439;
 bh=M1AN7qqNSjkyeTLTJMmsw47nJCeRnPuvx9ejux0gu5M=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=JQFzjF3bCjKcivEFrzfwJnAd2HUic8rmwC4d3N8F/Ulv8eSJ8pLEbhhe+M6lZTF9A
 1YjG+KCAxc5K70EBaiYXNoH75GOxJx79nIgzk5zWIjihDvWhFKOjJJav6E5jmDylx9
 Le2J0qxaNvQInga4tF4ZzscfvloN1O50CVK3z36eQJr/7zAcdZiURTJYdQYZFzPHRF
 qtR703jWO6g7rqb8gPHzp0sv3Ey3b/4uBuuJ7KK+pNSY1ypM3RgeyqZc3qIJcgVhIo
 sFb6KS5T25txK/UB9T1ThT56feNuxwQPSlQyeMMpKGArPwsNkWZjLzNLEEcU96mFf3
 7wGzH09zilqPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 55338C53BC5; Tue, 18 Aug 2026 15:53:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 18 Aug 2026 15:53:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221827-2300-Jo68V2ojSY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221827-2300@https.bugzilla.kernel.org/>
References: <bug-221827-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221827

--- Comment #5 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
There was a revert in 7.1.y.  Can you make sure you got it?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
