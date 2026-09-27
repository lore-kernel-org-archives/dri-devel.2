Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350EDC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C9310E437;
	Sun, 27 Sep 2026 14:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4F/w/06";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF33110E437
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:08:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B294460AAE
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 670D5C4AF14
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790518119;
 bh=o7KSSj/6vh4OAS9ZwsvRnM1ug8VoWNhokMFZJi/Nk6o=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=k4F/w/06IEjDbnhtFQTEDQKqBYCyCbFxmx+zJrVYQlpfblVW6ar8cwo6fTK+Mdckw
 JYT6PKjbHw9XuVN3T7C/c+GYRhmnFEkoiyfYS2fb8khvjo+YQDLhvZ4s7Oh1fuemP4
 TusA4S86uxTY4oAlKAnof8/h13rt5zE/dvuyQHAcOlcxKn/8h1QP2h8CZKKQEN3w+5
 rY0rfVXbpvnAe5KF1V8ILdgtwkfmKM0Laer+9Oct09b5owGQljRxIVKIYjhnCQwrLb
 Gd+29lCNir046ybWYMNCry3Gx7VpyVP7+TGbi/ZX5lv/q65ogGUTbHesgUjkj7Kaqz
 OoWVORlU+bOPw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 56970C4160E; Sun, 27 Sep 2026 14:08:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 222061] [REGRESSION 7.1.8 -> 7.2] Strix Halo HDMI 1080p black
 after login (kwin framebuffer EINVAL). Full report on drm/amd#5893
Date: Sun, 27 Sep 2026 14:08:39 +0000
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
Message-ID: <bug-222061-2300-66XG9c4jAE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222061-2300@https.bugzilla.kernel.org/>
References: <bug-222061-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222061

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Freedesktop is where such bugs belong. Closing.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
