Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C664AC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232DE10E216;
	Thu, 20 Aug 2026 16:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNjm17SA";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78A710E171
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:59 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so563625e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244658; x=1787849458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PblTzKwEMx0jDI4oVKpj3IJS/TAZT0OEcT+54p3qrbc=;
 b=KNjm17SAAfEJuBF28OhZJMDup5SJJm8h/o/F65iHgZbEabWg7U6jePL1mu1Y4LHjsK
 qLEvHFdpTvHnFHuvmg2C8LPx6dyGJwg7g1GaTZnKLS86UTm6kljbkZbCZqVavZV4/4oS
 xO5PEkDW0Ws8HDy5TYxe9M0i6ZYGOtJHpYX/kAyeF717PCw5MbH6stIIVwJS/9pbjytK
 gRNf1NpEgZAXiIuB5mxMPuww2Ss3YbFswWYtzVkz4XVTqr5WqBxcStABh3Sj0wadCyid
 3UzWXwQQGPChjBBt2F1cl9Rb+3gLycpGpHO3glw/X0BwL1U8BEBlpYRCN18N+elgGmHc
 eHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244658; x=1787849458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PblTzKwEMx0jDI4oVKpj3IJS/TAZT0OEcT+54p3qrbc=;
 b=dNlALcCI49rIX0/OQwLL81O466NeqbPf9fYf+1dvJ4fTppjgzY81ii5uQRJPoJnTQn
 KSfn0i4j6iBik8gKIo9OVFMoFydqVJT4tEmLB308bSKsonFxD4eSJLRvLflfyCn3ttiK
 Y9ON5Dn/QRhFqD8XRk78G5p4Gu0LElV9nJvsraxg6rQss9oeUHT++CG0iblVFgG5eyMl
 qYIzQQyQVUVBVcBq6P4Oeo4w32jlxgcQADFqQbF9kWoZnRmkPNaNPH+SFXFAfS+k+fRw
 yRUzRB+/qJQp2xNubX2imvYb5i012Tc0ccSXEh8aDJ1DgEzB45BlYvCLFDkNeDvEMI+r
 oGYA==
X-Gm-Message-State: AOJu0Yx5U/oc7KmwowKdK8OPPO4RniPjATmyOBXcv5fK48Tn1AxwN8gC
 KXbox9VJEOAn7ogLjbodT+oSu2amoiNtxxSPPtA/JI28uMfu8ZXnVR2cTe5Nqto7
X-Gm-Gg: AR+sD11EAiUAmpP6OnK94aMSTurgvH+QCSXXqT4Edc1eiW6XbkmVbsjR/f8Fb72VKWi
 8UuzhpknpoeT5Kn/wbuK/+4+5pdhOwzpxFQ/7hOAaupOk/08cRR4M+WzaC2Dvpt23RnDIGCoGg2
 auCbQh2LG3Z1hW5tAVEXJS3/ReObi1r7wiBDAAkp6i7qGuoTHBHG10nz0fo6tXnpk64WDvf8cSV
 7lv23Rzrw+Ekh5pJaXTJOqWu2iTf539D7VJQsBFFP0vvNlSwTToV4U0YtFw9vkifHdMkNJrvl2r
 /b5vtPGmNtk3jYM8ybkhGDni6mr0bXjCP53uAovEgACUQCdyOafjJgGVcU2vuFPpBTM5V6tAj8q
 /HzPz8IixFrw3XiTvAQ8rnlnrerKXRqyw0xqhquPPKS44SGHbRpuHfBextTasNdXaxuo7yJVSrn
 hkyqlJ9akZsKZ3/0JDyNAQBJFriFU8CIM52Izz6AddnyUHftVzRH/m9P8gtZ/+eYjtf/Q=
X-Received: by 2002:a05:600c:1910:b0:499:5f7a:7ea2 with SMTP id
 5b1f17b1804b1-499b845c7d9mr2645455e9.12.1787244657983; 
 Thu, 20 Aug 2026 09:50:57 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:56 -0700 (PDT)
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
Subject: [PATCH v2 08/10] drm/nouveau/gsp: fix vblank interrupts on GB20x
Date: Thu, 20 Aug 2026 20:49:27 +0400
Message-ID: <20260820164929.17117-9-mohamedahmedegypt2001@gmail.com>
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

The GSP path programs per-head timing (vblank) interrupts the same way on
every generation. NVD5.0 (GB20x) reworked the FE interrupt frontend
around four message-based kernel vectors (high latency, low latency, PMU,
and GSP) and moved RM head-timing interrupts to the dedicated low-latency
vector:

 - The enable is NV_PDISP_FE_RM_INTR_EN1_HEAD_TIMING, 0x611ef0 +
   head*4 (570.144 kernel_head_0501.c, renamed kernel_head_0502.c from
   575.51.02 on, and v05_01 dev_disp.h).

 - The vector is reported as a separate interrupt table entry,
   MC_ENGINE_IDX_DISP_LOW (intr_gb202.c, intrCacheDispIntrVectors).

 - The vector must be re-armed through NV_PDISP_FE_INTR_RETRIGGER(1)
   at 0x611f34 after servicing (kdispServiceInterrupt ->
   kdispIntrRetrigger_v05_01).

The event latch (0x611800), per-head status (0x611c00), and dispatch
summary (0x611ec0) the interrupt handler uses are unchanged on GB20x
(kheadReadPendingVblank_v03_00 and kheadResetPendingLastData_v03_00
remain for DISPv0502+).

On GB20x the old code enables head timing onto the legacy vector, leaves
its handler there, and never re-arms the message-based vectors. Page
flips still complete (nv50 sends those events from the commit path), so
the desktop looks fine while DRM vblank waits and vblank sequence queries
are affected.

Supply GB20x vblank enables and an interrupt handler that re-arms the
vector after servicing through gb202_gsp_disp, translate the low-latency
interrupt table entry as a second NVKM_ENGINE_DISP instance, and flag
the table so r535_disp_oneinit() attaches the handler to that instance.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 42 +++++++++++++++++--
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    |  5 ++-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  9 ++++
 3 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index a66c820be9fe..f78669bafd64 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -130,6 +130,40 @@ gb202_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
 	}
 }
 
+/* NVD5.0 (GB20x and later) moved the RM head-timing interrupt enable to
+ * the low-latency vector's EN1 block. The event latch is unchanged.
+ */
+static void
+gb202_head_vblank_put(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002, 0x00000000);
+}
+
+static void
+gb202_head_vblank_get(struct nvkm_head *head)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+
+	nvkm_wr32(device, 0x611800 + (head->id * 4), 0x00000002);
+	nvkm_mask(device, 0x611ef0 + (head->id * 4), 0x00000002, 0x00000002);
+}
+
+static irqreturn_t
+gb202_disp_intr(struct nvkm_inth *inth)
+{
+	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
+	irqreturn_t ret = tu102_disp_intr(inth);
+
+	/* The FE interrupt vectors are message-based on NVD5.0. Re-arm the
+	 * low-latency vector so it fires again for any event that latched
+	 * while we were servicing.
+	 */
+	nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
+	return ret;
+}
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -137,11 +171,13 @@ static const struct nvkm_disp_func
 gb202_gsp_disp = {
 	.uevent = &gv100_disp_chan_uevent,
 	.ramht_size = 0x2000,
-	.gsp.intr = tu102_disp_intr,
+	/* Head timing arrives on the dedicated low-latency vector. */
+	.gsp.intr = gb202_disp_intr,
+	.gsp.intr_low_latency = true,
 	.gsp.head_state = gb202_head_state,
 	.gsp.head_rgpos = gv100_head_rgpos,
-	.gsp.vblank_get = tu102_head_vblank_get,
-	.gsp.vblank_put = tu102_head_vblank_put,
+	.gsp.vblank_get = gb202_head_vblank_get,
+	.gsp.vblank_put = gb202_head_vblank_put,
 	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index 3a8ff621ed62..a95f78c4502f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1705,7 +1705,10 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 
 	/* Chips that raise head-timing interrupts on a separate low-latency
 	 * vector report it as a second DISP interrupt table entry, exposed
-	 * as instance 1 by the RM engine-index translation.
+	 * as instance 1 by the RM engine-index translation (see
+	 * r570_gsp_xlat_mc_engine_idx()). Their high-latency vector
+	 * (instance 0) is left unhandled as no event nouveau enables is
+	 * routed to it, and without a handler it stays masked.
 	 */
 	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type,
 				  disp->func->gsp.intr_low_latency ? 1 : disp->engine.subdev.inst);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 3e391646d8f7..b45781cd0dfd 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -44,6 +44,15 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx, enum nvkm_subdev_type *ptype, int
 		*ptype = NVKM_ENGINE_DISP;
 		*pinst = 0;
 		return true;
+	case MC_ENGINE_IDX_DISP_LOW:
+		/* GB20x+ report a separate low-latency display vector, used
+		 * for head-timing interrupts. Expose it as a second DISP
+		 * interrupt instance. r535_disp_oneinit() attaches the
+		 * handler to it when the chip's gsp.intr_low_latency is set.
+		 */
+		*ptype = NVKM_ENGINE_DISP;
+		*pinst = 1;
+		return true;
 	case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
 		*ptype = NVKM_ENGINE_CE;
 		*pinst = mc_engine_idx - MC_ENGINE_IDX_CE0;
-- 
2.55.0

