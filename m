Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F32CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 08:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C2910F3D1;
	Fri,  8 May 2026 08:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FBLmf5SB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F005E10F3D1
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:06:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BF743407F0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2922C2BCF4
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778227562;
 bh=1E41ZrOZc03qudRc1qThp8GNb8vH2T4qms7ARaCUCLQ=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=FBLmf5SBt7MNLcEa1/i8oq8XX9QpZwxVRr9FAP/WSE6XZtatFj4EAToWf01C/+M5g
 2diKeIZ8Zjjmr4iCQi27WRgpFEi2C62oA4/TNmBClZOUCZPVroQ+ObkmpZ68JCEnjc
 ozDPiOoCy6iilS7IXZvtGzDmyuMLtDYg9AW1wGDF7KYyN3BEOaUW2LNkJlncalNwJP
 A6oyA+bSYcYqYM8t3YAKEv1tXVdKjyra4hSdEtAOAtPoTYWUpHMCwuBQri7FuPtc4+
 9JugI+abiWPBoUH4BCm7NZfntxBhRURQGx4tjkw58W+6pva/YkQN/COxye2JSbAlHd
 hFYddnXu+kMQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 9B809C53BBF; Fri,  8 May 2026 08:06:02 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221480] drm/nouveau: timeout and WARN in tu102_vmm_flush while
 using mpv
Date: Fri, 08 May 2026 08:06:02 +0000
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
Message-ID: <bug-221480-2300-zKasEhHeK3@https.bugzilla.kernel.org/>
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

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please report here instead:

https://gitlab.freedesktop.org/drm/nouveau/-/issues/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
