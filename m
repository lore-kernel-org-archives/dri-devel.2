Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AE6107BCEA
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 22:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0D5610E078;
	Fri, 13 Mar 2026 22:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yve14dfL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA96810E078
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 22:44:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA7B960132;
 Fri, 13 Mar 2026 22:44:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0598C19421;
 Fri, 13 Mar 2026 22:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773441886;
 bh=5GtGhoHS8HzhfRZb7kBwpgihNGwT3ViE7dfRR/YruWw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Yve14dfLvoeGdPgwTBAq1RTGD7nLIKdMSlic/0tvBJH0pDaNuSojNd4deuMUpSrs7
 QVzAaoQ5vAQ7vmIk1INQz+y0oImEnYqfHu92kDrvO6zIKhBRIWF407mjDUMNh4N21t
 OOIgFohIW/tPEsDLwzhf8s46n/DEUiIhxg+Ip1x83GEfaGmzQER03aMiRs/s6xDVrL
 wtUVkB2BEngW+X22W0Luu1AcrM9fRu58YYOu7KFgGmm5IPsNS9kQRN0Z2hTpRIYmDu
 zzFAyuI3Pjy21sGGkh9j+m6GdIEwk2vX/ABr+mk6wHoDImNGQCcanrGYw8ZpGMnC+3
 ZAa2mPElffJoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D3593808200; Fri, 13 Mar 2026 22:44:42 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.0-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyoZ7v9_Ki2wzYGryWDzTfnbMy6YE-1XBmRxcRCA-FonQ@mail.gmail.com>
References: <CAPM=9tyoZ7v9_Ki2wzYGryWDzTfnbMy6YE-1XBmRxcRCA-FonQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyoZ7v9_Ki2wzYGryWDzTfnbMy6YE-1XBmRxcRCA-FonQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-03-14
X-PR-Tracked-Commit-Id: b28913e897edfeedc4e33b03b28068b27d002e6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c9982b4961334c1edb0745a04cabd34bc2de675
Message-Id: <177344188104.1530597.8092008340907234151.pr-tracker-bot@kernel.org>
Date: Fri, 13 Mar 2026 22:44:41 +0000
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

The pull request you sent on Sat, 14 Mar 2026 06:56:50 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c9982b4961334c1edb0745a04cabd34bc2de675

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
