Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA8C4451C
	for <dri-devel@archiver.kernel.org>; Sat, 18 Jul 2026 04:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80D0210E420;
	Sat, 18 Jul 2026 04:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X5mJScx4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBEE10E420
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 04:55:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C473C60A68;
 Sat, 18 Jul 2026 04:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6449C1F00A3A;
 Sat, 18 Jul 2026 04:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784350501;
 bh=e0hLHav3gzWrWz8CVEotWFoVD6khVop1zDvWSm2cn30=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=X5mJScx4G11i1xTkwoPKCcJR9tNvIXR1kS/99guh9MjOPWY//oqGKOJV/Td5K3/Fe
 wvWZ6XMIQNa87SHf/JdhJ0FZ0DrflhgXz2YCvIf4TPJGcguZ4HNS/5cxCRCfZnycwf
 lQ70TPJhxso2l9GRn6fA4QLFmLEt3y6J1LwWFD2xu+tusYIz8yp+tmdRTmq16LM2kd
 8qMsd/ey/HpbHXhXMzXmRwJcLoJf3UW0T57XJajO2yPvCz8/iNHSn9xz+EmJGL5ARE
 +aHgsQAnoI7E/eK9oKOEEOuNPodi3hDsMNcnAel2q6/4g8L9osmo2LmhUkRslTjye0
 TU0YKTpIEDH/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 938D53811955; Sat, 18 Jul 2026 04:54:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc4 (updated with amdgpu)
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txvBdB0TSf8W5S4M=CPu=vPZ5F2gBQQ27y4FzkoxoCKew@mail.gmail.com>
References: <CAPM=9txvBdB0TSf8W5S4M=CPu=vPZ5F2gBQQ27y4FzkoxoCKew@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txvBdB0TSf8W5S4M=CPu=vPZ5F2gBQQ27y4FzkoxoCKew@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-07-18-1
X-PR-Tracked-Commit-Id: 973fd9493ec21f12e760fbbedeb7b0b2317c02f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d6ca51a444234ca436d7c19282825797507fe82
Message-Id: <178435047324.2413748.16168542564300684388.pr-tracker-bot@kernel.org>
Date: Sat, 18 Jul 2026 04:54:33 +0000
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

The pull request you sent on Sat, 18 Jul 2026 09:20:34 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d6ca51a444234ca436d7c19282825797507fe82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
