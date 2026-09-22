Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C315C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CA310ED8B;
	Tue, 22 Sep 2026 19:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="tsdz/V+A";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFDC10E576
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104904; bh=EXF168YeLCc1blznFcIBmf6TglRxFDYLCZSvWRHZe8M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=tsdz/V+AUgAf3eYjCQyaEilc6fcuhe214IWYUS7C3v3Qcn7wRzuUKx8GpDjowVuOmfH5LoXb82UqGVF4HnhcrehhmF7goulafPmXDjtuZ52EQt4U0bsZOo7BuCsbXR3VHAObKkenwT4Yi8gQW5T2J5vCckYRHZ7rn7yS1teKcjRP4aVsBU0jVuVY2+vf1LvOsC4IUtJeEnoND9Ppa2EeLbOarD+bs8C9/wH8vQa09vPA0OzQehf/ruoMEMeWpMBBE86JrhusHWxsuUGtjm8q05ki2vbtW9a8JQd2poMeQQV1k4bmuF85KMAXUUSzytzwcujUYgFZeA9xBIIvrQvvDA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104904; bh=gz0aFPhJ830sWcbDiBe1m0NMpUnNHA/8OUT99hFDqvT=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Sp5KbO1Us/NHFvmvUYE69Sl1IlV0rJu8tSMYYiV32OvCog37vSQKxcgMamdrq+O5+szdqcdAqFyDD3alxHnI3uXyjAqEgfjsEnC+Q/QXb5AoYY+NFrpDtwQcliAVUFZTwmHk2b/3/suG4oBP0GBzK1wii06XeAMZF6CNFgGCjZ97X9F44hTYV9L8j8z+f/bDuSBT28kce8AIBHeNH2yLow1eyFnLyKrCIEDz0GDAIJfUIclXjoDF59L96FQJwKxF40Uj94kDIKWasBhe1UM+iDsuRLcfYBFoS+60MvKhicWsgxTEDf1tx6q8ULqMuG5vXJ/J8QCNWW9E520e0OONiQ==
X-YMail-OSG: xjOT.b0VM1nbd7txqQ32dep41q7U4nncGG3VmzO_S5iNqwtrFcYOo3IkgXOTDsj
 zQtBihkgxbYo_3SMVMPk1AIMjAMT.tHo.dXggRm0_yU2D0iPth5B9oxxi4kU9MZpDmE_ezNX8mSL
 aRN.bAkHwlXwD_OT.auyzO1hnT47waSU1_FVK6eY90MQd8ra.V1N_S6_1PXM8z.i0FFWP.Puv5AM
 NGvYtXO04uso1Yh1Q0dLGcdBhRQYiHvVtyXqIxzqle7DCKnH2MKvWHkHJRvWS0C8VIxnIulA6eD5
 xtHE8RAgM7UnzmvtehjsjNDy.BSXSFDspRfj28rGPWsM2SLz5xgli9nNExloocn.wHURtoKjEWqb
 opmwpTO6NC9iGcBRdgdDdoEKJmcP63tdwxZE6OQbiUlh7HPjHeWU0l52YNzcGdawZNw.tKf.jUXt
 a4D9Y81ViKcH4mNneEFZT8DBVZc.qqiAL0fLFb2nDFRtn5Fe2glDl7CI.mWTmbjD06_zZ2wwqGEN
 ncFCB3oyyuxo9MbE9t_MvvLItRD.4eTOnseogg.YaiCaJkvlGsKgrZWzoANd0Taodbx2GlYzGmj8
 bl.hUEr34XakNGKIPYJ8OJGsSFqg1uyGKizchzAnBWamdPl5ltmG7dHnHRIQDP.hIO8_NU1we50j
 cNgnH2lQFlpJChbESt0_czay1f0IJKyxlxRoAAFGKYF6nF4K8uQkR2f79TK4mr9ay1HlpQZfMW6Q
 lfGW0BJR.JWUrwUBhPOGiI4uBSi_Ye0a4GxgB9u8pM4gpd8aGD7oVLARcenm4qGcuUQ7SCwqoceX
 tRSIRDDuRws6kjzb63TF5C1kpNzpP727wR0.4JCupz.HxAs.QfXT2GuedKchjuRsyh5RN3LkWJNJ
 z7naoLajRyKWtSoYnsy.pXI9puuI0DG9rbUyx5b2VV0KjqKv4.JNx5kmG5Ve9pn8agvmGNsIIADc
 vS9Cors5rzh2F.992_XC14yCH5LtiL5bS6DAadjD8_2fPalcnK_l0Z3W2DkvH2Zu5MYVKHjo3f_C
 pSCyhVa3GchD2SUordIT.nz_Ws5r85d5ekQKVGRK8Hyjd4bG5mZNAciT166uc1d56Wvh2zmaWYWg
 GGQsDHrXF3bWTPIFamOzC5PU3qY_2A1afudyb0kNV79plVUa_rNNXd8g.s_tfTGJlzw4EFhzx5Cf
 Dra20P4LzqDXJVxm8IvYP_OW1i2pxoNGpc4.PyFv.Osjo3jJThmZ6D3PVyvewf_qE1OWJFQCKAa8
 gNqdVqhprgyftoCTTxZKTlJKS8CUhunhiIBGvvao3rNI5EhXFg_jswrWvZbxiUo9KMJstm3_aUZB
 h0SBzw8Q6LANRszoooXCHF6A5WiFigmfL_RnI_n6CrpyRwBEiXQjw3dLbOfFw1goe9qzXQnsIzuu
 gnrKz1cWHJi8ISxOnKbJlDxr8tbRFLG1VZgORou6KZOcrRXJlgvoY2FX1BfaVzntdwFw5b5vMT16
 E36.k0plAx1QvsorAUFyJItEtEHf8qYfhIg2zCkeAXSlnN9bOPfiN4t.RsqRu4r4ZHwqIDYGFx6g
 uDBObMh3ki6iBj1v2YMJMaW.oS7YETMIiKC9ldQ2PXAvpbUgchCRes9e.c0689mhIo5SXwcKj0F3
 4hk9dLU7PiXUE5qCg_DbameyUi0O9R_mB70kLmLHN2aYMKzogeeZYTIBuoE8iCEfvWjM6A5iC3CY
 44xo2rNKwxlheeEZO5uWu0BI1hWTROfgO4ekBP0T8u9ofProXOpgW8Mj7JZiQBGjALf7eIRVY743
 ZFWvsFePBcH2z4dr4pHkTVXI0O3r2n3nOCDebV1YVXoANeG8E10F1lV868OPYa08XOfTAwNQGlat
 Kk1NDS09ufy3KD2eXJqX_uI63XDMfNPNUg0YrKI4MO9kXYboGUnps1whXQmaSl8fIzEd_5Np8ldE
 rdolft59aSIXCmxLUPQIB8FsA3jv4l_DEU8BWgrFAu7df8ySYUwPtpSrJjcW0CGSD3G2GbVTEmME
 04lXt03y55_9t6osmHcOsYVsT1vk9L_qA
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 726e600d-042d-4df0-96f2-a6a7dde00f4b
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 19:21:44 +0000
Received: from dip49.lsn.bf1.yahoo.com ([67.195.177.58])
 by hello (SMTP) with SMTP ID a114298d351310ec48bd21743ed80317;
 Tue, 22 Sep 2026 19:21:41 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 2/3] drm/nouveau: pass HDMI GCP deep-color state through NVIF
Date: Tue, 22 Sep 2026 16:21:31 -0300
Message-ID: <20260922192132.114546-3-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
References: <20260922192132.114546-1-Capitain_Jack@yahoo.com>
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

The HDMI GCP carries color depth and pixel packing phase.  These fields
are required for 30-, 36- and 48-bpp RGB links.  Nouveau has no way to
pass them from the atomic state to the display engine.

Build CD and PP using NVIDIA NVKMS's 36-bpp rule and the HDMI 48-bpp
encoding.
Extend the internal HDMI NVIF method and cache the values in the armed TMDS
state.  The following change uses that state in the generation-specific GCP
writers.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 23 +++++++++++++++----
 drivers/gpu/drm/nouveau/include/nvif/if0012.h |  3 +++
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  2 +-
 drivers/gpu/drm/nouveau/nvif/outp.c           |  7 ++++--
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  2 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  |  6 +++++
 6 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 6410b96b..6d8fee1b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -809,13 +809,14 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 static void
 nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 		 struct nouveau_connector *nv_connector, struct drm_atomic_commit *state,
-		 struct drm_display_mode *mode, bool hda)
+		 struct drm_display_mode *mode, bool hda, u8 bpc)
 {
 	struct nouveau_drm *drm = nouveau_drm(encoder->dev);
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
 	struct drm_hdmi_info *hdmi = &nv_connector->base.display_info.hdmi;
 	union hdmi_infoframe infoframe = { 0 };
 	const u8 rekey = 56; /* binary driver, and tegra, constant */
+	u8 gcp_cd = 0, gcp_pp = 0;
 	u32 max_ac_packet;
 	DEFINE_RAW_FLEX(struct nvif_outp_infoframe_v0, args, data, 17);
 	const u8 data_len = __member_size(args->data);
@@ -826,6 +827,19 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	max_ac_packet -= 18; /* constant from tegra */
 	max_ac_packet /= 32;
 
+	/* Match NVIDIA's 36-bpp GCP construction and extend the same HDMI
+	 * color-depth encoding to 48-bpp.  48-bpp groups contain one pixel,
+	 * so their last packing phase is phase 4 (zero).
+	 */
+	if (bpc == 16) {
+		gcp_cd = 7;
+	} else if (bpc == 12) {
+		const u32 hbp = mode->crtc_hblank_end - mode->crtc_hsync_end;
+
+		gcp_cd = 6;
+		gcp_pp = ((mode->crtc_hdisplay + hbp) & 1) ? 1 : 2;
+	}
+
 	if (nv_encoder->i2c && hdmi->scdc.scrambling.supported) {
 		const bool high_tmds_clock_ratio = mode->clock > 340000;
 		u8 scdc;
@@ -850,7 +864,7 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 
 	ret = nvif_outp_hdmi(&nv_encoder->outp, nv_crtc->index, true, max_ac_packet, rekey,
 			     mode->clock, hdmi->scdc.supported, hdmi->scdc.scrambling.supported,
-			     hdmi->scdc.scrambling.low_rates);
+			     hdmi->scdc.scrambling.low_rates, gcp_cd, gcp_pp);
 	if (ret)
 		return;
 
@@ -1615,7 +1629,7 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *s
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
 		nvif_outp_hdmi(&nv_encoder->outp, head->base.index,
-			       false, 0, 0, 0, false, false, false);
+			       false, 0, 0, 0, false, false, false, 0, 0);
 		nv_encoder->hdmi.enabled = false;
 	}
 
@@ -1831,7 +1845,8 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 		if (disp->disp->object.oclass != NV50_DISP &&
 		    nv_connector->base.display_info.is_hdmi)
-			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda);
+			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda,
+					 asyh->or.bpc);
 
 		if (nv_encoder->outp.or.link & 1) {
 			proto = NV507D_SOR_SET_CONTROL_PROTOCOL_SINGLE_TMDS_A;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
index bde9bfae..ebfa60f9 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -176,6 +176,9 @@ union nvif_outp_hdmi_args {
 		__u8 scdc_scrambling;
 		__u8 scdc_low_rates;
 		__u32 khz;
+		__u8 gcp_cd;
+		__u8 gcp_pp;
+		__u8 pad14[2];
 	} v0;
 };
 
diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/nouveau/include/nvif/outp.h
index bc122a5b..3d5ed53f 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
@@ -90,7 +90,7 @@ int nvif_outp_bl_set(struct nvif_outp *, int level);
 int nvif_outp_lvds(struct nvif_outp *, bool dual, bool bpc8);
 
 int nvif_outp_hdmi(struct nvif_outp *, int head, bool enable, u8 max_ac_packet, u8 rekey, u32 khz,
-		   bool scdc, bool scdc_scrambling, bool scdc_low_rates);
+		   bool scdc, bool scdc_scrambling, bool scdc_low_rates, u8 gcp_cd, u8 gcp_pp);
 
 int nvif_outp_infoframe(struct nvif_outp *, u8 type, struct nvif_outp_infoframe_v0 *, u32 size);
 int nvif_outp_hda_eld(struct nvif_outp *, int head, void *data, u32 size);
diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 8cf4775a..44562645 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -224,9 +224,10 @@ nvif_outp_infoframe(struct nvif_outp *outp, u8 type, struct nvif_outp_infoframe_
 
 int
 nvif_outp_hdmi(struct nvif_outp *outp, int head, bool enable, u8 max_ac_packet, u8 rekey,
-	       u32 khz, bool scdc, bool scdc_scrambling, bool scdc_low_rates)
+	       u32 khz, bool scdc, bool scdc_scrambling, bool scdc_low_rates,
+	       u8 gcp_cd, u8 gcp_pp)
 {
-	struct nvif_outp_hdmi_v0 args;
+	struct nvif_outp_hdmi_v0 args = {};
 	int ret;
 
 	args.version = 0;
@@ -238,6 +239,8 @@ nvif_outp_hdmi(struct nvif_outp *outp, int head, bool enable, u8 max_ac_packet,
 	args.scdc = scdc;
 	args.scdc_scrambling = scdc_scrambling;
 	args.scdc_low_rates = scdc_low_rates;
+	args.gcp_cd = gcp_cd;
+	args.gcp_pp = gcp_pp;
 
 	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_HDMI, &args, sizeof(args));
 	NVIF_ERRON(ret, &outp->object,
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
index 5d682a77..fcf624cf 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h
@@ -46,6 +46,8 @@ struct nvkm_ior {
 	/* Armed TMDS state. */
 	struct {
 		bool high_speed;
+		u8 gcp_cd;
+		u8 gcp_pp;
 	} tmds;
 };
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index 377d0e0c..dff75d72 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -254,16 +254,22 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 	if (!ior->func->hdmi ||
 	    args->v0.max_ac_packet > 0x1f ||
 	    args->v0.rekey > 0x7f ||
+	    args->v0.gcp_cd > 0x0f ||
+	    args->v0.gcp_pp > 0x0f ||
 	    (args->v0.scdc && !ior->func->hdmi->scdc))
 		return -EINVAL;
 
 	if (!args->v0.enable) {
+		ior->tmds.gcp_cd = 0;
+		ior->tmds.gcp_pp = 0;
 		ior->func->hdmi->infoframe_avi(ior, args->v0.head, NULL, 0);
 		ior->func->hdmi->infoframe_vsi(ior, args->v0.head, NULL, 0);
 		ior->func->hdmi->ctrl(ior, args->v0.head, false, 0, 0);
 		return 0;
 	}
 
+	ior->tmds.gcp_cd = args->v0.gcp_cd;
+	ior->tmds.gcp_pp = args->v0.gcp_pp;
 	ior->func->hdmi->ctrl(ior, args->v0.head, args->v0.enable,
 			      args->v0.max_ac_packet, args->v0.rekey);
 	if (ior->func->hdmi->scdc)
-- 
2.53.0

