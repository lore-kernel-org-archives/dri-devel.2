Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346BCC98308
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E6210EE9B;
	Tue, 22 Sep 2026 21:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="uZXhky/m";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B47210EE8A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=rv58KOm2LYY98+tznbuSyxqW2xnPNxt4/e0afQY3Ffk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=uZXhky/mRjyaWEdL6Gw5hSH+zzA30TRcdrwSTyxMvahykdt6VebN3ixgoL/uHVyt7A+KPhrj020lV5NwaWZfwRZRID4N5xrs7KY5iHL8QlU/+CsCf37jrw3cFnb79HOW0iAFjuncGIkwacbEjg1iFb2kBj0oNxaEww4McP9YZXOSo9AQzGg555BgMW+R3dwufVMDSRhSB7H4u4OEH5505/P5JQtca3Pdf4nqHTPO/EP5u212vQSXxt/B5mzJ+ft7+M6gO2sR3+phgNGr5oVUa5Cp6TafT5MDT0VfAi9w6tpbuO0QiopasuoWbBraYRrH4T1IKvL4qCrWOvvJpp/7lg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=mOcvsz3uqySWnAffG5bj29ig3LAnU6p1wrD3PW5iQLJ=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=VkjGRQOFsO9po7w/hYNhBYx+XP9QzJylOoJRwWNskfq6feA/uBaWDqTL9lojDUzJJsVom0q2y7koZSs7ADKMLJE9nbPcTI1R3T7Z2d/pRD7vDEnUSkug3JN3vKkJ7ZklwkNm3q3aJdLfjnOGZpVwsyyrNlFrK4edbJN4HwIM3jLRdIvu2OIEqp56yvN708k5I9YyaKZ0dua+eclnwGCGRuUYxa+EFfU6GUZFZ2xqvFi0Ij/Zl2gMMWlD2eoKC5aZtT6O8mjIQWH+/LUEpTztEsIhVaadm792IrGLVu5kqlpcvlprdvMDcDtXOi1ewk9KGrqiQZPQ3I3kmxvffO27WQ==
X-YMail-OSG: vMSX0gcVM1nGGHJh1UtRepqZ.sxnAoKZJKpRL2wKMCGgyv3SnGx5RynW1Nk_QYQ
 GydDcLlPWuHVVDpSGNSQAw7PN5CTwrA_8iD66jSYwav5vksa7EmXptjJrRU.Uywfc7Nv_Syucop7
 Nr5OBSMChm5q3JPPwsHu5tql6t3ItIvu.tFWUAP1CcRaC4xUc1Dig8DQ0ygdTzAn5SesSgagxFqy
 XdVHoyrwkAfXgp5SivQWivFLAZ..FiLfglaynqfyQiV9ImzLg01aId_MQbCrJ5716dvA9EZAS1D7
 YmHHyrPuZZQwdZ_M7ERgxAcgXzFgM.SmhA85.7rVgnBB2SJ1neP.XL1ubuZAh2oPBzKzu3GTGam6
 kR_HpxZ4jjAVb8lGbhkYOcD.e4vPLMBwmmU9JEHPqzifB9IKgU7hwnouvC1W_cI_fgQgtWHGYiwv
 VwU8bg2yLnrWW97gjWaA50ii6KGsXwb4BGB4H5r5XlQ2o8J6VgvzPb2DirX5si53HbHe3AmbE3ex
 Dh_MUR6lJfeTJ7r0NQRRBepeUVIFW0XBFHck2uKgpaut7npG0dXGh2sEO3CuhUavY5sY7Asym1sq
 KYxaCSV9TB_caORxB4KocEBwV.h44KsuAJ11yhWKw.ICohz4P7hVgKKpCOo8DXl4v52BHSIACo0K
 O_i7NB.PGwIsZ6r9YJP.FUO6fefwoM4k5CstrcKHHpQDEtzB7U2kwS4NOt5ejkF.aAdd7_xc0_Mn
 JH0RkC3msLahLhxSh3Q_c4mqM2._za1z7H8ppp3DL5F1ws3mi5EioDlniG0ntyMwRPRfj61U99Eu
 FP9OxLKVvacFgbVTfK5Ll6uEBva2bdL6y2WzDEY918m7ElqTBwm0uiVtDAuifmOHMsqfyzxuBzlk
 yRUKQKjqIw0IAseavlD3zvVYopwW3AWNFPBk.qidz3nrwM.L.Y4yPU38Zha3D8GdLTv1AhF5ME0n
 JeBbx1.MPhrcKXQrUhWjlBzUjeXhGdPPY5Rat1MQtsUKOx8uuSk.NW_RUro7qXEAGoYpA8QbJpY5
 zA8JS7PvPNnVv7n53LLaO1qso.AKMccGXej689l8FhtPdQvgdtpyO3m6NgOslqoKMrdmN0ZkfK6K
 wqzjzucKZ6QimQArmhmjIZSE9T33qEsIH.INNEwPTdVlcVafSTs541gYWEKhOW7Sp.An2YSEQLi2
 uzLWnhrXZ0eInfLtsSQXBB3OM2_QKy1nWPdfyeil1KjXWyyQy8Y8bGqXza.m5YFK1HRbIO9XZkbP
 E0gm978fPFmxY1OdiIDDvaUqhs7ATRYjdWLhniPwgj4B5_5Lf5ETDf3Rs0KXgXryEFzwlBzXekWj
 GhNmeJgK.YDiP29twJYG85MAPjCMhRSQ.BxT8mEfdiEG7KlPcGwboLdEgMNJb44YeLT.A.0AaXvR
 jJXtoOJ9FlS7pavkOCjLETY3GPNkBB4_bDuoaXbc9Q3VbaWne8TwzJeUsazNZT_vgOicrSQ2pUuV
 xEVBQP_qTjJGv0Q0khnLWpYNAlF075rd_QKdPtJ4I2qFrGWqhLAzTV3cuqs6DqbtMeLgBi2LCSkF
 FofudFVcF2e9lIpRuXrQSduJEEyywADYGb4OQpbQBdswIKQN8xmWcrQwpnCbsB1CRp5kU9sczFfB
 EjysTgNIGlwAHhtThtXWrIRK_VwPCXle0HMA_MTwyOI_C3ORa5TqrWcgQoi5BvwZKEK_NCVHHF6H
 aYOycA.1R_XF_RfYWWx_Xft74VQkql89UPpafRKdIsSQVW.qV.kfyXoHBUURS0f3XQjVBtQw39TT
 FGtutQwNOvnBMbhe1pUacEB1HY11hTczscojy1wO9eV1Uu5hbI9F9gXCk2d5bUY985qON3RDyiU5
 wJ1rKOMIRuRzNivDqKBPcnX4n_czq1Hz.K6j3_CCzh4..Q6HHTJK75j_G.RTU30vcF7h.ZMeZ525
 Xjsi4T_8Yy2bC24Btzq_KVkOBKdBVYN_M8HlrYX4UQeJet99KSNqzhc321K30dbr5bIP8lxqX0X8
 12El__hWU1w9i0asyy6zdkJ6GhYi8Lig-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 345e600a-78dc-4a63-88ba-06e370ec161d
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 21:53:55 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:48 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 4/6] drm/nouveau: add HDMI YCbCr 4:4:4 and 4:2:2 output
Date: Tue, 22 Sep 2026 18:53:34 -0300
Message-ID: <20260922215336.612239-5-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
References: <20260922215336.612239-1-Capitain_Jack@yahoo.com>
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

Attach the "color format" connector property to HDMI connectors on heads
with an output CSC (Turing to Ada), offering RGB, YCbCr 4:4:4 and YCbCr
4:2:2, and select the pixel encoding together with the link depth.

The selection follows drm_hdmi_state_helper.c: RGB and 4:4:4 need the
sink's Deep Color bits for the chosen depth (4:4:4 through DC_Y444),
4:2:2 needs none but is limited to 12 bpc, and the TMDS character rate
comes from drm_hdmi_compute_mode_clock(), which carries 4:2:2 at the
8-bpc rate.  "Automatic" keeps RGB.  An explicit YCbCr request is either
honoured at the deepest depth that fits, or the commit is rejected.

YCbCr output is limited range.  Its colorimetry follows the CTA-861
default, BT.709 above 576 active lines and BT.601 otherwise, and the
head's output CSC applies the matching matrix.  The AVI InfoFrame now
declares the pixel encoding, that colorimetry and limited YCC range.
4:2:2 uses the 16/20/24-bpp 4:2:2 pixel depths and leaves the GCP colour
depth at its default, as HDMI 1.3 section 6.5 carries up to 12 bpc 4:2:2
in the 24-bit container; 4:4:4 uses the same GCP encodings as RGB.  The
SCDC scrambling threshold uses the same character rate.

The head pixel depth mapping in headc57d_or() becomes the offset it
always was between the NV837D SOR codes and the head codes, which also
covers the 4:2:2 depths.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/atom.h     |  11 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 228 +++++++++++++++-----
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  25 +--
 drivers/gpu/drm/nouveau/nouveau_connector.c |  13 +-
 4 files changed, 203 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/atom.h b/drivers/gpu/drm/nouveau/dispnv50/atom.h
index 64be784be335..f85e80eb8f8e 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/atom.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/atom.h
@@ -16,6 +16,14 @@ struct nv50_atom {
 
 #define nv50_head_atom(p) container_of((p), struct nv50_head_atom, state)
 
+/* Output colour space, numbered as every class's HEAD_SET_PROCAMP_COLOR_SPACE. */
+enum nv50_head_colorspace {
+	NV50_HEAD_COLORSPACE_RGB = 0,
+	NV50_HEAD_COLORSPACE_YUV_601 = 1,
+	NV50_HEAD_COLORSPACE_YUV_709 = 2,
+	NV50_HEAD_COLORSPACE_YUV_2020 = 3,
+};
+
 struct nv50_head_atom {
 	struct drm_crtc_state state;
 
@@ -112,7 +120,7 @@ struct nv50_head_atom {
 			u16 cos:12;
 			u16 sin:12;
 		} sat;
-		u8 colorspace:2;	/* HEAD_SET_PROCAMP_COLOR_SPACE */
+		u8 colorspace:2;	/* enum nv50_head_colorspace */
 		bool limited:1;		/* limited quantization range */
 	} procamp;
 
@@ -122,6 +130,7 @@ struct nv50_head_atom {
 		u8 depth:4;
 		u8 crc_raster:2;
 		u8 bpc;
+		u8 format;	/* enum drm_output_color_format */
 	} or;
 
 	struct nv50_crc_atom crc;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 54ed903644bf..ad8952dfcd71 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -35,6 +35,7 @@
 #include <linux/iopoll.h>
 
 #include <drm/display/drm_dp_helper.h>
+#include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_scdc_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -395,7 +396,67 @@ nv50_outp_has_output_csc(struct drm_encoder *encoder)
 	return oclass >= TU102_DISP && oclass < GB202_DISP;
 }
 
-static void
+/* Sink support for an HDMI colour format at a given depth, following
+ * drm_hdmi_state_helper.c, with 16 bpc accepted where the sink declares it.
+ */
+static bool
+nv50_hdmi_sink_supports(const struct drm_display_info *info,
+			const struct drm_display_mode *mode,
+			enum drm_output_color_format fmt, unsigned int bpc)
+{
+	u8 dc_modes;
+
+	if (drm_mode_is_420_only(info, mode) && fmt != DRM_OUTPUT_COLOR_FORMAT_YCBCR420)
+		return false;
+
+	switch (fmt) {
+	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
+		dc_modes = info->edid_hdmi_rgb444_dc_modes;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+		if (!(info->color_formats & BIT(fmt)))
+			return false;
+		dc_modes = info->edid_hdmi_ycbcr444_dc_modes;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+		/* HDMI 1.3 section 6.5: Deep Color does not apply to 4:2:2,
+		 * which carries up to 12 bpc in the 24-bit container.
+		 */
+		return (info->color_formats & BIT(fmt)) && bpc <= 12;
+	default:
+		return false;
+	}
+
+	switch (bpc) {
+	case 8:
+		return true;
+	case 10:
+		return dc_modes & DRM_EDID_HDMI_DC_30;
+	case 12:
+		return dc_modes & DRM_EDID_HDMI_DC_36;
+	case 16:
+		return dc_modes & DRM_EDID_HDMI_DC_48;
+	default:
+		return false;
+	}
+}
+
+/* TMDS character rate in Hz, as drm_hdmi_compute_mode_clock() but on the
+ * link's pixel clock.
+ */
+static unsigned long long
+nv50_hdmi_char_rate(const struct drm_display_mode *mode, unsigned int bpc,
+		    enum drm_output_color_format fmt)
+{
+	unsigned long long rate = drm_hdmi_compute_mode_clock(mode, bpc, fmt);
+
+	if (nv50_outp_link_clock(mode) != mode->clock)
+		rate *= 2; /* frame packing */
+
+	return rate;
+}
+
+static int
 nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state,
 			   struct drm_connector_state *conn_state)
 {
@@ -421,35 +482,62 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 			asyh->or.bpc -= 2;
 		}
 		break;
-	case DCB_OUTPUT_TMDS:
-		if (!connector->display_info.is_hdmi)
+	case DCB_OUTPUT_TMDS: {
+		const struct drm_display_info *info = &connector->display_info;
+		enum drm_output_color_format fmt = DRM_OUTPUT_COLOR_FORMAT_RGB444;
+		unsigned int bpc;
+
+		if (!info->is_hdmi)
 			break;
 
+		switch (drm_connector_get_color_format(conn_state)) {
+		case DRM_CONNECTOR_COLOR_FORMAT_YCBCR444:
+			fmt = DRM_OUTPUT_COLOR_FORMAT_YCBCR444;
+			break;
+		case DRM_CONNECTOR_COLOR_FORMAT_YCBCR422:
+			fmt = DRM_OUTPUT_COLOR_FORMAT_YCBCR422;
+			break;
+		default:
+			break;
+		}
+
+		/* Deepest depth the sink declares for the format, the user
+		 * allows and the TMDS link carries.
+		 */
 		max_rate = nouveau_connector_get_tmds_link_bandwidth(connector);
-		asyh->or.bpc = 8;
+		for (bpc = 16; bpc >= 8; bpc -= 2) {
+			unsigned long long rate;
 
-		if (conn_state->max_requested_bpc >= 16 &&
-		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_48) {
-			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 16, 8);
-			if (mode_rate <= max_rate)
-				asyh->or.bpc = 16;
-		}
+			if (bpc > conn_state->max_requested_bpc ||
+			    !nv50_hdmi_sink_supports(info, mode, fmt, bpc))
+				continue;
 
-		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 12 &&
-		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36) {
-			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 12, 8);
-			if (mode_rate <= max_rate)
-				asyh->or.bpc = 12;
+			rate = nv50_hdmi_char_rate(mode, bpc, fmt);
+			if (rate && rate <= max_rate * 1000ULL)
+				break;
 		}
 
-		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 10 &&
-		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30) {
-			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 10, 8);
-			if (mode_rate <= max_rate)
-				asyh->or.bpc = 10;
+		if (bpc < 8) {
+			/* An explicit format request is honoured or refused. */
+			if (fmt != DRM_OUTPUT_COLOR_FORMAT_RGB444)
+				return -EINVAL;
+			bpc = 8;
 		}
 
-		conn_state->max_bpc = asyh->or.bpc;
+		asyh->or.bpc = bpc;
+		asyh->or.format = fmt;
+		conn_state->max_bpc = bpc;
+
+		if (fmt != DRM_OUTPUT_COLOR_FORMAT_RGB444) {
+			/* YCbCr is limited range; CTA-861 colorimetry
+			 * defaults to BT.709 above 576 lines, BT.601 below.
+			 */
+			asyh->procamp.colorspace = mode->vdisplay > 576 ?
+						   NV50_HEAD_COLORSPACE_YUV_709 :
+						   NV50_HEAD_COLORSPACE_YUV_601;
+			asyh->procamp.limited = true;
+			break;
+		}
 
 		/* Broadcast RGB, as in drm_hdmi_state_helper.c: automatic
 		 * selects limited range for CE video formats.
@@ -460,9 +548,12 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 		      drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED)))
 			asyh->procamp.limited = true;
 		break;
+	}
 	default:
 		break;
 	}
+
+	return 0;
 }
 
 static int
@@ -482,14 +573,12 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
 
 	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		asyh->or.bpc = connector->display_info.bpc;
-		asyh->procamp.colorspace = 0; /* RGB */
+		asyh->procamp.colorspace = NV50_HEAD_COLORSPACE_RGB;
 		asyh->procamp.limited = false;
 	}
 
 	/* We might have to reduce the bpc */
-	nv50_outp_atomic_fix_depth(encoder, crtc_state, conn_state);
-
-	return 0;
+	return nv50_outp_atomic_fix_depth(encoder, crtc_state, conn_state);
 }
 
 struct nouveau_connector *
@@ -845,6 +934,7 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 		 struct drm_display_mode *mode, bool hda, struct nv50_head_atom *asyh)
 {
 	const u8 bpc = asyh->or.bpc;
+	const enum drm_output_color_format fmt = asyh->or.format;
 	struct nouveau_drm *drm = nouveau_drm(encoder->dev);
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
@@ -868,8 +958,13 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	 * 48-bpp groups contain one pixel, so PP is always 4 (zero);
 	 * 36-bpp groups contain two pixels and 30-bpp groups four, so PP
 	 * follows the pixel count of the final group.
+	 *
+	 * YCbCr 4:2:2 carries up to 12 bpc in the 24-bit container at the
+	 * pixel clock and declares no colour depth (HDMI 1.3 section 6.5).
 	 */
-	if (bpc == 16) {
+	if (fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR422) {
+		/* default GCP */
+	} else if (bpc == 16) {
 		gcp_cd = 7;
 	} else if (bpc == 12 || bpc == 10) {
 		const u32 pixels = mode->crtc_hdisplay +
@@ -885,12 +980,13 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	}
 
 	if (nv_encoder->i2c && hdmi->scdc.scrambling.supported) {
-		/* Deep Colour raises the TMDS character rate above the pixel
-		 * clock; the HDMI 2.0 340 MHz scrambling and clock-ratio
+		/* Deep Colour and the pixel encoding set the TMDS character
+		 * rate; the HDMI 2.0 340 MHz scrambling and clock-ratio
 		 * thresholds apply to the character rate.
 		 */
-		const u32 tmds_char_clock = nv50_outp_link_clock(mode) * bpc / 8;
-		const bool high_tmds_clock_ratio = tmds_char_clock > 340000;
+		const unsigned long long tmds_char_rate =
+			nv50_hdmi_char_rate(mode, bpc, fmt);
+		const bool high_tmds_clock_ratio = tmds_char_rate > 340000000ULL;
 		u8 scdc;
 
 		ret = drm_scdc_readb(nv_encoder->i2c, SCDC_TMDS_CONFIG, &scdc);
@@ -922,10 +1018,22 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	args->head = nv_crtc->index;
 
 	if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, &nv_connector->base, mode)) {
-		drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, &nv_connector->base, mode,
-						   asyh->procamp.limited ?
-						   HDMI_QUANTIZATION_RANGE_LIMITED :
-						   HDMI_QUANTIZATION_RANGE_FULL);
+		struct hdmi_avi_infoframe *avi = &infoframe.avi;
+
+		if (fmt == DRM_OUTPUT_COLOR_FORMAT_RGB444) {
+			drm_hdmi_avi_infoframe_quant_range(avi, &nv_connector->base, mode,
+							   asyh->procamp.limited ?
+							   HDMI_QUANTIZATION_RANGE_LIMITED :
+							   HDMI_QUANTIZATION_RANGE_FULL);
+		} else {
+			/* Declare the matrix the head's output CSC applies. */
+			avi->colorspace = fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR422 ?
+					  HDMI_COLORSPACE_YUV422 : HDMI_COLORSPACE_YUV444;
+			avi->colorimetry = asyh->procamp.colorspace ==
+					   NV50_HEAD_COLORSPACE_YUV_709 ?
+					   HDMI_COLORIMETRY_ITU_709 : HDMI_COLORIMETRY_ITU_601;
+			avi->ycc_quantization_range = HDMI_YCC_QUANTIZATION_RANGE_LIMITED;
+		}
 
 		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
 	} else {
@@ -1873,25 +1981,39 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 	switch (nv_encoder->dcb->type) {
 	case DCB_OUTPUT_TMDS:
-		switch (asyh->or.bpc) {
-		case 16:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_48_444;
-			break;
-		case 12:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_36_444;
-			break;
-		case 10:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_30_444;
-			break;
-		case 8:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_24_444;
-			break;
-		case 6:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_18_444;
-			break;
-		default:
-			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_DEFAULT;
-			break;
+		if (asyh->or.format == DRM_OUTPUT_COLOR_FORMAT_YCBCR422) {
+			switch (asyh->or.bpc) {
+			case 12:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_24_422;
+				break;
+			case 10:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_20_422;
+				break;
+			default:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_16_422;
+				break;
+			}
+		} else {
+			switch (asyh->or.bpc) {
+			case 16:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_48_444;
+				break;
+			case 12:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_36_444;
+				break;
+			case 10:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_30_444;
+				break;
+			case 8:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_24_444;
+				break;
+			case 6:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_18_444;
+				break;
+			default:
+				depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_DEFAULT;
+				break;
+			}
 		}
 
 		if (disp->disp->object.oclass != NV50_DISP &&
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index 9b5c02c86fc9..937f71f264db 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -48,25 +48,14 @@ headc57d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 	u8 depth;
 	int ret;
 
-	/*XXX: This is a dirty hack until OR depth handling is
-	 *     improved later for deep colour etc.
+	/* or.depth holds an NV837D SOR_SET_CONTROL_PIXEL_DEPTH code: those
+	 * number the same depths one higher, with 0 meaning the default.
 	 */
-	switch (asyh->or.depth) {
-	case 9:
-		depth = 8;
-		break;
-	case 8:
-		depth = 7;
-		break;
-	case 6: depth = 5; break;
-	case 5: depth = 4; break;
-	case 2: depth = 1; break;
-	case 0:	depth = 4; break;
-	default:
-		depth = asyh->or.depth;
-		WARN_ON(1);
-		break;
-	}
+	if (asyh->or.depth)
+		depth = asyh->or.depth - 1;
+	else
+		depth = NVC57D_HEAD_SET_CONTROL_OUTPUT_RESOURCE_PIXEL_DEPTH_BPP_24_444;
+	WARN_ON(depth > NVC57D_HEAD_SET_CONTROL_OUTPUT_RESOURCE_PIXEL_DEPTH_BPP_48_444);
 
 	if ((ret = PUSH_WAIT(push, 2)))
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 748c2f29d5d1..2a9782d6c382 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -301,10 +301,19 @@ nouveau_conn_attach_properties(struct drm_connector *connector)
 	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
-		/* Only heads with an output CSC can emit limited range. */
+		/* Only heads with an output CSC can emit limited range
+		 * or YCbCr.
+		 */
 		if (disp->disp.object.oclass >= TU102_DISP &&
-		    disp->disp.object.oclass < GB202_DISP)
+		    disp->disp.object.oclass < GB202_DISP) {
+			const unsigned long formats =
+				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
+				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
+				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
+
 			drm_connector_attach_broadcast_rgb_property(connector);
+			drm_connector_attach_color_format_property(connector, formats);
+		}
 	}
 
 	/* Add overscan compensation options to digital outputs. */
-- 
2.53.0

