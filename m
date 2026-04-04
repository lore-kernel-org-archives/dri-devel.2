Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49039E63FE6
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 23:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E0510E150;
	Sat,  4 Apr 2026 23:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u8i8mzUZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF21A10E14F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 23:37:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BCBC860054
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 23:37:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2999DC19421
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 23:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775345866;
 bh=Nq+abx1XPZCUhBQB23kxcZSzB3dCRDx1RTMIbLkhm8w=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=u8i8mzUZXLwFvlg3rX184MjxWHY3KGgpTD2CWxQKohrKrmz+yc5jfrdmqFTLYYjbg
 +pS2iTDjWjr9WEcD17qNLuZC+m2V5xceZG10gMnquZJ5u7ohqNWCXBbw1zW6w9fcYf
 7SMzepQ+ANjiI4f4lfaMme2jGQgz1lCw7ZQKbcHmNEf0i1bMa9IX7Mm8yq49gKXc5w
 3Ua7eOqLkq86E7I5t92QJoGar1rXdCRfPQp/YlUYhqpXGOSTRgz6pDkZ4QoyRjV8UU
 +tH2EJNVgto4SXm62AqPXgECEJoc3G1sd98iLU2OLeXo0N7cQDl6wA7XMO/N5pClsO
 X7d2VCZ6rEuUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 1FE2BC3279F; Sat,  4 Apr 2026 23:37:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] ring gfx_0.1.0 timeout, signaled seq=5855035, emitted
 seq=5855037
Date: Sat, 04 Apr 2026 23:37:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: witold.baryluk+kernel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221320-2300-gWOOeODEC7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221320-2300@https.bugzilla.kernel.org/>
References: <bug-221320-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221320

--- Comment #3 from Witold Baryluk (witold.baryluk+kernel@gmail.com) ---
Looks to be a likely regression.

6.19.10+deb14-amd64 - works fine, and stable  (firmware-amd-graphics 202603=
09-1
- newer)
7.0.0-rc5 - timeout (firmware-amd-graphics 20260221-1 - older)
7.0.0-rc6 - timeout (firmware-amd-graphics 20260309-1 - newer)


The 7.0 rc5/rc6 were compiled with different options, compared to stock deb=
ian
kernel 6.19.10, so that might be issue too.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
