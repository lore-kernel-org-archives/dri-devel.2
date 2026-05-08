Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE904CD3445
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 17:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F07110F566;
	Fri,  8 May 2026 17:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bS6NLouJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 816A210F566
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 17:21:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C5BA344372;
 Fri,  8 May 2026 17:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CE8C2BCC7;
 Fri,  8 May 2026 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778260872;
 bh=Dp9K+cTdAR9Ad22w803RAmQvWPlWzLWi9hAvbCMDQRA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=bS6NLouJWK2TXNEjnbfWNIaRZYocx5hGb79ByTVSoRT5lZR73v7e/qXXLk3pVnR4d
 GYJLv+1BCyVEW1llld7CxnLiqIFZ16DEVLlH+mfrSVOUcb9iKd1KWDjZTgQ7Ib4azw
 3C3AcaD/M8hEhaFy8Mx+GF/KjeXbwhl1k/ddXK8jBa3G4bcP5+GkphI/wgVconjDoY
 wFpaazFFmVShsw+YQhXFLrDWg7BK5eCOuIurfnitTIxdsw3IpgZetpR+TrIIhciYTO
 cHkJv5f0cABPrRozKENCoXe4ryVKLdZiogtyimy61ggO2ETH4qlwsdPL1vT+VpUCqO
 GnGxGwK9S2nXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D0C13811979; Fri,  8 May 2026 17:20:22 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.1-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw+hnprz_uW=B3TprAfTgNMWzAEQgeCVrKvuqam8tirDg@mail.gmail.com>
References: <CAPM=9tw+hnprz_uW=B3TprAfTgNMWzAEQgeCVrKvuqam8tirDg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw+hnprz_uW=B3TprAfTgNMWzAEQgeCVrKvuqam8tirDg@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-05-08-1
X-PR-Tracked-Commit-Id: 5e28b7b94408897e41c63477aabc9e1db439bc8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51d24842acb9b8d643046c71314cc3d7a846a3cf
Message-Id: <177826082123.771267.780862208449071855.pr-tracker-bot@kernel.org>
Date: Fri, 08 May 2026 17:20:21 +0000
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

The pull request you sent on Fri, 8 May 2026 18:10:26 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-05-08-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51d24842acb9b8d643046c71314cc3d7a846a3cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
