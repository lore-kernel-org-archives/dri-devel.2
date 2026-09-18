Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4160EC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 23:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81ECB10E500;
	Fri, 18 Sep 2026 23:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XEOPZ4C5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018E810E500
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 23:46:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C20C642E5E;
 Fri, 18 Sep 2026 23:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55E61F000FF;
 Fri, 18 Sep 2026 23:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789775216;
 bh=s2Zok4+sRmuTh9bTb95MbeiTB30WDV5CdXO2vJdNr8o=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=XEOPZ4C56Phi60+aRJ0+AO+1Wa0MYe9PmDXSp1gL5WMxMqwuMtgPpt+6/okLD8sDY
 krpyy6ROksDSczMI3Ms2jmcRGuyHLlx9zhLv1ehTvRDnRWtqp4lt2TnRdBo26p3fc5
 QOph68vIE6WOnSON4crAiVWk5TDFMdsqd9/JYzDabHNZJ0Fs1spgB6VduzQO8++faP
 oJ4VGC619lJDcYmcaUpbzekL3ITkBOJaKSIAMwCixnx1uwdzttC9JE/HTlFNFn/I1J
 0dNeTNVZp6s1u2OH+z9Jl8FzTLIVAOW8HXuKL1BicV8NYiCwJ/XGoZnNikYeoTqW1l
 em/86aefmnpVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 D0E313811977; Fri, 18 Sep 2026 23:45:50 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyHWoVvi75xn2duuoMm=MMux5fmBSx=UjbNkPAvbZZ3Nw@mail.gmail.com>
References: <CAPM=9tyHWoVvi75xn2duuoMm=MMux5fmBSx=UjbNkPAvbZZ3Nw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyHWoVvi75xn2duuoMm=MMux5fmBSx=UjbNkPAvbZZ3Nw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-09-19
X-PR-Tracked-Commit-Id: 71f370e9ee1bdfe1f916547089d93b5265a918e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40288c9206c17eb66a603262e06a58d300d0f279
Message-Id: <178977514946.1191559.17325193394068189608.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2026 23:45:49 +0000
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

The pull request you sent on Sat, 19 Sep 2026 08:16:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40288c9206c17eb66a603262e06a58d300d0f279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
