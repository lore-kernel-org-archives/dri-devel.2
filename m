Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378A3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQ1qStE5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A73E11294F;
	Fri, 27 Nov 2026 09:56:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C8DC112926
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:55:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 561EE42ABA;
 Fri, 27 Nov 2026 09:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FCD1F000C1;
 Fri, 27 Nov 2026 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773309;
 bh=84gcpPLyA7MExkV84AAhFzUmD9b+mztsv3tH99iXwLY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BQ1qStE5CvuvxJH9p0nZRNIYfKcg/q3syCrmyRbl4EJCBKfjp93ac4uYfWFaX0nx+
 S8uUXHlGeE3NB2ziiO1Df27zy0zZXwUTHHuR5PO51IoXWJeb4sN0YMkIEPcrOM4f9l
 V+jVPVQJ7qQytM/xB5cfEFZi8jchuQkPUO/h7u4znUe+BugixAyiiTjREf+UIiHuDV
 Xog76VFb4MZQUk3JWXmbJS4FgObp1XdASiJFX+fl6rcq/0ZrBOQk9ppv3ju3U86jId
 oXt3GkFPTRW9mVTolycKfz8hRzeSetb+yxqdM8OXMajq16yHSxhDCVLD939VscmjuV
 yLRjjdzKZXkQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:14 +0100
Subject: [PATCH v10 32/36] drm/bridge: sii902x: Implement hw state readout
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-32-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5983; i=mripard@kernel.org;
 h=from:subject:message-id; bh=857PsCNXqQcqY+i7IBehUqtgpkSalLcKxoAAe/XFYTg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwVzdl8WezCvaFh1481P+gdptFx6VFjs7lPmvOqyuc
 JlVlv9Wx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZiI1nLGhkeZGj9riy2cP/7m
 kZfUuuavk/tsdrmzYfzqNXJaC6/3rPTO3dByavon3YzUkIyvAd5sjA1LfvuHFyZO0dd+9zPd6eP
 xN8lrpm71XNe4za7EtPCuzWU71og51hUt+dEapcfuucmxawEA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Implement the hardware state readout for the sii902x bridge
now that all the infrastructure is in place.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 130 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 6eaf70aeb0e3..4fb639e72c7e 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -20,10 +20,12 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/clk.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_readout.h>
+#include <drm/drm_atomic_state_readout_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -535,20 +537,145 @@ sii902x_bridge_mode_valid(struct drm_bridge *bridge,
 		return MODE_CLOCK_HIGH;
 
 	return MODE_OK;
 }
 
+static int
+sii902x_bridge_connector_readout(struct drm_bridge *bridge,
+				 struct drm_atomic_sro_state *state,
+				 struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_crtc_state *crtc_state;
+	struct drm_encoder *encoder;
+	struct drm_crtc *crtc;
+	int ret;
+
+	mutex_lock(&sii902x->mutex);
+
+	ret = regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN);
+	/* I2C error */
+	if (ret < 0)
+		goto err_mutex_unlock;
+	/* Device is powered down, nothing to read out */
+	if (ret)
+		goto out;
+
+	encoder = bridge->encoder;
+	if (!encoder->funcs || !encoder->funcs->atomic_sro_get_current_crtc) {
+		ret = -ENODEV;
+		goto err_mutex_unlock;
+	}
+
+	crtc = encoder->funcs->atomic_sro_get_current_crtc(encoder);
+	if (!crtc) {
+		ret = -ENODEV;
+		goto err_mutex_unlock;
+	}
+
+	crtc_state = drm_atomic_sro_get_crtc_state(state, crtc);
+	if (!crtc_state) {
+		ret = -ENODEV;
+		goto err_mutex_unlock;
+	}
+
+	crtc_state->encoder_mask |= drm_encoder_mask(encoder);
+	crtc_state->connector_mask |= drm_connector_mask(connector);
+
+	/*
+	 * drm_atomic_set_crtc_for_connector() takes a connector reference
+	 * when setting the crtc pointer, which is later released by
+	 * __drm_atomic_helper_connector_destroy_state(). SRO readout
+	 * bypasses that path, so take the reference explicitly.
+	 */
+	drm_connector_get(connector);
+	conn_state->crtc = crtc;
+	conn_state->best_encoder = encoder;
+
+out:
+	mutex_unlock(&sii902x->mutex);
+	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&sii902x->mutex);
+	return ret;
+}
+
+static int sii902x_bridge_readout_state(struct drm_bridge *bridge,
+					struct drm_atomic_sro_state *state,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+	u32 input_format;
+	int ret;
+
+	mutex_lock(&sii902x->mutex);
+
+	ret = regmap_test_bits(sii902x->regmap, SII902X_SYS_CTRL_DATA, SII902X_SYS_CTRL_PWR_DWN);
+	/* I2C error */
+	if (ret < 0)
+		goto err_mutex_unlock;
+	/* Device is powered down, nothing to read out */
+	if (ret)
+		goto out;
+
+	switch (sii902x->bus_width) {
+	case 16:
+		input_format = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		input_format = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	case 24:
+		input_format = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_mutex_unlock;
+	}
+
+	bridge_state->input_bus_cfg.format = input_format;
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	/* The sii902x is a passthrough transmitter, output format equals input. */
+	bridge_state->output_bus_cfg.format = input_format;
+
+	/*
+	 * The output flags are those the next element of the chain
+	 * expects, which aren't available yet during the readout. They
+	 * are the connector display info flags when the elements after
+	 * the transmitter forward them unmodified, as the atomic check
+	 * assumes.
+	 */
+	bridge_state->output_bus_cfg.flags =
+		conn_state->connector->display_info.bus_flags;
+
+out:
+	mutex_unlock(&sii902x->mutex);
+	return 0;
+
+err_mutex_unlock:
+	mutex_unlock(&sii902x->mutex);
+	return ret;
+}
+
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
 	.atomic_disable = sii902x_bridge_atomic_disable,
 	.atomic_enable = sii902x_bridge_atomic_enable,
 	.detect = sii902x_bridge_detect,
 	.edid_read = sii902x_bridge_edid_read,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_sro_compare_state = drm_atomic_helper_bridge_compare_state,
+	.atomic_sro_readout_state = sii902x_bridge_readout_state,
+	.atomic_sro_connector_readout = sii902x_bridge_connector_readout,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
 	.mode_valid = sii902x_bridge_mode_valid,
 };
 
@@ -1139,11 +1266,12 @@ static int sii902x_init(struct sii902x *sii902x)
 	if (ret)
 		goto err_unreg_audio;
 
 	sii902x->bridge.of_node = dev->of_node;
 	sii902x->bridge.timings = &default_sii902x_timings;
-	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
+			      DRM_BRIDGE_OP_CONNECTOR_HW_READOUT;
 	sii902x->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 
 	if (sii902x->i2c->irq > 0)
 		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
 

-- 
2.56.1

