Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB34C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC0B10E358;
	Tue, 25 Aug 2026 00:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J6HgnYql";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57ADD10E588
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:14:58 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-482d9ddf129so184962f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616897; x=1788221697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d/NYE+hsr/DHtPZiO0MS/H4/xrbfs8tes2shrGKnSKU=;
 b=J6HgnYqlvIRyBs9UBaAX5GVPX3s8Od7JkFZkm/252jyli0A9FCkiYiLOsqg65CBRe9
 wMZdRsOSxrg79ZfNsp8uAQocYLV9RH4Qjh92Law26KvQ30xKCXpe6ufR0whSzmDxJyTw
 Hn5QKci/72mxrkLgmg/NlOd1XZWbg6ICvMB6xwkLsbeeKQrmzqGBGBpF/SPFlQBS9Y1r
 9MnabDM77jYSDFA+A/c89pAoTM+s9um3c8mUuYfb5GFhuWOLs8cbECP7Bdl2xC+rnTPa
 /okkjEwPLcPb0rbwqDHAMw0/OljWKA8Rm+R7juvMPWZWYT4AwOSeKwIC92a2cjrAHFL5
 xJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616897; x=1788221697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d/NYE+hsr/DHtPZiO0MS/H4/xrbfs8tes2shrGKnSKU=;
 b=Q3SEtv694m/lMQS4+AOnivcIIMnewDXgnuto3IT6STJDQC3eDKIfwjzcRp8KGz7nRA
 bJpzdQjnEh3HSTGyqeXfI46MtU4Y7efS/4xFYihnXEmEMSZjON/njmq6eoHR7Ob6YfgL
 YZfeQOiFS+qev+frcq7KmqU90zhTI9h3pZCy7vEJ3UByAhQuIx15A19m8E3UqkKbbq3B
 FXLK9zIqJ0gH3cIVdWXb13OZMZTE7envl5lBntz7uKU5zkmV7OpzfctfaETyKAGO/xfU
 GY0ulin0Rz0QtaAOl3tafCbIKPgZMhjJmGWu8Ip5XVGcGYhcLSCrY53QJtG/iGeqF3I+
 FiDw==
X-Gm-Message-State: AFuF++nnmP3TOjpQMQAYdU6OV+usC2EG8vnkh0U51e7fC2b7aiU4mdYC
 KNO9hvLF6MEjk4p53YCMsaeYJ7PcF2oAV+d5QX17f2nXh7bO7oYPcBkA
X-Gm-Gg: AR+sD13I2IhEnRCQF75qrTPOyq8gxRcDTCpWL2Srt8pjpO/n3XPP9XAwtfvhBgiZDuQ
 KJlYGpkJlJqB547kpmNS54Kk61hraddQMSxHHLu2DK/Og8ND3aZ9bIO6L7fHdRQWcOGBkM3hdvK
 c3fJzwqitpFXZbJgY7oMO0CZvcoTV2Uuz2B9Tlxryr/2gNK0FEcLHCVs/5kTbWpOSRHKKiAQfWw
 P2czNt4gJYfUG5hgdmg6ml4GxsUdZidYglL9C/vcGBGntvPcgF0n0kj/q+YHfuR5GpJ4hdjr1Y4
 uNxK1pOpFsvkfKfTX/HrgaI6upMUWAS4wsYO3T7w2LKX552bIl8fdyqmMH9x9vZ3Xfuu/et7wuq
 ESmCqH2k2Bb2X2UZwMV5XmH4WKoCpfxK1i3mwLGAA+GVNFqmMByxb/xqW4FEXoUYYFcXOYjD8XN
 En28N8vU8hNbGSZ+FUj7Y264/0pKivxKOa4ytoUm+w+s/r79NP22PsaMgH6rQRn/BNR6sG2owTu
 prwnw==
X-Received: by 2002:a05:6000:2f88:b0:47f:6f6a:6a7f with SMTP id
 ffacd0b85a97d-482c817b196mr24504551f8f.8.1787616896742; 
 Mon, 24 Aug 2026 17:14:56 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:14:55 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v3 03/10] drm/nouveau/disp: route GSP-RM display MMIO through
 nvkm_disp_func hooks
Date: Tue, 25 Aug 2026 04:14:01 +0400
Message-ID: <20260825001408.14219-4-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
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

The GSP-RM display code in rm/r535/disp.c borrows a few
register-programming routines from engine/disp (the head-timing
interrupt handler, vblank enables, armed head state and scanout position
readback, the AVI/VSI infoframe writers and the GCP AVMute write) and so
far picked them by name, which means it has to know which chip it runs
on the moment a generation changes any of them.

Give nvkm_disp_func a .gsp table that each chip fills with exactly those
hooks, add tu102_gsp_disp (TU1xx) and ga102_gsp_disp (GA10x onwards)
carrying the current functions, hand them to r535_disp_new() instead of
the full hardware tables, and make rm/r535/disp.c call through the
hooks. The head hooks are a whole nvkm_head_func, so r535_head goes away
and the chip's own table is handed to nvkm_head_new_(). r535_sor_hdmi
gets infoframe forwarders, r535_sor_hdmi_audio() calls the GCP hook, and
the interrupt handler comes from the table. The tables are per chip even
though the two currently coincide, so a generation that changes a hook
only touches its own file.
rm/r535/disp.c no longer contains chip-specific register code, and a new
display generation only has to provide its own table. No functional
change.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/ga102.c  | 13 +++++++-
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   | 14 +++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 21 ++++++++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 31 +++++++++++--------
 5 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
index ab0a85c92430..820834b5ee9b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
@@ -144,12 +144,23 @@ ga102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+ga102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head = &tu102_gsp_head,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 ga102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&ga102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&ga102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&ga102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 986043e87554..784521c2aca1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -58,6 +58,7 @@ void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
 void tu102_head_vblank_get(struct nvkm_head *);
 void tu102_head_vblank_put(struct nvkm_head *);
+extern const struct nvkm_head_func tu102_gsp_head;
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index 722ec340e12a..a9dbda67a7d4 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -5,6 +5,8 @@
 #include <engine/disp.h>
 #include <core/enum.h>
 struct nvkm_head;
+struct nvkm_head_func;
+struct nvkm_ior;
 struct nvkm_outp;
 struct dcb_output;
 
@@ -34,6 +36,18 @@ struct nvkm_disp_func {
 		int (*new)(struct nvkm_disp *, int id);
 	} wndw, head, dac, sor, pior;
 
+	/* Register programming that the GSP-RM display path (rm/r535) needs from
+	 * the chip, everything else on that path goes through RM. The hooks are
+	 * called unconditionally and the head table is handed to nvkm_head_new_().
+	 */
+	struct {
+		irqreturn_t (*intr)(struct nvkm_inth *);
+		const struct nvkm_head_func *head;
+		void (*hdmi_gcp)(struct nvkm_ior *, int head, bool enable);
+		void (*hdmi_infoframe_avi)(struct nvkm_ior *, int head, void *data, u32 size);
+		void (*hdmi_infoframe_vsi)(struct nvkm_ior *, int head, void *data, u32 size);
+	} gsp;
+
 	u16 ramht_size;
 
 	struct nvkm_sclass root;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index 6cfd52c9056f..948b1d2f954c 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -140,6 +140,14 @@ tu102_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
 }
 
+const struct nvkm_head_func
+tu102_gsp_head = {
+	.state = gv100_head_state,
+	.rgpos = gv100_head_rgpos,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
+};
+
 static void
 tu102_disp_intr_head_timing(struct nvkm_disp *disp, int head)
 {
@@ -295,12 +303,23 @@ tu102_disp = {
 	},
 };
 
+static const struct nvkm_disp_func
+tu102_gsp_disp = {
+	.uevent = &gv100_disp_chan_uevent,
+	.ramht_size = 0x2000,
+	.gsp.intr = tu102_disp_intr,
+	.gsp.head = &tu102_gsp_head,
+	.gsp.hdmi_gcp = tu102_sor_hdmi_gcp,
+	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
+	.gsp.hdmi_infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+};
+
 int
 tu102_disp_new(struct nvkm_device *device, enum nvkm_subdev_type type, int inst,
 	       struct nvkm_disp **pdisp)
 {
 	if (nvkm_gsp_rm(device->gsp))
-		return r535_disp_new(&tu102_disp, device, type, inst, pdisp);
+		return r535_disp_new(&tu102_gsp_disp, device, type, inst, pdisp);
 
 	return nvkm_disp_new_(&tu102_disp, device, type, inst, pdisp);
 }
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index cd4451e62512..bf97edcdfc95 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -547,7 +547,19 @@ r535_sor_hdmi_audio(struct nvkm_ior *sor, int head, bool enable)
 {
 	r535_sor_hdmi_ctrl_audio(sor->asy.outp, enable);
 	r535_sor_hdmi_ctrl_audio_mute(sor->asy.outp, !enable);
-	tu102_sor_hdmi_gcp(sor, head, enable);
+	sor->disp->func->gsp.hdmi_gcp(sor, head, enable);
+}
+
+static void
+r535_sor_hdmi_infoframe_avi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_avi(sor, head, data, size);
+}
+
+static void
+r535_sor_hdmi_infoframe_vsi(struct nvkm_ior *sor, int head, void *data, u32 size)
+{
+	sor->disp->func->gsp.hdmi_infoframe_vsi(sor, head, data, size);
 }
 
 static void
@@ -575,8 +587,8 @@ r535_sor_hdmi = {
 	.ctrl = r535_sor_hdmi_ctrl,
 	.scdc = r535_sor_hdmi_scdc,
 	/*TODO: SF_USER -> KMS. */
-	.infoframe_avi = gv100_sor_hdmi_infoframe_avi,
-	.infoframe_vsi = gv100_sor_hdmi_infoframe_vsi,
+	.infoframe_avi = r535_sor_hdmi_infoframe_avi,
+	.infoframe_vsi = r535_sor_hdmi_infoframe_vsi,
 	.audio = r535_sor_hdmi_audio,
 };
 
@@ -601,14 +613,6 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned long *pmask)
 	return 4;
 }
 
-static const struct nvkm_head_func
-r535_head = {
-	.state = gv100_head_state,
-	.rgpos = gv100_head_rgpos,
-	.vblank_get = tu102_head_vblank_get,
-	.vblank_put = tu102_head_vblank_put,
-};
-
 static struct nvkm_conn *
 r535_conn_new(struct nvkm_disp *disp, u32 id)
 {
@@ -1606,7 +1610,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 
 		for_each_set_bit(i, &disp->head.mask, disp->head.nr) {
-			ret = nvkm_head_new_(&r535_head, disp, i);
+			ret = nvkm_head_new_(disp->func->gsp.head, disp, i);
 			if (ret)
 				return ret;
 		}
@@ -1655,7 +1659,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    tu102_disp_intr, &disp->engine.subdev.inth);
+			    disp->func->gsp.intr, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
@@ -1688,6 +1692,7 @@ r535_disp_new(const struct nvkm_disp_func *hw, struct nvkm_device *device,
 	rm->uevent = hw->uevent;
 	rm->sor.cnt = r535_sor_cnt;
 	rm->sor.new = r535_sor_new;
+	rm->gsp = hw->gsp;
 	rm->ramht_size = hw->ramht_size;
 
 	rm->root.oclass = gpu->disp.class.root;
-- 
2.55.0

