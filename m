Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AA1C5AD2B
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB4310E4AE;
	Sat,  8 Aug 2026 09:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WqCsnuOU";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD03710E4B0
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 09:58:28 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47df6a5655aso40661f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 02:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786183107; x=1786787907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eukZ4Yw0lPupGVKUZsE6QR5EVi6K7EEsCGMJTKxA3Qg=;
 b=WqCsnuOU4cErmObY4cputhhf0tPZjewneS7e6xouL4Xj4uRV+0PFrCfo/ZLnl3VmBj
 5LIqs7mH64anylpng6kUdsB5pxesbRm4uVQYbRbApCuDleKfZz+my5IBoAo8RwiBSP8b
 kUx/qBjqIeM0IfML0CTZEf9dKzJRWrBusur9fRq7x1+eGmCj1Ez284GLKlbDAi4Qw4K3
 sLaUjdZNftuxUP6sq/Yzot1nTAUmWuC2HW1Uw5MZIQqS60NFHR2k+zebuhuHi7XCjID+
 I7sV7kSYJLAELImbQ3mYPM0N3VmzRyBDFYYi5Kdos2P3lJZXKItXBOSYRVRsNrVdts8G
 6/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786183107; x=1786787907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eukZ4Yw0lPupGVKUZsE6QR5EVi6K7EEsCGMJTKxA3Qg=;
 b=B0AmQsCD+JRhE8ylVUt9nV5YqOD6zBuR24kWPvNKSSfBd1Bv2x1AhyzrXU3nfZnm6f
 Oa5vjjUI1I4aoM8HNFRXOqKiAd9htEZQuaVbwzIoOfoZTHbWB2t+w1UfFExOAsHpnrl+
 PkjWDsDBLoxvjJ1XuxH6SA9ghqgKVLVu8+26oX4Hu9YCnu4OszYK+MIWGYwPHdAJtecq
 mPTEa2bWk6MnrsBZjIdawjAUW1H/qaxy0ozPRqoWUW3bHw347XD4bffbwAdpp0+OURER
 NRLoM5Q5IlQorqJrf+hfnBgkkPDFm0aiOh+y+8QGpgUBFU5+hdk+AVxXGhNApCyQIlj9
 pllw==
X-Gm-Message-State: AOJu0YzmnmAiPkuMNK4YXT3pmRgBumvKj3Tz5Tyln9ulIcajJYFhZvEc
 n94BHQxPhceUMi9TyWcoj+ba22TjE1M1N/EKfCmexn3GHG+1aT7Da8mDenill2kx
X-Gm-Gg: AR+sD10eocxM8KL762QHA1J2hNoejRTn+3Kx4fHoFW2aNRpgF57zXOFynR+bmqvNnGS
 YPxhEdU8a/tydSynmzTAUMVpIZCm7daOQDRRb9BBMQW8JgubwQGIPwUeeC6tShBESSPckF7gdTy
 w9bEF2gp7swfBmc2f7Aj5iH7EJxui3LPk3FTfxE7Iz34qc+QXuQUt3oVDXIUMeJB3iL0PVhs+WJ
 SgMO81Hkk21pJrGmoS3F1xB7XCylszB3v9/en2HFx9Efme6yB7k7iNRp4m+r65BYTbZ/J91M6Mi
 q+vB92fTDmZg5SZemtX0rlZ1aNBN7OrnO3wi/73EA4VvUUvrFW/ShUNADJTq2Wm+3ZVRr3ykYF4
 cbMQmICDB/KOtSkS/34QgreLDH51hFzKWz3HLmKgkC9CRVqMNJk8o51hJ0eKS13r9XHtQ18Gvic
 qv6j1hI932BFWk6c7czUT9Sf0IbmgMjrMmS0WutN84M1w9gJNY0YdLTJrrkfmJiboTHz5UMwZuY
 5LSMdmyg8B81po2h+wA0zPy2zbm6If9DIjg1FUjyuLqelzIOSvvZUg3qrZAnTtVoHo2o5FFPTIO
 Xzeppg==
X-Received: by 2002:a5d:584c:0:b0:47f:959f:d5e with SMTP id
 ffacd0b85a97d-47fec487b60mr22022705f8f.0.1786183107204; 
 Sat, 08 Aug 2026 02:58:27 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B8E20009911270F4BEC2300.dsl.pool.telekom.hu.
 [2001:4c4e:1b8e:2000:9911:270f:4bec:2300])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm13255725f8f.0.2026.08.08.02.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:58:26 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 5/5] drm/bridge: synopsys: dw-dp: Add BT.2020 colorimetry
 support
Date: Sat,  8 Aug 2026 11:57:24 +0200
Message-ID: <20260808095749.9428-6-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808095749.9428-1-royalnet026@gmail.com>
References: <20260808095749.9428-1-royalnet026@gmail.com>
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

The VSC SDP colorimetry is hardcoded: DEFAULT for RGB output and
BT709_YCC for YCbCr. HDR compositors render into a BT.2020 container
and need a way to tell the sink.

The legacy MSA MISC0 colorimetry bits cannot express BT.2020; DP 1.4a
requires the VSC SDP revision 5 pixel encoding/colorimetry format
indication, with MISC1 bit 6 set so the sink takes the format from the
VSC SDP instead of MISC0. The driver already sets MISC1 bit 6 whenever
it sends the VSC SDP, so only the trigger and the colorimetry values
need extending:

- store conn_state->colorspace in the bridge state during
  atomic_check(), next to the negotiated format;
- send the VSC SDP also when the colorspace is BT2020_RGB or
  BT2020_YCC, not only for YCbCr 4:2:0 output;
- map BT2020_RGB/BT2020_YCC to DP_COLORIMETRY_BT2020_RGB/
  DP_COLORIMETRY_BT2020_YCC in the VSC SDP; every other colorspace
  value keeps today's values. The dynamic range stays VESA for RGB and
  CTA for YCbCr output.

Sinks advertise VSC SDP colorimetry support in the DPCD
(DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED). Without it BT.2020 cannot
be signaled at all, so atomic_check() rejects such a request with
-EINVAL and userspace's TEST_ONLY probe learns the configuration is
impossible; i915 instead silently omits the VSC SDP and scans out
BT.2020 pixels without signaling them. A colorspace change on a live
stream forces a modeset, so the VSC SDP is regenerated with the new
colorimetry.

On the Rockchip side, create the DP Colorspace property with exactly
the enum values the driver implements (Default, BT2020_RGB,
BT2020_YCC). When the colorspace is BT.2020 and the negotiated bus
format is YCbCr, program s->color_space = V4L2_COLORSPACE_BT2020 so
the VOP2 uses its BT.2020 R'G'B' to Y'C'bC'r matrix for the CSC. For
RGB output the pixels leave the VOP2 unconverted and the color space
stays DEFAULT.

Userspace that leaves the property at "Default" sees no change in
behavior: the colorimetry mapping, the VSC SDP trigger and the VOP2
CSC selection all take the previous paths.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c   | 44 +++++++++++++++++++----
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c | 38 +++++++++++++++++++-
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index ca997ea53e66..8f0ee9628dcc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -306,6 +306,7 @@ struct dw_dp_bridge_state {
 	u8 color_format;
 	u8 bpc;
 	u8 bpp;
+	enum drm_colorspace colorspace;
 };
 
 struct dw_dp_sdp {
@@ -1125,6 +1126,12 @@ static void dw_dp_clear_sdp(struct dw_dp *dp, int nr)
 		clear_bit(nr, dp->sdp_reg_bank);
 }
 
+static bool dw_dp_colorspace_is_bt2020(enum drm_colorspace colorspace)
+{
+	return colorspace == DRM_MODE_COLORIMETRY_BT2020_RGB ||
+	       colorspace == DRM_MODE_COLORIMETRY_BT2020_YCC;
+}
+
 static int dw_dp_send_vsc_sdp(struct dw_dp *dp)
 {
 	struct dw_dp_bridge_state *state;
@@ -1160,13 +1167,25 @@ static int dw_dp_send_vsc_sdp(struct dw_dp *dp)
 		break;
 	}
 
-	if (state->color_format == DRM_OUTPUT_COLOR_FORMAT_RGB444) {
-		vsc.colorimetry = DP_COLORIMETRY_DEFAULT;
+	switch (state->colorspace) {
+	case DRM_MODE_COLORIMETRY_BT2020_RGB:
+		vsc.colorimetry = DP_COLORIMETRY_BT2020_RGB;
+		break;
+	case DRM_MODE_COLORIMETRY_BT2020_YCC:
+		vsc.colorimetry = DP_COLORIMETRY_BT2020_YCC;
+		break;
+	default:
+		if (state->color_format == DRM_OUTPUT_COLOR_FORMAT_RGB444)
+			vsc.colorimetry = DP_COLORIMETRY_DEFAULT;
+		else
+			vsc.colorimetry = DP_COLORIMETRY_BT709_YCC;
+		break;
+	}
+
+	if (state->color_format == DRM_OUTPUT_COLOR_FORMAT_RGB444)
 		vsc.dynamic_range = DP_DYNAMIC_RANGE_VESA;
-	} else {
-		vsc.colorimetry = DP_COLORIMETRY_BT709_YCC;
+	else
 		vsc.dynamic_range = DP_DYNAMIC_RANGE_CTA;
-	}
 
 	drm_dp_vsc_sdp_pack(&vsc, &sdp.base);
 
@@ -1227,7 +1246,7 @@ static bool dw_dp_video_need_vsc_sdp(struct dw_dp *dp)
 	if (state->color_format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
 		return true;
 
-	return false;
+	return dw_dp_colorspace_is_bt2020(state->colorspace);
 }
 
 static int dw_dp_video_set_msa(struct dw_dp *dp,
@@ -1644,10 +1663,21 @@ static int dw_dp_bridge_atomic_check(struct drm_bridge *bridge,
 	state->color_format = fmt->color_format;
 	state->bpc = fmt->bpc;
 	state->bpp = fmt->bpp;
+	state->colorspace = conn_state->colorspace;
+
+	/*
+	 * BT.2020 cannot be signaled through the legacy MSA MISC0
+	 * colorimetry bits; it requires the VSC SDP colorimetry format
+	 * indication, which the sink must support.
+	 */
+	if (dw_dp_colorspace_is_bt2020(conn_state->colorspace) &&
+	    !dp->link.vsc_sdp_supported)
+		return -EINVAL;
 
 	old_conn_state = drm_atomic_get_old_connector_state(conn_state->state,
 							    conn_state->connector);
-	if (!drm_connector_atomic_hdr_metadata_equal(old_conn_state, conn_state))
+	if (!drm_connector_atomic_hdr_metadata_equal(old_conn_state, conn_state) ||
+	    old_conn_state->colorspace != conn_state->colorspace)
 		crtc_state->mode_changed = true;
 
 	if ((adjusted_mode->hsync_start - adjusted_mode->hdisplay) & 0x1) {
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index c5bc178c0a50..798d82893f98 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -69,6 +69,21 @@ static void dw_dp_rockchip_hpd_sw_cfg(void *data, bool hpd)
 		     FIELD_PREP_WM16(ROCKCHIP_VO_GRF_DP_SINK_HPD_CFG, hpd));
 }
 
+static bool dw_dp_yuv_bus_format(u32 bus_format)
+{
+	switch (bus_format) {
+	case MEDIA_BUS_FMT_UYYVYY10_0_5X30:
+	case MEDIA_BUS_FMT_UYYVYY8_0_5X24:
+	case MEDIA_BUS_FMT_YUYV10_1X20:
+	case MEDIA_BUS_FMT_YUYV8_1X16:
+	case MEDIA_BUS_FMT_YUV10_1X30:
+	case MEDIA_BUS_FMT_YUV8_1X24:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
 				      struct drm_crtc_state *crtc_state,
 				      struct drm_connector_state *conn_state)
@@ -102,7 +117,17 @@ static int dw_dp_encoder_atomic_check(struct drm_encoder *encoder,
 	s->output_type = DRM_MODE_CONNECTOR_DisplayPort;
 	s->bus_format = bus_format;
 	s->bus_flags = di->bus_flags;
-	s->color_space = V4L2_COLORSPACE_DEFAULT;
+
+	/*
+	 * For BT.2020 YCbCr output the VOP2 must use its BT.2020 R'G'B' to
+	 * Y'C'bC'r matrix; BT.2020 RGB is passed through unconverted.
+	 */
+	if ((conn_state->colorspace == DRM_MODE_COLORIMETRY_BT2020_RGB ||
+	     conn_state->colorspace == DRM_MODE_COLORIMETRY_BT2020_YCC) &&
+	    dw_dp_yuv_bus_format(bus_format))
+		s->color_space = V4L2_COLORSPACE_BT2020;
+	else
+		s->color_space = V4L2_COLORSPACE_DEFAULT;
 
 	return 0;
 }
@@ -200,6 +225,17 @@ static int dw_dp_rockchip_bind(struct device *dev, struct device *master, void *
 
 	drm_connector_attach_hdr_output_metadata_property(connector);
 
+	ret = drm_mode_create_dp_colorspace_property(connector,
+						     BIT(DRM_MODE_COLORIMETRY_DEFAULT) |
+						     BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
+						     BIT(DRM_MODE_COLORIMETRY_BT2020_YCC));
+	if (ret) {
+		dw_dp_unbind(dp->base);
+		return ret;
+	}
+
+	drm_connector_attach_colorspace_property(connector);
+
 	return 0;
 }
 
-- 
2.43.0

