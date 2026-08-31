Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBFEC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E984110E255;
	Mon, 31 Aug 2026 07:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XZmdg7Do";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585A810E255
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:41:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EA420416CC
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC876C2BCF5
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 07:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788162113;
 bh=9IIbLstgB/znW5X56jz4Ej4mBcI3Pg4ImYfRNDbCYV4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=XZmdg7DoMmNjTSSXaUmGgDf8ZJ3wdNn/M7BZFvpZCA6K2wbZTDV1xu8fg3y3oiZkS
 4fyAUnLCvUK0WcM2VLo8Ze85cyM9o4eXtZ8W6JxaKEoLz9V4yEF0WGZih1BajjDl1b
 G2tEmFi54syPEoUenBALZQVbPJZ7m5fFpCGRxIhzkPEzAubzGkzsnArtsrdGYoBP8T
 SAR4j2Q3OX0GjymNWuFsKg2bVc5pl2ZU54bvWxBbZktND5ipyxEw4OvFQio5R6HCXz
 ppJIwxFdD494kE8ZSX24bUbkxYk81Yc5k5oFGlAaPUWQ8C0GXGHXypIldubCKI2g6W
 dOnBpJ25IpksA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AEB55C433E1; Mon, 31 Aug 2026 07:41:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221929] amdgpu flip_done timed out stills at ASUS ROG Strix G17
 2022 laptop(G713RM)
Date: Mon, 31 Aug 2026 07:41:53 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: twyoda@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution
Message-ID: <bug-221929-2300-up4YfpLJ9m@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221929-2300@https.bugzilla.kernel.org/>
References: <bug-221929-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221929

Yoda Wu (twyoda@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|ANSWERED                    |CODE_FIX

--- Comment #5 from Yoda Wu (twyoda@gmail.com) ---
Got it, thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
