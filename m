Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD5CCC6B39
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D501120EA;
	Thu, 15 Oct 2026 07:39:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 023A01120F4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:24 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F1enFD3468988
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BxPJ5bz63v9HogdNZ3A3/Q9lNywKHQtZNLqPWsvnizo=; b=kfq09MLPoTK+MwoZ
 nQ1iuVxvMBudjNZjG1NMa9nPUYhOai9O+ToiJQD/KLv6V6oz66Yi6Zl3or/cWmtS
 5OM63oASIHm4n0lAIiM/2BiKqmQktIypGXSUzWuMtQVFlvq6jjQuQcgIL0bqEl6d
 7cWeqv+GV6thJgzdN34My+448fBXB+a7jP2Wma7LfcPD+U7UGihb0flcHiWZzffR
 /U9g/dejD2rSH4Fv1i3FfRgtHBWlbisV0MgmVcWDU5r3ao/hKzZmDXCeBrh9CSK8
 1XqOWcNA22yrc43t7BC/teAox+8FcsX1yOJ/737N3Y94hNrvuu8wlCw3U3/5Vsoi
 rhiSCQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7b17e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc1b6f65dacso3191482a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792049963; x=1792654763;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BxPJ5bz63v9HogdNZ3A3/Q9lNywKHQtZNLqPWsvnizo=;
 b=e94LkWfU07K4M/Seha7jDMwR7bMqhB8vmwNmP9zWo5EBJ+Aogf+LNIg7YO3xWMyafv
 XDku4gYDtCTGWGOXbnfBnxAV1/StuWmFbmbP/v7RP65icS0EdIbwKwilNAwhiZPpSP+M
 yHor4xJTy4rWJOTfY1oZM0tsAeiAf1r1zGFbKZ2Kxbp/XFiZAYUm8vQa+BivAef8YitI
 CUaF7ku7tkYfVyIlk8rKEpGZSQfUp7Vqg+FgmTE9D5Q+AbcfrAMcZVAD5IWV3t/m1tyG
 +s4/2rbwuxfJDlH40y7Z4MnQ9W1OMj9uhTTGLRzpnxFqjoIuy1bJvIoDkwQ1CPeKT0hH
 B2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049963; x=1792654763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BxPJ5bz63v9HogdNZ3A3/Q9lNywKHQtZNLqPWsvnizo=;
 b=GdU2XOG411mwe+mtyXx9bgiE7omcQg3WVwkHaXV/Ki1UBXal4ITcwr9bh67V29H8Rc
 PzOrDhY7eR1nB8aLWL5cRWSwazJDIpdbVKWc14PLU27Xbuo4QtaMo4Ct1Ofiq+FQ/18p
 IVkTWsaVJ9cz3gIcwKHz04lhH1hAbNiKWufiPGsdMEXQo7FtadDo4gAF/vk8CPXZlWHm
 cHeGV3MukU+iB8Zn7WarQXQ2vsC9YPuOpvv7JaKR9zEX1WODa1K+GQMKOMKpZUKPeM08
 BRxpf6J4Tg7dDtYj+EjLa9ONcxcuCmfB9oNcIkNWodnf4q9jyiOZdquY9TxtPZcyVgwH
 4Wnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC33eHJ+UhUt2yojc6IAd9U0gFwGjgkttZGknqBS4xDeh3bpYmk3MkSQ33L8lFLiWvqb3veoOHMmk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdOIVnrFp+fZFkkSx6zr/Aye/sSHPRCYC5YNoNFG+p5mDJzWv4
 Tu5Munbv2/94HV9Ut94dMgGHq7XeXcFCP9o2/8KyIuT9n+Oc8/YLrBLXfG0HVCwNHbALtsdGtpL
 fPb1dpcJxSV2/voe2zI36irCvsjnNmG55wFKjopWeP3m97jwWqtkj5AP2Y5MtlmT4wBbT3MQ=
X-Gm-Gg: AYBFou2TbKm/M20zznq+fGsjfxlHyj0WnBlFmlpi/HZlQ4di6u9r8EJCwuScld/dl7z
 faVW1kxIq5Ut3pz4itxRCdPceMw3KBHJld2uer4Ha1SJWhuHcUj1VA6uB6or8g0bLz2728YG7aG
 zF43WZlAbdca8AOdwxlCjBouzQPzW6grN7usNsGdik5wdiLZYLOf75qXt9p7Sqd1N7g81K4bXiZ
 dYvRolh546rD2tp+TYqzOvuMU+Kk30GLq7UPVKXNu/fSo+PJXCBoGSfwfdzhl+Prv6Gb6Hby0vg
 I14FjJhx7vPXtYhxeORrraSHYlB4QvSRTmYEfHwwbttUxyDJorAp5R58Avyo+oxBN0x0z6IIIiD
 OOOSfBHgqw2BNjldEuGcgCatAvPsufPLPiRQ=
X-Received: by 2002:a17:902:db0b:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2e8427efd9dmr178100805ad.5.1792049962397; 
 Thu, 15 Oct 2026 00:39:22 -0700 (PDT)
X-Received: by 2002:a17:902:db0b:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2e8427efd9dmr178100625ad.5.1792049961739; 
 Thu, 15 Oct 2026 00:39:21 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:39:21 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:23 +0530
Subject: [PATCH 03/13] drm/msm/dcp: Add HFI transport over VirtIO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-3-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=46227;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=0d/472uA2aBtWDTKkLGtSOJQbMgUohuutcoQbFBC0AQ=;
 b=romwvP5tapZdxLBzf0FlMq9zcE++JS40EQSkBNIeKXmUckGUwYQpwS456wuAsGxvsko/VgFBP
 0B8TyM/Aw7kDjpiwnQUXmUv/CJizrbCUYayjHBygLz+xJFX8g/VRJfb
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad0832b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=W2xyxme5nyVMB79hAmUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: l4AEmJN3Mx11j9mYng1BGQKgJSxtatst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX+ql5v+FHFJQ+
 1sJBU3G89bCx7OMkY0uTG7a2O01nWCW2S5E2Vs7aD5kivsW6CwbStGyZM971TZKDjf5M5cCOVFM
 G5ti1p45NZQLMT1rAl5V90TUIE0/YneLxJxMF3uRhgk4IQvSAZipsMN7pRTiXkQQ02VmPwEWZDU
 TRe47Ye8R1DynIDilPK+tJsBa524HYqAfq4PAtAgOughiMHGYXKD9z/VStoDcciiEFwKJiS9k5w
 r93/48GsB+PK1ERRpGMo0a5gWbyum14q4bI0woaobMDzGVkmVPqNfh1cj9V1rfi32s17vYB3D8K
 8KC/cfjwwPBf9MI/Pbtv2enZN28OxeUOQD273rKSuzrNYZp47sHNsV9hGOYG/bUKJkJljBVHbif
 iR7y2HegNa8yp7mb1BmMVwgcTlaXhZcLZWkdUxghJIVPpfAXf87DPoZ5ugjsliphVeS5llomVow
 nqioilwH66Z7HRHJcAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX2kpzFVrxNicp
 DU0jN8XmuPXan2TLYeAvrQOAr2+0lsjODypVzk4M8vImbmcK8efITE+mwOao5OntYT/6fg5nsre
 tKRAibTLgiRt4VTG1JdOKenKvcZlzf8=
X-Proofpoint-ORIG-GUID: l4AEmJN3Mx11j9mYng1BGQKgJSxtatst
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150030
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

DCP firmware owns the display hardware, so the MSM DRM driver needs a
transport for HFI commands, responses, and asynchronous display events.

Add the VirtIO command and response queues used to communicate with DCP.
Allocate command, response, and capability buffers through the DMA API
using the firmware-visible IOVA window. Track synchronous commands and
asynchronous responses, dispatch HFI callbacks, and synchronize queue
teardown with in-flight transactions.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/Makefile           |    1 +
 drivers/gpu/drm/msm/dcp/dcp_drv.h      |   30 +
 drivers/gpu/drm/msm/dcp/dcp_hfi.h      |  214 ++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 1198 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h |   74 ++
 5 files changed, 1517 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 00c995dde21a..bdc34babfc21 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -70,6 +70,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 	disp/mdp5/mdp5_smp.o \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
+	dcp/dcp_hfi_core.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
new file mode 100644
index 000000000000..bf6c34af43a0
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DCP_DRV_H__
+#define __DCP_DRV_H__
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
+#include <linux/virtio.h>
+
+#include "dcp_hfi.h"
+
+struct dcp_dpu_kms;
+
+struct dcp_drv {
+	struct virtio_device	*vdev;
+	struct platform_device	*dcp_subsystem_dev;
+	struct device_dma_parameters dcp_subsystem_dma_parms;
+	struct device_node	*dcp_subsystem_node;
+	struct dcp_hfi		*hfi;
+	struct dcp_dpu_kms	*kms;
+	struct dcp_caps		 caps;
+	struct notifier_block	 panic_notifier;
+};
+
+#endif /* __DCP_DRV_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi.h b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
new file mode 100644
index 000000000000..726087e5c8a2
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP HFI (Hardware Firmware Interface) protocol layer.
+ */
+
+#ifndef __DCP_HFI_H__
+#define __DCP_HFI_H__
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/virtio.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_pack_unpack_common.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_commands_device.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_panel.h"
+#include "hfi/hfi_commands_display_events.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+#include "hfi/hfi_defs_device.h"
+#include "hfi/hfi_defs_panel.h"
+#include "hfi/hfi_properties_device.h"
+#include "hfi/hfi_properties_display.h"
+#include "hfi/hfi_properties_panel.h"
+
+struct dcp_drv;
+struct dcp_hfi_caps_cache;
+
+/* Queue 0 carries commands; queue 1 carries responses and events. */
+#define DCP_VQ_CMD	0	/* TX: all commands */
+#define DCP_VQ_RESP	1	/* RX: all responses and async events */
+#define DCP_NUM_VQS	2
+
+#define DCP_MAX_DISPLAYS	4
+
+#define DCP_FEAT_DSC		BIT(0)
+#define DCP_FEAT_HDR		BIT(1)
+#define DCP_FEAT_SRC_SPLIT	BIT(3)
+#define DCP_FEAT_CURSOR		BIT(4)
+
+#define DCP_MAX_SSPP_COUNT	16
+#define DCP_MAX_VIG_PIPES	DCP_MAX_SSPP_COUNT
+#define DCP_MAX_DMA_PIPES	DCP_MAX_SSPP_COUNT
+
+#define DCP_MAX_BLOCKS			8
+
+/* Pipe indices encode the rectangle ID in bits 31:24. */
+#define DCP_REC_ID(x)		(((x) & 0xff000000) >> 24)
+
+/* Capabilities parsed from DEVICE_INIT responses. */
+struct dcp_caps {
+	u32 dcp_hw_rev;
+	u32 hw_rev;
+	u32 fw_rev;
+
+	u32 num_vig_pipes;
+	u32 vig_pipe_ids[DCP_MAX_SSPP_COUNT];
+	u32 virt_vig_count;
+	u32 vig_r1_indices[DCP_MAX_SSPP_COUNT];
+
+	u32 num_dma_pipes;
+	u32 dma_pipe_ids[DCP_MAX_SSPP_COUNT];
+	u32 virt_dma_count;
+	u32 dma_r1_indices[DCP_MAX_SSPP_COUNT];
+
+	u32 num_crtcs;
+
+	u32 dsi_count;
+	u32 dsi_indices[DCP_MAX_BLOCKS];
+	u32 max_dsi_resolution;
+
+	u32 dp_count;
+	u32 dp_indices[DCP_MAX_BLOCKS];
+
+	u32 active_pipes_mask[DCP_MAX_DISPLAYS];
+
+	u32 max_width;
+	u32 max_height;
+	u32 max_planes;
+	u32 features;
+	bool valid;
+
+	bool dyn_clk_support;
+};
+
+struct dcp_hfi_buf {
+	void *data;
+	dma_addr_t dma_addr;
+	size_t size;
+	struct scatterlist sg;
+	struct dcp_hfi_completion *comp;
+	struct list_head node;
+};
+
+struct dcp_hfi_completion {
+	struct completion done;
+	int status;
+	void *resp_data;
+	size_t resp_len;
+	u32 packet_id;
+};
+
+#define DCP_HFI_RESOURCE_VOTE_BUF_SIZE	256
+
+/* Wire-format resource vote entry. */
+struct dcp_resource_vote_pair {
+	u32 key;
+	u64 value;
+};
+
+struct dcp_resource_vote_wire {
+	__le32 key;
+	__le64 value;
+} __packed;
+
+struct dcp_hfi {
+	struct device *dev;
+	struct dcp_drv *drv;
+
+	struct device *dma_dev;
+
+	struct virtqueue *cmd_vq;
+	struct virtqueue *resp_vq;
+
+	struct dcp_hfi_buf *cmd_pool;
+	struct list_head cmd_free_list;
+	/* Protects cmd_free_list and command buffer ownership. */
+	spinlock_t cmd_lock;
+
+	struct dcp_hfi_buf *resp_pool;
+	/* Protects response queue draining and power callback publication. */
+	spinlock_t resp_drain_lock;
+	struct list_head resp_repost_list;
+	struct delayed_work resp_repost_work;
+	struct xarray pending_xa;
+	/* Protects pending_xa. */
+	spinlock_t pending_lock;
+	atomic_t packet_id;
+	atomic_t shutdown_in_progress;
+
+	struct work_struct resource_vote_work;
+	/* Protects resource_vote_buf, resource_vote_len, and callback state. */
+	spinlock_t resource_vote_lock;
+	u8 resource_vote_buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
+	u32 resource_vote_len;
+	u32 resource_vote_generation;
+	void (*resource_vote_cb)(struct dcp_drv *drv,
+				 const struct dcp_resource_vote_pair *pairs,
+				 u32 count);
+
+	/* Protects caps_cache pointer and its lifetime. */
+	spinlock_t caps_lock;
+	/* Serializes capability transactions and cache detach/free. */
+	struct mutex caps_cache_lock;
+	struct dcp_hfi_caps_cache *caps_cache;
+
+	void (*hotplug_cb)(struct dcp_drv *drv, u32 intf_idx, bool connected);
+	void (*error_cb)(struct dcp_drv *drv, u32 display_id, u32 error_code);
+
+	void *power_control_priv;
+	void (*power_control_cb)(void *priv, u32 display_id,
+				 u32 power_mask, bool enable, u32 packet_id);
+};
+
+int dcp_hfi_init(struct dcp_drv *drv, struct virtio_device *vdev,
+		 struct virtqueue *cmd_vq, struct virtqueue *resp_vq,
+		 struct device *dma_dev);
+void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
+				  void (*cb)(void *priv, u32 display_id,
+					     u32 power_mask, bool enable,
+					     u32 packet_id));
+void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv);
+void dcp_hfi_stop(struct dcp_hfi *hfi);
+void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi);
+void dcp_hfi_deinit(struct dcp_hfi *hfi);
+
+void dcp_hfi_resp_callback(struct virtqueue *vq);
+void dcp_hfi_cmd_callback(struct virtqueue *vq);
+
+int dcp_hfi_send_sync(struct dcp_hfi *hfi, u32 cmd,
+		      enum hfi_cmd_buff_type cmd_type, u32 object_id,
+		      enum hfi_packet_payload_type payload_type, void *payload,
+		      u32 payload_size, u32 tx_flags, void *resp_data,
+		      size_t resp_len, unsigned int timeout_ms);
+
+int dcp_hfi_send_no_wait(struct dcp_hfi *hfi, u32 cmd,
+			 enum hfi_cmd_buff_type cmd_type, u32 object_id,
+			 enum hfi_packet_payload_type payload_type, void *payload,
+			 u32 payload_size);
+
+int dcp_hfi_send_no_wait_flags(struct dcp_hfi *hfi, u32 cmd,
+			       enum hfi_cmd_buff_type cmd_type, u32 object_id,
+			       enum hfi_packet_payload_type payload_type,
+			       void *payload, u32 payload_size, u32 tx_flags);
+int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi *hfi, u32 cmd,
+				      enum hfi_cmd_buff_type cmd_type, u32 object_id,
+				       enum hfi_packet_payload_type payload_type,
+				       void *payload, u32 payload_size, u32 tx_flags);
+#endif /* __DCP_HFI_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
new file mode 100644
index 000000000000..bf27cbf9b8a4
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -0,0 +1,1198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * DCP HFI core transport.
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/unaligned.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/virtio.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/virtio_mmio.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "dcp_drv.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_commands_device.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_commands_display_events.h"
+#include "hfi/hfi_defs_common.h"
+#include "hfi/hfi_defs_display.h"
+
+static void dcp_hfi_resource_vote_work(struct work_struct *work);
+static int dcp_hfi_prepost_resp_bufs(struct dcp_hfi *hfi);
+
+u32 dcp_hfi_next_packet_id(struct dcp_hfi *hfi)
+{
+	u32 id;
+
+	id = (u32)atomic_inc_return(&hfi->packet_id);
+	if (id == 0)
+		id = (u32)atomic_inc_return(&hfi->packet_id);
+	return id;
+}
+
+#define DCP_HFI_BUF_ALLOC_RETRIES	3	/* Bound command-path stalls. */
+#define DCP_HFI_BUF_ALLOC_SLEEP_US_MIN	30000
+#define DCP_HFI_BUF_ALLOC_SLEEP_US_MAX	40000
+
+static struct dcp_hfi_buf *_dcp_hfi_buf_alloc(struct dcp_hfi *hfi,
+					      struct list_head *free_list,
+					       spinlock_t *lock,
+					       const char *pool_name)
+{
+	struct dcp_hfi_buf *buf = NULL;
+	unsigned long flags;
+	int retry;
+
+	if (atomic_read(&hfi->shutdown_in_progress)) {
+		dev_dbg(hfi->dev,
+			"HFI shutdown in progress — refusing %s buffer allocation\n",
+			pool_name);
+		return NULL;
+	}
+
+	for (retry = 0; retry <= DCP_HFI_BUF_ALLOC_RETRIES; retry++) {
+		if (atomic_read(&hfi->shutdown_in_progress))
+			return NULL;
+
+		spin_lock_irqsave(lock, flags);
+		if (!list_empty(free_list)) {
+			buf = list_first_entry(free_list,
+					       struct dcp_hfi_buf, node);
+			list_del(&buf->node);
+		}
+		spin_unlock_irqrestore(lock, flags);
+
+		if (buf)
+			return buf;
+
+		if (retry < DCP_HFI_BUF_ALLOC_RETRIES)
+			usleep_range(DCP_HFI_BUF_ALLOC_SLEEP_US_MIN,
+				     DCP_HFI_BUF_ALLOC_SLEEP_US_MAX);
+	}
+
+	dev_warn_ratelimited(hfi->dev,
+			     "HFI %s TX pool exhausted after %d retries — command dropped\n",
+			     pool_name, DCP_HFI_BUF_ALLOC_RETRIES);
+	return NULL;
+}
+
+static void _dcp_hfi_buf_free(struct dcp_hfi *hfi, struct dcp_hfi_buf *buf,
+			      struct list_head *free_list, spinlock_t *lock)
+{
+	unsigned long flags;
+
+	buf->comp = NULL;
+	spin_lock_irqsave(lock, flags);
+	list_add_tail(&buf->node, free_list);
+	spin_unlock_irqrestore(lock, flags);
+}
+
+static void _dcp_hfi_buf_free_locked(struct dcp_hfi_buf *buf,
+				     struct list_head *free_list)
+{
+	buf->comp = NULL;
+	list_add_tail(&buf->node, free_list);
+}
+
+struct dcp_hfi_buf *dcp_hfi_buf_alloc(struct dcp_hfi *hfi)
+{
+	return _dcp_hfi_buf_alloc(hfi, &hfi->cmd_free_list,
+				   &hfi->cmd_lock, "cmd");
+}
+
+void dcp_hfi_buf_free(struct dcp_hfi *hfi, struct dcp_hfi_buf *buf)
+{
+	_dcp_hfi_buf_free(hfi, buf, &hfi->cmd_free_list, &hfi->cmd_lock);
+}
+
+struct dcp_hfi_buf *dcp_hfi_buf_alloc_atomic(struct dcp_hfi *hfi)
+{
+	struct dcp_hfi_buf *buf = NULL;
+	unsigned long flags;
+
+	if (atomic_read(&hfi->shutdown_in_progress))
+		return NULL;
+
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	if (!list_empty(&hfi->cmd_free_list)) {
+		buf = list_first_entry(&hfi->cmd_free_list,
+				       struct dcp_hfi_buf, node);
+		list_del(&buf->node);
+	}
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+
+	return buf;
+}
+
+/* Multi-packet headers register each response completion before submission. */
+int dcp_hfi_pending_add(struct dcp_hfi *hfi,
+			struct dcp_hfi_completion *comp)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&hfi->pending_lock, flags);
+	ret = xa_insert(&hfi->pending_xa, comp->packet_id, comp, GFP_ATOMIC);
+	spin_unlock_irqrestore(&hfi->pending_lock, flags);
+
+	if (ret < 0) {
+		dev_err_ratelimited(hfi->dev,
+				    "HFI pending XArray full or collision at pkt_id=%u: %d\n",
+			comp->packet_id, ret);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+struct dcp_hfi_completion *dcp_hfi_pending_find(struct dcp_hfi *hfi,
+						u32 packet_id)
+{
+	unsigned long flags;
+	struct dcp_hfi_completion *comp;
+
+	spin_lock_irqsave(&hfi->pending_lock, flags);
+	comp = xa_erase(&hfi->pending_xa, packet_id);
+	spin_unlock_irqrestore(&hfi->pending_lock, flags);
+	return comp;
+}
+
+static void dcp_hfi_complete_pending(struct dcp_hfi *hfi,
+				     const struct hfi_packet_info *pkt_info,
+				      int status)
+{
+	struct dcp_hfi_completion *comp;
+	size_t n;
+
+	comp = dcp_hfi_pending_find(hfi, pkt_info->packet_id);
+	if (!comp) {
+		if (!status)
+			dev_warn_ratelimited(hfi->dev,
+					     "HFI resp: SUCCESS cmd=0x%x pkt_id=%u no completion; payload dropped (size=%u)\n",
+					     pkt_info->cmd, pkt_info->packet_id,
+					     pkt_info->payload_size);
+		return;
+	}
+
+	if (!status && comp->resp_data && comp->resp_len &&
+	    pkt_info->payload_size) {
+		n = min_t(size_t, comp->resp_len, pkt_info->payload_size);
+		memcpy(comp->resp_data, pkt_info->payload_ptr, n);
+	}
+
+	comp->status = status;
+	complete(&comp->done);
+}
+
+static void dcp_hfi_cancel_pending(struct dcp_hfi *hfi, int status)
+{
+	unsigned long flags;
+	struct dcp_hfi_completion *comp;
+	unsigned long id;
+	void *entry;
+
+	spin_lock_irqsave(&hfi->pending_lock, flags);
+	xa_for_each(&hfi->pending_xa, id, entry) {
+		comp = entry;
+		comp->status = status;
+		complete(&comp->done);
+	}
+	xa_destroy(&hfi->pending_xa);
+	xa_init(&hfi->pending_xa);
+	spin_unlock_irqrestore(&hfi->pending_lock, flags);
+}
+
+void dcp_hfi_cmd_callback(struct virtqueue *vq)
+{
+	struct dcp_drv *drv = vq->vdev->priv;
+	struct dcp_hfi *hfi = drv ? drv->hfi : NULL;
+
+	struct dcp_hfi_buf *buf;
+	unsigned int len;
+	unsigned long flags;
+
+	if (!hfi)
+		return;
+
+	if (atomic_read(&hfi->shutdown_in_progress))
+		return;
+
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	virtqueue_disable_cb(vq);
+	do {
+		while ((buf = virtqueue_get_buf(vq, &len)) != NULL)
+			_dcp_hfi_buf_free_locked(buf, &hfi->cmd_free_list);
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+}
+
+static void dcp_hfi_store_caps_payload(struct dcp_hfi *hfi,
+				       struct completion *done,
+					 u8 *dst, u32 *dst_len,
+					 const struct hfi_packet_info *pkt_info,
+					 const char *name)
+{
+	u32 n;
+
+	if (!pkt_info->payload_ptr || !pkt_info->payload_size) {
+		dev_dbg(hfi->dev, "%s: empty payload\n", name);
+		return;
+	}
+
+	if (pkt_info->payload_size > DCP_HFI_CAPS_BUF_SIZE) {
+		dev_warn(hfi->dev, "%s: payload too large: %u\n",
+			 name, pkt_info->payload_size);
+		return;
+	}
+
+	n = pkt_info->payload_size;
+	memcpy(dst, pkt_info->payload_ptr, n);
+	*dst_len = n;
+	if (done)
+		complete(done);
+	dev_dbg(hfi->dev, "%s: stored %u bytes\n", name, n);
+}
+
+/* Route asynchronous events and capability packets before flag handling. */
+static bool dcp_hfi_dispatch_event(struct dcp_hfi *hfi,
+				   const struct hfi_packet_info *pkt_info)
+{
+	switch (pkt_info->cmd) {
+	case HFI_COMMAND_DISPLAY_EVENT_VSYNC:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE:
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS: {
+		u32 intf_idx = pkt_info->id & 0xFFFF;
+		bool connected = false;
+
+		if (pkt_info->payload_ptr &&
+		    pkt_info->payload_size >=
+		    sizeof(struct hfi_display_hpd_status)) {
+			struct hfi_display_hpd_status *hpd =
+				pkt_info->payload_ptr;
+			connected = (hpd->dp_state ==
+				     HFI_DP_STATE_CONNECTED);
+		}
+		if (hfi->hotplug_cb)
+			hfi->hotplug_cb(hfi->drv, intf_idx, connected);
+		return true;
+	}
+
+	case HFI_COMMAND_DISPLAY_EVENT_PANEL_DEAD:
+		dev_err(hfi->dev,
+			"DCP: panel dead display %u\n",
+			pkt_info->id & 0xFFFF);
+		if (hfi->error_cb)
+			hfi->error_cb(hfi->drv, pkt_info->id & 0xFFFF, 0);
+		return true;
+
+	case HFI_COMMAND_DISPLAY_EVENT_HW_RECOVERY:
+		dev_err(hfi->dev,
+			"DCP: HW recovery display %u\n",
+			pkt_info->id & 0xFFFF);
+		if (hfi->error_cb)
+			hfi->error_cb(hfi->drv, pkt_info->id & 0xFFFF, 1);
+		return true;
+
+	case HFI_COMMAND_DISPLAY_POWER_CONTROL: {
+		u32 display_id = pkt_info->id & 0xFFFF;
+		u32 power_mask = 0;
+		bool enable = true;
+		unsigned long flags;
+		void *power_priv;
+		void (*power_cb)(void *priv, u32 display_id,
+				 u32 power_mask, bool enable, u32 packet_id);
+
+		if (pkt_info->payload_ptr &&
+		    pkt_info->payload_size >= 2 * sizeof(u32)) {
+			const u32 *p = pkt_info->payload_ptr;
+
+			power_mask = p[0];
+			enable     = (p[1] == HFI_TRUE);
+		}
+
+		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+		power_cb = hfi->power_control_cb;
+		power_priv = hfi->power_control_priv;
+		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+
+		if (power_cb)
+			power_cb(power_priv, display_id, power_mask, enable,
+				 pkt_info->packet_id);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache)
+			dcp_hfi_store_caps_payload(hfi, &cache->device_done,
+						   cache->device_buf, &cache->device_len,
+						   pkt_info, "DEVICE_INIT_DEVICE_CAPS");
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache)
+			dcp_hfi_store_caps_payload(hfi, &cache->display_done,
+						   cache->display_buf, &cache->display_len,
+						   pkt_info, "DEVICE_INIT_DISPLAY_CAPS");
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_VIG_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache) {
+			dcp_hfi_store_caps_payload(hfi, NULL, cache->vig_buf,
+						   &cache->vig_len, pkt_info, "VIG_CAPS");
+			cache->pipe_caps_received |= BIT(0);
+		}
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DMA_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache) {
+			dcp_hfi_store_caps_payload(hfi, NULL, cache->dma_buf,
+						   &cache->dma_len, pkt_info, "DMA_CAPS");
+			cache->pipe_caps_received |= BIT(1);
+		}
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_VIG_R1_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache) {
+			dcp_hfi_store_caps_payload(hfi, NULL, cache->vig_r1_buf,
+						   &cache->vig_r1_len, pkt_info, "VIG_R1_CAPS");
+			cache->pipe_caps_received |= BIT(2);
+		}
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DMA_R1_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache) {
+			dcp_hfi_store_caps_payload(hfi, NULL, cache->dma_r1_buf,
+						   &cache->dma_r1_len, pkt_info, "DMA_R1_CAPS");
+			cache->pipe_caps_received |= BIT(3);
+		}
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_COMMON_LAYER_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache)
+			cache->pipe_caps_received |= BIT(4);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		dev_dbg(hfi->dev,
+			"COMMON_LAYER_CAPS: received (size=%u)\n",
+			pkt_info->payload_size);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_INIT_DISPLAY_WB_CAPS: {
+		struct dcp_hfi_caps_cache *cache;
+		unsigned long flags;
+
+		spin_lock_irqsave(&hfi->caps_lock, flags);
+		cache = hfi->caps_cache;
+		if (cache)
+			cache->pipe_caps_received |= BIT(5);
+		spin_unlock_irqrestore(&hfi->caps_lock, flags);
+		dev_dbg(hfi->dev,
+			"DISPLAY_WB_CAPS: received (size=%u) — all pipe caps received\n",
+			pkt_info->payload_size);
+		return true;
+	}
+
+	case HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE: {
+		unsigned long vote_flags;
+		u32 payload_size = pkt_info->payload_size;
+		bool valid = pkt_info->payload_ptr && payload_size &&
+			payload_size <= DCP_HFI_RESOURCE_VOTE_BUF_SIZE &&
+			payload_size % sizeof(struct dcp_resource_vote_wire) == 0;
+
+		if (!valid) {
+			dev_warn_ratelimited(hfi->dev,
+					     "dropping malformed RESOURCE_VOTE payload size=%u max=%u\n",
+					     payload_size, DCP_HFI_RESOURCE_VOTE_BUF_SIZE);
+			payload_size = 0;
+		}
+
+		spin_lock_irqsave(&hfi->resource_vote_lock, vote_flags);
+		if (payload_size)
+			memcpy(hfi->resource_vote_buf, pkt_info->payload_ptr,
+			       payload_size);
+		hfi->resource_vote_len = payload_size;
+		hfi->resource_vote_generation++;
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, vote_flags);
+
+		if (payload_size)
+			schedule_work(&hfi->resource_vote_work);
+		return true;
+	}
+
+	default:
+		return false;
+	}
+}
+
+void dcp_hfi_resp_callback(struct virtqueue *vq)
+{
+	struct dcp_drv *drv = vq->vdev->priv;
+	struct dcp_hfi *hfi = drv ? drv->hfi : NULL;
+	struct dcp_hfi_buf *buf;
+	unsigned int len;
+	unsigned long drain_flags;
+
+	if (!hfi || atomic_read(&hfi->shutdown_in_progress))
+		return;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
+	virtqueue_disable_cb(vq);
+	for (;;) {
+		while ((buf = virtqueue_get_buf(vq, &len)) != NULL) {
+			struct hfi_cmd_buff_hdl hdl;
+			struct hfi_header_info hdr_info;
+			struct hfi_packet_info pkt_info;
+			u32 pkt_num;
+			int rc;
+
+			spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
+
+			if (unlikely(len < sizeof(struct hfi_header) ||
+				     len > DCP_HFI_BUF_SIZE)) {
+				dev_warn_ratelimited(hfi->dev,
+						     "HFI resp: short buffer len=%u (min=%zu) — skipping\n",
+					     len, sizeof(struct hfi_header));
+				goto repost;
+			}
+
+			hdl.cmd_buffer = buf->data;
+			hdl.size = (u32)len;
+			rc = hfi_unpacker_get_header_info(&hdl, &hdr_info);
+			if (rc) {
+				dev_warn_ratelimited(hfi->dev,
+						     "HFI resp: invalid header (rc=%d) len=%u\n",
+					     rc, len);
+				print_hex_dump(KERN_WARNING, "HFI resp raw: ",
+					       DUMP_PREFIX_OFFSET, 16, 4,
+					       buf->data, min_t(u32, len, 64), false);
+				goto repost;
+			}
+
+			for (pkt_num = 1; pkt_num <= hdr_info.num_packets; pkt_num++) {
+				memset(&pkt_info, 0, sizeof(pkt_info));
+				rc = hfi_unpacker_get_packet_info(&hdl, pkt_num,
+								  &pkt_info);
+				if (rc) {
+					dev_warn_ratelimited(hfi->dev,
+							     "HFI resp: bad pkt %u (rc=%d)\n",
+							     pkt_num, rc);
+					break;
+				}
+
+				dev_dbg(hfi->dev,
+					"HFI resp: cmd=0x%x flags=0x%x pkt_id=%u id=%u payload_size=%u\n",
+					pkt_info.cmd, pkt_info.flags, pkt_info.packet_id,
+					pkt_info.id, pkt_info.payload_size);
+
+				if (pkt_info.flags & HFI_RX_FLAGS_SYSTEM_ERROR) {
+					dev_err(hfi->dev,
+						"HFI system error: cmd=0x%x pkt_id=%u\n",
+						pkt_info.cmd, pkt_info.packet_id);
+					dcp_hfi_complete_pending(hfi, &pkt_info, -EIO);
+				} else if (pkt_info.flags & HFI_RX_FLAGS_DEVICE_ERROR) {
+					dev_err(hfi->dev,
+						"HFI error: cmd=0x%x pkt_id=%u\n",
+						pkt_info.cmd, pkt_info.packet_id);
+					dcp_hfi_complete_pending(hfi, &pkt_info, -EIO);
+				} else if (dcp_hfi_dispatch_event(hfi, &pkt_info)) {
+					/* Event dispatch runs before flag handling. */
+				} else if (pkt_info.flags & HFI_RX_FLAGS_SUCCESS) {
+					if (pkt_info.flags & HFI_RX_FLAGS_INFORMATION)
+						dev_dbg(hfi->dev,
+							"HFI info with success: cmd=0x%x pkt_id=%u\n",
+							pkt_info.cmd, pkt_info.packet_id);
+					dcp_hfi_complete_pending(hfi, &pkt_info, 0);
+				} else if (pkt_info.flags & HFI_RX_FLAGS_INFORMATION) {
+					dev_dbg(hfi->dev,
+						"HFI info with cmd=0x%x pkt_id=%u\n",
+						pkt_info.cmd, pkt_info.packet_id);
+					dcp_hfi_complete_pending(hfi, &pkt_info, 0);
+				} else {
+					dev_dbg_ratelimited(hfi->dev,
+							    "HFI resp: unhandled cmd=0x%x flags=0x%x pkt_id=%u\n",
+							    pkt_info.cmd, pkt_info.flags,
+							    pkt_info.packet_id);
+				}
+			}
+
+repost:
+			spin_lock_irqsave(&hfi->resp_drain_lock, drain_flags);
+			dcp_hfi_buf_init_sg(buf, DCP_HFI_BUF_SIZE);
+			if (virtqueue_add_inbuf_premapped(vq, &buf->sg, 1, buf,
+							  NULL, GFP_ATOMIC)) {
+				list_add_tail(&buf->node, &hfi->resp_repost_list);
+				schedule_delayed_work(&hfi->resp_repost_work,
+						      msecs_to_jiffies(20));
+			}
+		}
+
+		if (virtqueue_kick_prepare(vq))
+			virtqueue_notify(vq);
+		if (virtqueue_enable_cb(vq))
+			break;
+	}
+
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
+}
+
+int dcp_hfi_send_cmd_async(struct dcp_hfi *hfi,
+			   struct dcp_hfi_buf *buf,
+			     size_t cmd_len,
+			     struct dcp_hfi_completion *comp)
+{
+	unsigned long flags;
+	int ret;
+
+	buf->comp = comp;
+	dcp_hfi_buf_init_sg(buf, cmd_len);
+
+	/* Serialize shutdown with both queue submission and notification. */
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	if (atomic_read(&hfi->shutdown_in_progress)) {
+		spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+		dcp_hfi_buf_free(hfi, buf);
+		return -ENODEV;
+	}
+
+	if (comp) {
+		ret = dcp_hfi_pending_add(hfi, comp);
+		if (ret) {
+			spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+			dcp_hfi_buf_free(hfi, buf);
+			return ret;
+		}
+	}
+
+	ret = virtqueue_add_outbuf_premapped(hfi->cmd_vq, &buf->sg, 1, buf,
+					     GFP_ATOMIC);
+	if (ret) {
+		if (comp)
+			dcp_hfi_pending_find(hfi, comp->packet_id);
+		spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+		dcp_hfi_buf_free(hfi, buf);
+		dev_err(hfi->dev, "virtqueue_add_outbuf failed: %d\n", ret);
+		return ret;
+	}
+
+	virtqueue_kick(hfi->cmd_vq);
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+	return 0;
+}
+
+static const char *dcp_hfi_cmd_buff_type_name(enum hfi_cmd_buff_type cmd_type)
+{
+	switch (cmd_type) {
+	case HFI_CMD_BUFF_SYSTEM:         return "SYSTEM";
+	case HFI_CMD_BUFF_DEVICE:         return "DEVICE";
+	case HFI_CMD_BUFF_DISPLAY:        return "DISPLAY";
+	case HFI_CMD_BUFF_DEBUG:          return "DEBUG";
+	case HFI_CMD_BUFF_VIRTUALIZATION: return "VIRT";
+	default:                          return "UNKNOWN";
+	}
+}
+
+static int dcp_hfi_send_sync_on_vq(struct dcp_hfi *hfi,
+				   struct virtqueue *vq __maybe_unused,
+				    u32 cmd,
+				    enum hfi_cmd_buff_type cmd_type,
+				    u32 object_id,
+				    enum hfi_packet_payload_type payload_type,
+				    void *payload,
+				    u32 payload_size,
+				    u32 tx_flags,
+				    void *resp_data,
+				    size_t resp_len,
+				    unsigned int timeout_ms)
+{
+	struct dcp_hfi_buf *buf;
+	struct dcp_hfi_completion comp;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	u32 packet_id;
+	unsigned long flags;
+	int ret;
+
+	buf = dcp_hfi_buf_alloc(hfi);
+	if (!buf) {
+		dev_err(hfi->dev, "HFI TX buffer pool exhausted (cmd=0x%x)\n",
+			cmd);
+		return -ENOMEM;
+	}
+
+	hdl.cmd_buffer = buf->data;
+	hdl.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = cmd_type;
+	hdr_info.object_id     = object_id;
+	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret) {
+		dcp_hfi_buf_free(hfi, buf);
+		return ret;
+	}
+
+	packet_id = dcp_hfi_next_packet_id(hfi);
+
+	pkt_info.cmd          = cmd;
+	pkt_info.id           = object_id & 0xFFFF;
+	pkt_info.flags        = tx_flags;
+	pkt_info.packet_id    = packet_id;
+	pkt_info.payload_type = payload_type;
+	pkt_info.payload_size = payload_size;
+	pkt_info.payload_ptr  = payload;
+
+	if (payload_type == HFI_PAYLOAD_NONE || !payload || !payload_size)
+		ret = hfi_create_packet_header(&hdl, &pkt_info);
+	else
+		ret = hfi_create_full_packet(&hdl, &pkt_info);
+
+	if (ret) {
+		dcp_hfi_buf_free(hfi, buf);
+		return ret;
+	}
+
+	init_completion(&comp.done);
+	comp.resp_data = resp_data;
+	comp.resp_len  = resp_len;
+	comp.status    = 0;
+	comp.packet_id = packet_id;
+
+	dev_dbg(hfi->dev,
+		"HFI send cmd=0x%x type=%s obj=%u pkt=%u payload=%u timeout=%ums\n",
+		 cmd, dcp_hfi_cmd_buff_type_name(cmd_type), object_id,
+		 packet_id, payload_size, timeout_ms);
+
+	ret = dcp_hfi_send_cmd_async(hfi, buf,
+				     hfi_get_header_size(&hdl), &comp);
+	if (ret)
+		return ret;
+
+	if (!wait_for_completion_timeout(&comp.done, msecs_to_jiffies(timeout_ms))) {
+		dev_err(hfi->dev,
+			"HFI cmd=0x%x buf_type=%s object_id=%u timed out after %ums (pkt_id=%u)\n",
+			cmd, dcp_hfi_cmd_buff_type_name(cmd_type), object_id,
+			timeout_ms, packet_id);
+		spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+		dcp_hfi_pending_find(hfi, packet_id);
+		spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+		return -ETIMEDOUT;
+	}
+
+	return comp.status;
+}
+
+int dcp_hfi_send_sync(struct dcp_hfi *hfi,
+		      u32 cmd,
+		       enum hfi_cmd_buff_type cmd_type,
+		       u32 object_id,
+		       enum hfi_packet_payload_type payload_type,
+		       void *payload,
+		       u32 payload_size,
+		       u32 tx_flags,
+		       void *resp_data,
+		       size_t resp_len,
+		       unsigned int timeout_ms)
+{
+	int ret;
+
+	ret = dcp_hfi_send_sync_on_vq(hfi, NULL,
+				      cmd, cmd_type, object_id,
+				       payload_type, payload, payload_size,
+				       tx_flags, resp_data, resp_len,
+				       timeout_ms);
+	if (ret)
+		dev_err(hfi->dev, "HFI command 0x%x failed: %d\n", cmd, ret);
+
+	return ret;
+}
+
+int dcp_hfi_send_no_wait_flags(struct dcp_hfi *hfi,
+			       u32 cmd,
+				 enum hfi_cmd_buff_type cmd_type,
+				 u32 object_id,
+				 enum hfi_packet_payload_type payload_type,
+				 void *payload,
+				 u32 payload_size,
+				 u32 tx_flags)
+{
+	struct dcp_hfi_buf *buf;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	int ret;
+
+	buf = dcp_hfi_buf_alloc(hfi);
+	if (!buf) {
+		dev_warn_ratelimited(hfi->dev,
+				     "HFI TX pool exhausted (no-wait cmd=0x%x)\n", cmd);
+		return -ENOMEM;
+	}
+
+	hdl.cmd_buffer = buf->data;
+	hdl.size       = DCP_HFI_BUF_SIZE;
+
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = cmd_type;
+	hdr_info.object_id     = object_id;
+	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret) {
+		dcp_hfi_buf_free(hfi, buf);
+		return ret;
+	}
+
+	pkt_info.cmd          = cmd;
+	pkt_info.id           = object_id & 0xFFFF;
+	pkt_info.flags        = tx_flags;
+	pkt_info.packet_id    = dcp_hfi_next_packet_id(hfi);
+	pkt_info.payload_type = payload_type;
+	pkt_info.payload_size = payload_size;
+	pkt_info.payload_ptr  = payload;
+
+	if (payload_type == HFI_PAYLOAD_NONE || !payload || !payload_size)
+		ret = hfi_create_packet_header(&hdl, &pkt_info);
+	else
+		ret = hfi_create_full_packet(&hdl, &pkt_info);
+
+	if (ret) {
+		dcp_hfi_buf_free(hfi, buf);
+		return ret;
+	}
+
+	ret = dcp_hfi_send_cmd_async(hfi, buf,
+				     hfi_get_header_size(&hdl), NULL);
+	if (ret)
+		dev_warn(hfi->dev,
+			 "HFI send (no-wait) cmd=0x%x pkt_id=%u failed: %d\n",
+			 cmd, pkt_info.packet_id, ret);
+
+	return ret;
+}
+
+int dcp_hfi_send_no_wait_atomic_flags(struct dcp_hfi *hfi,
+				      u32 cmd,
+				       enum hfi_cmd_buff_type cmd_type,
+				       u32 object_id,
+				       enum hfi_packet_payload_type payload_type,
+				       void *payload,
+				       u32 payload_size,
+				       u32 tx_flags)
+{
+	struct dcp_hfi_buf *buf;
+	struct hfi_cmd_buff_hdl hdl;
+	struct hfi_header_info hdr_info;
+	struct hfi_packet_info pkt_info;
+	int ret;
+
+	buf = dcp_hfi_buf_alloc_atomic(hfi);
+	if (!buf)
+		return -ENOMEM;
+
+	hdl.cmd_buffer = buf->data;
+	hdl.size       = DCP_HFI_BUF_SIZE;
+	hdr_info.num_packets   = 0;
+	hdr_info.cmd_buff_type = cmd_type;
+	hdr_info.object_id     = object_id;
+	hdr_info.header_id     = dcp_hfi_next_packet_id(hfi);
+
+	ret = hfi_create_header(&hdl, &hdr_info);
+	if (ret)
+		goto free_buf;
+
+	pkt_info.cmd          = cmd;
+	pkt_info.id           = object_id & 0xFFFF;
+	pkt_info.flags        = tx_flags;
+	pkt_info.packet_id    = dcp_hfi_next_packet_id(hfi);
+	pkt_info.payload_type = payload_type;
+	pkt_info.payload_size = payload_size;
+	pkt_info.payload_ptr  = payload;
+
+	if (payload_type == HFI_PAYLOAD_NONE || !payload || !payload_size)
+		ret = hfi_create_packet_header(&hdl, &pkt_info);
+	else
+		ret = hfi_create_full_packet(&hdl, &pkt_info);
+	if (ret)
+		goto free_buf;
+
+	return dcp_hfi_send_cmd_async(hfi, buf,
+				      hfi_get_header_size(&hdl), NULL);
+
+free_buf:
+	dcp_hfi_buf_free(hfi, buf);
+	return ret;
+}
+
+int dcp_hfi_send_no_wait(struct dcp_hfi *hfi,
+			 u32 cmd,
+			   enum hfi_cmd_buff_type cmd_type,
+			   u32 object_id,
+			   enum hfi_packet_payload_type payload_type,
+			   void *payload,
+			   u32 payload_size)
+{
+	return dcp_hfi_send_no_wait_flags(hfi, cmd, cmd_type, object_id,
+			payload_type, payload, payload_size, HFI_TX_FLAGS_NONE);
+}
+
+static void dcp_hfi_resource_vote_work(struct work_struct *work)
+{
+	struct dcp_hfi *hfi = container_of(work, struct dcp_hfi,
+					     resource_vote_work);
+	u8 buf[DCP_HFI_RESOURCE_VOTE_BUF_SIZE];
+	struct dcp_resource_vote_pair pairs[DCP_HFI_RESOURCE_VOTE_BUF_SIZE /
+							 sizeof(struct dcp_resource_vote_wire)];
+	const struct dcp_resource_vote_wire *wire;
+	u32 len, generation, count, i;
+	bool dirty;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
+		len = hfi->resource_vote_len;
+		generation = hfi->resource_vote_generation;
+		if (len)
+			memcpy(buf, hfi->resource_vote_buf, len);
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
+
+		if (!len || !hfi->resource_vote_cb)
+			return;
+		if (len % sizeof(struct dcp_resource_vote_wire)) {
+			dev_warn_ratelimited(hfi->dev,
+					     "dropping malformed RESOURCE_VOTE size=%u\n", len);
+			return;
+		}
+		count = len / sizeof(struct dcp_resource_vote_wire);
+		wire = (const struct dcp_resource_vote_wire *)buf;
+		for (i = 0; i < count; i++) {
+			pairs[i].key = le32_to_cpu(wire[i].key);
+			pairs[i].value = get_unaligned_le64(&wire[i].value);
+		}
+
+		hfi->resource_vote_cb(hfi->drv, pairs, count);
+		spin_lock_irqsave(&hfi->resource_vote_lock, flags);
+		dirty = generation != hfi->resource_vote_generation;
+		spin_unlock_irqrestore(&hfi->resource_vote_lock, flags);
+	} while (dirty);
+}
+
+static void dcp_hfi_free_pool(struct dcp_hfi *hfi, struct dcp_hfi_buf *pool,
+			      u32 count)
+{
+	u32 i;
+
+	if (!pool)
+		return;
+
+	for (i = 0; i < count; i++) {
+		if (!pool[i].data)
+			continue;
+
+		dma_free_coherent(hfi->dma_dev, DCP_HFI_BUF_SIZE,
+				  pool[i].data, pool[i].dma_addr);
+		pool[i].data = NULL;
+	}
+}
+
+static int dcp_hfi_prepost_resp_bufs(struct dcp_hfi *hfi)
+{
+	int i, ret;
+
+	for (i = 0; i < DCP_HFI_RESP_POOL_SIZE; i++) {
+		struct dcp_hfi_buf *buf = &hfi->resp_pool[i];
+
+		dcp_hfi_buf_init_sg(buf, DCP_HFI_BUF_SIZE);
+
+		ret = virtqueue_add_inbuf_premapped(hfi->resp_vq, &buf->sg, 1,
+						    buf, NULL, GFP_KERNEL);
+		if (ret) {
+			dev_warn(hfi->dev,
+				 "resp_vq full at buf %d/%d: %d\n",
+				 i, DCP_HFI_RESP_POOL_SIZE, ret);
+			break;
+		}
+	}
+	return ret;
+}
+
+static void dcp_hfi_resp_repost_work(struct work_struct *work)
+{
+	struct dcp_hfi *hfi = container_of(to_delayed_work(work), struct dcp_hfi,
+					      resp_repost_work);
+	struct dcp_hfi_buf *buf, *tmp;
+	unsigned long flags;
+	bool retry = false;
+
+	if (atomic_read(&hfi->shutdown_in_progress))
+		return;
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	list_for_each_entry_safe(buf, tmp, &hfi->resp_repost_list, node) {
+		dcp_hfi_buf_init_sg(buf, DCP_HFI_BUF_SIZE);
+		if (virtqueue_add_inbuf_premapped(hfi->resp_vq, &buf->sg, 1,
+						  buf, NULL, GFP_ATOMIC)) {
+			retry = true;
+			break;
+		}
+		list_del_init(&buf->node);
+	}
+	if (virtqueue_kick_prepare(hfi->resp_vq))
+		virtqueue_notify(hfi->resp_vq);
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+	if (retry && !atomic_read(&hfi->shutdown_in_progress))
+		schedule_delayed_work(&hfi->resp_repost_work, msecs_to_jiffies(20));
+}
+
+int dcp_hfi_init(struct dcp_drv *drv,
+		 struct virtio_device *vdev,
+		  struct virtqueue *cmd_vq,
+		  struct virtqueue *resp_vq,
+		  struct device *dma_dev)
+{
+	struct dcp_hfi *hfi;
+	int i, ret;
+
+	hfi = devm_kzalloc(&vdev->dev, sizeof(*hfi), GFP_KERNEL);
+	if (!hfi)
+		return -ENOMEM;
+
+	hfi->dev     = &vdev->dev;
+	hfi->drv     = drv;
+	hfi->cmd_vq  = cmd_vq;
+	hfi->resp_vq = resp_vq;
+	hfi->dma_dev = dma_dev;
+
+	spin_lock_init(&hfi->cmd_lock);
+	spin_lock_init(&hfi->pending_lock);
+	spin_lock_init(&hfi->resource_vote_lock);
+	spin_lock_init(&hfi->resp_drain_lock);
+	spin_lock_init(&hfi->caps_lock);
+	mutex_init(&hfi->caps_cache_lock);
+
+	atomic_set(&hfi->packet_id, 0);
+	atomic_set(&hfi->shutdown_in_progress, 0);
+
+	INIT_LIST_HEAD(&hfi->cmd_free_list);
+
+	xa_init(&hfi->pending_xa);
+
+	INIT_WORK(&hfi->resource_vote_work, dcp_hfi_resource_vote_work);
+	INIT_DELAYED_WORK(&hfi->resp_repost_work, dcp_hfi_resp_repost_work);
+	INIT_LIST_HEAD(&hfi->resp_repost_list);
+	hfi->resource_vote_len = 0;
+	hfi->resource_vote_generation = 0;
+
+	hfi->cmd_pool = devm_kcalloc(hfi->dev, DCP_HFI_CMD_POOL_SIZE,
+				     sizeof(*hfi->cmd_pool), GFP_KERNEL);
+	if (!hfi->cmd_pool)
+		return -ENOMEM;
+
+	hfi->resp_pool = devm_kcalloc(hfi->dev, DCP_HFI_RESP_POOL_SIZE,
+				      sizeof(*hfi->resp_pool), GFP_KERNEL);
+	if (!hfi->resp_pool)
+		return -ENOMEM;
+
+	hfi->caps_cache = NULL;
+	for (i = 0; i < DCP_HFI_CMD_POOL_SIZE; i++) {
+		hfi->cmd_pool[i].data = dma_alloc_coherent(hfi->dma_dev,
+							   DCP_HFI_BUF_SIZE,
+							 &hfi->cmd_pool[i].dma_addr,
+							 GFP_KERNEL);
+		if (!hfi->cmd_pool[i].data) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		hfi->cmd_pool[i].size = DCP_HFI_BUF_SIZE;
+		list_add_tail(&hfi->cmd_pool[i].node, &hfi->cmd_free_list);
+	}
+
+	for (i = 0; i < DCP_HFI_RESP_POOL_SIZE; i++) {
+		hfi->resp_pool[i].data =
+			dma_alloc_coherent(hfi->dma_dev, DCP_HFI_BUF_SIZE,
+					   &hfi->resp_pool[i].dma_addr, GFP_KERNEL);
+		if (!hfi->resp_pool[i].data) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		hfi->resp_pool[i].size = DCP_HFI_BUF_SIZE;
+		INIT_LIST_HEAD(&hfi->resp_pool[i].node);
+	}
+
+	ret = dcp_hfi_prepost_resp_bufs(hfi);
+	if (ret)
+		goto err;
+
+	drv->hfi = hfi;
+	dev_dbg(hfi->dev,
+		"HFI core initialized: cmd_vq=%p resp_vq=%p\n",
+		cmd_vq, resp_vq);
+	return 0;
+
+err:
+	atomic_set(&hfi->shutdown_in_progress, 1);
+	cancel_work_sync(&hfi->resource_vote_work);
+	cancel_delayed_work_sync(&hfi->resp_repost_work);
+	while (virtqueue_detach_unused_buf(hfi->cmd_vq))
+		;
+	while (virtqueue_detach_unused_buf(hfi->resp_vq))
+		;
+	xa_destroy(&hfi->pending_xa);
+
+	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);
+	dcp_hfi_free_pool(hfi, hfi->resp_pool, DCP_HFI_RESP_POOL_SIZE);
+	return ret;
+}
+
+void dcp_hfi_set_power_control_cb(struct dcp_hfi *hfi, void *priv,
+				  void (*cb)(void *priv, u32 display_id,
+					     u32 power_mask, bool enable,
+					     u32 packet_id))
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	hfi->power_control_priv = priv;
+	hfi->power_control_cb = cb;
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+}
+
+void dcp_hfi_clear_power_control_cb(struct dcp_hfi *hfi, void *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	if (hfi->power_control_priv == priv) {
+		hfi->power_control_priv = NULL;
+		hfi->power_control_cb = NULL;
+	}
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+}
+
+void dcp_hfi_stop(struct dcp_hfi *hfi)
+{
+	unsigned long flags;
+
+	if (!hfi)
+		return;
+
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	atomic_set(&hfi->shutdown_in_progress, 1);
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+
+	cancel_work_sync(&hfi->resource_vote_work);
+	cancel_delayed_work_sync(&hfi->resp_repost_work);
+	dcp_hfi_cancel_pending(hfi, -ENODEV);
+}
+
+void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi)
+{
+	unsigned long flags;
+
+	if (!hfi)
+		return;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	if (hfi->cmd_vq)
+		virtqueue_disable_cb(hfi->cmd_vq);
+	if (hfi->resp_vq)
+		virtqueue_disable_cb(hfi->resp_vq);
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+
+	if (hfi->cmd_vq)
+		while (virtqueue_detach_unused_buf(hfi->cmd_vq))
+			;
+	if (hfi->resp_vq)
+		while (virtqueue_detach_unused_buf(hfi->resp_vq))
+			;
+}
+
+void dcp_hfi_deinit(struct dcp_hfi *hfi)
+{
+	struct dcp_hfi_caps_cache *cache;
+	unsigned long flags;
+
+	if (!hfi)
+		return;
+
+	dcp_hfi_stop(hfi);
+
+	mutex_lock(&hfi->caps_cache_lock);
+	spin_lock_irqsave(&hfi->caps_lock, flags);
+	cache = hfi->caps_cache;
+	hfi->caps_cache = NULL;
+	spin_unlock_irqrestore(&hfi->caps_lock, flags);
+	kfree(cache);
+	mutex_unlock(&hfi->caps_cache_lock);
+
+	xa_destroy(&hfi->pending_xa);
+
+	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);
+	dcp_hfi_free_pool(hfi, hfi->resp_pool, DCP_HFI_RESP_POOL_SIZE);
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
new file mode 100644
index 000000000000..4f7d0ff3d9f5
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Private HFI helpers; external users should include dcp_hfi.h.
+ */
+
+#ifndef __DCP_HFI_PRIV_H__
+#define __DCP_HFI_PRIV_H__
+
+#include "dcp_hfi.h"
+
+#define DCP_HFI_CMD_POOL_SIZE					64
+#define DCP_HFI_RESP_POOL_SIZE					64
+#define DCP_HFI_BUF_SIZE						4096
+#define DCP_HFI_CAPS_BUF_SIZE					DCP_HFI_BUF_SIZE
+
+#define DCP_HFI_TIMEOUT_INIT_MS					2000
+#define DCP_HFI_TIMEOUT_RESOURCE_REGISTER_MS	5000
+#define DCP_HFI_TIMEOUT_CAPS_MS					1000
+#define DCP_HFI_TIMEOUT_DISPLAY_MS				1000
+#define DCP_HFI_TIMEOUT_MODE_MS					3000
+#define DCP_HFI_TIMEOUT_COMMIT_MS				2000
+#define DCP_HFI_TIMEOUT_DISPLAY_DCS_MS			10000
+
+struct dcp_hfi_caps_cache {
+	struct completion device_done;
+	struct completion display_done;
+
+	u8 device_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 device_len;
+
+	u8 display_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 display_len;
+
+	u8 vig_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 vig_len;
+
+	u8 dma_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 dma_len;
+
+	u8 vig_r1_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 vig_r1_len;
+
+	u8 dma_r1_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 dma_r1_len;
+
+	u32 pipe_caps_received;
+};
+
+struct dcp_hfi_buf *dcp_hfi_buf_alloc(struct dcp_hfi *hfi);
+struct dcp_hfi_buf *dcp_hfi_buf_alloc_atomic(struct dcp_hfi *hfi);
+void dcp_hfi_buf_free(struct dcp_hfi *hfi, struct dcp_hfi_buf *buf);
+
+static inline void dcp_hfi_buf_init_sg(struct dcp_hfi_buf *buf, size_t len)
+{
+	sg_init_table(&buf->sg, 1);
+	sg_dma_address(&buf->sg) = buf->dma_addr;
+	sg_dma_len(&buf->sg) = len;
+}
+
+u32 dcp_hfi_next_packet_id(struct dcp_hfi *hfi);
+
+int dcp_hfi_send_cmd_async(struct dcp_hfi *hfi,
+			   struct dcp_hfi_buf *buf,
+			     size_t cmd_len,
+			     struct dcp_hfi_completion *comp);
+
+int dcp_hfi_pending_add(struct dcp_hfi *hfi, struct dcp_hfi_completion *comp);
+
+struct dcp_hfi_completion *dcp_hfi_pending_find(struct dcp_hfi *hfi,
+						u32 packet_id);
+
+#endif /* __DCP_HFI_PRIV_H__ */

-- 
2.43.0

