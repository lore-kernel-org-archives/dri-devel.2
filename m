Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C33C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 17:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5216910E1FF;
	Fri, 10 Jul 2026 17:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NM1IecHh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C73F510E1FF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 17:05:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C3CC40452;
 Fri, 10 Jul 2026 17:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604251F000E9;
 Fri, 10 Jul 2026 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783703120;
 bh=YMBGzUxybwhqi32KPOh9yuc8Y63Bagid1WAti3xsC2w=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=NM1IecHh8kQ75zxqcII8zqEpAyWNl02pr27RdkM3+OZmdM9ow33OUs5g75UcJXjJH
 54+Gy+0GNM/EM+LWXGczrhxtNmtRu/s3CAaT883b1uq9+ZFkA68hStxOEAiRF2DH6R
 3ibWb7z25LBrgMGzNw6Uje4DvxK9m7MDQx/enimETsna6YHxUiUNPv9JRlgLdGmRVt
 DWlsRWvHyq1ki45sWdLDL9ouHpKb1QbXN2qHlVoFiXCNCYDHnz0Ffie6XIBe+z/xbC
 8lNLG22SYIjZ9tV7VgUEEXQJ/9+rswLxI0Toifxr3VrnY16HQxFmB2lpuXs0XCHYpO
 9Fse3823Zl3lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 56AE23924FB2; Fri, 10 Jul 2026 17:04:59 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twH=ycBLJyS7eEkqYexViq_Bju6R=Hj-ev1yWGkeStntA@mail.gmail.com>
References: <CAPM=9twH=ycBLJyS7eEkqYexViq_Bju6R=Hj-ev1yWGkeStntA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twH=ycBLJyS7eEkqYexViq_Bju6R=Hj-ev1yWGkeStntA@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-07-10
X-PR-Tracked-Commit-Id: 6763a0aea6d658d69b9215ab9151d7bd4c1c314b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba0b7c62cea942cd0afa35a3768a9f4874874b2f
Message-Id: <178370309791.779204.7836819456550114382.pr-tracker-bot@kernel.org>
Date: Fri, 10 Jul 2026 17:04:57 +0000
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

The pull request you sent on Fri, 10 Jul 2026 15:00:53 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba0b7c62cea942cd0afa35a3768a9f4874874b2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
