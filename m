Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC65F94CB7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:45:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D6310EDFD;
	Wed, 22 Apr 2026 00:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HPUpAhle";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8FE310EDFD;
 Wed, 22 Apr 2026 00:45:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C084260018;
 Wed, 22 Apr 2026 00:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B159C2BCB0;
 Wed, 22 Apr 2026 00:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776818721;
 bh=2BJjDF77qjHUMH9XeUdWF0cKGkPj5gcnwi8h0smYWvg=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=HPUpAhleqsEdsFdCY1IeDzBl1kWIuqT2A2nQsRR2mTrfs3ZNrvmY6YebTRXzbuVPU
 H09XdSjWNT/CUF7/Trb7alOl8bdJKoBgISG2XAjgZPi4gRtaR5j5F63n2Z2JCc0uQo
 qG811aEe/G7tlEBsLRXVqiqpLj/fdi98SQCis7d0sg6SzOfBKq74jZfRdzt8Gr1UVy
 jrjqgrNpd5egVFmhzUMrw+l7MAX/LNydUpxQUF78CQRigaZTEZ8i41xVU6KPFFESDx
 EKah1sr/KlD8eiAQoRVptQ623mdlCE7eAM/bUSndp7LLbyCJ3RA/F6JoFXBmiOfllV
 4emI5qvFILULQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 BA06D3930018; Wed, 22 Apr 2026 00:44:45 +0000 (UTC)
Subject: Re: [PULL] topic/pipe-reorder for drm-intel-next and possibly v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
References: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
X-PR-Tracked-List-Id: Intel graphics driver community testing & development
 <intel-gfx.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <d69501d53c233386d70ed10290af24aafebf434f@intel.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/i915/kernel.git
 tags/topic/pipe-reorder-2026-04-15
X-PR-Tracked-Commit-Id: 2c683e9b419328da3433a49f7c467da71aaf0469
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 993eb191400f5d06322989ea7c890fd11965f80b
Message-Id: <177681868431.3068898.8635617940441647954.pr-tracker-bot@kernel.org>
Date: Wed, 22 Apr 2026 00:44:44 +0000
To: Jani Nikula <jani.nikula@intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org, Ville Syrjala <ville.syrjala@linux.intel.com>
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

The pull request you sent on Wed, 15 Apr 2026 19:08:52 +0300:

> https://gitlab.freedesktop.org/drm/i915/kernel.git tags/topic/pipe-reorder-2026-04-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/993eb191400f5d06322989ea7c890fd11965f80b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
