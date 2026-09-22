Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787D4C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC83010EE8A;
	Tue, 22 Sep 2026 21:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="ggj4WVnq";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253B610EE98
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114030; bh=1EWUtu2sJLYGV2YU3khFR/dtRdXIgC8k8/wDb6Dwh/0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ggj4WVnqepgVJ4LvlGCs3tCNxsdhRelJ5yndGcNhPgXaXxG+/smR/fecAl/899dpyi8INCLK1/hD1p82PBasABteiZQAPeeVMW1Xp0r0MW5pWQCuMV4G+J0ba9mJgOLEff8JCxl319S3dekMozRXSPcW4D9ISyTuH0ZrDvQ1KLSpGnB5QcL+Ul/zMm/nfS6uh5sUlAxRb0r1gPCOhCuZqUdM31eiUdscWfdRhI+xK1UDGBgfzFGbDb+7IIpebMTAxtMGOJXYKr4SCielAnNl7sxZ8OTEZL3jM8GuPDlPXuNuHW3LMA8WZ7eflhijcADsK4biUhZ/GwDXUHyad7XiPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114030; bh=cqOxa/C9Ulnd47NdO5m4GOVwsHJQr+hZ9Q6BI/DpBpu=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=r28tEBm3AZj+jxIxWnB9TA5E3uhwpNSWs5swpVsTxNmjayYr4/Ls23zTsDlU6ti7FK45FjtFThoS6WO8GUxV/DZFA82GbmJK9SGw29xqcLwBE/f9+BttVdmNdZoFkMR8wjau0gIc5EN1VGoFjqTeFLBH7Cw1y1Js4tHCojGHdlbi/RcSyxE5qXupV1GbjmTFdDxA3vymFd60ii576NSKMKZrQLDg1owWX2Lbwa2+DvQJeVuFgQSH4LcY9/zI5hytlCpSS8Xd+wXj6hbAMjGb/p8Z+IMXLm6TPf6paRGvQunTgWe1O3/7aCLw7Q1GEzdnwHv2aqLGGomc9mRHGs5h6w==
X-YMail-OSG: kS2FgLYVM1lee9.ZIRmQPn.SDcUloGOVyKyAtKbY4j_g5QDT9JzjI39EVTA7lUW
 cZPS_VdU9NadbH9ykbqc3HuAuG1PwjVZypuFdedUKtlZc5PqvVVgi9dObG2qSkuoipmAGvTlDBRx
 3vfI9_MCtEJVXKh2TdfhtJ65HD6n94ERB2HsL2USmQ69OAvsu8rqb6zxBcNp0Q.j0Hdjd2AQFlPu
 5dzf4MgeMZynSAQvLQS3.2_3ePpkJ5CrZLclBruyn5zmtfZ2taWTrOuv73OIDz5UqqIvsKg266PZ
 qGcYXN5FWAaUcCvS_mB1G.JfiotX2FFe9fnYdk0ZwP.QRxX2aP018D8A_pksZChI.9qtRB97hkFj
 xaZTU1UyKsohzQKnOsZvizd5KuhmUB2avCT2po8Npm5rW1xeJt7RumPjgVyfBl1TOoFtXWuEU2Pe
 e.kj6Gj6ux1ui61jc8L9ti7nk6jWTplsCWK6dU1qEQ1WvHeQC0cbMKaHHGtT7luGZBC1rZyYzmih
 _Dzm5gavltQSXwqcAueJaivr1o0RQmEcyNoEKAYVjTpXGyoFNZzDLCbt7VkSyOmJVwt4zwd4nOJo
 X5Fy74S538fuRgeCdmsoCLvUhngXNsb1vXW1HK_EEryTtnekSqyhX4.aAd.gFleV8LYA9vZ7_t7f
 fDhJkzij.L4AjaBbDhtABf9xleRkZXgpQT.yelUf.3iECrdhLDig4VsRYDaLeAxS1QS6_ZUl5WYm
 fY5D7uTyLT5YniTLALPJcp7Dj_XzPNzG3NEf.pkTGFMpSqDvVgQdvpk1JpOELGPu6pR7MfKcgc_A
 LJy4jbKmFAhhe2dBWmghNaoE2NpeVd2dwvieDpaM6Y8YkMNhP3QgnQHXzQdmuiwmIovAX58UIqPa
 DG2MIkVM8HSmgx53yFVY5KVHq2ek3YOgWBRcknRTPkuHAAXLHgS6C2.xWVWGJKkIF.du1URj0FVj
 dTmEhU071_mObPRLh5gwRW8I3FXFL.5crn9Ys5B8sW0TMUVT8Cy4jgqSEZcYsdTjAsBXSFbRDicE
 VcGde1oMwPSHK2t0TcN3x0qXdLCnEYnCG6TA2tG851heQL_7INxKPxOWEcBqA9mYpdF6TItym_g3
 Li_cUydEHaTMg.__8D61CCZTfetztAAMpohOinSawvWMUR0UVTb2soVp1xZPVdAALU.4N4cm2dz7
 xZnxqumHlaL2SN2TWSjVfAWLYbZ4Av1A.QpODp.sjut_tNgd_FlUuhu0ur5a.XgsHsNjGgiahLIk
 NFc1YxV9iXPvbl5GMPCsu6tJxO2gRRmTlV_9i8Yu3dUp9ARZMKsln64_O6ImlfhHSJz8eG82pLYu
 gRDm0DV6SONZy2MQhg0nq76x_fBbW2VcoUwqgn6icVGN6IIe2LM2Ee6S8H1fq6EvNMaeRg5wZ5Sy
 Xle0nduMbip5lltqpCEdk9DzB1uWvEclGfo2W4N4_C4ZFjeXh3MkwBfELpEfdxeqJZD2e77ZYZiK
 TR4wMMA3OPr1plu6LCwAy.M3_Z6t2DTA.k0FdRxWVn4MiQPXc_aECSn8gJwu3Vs4J_nv.jBW.i8w
 7Tp8iGiS_L_zhzYC.9SNLtqgxeKdlOKX6oSAMADYlRk4CrL7TnuYJwEJJRkvduROqZoNTC4OsMov
 2hE6k6Iyw.pMdOGSUcMn2R77yTY2Ky_Zw88jg_NDt9VPur.RkLaaBlJuEy2EV1Qx_MghZ3OCa3ux
 ISUmsSU5CAJ9lXzj0mp481L3yhktwro36R43qjd.vexftE4D9rfY8.s08eIBKJjapeDidK2gNQM9
 Bsr.EvdUtwlxJGji5t5xzcNQxIimRazblw5n3Gf0mkAYlCLjRtEJMYwFhBroopfGZCR93twxszmO
 r5h2IMaptlqmJt3tCqKUwYdTRzVCoPIaXBMvVqjTxo8GZ8H0zoTBOAH6948foaM1rDsMadtmOFiU
 ECy7YrCTs4_RQO9TI3D.cHFjbn7DMl1gDrnQikfdpaI9dqjPBncUXmiln4fcTlfymRZW2SGCZDXN
 PEirRHVkFJu6ht5R.xdlZkAIitaDW36M-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: a82237e5-e532-4fa3-aa4b-080842d29e0a
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 21:53:50 +0000
Received: from dip68.lsn.bf1.yahoo.com ([67.195.177.77])
 by hello (SMTP) with SMTP ID 98779d167a59bfbe653b3ebdee112417;
 Tue, 22 Sep 2026 21:53:46 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 3/6] drm/nouveau: add the Broadcast RGB property for HDMI
Date: Tue, 22 Sep 2026 18:53:33 -0300
Message-ID: <20260922215336.612239-4-Capitain_Jack@yahoo.com>
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

Nouveau always scans out full-range RGB, and asks the AVI InfoFrame to
declare full range.  drm_hdmi_avi_infoframe_quant_range() may only send
a non-default Q when the sink sets QS in its Video Capability Data
Block, so a sink without one is told nothing and, for CE video formats
such as 1920x1080p60, applies its default limited range to full-range
pixels: black levels are crushed and highlights clipped.

Attach the standard "Broadcast RGB" property to HDMI connectors on heads
with an output CSC (Turing to Ada), and select limited range the same
way drm_hdmi_state_helper.c does: "Full" and "Limited 16:235" are
honoured, and "Automatic" follows drm_default_rgb_quant_range(), i.e.
limited for CE video formats and full otherwise.  The head's output CSC
performs the compression and the AVI InfoFrame declares the range that
is actually sent.  A change of the property forces a modeset, as the
range is selected in the encoder's atomic check.

This changes the default for CE video formats on those heads from
full-range pixels to limited range, matching i915 and the HDMI state
helpers.  "Full" restores the previous output.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 24 +++++++++++++++++++--
 drivers/gpu/drm/nouveau/nouveau_connector.c | 24 ++++++++++++++++++++-
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index b216db61330c..54ed903644bf 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -387,6 +387,14 @@ nv50_outp_link_clock(const struct drm_display_mode *mode)
 	return mode->clock;
 }
 
+static bool
+nv50_outp_has_output_csc(struct drm_encoder *encoder)
+{
+	const s32 oclass = nv50_disp(encoder->dev)->disp->object.oclass;
+
+	return oclass >= TU102_DISP && oclass < GB202_DISP;
+}
+
 static void
 nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state,
 			   struct drm_connector_state *conn_state)
@@ -442,6 +450,15 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 		}
 
 		conn_state->max_bpc = asyh->or.bpc;
+
+		/* Broadcast RGB, as in drm_hdmi_state_helper.c: automatic
+		 * selects limited range for CE video formats.
+		 */
+		if (nv50_outp_has_output_csc(encoder) &&
+		    (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_LIMITED ||
+		     (conn_state->hdmi.broadcast_rgb == DRM_HDMI_BROADCAST_RGB_AUTO &&
+		      drm_default_rgb_quant_range(mode) == HDMI_QUANTIZATION_RANGE_LIMITED)))
+			asyh->procamp.limited = true;
 		break;
 	default:
 		break;
@@ -825,8 +842,9 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 static void
 nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 		 struct nouveau_connector *nv_connector, struct drm_atomic_commit *state,
-		 struct drm_display_mode *mode, bool hda, u8 bpc)
+		 struct drm_display_mode *mode, bool hda, struct nv50_head_atom *asyh)
 {
+	const u8 bpc = asyh->or.bpc;
 	struct nouveau_drm *drm = nouveau_drm(encoder->dev);
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
@@ -905,6 +923,8 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 
 	if (!drm_hdmi_avi_infoframe_from_display_mode(&infoframe.avi, &nv_connector->base, mode)) {
 		drm_hdmi_avi_infoframe_quant_range(&infoframe.avi, &nv_connector->base, mode,
+						   asyh->procamp.limited ?
+						   HDMI_QUANTIZATION_RANGE_LIMITED :
 						   HDMI_QUANTIZATION_RANGE_FULL);
 
 		size = hdmi_infoframe_pack(&infoframe, args->data, data_len);
@@ -1877,7 +1897,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 		if (disp->disp->object.oclass != NV50_DISP &&
 		    nv_connector->base.display_info.is_hdmi)
 			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda,
-					 asyh->or.bpc);
+					 asyh);
 
 		if (nv_encoder->outp.or.link & 1) {
 			proto = NV507D_SOR_SET_CONTROL_PROTOCOL_SINGLE_TMDS_A;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index b452e73f03f1..748c2f29d5d1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -298,9 +298,15 @@ nouveau_conn_attach_properties(struct drm_connector *connector)
 		drm_object_attach_property(&connector->base, dev->mode_config.
 					   dvi_i_subconnector_property, 0);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA)
+	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+		/* Only heads with an output CSC can emit limited range. */
+		if (disp->disp.object.oclass >= TU102_DISP &&
+		    disp->disp.object.oclass < GB202_DISP)
+			drm_connector_attach_broadcast_rgb_property(connector);
+	}
+
 	/* Add overscan compensation options to digital outputs. */
 	if (disp->underscan_property &&
 	    (connector->connector_type == DRM_MODE_CONNECTOR_DVID ||
@@ -1213,9 +1219,25 @@ static int
 nouveau_connector_atomic_check(struct drm_connector *connector, struct drm_atomic_commit *state)
 {
 	struct nouveau_connector *nv_conn = nouveau_connector(connector);
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
 	struct drm_connector_state *conn_state =
 		drm_atomic_get_new_connector_state(state, connector);
 
+	/* The quantization range is selected during the encoder's atomic
+	 * check, which only runs on a modeset.
+	 */
+	if (conn_state->crtc &&
+	    old_conn_state->hdmi.broadcast_rgb != conn_state->hdmi.broadcast_rgb) {
+		struct drm_crtc_state *crtc_state;
+
+		crtc_state = drm_atomic_get_crtc_state(state, conn_state->crtc);
+		if (IS_ERR(crtc_state))
+			return PTR_ERR(crtc_state);
+
+		crtc_state->mode_changed = true;
+	}
+
 	if (!nv_conn->dp_encoder || !nv_conn->dp_encoder->dp.mstm)
 		return 0;
 
-- 
2.53.0

