Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC0B10AB83C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D92D10E321;
	Fri, 27 Mar 2026 00:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IrIqb/7G";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDAE010E283
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774572933;
 bh=V8lVwih9AzBJwR4ANDMYIaupy1aCX2o2M8JPQlL0kck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IrIqb/7GAIVHD1guC5m94AkcXTs3mqc4CtY9+J/qK/KXKq8Qxy4SbbNfudUXL78px
 Eh55aVvqNAWTtfqRTWTm0vO4/4Li30CogCg8tNoCpSPWyxEgO/vagQVw2U5G7oW4+s
 6M7i8ezglpfGmaHsosAyC+54eZlnX2Psa1A6MZHPx+zL8Q/ALQYKez7HRpEoywU7pT
 ZNNRJjkQjUAW4TpQCV1ZTs+UFfq0BbdIWNYC8qIkGoAqrFmEoo8bo7pbdEajg/z1gT
 PqW+W83gyJuFdWFrR9bV92PRZTmKXemWs3rK74Jp4AlgbSaSuhRjITOZ3tzogkjHHD
 ktetw3MEYQ5wg==
Received: from localhost (unknown [86.123.23.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1380117E6255;
 Fri, 27 Mar 2026 01:55:33 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 27 Mar 2026 02:55:07 +0200
Subject: [PATCH v3 1/2] drm/bridge: synopsys: dw-dp: Support unregistering
 the AUX channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-drm-rk-fixes-v3-1-fd2e6900c08c@collabora.com>
References: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
In-Reply-To: <20260327-drm-rk-fixes-v3-0-fd2e6900c08c@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
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

The DisplayPort AUX channel gets initialized and registered during
dw_dp_bind(), but it is never unregistered, which may lead to resource
leaks and/or use-after-free.

Add the missing dw_dp_unbind() function to allow the users of the
library to handle the required cleanup, i.e. unregister the AUX adapter.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 6 ++++++
 include/drm/bridge/dw_dp.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 3f4530c117c7..6211ba6ba7bd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2093,6 +2093,12 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 }
 EXPORT_SYMBOL_GPL(dw_dp_bind);
 
+void dw_dp_unbind(struct dw_dp *dp)
+{
+	drm_dp_aux_unregister(&dp->aux);
+}
+EXPORT_SYMBOL_GPL(dw_dp_unbind);
+
 MODULE_AUTHOR("Andy Yan <andyshrk@163.com>");
 MODULE_DESCRIPTION("DW DP Core Library");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/bridge/dw_dp.h b/include/drm/bridge/dw_dp.h
index 25363541e69d..22105c3e8e4d 100644
--- a/include/drm/bridge/dw_dp.h
+++ b/include/drm/bridge/dw_dp.h
@@ -24,4 +24,5 @@ struct dw_dp_plat_data {
 
 struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 			 const struct dw_dp_plat_data *plat_data);
+void dw_dp_unbind(struct dw_dp *dp);
 #endif /* __DW_DP__ */

-- 
2.52.0

