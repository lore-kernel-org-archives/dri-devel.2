Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53158CD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 16:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73CC110E3A9;
	Sat, 30 May 2026 16:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iyy0utnz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982CB10E3A9
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 16:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DA3C40B45;
 Sat, 30 May 2026 16:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA3B1F00A05;
 Sat, 30 May 2026 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780157824;
 bh=lgMGABhDtkcJCecMD67uV8TgoUAtWzS8gs+6setzh9w=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=iyy0utnzajBWYBOt3kaFOixwunXSTxA4LSoyNbWP5jFa4RiC0TmBpF2rQq2IsDHFF
 M8liKZvGcV9Ozv4k4UTkkweBnvaibpFMBs1czch17fMGDpQL+QwHLVOZQg6qoTXmP4
 XyRCwvfZassz7SnB9lKePvu5+KO738ywak2SbdmSuN0AOqqRFK89Q8D+XN3hM8Oqaf
 uNCfOfLgMYYGHu7pG/isO+XG8V42uH4JU8z2pm0kbgO3KYNxqoY+0InC6MNHrIYUsz
 Dbj6nFFedeYuFNzGEwhCwgkGv0tg8hP40Jz7ajkJt345pw89FqsdI+uwtyZdRtnZ2O
 Rb0lQNqNiAl5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0AA2393021E; Sat, 30 May 2026 16:17:08 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw_rsuFEfRpcctpzCxeiAufCf_+5Z+wYXVzYg2JEcHJjA@mail.gmail.com>
References: <CAPM=9tw_rsuFEfRpcctpzCxeiAufCf_+5Z+wYXVzYg2JEcHJjA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw_rsuFEfRpcctpzCxeiAufCf_+5Z+wYXVzYg2JEcHJjA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-05-30
X-PR-Tracked-Commit-Id: 7164d78559b0ff29931a366a840a9e5dd53d4b7c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2765233a483febb1bf56f0abdcc5aa06d25633d7
Message-Id: <178015782749.2653560.12936125919831947962.pr-tracker-bot@kernel.org>
Date: Sat, 30 May 2026 16:17:07 +0000
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

The pull request you sent on Sat, 30 May 2026 09:10:19 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2765233a483febb1bf56f0abdcc5aa06d25633d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
