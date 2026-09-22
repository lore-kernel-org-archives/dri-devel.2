Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE962C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5070410EE94;
	Tue, 22 Sep 2026 21:54:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="Q4kgUIoL";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4EB10EE96
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=VqDgXkoM8M05gFM6gqU5UGL9Hb5ZGd8EbqSSUdti/kQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=Q4kgUIoLK6rniVL07wxO+IGJP8FgclvhYjt3pG70+Q/mav/sP+BY5Q9CXunfkT4Wx6jPwbi9GdpjP+nBQgwHqnCvCvhPajWs3GippOYVI/OKsDtc6xWdSGneoy9ivRBDYx4C2N1iQeNjlYZolPFDSjDAXr/4/WC0QXQ39xxQ7v1IPrePK/EbLZpNHI7lNOyyTsyEe3xOFulK4nMlLpgt9wcVQ3KEnWLNbDt11e76Jo11jTRqzOZ51OaRZUEpj4SCP9TuKnwVZA+Kc26b0SlDuJarVv6wdUaHTrB9Mj28etLmXYT2t+/Y6CFf5qC8OZga21J4cYS5h3K/XRb0j91ZVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114035; bh=4PKPFzEAhodNZnZLnfyskZN+PPDWpeb9dVEZzk9ve7n=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=PCHwixI7acG9M0JNqbnDVJhcVT6IenpJGqSGGKmLPmZ9zpINwLcTSooOYtQsqmye7PxAQppb00XmR4d6z2+1vhWiQG8RRPzf3U6FBsDNVYwoRTPZJBduvlP5yFnyDso3c5vW6i1AjZYd+wsIHZrn+dys0Q9hLT0OD9R4RtukdoYlUUZGyiK3sy0cY9qILVIg46spLKNNpgQ8E/fqTYF1wzgFQNUnBd1gkNjvYX1CH9xpyVmp8NW15/HoCaOjD/+k+3wODtLwFnRATr2p9LKYXl6t29kRfjjdao+tz9aoJYAsH6WhHMvxb7uXG2KYXOLp2mitd+ct+/R4ZevXeUwyZg==
X-YMail-OSG: BE_YfrcVM1nRXZA2rg1UtWKe4UqaLDMWUQ6l1ZAu0SJpV.Z9GWuUKP3_FGR9NwL
 96WU6JkREpOGlfIsYJEBEzVHLUeaYdNTuJWqVYWxnlwRtHzP6diHA3_dYhTpKdqPQY6oMbkXutnn
 pUP3NY9rywz9rhgqrdg.76ABg7BIKXKz21qX6f8x6Yy5F8GixVqdMyLeMUapwKBm4ZaH4EzYa2_x
 5B4oqfJp2EXXbvx_4heMFd8gXlNuJJeM2OFUnxMkoria12GnlwDvQAkBynhzYtKk4BVNbCxg7jRu
 kKPeGm6JQG0RAXDCkIZKeTAFJr_1KsSApQxlv5awdbB62RUNUSY.o8ByVmpp_EWBv8aTXjRLXyQ0
 grshqF7KCJ24cJ0TS2lHwknRyiAnrh3_eT_US8v8byJMMbgfZqebqSi6ngpv.RLjzizpI0Apm4Kl
 nnTtBUhLkHBYdoq9BCveVK0Yel6SbUkJp.2u3t14j6QlWhe7TP3283qm8.GA8piAV8a97LjXLe_Q
 WdgyqgeIGXguOGY.vvu84Hdtet.11DtCbGcamHdXrPUL57UMB1WJGTfsHE.ENZb_sDda8Xze5CTh
 bNpuvqv2XcJhRvb_IxJWqnXaSndIcgACrzmbh5Hco2xVBmKu1joTU0wNHLPB9uEOtskayb5Zo2Bm
 T4D9xFpuO2Z92rjQZB1WwMjJcFPwHF4m_I4IJUjFpa_sbAQTFu8vOqdRCg017KZIiVurI28vfSiO
 RaP2ZiscW0cQRRYVr8ZyCXizT2q1N_UWsujLpPBfHGN2vKHnRQxVONsaHNa0QxntbJbvrK21OGvM
 lzyK.d5O32vB1iT_qbf6fM6xAUgYaBOA77KaT9hJ5yrpNkbGE3UJ3T8LiwC45tAmMtSYo.4dGhDo
 8QZodWea3arRHXzM5CGUWxv1dpXQ39OMco9.TDj4Y.buJLzINTNd4dUpKV5qN0VhdAD1aullLkV6
 E7LWomviRIVnC1tpQn6c7Uz1LdhxRsoVMsaXi6GDhL0hcoJei_DicYpHYNDnQhvk.Ccsg6qPLH4B
 GQxVtZQGt22LyqXoIPY5jpxjt3e5DuM.wO1LCCG4bgwABrcC4zhZr5fOMsDHDyYs2tK0ILKWhPER
 QIvA02NXysddiief4XGETQZ0vobyf9X4WRlwrSfUKCk7AzkGrNEYcu7RwLk_Xzo3r1DDDThAYIwz
 S_0Os64aw7QNhuxD6JVS.9FciRCLc7qYYX0UJOdrTMJz0UI1yGfOTsf7for5E5pLhzXQMtRfrbJ7
 IktEFP_Vsge6yBO70djdg8nETMWGVu2wsLVhi6DSscKPaY1Y4toDR25W6myPyzbDJKld3GeELOrc
 yxv59aYSbnylYl2m5o6FWGsEvauV2cWJJxNf6xd2W5c4UKoh9SNnAU.l3XnEjhjsTW5kUhLyIZ3P
 FEKDphlNzrfxjh4rMsLoSRyVTQNCq1aRUErfQh3_CmB6M4CMjGLd9Vjez5bvSf6KwXBCOHTtggn2
 7tDHmTiTugdIPF9Li6cmDlA1VvfTcMpzTktWB3Y4_Wn56IHhY5.j1hOqeDffpCHVQLevKzW3PCdW
 HtQKp6qRUcuIP0o3gQbeHdY.PSf2x7l_CMb59DcHMd3MHGhCwVkVCpWzkea.kJwQsHNzQmr8syRw
 gp2dmJcRSGaKBs_KrsUq87sUSbHHXvtqYrI_e94XvrYL00.lQsZdnRISmvXab2K9zal2_x7znl_y
 jf7TtEqmAUUd9YhMLBKMHBnVzcacHCaDIobF2vtdBW2BeYoBlquD_8Mz.npMivz7FBAu2w_607I1
 H5dt4bh28gD4agnamf7eYW.pQsJspnxB2zv7EcfPyDGCtiKRJ5r0x7hvzZy60LrN5.T._LwP3wr_
 yO9qZ61kTwMiIpq_lVJDVMYAkm9IQBa1uT9zSNxE1SvDV.EoMuMyUUu9Zzlr38.WhqIQUzQwu0ai
 Cf5gg6J32y4YhlLXfzyK3MMS0gYeiMUVpI1qWEAgDxBBsfKg6c6ut8qrWkx.0T7Sh7ZrxdQec_.W
 s0Kd.Kb60l9HsDNB5TalnUBsaxn9VoDDI6Q--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: a2be7161-97b1-454e-b2bf-f85ae85045ca
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 21:53:55 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:51 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 5/6] drm/nouveau: add HDMI YCbCr 4:2:0 output on GA102 and
 later
Date: Tue, 22 Sep 2026 18:53:35 -0300
Message-ID: <20260922215336.612239-6-Capitain_Jack@yahoo.com>
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

GA102 and later heads can pack YCbCr 4:2:0 in hardware when the
capability notifier reports the horizontal chroma low-pass and vertical
filters (POSTCOMP_HEAD_HDR_CAPA HCLPF/VFILTER), which is how NVIDIA's
open NVKMS enables it.  Read that per head, and on such heads offer
YCbCr 4:2:0 through the "color format" property and allow 4:2:0 modes.

4:2:0 enables the head's YUV420PACKER, CHROMA_LPF and CHROMA_DOWN_V,
reuses the 4:4:4 pixel depths and GCP encodings, is BT.709 limited
range, and is declared in the AVI InfoFrame.  The sink rules follow
drm_hdmi_state_helper.c: the mode must support 4:2:0 and deep colour
uses the 4:2:0 Deep Color bits; the TMDS character rate is half the
pixel clock.  "Automatic" falls back to 4:2:0 when RGB cannot carry the
mode, a 4:2:0-only mode is rejected on a head that cannot pack it, and
mode validation accounts for the halved rate as
drm_hdmi_connector_mode_valid() does.

The class definitions are subsets of NVIDIA's open-gpu-kernel-modules
clc67d.h and clc673.h.

Not tested on hardware: the only sink available here declares no 4:2:0
support.  The head programming, pixel depths and packets are the ones
exercised by the 4:4:4 and 4:2:2 paths, which were.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 83 +++++++++++++++----
 drivers/gpu/drm/nouveau/dispnv50/head.c       | 18 +++-
 drivers/gpu/drm/nouveau/dispnv50/head.h       |  3 +
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c   | 13 ++-
 .../drm/nouveau/include/nvhw/class/clc673.h   | 17 ++++
 .../drm/nouveau/include/nvhw/class/clc67d.h   | 16 ++++
 drivers/gpu/drm/nouveau/nouveau_connector.c   | 12 ++-
 7 files changed, 142 insertions(+), 20 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index ad8952dfcd71..c52629eaf786 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -423,6 +423,22 @@ nv50_hdmi_sink_supports(const struct drm_display_info *info,
 		 * which carries up to 12 bpc in the 24-bit container.
 		 */
 		return (info->color_formats & BIT(fmt)) && bpc <= 12;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+		/* 4:2:0 has its own Deep Color bits (HF-VSDB / Y420CMDB). */
+		if (!drm_mode_is_420(info, mode))
+			return false;
+		switch (bpc) {
+		case 8:
+			return true;
+		case 10:
+			return info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30;
+		case 12:
+			return info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36;
+		case 16:
+			return info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48;
+		default:
+			return false;
+		}
 	default:
 		return false;
 	}
@@ -456,10 +472,37 @@ nv50_hdmi_char_rate(const struct drm_display_mode *mode, unsigned int bpc,
 	return rate;
 }
 
+/* Deepest depth the sink declares for the format, the user allows and the
+ * TMDS link carries, or 0.
+ */
+static unsigned int
+nv50_hdmi_pick_bpc(const struct drm_connector_state *conn_state,
+		   const struct drm_display_mode *mode,
+		   enum drm_output_color_format fmt, unsigned int max_rate)
+{
+	const struct drm_display_info *info = &conn_state->connector->display_info;
+	unsigned int bpc;
+
+	for (bpc = 16; bpc >= 8; bpc -= 2) {
+		unsigned long long rate;
+
+		if (bpc > conn_state->max_requested_bpc ||
+		    !nv50_hdmi_sink_supports(info, mode, fmt, bpc))
+			continue;
+
+		rate = nv50_hdmi_char_rate(mode, bpc, fmt);
+		if (rate && rate <= max_rate * 1000ULL)
+			return bpc;
+	}
+
+	return 0;
+}
+
 static int
 nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state,
 			   struct drm_connector_state *conn_state)
 {
+	struct nv50_head *head = nv50_head(crtc_state->crtc);
 	struct nv50_head_atom *asyh = nv50_head_atom(crtc_state);
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct drm_connector *connector = conn_state->connector;
@@ -497,29 +540,34 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 		case DRM_CONNECTOR_COLOR_FORMAT_YCBCR422:
 			fmt = DRM_OUTPUT_COLOR_FORMAT_YCBCR422;
 			break;
+		case DRM_CONNECTOR_COLOR_FORMAT_YCBCR420:
+			if (!head->yuv420)
+				return -EINVAL;
+			fmt = DRM_OUTPUT_COLOR_FORMAT_YCBCR420;
+			break;
 		default:
 			break;
 		}
 
-		/* Deepest depth the sink declares for the format, the user
-		 * allows and the TMDS link carries.
-		 */
 		max_rate = nouveau_connector_get_tmds_link_bandwidth(connector);
-		for (bpc = 16; bpc >= 8; bpc -= 2) {
-			unsigned long long rate;
-
-			if (bpc > conn_state->max_requested_bpc ||
-			    !nv50_hdmi_sink_supports(info, mode, fmt, bpc))
-				continue;
+		bpc = nv50_hdmi_pick_bpc(conn_state, mode, fmt, max_rate);
 
-			rate = nv50_hdmi_char_rate(mode, bpc, fmt);
-			if (rate && rate <= max_rate * 1000ULL)
-				break;
+		/* "Automatic" falls back to 4:2:0 when RGB cannot carry the
+		 * mode, as in drm_hdmi_state_helper.c.
+		 */
+		if (bpc < 8 && fmt == DRM_OUTPUT_COLOR_FORMAT_RGB444 &&
+		    drm_connector_get_color_format(conn_state) == DRM_CONNECTOR_COLOR_FORMAT_AUTO &&
+		    head->yuv420 && drm_mode_is_420(info, mode)) {
+			fmt = DRM_OUTPUT_COLOR_FORMAT_YCBCR420;
+			bpc = nv50_hdmi_pick_bpc(conn_state, mode, fmt, max_rate);
 		}
 
 		if (bpc < 8) {
-			/* An explicit format request is honoured or refused. */
-			if (fmt != DRM_OUTPUT_COLOR_FORMAT_RGB444)
+			/* An explicit format request is honoured or refused,
+			 * and a 4:2:0-only mode cannot fall back to RGB.
+			 */
+			if (fmt != DRM_OUTPUT_COLOR_FORMAT_RGB444 ||
+			    drm_mode_is_420_only(info, mode))
 				return -EINVAL;
 			bpc = 8;
 		}
@@ -532,7 +580,8 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 			/* YCbCr is limited range; CTA-861 colorimetry
 			 * defaults to BT.709 above 576 lines, BT.601 below.
 			 */
-			asyh->procamp.colorspace = mode->vdisplay > 576 ?
+			asyh->procamp.colorspace = mode->vdisplay > 576 ||
+						   fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR420 ?
 						   NV50_HEAD_COLORSPACE_YUV_709 :
 						   NV50_HEAD_COLORSPACE_YUV_601;
 			asyh->procamp.limited = true;
@@ -1027,7 +1076,9 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 							   HDMI_QUANTIZATION_RANGE_FULL);
 		} else {
 			/* Declare the matrix the head's output CSC applies. */
-			avi->colorspace = fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR422 ?
+			avi->colorspace = fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR420 ?
+					  HDMI_COLORSPACE_YUV420 :
+					  fmt == DRM_OUTPUT_COLOR_FORMAT_YCBCR422 ?
 					  HDMI_COLORSPACE_YUV422 : HDMI_COLORSPACE_YUV444;
 			avi->colorimetry = asyh->procamp.colorspace ==
 					   NV50_HEAD_COLORSPACE_YUV_709 ?
diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.c b/drivers/gpu/drm/nouveau/dispnv50/head.c
index 7b94c881e8bb..ca48bedbdbe2 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.c
@@ -30,6 +30,8 @@
 #include <nvif/event.h>
 #include <nvif/cl0046.h>
 
+#include <nvhw/class/clc673.h>
+
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
@@ -371,7 +373,8 @@ nv50_head_atomic_check(struct drm_crtc *crtc, struct drm_atomic_commit *state)
 					asyc->set.dither = true;
 			}
 			if (armh->procamp.colorspace != asyh->procamp.colorspace ||
-			    armh->procamp.limited != asyh->procamp.limited)
+			    armh->procamp.limited != asyh->procamp.limited ||
+			    armh->or.format != asyh->or.format)
 				asyh->set.procamp = true;
 		} else {
 			if (asyc)
@@ -586,6 +589,19 @@ nv50_head_create(struct drm_device *dev, int index)
 	head->disp = disp;
 	head->base.index = index;
 
+	/* GA102 and later heads pack YCbCr 4:2:0 in hardware when they have
+	 * the horizontal chroma low-pass and vertical filters.
+	 */
+	if (disp->disp->object.oclass >= GA102_DISP &&
+	    disp->disp->object.oclass < GB202_DISP) {
+		const u32 capa = nvif_rd32(&disp->caps,
+					   NVC673_POSTCOMP_HEAD_HDR_CAPA(index));
+
+		head->yuv420 =
+			NVDEF_TEST(capa, NVC673, POSTCOMP_HEAD_HDR_CAPA, HCLPF_PRESENT, ==, TRUE) &&
+			NVDEF_TEST(capa, NVC673, POSTCOMP_HEAD_HDR_CAPA, VFILTER_PRESENT, ==, TRUE);
+	}
+
 	if (disp->disp->object.oclass < GF110_DISP)
 		funcs = &nv50_head_func;
 	else
diff --git a/drivers/gpu/drm/nouveau/dispnv50/head.h b/drivers/gpu/drm/nouveau/dispnv50/head.h
index 8bd2fcb1eff5..db4a50a85e79 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/head.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/head.h
@@ -19,6 +19,9 @@ struct nv50_head {
 	struct nv50_crc crc;
 	struct nv50_lut olut;
 	struct nv50_msto *msto;
+
+	/* The head can pack YCbCr 4:2:0 in hardware. */
+	bool yuv420;
 };
 
 struct nv50_head *nv50_head_create(struct drm_device *, int index);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index 937f71f264db..9e152daefc58 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -26,6 +26,7 @@
 #include <nvif/pushc37b.h>
 
 #include <nvhw/class/clc57d.h>
+#include <nvhw/class/clc67d.h>
 
 static int
 headc57d_display_id(struct nv50_head *head, u32 display_id)
@@ -111,6 +112,7 @@ headc57d_procamp(struct nv50_head *head, struct nv50_head_atom *asyh)
 	struct nvif_push *push = &nv50_disp(head->base.base.dev)->core->chan.push;
 	const u8 colorspace = asyh->procamp.colorspace;
 	const bool limited = asyh->procamp.limited;
+	const bool yuv420 = asyh->or.format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420;
 	const int i = head->base.index;
 	u32 lo = 0x000, y_hi = 0xfff, c_hi = 0xfff;
 	int ret;
@@ -126,9 +128,14 @@ headc57d_procamp(struct nv50_head *head, struct nv50_head_atom *asyh)
 	if (ret)
 		return ret;
 
+	/* 4:2:0 filters chroma horizontally and vertically.  CHROMA_DOWN_V
+	 * is an NVC67D field and an unused bit on NVC57D; 4:2:0 is only
+	 * selected on GA102 and later heads.
+	 */
 	PUSH_MTHD(push, NVC57D, HEAD_SET_PROCAMP(i),
 		  NVVAL(NVC57D, HEAD_SET_PROCAMP, COLOR_SPACE, colorspace) |
-		  NVDEF(NVC57D, HEAD_SET_PROCAMP, CHROMA_LPF, DISABLE) |
+		  NVVAL(NVC57D, HEAD_SET_PROCAMP, CHROMA_LPF, yuv420) |
+		  NVVAL(NVC67D, HEAD_SET_PROCAMP, CHROMA_DOWN_V, yuv420) |
 		  NVVAL(NVC57D, HEAD_SET_PROCAMP, DYNAMIC_RANGE,
 			limited ? NVC57D_HEAD_SET_PROCAMP_DYNAMIC_RANGE_CEA :
 				  NVC57D_HEAD_SET_PROCAMP_DYNAMIC_RANGE_VESA));
@@ -288,7 +295,9 @@ headc57d_mode(struct nv50_head *head, struct nv50_head_atom *asyh)
 
 	//XXX:
 	PUSH_NVSQ(push, NVC57D, 0x2074 + (i * 0x400), m->v.blank2e << 16 | m->v.blank2s);
-	PUSH_NVSQ(push, NVC57D, 0x2008 + (i * 0x400), m->interlace);
+	PUSH_NVSQ(push, NVC57D, 0x2008 + (i * 0x400), m->interlace |
+		  NVVAL(NVC67D, HEAD_SET_CONTROL, YUV420PACKER,
+			asyh->or.format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420));
 
 	PUSH_MTHD(push, NVC57D, HEAD_SET_PIXEL_CLOCK_FREQUENCY(i),
 		  NVVAL(NVC57D, HEAD_SET_PIXEL_CLOCK_FREQUENCY, HERTZ, m->clock * 1000));
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h
new file mode 100644
index 000000000000..ba901cf7ac28
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clc673.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2003-2021, NVIDIA CORPORATION. All rights reserved.
+ */
+#ifndef _clc673_h_
+#define _clc673_h_
+
+/* Subset: the per-head post-composition capabilities used by nouveau. */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA(i)                                      (0x680+(i)*32) /* RW-4A */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_HCLPF_PRESENT                                         19:19 /* RWIVF */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_HCLPF_PRESENT_TRUE                               0x00000001 /* RW--V */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_HCLPF_PRESENT_FALSE                              0x00000000 /* RW--V */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_VFILTER_PRESENT                                       23:23 /* RWIVF */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_VFILTER_PRESENT_TRUE                             0x00000001 /* RW--V */
+#define NVC673_POSTCOMP_HEAD_HDR_CAPA_VFILTER_PRESENT_FALSE                            0x00000000 /* RW--V */
+
+#endif // _clc673_h_
diff --git a/drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h b/drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h
new file mode 100644
index 000000000000..a659f1f2121c
--- /dev/null
+++ b/drivers/gpu/drm/nouveau/include/nvhw/class/clc67d.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2020, NVIDIA CORPORATION. All rights reserved.
+ */
+#ifndef _clC67d_h_
+#define _clC67d_h_
+
+/* Subset: the NVC67D additions to NVC57D head methods used by nouveau. */
+#define NVC67D_HEAD_SET_PROCAMP_CHROMA_DOWN_V                                   4:4
+#define NVC67D_HEAD_SET_PROCAMP_CHROMA_DOWN_V_DISABLE                           (0x00000000)
+#define NVC67D_HEAD_SET_PROCAMP_CHROMA_DOWN_V_ENABLE                            (0x00000001)
+#define NVC67D_HEAD_SET_CONTROL_YUV420PACKER                                    3:3
+#define NVC67D_HEAD_SET_CONTROL_YUV420PACKER_DISABLE                            (0x00000000)
+#define NVC67D_HEAD_SET_CONTROL_YUV420PACKER_ENABLE                             (0x00000001)
+
+#endif // _clC67d_h_
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 2a9782d6c382..e274251adbb2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -306,12 +306,17 @@ nouveau_conn_attach_properties(struct drm_connector *connector)
 		 */
 		if (disp->disp.object.oclass >= TU102_DISP &&
 		    disp->disp.object.oclass < GB202_DISP) {
-			const unsigned long formats =
+			unsigned long formats =
 				BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
 				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
 				BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
 
 			drm_connector_attach_broadcast_rgb_property(connector);
+			if (disp->disp.object.oclass >= GA102_DISP) {
+				/* 4:2:0 is further gated on each head's filters. */
+				formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
+				connector->ycbcr_420_allowed = true;
+			}
 			drm_connector_attach_color_format_property(connector, formats);
 		}
 	}
@@ -1205,6 +1210,11 @@ nouveau_connector_mode_valid(struct drm_connector *connector,
 	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) == DRM_MODE_FLAG_3D_FRAME_PACKING)
 		clock *= 2;
 
+	/* YCbCr 4:2:0 halves the TMDS character rate. */
+	if (clock > max_clock && connector->ycbcr_420_allowed &&
+	    drm_mode_is_420(&connector->display_info, mode))
+		clock /= 2;
+
 	if (clock < min_clock)
 		return MODE_CLOCK_LOW;
 	if (clock > max_clock)
-- 
2.53.0

