Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09E7C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FFF10E38E;
	Sat,  8 Aug 2026 06:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F+jLYOcC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1682710E38E
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:09:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 532406001A
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06901C2BCC7
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786169364;
 bh=baNdgHWHlgUV4MPWYG1M39j1DIHVOoKitgQj5Y/EXRA=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=F+jLYOcCuQkcPhFoVpkzhzMr96XMBpkyRVvHjJKhY+V/LYRugPX/kkAKQv0TddAXe
 VDvgOMQzo+lZ0wHq32EtCP2rfZ2oWrhTG/oCQZawVImWXow8a1/GWUxpSPIq4BWnSy
 h87ZnABzE/EvJQ0546d2qwM4WS+dPlXNbgzvlGKhoLwMSEEKqFb6iH85HTGx6lHmIe
 qsWAJ0vAuJnvMknhTnylr+LSx8W0qFf7NBHsEnPkytrL2vp3ornJbMT6vw3RVzVteR
 POwBjJ1AyoLef/9KF7/VguA2hrvxOHK9utCWiiU1eEGEVF2qWbHyfEh9Qb33MVmyT2
 rkSHKJCiGuZag==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id DAB8EC433E1; Sat,  8 Aug 2026 06:09:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221852] X does not start (or does not show screen) on
 DisplayPort of NVIDIA Quadro 600 with nouveau
Date: Sat, 08 Aug 2026 06:09:23 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: takashi.yano@nifty.ne.jp
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221852-2300-Fs9mMv2yKh@https.bugzilla.kernel.org/>
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

--- Comment #2 from Takashi Yano (takashi.yano@nifty.ne.jp) ---
This issue was originally reported here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1143161

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
