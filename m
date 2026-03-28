Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB6C10BA45E
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 00:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075E410EFA4;
	Sat, 28 Mar 2026 00:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DfkVjeby";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AABC10EFA4
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 00:31:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E571443748;
 Sat, 28 Mar 2026 00:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C382DC19423;
 Sat, 28 Mar 2026 00:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774657862;
 bh=A2gRRcEtk8utBL3b3A/baSIKWVOvi+p0JSQJhdd7h7U=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=DfkVjebytcwuvi7lcQdRAaCwr4EERGuOv7hkacnqPo+ymZCiQG6c+rb3jiGFwktGM
 kucaa6/OuOfNWz6KMSotlx7Ktg2sMi6+MIj+HaMzHiblondNIth7hKWEtbEonrTNCg
 kKy2IuonwCx1Otj0a/nwDHuvDYlpqLuwc5TydEpXujkShzcwC+t9DphstXl9tTdba0
 6gjwKwTJXVRqpWpIgFNVecj6deygsML4LJnmVpjgW8sv151/QXcdGAmcehumtwHgKu
 GBsiToMM8ERjvwn8XDkETMJNYCztbpgw4a4p+UUiFuLdc0pEUkFx7XcaVRa5TphZ9T
 rpm8uwmN3UHWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9F873930181; Sat, 28 Mar 2026 00:30:49 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyArjCxangpgvhE2MrRdkSyWMrEJWDei4eX4EjFgW8uyw@mail.gmail.com>
References: <CAPM=9tyArjCxangpgvhE2MrRdkSyWMrEJWDei4eX4EjFgW8uyw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyArjCxangpgvhE2MrRdkSyWMrEJWDei4eX4EjFgW8uyw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-03-28-1
X-PR-Tracked-Commit-Id: 5ba61d8a25ddf89915f71bf8b63c06d6ffdf06cc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26df51adf30b3d440293eed38d01f953ae0bb6f4
Message-Id: <177465784848.4134300.5840942074732836638.pr-tracker-bot@kernel.org>
Date: Sat, 28 Mar 2026 00:30:48 +0000
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

The pull request you sent on Sat, 28 Mar 2026 08:09:25 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-03-28-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26df51adf30b3d440293eed38d01f953ae0bb6f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
