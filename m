Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD4C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0810F0E8;
	Thu, 20 Aug 2026 16:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5ukEF/j";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8850910F103
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:14 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47362928f65so117448f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244613; x=1787849413; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nZ6u9Bl+UeuSLChNk/rtttClrX+K1Z0lpt5z16O5QEc=;
 b=c5ukEF/jL+5EcAD/YfWwQp0BT7WVXyLTx/w/dm5+z9bAtQH5oVIyGrs7Cce+OO3KrT
 r/3ISwo4rPvEgoGsTmU43q5lIvOlHSZ4jXpTeTTzJ9XA4zdAmOlzhtYi6xNBQF6eFMk2
 LBSMjZ/xgwFMUJWgf0YnTy5GUv+QpGEvIWdF0Rdu+H9exzVBgS8l15TSnBZW4nGI5Qs8
 g7K8HJr4qOIUwqGmvIHbR+zGZayH9P+0RMeWjK+DRFp42gDNltuYLr1UInmGHvEZeV8k
 pUSYADlHxKOm3MIM4ld5ATBwwYvWaGcqizibqd52CDLRK6ZnAKd6gPmni6nF9Q+llcA6
 MDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244613; x=1787849413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nZ6u9Bl+UeuSLChNk/rtttClrX+K1Z0lpt5z16O5QEc=;
 b=LR/IvU1/LEHe1HdHdYi1oma3KmkqQgzyIDyqgOhWrRceidPi+NHkWi+nF8/te9WJ9U
 oF6FLNwuPyBEfq9RYNx/CAJWoLdUO7N/9oT1kkkgE3tspE1aSf3MbenNAZyLLtGVnkmU
 JPvSkeYZOnz/rrL20fHiSlgqNmhoWZwIPY/xnBwMGVPLajSdGWBHIVtH/xKarj/X1gHB
 TnOHLkmb9qBXnMCUo1LucDO6B5COm4VPsyMeDhAMsYjHc+stX3XTAF63HsuBfHrSjHFk
 tq6jVHNU1NUDjLvYhsWiwrqC8ctrI+ZuPotQlf0pDKPZmvv5WK2nqPFa7tEOb+Wb9LZi
 4NUA==
X-Gm-Message-State: AOJu0Yx58ARuMkF5Sxa0du4q3TdXPyuwrlGoY5uu1M2gsrGt8tHu90jm
 ZCdQTG/MltCWuWJ7Y2+bhPWP+wPF6fCxWaKhk0cf81pR43pvwFAVeyzb
X-Gm-Gg: AR+sD10iDtRIyQt8B2GbRRpYndIBEkT+HA3k1iNm+Mstgx0/tKoJ7zs0+OyX1AjTVdn
 T562tRReEauFI2WK9cLBZEQDeqCJm8CdBmFRN14Z+jMaZwdDH2Lm5lvDVoeRLwxKK5I2G/phAag
 Rgxb4BF6q8EclSg18Hyb92fwLtSdFKz4QX3vSQag2kwGOKfJNrrZngujDsSgdFpxTdoCrnjkOj8
 39y3vvnvl/x0PfoBJYAzv5LKUza0kV185n9Oirr3R0qrZtbe4pr7YEG7lV4h25RpfxotM/hvBNJ
 YObpnTaJi2eeEpRS4/uxvwoZixfg7W6l+muBCA2YFp2RDhHYqynNVbt1oC6Bo4ENzGttfEHfaSV
 QtxkUvi79fVYr92viRy8sfY7vQxJpMBiiWvu4bvl3K1fCRIvPlvcCsnaMWWtuYISPl7dGasJ9HL
 SBiukC6TCca5+Hp8e8BjnPYt0gvdBKtvahQcQ7nPoL9AEybEQ4mjRrUbp4eZZ8xTjZzWE=
X-Received: by 2002:a05:600c:3544:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-499b8301874mr4103855e9.7.1787244612602; 
 Thu, 20 Aug 2026 09:50:12 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:11 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH v2 01/10] drm/nouveau/disp: move GSP head-timing ISR and
 vblank helpers to tu102.c
Date: Thu, 20 Aug 2026 20:49:20 +0400
Message-ID: <20260820164929.17117-2-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
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

The GSP-RM display code in rm/r535/disp.c owns a handful of direct MMIO
routines: the head-timing (vblank) interrupt handler and the per-head
vblank enable/disable. They program display registers, not RM, so they
belong with the rest of the per-chip register code in engine/disp/.

Move them to tu102.c (Turing is the first GSP-capable generation) as
tu102_disp_intr() and tu102_head_vblank_get()/put(), exported for
rm/r535/disp.c, which keeps calling them by name for now. No functional
change.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/head.h   |  3 ++
 .../gpu/drm/nouveau/nvkm/engine/disp/priv.h   |  1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/tu102.c  | 50 ++++++++++++++++++
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 52 ++-----------------
 4 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index b642729c254f..986043e87554 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -56,6 +56,9 @@ int gv100_head_new(struct nvkm_disp *, int id);
 void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
 void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
+void tu102_head_vblank_get(struct nvkm_head *);
+void tu102_head_vblank_put(struct nvkm_head *);
+
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
 	nvkm_##l(&_h->disp->engine.subdev, "head-%d: "f"\n", _h->id, ##a);     \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
index a3fd7cb7c488..722ec340e12a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h
@@ -72,6 +72,7 @@ int gv100_disp_wndw_cnt(struct nvkm_disp *, unsigned long *);
 int gv100_disp_caps_new(const struct nvkm_oclass *, void *, u32, struct nvkm_object **);
 
 int tu102_disp_init(struct nvkm_disp *);
+irqreturn_t tu102_disp_intr(struct nvkm_inth *);
 
 void nv50_disp_dptmds_war_2(struct nvkm_disp *, struct dcb_output *);
 void nv50_disp_dptmds_war_3(struct nvkm_disp *, struct dcb_output *);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
index dcb9f8ba374c..7b70b466fa36 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c
@@ -104,6 +104,56 @@ tu102_sor_new(struct nvkm_disp *disp, int id)
 	return nvkm_ior_new_(&tu102_sor, disp, SOR, id, hda & BIT(id));
 }
 
+/* The GSP-RM display path leaves head-timing (vblank) interrupts and their
+ * enables to us. These program the RM head-timing line (bit 1 of the
+ * per-head enable, not the bit nvkm's own gv100 path uses).
+ */
+void
+tu102_head_vblank_put(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
+}
+
+void
+tu102_head_vblank_get(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
+	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
+}
+
+static void
+tu102_disp_intr_head_timing(struct nvkm_disp *disp, int head)
+{
+	struct nvkm_subdev *subdev = &disp->engine.subdev;
+	struct nvkm_device *device = subdev->device;
+	u32 stat = nvkm_rd32(device, 0x611c00 + (head * 0x04));
+
+	if (stat & 0x00000002) {
+		nvkm_disp_vblank(disp, head);
+
+		nvkm_wr32(device, 0x611800 + (head * 0x04), 0x00000002);
+	}
+}
+
+irqreturn_t
+tu102_disp_intr(struct nvkm_inth *inth)
+{
+	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
+	struct nvkm_subdev *subdev = &disp->engine.subdev;
+	struct nvkm_device *device = subdev->device;
+	unsigned long mask = nvkm_rd32(device, 0x611ec0) & 0x000000ff;
+	int head;
+
+	for_each_set_bit(head, &mask, 8)
+		tu102_disp_intr_head_timing(disp, head);
+
+	return IRQ_HANDLED;
+}
+
 int
 tu102_disp_init(struct nvkm_disp *disp)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index e77733a5d9c3..8e57bb6519e5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -608,29 +608,12 @@ r535_sor_cnt(struct nvkm_disp *disp, unsigned long *pmask)
 	return 4;
 }
 
-static void
-r535_head_vblank_put(struct nvkm_head *head)
-{
-	struct nvkm_device *device = head->disp->engine.subdev.device;
-
-	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000000);
-}
-
-static void
-r535_head_vblank_get(struct nvkm_head *head)
-{
-	struct nvkm_device *device = head->disp->engine.subdev.device;
-
-	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
-	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
-}
-
 static const struct nvkm_head_func
 r535_head = {
 	.state = gv100_head_state,
 	.rgpos = gv100_head_rgpos,
-	.vblank_get = r535_head_vblank_get,
-	.vblank_put = r535_head_vblank_put,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
 };
 
 static struct nvkm_conn *
@@ -1404,35 +1387,6 @@ static const struct nvkm_event_func
 r535_disp_event = {
 };
 
-static void
-r535_disp_intr_head_timing(struct nvkm_disp *disp, int head)
-{
-	struct nvkm_subdev *subdev = &disp->engine.subdev;
-	struct nvkm_device *device = subdev->device;
-	u32 stat = nvkm_rd32(device, 0x611c00 + (head * 0x04));
-
-	if (stat & 0x00000002) {
-		nvkm_disp_vblank(disp, head);
-
-		nvkm_wr32(device, 0x611800 + (head * 0x04), 0x00000002);
-	}
-}
-
-static irqreturn_t
-r535_disp_intr(struct nvkm_inth *inth)
-{
-	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
-	struct nvkm_subdev *subdev = &disp->engine.subdev;
-	struct nvkm_device *device = subdev->device;
-	unsigned long mask = nvkm_rd32(device, 0x611ec0) & 0x000000ff;
-	int head;
-
-	for_each_set_bit(head, &mask, 8)
-		r535_disp_intr_head_timing(disp, head);
-
-	return IRQ_HANDLED;
-}
-
 static void
 r535_disp_fini(struct nvkm_disp *disp, bool suspend)
 {
@@ -1708,7 +1662,7 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    r535_disp_intr, &disp->engine.subdev.inth);
+			    tu102_disp_intr, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
-- 
2.55.0

