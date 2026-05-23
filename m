Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293E0CD5BB8
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 19:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E076610E71E;
	Sat, 23 May 2026 19:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cjpPJQod";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136CF10E6E4;
 Sat, 23 May 2026 19:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779565656; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=XMAwK+VWybJJQblBzau0qiAZxM0zstXOXEA79HZMcKrFtTpx2z3TVCqo4aCIkejSiZs9r72zegCRt1j8irvCui3uH3axIddpOKvcq/ljQFUUL4+2JCQsB510t6kCtNM/7THldxijQusOklW8C3ZDd8UGn8ZELgZUNO49jEx/aTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779565656;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gGVpB3IASMynkptuB4kz7f6PDzq595OY22LNP1SYLO4=; 
 b=MqmSozJZsKMHrNBzTveM4e4m8ZQmIO3ZnXDmcwJOB+5a7Qti3h5XsUfe/ql49fX8EBgM4+el53GSvFu5qXqIGawX/aA7OSgOFDXTgtz0C4TlquZ83CpPBMmYEFOSlAiPNx6nsXmf0gm06VzfZJK7XEuBKGG5XEfRK0SU0QeXxeM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779565656; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=gGVpB3IASMynkptuB4kz7f6PDzq595OY22LNP1SYLO4=;
 b=cjpPJQodib2+0I7xXN0Rw0DRGQd51mF+mKqOaWZvbCESU9R7d/TuXGyCMrmDT0fd
 /KFU/2iKGrLu2gqAZnW5pKO2cx36xngV48z+SkJSPrwW4rYORg/8YOp5EgBAA/09TGh
 y+6wrmzK91J+fmyACvX7ftTFc9FNENf3n5UsWueY=
Received: by mx.zohomail.com with SMTPS id 1779565654477578.5366255087284;
 Sat, 23 May 2026 12:47:34 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Sat, 23 May 2026 21:43:55 +0200
Subject: [PATCH v16 20/28] drm/rockchip: dw_hdmi_qp: Implement "color
 format" DRM property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-color-format-v16-20-24340c5e4732@collabora.com>
References: <20260523-color-format-v16-0-24340c5e4732@collabora.com>
In-Reply-To: <20260523-color-format-v16-0-24340c5e4732@collabora.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: kernel@collabora.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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

Switch between requested color formats by setting the right bus formats,
configuring the VO GRF registers, and setting the right output mode.

To do this, the encoder's atomic_check queries the bus format of the
first bridge, which was determined by the bridge chain recursive format
selection. Pick the input format if it's !FIXED, otherwise, pick the
output format.

The previously unused GRF register color format defines are redone as
well. Both RK3588 and RK3576 use the same defines; it didn't look like
this as there was a typo in the previously (unused) definition.

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Daniel Stone <daniel@fooishbar.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 107 ++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index f35484715c2d..b77ef92ae954 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/hw_bitfield.h>
 #include <linux/mfd/syscon.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
@@ -44,10 +45,6 @@
 #define RK3576_8BPC			0x0
 #define RK3576_10BPC			0x6
 #define RK3576_COLOR_FORMAT_MASK	GENMASK(7, 4)
-#define RK3576_RGB			0x9
-#define RK3576_YUV422			0x1
-#define RK3576_YUV444			0x2
-#define RK3576_YUV420			0x3
 #define RK3576_CECIN_MASK		BIT(3)
 
 #define RK3576_VO0_GRF_SOC_CON14	0x0038
@@ -75,8 +72,6 @@
 #define RK3588_8BPC			0x0
 #define RK3588_10BPC			0x6
 #define RK3588_COLOR_FORMAT_MASK	GENMASK(3, 0)
-#define RK3588_RGB			0x0
-#define RK3588_YUV420			0x3
 #define RK3588_SCLIN_MASK		BIT(9)
 #define RK3588_SDAIN_MASK		BIT(10)
 #define RK3588_MODE_MASK		BIT(11)
@@ -88,6 +83,11 @@
 #define HOTPLUG_DEBOUNCE_MS		150
 #define MAX_HDMI_PORT_NUM		2
 
+#define RK_COLOR_FMT_RGB		0x0
+#define RK_COLOR_FMT_YUV422		0x1
+#define RK_COLOR_FMT_YUV444		0x2
+#define RK_COLOR_FMT_YUV420		0x3
+
 struct rockchip_hdmi_qp {
 	struct device *dev;
 	struct regmap *regmap;
@@ -116,6 +116,33 @@ static struct rockchip_hdmi_qp *to_rockchip_hdmi_qp(struct drm_encoder *encoder)
 	return container_of(rkencoder, struct rockchip_hdmi_qp, encoder);
 }
 
+/**
+ * dw_hdmi_qp_rockchip_bus_fmt_to_reg - converts a bus format to a GRF reg value
+ * @bus_fmt: One of the MEDIA_BUS_FMT_s allowed by this driver's atomic_check
+ *
+ * Returns: an unshifted value to be written to the COLOR_FORMAT GRF register
+ * on success, or %-EINVAL if the bus format is not supported.
+ */
+static int __pure dw_hdmi_qp_rockchip_bus_fmt_to_reg(u32 bus_fmt)
+{
+	switch (bus_fmt) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB101010_1X30:
+		return RK_COLOR_FMT_RGB;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+	case MEDIA_BUS_FMT_UYVY10_1X20:
+		return RK_COLOR_FMT_YUV422;
+	case MEDIA_BUS_FMT_YUV8_1X24:
+	case MEDIA_BUS_FMT_YUV10_1X30:
+		return RK_COLOR_FMT_YUV444;
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+		return RK_COLOR_FMT_YUV420;
+	}
+
+	return -EINVAL;
+}
+
 static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 {
 	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
@@ -131,29 +158,83 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 		hdmi->ctrl_ops->enc_init(hdmi, to_rockchip_crtc_state(crtc->state));
 }
 
+/**
+ * dw_hdmi_qp_rockchip_get_vop_format - get the bus format VOP should output
+ * @encoder: pointer to a &struct drm_encoder
+ * @conn_state: pointer to the current atomic &struct drm_connector_state
+ *
+ * Determines which bus format the Rockchip video processor should output as
+ * to feed into the bridge chain.
+ *
+ * Returns a MEDIA_BUS_FMT_* on success, or negative errno on error.
+ */
+static int dw_hdmi_qp_rockchip_get_vop_format(struct drm_encoder *encoder,
+					      struct drm_connector_state *conn_state)
+{
+	struct drm_bridge *bridge __free(drm_bridge_put) = NULL;
+	struct drm_bridge_state *bstate;
+
+	bridge = drm_bridge_chain_get_first_bridge(encoder);
+	if (!bridge)
+		return -ENODEV;
+
+	bstate = drm_atomic_get_bridge_state(conn_state->state, bridge);
+	if (IS_ERR(bstate))
+		return PTR_ERR(bstate);
+
+	if (bstate->input_bus_cfg.format != MEDIA_BUS_FMT_FIXED)
+		return bstate->input_bus_cfg.format;
+
+	return bstate->output_bus_cfg.format;
+}
+
 static int
 dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_crtc_state *crtc_state,
 					 struct drm_connector_state *conn_state)
 {
-	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
+	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
 	union phy_configure_opts phy_cfg = {};
+	int ingest_fmt;
 	int ret;
 
+	ingest_fmt = dw_hdmi_qp_rockchip_get_vop_format(encoder, conn_state);
+	if (ingest_fmt < 0)
+		return -EINVAL;
+
 	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate &&
-	    s->output_bpc == conn_state->hdmi.output_bpc)
+	    s->output_bpc == conn_state->hdmi.output_bpc &&
+	    s->bus_format == ingest_fmt)
 		return 0;
 
+	switch (ingest_fmt) {
+	case MEDIA_BUS_FMT_RGB888_1X24:
+	case MEDIA_BUS_FMT_RGB101010_1X30:
+	case MEDIA_BUS_FMT_YUV8_1X24:
+	case MEDIA_BUS_FMT_YUV10_1X30:
+		s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
+		break;
+	case MEDIA_BUS_FMT_UYVY8_1X16:
+		s->output_mode = ROCKCHIP_OUT_MODE_YUV422;
+		break;
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+		s->output_mode = ROCKCHIP_OUT_MODE_YUV420;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	phy_cfg.hdmi.tmds_char_rate = conn_state->hdmi.tmds_char_rate;
 	phy_cfg.hdmi.bpc = conn_state->hdmi.output_bpc;
 
 	ret = phy_configure(hdmi->phy, &phy_cfg);
 	if (!ret) {
 		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
-		s->output_mode = ROCKCHIP_OUT_MODE_AAAA;
 		s->output_type = DRM_MODE_CONNECTOR_HDMIA;
 		s->output_bpc = conn_state->hdmi.output_bpc;
+		s->bus_format = ingest_fmt;
 	} else {
 		dev_err(hdmi->dev, "Failed to configure phy: %d\n", ret);
 	}
@@ -383,6 +464,7 @@ static void dw_hdmi_qp_rk3588_io_init(struct rockchip_hdmi_qp *hdmi)
 static void dw_hdmi_qp_rk3576_enc_init(struct rockchip_hdmi_qp *hdmi,
 				       struct rockchip_crtc_state *state)
 {
+	int color = dw_hdmi_qp_rockchip_bus_fmt_to_reg(state->bus_format);
 	u32 val;
 
 	if (state->output_bpc == 10)
@@ -390,12 +472,16 @@ static void dw_hdmi_qp_rk3576_enc_init(struct rockchip_hdmi_qp *hdmi,
 	else
 		val = FIELD_PREP_WM16(RK3576_COLOR_DEPTH_MASK, RK3576_8BPC);
 
+	if (likely(color >= 0))
+		val |= FIELD_PREP_WM16(RK3576_COLOR_FORMAT_MASK, color);
+
 	regmap_write(hdmi->vo_regmap, RK3576_VO0_GRF_SOC_CON8, val);
 }
 
 static void dw_hdmi_qp_rk3588_enc_init(struct rockchip_hdmi_qp *hdmi,
 				       struct rockchip_crtc_state *state)
 {
+	int color = dw_hdmi_qp_rockchip_bus_fmt_to_reg(state->bus_format);
 	u32 val;
 
 	if (state->output_bpc == 10)
@@ -403,6 +489,9 @@ static void dw_hdmi_qp_rk3588_enc_init(struct rockchip_hdmi_qp *hdmi,
 	else
 		val = FIELD_PREP_WM16(RK3588_COLOR_DEPTH_MASK, RK3588_8BPC);
 
+	if (likely(color >= 0))
+		val |= FIELD_PREP_WM16(RK3588_COLOR_FORMAT_MASK, color);
+
 	regmap_write(hdmi->vo_regmap,
 		     hdmi->port_id ? RK3588_GRF_VO1_CON6 : RK3588_GRF_VO1_CON3,
 		     val);

-- 
2.54.0

