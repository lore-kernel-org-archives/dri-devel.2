Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF983C5AD2C
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 18:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC4E10E027;
	Sat,  8 Aug 2026 18:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="is0zZU2t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E66610E027
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 18:07:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 67A9A4123B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 18:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 477C8C2BCF7
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786212469;
 bh=rA4ZMcbv124bQ1C9EGAYOEeOjKxcW7bTyQQzPSjoGpY=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=is0zZU2tEQkr1lv2YTn5nJdqRzDFBnttquxSzeRH2rIhCm+LRGcFiGRE1YG44ezdQ
 xZUek8sgb0h3P0H8Wvd92OMzi0sgOobsryY/JYuASmYxakmw9sE7suTxUJsrs11ifn
 mX7gFzqT+SGodjg5Yp+yhX3KRsqBLv91MdtsxQosAmkFkTFMX+8Lk5Jy7NQbH2UGz/
 EyYUI5bub3SVL47/8KX9F4CdmN1k4MXGyWxe6TVQfIpwawzujzDn7Hy/1ntwpwfw6o
 6kHVuIQRi7CO96I4hXraYG3B5hNp6Ksa8HNIG6BiN8GCwjq6gYMEhPtszZCgmUy+rt
 f0/hVKIL1KC4A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 386E9C53BC7; Sat,  8 Aug 2026 18:07:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221852] X does not start (or does not show screen) on
 DisplayPort of NVIDIA Quadro 600 with nouveau
Date: Sat, 08 Aug 2026 18:07:48 +0000
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
Message-ID: <bug-221852-2300-t3TG6A25vH@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221852-2300@https.bugzilla.kernel.org/>
References: <bug-221852-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221852

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
Report here instead:

https://gitlab.freedesktop.org/drm/nouveau/-/issues/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
