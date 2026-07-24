Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D237C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8500410E1B8;
	Fri, 24 Jul 2026 21:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o1/0+Z8R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323CF10E1B8
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:23:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EFEF433CD;
 Fri, 24 Jul 2026 21:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CED1F000E9;
 Fri, 24 Jul 2026 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784928203;
 bh=j88uBJov7ndcNu6an2BjYpk7VG/906RK1jvD+27UPFY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=o1/0+Z8RV+La7SsA9iq5AHzjJWpePqNI+Y6PJ42ncolAK9mddGss5X8atE62c6DZx
 ht8Z9pTqnowj3A8jNMkaX0MpUd9qLHudLO4QclFo/O6IVmiYbkDSB4Lf1JIDdBjEW7
 /FwfvtAddMgG64YQfNvMIwqmP9MyqpwHjJA3L5s7bAOmFimihcoVvO21DVfF71DMJV
 D/T+fujLpPQSCvEepAOQI0CoRBbW7T8DCpUzUYGwrDLZuTJIqQSRvoC1Nm7cEKWelE
 Z2zsd80wtne/wrXYssXVDC5uKGmsToPPyW6dpKFTUsQ4kC2RQOE5tk/lMUGi0D7Snq
 WhjmbiYVvCu2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0B9338111D7; Fri, 24 Jul 2026 21:22:51 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twoa3i8b3H5hLiJRdQeQ4X3n_mYtRXuoy9J=xtdHsq6bQ@mail.gmail.com>
References: <CAPM=9twoa3i8b3H5hLiJRdQeQ4X3n_mYtRXuoy9J=xtdHsq6bQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twoa3i8b3H5hLiJRdQeQ4X3n_mYtRXuoy9J=xtdHsq6bQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-07-25
X-PR-Tracked-Commit-Id: 6c33542c01eac1ac4d5595c1ba2dace0e27e842d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2a936998ab25cf7272847356390041c3143b498
Message-Id: <178492817039.3313174.6942043909812561101.pr-tracker-bot@kernel.org>
Date: Fri, 24 Jul 2026 21:22:50 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
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

The pull request you sent on Sat, 25 Jul 2026 07:00:57 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2a936998ab25cf7272847356390041c3143b498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
