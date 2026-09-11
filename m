Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA720C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 22:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B332C10E363;
	Fri, 11 Sep 2026 22:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QLt88QDD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F1110E363
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 22:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C4AE843919;
 Fri, 11 Sep 2026 22:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C171F000FF;
 Fri, 11 Sep 2026 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789166145;
 bh=DwABCuGqhZdwHbE6/rRUQTn1Zqfmf5jlBb34vF7u4lM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=QLt88QDDxbt//rMb8mwGUDHEBfWXSf4st1/5TH/vzIcfOPZyJF0b8+MXdGtLtEAfH
 jcxuR3XaQ7XrHWVnJyclnzHksGz/EN0q7oGDlnr8jF9A9w63fjQb7bZ8Vlh0ooV7SA
 DvXXMQhRFNRgmdkFJwaZ7oUFFBsrkGZ6HitPjcSIer9GMuDD/VHNrWXkTXe9stLSZP
 hr6uAdXKbU49zHAxq8I37PEbtn+wCYLK/bKVlluGStr2pKxOdlJpD+/RT7Hd4s0Ydl
 TvEhAqqQAEpKrf7L+W3/Tf9jET3e5wXDEibE4cl0tgLksYZO4DlUgID7ep3y6ui5B3
 KHV++fLEx5Qig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93DEA3924454; Fri, 11 Sep 2026 22:34:43 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty1x=g_7+obhbefCdWXQoEoW7-WdVuoN+P4+sfYJ34=_A@mail.gmail.com>
References: <CAPM=9ty1x=g_7+obhbefCdWXQoEoW7-WdVuoN+P4+sfYJ34=_A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty1x=g_7+obhbefCdWXQoEoW7-WdVuoN+P4+sfYJ34=_A@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-09-12
X-PR-Tracked-Commit-Id: b1edd3a3e00369080012b2e4c665fc662b96ecbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 525f0f99a4f775060288b3069e12b1d3e2b576da
Message-Id: <178916608228.3141697.4310144305381553071.pr-tracker-bot@kernel.org>
Date: Fri, 11 Sep 2026 22:34:42 +0000
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

The pull request you sent on Sat, 12 Sep 2026 06:44:25 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/525f0f99a4f775060288b3069e12b1d3e2b576da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
