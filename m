Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CCDC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 23:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559E910E081;
	Fri, 25 Sep 2026 23:07:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z9PWEHpa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6790510E081
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 23:07:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB99143FB0;
 Fri, 25 Sep 2026 23:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09F11F000FF;
 Fri, 25 Sep 2026 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790377632;
 bh=iL1Os5cJNzRTGk3HlBvSKm7ZvK/CpuePZU4NA2h0+D4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=Z9PWEHpaT/3UvqdMsoZXwicQzvmcGVJZHHTDLF6hYomvp3N5Wt+9IjnUiGzpCaDuS
 kyZxytJiDrTr+OhWj18Say1UDkL5CuNGUBgrlTsJzwLcGfkLsI094Rt1/JdqvvfpVM
 7yaKZQPCJX3rSzA6ZOP+IgKAa6S+sEKV3p/LR792HiElWukMzz+Cy/XTHLFVKvileT
 K329F9vgkE0+80Zpt13jiQ5vb2gNAwuQ41b6Q7tGPfCj2TTLuNet7rZxtfqOiS1vtR
 5J/ufCBeTKArEkYTy1UFR+UogPjFSIyTs1AUcjMq9WdyV/NhU65m4QqYHpGKwtJXmG
 O+AZbNbKJXMfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93C6C380820D; Fri, 25 Sep 2026 23:06:01 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twjOfCE5-LzepSB58uaQtn4kS2yF2sOu52kiJp2xkJXkQ@mail.gmail.com>
References: <CAPM=9twjOfCE5-LzepSB58uaQtn4kS2yF2sOu52kiJp2xkJXkQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twjOfCE5-LzepSB58uaQtn4kS2yF2sOu52kiJp2xkJXkQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-09-26
X-PR-Tracked-Commit-Id: a9ed3aa9b87ee41e8ab3ff471b1331c154767e45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
Message-Id: <179037756003.3195274.16267321532601727285.pr-tracker-bot@kernel.org>
Date: Fri, 25 Sep 2026 23:06:00 +0000
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

The pull request you sent on Sat, 26 Sep 2026 08:31:46 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6812ce4e4379ffc99c52401ec28f0d7ffbc36206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
