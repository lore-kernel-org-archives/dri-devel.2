Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C84FC0342
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:04:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 772B610E338;
	Thu, 23 Apr 2026 15:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V00pk+wg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC9F10E338
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:03:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6C9CE4401B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:03:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51729C2BCB7
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776956638;
 bh=F8J+Y9Czpo/W3moaEeLq0Sbr7FxonkNeiVM2Phmfcp8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=V00pk+wg4skIprB5yjCg2wLFH7+5hdiVJZn4eQVprP7lstqk3okX+IdKH3aaDsh48
 PyglV8It0V08NK4SU77G3wq2dFo2v4PCkfqn7nUtdQVgfT5GzVrHLMbXKeCIov7Lh5
 HBa7HQ+oWbPSCN2ZhFBzctfobLOFy55RZ9iWiXGLGWlDCi8KvaNzdRFb/0mVhSEUkg
 18bLg9V+m44K7po6dpHCWoiADAAbFCmVN3GzGhhku5MHxaO9kZlaAiTG0kvTdtSXnb
 y/Dy/WLsg+VzdsnEZAmJninXiinGoJSKtj9EgI6He/t8+VdP3SEmLSzJp1avTw0fLb
 mAcQxvlN7QzuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 489CFC41616; Thu, 23 Apr 2026 15:03:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: =?UTF-8?B?W0J1ZyAyMjE0MDJdIGVHUFUgYnJlYWtzIHBlcm1hbmVudGx5IGFm?=
 =?UTF-8?B?dGVyIGhpYmVybmF0ZSB3aXRoIFRCNCB0dW5uZWwgYWN0aXZlIG9uIEFNRCBT?=
 =?UTF-8?B?dHJpeCBIYWxvIChSeXplbiBBSSBNYXgrIDM5NSkg4oCUIExpbnV4LXNwZWNp?=
 =?UTF-8?B?Zmlj?=
Date: Thu, 23 Apr 2026 15:03:58 +0000
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
Message-ID: <bug-221402-2300-S2B8ahDveg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221402-2300@https.bugzilla.kernel.org/>
References: <bug-221402-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221402

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please refile here: https://gitlab.freedesktop.org/drm/amd/-/issues

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
