Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4866CC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CB410E035;
	Thu, 13 Aug 2026 13:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bpg7+rEr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33BC610E035
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3ED2E600AD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5883C19425
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786626315;
 bh=ouOKjkZv9VE3bezR/G5L3F1nOidzEG1n56xTrIPLJV4=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=bpg7+rEr2oBgumi52wTCycoHuHzYKyyJf9uGajR75MvzQ5KKAuDBknXsydLFLooTk
 U6ZEFlwXuKN/StkOwCRMirWxAEfTZIHu2m9adY88G24rYOpAwNpEexvf0CCKosCVtJ
 TpCmPf5+goAVeRtTleBF0INj6yFRmFdVvG3hqjuICjdHWxqRKuOZ1kw/Zc284ousS1
 /KMKFZCNAtGfvH9IlXUeTZkJDLTjgqRTQ4RFuVWuocwdxmTPPO5zC+D4xhGP+Nhq7p
 KpQAaOoYr9mLeLNxYjeVkERpUOyt+efv6F1Mr7WjCJ8QQ75nfAp1l9EIdhjuj33yKW
 la2WVt2kl9ldg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix,
 from userid 48) id C3012C41614; Thu, 13 Aug 2026 13:05:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: dri-devel@lists.freedesktop.org
Subject: [Bug 221879] Max brightness broken since 6.18.42 / 7.1.6
Date: Thu, 13 Aug 2026 13:05:15 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Video(DRI - non Intel)
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: augustin@trancart.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_video-dri@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221879-2300-EZ0aIpj6Dt@https.bugzilla.kernel.org/>
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

--- Comment #1 from Augustin Trancart (augustin@trancart.eu) ---
I'm CCing you Mario Limonciello as the original author of this commit. I ho=
pe
it's the correct procedure!

Please don't hesitate to ask me more information, I'd be glad to help.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
