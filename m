Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54ACCC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1089B1120F4;
	Thu, 15 Oct 2026 07:40:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 465841120F4
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:24 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F6CVwa644694
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ICxP8UmolakfqS6Z7WdDKjAETrqXC6rnAY1kBoKlKJg=; b=DJ7IRDfckUbO4th/
 TVMWvUGOLeTZshMtYaz00aYO9shN49/ciJOYlUVHICDP5o8yOv7GRHATNPMWcE+i
 j7xa7sJ8vcyaAgdqdXuZKHV3YkcZJGYrkpozQTwesjnPcFtl5i0O3cu4dGiGEDgT
 xhvGCWrr5nEPetUIDWHIBn5mtdW5yrIqmgeaJ5GSU6acpS16ydHSe/lt0acy69Iz
 CNYNSfOHhBfprqyDsAe5GyXkxpudPAq9N3K9KX+H0AsdWHSWsN8S61kPm3Hy0e12
 LWDSFMfn4AkMXHt6vhscpCycU3I4WnNkj37kghRVEhg6QUVrt3Iw7L0iNqC3K5zA
 /p11og==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hajmy9ryw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:40:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e617b5e9b3so36007945ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792050023; x=1792654823;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ICxP8UmolakfqS6Z7WdDKjAETrqXC6rnAY1kBoKlKJg=;
 b=GGXDKMsOu1TDzfhLlfPK0jxCjA8+OL9XqCKpNRUl3Gi9SbcRrTkGxZ9cWIcqv19NmV
 Pl5V7XcpHTmuCo01OvP/Ere/EXsA2pj5DFFUwOuy2nJiNkvcmXEaFKPhrhuB23Gqlwl1
 5Y69rPuLRojelCuUZOFKucprpfW/h1R655svimJy7+5pmU1/rlVEaScOqW4e4YisRwCJ
 g7WYhZ17BFpBqdHfCb8VOecMTg1UwOpPfBFfxRhoIa13MHfkWSZiUZOIrAi6koIi69k0
 b7GscokhuYphf3qEoEqitK6BWCwHNn5aVicEZ8rRAI8oaWkBBFpX8L5GWfzMbzMj7Epd
 QR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050023; x=1792654823;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ICxP8UmolakfqS6Z7WdDKjAETrqXC6rnAY1kBoKlKJg=;
 b=fJb2f1PcSzKHdF3Bw15bpO8tK5eACbFUgYgEadZOyvBm4tjcnRBUocDa0qnf9HSATB
 HURoHQqMdbPLgIhDlvf9oM2Zv3f85qTnazAtPwcJ086g/5ac5hc2HzT6NjeJUa7uTWWs
 Ym+JuaVA917o2GifR4KLW+UD1XmphTb2dd3eBPjJU5J6UOweCjtApCl4Z9InGmE+5TUF
 IddSnsKmZX2TP1dP+EvlY6qcl/cEzGa/ev8IVQVhFimG5gbvmr5srzv3vSOlPxq8atlY
 c+Ze8R4pV3aTVgXkewICT3OXYwKGsMhdVOyZXOL9dtGFyCpOee2PqhE8aa+MNpSXAx+N
 X40Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByOT4OjfW08yyYztVw3a4eSRMaRTzz4er/sMcitRTQDUGYS3+HOoWQJSaiFXgAvMzYMLwfiy/7bi2w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLrNeYWyuSKw1Q9MhkqO1nvrVjAZQlGialX/wphXbdbKxfMVYvz
 BkhOpxo5WI47EN0k0O8pxWC/LkxmKc6+gQaMKx5X1iwHEgFvSa1Lym2OjG+khwTe5Uqh4wZSygH
 9dy5u5BXceldsR4tjyGzJrYzBFaXOmbk18m6AJRwX3lOo+oGtIv9TdO8K8M7YycSKP8ZNLh8=
X-Gm-Gg: AYBFou1srcp8KAvAirKnmylFynplTP0njZH1zaxZpukkk4PF4UJYn9CsZySC7bNmpMN
 yfGv76EXxsNAWih8Oaxb+54qQJz1TMcl7y22cKmG3BwYNfDXjKcSFYuJrU47qEfHItc010YFxOG
 f4W3dPyA/kbv65X9G8yCsQRoNRMLORt+xF7/QUTOhk9qWaXeEP5QQrKhlYq7JgiddFLo5aIBy+F
 zvhZ7VL1ic0QB/qfr2+bswUqoDOUbiMRJCkgRl8B7BxSrJDRPFsAJZi60HrAZVwzTdxTrvlvPzD
 T/ozi99Rez2FI+LOhemS/0V4B0QJ+oXe+BiLE2vTEAxY7bcyNW7PewR9GoK2NU3hxTXBLQvpE82
 YX6McRDaDjArM5qFqrluf3z9Tu/wX3B9JBdU=
X-Received: by 2002:a17:902:f710:b0:2e9:3d65:22f2 with SMTP id
 d9443c01a7336-2e93d652861mr39015855ad.25.1792050022427; 
 Thu, 15 Oct 2026 00:40:22 -0700 (PDT)
X-Received: by 2002:a17:902:f710:b0:2e9:3d65:22f2 with SMTP id
 d9443c01a7336-2e93d652861mr39015545ad.25.1792050021842; 
 Thu, 15 Oct 2026 00:40:21 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:40:21 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:29 +0530
Subject: [PATCH 09/13] drm/msm/dcp: Register DCP display pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-9-48aad0fe4f72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=17374;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=KYrI9TOYyqGYIwURQefIDdE6XAH5LADAP+jElVKkJJM=;
 b=6yTDaTM90RlBWi3BqNEXOI7W7YZ/182e/2tfE3+wkxtNEaX65jcp9q5Jr+lomD8aiNN/e9yx+
 16HHXzZj8VCBImYhWD+rIhF1fbJaYBxvRGJZHyGqKLTGmK6WRi3pxzL
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-GUID: 5EKxUwgXDMfNxBZaUdtBJ8b_y4qoW22u
X-Proofpoint-ORIG-GUID: 5EKxUwgXDMfNxBZaUdtBJ8b_y4qoW22u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX0GHDMNvfFWjw
 N3XV5NnIO8sZE/tFENb8mg4+JbHCMhWEGc6bSbEyTp7WALSCTODvITk//qwoiI2lwZ/sKlcaBO4
 DDyxTQxcWpQYr5ODSMXK6YHIobHUCt0=
X-Authority-Analysis: v=2.4 cv=TbQDJhQh c=1 sm=1 tr=0 ts=6ad08367 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=_JdZWGNZrHrwUqfPKK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX5z+GW0UVWq5Z
 bPFSX4qlNCA2ywrw5zLy0A8AtTuShM9vn06RfH4NIX1IsbhTfw81ExH0EItPyIW/4AWlMJmw2f9
 VrzO/BiOkL/E8H2TLwODALAzejO+uM2Y26zPn+r+EkAzdN4UoATQlvCR8/PsNzua1R6mQnHXr0O
 AZH/2/gSMYNk7w5RNIOR17Qa3yqGULFcBrqDBAqgT2gouGw4xZE8rnqXGupTwJl1lMovn+YUuao
 kw4hFSw1t6yfR8RfI5tsMVuqdYEG1mjtVLgf1jSA7LfOpQaN7QR9l0Nqy8msdy2sxSymhZNi3Kt
 EI0lj5Epu7155pLfezNDfXVppD1wn+r8KhnUk6JASU/Bud6LXsDXKoGvED+CCpcxBnK+irEJ4K3
 pA0zhCAhbzsxnRfRRg0ds7Hy+VvZqwNxND0HaW9d/ibCvxMojYbwaiUEVMgYjtvIDDXe6ypvUkw
 ZO5vlS2oU84KJPSScjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030
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

The DCP firmware exposes display resources through capabilities rather than
through host-visible display registers. The MSM DRM backend therefore needs
to build its KMS objects from the firmware capabilities and device-tree
display graph.

Complete DCP KMS registration, including power and IOMMU integration,
capability handling, display-graph parsing, and creation of DRM planes,
CRTCs, encoders, bridges, and connectors.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c | 589 +++++++++++++++++++++++++++++++++-
 1 file changed, 588 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
index d465164b158b..e87c24d44417 100644
--- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
+++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
@@ -4,10 +4,30 @@
  * DCP KMS driver.
  */
 
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/pm_runtime.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_vblank.h>
 
-#include "dcp_dpu_kms.h"
+#include "msm_drv.h"
+#include "msm_gem.h"
+#include "msm_kms.h"
+
+#include "dcp_crtc.h"
 #include "dcp_dsi_bridge.h"
+#include "dcp_dpu_kms.h"
+#include "dcp_drv.h"
+#include "dcp_encoder.h"
+#include "dcp_hfi.h"
+#include "dcp_plane.h"
 
 int dcp_dpu_kms_prepare_crtc_session(struct dcp_dpu_kms *dpu_kms,
 				     struct drm_crtc *crtc)
@@ -70,3 +90,570 @@ bool dcp_dpu_kms_needs_dirtyfb(struct dcp_dpu_kms *dpu_kms,
 
 	return false;
 }
+
+static void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dpu_kms)
+{
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dpu_kms->dsi_bridge); i++) {
+		if (!dpu_kms->dsi_bridge[i])
+			continue;
+
+		dcp_dsi_bridge_cleanup(dpu_kms->dsi_bridge[i]);
+		dpu_kms->dsi_bridge[i] = NULL;
+	}
+}
+
+static void dcp_dpu_kms_dump_caps(struct dcp_dpu_kms *dpu_kms)
+{
+	struct device *dev = dpu_kms->dev->dev;
+	const struct dcp_caps *caps = dpu_kms->caps;
+	u32 i;
+
+	dev_dbg(dev, "DCP caps: hw=%u.%u fw=%u valid=%u dyn_clk=%u crtcs=%u\n",
+		caps->dcp_hw_rev, caps->hw_rev, caps->fw_rev, caps->valid,
+		 caps->dyn_clk_support, caps->num_crtcs);
+	dev_dbg(dev, "DCP caps: max_planes=%u max=%ux%u features=0x%x\n",
+		caps->max_planes, caps->max_width, caps->max_height,
+		 caps->features);
+
+	dev_dbg(dev, "DCP caps: VIG pipes=%u virt=%u\n",
+		caps->num_vig_pipes, caps->virt_vig_count);
+	for (i = 0; i < min_t(u32, caps->num_vig_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		dev_dbg(dev, "DCP caps: VIG[%u] pipe=%u r1=%u\n", i,
+			caps->vig_pipe_ids[i], caps->vig_r1_indices[i]);
+
+	dev_dbg(dev, "DCP caps: DMA pipes=%u virt=%u\n",
+		caps->num_dma_pipes, caps->virt_dma_count);
+	for (i = 0; i < min_t(u32, caps->num_dma_pipes,
+			      DCP_MAX_SSPP_COUNT); i++)
+		dev_dbg(dev, "DCP caps: DMA[%u] pipe=%u r1=%u\n", i,
+			caps->dma_pipe_ids[i], caps->dma_r1_indices[i]);
+
+	dev_dbg(dev, "DCP caps: DSI count=%u max_resolution=0x%x\n",
+		caps->dsi_count, caps->max_dsi_resolution);
+	for (i = 0; i < min_t(u32, caps->dsi_count, DCP_MAX_BLOCKS); i++)
+		dev_dbg(dev, "DCP caps: DSI[%u] index=%u\n", i,
+			caps->dsi_indices[i]);
+
+	dev_dbg(dev, "DCP caps: DP count=%u\n", caps->dp_count);
+	for (i = 0; i < min_t(u32, caps->dp_count, DCP_MAX_BLOCKS); i++)
+		dev_dbg(dev, "DCP caps: DP[%u] index=%u\n", i,
+			caps->dp_indices[i]);
+
+	for (i = 0; i < DCP_MAX_DISPLAYS; i++)
+		dev_dbg(dev, "DCP caps: active_pipes_mask[%u]=0x%x\n", i,
+			caps->active_pipes_mask[i]);
+}
+
+static int dcp_dpu_kms_hw_init(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+	struct drm_device *dev = dpu_kms->dev;
+	struct drm_gpuvm *vm;
+	int ret;
+
+	kms->irq = IRQ_NOTCONNECTED;
+	dev->mode_config.cursor_width  = 512;
+	dev->mode_config.cursor_height = 512;
+
+	ret = pm_runtime_resume_and_get(dpu_kms->pm_dev);
+	if (ret < 0) {
+		dev_err(dev->dev, "failed to enable power: %d\n", ret);
+		return ret;
+	}
+
+	vm = msm_kms_init_vm(dev, NULL);
+	if (IS_ERR(vm)) {
+		dev_err(dev->dev, "SMMU/IOMMU init failed: %pe\n", vm);
+		ret = PTR_ERR(vm);
+		goto err_cleanup;
+	}
+	kms->vm = vm;
+
+	if (dpu_kms->drv && !dpu_kms->hfi)
+		dpu_kms->hfi = dpu_kms->drv->hfi;
+	if (!dpu_kms->hfi) {
+		dev_err(dev->dev, "HFI unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+
+	if (!dpu_kms->caps || !dpu_kms->caps->valid) {
+		dev_err(dev->dev, "DCP caps unavailable, cannot initialize DCP KMS\n");
+		ret = -ENODEV;
+		goto err_cleanup;
+	}
+
+	dcp_dpu_kms_dump_caps(dpu_kms);
+
+	dev->mode_config.min_width  = 0;
+	dev->mode_config.min_height = 0;
+	dev->mode_config.max_width  = max(dpu_kms->caps->max_width,
+					  dpu_kms->caps->max_height);
+	dev->mode_config.max_height = dev->mode_config.max_width;
+	dev->max_vblank_count = 0xffffffff;
+	dev->vblank_disable_immediate = true;
+
+	ret = dcp_dpu_drm_obj_init(dpu_kms);
+	if (ret) {
+		dev_err(dev->dev, "DRM object init failed: %d\n", ret);
+		goto err_cleanup;
+	}
+
+	pm_runtime_put_autosuspend(dpu_kms->pm_dev);
+	dev_dbg(dev->dev, "DCP hw_init complete\n");
+	return 0;
+
+err_cleanup:
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach)
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+	pm_runtime_put_autosuspend(dpu_kms->pm_dev);
+	return ret;
+}
+
+static void dcp_dpu_kms_enable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dpu_kms->pm_dev);
+	if (ret < 0) {
+		dpu_kms->commit_pm_active = false;
+		dev_err_ratelimited(dpu_kms->dev->dev,
+				    "pm_runtime_resume_and_get failed: %d\n",
+				    ret);
+		return;
+	}
+
+	dpu_kms->commit_pm_active = true;
+}
+
+static void dcp_dpu_kms_disable_commit(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+
+	if (dpu_kms->commit_pm_active) {
+		pm_runtime_put_autosuspend(dpu_kms->pm_dev);
+		dpu_kms->commit_pm_active = false;
+	}
+}
+
+static int dcp_dpu_kms_check_mode_changed(struct msm_kms *kms,
+					  struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *new_crtc_state, *old_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
+				      new_crtc_state, i) {
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+		if (!new_crtc_state->active)
+			continue;
+		new_crtc_state->planes_changed = true;
+	}
+
+	return 0;
+}
+
+static void dcp_dpu_kms_flush_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dpu_kms->dev, crtc, crtc_mask) {
+		if (!crtc->state || !crtc->state->active)
+			continue;
+		dcp_crtc_commit_kickoff(crtc);
+	}
+}
+
+static void dcp_dpu_kms_wait_flush(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dpu_kms->dev, crtc, crtc_mask)
+		dcp_crtc_wait_for_commit_done(crtc);
+}
+
+static void dcp_dpu_kms_complete_commit(struct msm_kms *kms, unsigned int crtc_mask)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+	struct drm_crtc *crtc;
+
+	for_each_crtc_mask(dpu_kms->dev, crtc, crtc_mask)
+		dcp_crtc_complete_commit(crtc);
+}
+
+static int dcp_dpu_kms_enable_vblank(struct msm_kms *kms, struct drm_crtc *crtc)
+{
+	return dcp_crtc_vblank(crtc, true);
+}
+
+static void dcp_dpu_kms_disable_vblank(struct msm_kms *kms,
+				       struct drm_crtc *crtc)
+{
+	dcp_crtc_vblank(crtc, false);
+}
+
+static void dcp_dpu_kms_destroy(struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+
+	dcp_dpu_kms_cleanup_bridges(dpu_kms);
+
+	if (kms->vm) {
+		struct msm_gem_vm *msm_vm = to_msm_vm(kms->vm);
+
+		if (msm_vm->mmu && msm_vm->mmu->funcs->detach) {
+			dev_dbg(dpu_kms->dev ? dpu_kms->dev->dev : NULL,
+				"%s: detaching IOMMU domain from dcp-dpus\n", __func__);
+			msm_vm->mmu->funcs->detach(msm_vm->mmu);
+		}
+
+		drm_gpuvm_put(kms->vm);
+		kms->vm = NULL;
+	}
+
+	if (dpu_kms->rpm_enabled) {
+		pm_runtime_disable(dpu_kms->pm_dev);
+		dpu_kms->rpm_enabled = false;
+	}
+
+	msm_kms_destroy(&dpu_kms->base);
+}
+
+static void dcp_dpu_kms_irq_preinstall(struct msm_kms *kms) {}
+static void dcp_dpu_kms_irq_uninstall(struct msm_kms *kms) {}
+
+static irqreturn_t dcp_dpu_kms_irq(struct msm_kms *kms)
+{
+	return IRQ_NONE;
+}
+
+static void dcp_dpu_kms_snapshot(struct msm_disp_state *disp_state,
+				 struct msm_kms *kms)
+{
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(kms);
+
+	dev_dbg(dpu_kms->dev->dev,
+		"DCP snapshot: max %ux%u, features=0x%x\n",
+		 dpu_kms->caps->max_width,
+		 dpu_kms->caps->max_height,
+		 dpu_kms->caps->features);
+}
+
+const struct msm_kms_funcs dcp_dpu_kms_funcs = {
+	.hw_init            = dcp_dpu_kms_hw_init,
+	.irq_preinstall     = dcp_dpu_kms_irq_preinstall,
+	.irq_uninstall      = dcp_dpu_kms_irq_uninstall,
+	.irq                = dcp_dpu_kms_irq,
+	.enable_commit      = dcp_dpu_kms_enable_commit,
+	.disable_commit     = dcp_dpu_kms_disable_commit,
+	.check_mode_changed = dcp_dpu_kms_check_mode_changed,
+	.flush_commit       = dcp_dpu_kms_flush_commit,
+	.wait_flush         = dcp_dpu_kms_wait_flush,
+	.complete_commit    = dcp_dpu_kms_complete_commit,
+	.enable_vblank      = dcp_dpu_kms_enable_vblank,
+	.disable_vblank     = dcp_dpu_kms_disable_vblank,
+	.destroy            = dcp_dpu_kms_destroy,
+	.snapshot           = dcp_dpu_kms_snapshot,
+};
+
+static u32 dcp_dpu_kms_resolve_fw_display_id(struct dcp_dpu_kms *dpu_kms,
+					     bool is_dp, u32 intf_idx)
+{
+	struct dcp_caps *caps = dpu_kms->caps;
+	u32 count = 0;
+	const u32 *ids = NULL;
+	u32 id;
+
+	if (caps) {
+		count = is_dp ? caps->dp_count : caps->dsi_count;
+		ids   = is_dp ? caps->dp_indices : caps->dsi_indices;
+	}
+
+	if (!ids || intf_idx >= count) {
+		dev_err(dpu_kms->dev->dev,
+			"%s%u: no catalog entry (%u)\n",
+			is_dp ? "DP" : "DSI", intf_idx, count);
+		return U32_MAX;
+	}
+
+	id = ids[intf_idx];
+
+	if (id > 0xFF) {
+		dev_err(dpu_kms->dev->dev,
+			"%s%u: catalog id 0x%x exceeds 8-bit range\n",
+			is_dp ? "DP" : "DSI", intf_idx, id);
+		return U32_MAX;
+	}
+
+	return id;
+}
+
+static int dcp_dpu_kms_setup_bridges(struct dcp_dpu_kms *dpu_kms,
+				     struct device_node *dpu_np)
+{
+	struct drm_device *dev = dpu_kms->dev;
+	struct device_node *ep_np, *remote_np;
+	struct of_endpoint ep;
+	struct drm_encoder *encoder;
+	struct drm_bridge *bridge;
+	struct drm_connector *connector;
+	int ret = 0;
+	int dsi_idx = 0;
+
+	if (!dpu_np) {
+		dev_err(dev->dev, "no DCP function DT node\n");
+		return -ENODEV;
+	}
+
+	for_each_of_graph_port(dpu_np, port_np) {
+		u32 fw_display_id;
+		int enc_type;
+
+		ep_np = of_get_next_child(port_np, NULL);
+		if (!ep_np)
+			continue;
+
+		ret = of_graph_parse_endpoint(ep_np, &ep);
+		if (ret) {
+			of_node_put(ep_np);
+			continue;
+		}
+
+		remote_np = of_graph_get_remote_port_parent(ep_np);
+		of_node_put(ep_np);
+		if (!remote_np)
+			continue;
+
+		if (!of_device_is_available(remote_np)) {
+			of_node_put(remote_np);
+			continue;
+		}
+
+		if (of_node_name_prefix(remote_np, "dsi")) {
+			if (dsi_idx >= ARRAY_SIZE(dpu_kms->dsi_bridge)) {
+				dev_err(dev->dev, "too many DSI outputs\n");
+				ret = -E2BIG;
+				goto out;
+			}
+
+			enc_type  = DRM_MODE_ENCODER_DSI;
+			dev_dbg(dev->dev, "port@%u: DSI bridge intf_idx=%u\n",
+				ep.port, dsi_idx);
+			fw_display_id =
+				dcp_dpu_kms_resolve_fw_display_id(dpu_kms,
+								  false, dsi_idx);
+			if (fw_display_id == U32_MAX) {
+				ret = -EINVAL;
+				dev_err(dev->dev,
+					"port@%u: invalid DSI firmware display ID\n",
+					ep.port);
+				of_node_put(remote_np);
+				goto out;
+			}
+			bridge = dcp_dsi_bridge_init(dpu_kms, remote_np,
+						     dsi_idx, fw_display_id);
+			if (!IS_ERR(bridge) && dsi_idx < 2) {
+				dpu_kms->dsi_bridge[dsi_idx] =
+					to_dcp_dsi_bridge(bridge);
+				dsi_idx++;
+			}
+		} else {
+			of_node_put(remote_np);
+			continue;
+		}
+
+		of_node_put(remote_np);
+
+		if (IS_ERR(bridge)) {
+			ret = PTR_ERR(bridge);
+			dev_err(dev->dev, "bridge init failed: %d\n", ret);
+			goto out;
+		}
+
+		encoder = dcp_encoder_init(dev, enc_type);
+		if (IS_ERR(encoder)) {
+			ret = PTR_ERR(encoder);
+			dev_err(dev->dev, "encoder init failed: %d\n", ret);
+			goto out;
+		}
+
+		ret = drm_bridge_attach(encoder, bridge, NULL,
+					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
+		if (ret) {
+			if (ret == -EPROBE_DEFER) {
+				dev_dbg(dev->dev,
+					"port@%u bridge deferred; panel not ready\n", ep.port);
+				goto out;
+			}
+			dev_err(dev->dev, "bridge attach failed: %d\n", ret);
+			goto out;
+		}
+
+		connector = drm_bridge_connector_init(dev, encoder);
+		if (IS_ERR(connector)) {
+			ret = PTR_ERR(connector);
+			dev_err(dev->dev, "bridge connector init failed: %d\n", ret);
+			goto out;
+		}
+	}
+
+out:
+	if (ret)
+		dcp_dpu_kms_cleanup_bridges(dpu_kms);
+	return ret;
+}
+
+static int dcp_dpu_setup_pipeline(struct dcp_dpu_kms *dpu_kms,
+				  struct device_node *dpu_np)
+{
+	struct drm_device *dev = dpu_kms->dev;
+	struct drm_plane *primary_planes[DCP_DPU_MAX_CRTCS];
+	struct drm_plane *plane;
+	struct drm_crtc *crtc;
+	struct drm_encoder *encoder;
+	int primary_idx = 0;
+	int max_crtc_count;
+	int total_planes;
+	int i, ret;
+
+	ret = dcp_dpu_kms_setup_bridges(dpu_kms, dpu_np);
+	if (ret) {
+		dev_err(dev->dev, "bridge setup failed: %d\n", ret);
+		return ret;
+	}
+
+	max_crtc_count = 0;
+	drm_for_each_encoder(encoder, dev)
+		max_crtc_count++;
+
+	if (!dpu_kms->caps || !dpu_kms->caps->valid) {
+		dev_err(dev->dev, "firmware capabilities unavailable\n");
+		return -EINVAL;
+	}
+
+	max_crtc_count = min(max_crtc_count, DCP_DPU_MAX_CRTCS);
+	max_crtc_count = min_t(int, max_crtc_count,
+			       dpu_kms->caps->num_crtcs);
+
+	total_planes = min_t(int, dpu_kms->caps->max_planes,
+			     DCP_DPU_MAX_CRTCS * DCP_DPU_MAX_PLANES);
+
+	for (i = 0; i < total_planes; i++) {
+		enum drm_plane_type type;
+		unsigned long possible_crtcs;
+
+		possible_crtcs = ((1UL << max_crtc_count) - 1)
+				 << dev->mode_config.num_crtc;
+
+		if (primary_idx < max_crtc_count)
+			type = DRM_PLANE_TYPE_PRIMARY;
+		else
+			type = DRM_PLANE_TYPE_OVERLAY;
+
+		plane = dcp_plane_init(dev, U32_MAX, type, possible_crtcs);
+		if (IS_ERR(plane)) {
+			ret = PTR_ERR(plane);
+			dev_err(dev->dev, "plane init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+
+		if (type == DRM_PLANE_TYPE_PRIMARY)
+			primary_planes[primary_idx++] = plane;
+	}
+
+	max_crtc_count = min(max_crtc_count, primary_idx);
+
+	for (i = 0; i < max_crtc_count; i++) {
+		crtc = dcp_crtc_init(dpu_kms, primary_planes[i],
+				     dev->mode_config.num_crtc);
+		if (IS_ERR(crtc)) {
+			ret = PTR_ERR(crtc);
+			dev_err(dev->dev, "CRTC init failed: %d\n", ret);
+			goto err_cleanup_bridges;
+		}
+	}
+
+	return 0;
+
+err_cleanup_bridges:
+	dcp_dpu_kms_cleanup_bridges(dpu_kms);
+	return ret;
+}
+
+int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dpu_kms)
+{
+	struct drm_device *dev = dpu_kms->dev;
+	struct device_node *dpus_np = dpu_kms->dpus_np;
+	struct drm_encoder *encoder;
+	int enc_idx = 0;
+	int ret;
+
+	if (!dpus_np) {
+		dev_err(dev->dev, "no DCP function node — cannot create DRM objects\n");
+		return -ENODEV;
+	}
+
+	ret = dcp_dpu_setup_pipeline(dpu_kms, dpus_np);
+	if (ret) {
+		dev_err(dev->dev, "pipeline setup failed: %d\n", ret);
+		return ret;
+	}
+
+	/* v1 - Encoders map one-to-one to CRTCs; cloning is unsupported. */
+	drm_for_each_encoder(encoder, dev) {
+		encoder->possible_crtcs = BIT(enc_idx);
+		encoder->possible_clones = 0;
+		enc_idx++;
+	}
+
+	dev_dbg(dev->dev,
+		"DCP KMS: DPU ready — %d CRTCs, %d planes, %d encoders\n",
+		 dev->mode_config.num_crtc,
+		 dev->mode_config.num_total_plane,
+		 dev->mode_config.num_encoder);
+
+	return 0;
+}
+
+int dcp_kms_init(struct drm_device *ddev)
+{
+	struct msm_drm_private *priv = ddev->dev_private;
+	struct dcp_dpu_kms *dpu_kms = to_dcp_dpu_kms(priv->kms);
+	struct dcp_drv *drv = dpu_kms->drv;
+
+	dpu_kms->dev = ddev;
+	if (drv)
+		drv->kms = dpu_kms;
+
+	if (drv) {
+		dpu_kms->pm_dev = &drv->dcp_subsystem_dev->dev;
+		if (!dpu_kms->hfi)
+			dpu_kms->hfi = drv->hfi;
+		if (!dpu_kms->dpus_np)
+			dpu_kms->dpus_np = drv->dcp_subsystem_node;
+		if (!dpu_kms->iommu_dev)
+			dpu_kms->iommu_dev = &drv->dcp_subsystem_dev->dev;
+	}
+
+	if (!dpu_kms->hfi)
+		return -ENODEV;
+
+	if (!dpu_kms->caps || !dpu_kms->caps->valid)
+		return -ENODEV;
+
+	return 0;
+}

-- 
2.43.0

