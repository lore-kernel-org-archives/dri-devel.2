Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3666DFED9EF
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A6010E5A8;
	Tue, 17 Mar 2026 17:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H0fa4eu0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2004210E5A8
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 50252600AD
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 032C2C4CEF7
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773769545;
 bh=85wL3eBjre7cygNfbUStOwx2kyrX+13dT8pnLXw13ds=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=H0fa4eu0AWn7a0OZdzIM8fw+Wni6pBTi8N/c/v64oxHHrpvkyWbjJ+OvBVzKjjwWc
 RG9FS/9jPAz7fN7sBUpp9dGsF7vQVJlixw45EOulK+sZ8L7jTCcsEnRdTtmjIuPxab
 bWnsV8+mYUu3kGEn8rnkgOVFUuc3686Sj39CPDIyb4s34iLCi+Y/JfU1bzQSF33jI3
 LG+PqM6lj8vCf+pg/9LQ50KqgB4xA9C/QmPst6A/y7cTJ/3xj7YzFqEcEn7aPdVDfK
 9PBgUBPt2U9u6t+GEebHv3rX+QQQ6hizR7Ons6+ubPCLt0ZpF4pMqqCaNetoRnNka5
 vkKrXveXq68nQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id F1EE6C53BC5; Tue, 17 Mar 2026 17:45:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221245] Regression: Black screen on boot with AMD FirePro M4000
 on kernel 6.19.7
Date: Tue, 17 Mar 2026 17:45:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221245-2300-63MwRClhCH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221245-2300@https.bugzilla.kernel.org/>
References: <bug-221245-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221245

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Perform bisection, report to

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
