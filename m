Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379A2C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 08:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861A010E47A;
	Mon,  7 Sep 2026 08:08:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pcxOOOoU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2112F10E47A
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:08:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C489A440BA
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA21EC2BCF4
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788768526;
 bh=EHoHPZKrEOryNHIVFY0we9zTAJFb3Ig9zO92zA2EN+o=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=pcxOOOoU7t/WJNewOScDpvjP8etWR7Zn05YOEiIex//y0SB3MicJt3Xrf87nxil6z
 xcGkM/z3Id9Wj49JfDxjLIp7vrmxEGDtr48EO2E1bH5GPcouVP4AzxWZe1smbmAux6
 BvPaqBTuNZ9LeycOOZUsU6ffXQWdsBXYctzG42FRnBRMkAPlSOqI1gQ2ZJZIpzksgL
 ypUObGQjuPEL4B1cLes6jOKOwXHRuMhs0gjARCPr4dcUqVJ4NzcybEUZkKhNZpfJkO
 9/8B4c3zp76g13tCNRj5OrRnJY+EbGDBh+JK4UH2arkcP9MShvXOgO8YRv8JfR848H
 Qy5/RIcAraceA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 8CF0AC433E1; Mon,  7 Sep 2026 08:08:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221959] ttm_lru_bulk_move_tail cause CPU stuck
Date: Mon, 07 Sep 2026 08:08:46 +0000
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
Message-ID: <bug-221959-2300-9qfvX1FtnK@https.bugzilla.kernel.org/>
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

Yoda Wu (twyoda@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|ANSWERED                    |CODE_FIX

--- Comment #2 from Yoda Wu (twyoda@gmail.com) ---
Got it, thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
