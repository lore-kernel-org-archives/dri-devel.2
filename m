Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AFCC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 21:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F55C10EE84;
	Tue, 22 Sep 2026 21:53:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="q+Sh0XWo";
	dkim-atps=neutral
Received: from sonic.asd.mail.yahoo.com (sonic-usea1-0019.asd.mail.yahoo.com
 [34.2.64.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C6010EE8A
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 21:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114010; bh=FRUpJK5g7FsxiTDOVWwiH8txwLJlVllIJOTpOfNTcX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=q+Sh0XWomTJMhq//tgp5Y16mQ58B8YgZnHlzKq5qQrMvbMUSFVAxtfgU6Ld+lks3en0+EgpnAyZA7hKWmwbxj/4TORV2dDXHfoPzRBQBLyidB5eK8iGzJBpk39MgALrjhydlEXficixXaTPvQ/jvH3FWsfp5M4ZMfQ+3hRVMTh/rGNho1M/x7UrTHHhR9FU8xJe1ThBB2t7QVu0Ov4lP32b01f4Ux0qXoHaQ0je8bqkHSTGhABDhYiALEsOnPRnDIeduecXh/z9Hfd2OToMV+l+4ZbmyoLHzK5eeViVupEgS6DIvZ8/1pA5FHRFCf3iw/X+be7TWiImBcjMky4Lfbg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1790114010; bh=aoMa629k1BeScqukmj7ydwuputYN+EPnYfAlSQ8kP13=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=krdvXJbjW8OqTm6EEN+2u1e6/QX1atbqhZsFyTo+5026sqD7qIOXusUIpPuX/Zwd2ZTanFkF2aCg9MFhXthGnESOozmZ8wiu9e4OO68/uYSv/CIVSbFfTzAnmOBNQMBpqyZydufub9Wm24jbHzhVP7AOV3oCnYo6RYHdTsmzEAo/l1hYjDme2Y4/qtFc5Ek70hitNimWnyVEBHmYL93QQws4O/0eoP3HpAj+rEynRQbp/OdK6IESpFDiHK/S5LfN4RwteIHIyq9fP7jmRw/WN/e/f4kPHTdbEDOmrnO761fx8qeBG08BxfC/CKBwNV+xaWu1s+9NsIg+0/lVC++YFQ==
X-YMail-OSG: M33AJKUVM1lboP9XktSXbVE2p80_wvcn0pBRqtr.nEIgFqZlGphmBIrnV0n1Rcy
 eJp1WIfEOD.AnISsWyG_iy89coZX.Qsg0fZ4XGfo2EqmYSyWwuuq0mksv0VbXO5l2LFFdk5dVr2h
 piVCtzij5KYIwtaXul3LgNYRVV0AEC0VAGOoWNLhhWv1xhRC3i.HF1KmsnITA7LYUuBuzD1utjkH
 9a2e18Htr7LJgIPr8kcSCXAF.7qmggWrdLU.O5alKP18HO9FahVppVYKcmPrW4opTzB8kJKCBCaO
 CoXreoMEWndTHuO0r1eHd.WxQ2_sW0zGz3p.Smj4Fl17he2q93ivZkoRBeswuN5sT56C4BdDU5eU
 vKHdaJPpG521u7itm1ZLqW8czi1p3ld7Akt75ytDzZb3Ixc7p92QTVCnZCzQ0.EKJBbr7FldQDvK
 V64i2G134Q9CYZLKh2vun5Di8vpkVswPRfrYh51R46WEkZlG5AkMdzrwA4AxcxIhNd9BAIKxoTlz
 S_OC6DsiAeaf9qw4OrApRdO3DTXi6Q9wfDrobnW6.QD.rSzlnUT7BmYe2NEmN7oqeLyQd.ptJaoS
 5OKCUSuM.XhQMi1aQPn1UhXK24zONVA12bm3EiIwKiT7hLhZRWOQC2eknaBRfWzDo4HKsW3bQTPG
 N.IWrLdVfjF7HgT5lD3jP9n5kBxTYpfdpLF9vsrVXgKYb5g2p76NBxRNfTfobU6MRaniyodA8XvP
 k6L20C7NwFe2Whbo1lguiT.oTavt2FbyTKwkh8aK3gL9TYZLsnglQVygl3SiI.EJOl9M_SY4EYK3
 6Bg9dl8xOUCh4NoUUTkmX3L48WZ9qHBkXrOAgpUT8vI76yOyTqDivS4GUJoTsHcJMQlUvz4jSIG5
 2q5xs8fwSGGaICKj109RHwYeZDNtkAyGeacSgRKV5z6QDnFWMNE0THbvjkvBkJigKyN3R7N6Vhwa
 p7NPpJrDn_Ivi_MPy16QEE0ht3q4WDxnvfSgdG6InKBS4V1PXEzlfptMq42vTGTSxmrto7mvKVRk
 dRAmV5KaDjzafm.Th08.70S2rRornFNyaPoRbeb_QW.etOa15ZPB3KkiSGrRPGdTRDqqpzwLGRP7
 lW6xo21PWddKipEngHfOOygIN1AXk0vY.IBcOU0O7d3jiRABQvOI7_N4j8n6ncvIgBAYOjlY5kt3
 gYlUuJGS1xEKI8gkTB9o9gJ8p51QH5ookWsrR_fbFKeYlO6zOrQ.4lYq6HocVDWPc.FgPjvzjxLL
 OJYrmo907H6rq0CLnxwSHE7T6ncBnAzxNkazx6ShBZOGpSJFYrHjgZw16s_HOceQrReDR4JlYeA4
 7h48ecwcsRYl2FTnRHor6L0B3JDe4OOXiui0DwZ4l0TBtrzJlFFkI0huYoftfNcDe2D4CHL4orJ7
 BtMlslQ6IzsCSsy.MqRUBnt5Y_rprfeNrFhtPmEouxZfpFiU1tV4tSGBVPRzebsdbTSQ0owo9XfJ
 B65drUEhJwotxT.5iuhAhPTVYtRKniyhlfUzUsjLUorCjFsMMbLRWYM01SxgU7ZbmNWU3hPT3ir7
 sfiv7.VW95QM8t3oiMAuOZb8lKDHm0PZEeMGVV2mpqPDNP1CNrHtby6l.dKhn7Xhe6fDEfaaulRQ
 kWG5CKkAoIVDAUSy3jsDilRcy1fHogrli1K2ICvh1AEhpr5tRTtD8nw2vMx2Q0H30VqBIsJgzMJV
 jXlX84I4SsSKq9yJAYYI_TOwDff271hhiGdCsE5rt3NgwgDkayzK6Xffc7Eyy57jrwvQFTHRNA6J
 fwM8OJwuAnzEV3.QLWPljxbyG_BunvRG04pE2S0GhCpw_FfHWQ.6sm_45oemxKK4WJx6cSTIjkdH
 xsfp7lLV0xcvi_QDzVuLgu7ZP80SXT0lAyQcmUNwXG2mCgB6rSmQ6LW5Fo6O3bIgqIH5E9stBDVx
 O0qEAIYuPyXu6buvrwzgvQJeuzBm5nqu5iNPeXuUASTWjNSrd8oAfE3WKISgerub1Tptqrx8KPaa
 Sy_BBe80d0gLBAxFSYCWj8YDH0dPtIpg-
X-Sonic-MF: <Capitain_Jack@yahoo.com>
X-Sonic-ID: 6f84a49b-375f-4db4-aad8-a0741cd48426
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-usea1-prod-sonicconsumer-svc-101 with HTTP;
 Tue, 22 Sep 2026 21:53:30 +0000
Received: from dip33.lsn.bf1.yahoo.com ([67.195.177.42])
 by hello (SMTP) with SMTP ID a34e68627d724ee34c25b40bae8a8d59;
 Tue, 22 Sep 2026 21:53:27 +0000 (UTC)
From: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
To: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org, lyude@redhat.com, dakr@kernel.org,
 Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Subject: [PATCH v2 2/3] drm/nouveau: pass HDMI GCP deep-color state through
 NVIF
Date: Tue, 22 Sep 2026 18:53:16 -0300
Message-ID: <20260922215317.611388-3-Capitain_Jack@yahoo.com>
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
 drivers/gpu/drm/nouveau/dispnv50/disp.c       | 40 ++++++++++++++++---
 drivers/gpu/drm/nouveau/include/nvif/if0012.h |  3 ++
 drivers/gpu/drm/nouveau/include/nvif/outp.h   |  2 +-
 drivers/gpu/drm/nouveau/nvif/outp.c           |  7 +++-
 .../gpu/drm/nouveau/nvkm/engine/disp/ior.h    |  2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/uoutp.c  |  6 +++
 6 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 028512f8767b..b183e1865bf5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -822,13 +822,14 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
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
@@ -839,8 +840,36 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	max_ac_packet -= 18; /* constant from tegra */
 	max_ac_packet /= 32;
 
+	/* HDMI 1.4b section 6.5.3 GCP encodings, extended from NVIDIA's
+	 * 36-bpp construction: CD is 5/6/7 for 30/36/48-bpp and PP is the
+	 * packing phase of the last pixel in the packing group (wire 0 is
+	 * phase 4, per NVIDIA's nvtiming.h phase constant numbering).
+	 * 48-bpp groups contain one pixel, so PP is always 4 (zero);
+	 * 36-bpp groups contain two pixels and 30-bpp groups four, so PP
+	 * follows the pixel count of the final group.
+	 */
+	if (bpc == 16) {
+		gcp_cd = 7;
+	} else if (bpc == 12 || bpc == 10) {
+		const u32 pixels = mode->crtc_hdisplay +
+				   (mode->crtc_hblank_end - mode->crtc_hsync_end);
+
+		if (bpc == 12) {
+			gcp_cd = 6;
+			gcp_pp = (pixels & 1) ? 1 : 2;
+		} else {
+			gcp_cd = 5;
+			gcp_pp = pixels & 3;
+		}
+	}
+
 	if (nv_encoder->i2c && hdmi->scdc.scrambling.supported) {
-		const bool high_tmds_clock_ratio = mode->clock > 340000;
+		/* Deep Colour raises the TMDS character rate above the pixel
+		 * clock; the HDMI 2.0 340 MHz scrambling and clock-ratio
+		 * thresholds apply to the character rate.
+		 */
+		const u32 tmds_char_clock = nv50_outp_link_clock(mode) * bpc / 8;
+		const bool high_tmds_clock_ratio = tmds_char_clock > 340000;
 		u8 scdc;
 
 		ret = drm_scdc_readb(nv_encoder->i2c, SCDC_TMDS_CONFIG, &scdc);
@@ -863,7 +892,7 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 
 	ret = nvif_outp_hdmi(&nv_encoder->outp, nv_crtc->index, true, max_ac_packet, rekey,
 			     mode->clock, hdmi->scdc.supported, hdmi->scdc.scrambling.supported,
-			     hdmi->scdc.scrambling.low_rates);
+			     hdmi->scdc.scrambling.low_rates, gcp_cd, gcp_pp);
 	if (ret)
 		return;
 
@@ -1628,7 +1657,7 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *s
 
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
 		nvif_outp_hdmi(&nv_encoder->outp, head->base.index,
-			       false, 0, 0, 0, false, false, false);
+			       false, 0, 0, 0, false, false, false, 0, 0);
 		nv_encoder->hdmi.enabled = false;
 	}
 
@@ -1844,7 +1873,8 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 		if (disp->disp->object.oclass != NV50_DISP &&
 		    nv_connector->base.display_info.is_hdmi)
-			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda);
+			nv50_hdmi_enable(encoder, nv_crtc, nv_connector, state, mode, hda,
+					 asyh->or.bpc);
 
 		if (nv_encoder->outp.or.link & 1) {
 			proto = NV507D_SOR_SET_CONTROL_PROTOCOL_SINGLE_TMDS_A;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
index bde9bfae8d11..ebfa60f98252 100644
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
index bc122a5ba7df..3d5ed53fd13c 100644
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
index 8cf4775a0a1e..4456264512eb 100644
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
index 5d682a774f2d..fcf624cff976 100644
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
index 377d0e0cef84..dff75d7257ac 100644
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

