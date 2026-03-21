Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A641093170
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4182710EB7D;
	Sat, 21 Mar 2026 05:21:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nvKpO9iI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2544610EB8B
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:21:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 26F6360126;
 Sat, 21 Mar 2026 05:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFCCC19421;
 Sat, 21 Mar 2026 05:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774070477;
 bh=MjDpIuplnCFyVmF7oudkHl3VKWJqFg9uwu3xciNHmx0=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=nvKpO9iI4t8mgbc79CLhZLser3wlfP0poZiG+WYumGRmbOdbwXOzzA7d5rAZlens4
 J+ZH49vZDMxx94y6O0ecavnjqvBCZdUhQDp9/Nvyg3YxznPAx2x/AkLLZRhTxvmBH1
 k0PGvwW92+ATv556TuozQ+hYFtUlXYyM4HTBbUvH5KRCId0O0JJKx0auzw3N7Rat5M
 LDIFpSeiNzibX/rbe2sRHzGzarcPj/6PMiLuatwjn2v29e3E3nUGGspMn0lZqPCgUY
 UYUYYqX3YTbhMnWuE4qgcRSQgkuONhtfiz2h8+M+wp8iCWzAGljxsTCoN6EI+alLUd
 DQQq3rHPrn6sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 030843808200; Sat, 21 Mar 2026 05:21:09 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twty3xn1KRnsyHDEPMA3c6m3JZOOoh7GuW3gaLPt7-ivA@mail.gmail.com>
References: <CAPM=9twty3xn1KRnsyHDEPMA3c6m3JZOOoh7GuW3gaLPt7-ivA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twty3xn1KRnsyHDEPMA3c6m3JZOOoh7GuW3gaLPt7-ivA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-03-21
X-PR-Tracked-Commit-Id: a6e77320badd1444b0429ff8b6f338b750a1dc4f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0c83177734ab98623795e1ba2cf4b72c23de5e7
Message-Id: <177407046745.2772516.3088948036703754549.pr-tracker-bot@kernel.org>
Date: Sat, 21 Mar 2026 05:21:07 +0000
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

The pull request you sent on Sat, 21 Mar 2026 10:30:53 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0c83177734ab98623795e1ba2cf4b72c23de5e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
