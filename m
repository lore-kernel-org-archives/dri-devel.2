Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75836F34C64
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3EA10E09B;
	Mon, 13 Apr 2026 16:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="wOewI4Y4";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 446CE10E09B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 16:05:17 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E11474E42978;
 Mon, 13 Apr 2026 16:05:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF9AE5FFB9;
 Mon, 13 Apr 2026 16:05:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6DEBB10451BA1; 
 Mon, 13 Apr 2026 18:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776096314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6NYaxM8+Z4I9FTa2rYGBzSB24QflKaTIQ9WHW5ChvWw=;
 b=wOewI4Y44/e5Ugt1wMJEqTWeyI7QdMUyKeWAS3i9J1T2rhKjY/W9OlFnfkJ+zluISZMMLz
 mEA9ZPcVkTjxyEgMyivU7hq9DhhOUbfqypKx/Rz5xRaPfTYxnuRk8eT40tLHJ2iNQWfWDD
 rs1u7eVmm/PJ2q8C3toMNFq2JXYak1m7bgJi8/8VCQDYgbaKKxPscrDvqTR0YGIQaQAo0a
 9MKhUQq0VSxSB4XAzu3vMewQt/wvr710KPGbp+GEhOwQRDnIrfR1h/RoSfQkbTzCVApmYe
 fChmda3/rQ3qjvZXx3OlgyIxX5CXk1iD3Ihjdp5Ikb69GbhSR3hxMZgJWA/vmQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, inki.dae@samsung.com, 
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org, 
 jingoohan1@gmail.com, hjc@rock-chips.com, heiko@sntech.de, 
 andy.yan@rock-chips.com, Damon Ding <damon.ding@rock-chips.com>
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, alim.akhtar@samsung.com, 
 dmitry.baryshkov@oss.qualcomm.com, nicolas.frattaroli@collabora.com, 
 dianders@chromium.org, m.szyprowski@samsung.com, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20260413132551.1049307-1-damon.ding@rock-chips.com>
References: <20260413132551.1049307-1-damon.ding@rock-chips.com>
Subject: Re: [PATCH v14 0/8] Apply drm_bridge_connector and panel_bridge
 helper for the Analogix DP driver
Message-Id: <177609630366.308413.12157295287173122177.b4-ty@b4>
Date: Mon, 13 Apr 2026 18:05:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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


On Mon, 13 Apr 2026 21:25:43 +0800, Damon Ding wrote:
> Picked from:
> https://lore.kernel.org/all/20260409065301.446670-1-damon.ding@rock-chips.com/
> 
> PATCH 1 is the preparation for apply drm_bridge_connector helper.
> PATCH 2 is to apply the drm_bridge_connector helper.
> PATCH 3-5 are to move the panel/bridge parsing to the Analogix side.
> PATCH 6 is to attach the next bridge on Analogix side uniformly.
> PATCH 7-8 are to apply the panel_bridge helper.
> 
> [...]

Applied, thanks!

[1/8] drm/bridge: analogix_dp: Pass struct drm_atomic_state* for analogix_dp_bridge_mode_set()
      commit: 3be024d26a576519ce75fabfbdf6972731c19900
[2/8] drm/bridge: analogix_dp: Apply drm_bridge_connector helper
      commit: 99a49ff5ef7a5f01e28e724b888d94b6735a88c1
[3/8] drm/bridge: analogix_dp: Add new API analogix_dp_finish_probe()
      commit: e9c897c898f9ff32d93380ee4ebc778a6b787aaa
[4/8] drm/rockchip: analogix_dp: Apply analogix_dp_finish_probe()
      commit: d35ac0973463f67162d9ee73bf0c828ad5d4d2f9
[5/8] drm/exynos: exynos_dp: Apply analogix_dp_finish_probe()
      commit: 02b8a4f240abdc4e99efd6cf95c47378a1015903
[6/8] drm/bridge: analogix_dp: Attach the next bridge in analogix_dp_bridge_attach()
      commit: 3076510af7cd01a7fb0ae5103116a39ad35eb5cb
[7/8] drm/bridge: analogix_dp: Remove bridge disabing and panel unpreparing in analogix_dp_unbind()
      commit: 2bfc4e192f04260c2eead9b79274d39984f5a143
[8/8] drm/bridge: analogix_dp: Apply panel_bridge helper
      commit: 1b86a69b61df411354da70d9528f022833bee4d7

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

