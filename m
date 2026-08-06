Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F00C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 09:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A057D10E1F6;
	Thu,  6 Aug 2026 09:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b2lrM5Jw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A1110E1F6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:14:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 94AF14120B
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7579BC2BCF6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786007666;
 bh=Xk43tKb9ImT5tTRqg5TvEEEt/n7PbA02hGP+eU8PKEM=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=b2lrM5JwGUjom8PEO3R6puNIovpAWq1Y3EkzyY8mdl+mOkNTSHvrbBp0PCRodVvtz
 I1kVg+ClwdZHNG3Veer0w3/zUQZ/6YHN84aNmTf0ArRVp+rR+0yNf5qOOKweB8y6Y3
 +qxoRf13UZ0UF+SKV7g/1lcoXSLOf41RqgMycIU5zLWLW1ZadI+NAKQa0uiQA535Xw
 JarCgDaTR0etj3WKleogMCqy4Z63elNgNwzLZiQyTaWIVpnvYbxHCoMTIYid2aT7/j
 oH0rF0RyyIro91by6EyFN4i1czqQ5vLUYaHPmLzgNvsQGfERzB6B1aXwR1B0hd/dMW
 qdGXRSBsqRlng==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id 660DDC53BBF; Thu,  6 Aug 2026 09:14:26 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221838] [Regression] Black screen / no backlight on resume from
 suspend in kernel 7.0.0-28-generic (Dell Precision M4800,
 Optimus Intel + Quadro K1100M on nouveau)
Date: Thu, 06 Aug 2026 09:14:26 +0000
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
Message-ID: <bug-221838-2300-hxWf52mAJT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221838-2300@https.bugzilla.kernel.org/>
References: <bug-221838-2300@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221838

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please report here:

https://gitlab.freedesktop.org/drm/nouveau/-/issues/

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
