Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FF1C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 22:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B3A10E012;
	Fri, 14 Aug 2026 22:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVcm9B64";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6540310EF0E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 22:59:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70ECD601E9;
 Fri, 14 Aug 2026 22:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2880C1F00A3E;
 Fri, 14 Aug 2026 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786748352;
 bh=MEVqkUPf/cBi6WdDtRupbRE+z3cEavDohEXb81dnfmQ=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=SVcm9B64Ri/Hkizgjm56FT5VvYGUYh6AvX7phQ1L45PqVfZUOORva6vVzRJNvpqBS
 +oePvKb6n3eaq/yNeWPJDKmvJ/o36QPf32DpK5IcfHKF97IXRJPJSq5Sqh+dcI/3xQ
 B7SmmQlWZkX/P8XghNC9A1ubNmBzatIRDZrZ0LU07ZCjIBF4TjKrkxF1jhzbJ5VhqZ
 R7Af3hBOvTj7QXb7w4cd7eThNxyC2/Qq6tgKbYe2aF7HeFo4ySkWT1bLR6WFChF6rl
 0Rb5Tkqx7LA+10yaFRn9udp9IshbS+ziltHUJj6nsTnbQyukh/dM8Huka48k6db+Hk
 sP0zySjEen6eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 5685C3924460; Fri, 14 Aug 2026 22:58:27 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.2 final
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz9+VhERCnDCCiFw3_FF_-C5ygQMUVQTcozjwdVRS7Ppw@mail.gmail.com>
References: <CAPM=9tz9+VhERCnDCCiFw3_FF_-C5ygQMUVQTcozjwdVRS7Ppw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz9+VhERCnDCCiFw3_FF_-C5ygQMUVQTcozjwdVRS7Ppw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-08-15
X-PR-Tracked-Commit-Id: b2601e783a2e54f6963d65f0d94f96d96c146a3a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dac3e89a2c90c2feeb471e1f22a2512ad424b792
Message-Id: <178674830595.3991221.12932139912258540032.pr-tracker-bot@kernel.org>
Date: Fri, 14 Aug 2026 22:58:25 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
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

The pull request you sent on Sat, 15 Aug 2026 06:33:44 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dac3e89a2c90c2feeb471e1f22a2512ad424b792

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
