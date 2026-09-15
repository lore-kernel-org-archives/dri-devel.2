Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4008AC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1CB10F3E1;
	Tue, 15 Sep 2026 10:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K1to65bB";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E936810F3D7
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:35:04 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d6ff23d82eso5054175ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 03:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789468504; x=1790073304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1ct/p5G8yFAnha3FVWj3nnL27FNsWn5+Pk7HzweSOSA=;
 b=K1to65bBImRMrAcENmcyHvsEdttW7nqTB1BSN/dX8PyFRexdZAbWhLziyD5qP7yFUW
 kftL06eUbiPRUfMi7pcRYixTs/oKYllFzUPp9zlwa+OfTFOtxC+ZhuXD7ahTQwheP8zU
 vzK7e5D8bK54m4ED5Dxp4b1RHcajXjy0xj/oSfLHcTkw2c7vK6x19GJOu5wQqweYhYH9
 hkINjUt+muVdeL+vMX7T5idR5fL2npsftfDFbsj9l8HZSx/jUeOTWC0e4K4K0VCFWsE8
 FuwPE7cZeE+0+fm/B7/4lOjrZNtq3f7qEVR8EXSFeaTfPS/UaTSjVYmy+IRxL9h/TA0F
 6aMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789468504; x=1790073304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1ct/p5G8yFAnha3FVWj3nnL27FNsWn5+Pk7HzweSOSA=;
 b=e3ffEaWh7qP10G/NqQVMPd7Knq7FIYgQJE3yz+/GkKcrzA3qwVkFui2P2fYhNRnzMO
 PrDf7qb4v02dZbsFNOrbeE1pRx/A66A7Hfn+2B477cifBPz1IKe/Tc+0BlaAKqQUz+I8
 O+h9cUr3PE93zjbFOoRwncXLfKnRLalFifdSlHvBuv6Uwf9n312PKlaOt2OeVPoPjhd3
 RmiXiAxt0Ng5CeL2XR/iiscETCQx2IqiVFAaWnzEpYLFjhOzVvUFpGcKe3T8TNkeMFnx
 nm58bmTq8KZgDC/neH1RKr9edOqD3uokh6mYVzr85/KIpvXsoj1PohQibndxSakSCbpl
 2WWA==
X-Gm-Message-State: AFuF++l5TPG9AAxUuTRcMhQkRur16UK2RpNBwHkdH39UDXkP1LC2bV3k
 zHeVH5UxGVTInmZHahjQbtQWdAJj1ekeA7Zh62T50ij46Py1Ey3gZotp
X-Gm-Gg: AYBFou0yRh9ODjropiACuRDJ/6FTm/YwgHnGqFmUmnGNxPIxYZQKvx8exhcNkScJ7aZ
 cTxw4nUokJdVmfgm26ffjFxMeXm49TANVkfmEJt0Xurmp2S8ZmLNo6x8bfnuUoXlh1G5DX3z74X
 07Yncj/LzpCepHgjdToId8/RHqE0zmozUQyQVIztpKEAXdwYnAbNyF1/kjzhwNxfvSB2VNHhdcJ
 ea74Y5mYH/w/FGkLDqXiNn9A7DwMulY/QA8PNud8Sdk5LoGi/9tJQgH9u9ZrVchHC11WHN5kJ+9
 4pP5IPrXLkvZWqssSwDJJxKzT2k9oH5TZVY4+iruFk1GHQPfi2lrS0+Wd30L9bsTTNQ9es27nRb
 K4dq9bPnCG+NCELykmP/RK71lK1RN1WWjgy2vWNizp4346VKEXdH3JPni4LtVRCWckBWFJQcQ54
 JfI5ZPcwH+Pbm+cGJpW1sjePyhXN9g8dsQf5w05oMfthKUG7iTg249r4O3uWxYvamRRDntqwMlm
 KCikieCpiaGhBWAkN7jXjDw
X-Received: by 2002:a17:903:b0e:b0:2d6:3c1a:85ef with SMTP id
 d9443c01a7336-2dd6c848391mr95107925ad.4.1789468504342; 
 Tue, 15 Sep 2026 03:35:04 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cca6b8asm64721195ad.5.2026.09.15.03.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:35:03 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: royalnet026@gmail.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, andrzej.hajda@intel.com, luca.ceresoli@bootlin.com,
 cristian.ciocaltea@collabora.com, daniels@collabora.com,
 detlev.casanova@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, sebastian.reichel@collabora.com,
 macromorgan@hotmail.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v6] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
Date: Tue, 15 Sep 2026 18:34:33 +0800
Message-ID: <20260915103433.13163-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
Call trace:
 ...
 regmap_update_bits_base+0x70/0xa8
 dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
 drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
 snd_pcm_release+0x4c/0xc0 [snd_pcm]
 ...

The crash occurs when HDMI audio callbacks access registers after DRM
atomic framework disabled the PHY.

The root cause is a race condition exists between ALSA and DRM atomic
framework. During a modeset disable sequence, the DRM path disables the
PHY, while ALSA may still execute HDMI audio callbacks such as
audio_shutdown(), leading to accessing registers while the PHY is down
and eventually a kernel panic.

Fix this by introducing a mutex lock and PHY enabled state to serialize
PHY state transitions and HDMI audio callbacks. This ensures that HDMI
audio callbacks can only access registers while the PHY is enabled.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

Changes in v3:
- Add a tmds_char_rate guard in clear_audio_infoframe path.
- Decouple write_audio_infoframe from clear_audio_infoframe.
- Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
- Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/

Changes in v4:
- Update panic stack on 7.0.5
- Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/

Changes in v5:
- Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
  tmds_char_rate guard in new callback function.
- Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/

Changes in v6:
- Add mutex and state to serialize HDMI audio callbacks with the PHY enable/disable
- Link to v5: https://lore.kernel.org/all/20260908070220.41574-1-rmxpzlb@gmail.com/

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 1c214a8e6dc2..a4789050a09e 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -159,6 +159,8 @@ struct dw_hdmi_qp {
 	struct {
 		const struct dw_hdmi_qp_phy_ops *ops;
 		void *data;
+		struct mutex lock;
+		bool enabled;
 	} phy;
 
 	unsigned long ref_clk_rate;
@@ -467,6 +469,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return -EOPNOTSUPP;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
 
@@ -480,13 +486,23 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 	bool ref2stream = false;
+	int ret = 0;
 
-	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
+	mutex_lock(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled) {
+		ret = -EOPNOTSUPP;
+		goto err_res;
+	}
+
+	if (!hdmi->tmds_char_rate) {
+		ret = -ENODEV;
+		goto err_res;
+	}
 
 	if (fmt->bit_clk_provider | fmt->frame_clk_provider) {
 		dev_err(hdmi->dev, "unsupported clock settings\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_res;
 	}
 
 	if (fmt->bit_fmt == SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE)
@@ -495,9 +511,13 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 	dw_hdmi_qp_set_audio_interface(hdmi, fmt, hparms);
 	dw_hdmi_qp_set_sample_rate(hdmi, hdmi->tmds_char_rate, hparms->sample_rate);
 	dw_hdmi_qp_set_channel_status(hdmi, hparms->iec.status, ref2stream);
-	drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector, &hparms->cea);
+	mutex_unlock(&hdmi->phy.lock);
 
-	return 0;
+	return drm_atomic_helper_connector_hdmi_update_audio_infoframe(connector, &hparms->cea);
+
+err_res:
+	mutex_unlock(&hdmi->phy.lock);
+	return ret;
 }
 
 static void dw_hdmi_qp_audio_disable_regs(struct dw_hdmi_qp *hdmi)
@@ -526,6 +546,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
 
 	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_audio_disable_regs(hdmi);
 }
@@ -754,6 +778,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	struct drm_connector_state *conn_state;
 	struct drm_connector *connector;
 	unsigned int op_mode;
+	int ret;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	if (WARN_ON(!connector))
@@ -763,6 +788,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (WARN_ON(!conn_state))
 		return;
 
+	mutex_lock(&hdmi->phy.lock);
 	if (connector->display_info.is_hdmi) {
 		dev_dbg(hdmi->dev, "%s mode=HDMI %s rate=%llu bpc=%u\n", __func__,
 			drm_hdmi_connector_get_output_format_name(conn_state->hdmi.output_format),
@@ -774,10 +800,19 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 		op_mode = OPMODE_DVI;
 	}
 
-	hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	if (unlikely(ret)) {
+		dev_err(hdmi->dev, "failed to initialize PHY: %d\n", ret);
+		hdmi->phy.enabled = false;
+		hdmi->tmds_char_rate = 0;
+		mutex_unlock(&hdmi->phy.lock);
+		return;
+	}
+	hdmi->phy.enabled = true;
 
 	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
 	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
+	mutex_unlock(&hdmi->phy.lock);
 
 	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 }
@@ -787,9 +822,10 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
+	guard(mutex)(&hdmi->phy.lock);
 	hdmi->tmds_char_rate = 0;
-
 	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
+	hdmi->phy.enabled = false;
 }
 
 static enum drm_connector_status
@@ -880,10 +916,8 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
-static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+static int dw_hdmi_qp_clear_audio_infoframe_regs(struct dw_hdmi_qp *hdmi)
 {
-	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-
 	dw_hdmi_qp_mod(hdmi, 0,
 		       PKTSCHED_ACR_TX_EN |
 		       PKTSCHED_AUDS_TX_EN |
@@ -893,6 +927,17 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return 0;
+
+	return dw_hdmi_qp_clear_audio_infoframe_regs(hdmi);
+}
+
 static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
 				 size_t start, size_t len, unsigned int reg)
 {
@@ -987,7 +1032,11 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return -EOPNOTSUPP;
+
+	dw_hdmi_qp_clear_audio_infoframe_regs(hdmi);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
@@ -1299,6 +1348,8 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 
 	hdmi->phy.ops = plat_data->phy_ops;
 	hdmi->phy.data = plat_data->phy_data;
+	hdmi->phy.enabled = false;
+	mutex_init(&hdmi->phy.lock);
 
 	if (plat_data->ref_clk_rate) {
 		hdmi->ref_clk_rate = plat_data->ref_clk_rate;
-- 
2.55.0

