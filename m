Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D14C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 00:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A78710E588;
	Tue, 25 Aug 2026 00:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="psVV0XJe";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1EA010E588
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 00:15:21 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso1328731f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 17:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787616920; x=1788221720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PE18UOnUU3vtHd95e5x4c1/cDuJ6Y/PBPwnRKByDmzE=;
 b=psVV0XJe8qYFJo/YaQf8UwzBA6II87K9hRPAYlPZ2Cf1y1hC+nGA/zYnAiSPht8TcS
 iBnn00GIR8njjDLZ7TBGUuv6XeSXPsgK8JRcmz5g22dLF6D8TC+hJHUhd1V8RmhIFKAz
 HxeuMaKQYOrhWNz8Sd1/febf2R+uJ3wDGXZfAuYOfachv4ScCPhMW4KPPS1ndXdlRpjF
 Kqmu5JBrydcMeGzdJ4eVJW6KI6rwrT/6dIMLL3TH6rTHeTerdnGAVIqDQChWTC39op+o
 Koe+9IzDg5clQI5yVCgrHloxzMvRPalgV6/4Pj5vygs37VixGJy0f/9RrjjHxwnseQ5M
 7MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787616920; x=1788221720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PE18UOnUU3vtHd95e5x4c1/cDuJ6Y/PBPwnRKByDmzE=;
 b=mxo9Yk27IWOp+rcstKQa9O1gk5vEwBERT5JRQzqSPSMCHYj1CDVO8jGxvO3BFyj0JM
 OTlxSeiWrSRfn/t/gYQmzejlawNVaZv5KhW2jD3MDjHOMXLs3FnajN6RgAr2wFQKIuS1
 YcyU6MJregmP4DKeZdz04WRneRYJxabrcbSZDYEvGqB55OfOyefj2xdIslTy/pDqPr81
 bcsEOHxWYV9oN0QQsYL/hHK55YrR2WGebXYcmkEnz2kTXnuMH93Mt+d5rZdCNbm8rTIJ
 gUD2PtU34V6kRGDRh8FPIQv0L38kQSDklX6qo5wuieZiLavkRh3oQpN8h4J6ygLLiAbG
 5XrA==
X-Gm-Message-State: AFuF++nonQXMtmN149Fa8kaUUqA4agIoffbwK5ANjGb9iVVN4fXR+6eM
 wVnDVVOAC3shJw4U1CXMTZFJjJiaQ40pk1DJZFa6O6f/Sfwz7vO1FL+D
X-Gm-Gg: AR+sD12L5EJH+TGg5IYQRDx6lNSmxrobMDZktXfTQdDj0IG8/q5EQymvnwWW1297Sl4
 n/rAp7/owGWVP+NxzzHQOTJ2ckTs4ypyHYil5cwRPSkc/8tZs+K6dh/vbU67YFlchn4SvwU67ML
 ku8Mx3bwklnk4+CPXJsNHpCz7c792X50ZTxaSSv+kAv8pmBXA16c1wvSqh9q4A+FjjnF/258i9N
 T67HbVAtZt2H7Nmt57cqCqJXAz2q0UknhzUuZK6v/0h2Ojjq8Hf0SKyi9ivTHaJHtSvhEFbgeQz
 ZtHEagzAQTHdh1Y26BvZ1rgYZt6Kmem5ecgxU2svtsX/sB+d1SuvvefLOQuGmtyCdey6gcSx4ej
 p/MeXkIP0FIZeOJsB4OYnppwPJ8QyItvDUK75EHxZzS+qX1wpDlXyaLw/Nv2UPR+vV47m+/qffk
 6BEteW1ejpNWWaft72Yq+a3/Yjkg0SKLTQ9dTI4JoYxjP2WKEu+2Kv8hFGrnQXD/EuwcI=
X-Received: by 2002:a5d:6f09:0:b0:481:5ba5:994c with SMTP id
 ffacd0b85a97d-482c0baf924mr44313278f8f.20.1787616920113; 
 Mon, 24 Aug 2026 17:15:20 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 17:15:18 -0700 (PDT)
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
Subject: [PATCH v3 06/10] drm/nouveau/gsp: use per-version DP_CONFIG_STREAM
 params on r570 firmware
Date: Tue, 25 Aug 2026 04:14:04 +0400
Message-ID: <20260825001408.14219-7-mohamedahmedegypt2001@gmail.com>
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

NVIDIA removed the deprecated actualPclkHz/linkClkFreqHz fields and the
whole Legacy{activeCnt, activeFrac, activePolarity, mvidWarEnabled,
MvidWarParams} block from the SST sub-struct of
NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS between the 535 and 570 releases
(compared in OpenRM tags 535.113.01 vs 570.144), shrinking the struct.

Everything nouveau writes sits at identical offsets in both layouts
except the trailing SST.bEnableAudioOverRightPanel (written as zero), but
the size is wrong on r570, which means r535_sor_dp_sst() and
r535_sor_dp_vcpi() are sent with an incorrect size.

Route the .sst/.vcpi IOR functions through nvkm_rm_api_disp the same way
bl_ctrl and dp.get_caps/set_indexed_link_rates already are. Keep the
existing implementation for r535 and add an r570 implementation built
against the 570.144 layout, which already exists in r570/nvrm/disp.h but
was unused until now. Also add the NV0073_CTRL_CMD_DP_CONFIG_STREAM
define that was missing from the layout.

Other DP controls sent through shared r535 code did not change layout
between the tags.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 33 ++++++++--
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    | 64 +++++++++++++++++++
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |  2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  5 ++
 4 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index bf97edcdfc95..7d1d4ee2af79 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -400,16 +400,16 @@ r535_sor_dp_audio(struct nvkm_ior *sor, int head, bool enable)
 		r535_sor_dp_audio_mute(sor, false);
 }
 
-static void
-r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+static int
+r535_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
 {
 	struct nvkm_disp *disp = sor->disp;
 	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
 
 	ctrl = nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
 				    NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
-	if (WARN_ON(IS_ERR(ctrl)))
-		return;
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
 	ctrl->subDeviceInstance = 0;
 	ctrl->head = head;
@@ -429,12 +429,20 @@ r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u
 	ctrl->MST.sendACT = 0;
 	ctrl->MST.singleHeadMSTPipeline = 0;
 	ctrl->MST.bEnableAudioOverRightPanel = 0;
-	WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
+	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
+}
+
+static void
+r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+{
+	const struct nvkm_rm_api *rmapi = sor->disp->engine.subdev.device->gsp->rm->api;
+
+	WARN_ON(rmapi->disp->dp.vcpi(sor, head, slot, slot_nr, pbn, aligned_pbn));
 }
 
 static int
-r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
-		u32 watermark, u32 hblanksym, u32 vblanksym)
+r535_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+	    u32 watermark, u32 hblanksym, u32 vblanksym)
 {
 	struct nvkm_disp *disp = sor->disp;
 	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
@@ -461,6 +469,15 @@ r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
 	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
 }
 
+static int
+r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+		u32 watermark, u32 hblanksym, u32 vblanksym)
+{
+	const struct nvkm_rm_api *rmapi = sor->disp->engine.subdev.device->gsp->rm->api;
+
+	return rmapi->disp->dp.sst(sor, head, ef, watermark, hblanksym, vblanksym);
+}
+
 static const struct nvkm_ior_func_dp
 r535_sor_dp = {
 	.sst = r535_sor_dp_sst,
@@ -1734,6 +1751,8 @@ r535_disp = {
 	.dp = {
 		.get_caps = r535_dp_get_caps,
 		.set_indexed_link_rates = r535_dp_set_indexed_link_rates,
+		.sst = r535_dp_sst,
+		.vcpi = r535_dp_vcpi,
 	},
 	.chan = {
 		.set_pushbuf = r535_disp_chan_set_pushbuf,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
index a96e31c2d80b..8a23837f356e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
@@ -5,6 +5,7 @@
 #include <rm/rm.h>
 
 #include <engine/disp.h>
+#include <engine/disp/ior.h>
 #include <engine/disp/outp.h>
 
 #include "nvhw/drf.h"
@@ -74,6 +75,67 @@ r570_disp_chan_set_pushbuf(struct nvkm_disp *disp, s32 oclass, int inst, struct
 	return nvkm_gsp_rm_ctrl_wr(&gsp->internal.device.subdevice, ctrl);
 }
 
+static int
+r570_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+{
+	struct nvkm_disp *disp = sor->disp;
+	NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
+
+	ctrl = nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
+				    NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	ctrl->subDeviceInstance = 0;
+	ctrl->head = head;
+	ctrl->sorIndex = sor->id;
+	ctrl->dpLink = sor->asy.link == 2;
+	ctrl->bEnableOverride = 1;
+	ctrl->bMST = 1;
+	ctrl->hBlankSym = 0;
+	ctrl->vBlankSym = 0;
+	ctrl->colorFormat = 0;
+	ctrl->bEnableTwoHeadOneOr = 0;
+	ctrl->singleHeadMultistreamMode = 0;
+	ctrl->MST.slotStart = slot;
+	ctrl->MST.slotEnd = slot + slot_nr - 1;
+	ctrl->MST.PBN = pbn;
+	ctrl->MST.Timeslice = aligned_pbn;
+	ctrl->MST.sendACT = 0;
+	ctrl->MST.singleHeadMSTPipeline = 0;
+	ctrl->MST.bEnableAudioOverRightPanel = 0;
+	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
+}
+
+static int
+r570_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+	    u32 watermark, u32 hblanksym, u32 vblanksym)
+{
+	struct nvkm_disp *disp = sor->disp;
+	NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
+
+	ctrl = nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
+				    NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	ctrl->subDeviceInstance = 0;
+	ctrl->head = head;
+	ctrl->sorIndex = sor->id;
+	ctrl->dpLink = sor->asy.link == 2;
+	ctrl->bEnableOverride = 1;
+	ctrl->bMST = 0;
+	ctrl->hBlankSym = hblanksym;
+	ctrl->vBlankSym = vblanksym;
+	ctrl->colorFormat = 0;
+	ctrl->bEnableTwoHeadOneOr = 0;
+	ctrl->SST.bEnhancedFraming = ef;
+	ctrl->SST.tuSize = 64;
+	ctrl->SST.waterMark = watermark;
+	ctrl->SST.bEnableAudioOverRightPanel = 0;
+	return nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl);
+}
+
 static int
 r570_dp_set_indexed_link_rates(struct nvkm_outp *outp)
 {
@@ -255,6 +317,8 @@ r570_disp = {
 	.dp = {
 		.get_caps = r570_dp_get_caps,
 		.set_indexed_link_rates = r570_dp_set_indexed_link_rates,
+		.sst = r570_dp_sst,
+		.vcpi = r570_dp_vcpi,
 	},
 	.chan = {
 		.set_pushbuf = r570_disp_chan_set_pushbuf,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
index 06e972835d77..742b25a2a12d 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/disp.h
@@ -256,6 +256,8 @@ typedef struct NV0073_CTRL_DP_CTRL_PARAMS {
     NvU32 eightLaneDpcdBaseAddr;
 } NV0073_CTRL_DP_CTRL_PARAMS;
 
+#define NV0073_CTRL_CMD_DP_CONFIG_STREAM                   (0x731362U) /* finn: Evaluated from "(FINN_NV04_DISPLAY_COMMON_DP_INTERFACE_ID << 8) | NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS_MESSAGE_ID" */
+
 typedef struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS {
     NvU32  subDeviceInstance;
     NvU32  head;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index 0fb0e67406c6..e9ac47d86b69 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -6,6 +6,7 @@
 #ifndef __NVKM_RM_H__
 #define __NVKM_RM_H__
 #include "handles.h"
+struct nvkm_ior;
 struct nvkm_outp;
 struct r535_gr;
 
@@ -93,6 +94,10 @@ struct nvkm_rm_api {
 		struct {
 			int (*get_caps)(struct nvkm_disp *, int *link_bw, bool *mst, bool *wm);
 			int (*set_indexed_link_rates)(struct nvkm_outp *);
+			int (*sst)(struct nvkm_ior *, int head, bool ef,
+				   u32 watermark, u32 hblanksym, u32 vblanksym);
+			int (*vcpi)(struct nvkm_ior *, int head,
+				    u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn);
 		} dp;
 
 		struct {
-- 
2.55.0

