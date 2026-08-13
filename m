Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86997C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8C5F10E295;
	Thu, 13 Aug 2026 13:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WE4qCuHJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA3A10E295
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:26:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 210A260A6C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9795C2BCF7
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786627592;
 bh=LXWEjbeFEbaor/RSZAx9isYUdfa+B8gEznlI2GTj8DE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=WE4qCuHJlPYgt2w6pdPYwskX/4JTY7w6Rdwwg4zmy3SDPr26GAbuKyYGsBzUDE+X/
 sD3D4IWElOhdev+LjHubOpidevQLjR1ynrbfMvCRiMZMGWRmVKsTgSEIBtiJtgZk9Q
 QDhl0JEPcx+KXdc/PToL7x9VBQBjNmfAIxNoKujnZ+g2b3vm6WfRN2DHRjXUZR3QnN
 XD34ZWU0dGAsCyIN9M2KUyP3tutTfIVS3NtKynrXamcFkEADdZoC85Dqj0xlBaikem
 qYSd70luPOVY72bxMNSI53MFd4eo1mofOJocffvPjvZlaNhuATiAlvlQO/snxvKCQS
 Xb4E2IcHCgeUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id AD1CAC53BBF; Thu, 13 Aug 2026 13:26:32 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221879] Max brightness broken since 6.18.42 / 7.1.6
Date: Thu, 13 Aug 2026 13:26:32 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221879-2300-l24Z7QurqS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221879-2300@https.bugzilla.kernel.org/>
References: <bug-221879-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221879

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
The correct procedure would be to find the proper bug tracker (this one's n=
ot)
and search for the existing tickets (the issue has already been resolved).

https://gitlab.freedesktop.org/drm/amd/-/work_items/5562

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
