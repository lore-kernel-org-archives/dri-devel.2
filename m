Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A8C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 02:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853810E0D2;
	Sat,  4 Jul 2026 02:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AVOgE4jm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC1910E0D2
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 02:02:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E331600AF;
 Sat,  4 Jul 2026 02:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534911F000E9;
 Sat,  4 Jul 2026 02:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783130560;
 bh=cW2cuv37oDm8TGEhy07fZCKyHkwv6GCeLREWBCbN8q8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=AVOgE4jmC04i4J3YW1WjlCCKG4WjOmIPO7Xv1Nb824MAhHJxBbdbPxuI+nLFk7TEl
 z4S/FZdehDJCq+BOMuica/jxv6jy6tMM4g4fXZ0iu7fP7F1NuAO/E9O1OYHqvMt5xy
 Hl/eRhSYxlt9bu75LGgsV237eax+fGWvpOriDm8pAWo1YSNzHdwqSK9JOyyiA4ueAj
 d44vdhLu1Qx/S++Gq+viIuDmm9klVosPJvav1vAvaPPSn9K1CYSn5ngDH1b1bpWP3g
 767QjBf4qdA3E7gqSPyer8UYpT0mxja+htOUyITaW/XeIN7HOXrSsQWa/0lKJ5I0ud
 wfgcH17YGKnNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 939A53939F31; Sat,  4 Jul 2026 02:02:23 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txPze-srvS8pEioF2kCdkTCcf-zAbXjUKuzgw35b6xubw@mail.gmail.com>
References: <CAPM=9txPze-srvS8pEioF2kCdkTCcf-zAbXjUKuzgw35b6xubw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9txPze-srvS8pEioF2kCdkTCcf-zAbXjUKuzgw35b6xubw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-07-04
X-PR-Tracked-Commit-Id: acd7c71ba8d83808fa8d704196f3d53f7d58cf50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dac0b8c58757eba9deb0fdd32d37a85bbb06006d
Message-Id: <178313054210.3392227.10324075597783203394.pr-tracker-bot@kernel.org>
Date: Sat, 04 Jul 2026 02:02:22 +0000
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

The pull request you sent on Sat, 4 Jul 2026 07:52:34 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-07-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dac0b8c58757eba9deb0fdd32d37a85bbb06006d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
