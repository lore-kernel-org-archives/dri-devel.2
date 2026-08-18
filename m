Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FC2C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A03A110E4F1;
	Tue, 18 Aug 2026 16:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="THAxlsOz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D90710E4F1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:10:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C959B432F4
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABBCEC4AF0B
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787069403;
 bh=uCuKjRIWh88+3YXkMDTtluDqRi42YPHpmasWKl1McSo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=THAxlsOzbq3zMit4CUeF5JUlUf5wKK/G7X0UkFuGooKDWao9kCkWvcGUC9UXkhE1p
 JzcHvLKa+DwMIWYBVskfD7x4t5XYJnlvvwLkttofkT3xIADdXlU0MS8UgrfTQ+OMh0
 /hRd2QYRbUxCkZ/QQiJ75yDNNZQyaG3gT5hj/10iyc5YgkDNFZfNEihah8AXAt3kMC
 TdLIOIv9pDNXM4QQu5wdiC8vh6O0EiWI6cHvnESbuEqur6HcZa+WngdwMChp4Tjusu
 9uqMZfFF2BVVHodo5JDQvobqxOQxQijBgI9B+SWwE7gUUGoNbQg/VNT6Lk07QELtGx
 OW/VXTtSa/RrA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 90283C433E1; Tue, 18 Aug 2026 16:10:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 18 Aug 2026 16:10:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221827-2300-31surrUTJH@https.bugzilla.kernel.org/>
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

--- Comment #6 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
latest 7.1.y is still affected, as the revert is only in the current 7.1.y-=
rc
release.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
