Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C847C79FBD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 17:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B89BE10E556;
	Wed,  9 Sep 2026 17:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NUVPRal7";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202DA10E557
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 17:36:12 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b4ba7fe26so2339925e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788975370; x=1789580170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GcSEJLSb+KPAcWrzfd13cySwpnusQrnIcgjvZmkYhdY=;
 b=NUVPRal7UEW6/spynYrwt+j82/yz1qN1BO4NGXXHiM/YDcvEG4HeUAoOU7HJD4ND1S
 VuGaONQY7prRV/0vgDjOSfcx5o0OaI80fxUH8x+I8bmnKO19ne/9oRBBGd5u4HhgcRJ4
 ox1GvDcBYYjGsFX54juDYYio7md1oyzkq0ntI1oZz/cjsCLRlF0o/th4QgjTeHFRYcjw
 5GCnoxMoP/fOVy0Nojak5QzPpV0krRjvzuJPXTkYiIuu17qsmNFBdmB6VkvTgL5fF4zO
 TrkOKXqhNYIGhm3F95oWIG09U/GnbFoyZO/soOta7pi7nm4RtAzHPmyKY5LGkGsfRMX+
 MdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788975370; x=1789580170;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GcSEJLSb+KPAcWrzfd13cySwpnusQrnIcgjvZmkYhdY=;
 b=ExlLzGawJ6Jg/yuLl/EVg8zcjeUelRoPp3x7/BBSw6QdT6iVRhkZsudXjCuf1LM81C
 0Wk3cXXMTmHo9zN/CSuW/X91mFxkc2oTXhcIGRzX8L89y+6PsUWGHV6CiimL5vOXiKBH
 BJQ9CJrSa9+WC9JdtZiOfxepgFa6z2agV77UZyRPbJiBbA6uuD7gU6Ped13YwXMz868C
 sMNV3IOQ7iMF/nSEjUJTH1DHA3r5V3kI1Gb020/hO/rix2pgVwVrlkOpNGgC027JJyot
 4zKl+FMrHp7zX1ABfJMzQ7ql2yfZ3t8yTCAXO/UyTV1dhL5DbOWIO2GOx+Fu13/cXPkP
 HkoQ==
X-Gm-Message-State: AFuF++kk5AmLK3/ZVMtBJO5KdwKzgCibrxnfdTzxcPwGMxLLjCQble93
 Nh8Mn8hE/eoBXwo1vlC6AsCLVJYUzNqyyPrj8YaRk8OiegnBZYs88FdkvlEtsu18
X-Gm-Gg: AYBFou2K0k5P0c7pNhHAAmSEPmutgs0SwzDEmvzqZtqCbG4l2Xc3qbChUQd4auoed3u
 1wQRJQ+PlJeBMq2rt4af4Ljxjk6h2zISxS3gC81927SoeaiqDGHM05S/VDxEH2gyWyQZqcSWgSM
 a0wYdBZTgG/HMebcQD1Zwv0ABG+4JX1sYbRrd8AhhqYdLPcUJVRrktYIxNsO2ylXZsMikY70jIP
 2RG0y8pQ76ZcUZkuVlqFy6LLJUZ5JOhqAtmBbjxNeewLiq6vycb8uaS8+odns4KGBz4SnSiw4xY
 wmVReUwtE0m9frOfI9+OwK14YFjXw0IggalfF29YPSp3ZrIhxiydqGpC1jLvH22gcIuViaohFRO
 79oC6M5WkcPW3UHtdZSDYHwPsE5y0Wo+dVjLAFcq9tYv9qyRub8RHFaG8coqcu9RB/S2AYo3RUq
 v+JGqeiVAHTbRLnC/7BtUcr5i6MSc9lVh+uRrNVtCxjSYkjB6Ww6kkxuVGjxchy19ApY3gAgbGI
 63clQMeRq7oajU45JBz4HVxwbhJryq5F3w9YU1WsD53qkfO4Wy+jedg9dqb/3xTPyQViqblZope
 yvo=
X-Received: by 2002:a05:600c:35cb:b0:49d:1da4:511b with SMTP id
 5b1f17b1804b1-49d1da4515bmr96595615e9.1.1788975370286; 
 Wed, 09 Sep 2026 10:36:10 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B836900B0110705BF092680.dsl.pool.telekom.hu.
 [2001:4c4e:1b83:6900:b011:705:bf09:2680])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c06f04sm6876575e9.13.2026.09.09.10.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 10:36:09 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Igor Paunovic <royalnet026@gmail.com>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
 Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville Syrjala <ville.syrjala@linux.intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH v2 1/3] drm/dp: Add drm_dp_hdr_metadata_infoframe_sdp_pack()
Date: Wed,  9 Sep 2026 19:35:38 +0200
Message-ID: <20260909173542.14030-2-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909163206.36409-1-royalnet026@gmail.com>
References: <20260909163206.36409-1-royalnet026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

i915 packs HDR static metadata into an HDR Metadata InfoFrame SDP
(DP 1.4a spec, Table 2-100 and Table 2-101) with a driver-private
helper, intel_dp_hdr_metadata_infoframe_sdp_pack(). Nothing in it is
i915 specific: it converts a generic struct hdmi_drm_infoframe into a
generic struct dp_sdp.

Move it to drm_dp_helper.c as drm_dp_hdr_metadata_infoframe_sdp_pack(),
next to drm_dp_vsc_sdp_pack(), and convert i915 to the new helper. The
Synopsys DesignWare DisplayPort bridge driver (dw-dp) needs to send the
same SDP to support HDR and should not have to duplicate the packing
code.

The helper takes a struct drm_device pointer in place of the i915
display pointer for its two debug messages, and an i915-specific
comment about GEN11+ GMP register sizes is dropped. No functional
change.

Assisted-by: LLM checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 88 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c | 84 +----------------------
 include/drm/display/drm_dp_helper.h     |  4 ++
 3 files changed, 95 insertions(+), 81 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index e623ccb4c1d8a..7b80937255fe0 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -25,6 +25,7 @@
 #include <linux/dynamic_debug.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
@@ -3672,6 +3673,93 @@ ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
 }
 EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
 
+/**
+ * drm_dp_hdr_metadata_infoframe_sdp_pack() - pack HDR Metadata InfoFrame SDP
+ * @dev: DRM device
+ * @drm_infoframe: HDMI DRM infoframe carrying the HDR static metadata
+ * @sdp: valid handle to the generic dp_sdp which will be packed
+ * @size: valid size of the passed sdp handle
+ *
+ * Pack a CTA-861 Dynamic Range and Mastering infoframe into an HDR
+ * Metadata InfoFrame SDP, as defined in DP 1.4a spec, Table 2-100 and
+ * Table 2-101.
+ *
+ * Returns: length of sdp on success and error code on failure
+ */
+ssize_t drm_dp_hdr_metadata_infoframe_sdp_pack(struct drm_device *dev,
+					       const struct hdmi_drm_infoframe *drm_infoframe,
+					       struct dp_sdp *sdp,
+					       size_t size)
+{
+	size_t length = sizeof(struct dp_sdp);
+	const int infoframe_size = HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE;
+	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
+	ssize_t len;
+
+	if (size < length)
+		return -ENOSPC;
+
+	memset(sdp, 0, size);
+
+	len = hdmi_drm_infoframe_pack_only(drm_infoframe, buf, sizeof(buf));
+	if (len < 0) {
+		drm_dbg_kms(dev,
+			    "buffer size is smaller than hdr metadata infoframe\n");
+		return -ENOSPC;
+	}
+
+	if (len != infoframe_size) {
+		drm_dbg_kms(dev, "wrong static hdr metadata size\n");
+		return -ENOSPC;
+	}
+
+	/*
+	 * Set up the infoframe sdp packet for HDR static metadata.
+	 * Prepare VSC Header for SU as per DP 1.4a spec,
+	 * Table 2-100 and Table 2-101
+	 */
+
+	/* Secondary-Data Packet ID, 00h for non-Audio INFOFRAME */
+	sdp->sdp_header.HB0 = 0;
+	/*
+	 * Packet Type 80h + Non-audio INFOFRAME Type value
+	 * HDMI_INFOFRAME_TYPE_DRM: 0x87
+	 * - 80h + Non-audio INFOFRAME Type value
+	 * - InfoFrame Type: 0x07
+	 *    [CTA-861-G Table-42 Dynamic Range and Mastering InfoFrame]
+	 */
+	sdp->sdp_header.HB1 = drm_infoframe->type;
+	/*
+	 * Least Significant Eight Bits of (Data Byte Count – 1)
+	 * infoframe_size - 1
+	 */
+	sdp->sdp_header.HB2 = 0x1D;
+	/* INFOFRAME SDP Version Number */
+	sdp->sdp_header.HB3 = (0x13 << 2);
+	/* CTA Header Byte 2 (INFOFRAME Version Number) */
+	sdp->db[0] = drm_infoframe->version;
+	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
+	sdp->db[1] = drm_infoframe->length;
+	/*
+	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
+	 * HDMI_INFOFRAME_HEADER_SIZE
+	 */
+	BUILD_BUG_ON(sizeof(sdp->db) < HDMI_DRM_INFOFRAME_SIZE + 2);
+	memcpy(&sdp->db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
+	       HDMI_DRM_INFOFRAME_SIZE);
+
+	/*
+	 * Size of DP infoframe sdp packet for HDR static metadata consists of
+	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
+	 * - Two Data Blocks: 2 bytes
+	 *    CTA Header Byte2 (INFOFRAME Version Number)
+	 *    CTA Header Byte3 (Length of INFOFRAME)
+	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
+	 */
+	return sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE;
+}
+EXPORT_SYMBOL(drm_dp_hdr_metadata_infoframe_sdp_pack);
+
 /**
  * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
  * @dpcd: DisplayPort configuration data
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 113d767e62e9c..d0d3f517df85a 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -5189,84 +5189,6 @@ static ssize_t intel_dp_as_sdp_pack(const struct drm_dp_as_sdp *as_sdp,
 	return length;
 }
 
-static ssize_t
-intel_dp_hdr_metadata_infoframe_sdp_pack(struct intel_display *display,
-					 const struct hdmi_drm_infoframe *drm_infoframe,
-					 struct dp_sdp *sdp,
-					 size_t size)
-{
-	size_t length = sizeof(struct dp_sdp);
-	const int infoframe_size = HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE;
-	unsigned char buf[HDMI_INFOFRAME_HEADER_SIZE + HDMI_DRM_INFOFRAME_SIZE];
-	ssize_t len;
-
-	if (size < length)
-		return -ENOSPC;
-
-	memset(sdp, 0, size);
-
-	len = hdmi_drm_infoframe_pack_only(drm_infoframe, buf, sizeof(buf));
-	if (len < 0) {
-		drm_dbg_kms(display->drm,
-			    "buffer size is smaller than hdr metadata infoframe\n");
-		return -ENOSPC;
-	}
-
-	if (len != infoframe_size) {
-		drm_dbg_kms(display->drm, "wrong static hdr metadata size\n");
-		return -ENOSPC;
-	}
-
-	/*
-	 * Set up the infoframe sdp packet for HDR static metadata.
-	 * Prepare VSC Header for SU as per DP 1.4a spec,
-	 * Table 2-100 and Table 2-101
-	 */
-
-	/* Secondary-Data Packet ID, 00h for non-Audio INFOFRAME */
-	sdp->sdp_header.HB0 = 0;
-	/*
-	 * Packet Type 80h + Non-audio INFOFRAME Type value
-	 * HDMI_INFOFRAME_TYPE_DRM: 0x87
-	 * - 80h + Non-audio INFOFRAME Type value
-	 * - InfoFrame Type: 0x07
-	 *    [CTA-861-G Table-42 Dynamic Range and Mastering InfoFrame]
-	 */
-	sdp->sdp_header.HB1 = drm_infoframe->type;
-	/*
-	 * Least Significant Eight Bits of (Data Byte Count – 1)
-	 * infoframe_size - 1
-	 */
-	sdp->sdp_header.HB2 = 0x1D;
-	/* INFOFRAME SDP Version Number */
-	sdp->sdp_header.HB3 = (0x13 << 2);
-	/* CTA Header Byte 2 (INFOFRAME Version Number) */
-	sdp->db[0] = drm_infoframe->version;
-	/* CTA Header Byte 3 (Length of INFOFRAME): HDMI_DRM_INFOFRAME_SIZE */
-	sdp->db[1] = drm_infoframe->length;
-	/*
-	 * Copy HDMI_DRM_INFOFRAME_SIZE size from a buffer after
-	 * HDMI_INFOFRAME_HEADER_SIZE
-	 */
-	BUILD_BUG_ON(sizeof(sdp->db) < HDMI_DRM_INFOFRAME_SIZE + 2);
-	memcpy(&sdp->db[2], &buf[HDMI_INFOFRAME_HEADER_SIZE],
-	       HDMI_DRM_INFOFRAME_SIZE);
-
-	/*
-	 * Size of DP infoframe sdp packet for HDR static metadata consists of
-	 * - DP SDP Header(struct dp_sdp_header): 4 bytes
-	 * - Two Data Blocks: 2 bytes
-	 *    CTA Header Byte2 (INFOFRAME Version Number)
-	 *    CTA Header Byte3 (Length of INFOFRAME)
-	 * - HDMI_DRM_INFOFRAME_SIZE: 26 bytes
-	 *
-	 * Prior to GEN11's GMP register size is identical to DP HDR static metadata
-	 * infoframe size. But GEN11+ has larger than that size, write_infoframe
-	 * will pad rest of the size.
-	 */
-	return sizeof(struct dp_sdp_header) + 2 + HDMI_DRM_INFOFRAME_SIZE;
-}
-
 static void intel_write_dp_sdp(struct intel_encoder *encoder,
 			       const struct intel_crtc_state *crtc_state,
 			       unsigned int type)
@@ -5285,9 +5207,9 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
 		len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp);
 		break;
 	case HDMI_PACKET_TYPE_GAMUT_METADATA:
-		len = intel_dp_hdr_metadata_infoframe_sdp_pack(display,
-							       &crtc_state->infoframes.drm.drm,
-							       &sdp, sizeof(sdp));
+		len = drm_dp_hdr_metadata_infoframe_sdp_pack(display->drm,
+							     &crtc_state->infoframes.drm.drm,
+							     &sdp, sizeof(sdp));
 		break;
 	case DP_SDP_ADAPTIVE_SYNC:
 		len = intel_dp_as_sdp_pack(&crtc_state->infoframes.as_sdp, &sdp,
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index 5b05a7fbe174a..3e3f119775b38 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -32,6 +32,7 @@
 struct drm_device;
 struct drm_dp_aux;
 struct drm_panel;
+struct hdmi_drm_infoframe;
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
@@ -1035,6 +1036,9 @@ int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
 int drm_dp_max_dprx_data_rate(int max_link_rate, int max_lanes);
 
 ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc, struct dp_sdp *sdp);
+ssize_t drm_dp_hdr_metadata_infoframe_sdp_pack(struct drm_device *dev,
+					       const struct hdmi_drm_infoframe *drm_infoframe,
+					       struct dp_sdp *sdp, size_t size);
 int drm_dp_link_symbol_cycles(int lane_count, int pixels, int dsc_slice_count,
 			      int bpp_x16, int symbol_size, bool is_mst);
 
-- 
2.43.0

