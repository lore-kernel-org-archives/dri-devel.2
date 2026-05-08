Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAD9CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2CB10F38F;
	Fri,  8 May 2026 07:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kM3XEbo+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C34D10F390
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:24:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E8D524422A
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB4BDC2BCF4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778225047;
 bh=LQHKrC0aXbpVre9jlv01B4dBqxtEXYpWPzju6BfKxKQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=kM3XEbo+bfprWRGDgYh+cCBjmSOdq/sSJ3LaBa+eL7HRKyv8+lBiUsQlPiKHIJM4W
 MkqRIVWl6/3c3PIHYIxtm7Z+u/XXZTpugLeuTM1QZecyPL7PsLXmz18aGMacCXKsrl
 RoTykFxN055AI/4m41pYlbI1XTJBlAke7FAg73JLqIV6zn1bQFuHeE9KFJHqCwOUXw
 RffHZIocJSfNplyWLqcmQa+wBKGm1xLTUHCswYBMUjEXb7maOxdswPdq1cMwYftIm8
 PSWxpIaC0hih9bPXxDu4rJU9ba8jK7ogacUh+mTgJyUHbvptBcS+J6QReBwmPs1jOF
 UFF8LFV4cdwGA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C1D0BC41616; Fri,  8 May 2026 07:24:07 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221480] drm/nouveau: timeout and WARN in tu102_vmm_flush while
 using mpv
Date: Fri, 08 May 2026 07:24:07 +0000
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
Message-ID: <bug-221480-2300-GN06slFHmr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221480-2300@https.bugzilla.kernel.org/>
References: <bug-221480-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221480

info@maketopsite.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|All                         |AMD

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
