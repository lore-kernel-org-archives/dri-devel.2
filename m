Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F7FCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9557310E960;
	Wed, 17 Jun 2026 08:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Ujm/M1hV";
	dkim-atps=neutral
Received: from mail-m81248.xmail.ntesmail.com (mail-m81248.xmail.ntesmail.com
 [156.224.81.248])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E171810E960
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:09:35 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 42babb538;
 Wed, 17 Jun 2026 16:09:32 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH v1] drm/bridge: of-display-mode-bridge: Fix missing static
 const for the bridge funcs
Date: Wed, 17 Jun 2026 16:07:55 +0800
Message-Id: <20260617080755.186368-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed4a0da4c03a8kunm894ad5d3100114
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCT01NVklKQx1DGh1KTR5PS1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0tVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
 b=Ujm/M1hVlK+YRle0YoqxJdBkguaeKgV1Xy0k0jRCXnGaCqjXRVgaaVsu/nbS/Gv3mLDyEQT5uLdbaCeVyMiSx7Lotg9d8ZI2tZLVKlQGBygGSpT72Mrold98Sgx52ZsYQ93D344XMe98Q8WqLg5K2J/dXyL9GPidX1cKrBC3o4o=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=RJm8BpWTv3NBC6m8Ens3pSKQF1AhwDpnF1kcx9evs+A=;
 h=date:mime-version:subject:message-id:from;
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

Add static qualifier for of_display_mode_bridge_funcs to resolve the
sparse warning:

drivers/gpu/drm/bridge/of-display-mode-bridge.c:54:25: sparse: sparse:
symbol 'of_display_mode_bridge_funcs' was not declared. Should it be
static?

Also mark the structure const as required by devm_drm_bridge_alloc()
parameter type constraints.

Fixes: ba2db93cf3d5 ("drm/bridge: Move legacy bridge driver out of imx directory for multi-platform use")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606170744.FUStcWaB-lkp@intel.com/
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 drivers/gpu/drm/bridge/of-display-mode-bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/of-display-mode-bridge.c b/drivers/gpu/drm/bridge/of-display-mode-bridge.c
index cb15713f3a79..e66dae168fd0 100644
--- a/drivers/gpu/drm/bridge/of-display-mode-bridge.c
+++ b/drivers/gpu/drm/bridge/of-display-mode-bridge.c
@@ -51,7 +51,7 @@ static int of_display_mode_bridge_get_modes(struct drm_bridge *bridge,
 	return 0;
 }
 
-struct drm_bridge_funcs of_display_mode_bridge_funcs = {
+static const struct drm_bridge_funcs of_display_mode_bridge_funcs = {
 	.attach = of_display_mode_bridge_attach,
 	.get_modes = of_display_mode_bridge_get_modes,
 };
-- 
2.34.1

