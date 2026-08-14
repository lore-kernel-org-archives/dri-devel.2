Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBBBC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931CE10F786;
	Fri, 14 Aug 2026 23:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sb0yci7t";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85FA10F78C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:58:57 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so15182565e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786751936; x=1787356736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/7LCFTWRnAeC5g1WvDew++pqFKHPtJ1vfgI1n3/PZ1c=;
 b=Sb0yci7tdWp8Ul+JITTYAGmZGgNTp0ZeN1GYnBoH013F3v0XsxPKN/54MYi+X+3V+b
 To99TA6U1xadvAJs9Ju/55pLe3qhR60uuXgNHfzH6QjE6xiRxfVl3oNyt7SGHrgRaQLV
 iQir/Ub+ryBKo0USfKauFNf2OZzn+F65M6SAR+o0jZSy0NFxfR0ReKgLXslNXlGln9HH
 j4rl/C3JQ03RU7IN77OCZWTCjN9ROIeTN8LkexgqaXSueqU5xPD+0aUq9aEGs4bLAM3B
 znOqbkVN8a1YqD85zTmtc4TlH+CR5Uy8AAvZBs/sqe1fUnPfY4vxASqRSDCSXAI8JAKw
 DAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786751936; x=1787356736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/7LCFTWRnAeC5g1WvDew++pqFKHPtJ1vfgI1n3/PZ1c=;
 b=IuBXE/q50dCWtCx8LBYUTanhOHGVvGXffwSoLl2iklLTgONfF5wMAZ8CJMWpOA+Z6s
 oevRrvHzUIw59osSkPzMfCcGhRowa0nTuvTMWfj2W5YfR7y3iU2Yfmt24CjBekatvAOd
 wondi8fSgrgahT0v/Yac+ucpKZrAyMjuX6+OP9CyXvD5Md8titP7Nq7pY2WKWHh38i/2
 t7hd4FCpWimvwMMvNZzeXMyhJgveDwQ7Z4rlY+4FDJTIsWsdgT15mgBGmmAgvI3DCA+k
 w9l3DOwTVSypWxngo+fPFjJR9eIxCGaMU1eZX234l/4kiNZDx7m2j9To8KeOxLsRiAXo
 5cng==
X-Gm-Message-State: AOJu0YzupgxQtuKwS/VYyqR8YW6NR9t88xZ9H+uBj6VHb50+brLEcIoF
 pIS+N2s1qjnimr9/8BdOFwtYmip9YShSdweLPQnBpFLYXNM43LztpAwZ
X-Gm-Gg: AR+sD13S/9CNRATAEILPBBs8NLjeQpvPl0iAflCBmoi5yENhaNgGq/W7jEEr+cnGGzC
 ozz81jF+f/ONrwdasBWfNVLz005QWyK7h1DqDHMZuV5ugRzkzeNzRQpiJBvbMxzGRtI+StAtUoW
 xXAQ+J4WYdf6kthNbUXc/RnE6zNwi1A9vT8FmBCBkvNvdwJ6D3jMPZ6dEll/6fGsqc+dXe8xsxp
 f5wWC/b7zaDN7mzAFrUXeN9F1JrXoULKHW9Jc9Xs/DDK8c/hQyJZpg1xDhPBK3M65alMsxQeBnT
 TM3EvE46TivVzx2nV0Pd0V8o9Rc+LVY1QAN85eogKYXIh3kRVpzybUUDPWPD9qkyxyrxCHILE1n
 RrKlzVnlkujEYw8GefnzwoCkOHvT+Nzgf10idH+Zu/U5DjX7SpoLLIxt/jIEcosLxCFOKW9AdeD
 W4EJa2pdBBVmM5ysicwbTC5WgOgbbxGDv7EgAp1V4v8JlZ9LXB4s+NYt4c/MekbJnYZNE=
X-Received: by 2002:a05:600c:8714:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-49987938551mr142397245e9.3.1786751936320; 
 Fri, 14 Aug 2026 16:58:56 -0700 (PDT)
Received: from fedora ([5.31.134.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899753ccsm77751245e9.0.2026.08.14.16.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 16:58:55 -0700 (PDT)
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
Subject: [PATCH 4/7] nouveau/gsp: use per-version DP_CONFIG_STREAM params on
 r570 firmware
Date: Sat, 15 Aug 2026 03:57:02 +0400
Message-ID: <20260814235705.59132-5-mohamedahmedegypt2001@gmail.com>
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

NVIDIA removed the deprecated actualPclkHz/linkClkFreqHz fields and the
whole Legacy{activeCnt, activeFrac, activePolarity, mvidWarEnabled,
MvidWarParams} block from the SST sub-struct of
NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS between the 535 and 570 releases
(compared in OpenRM tags 535.113.01 vs 570.144), shrinking the struct.

Everything nouveau writes sits at identical offsets in both layouts but
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
 .../nouveau/nvkm/subdev/gsp/rm/r535/disp.c    | 25 +++++++-
 .../nouveau/nvkm/subdev/gsp/rm/r570/disp.c    | 64 +++++++++++++++++++
 .../nvkm/subdev/gsp/rm/r570/nvrm/disp.h       |  2 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  5 ++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f51ad7c754d8..dd632767aea5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -403,7 +403,7 @@ r535_sor_dp_audio(struct nvkm_ior *sor, int head, bool enable)
 }
 
 static void
-r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+r535_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
 {
 	struct nvkm_disp *disp = sor->disp;
 	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
@@ -434,9 +434,17 @@ r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u
 	WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
 }
 
+static void
+r535_sor_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+{
+	const struct nvkm_rm_api *rmapi = sor->disp->engine.subdev.device->gsp->rm->api;
+
+	rmapi->disp->dp.vcpi(sor, head, slot, slot_nr, pbn, aligned_pbn);
+}
+
 static int
-r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
-		u32 watermark, u32 hblanksym, u32 vblanksym)
+r535_dp_sst(struct nvkm_ior *sor, int head, bool ef,
+	    u32 watermark, u32 hblanksym, u32 vblanksym)
 {
 	struct nvkm_disp *disp = sor->disp;
 	struct NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
@@ -463,6 +471,15 @@ r535_sor_dp_sst(struct nvkm_ior *sor, int head, bool ef,
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
@@ -1828,6 +1845,8 @@ r535_disp = {
 	.dp = {
 		.get_caps = r535_dp_get_caps,
 		.set_indexed_link_rates = r535_dp_set_indexed_link_rates,
+		.sst = r535_dp_sst,
+		.vcpi = r535_dp_vcpi,
 	},
 	.chan = {
 		.set_pushbuf = r535_disp_chan_set_pushbuf,
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/disp.c
index a96e31c2d80b..61f82e15ff39 100644
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
 
+static void
+r570_dp_vcpi(struct nvkm_ior *sor, int head, u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn)
+{
+	struct nvkm_disp *disp = sor->disp;
+	NV0073_CTRL_CMD_DP_CONFIG_STREAM_PARAMS *ctrl;
+
+	ctrl = nvkm_gsp_rm_ctrl_get(&disp->rm.objcom,
+				    NV0073_CTRL_CMD_DP_CONFIG_STREAM, sizeof(*ctrl));
+	if (WARN_ON(IS_ERR(ctrl)))
+		return;
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
+	WARN_ON(nvkm_gsp_rm_ctrl_wr(&disp->rm.objcom, ctrl));
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
index a9af94adf9ef..e0c10a7e3452 100644
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
+			void (*vcpi)(struct nvkm_ior *, int head,
+				     u8 slot, u8 slot_nr, u16 pbn, u16 aligned_pbn);
 		} dp;
 
 		struct {
-- 
2.55.0

