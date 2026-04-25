Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AC9FF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 15:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D567710E449;
	Sat, 25 Apr 2026 15:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WL2nHQhs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904B610E449
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 15:19:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B58C4347F;
 Sat, 25 Apr 2026 15:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38669C2BCB0;
 Sat, 25 Apr 2026 15:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777130397;
 bh=p+/TJClLL7ZSy93mPEIFdv+ZR12IgWfKo9hdpLIaYi8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=WL2nHQhsc+Nxw5XNlhzqx5BfS/rzgiM+5MMA2xckIvS3LChNfcT8tRsNeKPrMStVq
 13Gi71D5avbaOO8JU/jmDT3ze/qSnj4VNU5CzXKxCBbevf/Hi+8xjXddf8ajEXm9R0
 xz77iDJ12VKP9L7dZruESZVHZJQ+HHEyiieNbfCxrrqODNj3C8xGcxgko6A6JXy1Zm
 fBf5AS/GSET6/suNRgyUYHMJNR9+uJIiRn1kvN+NE+ALNEQbqAA2kiYhIMiWDos8Mv
 IH+79UdpfTMS8Mn1XYQPK+/5V9XyoNeyvdXuJsXOA2kZfiDPQkRDU6PG9ZYliz1/yE
 PZ8nWtkwPNmAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 02EB538119CB; Sat, 25 Apr 2026 15:19:18 +0000 (UTC)
Subject: Re: [GIT PULL] more fbdev fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <aex66_AU379EYm_a@carbonx1>
References: <aex66_AU379EYm_a@carbonx1>
X-PR-Tracked-List-Id: <linux-fbdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <aex66_AU379EYm_a@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.1-rc1-2
X-PR-Tracked-Commit-Id: 448aaf54d3ae1b73dfcf723c9f8a02c2116f3358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 897d54018cc9aa97fd1529ca08a53b429d05a566
Message-Id: <177713035656.1989237.16063921227445244104.pr-tracker-bot@kernel.org>
Date: Sat, 25 Apr 2026 15:19:16 +0000
To: Helge Deller <deller@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
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

The pull request you sent on Sat, 25 Apr 2026 10:27:23 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/897d54018cc9aa97fd1529ca08a53b429d05a566

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
