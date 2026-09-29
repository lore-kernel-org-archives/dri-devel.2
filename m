Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C23ECA5FB4
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABFF10F041;
	Tue, 29 Sep 2026 18:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OwFqeb9h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78E8510F036;
 Tue, 29 Sep 2026 18:51:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F62443A8F;
 Tue, 29 Sep 2026 18:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3736C1F00893;
 Tue, 29 Sep 2026 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790707878;
 bh=ZHSjjqpMm/URqtCDk0E7y52wfoKHRmMNE12oAP2zlD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OwFqeb9ha1kXhRCadNcpLhhWEmbOWfUEJab4R6DEcahzzX9butBH7M9Hf1XiNshNM
 m2pzL3Hn6Re9j+u5z2PvCWo6wxUZLgR2Sh6Gnu8m0akINhWSV5ZG20bRCl0WcIhjtO
 6i0EPcTYtwinotBrOqekw45bo2pxJT00zBdyRDVpMCEEnEhggKyMrMipRpQSm4pLsv
 ZNd07ArA67xV937ar5nuVz3sb4U75sCj3Enbyawk25Euf13CuBI8zZ3IKO58+X6i3A
 NP4GhhhQFhr/NcFTo3/dRd1A+BSrdSNrNwccKY/G2zBDrFSgqGEkJ15V4eIAA7RxB2
 3f0GOQCf0d/0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Jerry Zuo <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <xinhui.pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, Rodrigo Siqueira <siqueira@igalia.com>
Subject: Re: [PATCH 6.6.y] drm/amd/display: Check null pointers before using
 them
Date: Tue, 29 Sep 2026 14:50:53 -0400
Message-ID: <2026-09-29-daily-reply-0010-re-amd-check-null-pointers-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929031415.87382-1-artem@trailofbits.com>
References: <20260929031415.87382-1-artem@trailofbits.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> This one addresses CVE-2024-49922. It prevents the applicable HDCP path
> from dereferencing a NULL dc_link.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
