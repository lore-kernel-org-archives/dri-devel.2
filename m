Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D48E64002
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 08:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B455110E19A;
	Sun,  5 Apr 2026 08:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4catJD8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8377810E19A
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 08:37:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D71C41942
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 08:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3903C2BCB0
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 08:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775378226;
 bh=OMQT6l/yBYkeWsKNEDPOylTuchVnJeyMtNB9HNNXAoM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=L4catJD81UsHVAlwKLlbsDF2l4jY6jQuEc8KZ3xXq80ezoAyqFgYbnihOWnmvsFEi
 1QReCePeXa/0vjjSZRPicJnxSZJ+xGZwksITTQZh7TZVie6hAaxaS14SGEAjFZavYn
 vXmEAvfICMfV28xeA7YFvuMF8TCY3bjllI9t56Pf0sgIfjM8/T4lrewiLVZSFsXDMJ
 eW09Q4SnrQqteAeBZQegsevTele5DtT219m1M/TXAOOPbkinx5CeyzEkkglf2tdm5d
 IEW9zFWAerb0wuw/A4T7ifNAE9kRzUczqyG2XT+2LyWeEztR4V+Q9HMUc+VWgzBElf
 tmaOvEMC8wHBw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C67EBC41614; Sun,  5 Apr 2026 08:37:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221320] ring gfx_0.1.0 timeout, signaled seq=5855035, emitted
 seq=5855037
Date: Sun, 05 Apr 2026 08:37:06 +0000
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
X-Bugzilla-Resolution: MOVED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221320-2300-K1aROUm6mY@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |MOVED

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
