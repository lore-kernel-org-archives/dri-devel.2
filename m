Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FA1C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF2F10EE21;
	Tue, 22 Sep 2026 19:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="izNaHeO0";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E127E10E576
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104904; bh=N/6LP1T08zHigj+cIIt6LBUWhq0wPjTrz3GxDpJ0pwk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=izNaHeO07LRm73zHnssnDRS0ekb0vZJkvnhudJEmaLrok7G5tCya/zktSydDjZaHT2CkZdbO/FqmhSZ2dV3FoyWLhFQJq7l1+9ZB7+S23bVdcKi0KZet5p7CJ82noQL4yzai226kj+Pq2ByN1OZhZGHF+acZvtL0WEhrCOYbPBlm1Z86g8zRCd4tyzjogg9WjWDQBLuKkd4gxKD4AVTBin/D0f3eZJNsNYEMOf2Amn596OAnCa8Kgav0HZqDrFEd5XFdjsbxlLG984DUui0BMdyq1oA/KV9ybUdBbwCR8exQZPHubOx7oTz4uloeTSpNiH4eNi9tJiMMTQpVpZJg0A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790104904; bh=uzog52ypVa9fPKEsgfxPuQ1oDqbbF7e/akJ2yL79o65=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=eHd7mWW0bh0XRM0nDsMd2Of7qD8X2FgfEAKoovbKZuZVOXG2stan/lI0+GrShr4GV9DbSZlEV8PvQX+PA6ThKfxlbL51uwgPRsNcgPI9uj+2F+v7jpMd9z++yRm4EN2WXmYIpmoKn3oUA4SkK9wT8K3sYFksXyjeNZrOLZOcqpC7oMTyLWTzjrS6kI3ftrDibKNgOqw8nojju7JBuFj/TwoifWEMgp9brOdvH9aHGbCt33a1jfsrCzTLCn1QnzpUXCXKNduXujuIsdPKlQfUp4b5ZlbyzFGfyxVqoVvPvyJdyWnw5iPilnuGoFT0JqcbmxkTOJ4pOV12UWlVDZmGCg==
X-YMail-OSG: 1WhvEtcVM1lA3J4UfO431d3WYMhSh6jM44ht7tDmJQUR2doLIAPWaKgJE6oju3h
 Ti3NSdvHJmHYhl28uWcxpgdVccl9d8Aco3d3QIPlGqqhW6u8cI1PlVVE3vsoXMQdGDCE1D37XOG_
 sgoMcaAcF8kliQgxuIVmHNRs51wGIFT7WBIIDgqwcj6zGN7FNr8nDfehZfw_OTFQ28lvFbeHT9Wh
 nRXtjODoECvVWSsI4thgVa6d98t7763JbGNcrFNyQ4Cv0hpPXMtGmAItTqvepV4Hn.Voxap2eSf.
 .jYBMyl7IFHaY_RmMOcZvyuMr0wSN1s2akfmV3pNP1bK_OdcHCy_fk9eTNdj3_WCwfMUgeaoUTSP
 vefqYWL9_rDcUTAGLXMo1Kj9xjQOSJq1gYV0Ih6R9f3B6sap.k_rYTNg5P7oSh5oimO7ROVuOmbx
 2ONqiH18erxp_QAeZ4u2E64sP.xXDcy3fKJZeUZDr9.4sDjMXdRXpJN.gzytujjbcuEGhSzXd6AB
 MI.iPeJiMGpqhP9RUQCHjrXSfpGFTGKt7.hGIcx6fXrbAzxiom9cnjUB4uKFz3Y21ToBuqy.dDkc
 wuLwFxK4CwPn5y6lN6fKyW7T0xqTMK3.B5lxQxS0Z4mSrQIp31akUgs9LOURKn3hzQY4_zZgZdv_
 J0cCqjc8lkllr0t5q5v77Opilkmj9WRLssM2w0USV.3t1YLZ9Baumw.TqsjxYwKCPBKnZYgJ.Bls
 b5YK_ICWPUXr9GFR4uMuhrPbJLBZCdslMy_qg2ZmTogCTdjmgHEJEtHwnQOyj2Jy5_7O1.ptishO
 sJGywxRkG5KmdWQqXPJLEj2qFqtzkHjLOaUKRcVbUFi7HJDpcPhXYw7D700HszARZddZapIAusXL
 SdZKHC3bF7ecRAacMNFKM06yXaA5tCgnscz3A2SjKxz_8BsCvY8zjs.jLTJpkabzJqL3Ka8TBIJR
 dvWDF9LUKSGiYdoCGpLhgtYxKZ9Xzi91ZDdjCvWIlGzmdAGn5dK2BSeMjLfXmnbtOr7mK_0l6k1L
 .J0a9ecCebLFgCTFcwD8k4PZwn3ivlIl5rvNibGZxuU2nAF8Eqbh5MiB2Q7AX_2uFfUh9pQuu2TR
 zpTIOzmDBTB2wCWTLpnYem7NRY9RiDowIWGG7wVjuLOpsGYnMHOnEFK.0_v.R8A4cCdxkzNY0DX3
 ixOnw7.o89Vbz8aEKxnwKXSQJ3j2BzWeLkfoEnVOtyoQ2hvNXObLbFGXHhBHfqZgxMrk3ycSBcJZ
 Z0znhAmhIjTDB4EXDT.KbryPx.eFpIUdATZNodfklWvP.NqdTsqpN1OV5p.Pp4FiUlLnQD3kflc0
 rLAVikIyBkZMmlstjADsdh_YPoXJ6pfTR0lZinox2PBgSIEIDje39l3d0_iehkF5I62vlPvM1zmw
 gT72LsshLGA9jVK42E3UP1TL.ooC7GuMnjfH8kAStrU4M12pNjkEPGeqEY1hoPAHq5eFrg2iHrsH
 fjQiSLU8PQiTg0STEBH31o7yiLvDn7fdU8Ehckuhnz09jm35ZTSweNWLXem6UE6ELl7huPT5NFiF
 YgscDqIN8XamQ7AyhSDnlDpgEcKaiuliGh6msY1lHyVvrbRnLDz98eG_nz0kw.w8.V3WovtsJxUd
 apVfk2j6eB4xPwPdoc_5gbyY.zzBnQe5yYohFFvwcqUINRRyM2PYQ17GDzuWLj4FQbU8Ym62vAs2
 aznoYHlc4rIWkvWFUJbJFzFoVCmwUgQOKACYZ0i81l_QWFIoMb1YSdc1a92lFS_dq7OvVIaVT2MY
 1M8Wt3OoZWBa1hSpFzX0SIuX_y.iYOktVKvcQRKY.ViW_Zuq_HuFvXv6zVeENPUjYygRI3.Qn1nc
 4VtboxT2nsogjrIAajh.sNkuwlbVSQTGOhrC7XWKgP0IZHCf7Cxrf9xgy29U0QCZTrayW2KlQhDT
 jtfh0AWhbxMd6J6jQxHMij1Os4K0uu92AnbgVn3SAGG2ZQTEdzd61rmWfbwBbbGdidOjPLiTbvbQ
 qM81c5S6p0OsQsIV3xkGkLqw2utl1
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 5995c0c2-44f1-4194-9585-80c433938dc8
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 19:21:44 +0000
Received: from dip49.lsn.bf1.yahoo.com ([67.195.177.58])
 by hello (SMTP) with SMTP ID a114298d351310ec48bd21743ed80317;
 Tue, 22 Sep 2026 19:21:39 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH 1/3] drm/nouveau: select HDMI deep-color link depth
Date: Tue, 22 Sep 2026 16:21:30 -0300
Message-ID: <20260922192132.114546-2-Capitain_Jack@yahoo.com>
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
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 57 ++++++++++++++++++++-
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  6 +++
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  6 +++
 drivers/gpu/drm/nouveau/dispnv50/headca7d.c |  6 +++
 drivers/gpu/drm/nouveau/nouveau_connector.c |  9 ++--
 drivers/gpu/drm/nouveau/nouveau_connector.h |  1 +
 6 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index add19d47..6410b96b 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -375,10 +375,12 @@ nv50_outp_atomic_check_view(struct drm_encoder *encoder,
 }
 
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
 
@@ -398,6 +400,36 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
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
+			mode_rate = DIV_ROUND_UP(mode->clock * 16, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 16;
+		}
+
+		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 12 &&
+		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_36) {
+			mode_rate = DIV_ROUND_UP(mode->clock * 12, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 12;
+		}
+
+		if (asyh->or.bpc == 8 && conn_state->max_requested_bpc >= 10 &&
+		    connector->display_info.edid_hdmi_rgb444_dc_modes & DRM_EDID_HDMI_DC_30) {
+			mode_rate = DIV_ROUND_UP(mode->clock * 10, 8);
+			if (mode_rate <= max_rate)
+				asyh->or.bpc = 10;
+		}
+
+		conn_state->max_bpc = asyh->or.bpc;
+		break;
 	default:
 		break;
 	}
@@ -422,7 +454,7 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
 		asyh->or.bpc = connector->display_info.bpc;
 
 	/* We might have to reduce the bpc */
-	nv50_outp_atomic_fix_depth(encoder, crtc_state);
+	nv50_outp_atomic_fix_depth(encoder, crtc_state, conn_state);
 
 	return 0;
 }
@@ -1776,6 +1808,27 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
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
index 2bcb3790..f42d6642 100644
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
index 3f8ba495..f1e9f02d 100644
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
index 678cbc78..437633ff 100644
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
index cc3caf8d..b452e73f 100644
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
index eb292d2b..6623b5e1 100644
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

