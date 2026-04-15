Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFCDF43848
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157AA10E251;
	Wed, 15 Apr 2026 16:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rJTW+xL/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344D610E251
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:50:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2F518600AD;
 Wed, 15 Apr 2026 16:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB486C2BCB5;
 Wed, 15 Apr 2026 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776271850;
 bh=ufj3pjCxkiTm9y+Q+t1SNZaKvYGfCat5TvKexYGBrc4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=rJTW+xL/eAliDDAhR63bOQkshj8BUfcMogDt0F2BQNyVjtMcKM73E6xOupcBERONq
 pM63/eyq+L0bZRQBuWiVPNdRpMHxYW9WAh+SVYgw9u4ljhDl0qAGp6Ui/4cx3ePgA0
 XfY3wNfrK/gCy9kuHUw18UwwJ2+dfchRCYbDzWDzEroByrDfjs01UHO1fMn6M7tzNS
 lml1U2bEazxS36/+sFAiYNRTVXx0DFVEGq0LZhQZnqPECEsrid56Z2EF/okegUjcWX
 faShbn+Gea2mdgW9yKcC0LKJRmhYoLWA8Uku06raTpVR52XnBewlECcrkjY5mM0gWk
 SFeQHjWq8sb3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9CFBC380A964; Wed, 15 Apr 2026 16:50:21 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes and updates for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ad5m1zGyRSJFwoC8@carbonx1>
References: <ad5m1zGyRSJFwoC8@carbonx1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad5m1zGyRSJFwoC8@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.1-rc1
X-PR-Tracked-Commit-Id: a31e4518bec70333a0a98f2946a12b53b45fe5b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afac4c66d1aa6396ce44d94fe895d7b61e085fd4
Message-Id: <177627182034.2328436.49830147803001383.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 16:50:20 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
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

The pull request you sent on Tue, 14 Apr 2026 18:09:59 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afac4c66d1aa6396ce44d94fe895d7b61e085fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
