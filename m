Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251DCCCA46C
	for <dri-devel@archiver.kernel.org>; Sat, 17 Oct 2026 01:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5842510E0F2;
	Sat, 17 Oct 2026 01:43:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDF410E0F2
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:43:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C860D6053E;
 Sat, 17 Oct 2026 01:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF01F000C4;
 Sat, 17 Oct 2026 01:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792201414;
 bh=jbUmEp2hAjKmLTkX1BCZDqAGjVXdLC7pt4TCKIbfFxs=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=brCHT5xZRhTVvx/gqp8S1r71ouXt3WbvN2v4iN6G9IzdXWv4GGKP1mlZqgQo/gTsv
 +uL9Sp/tJbDfLs5q5g+tJMVNhfmVcDf1koveXY6AcCpkV7Yb6P1FvTH+vh/JE6UP+r
 XiFbr+NkRf4+JI8DPDNCzyPOdtYUPm6wgZZ7w5Ig8zKhTaN4Bx9I4NiP5zEn0jLDJk
 ++bAUiZWmVJ16X+q9uByl1kIHu/qKW84WWMrqELxrdB1+WHt6s7ldYA+VmFKteQHsJ
 oZXAf7TgCUE0rOIpOX5ICdiWtnn7SZc53/xsL2oAPSr4G6sunhB2DClgB/C1hstQoc
 nZgd7XUTPsnKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7745C380CED9; Sat, 17 Oct 2026 01:43:34 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz6wzOBn8o_xgpKkstWwUem0tGzau544TETtuiNthN1KQ@mail.gmail.com>
References: <CAPM=9tz6wzOBn8o_xgpKkstWwUem0tGzau544TETtuiNthN1KQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz6wzOBn8o_xgpKkstWwUem0tGzau544TETtuiNthN1KQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-10-17
X-PR-Tracked-Commit-Id: f91a4ac69629e1479745e82100863157e6967ec0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58161ead29e50d70a317ea26b472e0c7508e69da
Message-Id: <179220141305.1053691.11331644666621373723.pr-tracker-bot@kernel.org>
Date: Sat, 17 Oct 2026 01:43:33 +0000
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

The pull request you sent on Sat, 17 Oct 2026 08:02:17 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-10-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58161ead29e50d70a317ea26b472e0c7508e69da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
