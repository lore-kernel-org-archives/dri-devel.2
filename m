Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1428CC79F82
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 21:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE6D10E16F;
	Fri,  4 Sep 2026 21:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XLdl8Q0R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169E210E16F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 21:01:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8DA7B44783;
 Fri,  4 Sep 2026 21:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672A61F01565;
 Fri,  4 Sep 2026 21:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788555688;
 bh=zVaURlvyoBLOyt7OGXCWczNXhDsHtBwMHiOQfWney3k=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=XLdl8Q0RUQntg0zNfrNm0/neW/cviVcWf2Oe8psL3BZztlycTFv3Bis8LmcAAKkzl
 PeDtFWd/KMJY3XyCqGWZKhDY2YzvkEz9G00yNPINL11TAQqLwZd3YHTeBkPt4iaaO8
 Tcl6tS15GDPoxRjKutYQVJF4sJMSYLkWz1mt+doFYcbP50b+qJCp/OksY8HXmFrIDW
 Tm6NYsDWvRy1YaAJ4Uy5WtePEbW3YOOvv/9GXq2GzR6qSA0VbCVXyQKr7x1yZyhWqq
 uRQWl/od6ojH8yPUM2G80RUePo6fOeJErjsDg3xXzKc2JXY8Ue0qfQeTkQtC5aSgkN
 xX782mjXjIqgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 4EB463924A73; Fri,  4 Sep 2026 21:00:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.3-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
References: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty9kjb1bKFgjgBS1tgM3zP2tK+5qTFzT9-0t+1jykBDxw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-09-05
X-PR-Tracked-Commit-Id: c96294afbcb5737da18229e788ca45a5d534abc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
Message-Id: <178855562902.966019.17956475458236383508.pr-tracker-bot@kernel.org>
Date: Fri, 04 Sep 2026 21:00:29 +0000
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

The pull request you sent on Sat, 5 Sep 2026 05:52:03 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/654ae5d73c05bd2943d65636ce6cd0aa46e62f18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
