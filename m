Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2E60A263D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=geIMCpwt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231BE10E5E1;
	Fri, 20 Nov 2026 08:33:17 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBB5710E5E1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:33:10 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261120083308euoutp024e2d8fdbb119aff300f2f4b0ccbb8ab3~ps8XY5ILA0821908219euoutp02w
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:33:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261120083308euoutp024e2d8fdbb119aff300f2f4b0ccbb8ab3~ps8XY5ILA0821908219euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795163588;
 bh=ojjQE8zFX677t+gAJRG+m0a6Gi2Ki7K5qk5BkNHDxwI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=geIMCpwtlAbY/xk/kf0hWNioLtvXqEUHrkmdhveGAaTIOOq6qAFvpXHej7SA9plYm
 Yh2oPd96chTGAVBhIBxUa6NWj3B4LeO5IrCzd5ovBQ7wOaxtBNiQsEY+lr5saSXsMK
 v3ZM1Ka0fH6eNnhRnLuVG9Q/31mdHwFyM0gERxpU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438~ps8W_xKz_1516215162eucas1p1P;
 Fri, 20 Nov 2026 08:33:08 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261120083307eusmtip2051a07475ab43ef42acd41fbf9530feb~ps8WMryvY1698416984eusmtip2O;
 Fri, 20 Nov 2026 08:33:07 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Damon Ding
 <damon.ding@rock-chips.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Heiko Stuebner <heiko@sntech.de>,
 Douglas Anderson <dianders@chromium.org>, Brian Norris
 <briannorris@chromium.org>
Subject: [PATCH] drm/bridge: analogix_dp: Make
 analogix_dp_init_analog_func() void
Date: Fri, 20 Nov 2026 09:33:01 +0100
Message-ID: <20261120083302.3719465-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438
X-EPHeader: CA
X-CMS-RootMailID: 20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438
References: <CGME20261120083308eucas1p1d1298fab5a4df3a64cf66d5fe9d82438@eucas1p1.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

analogix_dp_init_analog_func() always returned 0, so the error check in
its only caller, analogix_dp_set_bridge(), never took the jump to the
common error path. Make the function void and drop the check. No
functional change.

Suggested-by: Brian Norris <briannorris@chromium.org>
Link: https://lore.kernel.org/all/20261119093347.1159198-1-m.szyprowski@samsung.com/
Fixes: 3efe2ace7f5b ("drm/bridge: analogix_dp: move basic controller init into runtime PM")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 +---
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 8bb4c48aa3b4..a41c16b7dcbe 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -996,9 +996,7 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 
 	pm_runtime_get_sync(dp->dev);
 
-	ret = analogix_dp_init_analog_func(dp);
-	if (ret)
-		return ret;
+	analogix_dp_init_analog_func(dp);
 
 	/*
 	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 4560597604ad..440007e2270d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -192,7 +192,7 @@ void analogix_dp_set_pll_power_down(struct analogix_dp_device *dp, bool enable);
 void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 				       enum analog_power_block block,
 				       bool enable);
-int analogix_dp_init_analog_func(struct analogix_dp_device *dp);
+void analogix_dp_init_analog_func(struct analogix_dp_device *dp);
 void analogix_dp_init_hpd(struct analogix_dp_device *dp);
 void analogix_dp_force_hpd(struct analogix_dp_device *dp);
 enum dp_irq_type analogix_dp_get_irq_type(struct analogix_dp_device *dp);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index c1344a3f013a..3d196cf96fb9 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -351,7 +351,7 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
 	}
 }
 
-int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
+void analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 {
 	u32 reg;
 
@@ -372,7 +372,6 @@ int analogix_dp_init_analog_func(struct analogix_dp_device *dp)
 	reg &= ~(SERDES_FIFO_FUNC_EN_N | LS_CLK_DOMAIN_FUNC_EN_N
 		| AUX_FUNC_EN_N);
 	writel(reg, dp->reg_base + ANALOGIX_DP_FUNC_EN_2);
-	return 0;
 }
 
 void analogix_dp_clear_hotplug_interrupts(struct analogix_dp_device *dp)
-- 
2.43.0

