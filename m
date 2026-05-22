Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995E3CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 23:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9326410E08A;
	Fri, 22 May 2026 23:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mPMy1rcl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063A010E08A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 23:43:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 90C4A40555;
 Fri, 22 May 2026 23:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C911F000E9;
 Fri, 22 May 2026 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779493434;
 bh=KtS4rZQF38Aq9tn0nSfDT0dXFIMlWoqdHKktHaRmhBY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=mPMy1rclDF8vtcrEsP5yl8JXMEsWfFvFXdDWoA1LzO2o7XEEgco0BXIDUroeMd1+D
 DGWFTMqJAJu7AVj4rDPUMQr+sLtWC6BV519inaufv5gZH5U5ISpcjRPhH2W929eHNE
 u1xDA46UOXo7IOV8atQQxI+a9IReydb1lZkJA/pWMc8pVq+OGWJtEwr933NmbgaXHg
 tPtA7rwZXGQICRAKNTHQTeNu8av9+FaXpwnn9QnWXyh5FOlqyt85CKWZGue0NDxd98
 8Vvi0WHl3gAFXI5wzusfVkw/YsvQ1oVHN6CDNPwgNWDoic9KPCJpc4GF4QAVDLTuIT
 9UFWvmzSpojcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93CFC393100F; Fri, 22 May 2026 23:44:04 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
References: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx1oasUKYLGvimk5eXftsYk1LOSaNV_X27tVp-pvrMLLA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-05-23
X-PR-Tracked-Commit-Id: 84335a9985867c1a6cd28c693ffbedc4ef1caa39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a5860ea6098bc6c0a966bb415d5dfe96adb4a86
Message-Id: <177949344317.1408813.13770640725783848977.pr-tracker-bot@kernel.org>
Date: Fri, 22 May 2026 23:44:03 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>,
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

The pull request you sent on Sat, 23 May 2026 08:16:11 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a5860ea6098bc6c0a966bb415d5dfe96adb4a86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
