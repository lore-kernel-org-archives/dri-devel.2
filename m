Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC82CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 14:47:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B4710F42D;
	Thu,  2 Jul 2026 14:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OxkSnueS";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30AC210F420
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 14:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783003617;
 bh=PuxG68+CQhAoYovAeuQMsuFGzjG8Iw5optkXYeXFq4s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OxkSnueSEO0v+///ZqYtgTpupt6OfvoWhQaCKAJsrnLTEDJOtCB/cgKvg7OtaTfzD
 y0j0zXwvnNlNixcO2VSzTJmM13Zv0iAOZKa1f7s4HkmEVkYBvINZZlSgP7NYw2J2QQ
 IwUDzGEN27PR/3hnChZxMogVb1kqo4QMTtrGbgtP/AE3ZKB9yZ3aVQa6OgZDN7TImW
 xtZJNm4LElVLEb0vY2h+2lElx/0PJWACgnQsKYkTm/Zb02mUr8DkpXY+bHjGDiZ3nP
 y7d64Cuec7QFBw3GLKVrq9pMKyhu39BWMxDh8eiK/RBOyV8oLZcPidf0rg9GxNMzou
 QrssWl9sKahxA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CDA0C17E3678;
 Thu,  2 Jul 2026 16:46:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 02 Jul 2026 17:46:47 +0300
Subject: [PATCH v8 34/39] drm/tests: hdmi_state_helper: Use
 drmm_connector_hdmi_init_with_caps()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dw-hdmi-qp-scramb-v8-34-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

Convert the internal __connector_hdmi_init() helper to take a
drm_connector_hdmi_caps struct rather than separate formats and max_bpc
parameters, and add a
drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs() macro that
exposes the full caps struct to tests.

This lets new tests exercise capability fields beyond formats and
max_bpc, notably supported_hdmi_ver and max_tmds_char_rate, without
further changes to the helper signature.

The legacy drm_kunit_helper_connector_hdmi_init_with_edid_funcs() macro
is kept as a thin wrapper so the bulk of the test suite is unaffected.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 35 ++++++++++++++--------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 353a261d42da..6a7dd2de002a 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -231,8 +231,7 @@ static const struct drm_encoder_helper_funcs test_encoder_helper_funcs = {
 static
 struct drm_atomic_helper_connector_hdmi_priv *
 __connector_hdmi_init(struct kunit *test,
-		      unsigned int formats,
-		      unsigned int max_bpc,
+		      const struct drm_connector_hdmi_caps *caps,
 		      const struct drm_connector_hdmi_funcs *hdmi_funcs,
 		      const void *edid_data, size_t edid_len)
 {
@@ -273,16 +272,16 @@ __connector_hdmi_init(struct kunit *test,
 	enc->possible_crtcs = drm_crtc_mask(priv->crtc);
 
 	conn = &priv->connector;
-	conn->ycbcr_420_allowed = !!(formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
+	conn->ycbcr_420_allowed = !!(caps->supported_formats &
+				     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
-	ret = drmm_connector_hdmi_init(drm, conn,
-				       "Vendor", "Product",
-				       &dummy_connector_funcs,
-				       hdmi_funcs,
-				       DRM_MODE_CONNECTOR_HDMIA,
-				       NULL,
-				       formats,
-				       max_bpc);
+	ret = drmm_connector_hdmi_init_with_caps(drm, conn,
+						 "Vendor", "Product",
+						 &dummy_connector_funcs,
+						 hdmi_funcs,
+						 DRM_MODE_CONNECTOR_HDMIA,
+						 NULL,
+						 caps);
 	KUNIT_ASSERT_EQ(test, ret, 0);
 
 	drm_connector_helper_add(conn, &dummy_connector_helper_funcs);
@@ -298,8 +297,18 @@ __connector_hdmi_init(struct kunit *test,
 	return priv;
 }
 
-#define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, formats, max_bpc, funcs, edid) \
-	__connector_hdmi_init(test, formats, max_bpc, funcs, edid, ARRAY_SIZE(edid))
+#define drm_kunit_helper_connector_hdmi_init_with_edid_funcs(test, formats,	\
+						bpc_max, funcs, edid)		\
+({										\
+	struct drm_connector_hdmi_caps __caps = {				\
+		.supported_formats = (formats),					\
+		.max_bpc = (bpc_max),						\
+	};									\
+	__connector_hdmi_init(test, &__caps, funcs, edid, ARRAY_SIZE(edid));	\
+})
+
+#define drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs(test, caps, funcs, edid) \
+	__connector_hdmi_init(test, caps, funcs, edid, ARRAY_SIZE(edid))
 
 static
 struct drm_atomic_helper_connector_hdmi_priv *

-- 
2.54.0

