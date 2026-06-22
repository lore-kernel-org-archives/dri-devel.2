Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41494CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9846E89304;
	Mon, 22 Jun 2026 10:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qlyZrJHV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 089D489304
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:25:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A92BD43451
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87475C2BCB4
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 10:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782123917;
 bh=JNCsW9aWq6iEmiyBFSFSIcM+IaXWUmQ5OLYA/gM+3g4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=qlyZrJHVRwhnmYCZvc0jHr7NdnVt77V+7XX7ctcCv6pZXP0d8u/+S73uxcr46j18n
 tOskX9libCeGB8q2Xz30xwpVisHvCXeip06pbmw2BZzf8ms7aL4yEORb2Us1kz7uEM
 zv5UCU8A2Jyi8idnl4suVVAAwUbSIucyD9WjkiF19YqDY3P3iVBfmit4XMY/CZ2a0D
 bqXaLZjtP5WOupiBTcw0WTlrHXSoUEVO/CyCkONShlQVwAVz5BYzOP4wou/SJHnHq3
 NDqLig2zfG5GLWEWxdSXkpSArcrpZ5bcUFbTPaXkpZH74j6D66RPmrLiCH05B2bfcd
 MQ3syV7XUs9UA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 6F94BC41613; Mon, 22 Jun 2026 10:25:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221679] BUG: kernel NULL pointer dereference, address:
 0000000000000000 - amdgpu_hmm_invalidate_gfx+0x36/0xe0
Date: Mon, 22 Jun 2026 10:25:17 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jy6x2b32pie9@yahoo.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221679-2300-xk6WBJ7421@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221679-2300@https.bugzilla.kernel.org/>
References: <bug-221679-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221679

NHOrus (jy6x2b32pie9@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #1 from NHOrus (jy6x2b32pie9@yahoo.com) ---
Found the bug in drm gitlab:
https://gitlab.freedesktop.org/drm/amd/-/work_items/5399

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
