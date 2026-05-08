Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAFACD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DE110F38E;
	Fri,  8 May 2026 07:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5a4O8sX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A97510F38E
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:23:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 10926406CF
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E515AC2BCB0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778224986;
 bh=Zk/64QSTk5+hEewphrXa+545x2D2r4lVCSeCfJDMdYs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=P5a4O8sXqx5WIz6mA0bgb3XWz06vkALg3k2LIUD+iAQlM3Yg+k31zswihsKJfZgSw
 KYGc/Yl74AjuJM/kPbiii/lbBsn3VvBprgHh1Lqa5ByDFIj4QzzrJD8Mo5dJemcqs8
 pTHOwPrCu6S/GoPo0oM6B2HuVOVNRDBU8ryztmYNPdRsCOLORhQ7fpxvfY0QyvsJ4+
 8DQEEPvL7HkLc07z4ILcZlzcKKySAT+3o8ldnBBYcu0R052CI7+9F0TLqCh7IPTFRY
 qge250jni0qOUn7bmlq8mxlwTZ+hnvHM/BH5r9pA2/lm6nw6yusZj95nmG+mJDa2u5
 Gbrcc3YTx9n5Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DDF5EC41616; Fri,  8 May 2026 07:23:06 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221487] Nouveau GSP timeout (r535_gsp_msgq_wait) on ASUS TUF
 Gaming A16 with NVIDIA RTX 4060 Max-Q / Mobile and kernel 6.12.86
Date: Fri, 08 May 2026 07:23:06 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: info@maketopsite.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-221487-2300-sxeC9Z5Owv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221487-2300@https.bugzilla.kernel.org/>
References: <bug-221487-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221487

info@maketopsite.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
