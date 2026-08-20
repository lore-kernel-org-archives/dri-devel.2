Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D38AC5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 852B510F10F;
	Thu, 20 Aug 2026 16:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KsDJyeWi";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8E610F11B
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 16:50:47 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so561295e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787244645; x=1787849445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vnOb/9NeU+aY27k+bEV+VJd7crL2q/W32VHlWjgPnxc=;
 b=KsDJyeWi/KLTvXZNhs1GDicJJYT7witOQpT9+IfUprkjxR9KO7xZQV5AFoNxFXvC8d
 kzcR10OKSS7O6LCfHMTutMQy7ah6n5+id+GhlKyTzmlx6fkwCP5yhEOBLdOimZ1jlP77
 71c+Wt5aC5Mg6ImFl0VedaHstzAo4moJv6eoyUDAwapHsKVWi0PbhYR0Q6OZBWaCC4r/
 soo3xEYKBsnmGRFD9fF0E73yZnqk85hQRbjdtrX0h0m2HjjWWhr8vaS/DsT92/eqMSKI
 JoRu1Rlw6lhXsq8BA2cHSwerLgPEPwPG5KOJ0PhAM+kkQkgmbceJm7bUQHPFXIdWH7vW
 bHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244645; x=1787849445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vnOb/9NeU+aY27k+bEV+VJd7crL2q/W32VHlWjgPnxc=;
 b=lnBFQ6zxj+y/qlslziCXee1UeU2gtGLOtuGM0OCPiIgTKK2RCgWYVHoUv4vtKJKpkV
 k33Ox7F2vPef+/piXtJHvpwR/yDAbw4lDtcmHu2S/Ob+ZQBIfuigdLdjPO76FSzMu/bU
 SPmTG3XO1n+CMGGSRkErnQ8WgLJlUS74WknVBcazLH2aJzEBXuyiau2xqvimsXqwXnhP
 lAmr4QBNnAHph6bQJtIan5eWg+4axUVC3gLaGqpdlu8Grt6Jbh8468ovZ443ydlbGBIf
 U4uTr1763v4zdo8c7+YQmoo1mRRW18yYcLC4NqH1MUSjIflQQ1rr7NGqU3tZf+d3aUOt
 ZdNw==
X-Gm-Message-State: AOJu0YzdBN5j/KtohgmB84LVPIEc7Kd/e8U+/M7491lVj37DckTChv1x
 N13makOLJOy0GyE7cbAYQhAtiuUXrjEl6QnTMakwROC4wejnfMzIGncR
X-Gm-Gg: AR+sD11MnWyTB72tf6pbtRLTLHv/4lm68KujUZ1uak1f3eDvMbAcqidK7dlM8RmROk7
 Gh9cE8gR3IMVSyFFX7jAiBFDToan2jlGeBkTzWcPOSeg6xZdZbxDYsCgoWTXPV1WZF5n+OGgY6y
 qcyxNQDvcRquxffNsJ9itz/ITzEPOxhkhEClIBdUzozrZwJ6sPMLJBA8GeZMKTH8EdCYWwR0bNt
 LdQAQnJhJ5r+qYj/YmkqUPM0p2Pw1hdE+pklnMLxOU7fC3By6EdJhJYwTb+nQxAeVl0yTh8FRb7
 Sx8/ROWr0CNaPlTiftX382zlJtZbKp31opBtrcMZxPS4cNVkGnlU6LyPNG4RFLdoeC2xTex3gGl
 XJHSoJeWWooGoy8rKqUOUrHDD/86ka0wr/yrCO+9Dwl4ctMpvplkKkX1ztUXeSoYFCRQN2vA+Oc
 NQknUUlB/zlvTbOs8yq/ZuG3RTleeZ1a8TvIsYJZfo2Rgeq6ic4FokLkxEZsFUA0Q8UUs=
X-Received: by 2002:a05:600c:6211:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-499b82e8e9dmr5345035e9.3.1787244645217; 
 Thu, 20 Aug 2026 09:50:45 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111b2sm205307545e9.5.2026.08.20.09.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:43 -0700 (PDT)
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
Subject: [PATCH v2 06/10] drm/nouveau/gsp: use per-version DP_CONFIG_STREAM
 params on r570 firmware
Date: Thu, 20 Aug 2026 20:49:25 +0400
Message-ID: <20260820164929.17117-7-mohamedahmedegypt2001@gmail.com>
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

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 33 ++++++++--
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    | 64 +++++++++++++++++++
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |  2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  5 ++
 4 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f3e55253bcbc..3a8ff621ed62 100644
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
@@ -1771,6 +1788,8 @@ r535_disp = {
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

