Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61F606A6B7
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0tZ/1AJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7028210E0DD;
	Sat, 21 Nov 2026 05:05:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA61D10E0DD
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 05:05:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BB4560235;
 Sat, 21 Nov 2026 05:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4325F1F000C4;
 Sat, 21 Nov 2026 05:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795237538;
 bh=G1FP/mrEv40p41j8+397M2J3HIaMmil9yAF1/nARBgI=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc;
 b=W0tZ/1AJ/3zHB4BB4M7MvFj/nwBpThOA0foEafTK0YQdGqnTJEHg/iuPvEZNo1RgJ
 VGxLkd8MvqQhGMPxnJPwT/MHpgdrxvdKaJZx6JS7FoTZUumbzil1BwyJO9wOiNRwL4
 L8/OaZm1InaX8CAzpMwY23vtd7IvIraQqWBDmRGUA7EhioFDkbY08owuVY89BrhUFu
 I9rwo8TISMV5LC8kwrQs+/rL/PqfVtzCuTiO9n5ZfUSFL6cTyRJgPA7MD6Rsi4CFJf
 VZTRvATKwEc4MOCGAsYcChORZ2i4LsfApNBg7QeMcAuxEGKSHfe82BCe2DBCDbFRit
 PMmZCGzSS+yGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 3A4D3380AAFE; Sat, 21 Nov 2026 05:05:38 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 7.4-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9ty1FBin9jGz8CoumpTTBOe-LB_Qs5RNn_uMJMbMGTYmyQ@mail.gmail.com>
References: <CAPM=9ty1FBin9jGz8CoumpTTBOe-LB_Qs5RNn_uMJMbMGTYmyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9ty1FBin9jGz8CoumpTTBOe-LB_Qs5RNn_uMJMbMGTYmyQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git
 tags/drm-fixes-2026-11-21
X-PR-Tracked-Commit-Id: ce29b8f9fb606f87014c2d05483a3fef05a11f38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c44104f3642da720164042623e4832836aefdd8e
Message-Id: <179523753687.934029.387954530225891606.pr-tracker-bot@kernel.org>
Date: Sat, 21 Nov 2026 05:05:36 +0000
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The pull request you sent on Sat, 21 Nov 2026 08:35:51 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2026-11-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c44104f3642da720164042623e4832836aefdd8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
