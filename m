Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BEAC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1757710EBDB;
	Tue, 18 Aug 2026 15:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O60rnvh9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CF5810EBDB
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:53:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 359FB601DE
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD998C19425
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 15:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787068393;
 bh=i9Nyf4II5sASJj388u1jdwoGrYwo23KjNzhp6t03C/E=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=O60rnvh9vijYCvmhlmB0tI1IxlbswEODJxEoektHkFwml1zCANIHZqN9T5vEH6+Ig
 uqv6kk3vj1GG004+VkjrX+xS13VBDCJskmzGqUqDlR/YsxjrTGr+lSbMNM7M8ywnIH
 +LpBrdbIAT9fJqvG3R7ANVAEwnDfTlAqBloWy1IlvTFbAZUXchrTgZcM8LHpi1WrDt
 kyoLP3HZBQN/qLIsoYszgx7IJa65C0OXoqsuhXrCyXzTJMHPzZazvN9PP602LYziQT
 HXbWAT5d7KVLzD+Z90MS8+SC5vTX7APnLZMUxVTh8LBWl1CridUFR1iSjICP4FhdPV
 SDrLUoyWQf6sA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id BD4A5C53BBF; Tue, 18 Aug 2026 15:53:13 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221827] Backlight regression with 7.1.6
Date: Tue, 18 Aug 2026 15:53:13 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: abdullahz.universe@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221827-2300-51DLPaTIZT@https.bugzilla.kernel.org/>
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

Muhammad Abdullah (abdullahz.universe@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |abdullahz.universe@gmail.co
                   |                            |m

--- Comment #4 from Muhammad Abdullah (abdullahz.universe@gmail.com) ---
The issue is marked resolved but I still have the EXACT issue on Fedora 44 =
with
linux kernal 7.1.8

Max brightness at 98%
Lowest at 99%
Very low but not the lowest on 0%


I have a Strix G15 AMD Advantage edition

Ryzen 9 5980HX
RX 6800m

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
