Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05C8C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 06:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD76510E1D7;
	Sat,  8 Aug 2026 06:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WXNkCtd/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112CE10E1D7
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:05:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C1E3F404AE
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B172C2BCC7
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786169121;
 bh=qatgqFx+3SRPLU+Yzcv+MPTpEeq4AhkOx2UgvvKwLlo=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=WXNkCtd/Tb71s7X3vQZFmWZBizZ+tUqXsLYhO8+7gdm2vIzWnHO4tk1ajB1V/e67I
 3NXGebZHqLhIGRIGkJ86Ipmqf27Z6VAET6vzvjsbhIkJz0C4V6QDpdLi7LyJP/a1r/
 mKLBlYJ8u2Hqrelnhoq92Q7ytuZCC7H7glhqc+LrYvob8yGNeYe+FnCXYRl85cHXii
 CgnxCrjXy8unnd//GPkEb35YgkRjJEgWB/EejLdQ+wfIWaWmDHun2GNd1MIVjM57Pd
 BuOEs+QwTYxKmWiAaN5S78XalkoeJ+tZvV+I1YMlJJO93ft4XC5Fwsf9R3QKm9JCiB
 KWKYej6TJEhaA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 7B80FC3279F; Sat,  8 Aug 2026 06:05:21 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221852] X does not start (or does not show screen) on
 DisplayPort of NVIDIA Quadro 600 with nouveau
Date: Sat, 08 Aug 2026 06:05:21 +0000
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
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221852-2300-Jp3sxFe60o@https.bugzilla.kernel.org/>
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

--- Comment #1 from Takashi Yano (takashi.yano@nifty.ne.jp) ---
Created attachment 310600
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310600&action=3Dedit
Full dmesg log when the issue happens

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
