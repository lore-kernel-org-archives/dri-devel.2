Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15009C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46F7B10E4B7;
	Sat, 12 Sep 2026 15:17:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Njfjkhlf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5C6F10E4B7
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:17:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C6F360233;
 Sat, 12 Sep 2026 15:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C722F1F00898;
 Sat, 12 Sep 2026 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789226246;
 bh=l4z4UUE2cvte4absAeVMzuQneJVY5GD1Ku0ix4zvAOQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Njfjkhlf1hqsUD5tuPROKSSfIHm0lfuw7xztLe1SOKQdtP8DZJxfe1cXXbJxSHbHC
 hMMdibTBCdsCsaa4T/l+Y2Cz3ByLHPFRkraj9HD5vFyybfRFu8jUxa9ZAxt7xsdpN2
 67YejZCzqg3sKhqSJP/USKLvhXWScT2LRyhtSKNd5W5qZEDX5oFLtzSRipRQTTvDaF
 HxE9h+qW4/R/VCU6daJZw1ANHhFMsXw6o8mQF2Nyhqp+/8nbEgeYxbPTukxrmKfzzV
 uEr7Dr8RwG2yhUXjR8qrqkG+N906ypCnD3ZQLOkx1xB/1A3A+QzsVH6f9+mk1+TNZ8
 Y4tpm2PhA12nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56B86380820D; Sat, 12 Sep 2026 15:16:24 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aqURvm8xf2oDLypa@carbonx1>
References: <aqURvm8xf2oDLypa@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <aqURvm8xf2oDLypa@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.3-rc3
X-PR-Tracked-Commit-Id: a0a34a40ed299c9c7cff6af163a5b883ee9d6d73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 31a4327ffe2d8cbd0f51a3af6a3ffc5ecd7fdbee
Message-Id: <178922618297.3511661.11196158861938310035.pr-tracker-bot@kernel.org>
Date: Sat, 12 Sep 2026 15:16:22 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
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

The pull request you sent on Sat, 12 Sep 2026 10:47:58 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/31a4327ffe2d8cbd0f51a3af6a3ffc5ecd7fdbee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
