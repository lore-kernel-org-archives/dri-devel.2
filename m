Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852C606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YS0tumsx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F226610FF47;
	Thu, 12 Nov 2026 10:12:18 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0612210FF47
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:12:13 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-33c10faf6easo195400eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794478332; x=1795083132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=84BQ33dM6skqqhDQ13P+I0fpvb0Yjhxvcrb4mjU58j8=;
 b=YS0tumsxN7lZtwjtVOLFH+rHtKSCOyS9iD4BQwT7ZrBfsfyjR95lbTkSLisv/D/nR4
 XCHYnSFb1FJw82JaJIM4N3bJiE64lpxBGe/khaMl5pKDyGk3d2+khdrqSYEtt5e+o085
 gJi/QT1ybdik4wV+0aELgZg3LTaZ7JvxsexyzB9eNFBk0e8mU5rcw9WgBviHIc3XZrKc
 eV+bK3oJ1c0vRWnE6SS4IJaxYvx3JVr1ZRjkPVHjeNXpWS47gKfr1MqB3uDzWnPfc//r
 2K5kMFQoeGgCuzDnw9/FSWx+ZxPr3W84II2+Ep5aIQcbcUGv0ldB/IsgDOxr1pcVqRd/
 oIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478332; x=1795083132;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=84BQ33dM6skqqhDQ13P+I0fpvb0Yjhxvcrb4mjU58j8=;
 b=M0xndPfE5A42WfA3HSmli1kvPXouOQ0RywNXmaepAagPglH+YrvMUh6C4NufOeet78
 sH7pB1avmrVTMQN7jPhuk714XHY76oQQ96Y/jzicE1EVHklWcBGByJulSUmPEOQLdLY7
 /8ctJ3wlynEg/APM7tGGxJjb/ffWroVwqacL8cAfK/8wYmgmZIKyI51qxK4KyQH2Qcrs
 ZimKoBdm41OBlsmyZATmt6aWcVZcnG3BXbaiyViLbmgRdwg2bwx4s0ZBoi80WL8qEVoy
 3BQJzdtZFzxTlh5vj8+FCXGgDRHpcmau+MoTTy42Tc/PrPQ3NOjTYuO/Bs+pN+h4pE6z
 pxfg==
X-Gm-Message-State: APuU4Z/UCfMpyPBLF+9tn6M4r8hxxi8vgimLEm/0SGN0iPNT5tfDWLW1
 KxUnwja3uEMErlOUqt+VZ02yHX80P/RKHvJJE7dFSPEEco0tdxMbpB+H
X-Gm-Gg: AYBFou0RQgDxgiL6PQkOv6wU+Wl5Ue5IdQbCGPluD6DP8XkHrdZB9in/XMZNAzNFg1L
 yjKyViKXYXNPGYlnJswYtsTfzLuzA/YNTSdcPZ/jUk8gTEolKCy4Is8b8lj20mCabEljjDROOnL
 2cr5+ecbHP3lKqzcl0eMS7O6KVq/wqTh4jhbxqbGPS3UPZBXoibnI5xTspF+Pb/6tcLsOc7jv6j
 w2wcGRkIWPKGPGTVvo7BtYuW3OtJF00yjmYC+Vi1CcDCAcTM0a4AFJObMD6dHzNJ5bs1GJpmxfD
 2S+ZykkKQ7KzoDMaTQB0KGsdz3aOCk3vJzoyWJny+R9DoInGCrYbPcjX6be8LoVL2E8jG5w8SXd
 w8Uu/GvA/b5nm3p77zaYV0xkzJEvpGT5YlQnVx74OzpKAZpqVOUFMA9Q/xRp2P1bdidURsL6ysC
 M6rOQkHsfQcPvXKBZYHZgbAISRXKHbJhvC0qtsGpZkni0AAXD1JNr0fB6QonUJKppbxZxMTT6OQ
 ZDvyXbsK2IGa0fdSbsiFIk0nSYl4ZPWTJzOiWKHwfceEt8u8GNV3WD8n5WIz82M9aKeSVqp4rA9
 xqrv0Co5KURGyfTEISa8hgpxNxBwqyk/4HnM/3KtuXY=
X-Received: by 2002:a05:7300:fa13:b0:372:c0ee:875b with SMTP id
 5a478bee46e88-3767ff8b6abmr7665742eec.0.1794478332061; 
 Thu, 12 Nov 2026 02:12:12 -0800 (PST)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3751fe32276sm23223806eec.8.2026.11.12.02.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:12:11 -0800 (PST)
From: Frank Zhang <rmxpzlb@gmail.com>
To: hjc@rock-chips.com, heiko@sntech.de, andyshrk@163.com,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, royalnet026@gmail.com, me@timsurber.de
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v7] drm/bridge: dw-hdmi-qp: serialize HDMI audio callbacks
 with PHY enable/disable
Date: Thu, 12 Nov 2026 18:11:55 +0800
Message-ID: <20261112101155.47777-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following panic was observed during system reboot, it can also be
triggered by the following sequences:

- Disable the HDMI drm display, open and close the HDMI PCM device.
- Enable the HDMI drm display and start audio stream on the HDMI PCM
  device, then switch the HDMI drm display to disable, stop and close
  audio stream.

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

Tested-by: Igor Paunovic <royalnet026@gmail.com> # Orange Pi 5 Plus (RK3588)
Tested-by: Tim Surber <me@timsurber.de> # FriendlyElec CM3588 NAS (RK3588)
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
- Update panic stack on 7.0.5.
- Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/

Changes in v5:
- Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
  tmds_char_rate guard in new callback function.
- Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/

Changes in v6:
- Add mutex and state to serialize HDMI audio callbacks with the PHY enable/disable.
- Link to v5: https://lore.kernel.org/all/20260908070220.41574-1-rmxpzlb@gmail.com/

Changes in v7:
- Update commit message, add more triggering sequences.
- Rebase patch to mainline v7.4-rc2, clean up the connector reference in
  phy init fail path.
- Link to v6: https://lore.kernel.org/lkml/20260915103433.13163-1-rmxpzlb@gmail.com/

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 62835485d66a..ef5ccf0f609c 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -76,6 +76,8 @@ struct dw_hdmi_qp {
 	struct {
 		const struct dw_hdmi_qp_phy_ops *ops;
 		void *data;
+		struct mutex lock;
+		bool enabled;
 	} phy;
 
 	unsigned long ref_clk_rate;
@@ -262,6 +264,10 @@ static int dw_hdmi_qp_audio_enable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return -EOPNOTSUPP;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_mod(hdmi, 0, AVP_DATAPATH_PACKET_AUDIO_SWDISABLE, GLOBAL_SWDISABLE);
 
@@ -275,13 +281,23 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 	bool ref2stream = false;
+	int ret = 0;
+
+	mutex_lock(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled) {
+		ret = -EOPNOTSUPP;
+		goto err_res;
+	}
 
-	if (!hdmi->tmds_char_rate)
-		return -ENODEV;
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
@@ -290,9 +306,13 @@ static int dw_hdmi_qp_audio_prepare(struct drm_bridge *bridge,
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
@@ -321,6 +341,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
 
 	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 
+	guard(mutex)(&hdmi->phy.lock);
+	if (!hdmi->phy.enabled)
+		return;
+
 	if (hdmi->tmds_char_rate)
 		dw_hdmi_qp_audio_disable_regs(hdmi);
 }
@@ -551,6 +575,7 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (WARN_ON(!conn_state))
 		return;
 
+	mutex_lock(&hdmi->phy.lock);
 	if (connector->display_info.is_hdmi) {
 		op_mode = 0;
 		hdmi->tmds_char_rate = conn_state->hdmi.tmds_char_rate;
@@ -572,10 +597,25 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 	scoped_guard(mutex, &hdmi->mutex)
 		hdmi->curr_conn = connector;
 
-	hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	ret = hdmi->phy.ops->init(hdmi, hdmi->phy.data);
+	if (unlikely(ret)) {
+		dev_err(hdmi->dev, "failed to initialize PHY: %d\n", ret);
+		scoped_guard(mutex, &hdmi->mutex) {
+			drm_connector_put(hdmi->curr_conn);
+			hdmi->curr_conn = NULL;
+		}
+
+		hdmi->phy.enabled = false;
+		hdmi->tmds_char_rate = 0;
+
+		mutex_unlock(&hdmi->phy.lock);
+		return;
+	}
+	hdmi->phy.enabled = true;
 
 	dw_hdmi_qp_mod(hdmi, HDCP2_BYPASS, HDCP2_BYPASS, HDCP2LOGIC_CONFIG0);
 	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
+	mutex_unlock(&hdmi->phy.lock);
 
 	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
 }
@@ -593,12 +633,14 @@ static void dw_hdmi_qp_bridge_atomic_disable(struct drm_bridge *bridge,
 		}
 	}
 
+	guard(mutex)(&hdmi->phy.lock);
 	hdmi->tmds_char_rate = 0;
 
 	connector = drm_atomic_get_old_connector_for_encoder(state, bridge->encoder);
 	drm_connector_hdmi_disable_scrambling(connector);
 
 	hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
+	hdmi->phy.enabled = false;
 }
 
 static enum drm_connector_status
@@ -689,10 +731,8 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
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
@@ -702,6 +742,17 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
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
@@ -796,7 +847,11 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
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
@@ -1129,6 +1184,8 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 
 	hdmi->phy.ops = plat_data->phy_ops;
 	hdmi->phy.data = plat_data->phy_data;
+	hdmi->phy.enabled = false;
+	mutex_init(&hdmi->phy.lock);
 
 	if (plat_data->ref_clk_rate) {
 		hdmi->ref_clk_rate = plat_data->ref_clk_rate;
-- 
2.56.1

