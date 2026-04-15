Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E94F43858
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151B110E252;
	Wed, 15 Apr 2026 16:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hHLAntJ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D10A10E252
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 16:50:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AD2744381;
 Wed, 15 Apr 2026 16:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38FFC2BCB5;
 Wed, 15 Apr 2026 16:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776271853;
 bh=vjkcHT+XKAvyD4BzJrBgqseQQr8P7CstbX+4l0FdhrY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=hHLAntJ5lyU/7/b5jWaDbnoOd880Qb1UsYRR1OvhfYjnSurO4pPnWYGIMpYsWZuF7
 5Lva3RPq2mp9SaY9gvnaVqwOyHo5nogQUHVJPM5YwwavGKFufuHO2cprOrY2f3w224
 WN/HX+kwwFZEI0MGGkE30ebZS7EoTmUaYgCY2yNPOCKIYZmlmlgqfoh/pvkS+uTvg5
 2NyY7nPOBRvu0+kF9YymHsM70+2EMPTLt3sR743eDsEk1s4IZwaKZ2vwQDA5mJdhte
 YjqzCkYAm/9m4uHmzq4faqLdgMSAxgentHInW95EyRlprfOaLt9KTwQ83/Gveu96Ve
 H15767vaDgfiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9FFB380A963; Wed, 15 Apr 2026 16:50:23 +0000 (UTC)
Subject: Re: [git pull] drm for 7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyvKEU6-6O=Le9wVjTJqd3NdrUr-pA_eHxt3Bj-Cv7zMw@mail.gmail.com>
References: <CAPM=9tyvKEU6-6O=Le9wVjTJqd3NdrUr-pA_eHxt3Bj-Cv7zMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyvKEU6-6O=Le9wVjTJqd3NdrUr-pA_eHxt3Bj-Cv7zMw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-04-15
X-PR-Tracked-Commit-Id: 83e8d8bbffa8161e94f3aeee4dd09a35062a78c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a57e0913e8c7fff407e97909f4ae48caa84d612
Message-Id: <177627182260.2328436.15463233574545419711.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 16:50:22 +0000
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

The pull request you sent on Wed, 15 Apr 2026 16:42:38 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-04-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a57e0913e8c7fff407e97909f4ae48caa84d612

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
