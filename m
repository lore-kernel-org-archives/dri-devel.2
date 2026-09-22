Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9C3C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8522610EE90;
	Tue, 22 Sep 2026 21:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="W8RsBE+C";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12DEE10EE84
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114011; bh=4E+t1EY4JVvXu/VvFDxQtqUwdr1Waxsri61crfiCJNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=W8RsBE+C8VegYTp8Qse5GOewb7d5ENZtZ2zaFyq/ImgWpgdpLO2KVFK/ng334g6SLvhOzVjmsQbWkK8rDTE96/6h++2QxZdCJeiXOY8Yt5ueekGyU3BeSBP+rnWK7vPnX0oIzsxmXrGtfOBJLMuJr3Z6yx3W3h0yEiYWFFIsGTnSsIumzZK8nXT9b3KKjhsFcghaBhhoJ2RUb4rcSVKGIZ8+Lb0p+1qGSUEYQgDKoos75brjA1cYPDrQLeIwaBMV3Zk2vK6MQFOabw9r2NTW160kVI5OBpyATuasgtvfTv6Rf5bMzjNUaqjoFpNXtbjIvHoOJxNhZL15hZT0hTK2jw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114011; bh=tuSj9mGCHHO4u1IwrQe2rS/DDcpOYnbihGcXp3U43oh=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=XIiDLWMRB+AhCPnHAHJOGre1bfTxrQijhU4NimN4oKm8Gr26xsflhwYVWDohkmRG+pDU9RPl5FDLM/GjuuDSBc3+FHo/KMOSfrrX+EbvT0SKgVtgbFZPrYJ9phz4jnus5iKwCElqCzrJAiXzAnL98zAdAmJyprqz/XaePHtytCpzTsfwXKrH6lpggAJ3KGA/wEJ3BkI8QXFye2iqDCBvxJ8i896S8tuNvvg36DntRwOaOwxhYZbrUgdyrulo5QrEmxLPPhp/7hDZENggc92EoDgRPt30YzveV87Twt4awBpuQChd5JfWpql4I3W+hGv147biw0MjP4ji9/D56Njw0w==
X-YMail-OSG: Gq0c7B4VM1ntUYtDj2t5p0fO80swuX.NVsq5sXB86baDCIkQDxyvTsamug3zLSG
 kD18FRMCEuxUiG7dS06MGirQ0V0PS._YPwlY8geQS4LYKGNT6dbIJ_vOvAwRulgZrjr676SHQcXd
 RXcGeCdI8wq6IL2nQ2Suc.EfIslHeh10xONaQVfx8vXiVJJ0TKX5EGAbplyxfz8DLXjVs2kWHh3i
 lYolPmV1R.sPkpvsSUJYHjBQE7w9cXkRXpy7uCRyXoJjwDoLxTznS.RtCIpLZZjTf0rBW8axuv6N
 UyiZnDgYDQOCIrmRgU8if_DHCQbRkX_76soLgsrsZhIXBaw3J.fswKKS6ye0PLsAd2clmUBbvJGy
 LCN4o47GzeIzPNMCimRl65DADQ7WpN66AOYzKuak4veervrPHaUFLdG6VCHGmYh_SRFK_C2nWmBn
 SfSfgYuV1jt9Ewaqu6ZNjz62.jrmpnvcmuG_64kwGGHLeev_1caC9JyGETv5lqBg57JblDqe9mr6
 n6hdUEcxvSRN6i1.h0MtOEviKbZqj1qZ2D.RTvDMVjGMzGnzroEYrpD1_VH046vmjGVE7DBOg8J3
 Dr3QoxBn64ibIF7fKbtpCkdHKeF6jMKDLH0sJIDyY_g_s2DxY6KSUS.2OobJLp7wmreTIZUBKFiL
 T.unIuH97cTMbkaF1nDVsk0ilZbQENBn_WAslblf.FN0Uv9bvsceUfDUpuJQaxXNDbho.FvCSQZo
 KF5m9rUkpnIyC2nzo099oJVI6xuqhQZrPUKef.51tGGyomHHURtlkZ93ijQef39sInCyzV35T9np
 iiZkajg2ad1W5edfA.yuEOkoZnRQLokkHzh59LZs9YdXAkEJ0kXzu_0FNVlybl46.ximM6KqLLAs
 z8x1lOJYgn9ojPtAnJEkpTpyyF5PCfWnpghWM38qjbnke1IbVtwZgRVNMj_oxd_3cTJSTPigDl7d
 KYuECJlap6OpEJDrMhTrsiW2HMJVx0wQK3nmYZrIo2SNoapM3k0T.uSkPLNP5ynkhoEo0EQ29._l
 5mLjRdGeBokdRSVExr_JRhtlxeBKaU_cXzRwbc.huKbn1JMjh8tN8V_Oz_FtddD6BhpJwGfk.rPn
 FmXHHtQRdE2L4DJeSBwCDI1th2ftNwpDqZfdsFmzE58gDzaCmSV8E4MtCLLzWLAb6yf5jycln0Lh
 l_x6WPpzixfC3U7Zndp4wZ2efK4qHvrltPP_57.NV7mYGqk242x825KYHGkao1_kbfwInYIUEJSI
 VnsCr2xYNrY7N802tcvijOaICTrSUIKPuSrLzofwvMUGoQiXDoTiXR8m7t8WtlMfyzvJPHAcWDn9
 RMq3fSLIfnWedKhqkP8OT6XWYO8keHC9DGYVCUigzXv_G..NPib1.stFlEGdQqJlgAG.aOlj5Raj
 zH2lcsZgM.H5608x7fPSW4lvLGHizJVxjV3L6vEDyGixZskhvBAg22QH1xWovjonViNcs4pHrOsI
 J9g970c01bNINoFGwv_h5lUEATjCx68.IwNXsEMzQHIXdo3WCkLV2h7hLSaIqJSnJflQ9qzEVuA0
 yI5yYH.Xv_rQ9tUF8dpp.NDwYkzAGVw50TzCJmwGhswzHCfNN5zYwyRH3Kbx6dG5AE46.cEOeWB5
 UH5IHHiWfdyqt.D_U2BCwaz6A08isdSY_AL5X7Tr4mLY199WR6TcgJwV139h6bqT3yXagMTGIoOq
 E5SxEDWrhu5AcJRJ81E8lNPbXNa1zR7ipOntF2gSE3bWB6IlWoyTiM_dQwvkNVoMoCmb_ym4bmDM
 3TvuTYt43LqzRkA4eksKw8vh9Fi8nmKAsxAc0Drz_NCNg4CoDnOIIQzWR7l9VUgKTC0DZx_qbp90
 _S8i7Tq8WYs5XP1xgfjDIP.yZKEPznGusB.Z3Tmhkc_anB6r9I6V.Wh5PUSX7sTRKHx031oO85lk
 7FiyUJk4PB5Fre8z2lRpAosbqHjMxMKG9OuoHb3xgZGG2GxZbo12oo6VwR70HaSqoDyanpFIlDyp
 21nt7yLkKsielpVAoSZVOp7Pv9lYyvA--
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 86ff367c-0dfb-403c-9db8-c24727c86d51
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 22 Sep 2026 21:53:31 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
 by hello (SMTP) with SMTP ID a34e68627d724ee34c25b40bae8a8d59;
 Tue, 22 Sep 2026 21:53:24 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH v2 1/3] drm/nouveau: select HDMI deep-color link depth
Date: Tue, 22 Sep 2026 18:53:15 -0300
Message-ID: <20260922215317.611388-2-Capitain_Jack@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922215317.611388-1-Capitain_Jack@yahoo.com>
References: <20260922215317.611388-1-Capitain_Jack@yahoo.com>
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

Nouveau currently initializes the output depth from the EDID basic display
parameters and does not expose a max bpc property on HDMI connectors.  As a
result, HDMI deep-color modes advertised by the VSDB are never selected.

Attach an 8..16 max bpc property.  Select 10, 12 or 16 bpc only when
the sink advertises the corresponding RGB 4:4:4 deep-color mode and the
resulting TMDS character rate fits the existing link limit.  Program the
matching head output-resource depth on NVDisplay.

Share the existing TMDS bandwidth helper with the atomic check so the depth
selection observes both sink and GPU limits.

Signed-off-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 70 ++++++++++++++++++++-
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  6 ++
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  6 ++
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c |  6 ++
 drivers/gpu/drm/nouveau/nouveau_connector.c |  9 ++-
 drivers/gpu/drm/nouveau/nouveau_connector.h |  1 +
 6 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index add19d479ebe..028512f8767b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -374,11 +374,26 @@ nv50_outp_atomic_check_view(struct drm_encoder *encoder,
 	return 0;
 }
 
+/* Pixel clock on the link.  Frame packing sends both eyes, doubling the mode
+ * clock; drm_mode_set_crtcinfo() applies the same doubling to crtc_clock, but
+ * only once the head's atomic check has run.
+ */
+static unsigned int
+nv50_outp_link_clock(const struct drm_display_mode *mode)
+{
+	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) == DRM_MODE_FLAG_3D_FRAME_PACKING)
+		return mode->clock * 2;
+
+	return mode->clock;
+}
+
 static void
-nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state)
+nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state,
+			   struct drm_connector_state *conn_state)
 {
 	struct nv50_head_atom *asyh = nv50_head_atom(crtc_state);
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
+	struct drm_connector *connector = conn_state->connector;
 	struct drm_display_mode *mode = &asyh->state.adjusted_mode;
 	unsigned int max_rate, mode_rate;
 
@@ -398,6 +413,36 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 			asyh->or.bpc -= 2;
 		}
 		break;
+	case DCB_OUTPUT_TMDS:
+		if (!connector->display_info.is_hdmi)
+			break;
+
+		max_rate = nouveau_connector_get_tmds_link_bandwidth(connector);
+		asyh->or.bpc = 8;
+
+		if (conn_state->max_requested_bpc >= 16 &&
+		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_48) {
+			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 16, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 16;
+		}
+
+		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 12 &&
+		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36) {
+			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 12, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 12;
+		}
+
+		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 10 &&
+		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30) {
+			mode_rate = DIV_ROUND_UP(nv50_outp_link_clock(mode) * 10, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 10;
+		}
+
+		conn_state->max_bpc = asyh->or.bpc;
+		break;
 	default:
 		break;
 	}
@@ -422,7 +467,7 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
 		asyh->or.bpc = connector->display_info.bpc;
 
 	/* We might have to reduce the bpc */
-	nv50_outp_atomic_fix_depth(encoder, crtc_state);
+	nv50_outp_atomic_fix_depth(encoder, crtc_state, conn_state);
 
 	return 0;
 }
@@ -1776,6 +1821,27 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 	switch (nv_encoder->dcb->type) {
 	case DCB_OUTPUT_TMDS:
+		switch (asyh->or.bpc) {
+		case 16:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_48_444;
+			break;
+		case 12:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_36_444;
+			break;
+		case 10:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_30_444;
+			break;
+		case 8:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_24_444;
+			break;
+		case 6:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_BPP_18_444;
+			break;
+		default:
+			depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_DEFAULT;
+			break;
+		}
+
 		if (disp->disp->object.oclass != NV50_DISP &&
 		    nv_connector->base.display_info.is_hdmi)
 			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda);
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
index 2bcb3790fc10..f42d6642d6e0 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc37d.c
@@ -39,6 +39,12 @@ headc37d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 	 *     improved later for deep colour etc.
 	 */
 	switch (asyh->or.depth) {
+	case 9:
+		depth = 8;
+		break;
+	case 8:
+		depth = 7;
+		break;
 	case 6: depth = 5; break;
 	case 5: depth = 4; break;
 	case 2: depth = 1; break;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
index 3f8ba495de8f..f1e9f02d177c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
@@ -52,6 +52,12 @@ headc57d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 	 *     improved later for deep colour etc.
 	 */
 	switch (asyh->or.depth) {
+	case 9:
+		depth = 8;
+		break;
+	case 8:
+		depth = 7;
+		break;
 	case 6: depth = 5; break;
 	case 5: depth = 4; break;
 	case 2: depth = 1; break;
diff --git a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
index 678cbc78ca9f..437633ff7807 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/headca7d.c
@@ -35,6 +35,12 @@ headca7d_or(struct nv50_head *head, struct nv50_head_atom *asyh)
 	int ret;
 
 	switch (asyh->or.depth) {
+	case 9:
+		depth = NVCA7D_HEAD_SET_CONTROL_OUTPUT_RESOURCE_PIXEL_DEPTH_BPP_48_444;
+		break;
+	case 8:
+		depth = NVCA7D_HEAD_SET_CONTROL_OUTPUT_RESOURCE_PIXEL_DEPTH_BPP_36_444;
+		break;
 	case 6:
 		depth = NVCA7D_HEAD_SET_CONTROL_OUTPUT_RESOURCE_PIXEL_DEPTH_BPP_30_444;
 		break;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b..b452e73f03f1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -298,6 +298,9 @@ nouveau_conn_attach_properties(struct drm_connector *connector)
 		drm_object_attach_property(&connector->base, dev->mode_config.
 					   dvi_i_subconnector_property, 0);
 
+	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA)
+		drm_connector_attach_max_bpc_property(connector, 8, 16);
+
 	/* Add overscan compensation options to digital outputs. */
 	if (disp->underscan_property &&
 	    (connector->connector_type == DRM_MODE_CONNECTOR_DVID ||
@@ -1101,8 +1104,8 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
-static unsigned
-get_tmds_link_bandwidth(struct drm_connector *connector)
+unsigned int
+nouveau_connector_get_tmds_link_bandwidth(struct drm_connector *connector)
 {
 	struct nouveau_connector *nv_connector = nouveau_connector(connector);
 	struct nouveau_encoder *nv_encoder = nv_connector->detected_encoder;
@@ -1168,7 +1171,7 @@ nouveau_connector_mode_valid(struct drm_connector *connector,
 		max_clock = 400000;
 		break;
 	case DCB_OUTPUT_TMDS:
-		max_clock = get_tmds_link_bandwidth(connector);
+		max_clock = nouveau_connector_get_tmds_link_bandwidth(connector);
 		break;
 	case DCB_OUTPUT_ANALOG:
 		max_clock = nv_encoder->dcb->crtconf.maxfreq;
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bc..6623b5e17796 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -216,6 +216,7 @@ extern int nouveau_duallink;
 extern int nouveau_hdmimhz;
 
 void nouveau_conn_attach_properties(struct drm_connector *);
+unsigned int nouveau_connector_get_tmds_link_bandwidth(struct drm_connector *connector);
 void nouveau_conn_reset(struct drm_connector *);
 struct drm_connector_state *
 nouveau_conn_atomic_duplicate_state(struct drm_connector *);
-- 
2.53.0

