Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B39C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 02:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D946A10E406;
	Sat, 27 Jun 2026 02:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KTfuU+E4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D77710E406
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 02:00:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3C7F600AB;
 Sat, 27 Jun 2026 02:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDE91F00A3D;
 Sat, 27 Jun 2026 02:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782525635;
 bh=UzMEt/7O4PD9G5kfBZG3O4N2CuKn5infao9iZoRs6BA=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=KTfuU+E487x3mwUENxZpwIisEArhrybLHvEVtJoWFXjXl2GaZDVfofAwymLbmKL3Q
 heAN+MNw7ZE4GR4mJq0eImJ+SFMmxrn9ENxObW+IFX/ua31zNMowmvEIE4piujW0yP
 VB/eFgx4WtnNM+ftENu8WO0nzqXAcLvcTZ5URMrlwN2dNKIkzAZCo2aZo0oynyT5Wk
 LuU+Gn0PsGR4FJWXkhG4O7b8JoPiWdjGyM67K/Rody/rWEgx9b7UL+nrwaF3MI9N4r
 +OhC3tuLZOXCk9cZDwvN6H/xZtbyE12MQI9aRP6uqjOlyMh5kewHxGlUgAbZI3yYQS
 68FICZg3kQ8ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19EA53938C76; Sat, 27 Jun 2026 02:00:23 +0000 (UTC)
Subject: Re: [git pull] drm-next-fixes for 7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tys2rN-EwfmUowvdozkZXqJENMz4GsCYHG6eOwyo_-R1g@mail.gmail.com>
References: <CAPM=9tys2rN-EwfmUowvdozkZXqJENMz4GsCYHG6eOwyo_-R1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tys2rN-EwfmUowvdozkZXqJENMz4GsCYHG6eOwyo_-R1g@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-next-2026-06-27
X-PR-Tracked-Commit-Id: b41df707b6d7b7ae6188c6fc37ba81859293cb94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa6fe449343c3d97ed93fd01b020860c663f8807
Message-Id: <178252562158.1167646.2593473629414958552.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jun 2026 02:00:21 +0000
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

The pull request you sent on Sat, 27 Jun 2026 07:12:25 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2026-06-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa6fe449343c3d97ed93fd01b020860c663f8807

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
