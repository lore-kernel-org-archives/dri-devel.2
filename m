Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACFDC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 21:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC19810E52A;
	Sat, 27 Jun 2026 21:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m8TT+rG3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B41FA10E52A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 21:13:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBF73600E2;
 Sat, 27 Jun 2026 21:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828431F000E9;
 Sat, 27 Jun 2026 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782594802;
 bh=7IIarUe+baKuHHQbpyHLNcw1qaxN6lQqvLcXWyFWHNg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=m8TT+rG3IZWdMjJVbbCAX1lNwl/HNbxDubbGoG2cwBROFV+X9uHbT3ktfM6AdBNeC
 qWbY6iAOkhxGkMkqEOKtzFuO+hNAWMT+CfaPS/JtEm+vdZ9nbfF3Px8kqPEZreGEqC
 j3rUuE03cthvUJhUN3mbyI5BVTEBknk8Zo/9m1nxxn6fvvkr+QrTCjdkn0pCjUxj2A
 582sVT8UwtLquwteFc0AKr8YfEb5Mit/KuNp/6MQFrc3LXujOnn9VPlu86y6j4M3v4
 BQ4lbB4/1UzGCgekTJ1OF5sbErACEQdkbwwlRiq1H86nmUBPRhVI2fwpr5M+u6Dbp/
 BehIEOLbYn8MQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A9F3938452; Sat, 27 Jun 2026 21:13:09 +0000 (UTC)
Subject: Re: [GIT PULL] additional fbdev fixes and updates for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <akANXx5Fr4vBRhwg@carbonx1>
References: <akANXx5Fr4vBRhwg@carbonx1>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <akANXx5Fr4vBRhwg@carbonx1>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
 tags/fbdev-for-7.2-rc1-2
X-PR-Tracked-Commit-Id: 7f08fc10fa3d3366dc3af723970bd03d7d6d10e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f21df873208d41ef816b15024d6447813b97ab5e
Message-Id: <178259478823.1431938.3522644980455972478.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 21:13:08 +0000
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

The pull request you sent on Sat, 27 Jun 2026 19:50:23 +0200:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-7.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f21df873208d41ef816b15024d6447813b97ab5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
