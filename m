Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9179CA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D06E10EA48;
	Sat,  3 Oct 2026 22:38:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a8gsQoBh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A68610EA48
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 22:38:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F257660214;
 Sat,  3 Oct 2026 22:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898EF1F0089C;
 Sat,  3 Oct 2026 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791067129;
 bh=xO5R81dRFmvXP+oBvrJJLiArFPxToNNZBXws0YgONPU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a8gsQoBhJC5EYlxZ27z608xFzxwPohUilz2EuP2ADNGIfR8h3+S2DcTuy5XPEmdOT
 7RHHGx+t9S4U6X6No7yx2d/jgaeVJ36MhyypFTYXDgK0D+lHqLzwyvPGPa6hg8uFmd
 YwCWjdIZY0Ip+gSgouzHbEMQ4SMeRpCyZuZ9s4ofNBUYPeGodVKFvmHWDSDbHC2xm1
 VFBwuM8JECPeh324dFaO9qLdx+2hjEJLonsWjTrGQR/EI3QrhLKhcCM6SMkLme+N/d
 uFbZ/W99f+oU/Z9ixdyc0LHchzEeZomG5lQ2Jqd6JSbrmj2s9nbeXMxE2xP6Q3H8Dm
 +BhzzRg5YecvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Artem Dinaburg <artem@trailofbits.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>, jason-jh.lin@mediatek.com
Subject: Re: [PATCH 6.1.y] drm/mediatek: Fix potential NULL dereference in
 mtk_crtc_destroy()
Date: Sat,  3 Oct 2026 18:33:03 -0400
Message-ID: <2026-10-03-1-daily-reply-0022-re-mediatek-crtc-destroy-null-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002194413.20810-1-artem@trailofbits.com>
References: <20261002194413.20810-1-artem@trailofbits.com>
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

> [ Upstream commit 4018651ba5c409034149f297d3dd3328b91561fd ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
