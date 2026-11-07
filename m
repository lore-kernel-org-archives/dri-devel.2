Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D402606A326
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNzZ7+by
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF6010E650;
	Sat,  7 Nov 2026 19:34:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C2A10E650
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 19:34:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C14DC43E7E;
 Sat,  7 Nov 2026 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C701F0089F;
 Sat,  7 Nov 2026 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794080070;
 bh=hR0lLIy5I7EOWaXN48xdiPdjHbSikuo7QbvBMv02qEY=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=cNzZ7+byA86EetcnISpcN5A6MfW/ag4oPLrQHXvMl39mNNDwjNVN9VpDeHKedz+UF
 l7mbBT3ObpN0lgvjbPpITn6O2edX2o7rsQDO3UzJC2CMrmJtRY3zizDBKw0DWsAtQf
 7MXBPAoTTMNUs8i0VChpg2ArzERkcFaPYlURgfuQvq2+BvTyKdawABwGXST90zmm4o
 DeKEuUBQz9l1uGXEAcheHJgMozCu+XTTbJ/dkraMH0ed4RoGIPKMvra7B7kHhUUBHT
 5Hg0gVAlMw8x6dYg95ZvYdr1yg45XHSeDe3W2r4CX1dkbDCKGzGFXYaEFDLrsc3Pj1
 G9A+BGknccy8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 9B2CD380821F; Sat,  7 Nov 2026 19:34:30 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.4-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz9wWFUO4Ua84DF3V3GWHSL1k_t2UhShUHS4MkGpXR+Mw@mail.gmail.com>
References: <CAPM=9tz9wWFUO4Ua84DF3V3GWHSL1k_t2UhShUHS4MkGpXR+Mw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tz9wWFUO4Ua84DF3V3GWHSL1k_t2UhShUHS4MkGpXR+Mw@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-11-07
X-PR-Tracked-Commit-Id: 19e67d977d3d4d0c54f03906ef578578190db9e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 543b7d2ca09b4b08d518d668ac2fdc361f231785
Message-Id: <179408006914.1301131.1164662599894737407.pr-tracker-bot@kernel.org>
Date: Sat, 07 Nov 2026 19:34:29 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sat, 7 Nov 2026 06:36:45 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/543b7d2ca09b4b08d518d668ac2fdc361f231785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
