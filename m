Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502D7CA9ECA
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 00:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6230010E136;
	Sun, 11 Oct 2026 00:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fP2x/YP4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB3F610E136
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 00:03:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87C7160A75;
 Sun, 11 Oct 2026 00:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414AD1F000FF;
 Sun, 11 Oct 2026 00:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791677032;
 bh=FWKMjmWHeJA8O1rpfSknkdz6pa7ZC6KyGE2ideprhJM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=fP2x/YP4pFqdYnXHRApl3yVjLkv3eWzXsLhNn9R1cy6sTfPD26bMzf2LIA3MYhAfb
 n5VyhHP/W17tufL7llxHdG7r6Ku9/TWM4kiNeaXjOen2UsJIgqUbLN+PKYR/qDG38Z
 XihmGPBXn5B7DHbOMuPBsWaPWPnNwTjOXe8pUDC5J5xoBoRigi/IJhmUUVnZNcNfDQ
 +KGCnyfWwjkuy/FEVibx4eSbv9nfMTwiNUdhPc24d4rI2OtCxeM110iDIKdx6Ra5n5
 V8tDJMwbVhBY+8x3PCnXWRn2iisooTRffq7VyexmIv6GiK4mB6L5NTnk9DfwsqrB7w
 aP4DEpXCNfrrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A351381195E; Sun, 11 Oct 2026 00:03:52 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty-Gh9_5sqdFzz6gVvvVjQ4erOSEg_bm8S9a5O4Seu7Nw@mail.gmail.com>
References: <CAPM=9ty-Gh9_5sqdFzz6gVvvVjQ4erOSEg_bm8S9a5O4Seu7Nw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty-Gh9_5sqdFzz6gVvvVjQ4erOSEg_bm8S9a5O4Seu7Nw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-10-11
X-PR-Tracked-Commit-Id: c61e23ed14359e6289c08e55940dd3401fe27db0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb934c29fda8dcd409145a0deddc1a8095fec930
Message-Id: <179167703070.1871243.15634334620212402831.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 00:03:50 +0000
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

The pull request you sent on Sat, 10 Oct 2026 21:23:16 +0200:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-10-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb934c29fda8dcd409145a0deddc1a8095fec930

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
