Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6BDE99049
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 07:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7863210E0FB;
	Fri, 10 Apr 2026 07:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SIW8RjJo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA99610E0FB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 07:28:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E07E43DEB
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 07:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EB24C19424
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 07:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775806080;
 bh=sdqBci77dDB8hPjfCowoEq5c212T6tevqvqGVKL6Eyo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=SIW8RjJoYZWVr7HRMJRAOQmJXM4m9T/9KqAYhNZlP1DcOQZNWQUpepY6YXiBaSyyB
 cFVvQK1gl+CvlSbvBBt20t136pAxhOWftriQnhLFZ/Bcc9UWgszMPjO8IWynZ8oYGW
 EvBdQqDEmC0mUEvktPTg/t+mVyIeVYZKSzIV3QYqfb9Hkzc0b+n4TXSAPr3HQuzaSK
 VhjQLsY4zLDxn5iyggDWj0aPVerDKmV5R37bydn6aTxztlEXdsrkNRPyxDxDma/LvW
 XJLVwAe1Ssrz0kvRAptmdXC9LqtuRZWsPgP69Ws0HriiU1fcrsKWLyp2a5VG5lGRcb
 2kAsFc8uVp+VA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 2D70EC41612; Fri, 10 Apr 2026 07:28:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221338] AMDGPU: RDNA2 (RX 6600) Vulkan workload causes gfx ring
 timeout, MODE1 reset, and VRAM loss (SMU driver/firmware mismatch)
Date: Fri, 10 Apr 2026 07:27:59 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221338-2300-8qwdRQbhJM@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221338-2300@https.bugzilla.kernel.org/>
References: <bug-221338-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221338

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Report here instead:

https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
