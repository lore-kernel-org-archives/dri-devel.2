Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F554C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA6910F778;
	Fri, 14 Aug 2026 23:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fI8f8iVN";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1D910F778
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:59:02 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso8072265e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751941; x=1787356741; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fMGRuxtkoqwvkegb2VQwtKr99OBFpwpDX/9kGruR5sw=;
 b=fI8f8iVNYpM3ZWvX+tmW9n4Qtj6ZsfOMgwSKQByI/SjZQ8iMhk3z1uh6BvFh2BWImp
 jY7WSphV5OP1mGz32/3qAJ3BhvkuK2eLub7ozvZjVArnvEKnD97tSzJULCuck0C5qt60
 L7MjJXInzjPU2oYR5Gl/KGn0e34lzOPiCzjCZG5is2cHkNnHFJH3nTVuir1lLjpMkihW
 RQBcVqDAECJ1OwFR3zQrSHkaPYNvanOGX1iqRUY7UNA3px+dH847wVlswbX12Ncu3PXE
 5+y2BoNKGp+jl5vr9uQlqKw9pcOMvQAkliX66K+zkB46r2Mqpi+QZCW/Lkx6Zn0+cLAW
 K2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751941; x=1787356741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fMGRuxtkoqwvkegb2VQwtKr99OBFpwpDX/9kGruR5sw=;
 b=NvnAw6apsdQ+wd+hs7AO7dFWOn2RHU4tleT0Ju5LaxViF9fbMa5f+/tk91ABUXeP5v
 zInetmZ4WiU1dyt8B8cLVfOyzNkIpDuy3UYkyjQ6L0CWmWr1MEiYZ0nOJG3LO5REt7W5
 oONbSgvqWhnip0Yg3CUq58jbugevMRqOpd4MapVw9DNybquWyyaWOHueff9y0CG7Fwjg
 epKyM57puzUR7jcgv9zvX83iMCYUaL9YhWeS0tcf/K0c6ad+ZZdCG/L736q9qhU5lE/W
 TyL3RZPp6ROzkPmjNp1x5ewiquoVJ9263ctN5Z1i3xs+NMG9KuLHSegcVOqGrMy0NI8m
 hShw==
X-Gm-Message-State: AOJu0Yz5uGqRhn0osPYX/bcwm4gFkPGQZSphSEMLh+ysT6XI4fazdJ4T
 bwUJgFQ1g/K1j0Y+OI30elFpXVrujqrLJfCOOWWeW24OIUddwkU2T6Co
X-Gm-Gg: AR+sD11GSEvw5FnjO2Q/lSIBPL6hFOflQmAA7AvqxziRDH3G1UPrn1672ZpjMCPQTAt
 iVILv/m4oNZvzfwY+0e0Eodrbb76HYWeWVJ8hBuKNwmYZfU6wAWuUhtWxbb+ezMR1z3vpYUsnWa
 CxpZ0f4fJvdw8OYwfqrjat71gnfriPtOTNSYDB2K9DbBzKokOEy5arI8nElybINK3X+0weHoMos
 vnulz8gSThOE21REjFXnf3mcKReZi8WDv9MMeQbpq5L8tZ4O9cCkfpu0wNm/2vEixuDTNwM88gs
 Sgp2s8GPhmCoN3U/SbxYLV9u1CLbzodyNqfL2jdYDHlbnM4oc4DAk8Ebcq0i/q1u36cxBCT5nc2
 vY+eiWtTWJq5iHX9WmH9kc/fUQndhfMLyuChf1Gp6T4yK1mUjKW7Go1WmlUSR8F0+/oUgTD7pme
 gcTdO26v7UroKip+ExFWcvJnAeAqUgb79niXbu9z9QVlhj/EHBom+pcr/NLeBY21sSUE5sidQE
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-49988073627mr107955575e9.13.1786751941266; 
 Fri, 14 Aug 2026 16:59:01 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:59:00 -0700 (PDT)
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
Subject: [PATCH 5/7] nouveau/gsp: fix vblank interrupts on GB20x
Date: Sat, 15 Aug 2026 03:57:03 +0400
Message-ID: <20260814235705.59132-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
References: <20260814235705.59132-1-mohamedahmedegypt2001@gmail.com>
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
   head*4 (570.144 kernel_head_0501.c and v05_01 dev_disp.h. (Renamed
   kernel_head_0502.c in 610 releases)).

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

Select the head functions and the interrupt handler per generation in
r535_disp_oneinit(), keyed on the display root class from the RM GPU
table like the SOR split. Translate the low-latency interrupt table as a
second NVKM_ENGINE_DISP instance, attach the handler to it on GB20x, and
retrigger the vector after servicing.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 63 ++++++++++++++++++-
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  8 +++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index dd632767aea5..248ed6368e48 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -696,6 +696,33 @@ r535_head = {
 	.vblank_put = r535_head_vblank_put,
 };
 
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
+static const struct nvkm_head_func
+gb202_head = {
+	.state = r535_head_state,
+	.vblank_get = gb202_head_vblank_get,
+	.vblank_put = gb202_head_vblank_put,
+};
+
 static struct nvkm_conn *
 r535_conn_new(struct nvkm_disp *disp, u32 id)
 {
@@ -1496,6 +1523,20 @@ r535_disp_intr(struct nvkm_inth *inth)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t
+gb202_disp_intr(struct nvkm_inth *inth)
+{
+	struct nvkm_disp *disp = container_of(inth, typeof(*disp), engine.subdev.inth);
+	irqreturn_t ret = r535_disp_intr(inth);
+
+	/* The FE interrupt vectors are message-based on NVD5.0. Re-arm the
+	 * low-latency vector so it fires again for any event that latched
+	 * while we were servicing.
+	 */
+	nvkm_wr32(disp->engine.subdev.device, 0x611f34, 0x00000001);
+	return ret;
+}
+
 static void
 r535_disp_fini(struct nvkm_disp *disp, bool suspend)
 {
@@ -1568,7 +1609,9 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 	struct nvkm_device *device = disp->engine.subdev.device;
 	struct nvkm_gsp *gsp = device->gsp;
 	const struct nvkm_rm_api *rmapi = gsp->rm->api;
+	const struct nvkm_rm_gpu *gpu = gsp->rm->gpu;
 	NV2080_CTRL_INTERNAL_DISPLAY_WRITE_INST_MEM_PARAMS *ctrl;
+	nvkm_inth_func intr_func;
 	unsigned long mask;
 	int ret, i;
 
@@ -1722,7 +1765,12 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 		nvkm_gsp_rm_ctrl_done(&disp->rm.objcom, ctrl);
 
 		for_each_set_bit(i, &disp->head.mask, disp->head.nr) {
-			ret = nvkm_head_new_(&r535_head, disp, i);
+			const struct nvkm_head_func *func = &r535_head;
+
+			if (gpu->disp.class.root >= GB202_DISP)
+				func = &gb202_head;
+
+			ret = nvkm_head_new_(func, disp, i);
 			if (ret)
 				return ret;
 		}
@@ -1766,12 +1814,21 @@ r535_disp_oneinit(struct nvkm_disp *disp)
 	if (ret)
 		return ret;
 
-	ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, disp->engine.subdev.inst);
+	if (gpu->disp.class.root >= GB202_DISP) {
+		/* GB20x deliver head-timing interrupts on the display's
+		 * separate low-latency vector (interrupt table instance 1).
+		 */
+		ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, 1);
+		intr_func = gb202_disp_intr;
+	} else {
+		ret = nvkm_gsp_intr_stall(gsp, disp->engine.subdev.type, disp->engine.subdev.inst);
+		intr_func = r535_disp_intr;
+	}
 	if (ret < 0)
 		return ret;
 
 	ret = nvkm_inth_add(&device->vfn->intr, ret, NVKM_INTR_PRIO_NORMAL, &disp->engine.subdev,
-			    r535_disp_intr, &disp->engine.subdev.inth);
+			    intr_func, &disp->engine.subdev.inth);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index 996941c668ba..2590b22663cb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -44,6 +44,14 @@ r570_gsp_xlat_mc_engine_idx(u32 mc_engine_idx, enum nvkm_subdev_type *ptype, int
 		*ptype = NVKM_ENGINE_DISP;
 		*pinst = 0;
 		return true;
+	case MC_ENGINE_IDX_DISP_LOW:
+		/* GB20x+ report a separate low-latency display vector, used
+		 * for head-timing interrupts. Expose it as a second DISP
+		 * interrupt instance.
+		 */
+		*ptype = NVKM_ENGINE_DISP;
+		*pinst = 1;
+		return true;
 	case MC_ENGINE_IDX_CE0 ... MC_ENGINE_IDX_CE19:
 		*ptype = NVKM_ENGINE_CE;
 		*pinst = mc_engine_idx - MC_ENGINE_IDX_CE0;
-- 
2.55.0

