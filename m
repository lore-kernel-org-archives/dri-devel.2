Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85885CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E464E1120FE;
	Thu, 15 Oct 2026 07:39:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51FE711211D
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:17 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3wZEZ1889493
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tk8WsNbwxB4i5YSvC+PJ+0ReBj+xSlG70tZdp6hOAkE=; b=OO2uXBObxGe5EyBe
 wMvDd5J+1ZoGwT10aLwIPALxcXzmXUFwRdpGfJDFHYLLv7QcOjHINkc2kNHoRYwS
 yXWMVVbtgni5gWKLbYXqUft8byWNLmA2sM1aCXwoFXu43Rh1gLUKhXWgzDKxKvPU
 11g2cQzdNBNdKojJZ8yI2JV94nxho9Y8A9I9fepN3McTnKqWegiYnmtG28m7cnNT
 Xe0H5qIv7BqacCb9eQssJFE1/QJHNqYNjB/8xxjPLSrmYl9yG+6FjuVFXB25u8kq
 6nZYJHA/qo++08ncK98z3hdv5qV4CuFvNkVt72kQfhTOyMSSjQagoPlv3aXF35m2
 9YLLXA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqda0scx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfc52ddc55so18980745ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792049955; x=1792654755;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tk8WsNbwxB4i5YSvC+PJ+0ReBj+xSlG70tZdp6hOAkE=;
 b=kmmNFSSOcX3KBTEraYxRC3Mm8BBg/WnUfWAZEjvEdlxYlLiaLQOsoLBWF73JgXm0ny
 hYl75Q5VZCeY6oySkSSFquw3Ha9LpdCp5Ov3tK47WTYx2rnuEnYRcrREBN05vFvy1A3Z
 h2PxCf0uhmx3jDiqyDPPxUVTyKJNhpHSl0GyYRtbInRTkwwcTDQ6qTQn/hRfh0u8l7X3
 U/05vfXg6sZvAVKi5fUKaBgZtx3j3nyVrsETlU+9AQxCIQChB5GpE2WXbtpgJ8Y5ynAD
 ed4sgEEYhKyhaS2lmNZsPzbVpkTp8dHL1YwRKif9xi1hf5W45BolJQEE21nGi5nLAKK1
 R3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049955; x=1792654755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tk8WsNbwxB4i5YSvC+PJ+0ReBj+xSlG70tZdp6hOAkE=;
 b=mRV+9wbYYplgHsLENo6A0ebrv9EIA2EHwaj+xu9beEO/7aPWs6WBP++LlqKfijmnyG
 ZKoyRFbPfL70ZxfOB6N9ysiFdfSx8SY0EYZ/G2bjX9wALFFo/HGd9OYK0MtwA4ChNabb
 8PwxEZYRm8/8H7aoGGjW96xFam++nOmgQFBy05MfMy/+5zZgynEyYabwzYWMj7PkWUYI
 Ovo9kvoYqRMzPB8AdzhChqFOYSSgAtHPtPx/fBxg77PulQu7tenS2gKIZF3aJl7bBrsz
 M02JBEvHAMeGJLo0XfDXTLaq7grLON0pRk0C0VXAuRxmnqZYoiRiziN8vmf+6xhXPtzY
 aWzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPRxjE5UHsFHmEjZmpTopq0BnCjVVr7IDa8LuZ+vH01w/u9pD71tAhbuqmbaviSTj7X7f4af843qE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZ6nAg3x1Kux3Az9YugdYG27d3FPKShgGrwKLR/pkCqrjxMuyr
 5G79cWLl4x1WRmsZgShJuCv6FBcu2SxCzelJfatuWIO0+oyZ3K9PnPTbmvMQ8PUJWI4EY4vQGss
 IfdIl3GkmrTmBvI/FWW6K1VsuIyKaKHiR7TDoF8Zl0Q1VCME3EiFMI8DEhGAnmAdW4xCxTXeXWe
 veC+XQQA==
X-Gm-Gg: AYBFou1DP4sRxwvVXDsspHeQhsQyCkYpH4O0s8F3RtJIgmDacOHH4GOxP7Rfd58E3pg
 vMXIjVWHrILimjJVeB0tTnizuckPiSpp6h80gg5Tn2DdGoqBJLS8R4qAgXJEaTXjY/2cK+IVY7z
 nDcT3WK0lpYwS7QfxIZt1c1pb8QWmri3e6topQP2T2taRc3wENOvaUqAC8LnpbH0xHy1N+wG4dp
 z6PUgFq6EXljZ3pN9hIReFjmWMbIpV+R/4BZHNM8r9J8DcfPXPsMdTO0RVuLXbsnEaJXdGBSY6R
 lSMmpmd9fU1PLlGII54bZPjo3saGPlVvYodqSLkSWbaEaxYe5rj+E7GFJWUy5rDEYrwvzj9eEJj
 8krOnfcgNgfzmqVQRIqRHiRgmq+OnN/c2FTw=
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id
 d9443c01a7336-2e92a1a8ba7mr57384075ad.55.1792049953408; 
 Thu, 15 Oct 2026 00:39:13 -0700 (PDT)
X-Received: by 2002:a17:903:110e:b0:2e9:2a1a:8b69 with SMTP id
 d9443c01a7336-2e92a1a8ba7mr57383685ad.55.1792049952024; 
 Thu, 15 Oct 2026 00:39:12 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:39:11 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:22 +0530
Subject: [PATCH 02/13] drm/msm/dcp: Add HFI protocol definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-2-48aad0fe4f72@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=111551;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=LKRfQm2lqh7nV0bUBZzQGdPFQewD4epRqML3MIqhP78=;
 b=sOXZOZQvItX55hIY9sHjodPdF2XZnkx2obE71y9f3JU+29DZweRdR8nNKGL5RPdNsaGEn0jL2
 7x4ffALdVfuBjH8Dl32rkbAm+xs71xBFzP/9xpcHpCmK76VE8qYZroo
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX04nFDGTMn0Wq
 JwqUcnHKzyVoUqmMjRNZd0CHAoxWAamg4YTmr/Q9lwmu6LESHphEZAXHe42h9DCupIMsDB5mULE
 zK1zWDZgYX6aLszVj2NvOFZaFvQ5fpk=
X-Authority-Analysis: v=2.4 cv=K9u3jCWI c=1 sm=1 tr=0 ts=6ad08324 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=q1IBRVifF20qqtz0tQQA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ehnK5GyRlSGBKJkJbN_aQv0sUp5nR6JQ
X-Proofpoint-ORIG-GUID: ehnK5GyRlSGBKJkJbN_aQv0sUp5nR6JQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX3anlgSPD7HHE
 EYJAWWi7WGN8hBfE+E2yIBVEWcE/bF85ZinyqqUejc3iGl768YN1StBtaZZHeQ/e8zc42Q8pZij
 3PlYfS2Y6/wxChCB0TOW478KHtfO1+zlHGvKpLtcHgKfAwu0xvadeDStNfAx+cgb7GsfljEUpjU
 wJ1Ucd/s1D9r3BzfJcyeM1qgT94fYEUIeYbaW77yImOoGrJml6ESEQtQiQ3T8fud9NcDsA8Fq5J
 yX7uZ2AvMBq31mzePQM/Y8wUebRbzU6PvORl4tCxlDJ1LzGWufoVV1OgpoLwhRx8MbkDZdl/9L6
 gpYCt8oaLSCjUlkqYGW9kzf+7IYiDXaOXSJEUj4fm4ULKNINASEh4J9GhQRjsAJYf7i5kOtGfeu
 FP40rwRCVCjtfZt1w9HnXfbQVDflY4hGZ8heWZhTpEB16aCfpzMGqH9VvvbHQD/c7OniNFLlPmp
 E7yatf+GNCR3W/WnSgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
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

DCP firmware owns the display hardware and communicates with Linux through
the HFI protocol. The driver needs a single definition of the packet and
property formats shared by transport, capability, modeset, and event code.

Add the HFI packet formats, commands, properties, response structures, and
common pack, unpack, and utility helpers used by the DCP driver.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 drivers/gpu/drm/msm/Kconfig                        |  25 ++
 drivers/gpu/drm/msm/Makefile                       |   6 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h  |  78 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h | 105 +++++
 .../drm/msm/dcp/hfi/hfi_commands_display_events.h  |  90 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h   |  27 ++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h      | 182 ++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h      |  61 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h     | 464 ++++++++++++++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h   | 247 +++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h       | 287 ++++++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h   |  79 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c           | 106 +++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h           |  65 +++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h           |  76 ++++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_device.h    | 102 +++++
 .../gpu/drm/msm/dcp/hfi/hfi_properties_display.h   | 480 +++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h | 198 +++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c         | 157 +++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h         |  77 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c            |  79 ++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h            |  56 +++
 22 files changed, 3047 insertions(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index ed1c4775d1e9..a9f049271c25 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -114,6 +114,31 @@ config DRM_MSM_DPU
 	  the MSM DRM driver. It is the display controller found in devices
 	  using e.g. SDM845 and newer platforms.
 
+config DRM_MSM_DCP
+	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
+	depends on DRM_MSM
+	depends on VIRTIO
+	select DRM_MSM_KMS
+	select DRM_BRIDGE_CONNECTOR
+	select DRM_MIPI_DSI
+	select DRM_DISPLAY_DSC_HELPER
+	default y
+	help
+	  Compile in support for the DCP (Display Coprocessor) firmware-delegated
+	  display architecture in the MSM DRM driver.
+
+	  DCP is used on Hawi (qcom,hawi) SoC where all display hardware is
+	  owned by a separate Display Coprocessor firmware. The host AP
+	  communicates with DCP via two interfaces:
+	    - IPCC SMP2P mailbox: one-shot wake signal before each HFI command
+	    - HFI over VirtIO MMIO: all display command/response exchange
+
+	  DPU and bridge nodes in the Device Tree are topology-only (no
+	  compatible string, no reg). The driver detects them by node name
+	  prefix using of_node_name_prefix().
+
+	  If unsure, say N.
+
 config DRM_MSM_DP
 	bool "Enable DisplayPort support in MSM DRM driver"
 	depends on DRM_MSM
diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 0b8f2cafed19..00c995dde21a 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -I $(obj)/generated
 ccflags-y += -I $(src)/disp/dpu1
 ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(src)/dsi
 ccflags-$(CONFIG_DRM_MSM_DP) += -I $(src)/dp
+ccflags-$(CONFIG_DRM_MSM_DCP) += -I $(src)/dcp
 
 adreno-y := \
 	adreno/adreno_device.o \
@@ -68,6 +69,11 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 	disp/mdp5/mdp5_plane.o \
 	disp/mdp5/mdp5_smp.o \
 
+msm-display-$(CONFIG_DRM_MSM_DCP) += \
+	dcp/hfi/hfi_packer.o \
+	dcp/hfi/hfi_unpacker.o \
+	dcp/hfi/hfi_utils.o
+
 msm-display-$(CONFIG_DRM_MSM_DPU) += \
 	disp/dpu1/dpu_core_perf.o \
 	disp/dpu1/dpu_crtc.o \
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h
new file mode 100644
index 000000000000..abf15e6ceaec
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_device.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_DEVICE_H__
+#define __H_HFI_COMMANDS_DEVICE_H__
+
+/* Device-level command range. */
+#define HFI_COMMAND_DEVICE_BEGIN                                     0x01000000
+
+/* Initialize the device and return firmware capabilities. */
+#define HFI_COMMAND_DEVICE_INIT                                      0x01000001
+
+/* Device, display, and pipeline capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DEVICE_CAPS                          0x01000002
+
+/* VIG pipeline capability response. */
+#define HFI_COMMAND_DEVICE_INIT_VIG_CAPS                             0x01000003
+
+/* DMA pipeline capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DMA_CAPS                             0x01000004
+
+/* Common VIG/DMA capability response. */
+#define HFI_COMMAND_DEVICE_INIT_COMMON_LAYER_CAPS                    0x01000005
+
+/* Display capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DISPLAY_CAPS                         0x01000006
+
+/* Writeback capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DISPLAY_WB_CAPS                      0x01000007
+
+/* Register clocks and bandwidth resources with firmware. */
+#define HFI_COMMAND_DEVICE_RESOURCE_REGISTER                         0x01000008
+
+/* Firmware requests a resource vote from the host. */
+#define HFI_COMMAND_DEVICE_CALLBACK_RESOURCE_VOTE                    0x01000009
+
+/* VIG rect-1 capability response. */
+#define HFI_COMMAND_DEVICE_INIT_VIG_R1_CAPS                          0x0100000a
+
+/* DMA rect-1 capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DMA_R1_CAPS                          0x0100000b
+
+/* Provide the last-command buffer to firmware. */
+#define HFI_COMMAND_DEVICE_LUT_DMA_LAST_CMD                          0x0100000c
+
+/* Deinitialize the device. */
+#define HFI_COMMAND_DEVICE_DEINIT                                    0x0100000d
+
+/* LSR writeback CSC layer capability response. */
+#define HFI_COMMAND_DEVICE_INIT_LSR_WB_CSC_LAYER_CAPS                0x0100000e
+
+/* LSR writeback reprojection layer capability response. */
+#define HFI_COMMAND_DEVICE_INIT_LSR_WB_REPROJ_LAYER_CAPS             0x0100000f
+
+/* LSR writeback CSC output capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DISPLAY_LSR_WB_CSC_CAPS              0x01000010
+
+/* LSR writeback reprojection output capability response. */
+#define HFI_COMMAND_DEVICE_INIT_DISPLAY_LSR_WB_REPROJ_CAPS           0x01000011
+
+/* Configure the hardware-fence HFI queue. */
+#define HFI_COMMAND_DEVICE_HWFENCE_HFI_CONFIG                        0x01000012
+
+/* Update hotplug state and provide EDID/mode buffers. */
+#define HFI_COMMAND_DEVICE_HOT_PLUG_DETECT                           0x01000013
+
+/* Configure resources shared across virtual machines. */
+#define HFI_COMMAND_DEVICE_RESOURCE_CTRL                             0x01000014
+
+/* Notify firmware of a subsystem restart. */
+#define HFI_COMMAND_DEVICE_SUBSYSTEM_RESTART_NOTIFY                  0x01000015
+
+/* End of device-level command range. */
+#define HFI_COMMAND_DEVICE_END                                       0x01ffffff
+
+#endif /* __H_HFI_COMMANDS_DEVICE_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h
new file mode 100644
index 000000000000..5f24b45e67b1
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_DISPLAY_H__
+#define __H_HFI_COMMANDS_DISPLAY_H__
+
+/* Display-command range. */
+#define HFI_COMMAND_DISPLAY_BEGIN                                     0x02000000
+
+/* Set display properties. */
+#define HFI_COMMAND_DISPLAY_SET_PROPERTY                              0x02000001
+
+/* Read display or layer properties. */
+#define HFI_COMMAND_DISPLAY_GET_PROPERTY                              0x02000002
+
+/* Commit previously submitted display state. */
+#define HFI_COMMAND_DISPLAY_FRAME_TRIGGER                             0x02000003
+
+/* Register a display event. */
+#define HFI_COMMAND_DISPLAY_EVENT_REGISTER                            0x02000004
+
+/* Unregister a display event. */
+#define HFI_COMMAND_DISPLAY_EVENT_DEREGISTER                          0x02000005
+
+/* Enable the display session. */
+#define HFI_COMMAND_DISPLAY_ENABLE                                    0x02000006
+
+/* Send post-enable panel commands. */
+#define HFI_COMMAND_DISPLAY_POST_ENABLE                               0x02000007
+
+/* Disable the display stream. */
+#define HFI_COMMAND_DISPLAY_DISABLE                                   0x02000008
+
+/* Release post-disable display resources. */
+#define HFI_COMMAND_DISPLAY_POST_DISABLE                              0x02000009
+
+/* Set a previously validated display mode. */
+#define HFI_COMMAND_DISPLAY_SET_MODE                                  0x0200000a
+
+/* Validate a display mode in firmware. */
+#define HFI_COMMAND_DISPLAY_MODE_VALIDATE                             0x0200000b
+
+/* Request host-side display power control. */
+#define HFI_COMMAND_DISPLAY_POWER_CONTROL                             0x0200000c
+
+/* Register display power-control handling. */
+#define HFI_COMMAND_DISPLAY_POWER_REGISTER                            0x0200000d
+
+/* Transfer one DCS command. */
+#define HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD                          0x0200000e
+
+/* Transfer a DCS command set. */
+#define HFI_COMMAND_DISPLAY_TRANSFER_DCS_CMD_SET                      0x0200001d
+
+/* Configure the display idle timer. */
+#define HFI_COMMAND_DISPLAY_IDLE_TIMER_CONTROL                        0x0200000f
+
+/* Configure DisplayPort transfer units. */
+#define HFI_COMMAND_DISPLAY_SET_DP_TU                                 0x02000010
+
+/* Configure HDR display properties. */
+#define HFI_COMMAND_DISPLAY_CONFIG_HDR                                0x02000011
+
+/* Configure display audio. */
+#define HFI_COMMAND_DISPLAY_AUDIO_CONFIG                              0x02000012
+
+/* Control display audio. */
+#define HFI_COMMAND_DISPLAY_AUDIO_CONTROL                             0x02000013
+
+/* Set the display color space. */
+#define HFI_COMMAND_DISPLAY_SET_COLORSPACE                            0x02000014
+
+/* Provide the HDCP 1.x AKSV. */
+#define HFI_COMMAND_DISPLAY_HDCP1X_AKSV                               0x02000015
+
+/* Provide an HDCP 2.x response. */
+#define HFI_COMMAND_DISPLAY_HDCP2X_RESPONSE                           0x02000016
+
+/* Report sink HDCP capabilities. */
+#define HFI_COMMAND_DISPLAY_HDCP_FEATURE_SUPPORTED                    0x02000017
+
+/* Configure DSI DCS command remapping. */
+#define HFI_COMMAND_DISPLAY_DSI_CUSTOM_DCS_CMDS_SET_REMAP             0x02000018
+
+/* Configure DSI DCS command replacement. */
+#define HFI_COMMAND_DISPLAY_DSI_CUSTOM_DCS_CMDS_SET_REPLACE           0x02000019
+
+/* Configure display batch mode. */
+#define HFI_COMMAND_DISPLAY_BATCH_MODE                                0x0200001a
+
+/* Configure the display HFI subsystem. */
+#define HFI_COMMAND_DISPLAY_HFI_SUBSYSTEM_CONFIG                      0x0200001b
+
+/* Execute a DCS low-power command type. */
+#define HFI_COMMAND_DISPLAY_EXEC_DCS_CMD_TYPE                         0x0200001c
+
+/* End of display-command range. */
+#define HFI_COMMAND_DISPLAY_END                                       0x02ffffff
+
+/* Alias for the display-command range end. */
+#define HFI_COMMAND_DISPLAY_CLOSE                                     HFI_COMMAND_DISPLAY_END
+
+#endif /* __H_HFI_COMMANDS_DISPLAY_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h
new file mode 100644
index 000000000000..48d9c936b672
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_display_events.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_DISPLAY_EVENTS_H
+#define __H_HFI_COMMANDS_DISPLAY_EVENTS_H
+
+/* Display-event command range. */
+#define HFI_COMMAND_DISPLAY_EVENT_BEGIN                                         0x04000000
+
+/* Report vertical sync and its index. */
+#define HFI_COMMAND_DISPLAY_EVENT_VSYNC                                         0x04000001
+
+/* Report frame-scan start and sequence ID. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_START                              0x04000002
+
+/* Report frame-scan completion. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_SCAN_COMPLETE                           0x04000003
+
+/* Report display idle state. */
+#define HFI_COMMAND_DISPLAY_EVENT_IDLE                                          0x04000004
+
+/* Report display power-state changes. */
+#define HFI_COMMAND_DISPLAY_EVENT_POWER                                         0x04000005
+
+/* Report display hardware recovery. */
+#define HFI_COMMAND_DISPLAY_EVENT_HW_RECOVERY                                   0x04000006
+
+/* Report frame-capture completion. */
+#define HFI_COMMAND_DISPLAY_EVENT_FRAME_CAPTURE_COMPLETE                        0x04000007
+
+/* Report an unrecoverable panel failure. */
+#define HFI_COMMAND_DISPLAY_EVENT_PANEL_DEAD                                    0x04000008
+
+/* Report LTM statistics events. */
+#define HFI_COMMAND_DISPLAY_EVENT_LTM                                           0x04000009
+
+/* Report RGB histogram events. */
+#define HFI_COMMAND_DISPLAY_EVENT_RGB_HIST                                      0x0400000a
+
+/* Report PA histogram events. */
+#define HFI_COMMAND_DISPLAY_EVENT_PA_HIST                                       0x0400000b
+
+/* Report hotplug status. */
+#define HFI_COMMAND_DISPLAY_EVENT_HPD_STATUS                                    0x0400000c
+
+/* Report EDID and supported modes. */
+#define HFI_COMMAND_DISPLAY_EVENT_EDID_INFO                                     0x0400000d
+
+/* Report SPR/OPR values at frame scan. */
+#define HFI_COMMAND_DISPLAY_EVENT_SPR_OPR                                       0x0400000e
+
+/* Report interface MISR values at frame scan. */
+#define HFI_COMMAND_DISPLAY_EVENT_INTERFACE_MISR                                0x0400000f
+
+/* Request HDCP 1.x authentication start. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_START                                  0x04000010
+
+/* Request HDCP 1.x authentication stop. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_STOP                                   0x04000011
+
+/* Update HDCP 1.x encryption state. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_ENC                                    0x04000012
+
+/* Update HDCP 1.x repeater topology. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP1X_TOPOLOGY_UPDATE                        0x04000013
+
+/* Start the HDCP 2.x sequence. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_START                                  0x04000014
+
+/* Process an HDCP 2.x message. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_PROCESS_MSG                            0x04000015
+
+/* Report an HDCP 2.x message timeout. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP2X_TIMEOUT                                0x04000016
+
+/* Report sink HDCP capabilities. */
+#define HFI_COMMAND_DISPLAY_EVENT_HDCP_FEATURE_SUPPORTED                        0x04000017
+
+/* Report COPR status data. */
+#define HFI_COMMAND_DISPLAY_EVENT_AIQE_COPR_READ                                0x04000018
+
+/* Report programmable-line events. */
+#define HFI_COMMAND_DISPLAY_EVENT_PROG_LINE                                     0x04000019
+
+/* End of display-event command range. */
+#define HFI_COMMAND_DISPLAY_EVENT_END                                           0x04ffffff
+
+#endif /* __H_HFI_COMMANDS_DISPLAY_EVENTS_H */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h
new file mode 100644
index 000000000000..ceccc8da8a29
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_commands_panel.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_COMMANDS_PANEL_H__
+#define __H_HFI_COMMANDS_PANEL_H__
+
+/* Panel-command range. */
+#define HFI_COMMAND_PANEL_BEGIN                                         0x03000000
+
+/* Start panel initialization; send with timing and generic packets in one HFI header. */
+#define HFI_COMMAND_PANEL_INIT_PANEL_CAPS                            0x03000001
+
+/* Provide one panel timing-mode description. */
+#define HFI_COMMAND_PANEL_INIT_TIMING_MODE_CAPS                      0x03000002
+
+/* Provide non-timing panel properties. */
+#define HFI_COMMAND_PANEL_INIT_GENERIC_CAPS                          0x03000003
+
+/* Deinitialize panel attributes. */
+#define HFI_COMMAND_PANEL_DEINIT                                     0x03000004
+
+/* End of panel-command range. */
+#define HFI_COMMAND_PANEL_END                                        0x03ffffff
+
+#endif /* __H_HFI_COMMANDS_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h
new file mode 100644
index 000000000000..8e58a50f600c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h
@@ -0,0 +1,182 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_COMMON_H__
+#define __H_HFI_DEFS_COMMON_H__
+
+#include <linux/bits.h>
+
+/* Boolean property values. */
+#define HFI_FALSE		0
+#define HFI_TRUE		1
+
+#define HFI_MAX_PLANES  4 /* Maximum number of planes supported */
+
+#define HFI_MAX_COLOR_COMPONENTS  3 /* Maximum number of color components supported */
+#define HFI_DHDR_PAYLOAD_MAX_SIZE 32 /* Maximum dynamic HDR payload size */
+
+/* Color-format class is encoded in bits 31:24. */
+enum hfi_color_formats {
+	/* Interleaved RGB */
+	HFI_COLOR_FORMAT_INTERLEAVED_RGB_MIN        = 0x01000000,
+	HFI_COLOR_FORMAT_RGB565                     = 0x01000001,
+	HFI_COLOR_FORMAT_RGB888                     = 0x01000002,
+	HFI_COLOR_FORMAT_ARGB8888                   = 0x01000003,
+	HFI_COLOR_FORMAT_RGBA8888                   = 0x01000004,
+	HFI_COLOR_FORMAT_XRGB8888                   = 0x01000005,
+	HFI_COLOR_FORMAT_RGBX8888                   = 0x01000006,
+	HFI_COLOR_FORMAT_ARGB1555                   = 0x01000007,
+	HFI_COLOR_FORMAT_RGBA5551                   = 0x01000008,
+	HFI_COLOR_FORMAT_XRGB1555                   = 0x01000009,
+	HFI_COLOR_FORMAT_RGBX5551                   = 0x0100000a,
+	HFI_COLOR_FORMAT_ARGB4444                   = 0x0100000b,
+	HFI_COLOR_FORMAT_RGBA4444                   = 0x0100000c,
+	HFI_COLOR_FORMAT_RGBX4444                   = 0x0100000d,
+	HFI_COLOR_FORMAT_XRGB4444                   = 0x0100000e,
+	HFI_COLOR_FORMAT_ARGB2_10_10_10             = 0x0100000f,
+	HFI_COLOR_FORMAT_XRGB2_10_10_10             = 0x01000010,
+	HFI_COLOR_FORMAT_RGBA10_10_10_2             = 0x01000011,
+	HFI_COLOR_FORMAT_RGBX10_10_10_2             = 0x01000012,
+	HFI_COLOR_FORMAT_ARGB_FP_16                 = 0x01000013,
+	HFI_COLOR_FORMAT_RGBA_FP_16                 = 0x01000014,
+	HFI_COLOR_FORMAT_RGBA8888_TILED             = 0x01000015,
+	HFI_COLOR_FORMAT_RGBX8888_TILED             = 0x01000016,
+	HFI_COLOR_FORMAT_RGBA10_10_10_2_TILED       = 0x01000017,
+	HFI_COLOR_FORMAT_RGBX10_10_10_2_TILED       = 0x01000018,
+	HFI_COLOR_FORMAT_RGB888_BYPASS              = 0x01000019,
+	HFI_COLOR_FORMAT_INTERLEAVED_RGB_MAX        = 0x01ffffff,
+	/* Interleaved BGR */
+	HFI_COLOR_FORMAT_INTERLEAVED_BGR_MIN        = 0x02000000,
+	HFI_COLOR_FORMAT_BGR565                     = 0x02000001,
+	HFI_COLOR_FORMAT_BGR888                     = 0x02000002,
+	HFI_COLOR_FORMAT_ABGR8888                   = 0x02000003,
+	HFI_COLOR_FORMAT_BGRA8888                   = 0x02000004,
+	HFI_COLOR_FORMAT_BGRX8888                   = 0x02000005,
+	HFI_COLOR_FORMAT_XBGR8888                   = 0x02000006,
+	HFI_COLOR_FORMAT_ABGR1555                   = 0x02000007,
+	HFI_COLOR_FORMAT_BGRA5551                   = 0x02000008,
+	HFI_COLOR_FORMAT_XBGR1555                   = 0x02000009,
+	HFI_COLOR_FORMAT_BGRX5551                   = 0x0200000a,
+	HFI_COLOR_FORMAT_ABGR4444                   = 0x0200000b,
+	HFI_COLOR_FORMAT_BGRA4444                   = 0x0200000c,
+	HFI_COLOR_FORMAT_BGRX4444                   = 0x0200000d,
+	HFI_COLOR_FORMAT_XBGR4444                   = 0x0200000e,
+	HFI_COLOR_FORMAT_ABGR2_10_10_10             = 0x0200000f,
+	HFI_COLOR_FORMAT_XBGR2_10_10_10             = 0x02000010,
+	HFI_COLOR_FORMAT_BGRA10_10_10_2             = 0x02000011,
+	HFI_COLOR_FORMAT_BGRX10_10_10_2             = 0x02000012,
+	HFI_COLOR_FORMAT_ABGR16_FP_16               = 0x02000013,
+	HFI_COLOR_FORMAT_BGRA16_FP_16               = 0x02000014,
+	HFI_COLOR_FORMAT_INTERLEAVED_BGR_MAX        = 0x02ffffff,
+	/* Compressed RGBA UBWC 3.0/ 4.x / 5.0 Lossless */
+	HFI_COLOR_FORMAT_RGBA_UBWC_LOSSLESS_MIN     = 0x03000000,
+	HFI_COLOR_FORMAT_UBWC_RGBA8888              = 0x03000001,
+	HFI_COLOR_FORMAT_UBWC_RGBA10_10_10_2        = 0x03000002,
+	HFI_COLOR_FORMAT_UBWC_RGBA16_16_16_16_F     = 0x03000003,
+	HFI_COLOR_FORMAT_UBWC_RGB565                = 0x03000004,
+	HFI_COLOR_FORMAT_UBWC_RGBX8888              = 0x03000005,
+	HFI_COLOR_FORMAT_UBWC_RGBX10_10_10_2        = 0x03000006,
+	HFI_COLOR_FORMAT_RGBA_UBWC_LOSSLESS_MAX     = 0x03ffffff,
+	/* Compressed RGBA UBWC 5.0 Lossy */
+	HFI_COLOR_FORMAT_RGBA_UBWC_LOSSY_MIN        = 0x04000000,
+	HFI_COLOR_FORMAT_UBWC_RGBA8888_L_8_5        = 0x04000001,
+	HFI_COLOR_FORMAT_UBWC_RGBA8888_L_2_1        = 0x04000002,
+	HFI_COLOR_FORMAT_RGBA_UBWC_LOSSY_MAX        = 0x04ffffff,
+	/* Linear / Uncompressed YUV420 / FSC */
+	HFI_COLOR_FORMAT_LINEAR_MIN                 = 0x05000000,
+	HFI_COLOR_FORMAT_YU12                       = 0x05000001,
+	HFI_COLOR_FORMAT_YV12                       = 0x05000002,
+	HFI_COLOR_FORMAT_NV12                       = 0x05000003,
+	HFI_COLOR_FORMAT_NV21                       = 0x05000004,
+	HFI_COLOR_FORMAT_P010                       = 0x05000005,
+	HFI_COLOR_FORMAT_YUYV                       = 0x05000006,
+	HFI_COLOR_FORMAT_YVYU                       = 0x05000007,
+	HFI_COLOR_FORMAT_UYVY                       = 0x05000008,
+	HFI_COLOR_FORMAT_VYUY                       = 0x05000009,
+	HFI_COLOR_FORMAT_FSC_R                      = 0x0500000a,
+	HFI_COLOR_FORMAT_FSC_G                      = 0x0500000b,
+	HFI_COLOR_FORMAT_FSC_B                      = 0x0500000c,
+	HFI_COLOR_FORMAT_FSC_ALPHA                  = 0x0500000d,
+	HFI_COLOR_FORMAT_P210                       = 0x0500000e,
+	HFI_COLOR_FORMAT_Y10                        = 0x0500000f,
+	HFI_COLOR_FORMAT_A10                        = 0x05000010,
+	HFI_COLOR_FORMAT_Y10_MSB_ALIGN              = 0x05000011,
+	HFI_COLOR_FORMAT_A10_MSB_ALIGN              = 0x05000012,
+	HFI_COLOR_FORMAT_Y8                         = 0x05000013,
+	HFI_COLOR_FORMAT_LINEAR_MAX                 = 0x05ffffff,
+	/* Compressed UBWC 3.0 / 4.x / 5.0 Lossless / FSC */
+	HFI_COLOR_FORMAT_UBWC_LOSSLESS_MIN          = 0x06000000,
+	HFI_COLOR_FORMAT_UBWC_NV12                  = 0x06000001,
+	HFI_COLOR_FORMAT_UBWC_NV12_INTERLACE        = 0x06000002,
+	HFI_COLOR_FORMAT_UBWC_TP10                  = 0x06000003,
+	HFI_COLOR_FORMAT_UBWC_P010                  = 0x06000004,
+	HFI_COLOR_FORMAT_UBWC_FSC_R                 = 0x06000005,
+	HFI_COLOR_FORMAT_UBWC_FSC_G                 = 0x06000006,
+	HFI_COLOR_FORMAT_UBWC_FSC_B                 = 0x06000007,
+	HFI_COLOR_FORMAT_UBWC_FSC_ALPHA             = 0x06000008,
+	HFI_COLOR_FORMAT_UBWC_FSC_R_4R              = 0x06000009,
+	HFI_COLOR_FORMAT_UBWC_FSC_G_4R              = 0x0600000a,
+	HFI_COLOR_FORMAT_UBWC_FSC_B_4R              = 0x0600000b,
+	HFI_COLOR_FORMAT_UBWC_FSC_ALPHA_4R          = 0x0600000c,
+	HFI_COLOR_FORMAT_UBWC_ABGR_NV12_4R_4Y       = 0x0600000d,
+	HFI_COLOR_FORMAT_UBWC_P210                  = 0x0600000e,
+	HFI_COLOR_FORMAT_UBWC_Y10                   = 0x0600000f,
+	HFI_COLOR_FORMAT_UBWC_A10                   = 0x06000010,
+
+	HFI_COLOR_FORMAT_UBWC_LOSSLESS_MAX          = 0x06ffffff,
+	/* Compressed UBWC 3.0 / 4.x / 5.0 Lossy */
+	HFI_COLOR_FORMAT_UBWC_LOSSY_MIN             = 0x07000000,
+	HFI_COLOR_FORMAT_UBWC_NV12_LOSSY            = 0x07000001,
+	HFI_COLOR_FORMAT_UBWC_TP10_LOSSY            = 0x07000002,
+	HFI_COLOR_FORMAT_UBWC_LOSSY_MAX             = 0x07ffffff,
+};
+
+/* Shared HFI buffer descriptor. */
+struct hfi_buff {
+	u32 addr_l;
+	u32 addr_h;
+	u32 size;
+	u32 version;
+	u32 flags;
+};
+
+/* Multi-plane HFI buffer descriptor. */
+struct hfi_plane_buff {
+	u32 addr_l[HFI_MAX_PLANES];
+	u32 addr_h[HFI_MAX_PLANES];
+	u32 size;
+	u32 version;
+	u32 flags;
+	u32 format;
+};
+
+/* 64-bit HFI property value. */
+struct hfi_prop_u64 {
+	u32 val_lo;
+	u32 val_hi;
+};
+
+#define HFI_BUFF_FEATURE_ENABLE         BIT(0)
+#define HFI_BUFF_FEATURE_BROADCAST      BIT(1)
+#define HFI_BUFF_FEATURE_HW_BLK_IDX_0   BIT(2)
+#define HFI_BUFF_FEATURE_HW_BLK_IDX_1   BIT(3)
+#define HFI_BUFF_FEATURE_HW_BLK_IDX_2   BIT(4)
+#define HFI_BUFF_FEATURE_HW_BLK_IDX_3   BIT(5)
+#define HFI_BUFF_3D_LUT_MODE_A          BIT(16)
+#define HFI_BUFF_3D_LUT_MODE_B          BIT(17)
+/* Buffer descriptor visible to the DPU. */
+struct hfi_buff_dpu {
+	u32 flags;
+	u32 iova;
+	u32 len;
+};
+
+/* HFI subsystem identifiers. */
+enum hfi_subsystem_type {
+	HFI_SUBSYSTEM_TYPE_LSR = 0,
+	HFI_SUBSYSTEM_TYPE_GMU = 1
+};
+
+#endif /* __H_HFI_DEFS_COMMON_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h
new file mode 100644
index 000000000000..c6c8fb556c3e
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_device.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_DEVICE_H__
+#define __H_HFI_DEFS_DEVICE_H__
+
+#include "hfi_defs_common.h"
+
+/* Hotplug state for dynamic display interfaces. */
+struct hfi_device_hotplug_config {
+	u32 orientation;
+	u32 port_index;
+	u32 pin_config;
+	u32 hpd_state;
+	u32 hpd_irq;
+};
+
+/* Display resource ownership state. */
+enum hfi_device_res_state {
+	HFI_DEVICE_RESOURCE_ACQUIRE = 0x0,
+	HFI_DEVICE_RESOURCE_RELEASE = 0x1,
+	HFI_DEVICE_RESOURCE_SHARED  = 0x2,
+	HFI_DEVICE_RESOURCE_PRE_RELEASE = 0x3,
+};
+
+/* Virtualized display-resource types. */
+enum hfi_device_resource_type {
+	HFI_DEVICE_RESOURCE_DISPLAY,
+};
+
+/* Virtualized display-resource configuration. */
+struct hfi_device_resource_config {
+	u32 disp_mask;
+	enum hfi_device_res_state vm_state;
+	u32 resource_type;
+	u32 reserved[2];
+};
+
+/* Subsystem-restart event. */
+enum hfi_device_ssr_event {
+	HFI_DEVICE_SSR_EVENT_START  = 0,
+	HFI_DEVICE_SSR_EVENT_END  = 1,
+};
+
+/* Subsystem-restart information. */
+struct hfi_device_ssr_info {
+	enum hfi_subsystem_type subsystem_type;
+	enum hfi_device_ssr_event ssr_event;
+	u32 reserved1;
+	u32 reserved2;
+};
+
+/* Active layer mask for a display. */
+struct hfi_device_active_layers_info {
+	u32 display_id;
+	u32 layers_mask;
+};
+
+#endif /* __H_HFI_DEFS_DEVICE_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h
new file mode 100644
index 000000000000..c01a001409ce
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display.h
@@ -0,0 +1,464 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_DISPLAY_H__
+#define __H_HFI_DEFS_DISPLAY_H__
+
+#include "hfi_defs_common.h"
+
+/* Display blending and power controls. */
+enum hfi_display_blend_ops {
+	HFI_BLEND_OP_NOT_DEFINED        = 0x0,
+	HFI_BLEND_OP_OPAQUE             = 0x1,
+	HFI_BLEND_OP_PREMULTIPLIED      = 0x2,
+	HFI_BLEND_OP_COVERAGE           = 0x3,
+	HFI_BLEND_OP_SKIP               = 0x4,
+	HFI_BLEND_OP_MAX                = 0x5,
+};
+
+enum hfi_display_power_mode {
+	HFI_MODE_DPMS_INVALID   = 0,
+	HFI_MODE_DPMS_OFF       = 0x1,
+	HFI_MODE_DPMS_ON        = 0x2,
+	HFI_MODE_DPMS_LP1       = 0x3,
+	HFI_MODE_DPMS_LP2       = 0x4,
+	HFI_MODE_DPMS_NOLP      = 0x5,
+};
+
+enum hfi_display_power_control {
+	HFI_PANEL_POWER      = 0x1,
+	HFI_CTRL_POWER       = 0x2,
+	HFI_PHY_POWER        = 0x4,
+};
+
+enum hfi_display_commit_flag {
+	HFI_VALIDATE           = 0x1,
+	HFI_COMMIT             = 0x2,
+};
+
+enum hfi_display_res_type {
+	HFI_RESOURCE_LM = 0x1,
+};
+
+/* Firmware resource configuration. */
+struct hfi_resource_cfg {
+	u32 res_type;
+	u32 resource_idx;
+	u32 width;
+	u32 height;
+	u32 reserved;
+};
+
+/* Display region of interest. */
+struct hfi_display_roi {
+	u32 x_pos;
+	u32 y_pos;
+	u32 width;
+	u32 height;
+};
+
+enum hfi_display_roi_type {
+	PANEL_ROI = 0x0,
+};
+
+/* VSync event payload. */
+struct hfi_display_vsync_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 vsync_index;
+};
+
+/* Frame-scan event payload. */
+struct hfi_display_frame_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 bufferflip_index;
+};
+
+struct hfi_display_color {
+	u16 color_0;
+	u16 color_1;
+	u16 color_2;
+	u16 color_3;
+};
+
+enum hfi_display_dim_layer_flag {
+	HFI_DIM_LAYER_INCLUSIVE = 0x1,
+	HFI_DIM_LAYER_EXCLUSIVE = 0x2,
+};
+
+/* Dim-layer configuration. */
+struct hfi_display_dim_layer {
+	enum hfi_display_dim_layer_flag flags;
+	u32 stage;
+	struct hfi_display_color color_fill;
+	struct hfi_display_roi rect;
+};
+
+enum hfi_layer_cache_state {
+	HFI_CACHE_STATE_DISABLE = 0x0,
+	HFI_CACHE_STATE_READ = 0x1,
+	HFI_CACHE_STATE_WRITE = 0x2,
+};
+
+enum hfi_layer_cache_op_type {
+	HFI_CACHE_OP_TYPE_NONE = 0x0,
+	HFI_CACHE_NORMAL_CACHEABLE_READ = 0x1,
+	HFI_CACHE_READ_INVALIDATE = 0x2,
+	HFI_CACHE_READ_EVICT = 0x3,
+	HFI_CACHE_PREFETCH_READ = 0x4,
+};
+
+/* Autorefresh configuration. */
+struct hfi_display_autorefresh_cfg {
+	u32 enable;
+	u32 frame_count;
+};
+
+struct hfi_display_idle_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 idle_index;
+};
+
+struct hfi_display_power_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	enum hfi_display_power_mode power_state;
+};
+
+struct hfi_display_prog_line_event_data {
+	u32 timestamp_lo;
+	u32 timestamp_hi;
+	u32 prog_line_index;
+};
+
+enum hfi_display_idle_timer_control {
+	HFI_DEFAULT          = 0x0,
+	HFI_WAKEUP           = 0x1,
+	HFI_BLOCK_TIMER      = 0x2,
+	HFI_UNBLOCK_TIMER    = 0x3,
+};
+
+/* Display event identifiers. */
+enum hfi_display_event_id {
+	HFI_EVENT_VSYNC               = 0x1,
+	HFI_EVENT_FRAME_SCAN_START    = 0x2,
+	HFI_EVENT_FRAME_SCAN_COMPLETE = 0x3,
+	HFI_EVENT_FRAME_IDLE          = 0x4,
+	HFI_EVENT_DISPLAY_POWER       = 0x5,
+	HFI_EVENT_HW_RECOVERY         = 0x6,
+	HFI_EVENT_FRAME_CAPTURE_COMPLETE = 0x7,
+	HFI_EVENT_PANEL_DEAD          = 0x8,
+	HFI_EVENT_LTM                 = 0x9,
+	HFI_EVENT_RGB_HIST            = 0xa,
+	HFI_EVENT_PA_HIST             = 0xb,
+	HFI_EVENT_HPD_STATUS          = 0xc,
+	HFI_EVENT_DISPLAY_EDID_INFO   = 0xd,
+	HFI_EVENT_SPR_OPR             = 0xe,
+	HFI_EVENT_INTF_MISR           = 0xf,
+	HFI_EVENT_HDCP1X_START        = 0x10,
+	HFI_EVENT_HDCP1X_STOP         = 0x11,
+	HFI_EVENT_HDCP1X_ENC          = 0x12,
+	HFI_EVENT_HDCP1X_TOPOLOGY_UPDATE = 0x13,
+	HFI_EVENT_HDCP2X_START        = 0x14,
+	HFI_EVENT_HDCP2X_PROCESS_MSG  = 0x15,
+	HFI_EVENT_HDCP2X_TIMEOUT      = 0x16,
+	HFI_EVENT_HDCP_FEATURE_SUPPORTED = 0x17,
+	HFI_EVENT_AIQE_COPR           = 0x18,
+	HFI_EVENT_PROG_LINE_INTR      = 0x19,
+};
+
+enum hfi_display_dp_event {
+	HFI_DP_EVENT_NONE         = 0x0,
+	HFI_DP_EVENT_HPD_PLUGGED  = 0x1,
+	HFI_DP_EVENT_IRQ_HPD      = 0x2,
+	HFI_DP_EVENT_SET_MODE     = 0x3,
+	HFI_DP_EVENT_HPD_UNPLUGGED = 0x4,
+};
+
+enum hfi_display_dp_state {
+	HFI_DP_STATE_DISCONNECTED = 0x0,
+	HFI_DP_STATE_HPD_IN       = 0x1,
+	HFI_DP_STATE_CONNECTED    = 0x2,
+	HFI_DP_STATE_HPD_OUT      = 0x3,
+};
+
+struct hfi_display_hpd_status {
+	enum hfi_display_dp_event dp_evt;
+	enum hfi_display_dp_state dp_state;
+};
+
+/* Display mode sent to firmware. */
+struct hfi_display_mode_info {
+	u32 size;
+	u32 h_active;
+	u32 h_back_porch;
+	u32 h_sync_width;
+	u32 h_front_porch;
+	u32 h_skew;
+	u32 h_sync_polarity;
+	u32 v_active;
+	u32 v_back_porch;
+	u32 v_sync_width;
+	u32 v_front_porch;
+	u32 v_sync_polarity;
+	u32 refresh_rate;
+	u32 clk_rate_hz_lo;
+	u32 clk_rate_hz_hi;
+	u32 flags_lo;
+	u32 flags_hi;
+	u32 reserved1;
+	u32 reserved2;
+};
+
+/* DSI command descriptor. */
+struct hfi_dsi_cmd_desc {
+	u32 size;
+
+	u8 channel;
+	u8 type;
+	u16 flags;
+
+		u32 tx_len;
+	u32 tx_buff_addr_lsb;
+	u32 tx_buff_addr_msb;
+
+		u32 rx_len;
+	u32 rx_buff_addr_lsb;
+	u32 rx_buff_addr_msb;
+
+		u32 ctrl_idx;
+	u32 ctrl_flags;
+	u32 last_command;
+	u32 post_wait_ms;
+
+	u32 seq_no;
+
+		u32 reserved2;
+};
+
+/* DSI command descriptor. */
+struct hfi_dsi_cmd_desc_set {
+	u32 size;
+	u32 type;
+	u32 count;
+	u32 state;
+	u32 seq_no;
+	u32 reserved2;
+	struct hfi_dsi_cmd_desc cmds[];
+};
+
+enum hfi_display_blend_stage {
+	HFI_BLEND_STAGE_BASE,
+	HFI_BLEND_STAGE_0,
+	HFI_BLEND_STAGE_1,
+	HFI_BLEND_STAGE_2,
+	HFI_BLEND_STAGE_3,
+	HFI_BLEND_STAGE_4,
+	HFI_BLEND_STAGE_5,
+	HFI_BLEND_STAGE_6,
+	HFI_BLEND_STAGE_7,
+	HFI_BLEND_STAGE_8,
+	HFI_BLEND_STAGE_9,
+	HFI_BLEND_STAGE_10,
+};
+
+enum hfi_layer_fetch_mode {
+	HFI_PARALLEL_FETCH        = 0x0,
+	HFI_TIME_MULTIPLEX_FETCH  = 0x1,
+};
+
+enum hfi_layer_security_policy {
+	HFI_LAYER_SECURITY_POLICY_NON_SECURE                  = 0x0,
+	HFI_LAYER_SECURITY_POLICY_SECURE                      = 0x1,
+	HFI_LAYER_SECURITY_POLICY_SECURE_DIR_TRANSLATION      = 0x2,
+	HFI_LAYER_SECURITY_POLICY_MAX
+};
+
+#define HFI_DISPLAY_ROTATION_0   BIT(0)
+
+#define HFI_DISPLAY_ROTATION_90   BIT(1)
+
+#define HFI_DISPLAY_ROTATION_180     BIT(2)
+
+#define HFI_DISPLAY_ROTATION_270   BIT(3)
+
+#define HFI_DISPLAY_REFLECT_X   BIT(4)
+
+#define HFI_DISPLAY_REFLECT_Y   BIT(5)
+
+enum hfi_cwb_tap_points {
+	HFI_TAP_POINT_NONE,
+	HFI_TAP_POINT_LM,
+	HFI_TAP_POINT_DSPP,
+	HFI_TAP_POINT_DEMURA,
+	HFI_TAP_POINT_MAX,
+};
+
+enum hfi_fence_type {
+	HFI_FENCE_SCAN_START,
+	HFI_FENCE_SCAN_COMPLETE,
+};
+
+enum hfi_dp_sink_capability_flags {
+	HFI_DP_SINK_CAP_MST,
+	HFI_DP_SINK_CAP_DSC,
+	HFI_DP_SINK_CAP_FEC,
+};
+
+/* EDID and mode information. */
+struct hfi_display_event_edid_info {
+	u32 controller_id;
+	u32 stream_id;
+	u32 link_rate;
+	u32 lane_count;
+	u32 bits_per_pixel;
+	u32 flags;
+	struct hfi_buff edid_modes_buf;
+};
+
+struct hfi_display_dp_tu {
+	u32 dp_tu;
+	u32 valid_boundary;
+	u32 valid_boundary2;
+};
+
+/* Display audio configuration. */
+struct hfi_audio_config {
+	u32 sample_rate;
+	u32 num_of_channels;
+	u32 channel_allocation;
+	u32 level_shift;
+	u32 down_mix;
+	u32 sample_present;
+	u32 stream_id;
+};
+
+struct hfi_hdr_metadata {
+		u32 hdr_state;
+	u32 eotf;
+	u32 hdr_supported;
+	u32 display_primaries_x[HFI_MAX_COLOR_COMPONENTS];
+	u32 display_primaries_y[HFI_MAX_COLOR_COMPONENTS];
+	u32 white_point_x;
+	u32 white_point_y;
+	u32 max_luminance;
+	u32 min_luminance;
+	u32 max_content_light_level;
+	u32 max_average_light_level;
+};
+
+/* HDR display configuration. */
+struct hfi_display_hdr_cfg {
+	struct hfi_hdr_metadata hdr_meta;
+	u32 dynamic_hdr_payload_size;
+	u8 dynamic_hdr_payload[HFI_DHDR_PAYLOAD_MAX_SIZE];
+};
+
+enum hfi_colorimetry {
+	HFI_COLORIMETRY_DEFAULT            = 0,
+	HFI_COLORIMETRY_SMPTE_170M_YCC     = 1,
+	HFI_COLORIMETRY_BT709_YCC          = 2,
+	HFI_COLORIMETRY_XVYCC_601          = 3,
+	HFI_COLORIMETRY_XVYCC_709          = 4,
+	HFI_COLORIMETRY_SYCC_601           = 5,
+	HFI_COLORIMETRY_OPYCC_601          = 6,
+	HFI_COLORIMETRY_OPRGB              = 7,
+	HFI_COLORIMETRY_BT2020_CYCC        = 8,
+	HFI_COLORIMETRY_BT2020_RGB         = 9,
+	HFI_COLORIMETRY_BT2020_YCC         = 10,
+	HFI_COLORIMETRY_DCI_P3_RGB_D65     = 11,
+	HFI_COLORIMETRY_DCI_P3_RGB_THEATER = 12,
+};
+
+enum hfi_misr_block {
+	HFI_MISR_DSI   = 0x0,
+	HFI_MISR_MIXER = 0x1,
+	HFI_MISR_INTF  = 0x2,
+};
+
+enum hfi_batch_mode {
+	HFI_BATCH_MODE_NONE   = 0x0,
+	HFI_BATCH_MODE_START  = 0x1,
+	HFI_BATCH_MODE_END    = 0x2,
+	HFI_BATCH_MODE_CANCEL = 0x3,
+};
+
+enum hfi_batch_usecase_id {
+	HFI_BATCH_USECASE_NONE = 0,
+	HFI_BATCH_USECASE_GMU_REPROJ,
+};
+
+struct hfi_misr_config {
+	u32 enable;
+	u32 frame_count;
+	enum hfi_misr_block block;
+};
+
+/* HDCP 1.x topology. */
+struct hfi_hdcp1x_topology_data {
+	u32 depth;
+	u32 device_count;
+	u32 max_devices_exceeded;
+	u32 max_cascade_exceeded;
+};
+
+/* HDCP 2.x message payload. */
+struct hfi_hdcp2_message {
+	u32 timeout_ms;
+	u32 repeater_flag;
+	struct hfi_buff request;
+	struct hfi_buff response;
+};
+
+struct hfi_display_mode_extended_info {
+	u32 size;
+	struct hfi_display_mode_info base;
+	u32 mixer_count;
+	u32 cmpr_count;
+	u32 cmpr_enabled;
+	u32 cmpr_bpp;
+	u32 cmpr_slice_count;
+	u8  test_pattern;
+	u8  reserved[7];
+};
+
+struct hfi_cmd_set_remap {
+	u32 cmd_type;
+	u32 custom_cmd_type;
+	u32 flag;
+	u32 reserved;
+};
+
+struct hfi_dsi_dcs_cmd_set_replace_entry {
+	u32 dpu_buff_type_offset;
+	u32 cmd_type;
+	u32 count_cmds;
+	u32 hfi_buff_struct_offset;
+	u32 reserved;
+};
+
+struct hfi_custom_wd_te_params {
+	u32 wd_te_enabled;
+	u32 custom_fps;
+};
+
+/* Display batch-mode configuration. */
+struct hfi_batch_mode_info {
+	enum hfi_batch_mode mode;
+	enum hfi_batch_usecase_id usecase_id;
+	u32 reserved[2];
+};
+
+#define HFI_WB_DNSC_CFG_DISABLE	BIT(0)
+
+struct hfi_dnsc_cfg {
+	u32 flags;
+	u32 dst_width;
+	u32 dst_height;
+};
+
+#endif /* __H_HFI_DEFS_DISPLAY_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h
new file mode 100644
index 000000000000..7a474e0c55b7
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_display_color.h
@@ -0,0 +1,247 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_DISPLAY_COLOR_H__
+#define __H_HFI_DEFS_DISPLAY_COLOR_H__
+
+#include <linux/types.h>
+
+#include "hfi_defs_common.h"
+
+#define HFI_DISPLAY_COLOR_FLAGS_FEATURE_ENABLE         BIT(0)
+
+#define HFI_DISPLAY_COLOR_FLAGS_FEATURE_BROADCAST      BIT(1)
+
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_0_FLAG    BIT(2)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_1_FLAG    BIT(3)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_2_FLAG    BIT(4)
+#define HFI_DISPLAY_COLOR_HW_BLK_INDEX_3_FLAG    BIT(5)
+
+#define HFI_DITHER_MATRIX_SZ                16
+#define HFI_DITHER_LUMA_MODE                BIT(0)
+#define HFI_DITHER_OFFSET_ENABLE            BIT(1)
+
+#define HFI_DITHER_MATRIX_SZ_EXTENDED       256
+#define HFI_DITHER_MATRIX_SELECT_4_4        0
+#define HFI_DITHER_MATRIX_SELECT_6_6        1
+#define HFI_DITHER_MATRIX_SELECT_8_8        2
+#define HFI_DITHER_MATRIX_SELECT_16_16      3
+
+/* Dither configuration. */
+struct hfi_display_dither {
+	u32 flags;
+	u32 feature_flags;
+	u32 temporal_en;
+	u32 c0_bitdepth;
+	u32 c1_bitdepth;
+	u32 c2_bitdepth;
+	u32 c3_bitdepth;
+	u32 dither_matrix_select;
+	s32 matrix[HFI_DITHER_MATRIX_SZ_EXTENDED];
+};
+
+/* PA dither configuration. */
+struct hfi_display_pa_dither {
+	u32 flags;
+	u32 strength;
+	u32 offset_en;
+	u32 matrix[HFI_DITHER_MATRIX_SZ];
+};
+
+#define HFI_QRTC_LUT_SIZE 81        /* Each LUT is 9x9 */
+#define HFI_QRTC_NUM_LUTS 3         /* Number of LPF/HPF tables */
+
+/* QRTC subsampling modes. */
+#define HFI_QRTC_SUBSAMPLE_1x1 0x0  /* Horizontal: 1, Vertical: 1 */
+#define HFI_QRTC_SUBSAMPLE_2x1 0x1  /* Horizontal: 2, Vertical: 1 */
+#define HFI_QRTC_SUBSAMPLE_2x2 0x2  /* Horizontal: 2, Vertical: 2 */
+#define HFI_QRTC_SUBSAMPLE_3x3 0x3  /* Horizontal: 3, Vertical: 3 */
+
+/* QRTC DMA selections. */
+#define HFI_QRTC_DMA_1 0x1
+#define HFI_QRTC_DMA_3 0x3
+
+/* QRTC rectangle selections. */
+#define HFI_QRTC_RECT0 0x0  /* Select Rectangle 0 */
+#define HFI_QRTC_RECT1 0x1  /* Select Rectangle 1 */
+#define HFI_WRITE_BACK_0 0x0
+#define HFI_WRITE_BACK_1 0x1
+#define HFI_WRITE_BACK_2 0x2
+#define HFI_CWB_BLOCK_0 0x0
+#define HFI_CWB_BLOCK_1 0x1
+#define HFI_CWB_BLOCK_2 0x2
+#define HFI_CWB_BLOCK_3 0x3
+#define HFI_CWB_BLOCK_4 0x4
+#define HFI_CWB_BLOCK_5 0x5
+#define HFI_CWB_BLOCK_6 0x6
+#define HFI_CWB_BLOCK_7 0x7
+
+/* Bit 16 marks a secure QRTC buffer. */
+#define HFI_QRTC_SECURE_BUFF BIT(16)
+
+/* QRTC configuration and capture-buffer selection. */
+struct hfi_qrtc_config {
+	u32 flags;
+	u32 lut_dma_flags;
+	u32 iova_l;
+	u32 iova_h;
+	u32 len;
+	u32 coring_en;
+	u32 coring_pos;
+	u32 coring_neg;
+	u32 lpf_en;
+	u32 subsample_mode;
+	u32 dma_sel;
+	u32 rect_sel;
+	u32 wb_sel;
+	u32 cwb_sel;
+	u32 cwb_tap_point;
+	u32 cwb_iova_l;
+	u32 cwb_iova_h;
+	u32 cwb_len;
+	u32 cwb_height;
+	u32 cwb_width;
+	u32 format;
+	u32 aligned_cwb_height;
+	u32 aligned_cwb_width;
+};
+
+#define HFI_LTM_DATA_SIZE_0        32
+#define HFI_LTM_DATA_SIZE_1        128
+#define HFI_LTM_DATA_SIZE_2        256
+#define HFI_LTM_BLOCK_MAX          4
+
+#define HFI_LTM_STATS_SAT          BIT(1)
+#define HFI_LTM_STATS_MERGE_SAT    BIT(2)
+
+#define HFI_LTM_HIST_DONE                   BIT(0)
+#define HFI_LTM_WB_PB                       BIT(1)
+#define HFI_LTM_HIST_OFF                    BIT(2)
+
+struct hfi_display_ltm_init_param {
+	u32 flags;
+	u32 init_param_01;
+	u32 init_param_02;
+	u32 init_param_03;
+	u32 init_param_04;
+};
+
+struct hfi_display_ltm_cfg_param {
+	u32 flags;
+	u32 cfg_param_01;
+	u32 cfg_param_02;
+	u32 cfg_param_03;
+	u32 cfg_param_04;
+	u32 cfg_param_05;
+	u32 cfg_param_06;
+};
+
+/* Shared LTM statistics buffer descriptor. */
+struct hfi_display_ltm_buffer {
+	u32 flags;
+	u32 dpu_iova_l;
+	u32 dpu_iova_h;
+	u32 dcp_addr_l;
+	u32 dcp_addr_h;
+	u32 size;
+};
+
+struct hfi_display_ltm_stats_data {
+	u32 stats_01[HFI_LTM_DATA_SIZE_0][HFI_LTM_DATA_SIZE_1];
+	u32 stats_02[HFI_LTM_DATA_SIZE_2];
+	u32 stats_03[HFI_LTM_DATA_SIZE_0];
+	u32 stats_04[HFI_LTM_DATA_SIZE_0];
+	u32 stats_05[HFI_LTM_DATA_SIZE_0];
+	u32 status_flag;
+	u32 display_h;
+	u32 display_v;
+	u32 init_h[HFI_LTM_BLOCK_MAX];
+	u32 init_v;
+	u32 inc_h;
+	u32 inc_v;
+	u32 portrait_en;
+	u32 merge_en;
+	u32 cfg_param_01;
+	u32 cfg_param_02;
+	u32 cfg_param_03;
+	u32 cfg_param_04;
+	u32 feature_flag;
+	u32 checksum;
+};
+
+struct hfi_display_ltm_event_resp {
+	u32 event_type;
+	u32 dcp_addr_h;
+	u32 dcp_addr_l;
+};
+
+#define HFI_RGB_HISTOGRAM_BIN_COUNT 1024
+#define HFI_RGB_COMPONENT_SIZE 3
+
+#define HFI_RGB_HIST_ROI_ENABLE BIT(1)
+
+#define HFI_RGB_HIST_DONE BIT(0)
+#define HFI_RGB_HIST_WB_ERR BIT(1)
+#define HFI_RGB_HIST_OFF BIT(2)
+
+struct hfi_display_rgb_hist_ctrl {
+	u32 flags;
+	u32 roi_mode;
+	u32 roi_x;
+	u32 roi_y;
+	u32 roi_width;
+	u32 roi_height;
+	u32 tap_point;
+	u32 colorspace_mode;
+};
+
+struct hfi_display_rgb_hist_stats_data {
+	u32 hist[HFI_RGB_HISTOGRAM_BIN_COUNT];
+	u32 hist_min;
+	u32 hist_max;
+	u32 hist_sum_lsb;
+	u32 hist_sum_msb;
+	u32 hcount;
+	u32 crc;
+	u32 status_flags;
+	u32 roi_mode;
+	u32 roi_x;
+	u32 roi_y;
+	u32 roi_width;
+	u32 roi_height;
+	u32 tap_point;
+	u32 colorspace_mode;
+};
+
+/* Shared RGB histogram buffer descriptor. */
+struct hfi_display_rgb_hist_buffer {
+	u32 flags;
+	u32 dpu_iova_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dpu_iova_hi[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_hi[HFI_RGB_COMPONENT_SIZE];
+	u32 size;
+};
+
+struct hfi_display_rgb_hist_event_resp {
+	u32 event_type;
+	u32 dcp_addr_lo[HFI_RGB_COMPONENT_SIZE];
+	u32 dcp_addr_hi[HFI_RGB_COMPONENT_SIZE];
+};
+
+/* Shared PA histogram buffer descriptor. */
+struct hfi_display_pa_hist_buffer {
+	u32 flags;
+	u32 dcp_addr_lo;
+	u32 dcp_addr_hi;
+	u32 size;
+};
+
+struct hfi_display_pa_hist_event_resp {
+	u32 dcp_addr_lo;
+	u32 dcp_addr_hi;
+};
+
+#endif /* __H_HFI_DEFS_DISPLAY_COLOR_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h
new file mode 100644
index 000000000000..a38d778898b2
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_DEFS_PANEL_H__
+#define __H_HFI_DEFS_PANEL_H__
+
+#include "hfi_defs_common.h"
+
+/* Panel format, link, and power properties. */
+enum hfi_panel_phy_type {
+	HFI_PANEL_PHY_OLED      = 0x1,
+	HFI_PANEL_PHY_LCD       = 0x2,
+};
+
+/* Lower values have higher display priority. */
+enum hfi_panel_display_type {
+	HFI_PANEL_DISPLAY_TYPE_NONE           = 0x0,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_0     = 0x1,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_1     = 0x2,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_2     = 0x3,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_3     = 0x4,
+	HFI_PANEL_DISPLAY_TYPE_BUILT_IN_4     = 0x5,
+};
+
+enum hfi_panel_bpp {
+	HFI_PANEL_BPP_3      = 1,
+	HFI_PANEL_BPP_8      = 2,
+	HFI_PANEL_BPP_12     = 3,
+	HFI_PANEL_BPP_16     = 4,
+	HFI_PANEL_BPP_18     = 5,
+	HFI_PANEL_BPP_24     = 6,
+	HFI_PANEL_BPP_30     = 7,
+};
+
+enum hfi_panel_deinit_prop {
+	HFI_PANEL_DEINIT_CONT_SPLASH = 0x00000001,
+};
+
+enum hfi_panel_lane_enable {
+	HFI_PANEL_LANE_0      = 0x00000001,
+	HFI_PANEL_LANE_1      = 0x00000002,
+	HFI_PANEL_LANE_2      = 0x00000004,
+	HFI_PANEL_LANE_3      = 0x00000008,
+};
+
+enum hfi_panel_lane_map {
+	HFI_PANEL_LANE_MAP_0123 = 1,
+};
+
+enum hfi_panel_color_order_type {
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_RGB   = 0x1,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_RBG   = 0x2,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_BRG   = 0x3,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_GRB   = 0x4,
+	HFI_PANEL_COLOR_ORDER_RGB_SWAP_GBR   = 0x5,
+};
+
+enum hfi_panel_vsync_source {
+	HFI_PANEL_VSYNC_SOURCE_GPIO_0  = 0x0,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_1  = 0x1,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_2  = 0x2,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_3  = 0x3,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_4  = 0x4,
+	HFI_PANEL_VSYNC_SOURCE_GPIO_5  = 0x5,
+	HFI_PANEL_VSYNC_SOURCE_WD      = 0xf,
+};
+
+enum hfi_panel_trigger_type {
+	HFI_PANEL_TRIGGER_NONE      = 1,
+	HFI_PANEL_TRIGGER_TE        = 2,
+	HFI_PANEL_TRIGGER_SW        = 3,
+	HFI_PANEL_TRIGGER_SW_TE     = 4,
+	HFI_PANEL_TRIGGER_SW_SEOF   = 5,
+	HFI_PANEL_TRIGGER_SEOF      = 6,
+};
+
+enum hfi_panel_fps_traffic_mode {
+	HFI_PANEL_TRAFFIC_NON_BURST_SYNC_PULSE_MODE     = 1,
+	HFI_PANEL_TRAFFIC_NON_BURST_SYNC_EVENT_MODE     = 2,
+	HFI_PANEL_TRAFFIC_BURST_MODE                    = 3,
+};
+
+enum hfi_panel_modes {
+	HFI_PANEL_VIDEO_MODE_8_BIT      = 0x1,
+	HFI_PANEL_VIDEO_MODE_10_BIT     = 0x2,
+	HFI_PANEL_CMD_MODE_8_BIT        = 0x4,
+	HFI_PANEL_CMD_MODE_10_BIT       = 0x8,
+	HFI_PANEL_VIDEO_MODE_PSR_8_BIT	= 0x10,
+	HFI_PANEL_VIDEO_MODE_PSR_10_BIT	= 0x20,
+	HFI_PANEL_VIDEO_LTPO_8_BIT	= 0x40,
+	HFI_PANEL_VIDEO_LTPO_10_BIT	= 0x80
+};
+
+enum hfi_panel_backlight_ctrl {
+	HFI_PANEL_BACKLIGHT_CTRL_UNKNOWN    = 0x0,
+	HFI_PANEL_BACKLIGHT_CTRL_PWM        = 0x1,
+	HFI_PANEL_BACKLIGHT_CTRL_WLED       = 0x2,
+	HFI_PANEL_BACKLIGHT_CTRL_DCS        = 0x3,
+	HFI_PANEL_BACKLIGHT_CTRL_EXTERNAL   = 0x4,
+};
+
+enum hfi_panel_compression_mode {
+	HFI_PANEL_COMPRESSION_NONE  = 0,
+	HFI_PANEL_COMPRESSION_DSC   = 1,
+};
+
+enum hfi_panel_chroma_format_type {
+	HFI_PANEL_CHROMA_FORMAT_444     = 1,
+	HFI_PANEL_CHROMA_FORMAT_422     = 2,
+	HFI_PANEL_CHROMA_FORMAT_420     = 3,
+};
+
+enum hfi_panel_color_space_type {
+	HFI_PANEL_COLOR_SPACE_RGB     = 1,
+	HFI_PANEL_COLOR_SPACE_YUV     = 2,
+};
+
+enum hfi_panel_dfps_type {
+	HFI_PANEL_DFPS_NONE = 0,
+	HFI_PANEL_DFPS_SUSPEND_RESUME,
+	HFI_PANEL_DFPS_IMMEDIATE_CLK,
+	HFI_PANEL_DFPS_IMMEDIATE_HFP,
+	HFI_PANEL_DFPS_IMMEDIATE_VFP,
+	HFI_PANEL_DFPS_MAX
+};
+
+/* Panel topology. */
+struct hfi_panel_topology {
+	u32 mixer_count;
+	u32 enc_count;
+	u32 display_count;
+};
+
+/* DSI command sequencing. */
+enum hfi_panel_dcs_cmd_state {
+	HFI_PANEL_DSI_HS_MODE   = 0x1,
+	HFI_PANEL_DSI_LP_MODE   = 0x2,
+};
+
+enum hfi_panel_dcs_command_type {
+	HFI_DCS_CMD_PRE_ON                      = 0x00000000,
+	HFI_DCS_CMD_ON                          = 0x00000001,
+	HFI_DCS_CMD_VIDEO_ON                    = 0x00000002,
+	HFI_DCS_CMD_COMMAND_ON                  = 0x00000003,
+	HFI_DCS_CMD_POST_PANEL_ON               = 0x00000004,
+	HFI_DCS_CMD_PRE_OFF                     = 0x00000005,
+	HFI_DCS_CMD_OFF                         = 0x00000006,
+	HFI_DCS_CMD_POST_OFF                    = 0x00000007,
+	HFI_DCS_CMD_PRE_RES_SWITCH              = 0x00000008,
+	HFI_DCS_CMD_RES_SWITCH                  = 0x0000009,
+	HFI_DCS_CMD_POST_RES_SWITCH             = 0x00000010,
+	HFI_DCS_CMD_VIDEO_MODE_SWITCH_INS       = 0x00000011,
+	HFI_DCS_CMD_VIDEO_MODE_SWITCH_OUTS      = 0x00000012,
+	HFI_DCS_CMD_COMMAND_MODE_SWITCH_INS     = 0x00000013,
+	HFI_DCS_CMD_COMMAND_MODE_SWITCH_OUTS    = 0x00000014,
+	HFI_DCS_CMD_PANEL_STATUS                = 0x00000015,
+	HFI_DCS_CMD_LP1                         = 0x00000016,
+	HFI_DCS_CMD_LP2                         = 0x00000017,
+	HFI_DCS_CMD_NOLP                        = 0x00000018,
+	HFI_DCS_CMD_PPS                         = 0x00000019,
+	HFI_DCS_CMD_ROI                         = 0x00000020,
+	HFI_DCS_CMD_TIMING_SWITCH               = 0x00000021,
+	HFI_DCS_CMD_POST_MODE_SWITCH_ON         = 0x00000022,
+	HFI_DCS_CMD_QSYNC_ONS                   = 0x00000023,
+	HFI_DCS_CMD_QSYNC_OFFS                  = 0x00000024,
+	HFI_DCS_CMD_MAX                         = 0x00000025
+};
+
+/* Panel ESD status modes. */
+enum hfi_panel_esd_status_mode {
+	HFI_PANEL_ESD_STATUS_MODE_REG_READ       = 0x1,
+	HFI_PANEL_ESD_STATUS_MODE_SW_BTA         = 0x2,
+	HFI_PANEL_ESD_STATUS_MODE_PANEL_TE       = 0x3,
+	HFI_PANEL_ESD_STATUS_MODE_PANEL_RW       = 0x4,
+	HFI_PANEL_ESD_STATUS_MODE_SW_SIM_SUCCESS = 0x5,
+	HFI_PANEL_ESD_STATUS_MODE_SW_SIM_FAILURE = 0x6
+};
+
+/* Panel timing parameters. */
+struct hfi_panel_res_data {
+	u32 active_width;
+	u32 active_height;
+	u32 h_front_porch;
+	u32 h_back_porch;
+	u32 h_left_border;
+	u32 h_right_border;
+	u32 h_pulse_width;
+	u32 h_sync_skew;
+	u32 h_sync_pulse;
+	u32 v_front_porch;
+	u32 v_back_porch;
+	u32 v_top_border;
+	u32 v_bottom_border;
+	u32 v_pulse_width;
+};
+
+/* Panel compression parameters. */
+struct hfi_panel_compression_params {
+	enum hfi_panel_compression_mode	mode;
+	u32 version;
+	u32 scr_version;
+	u32 slice_height;
+	u32 slice_width;
+	u32 slices_per_pkt;
+	u32 bits_per_component;
+	u32 pps_delay_ms;
+	u32 bits_per_pixel;
+	enum hfi_panel_chroma_format_type chroma_format;
+	enum hfi_panel_color_space_type color_space;
+	u32 block_prediction_enable;
+};
+
+/* DCS command buffers. */
+struct hfi_panel_dcs_cmd_buffer_info {
+	u32 offset_l;
+	u32 offset_h;
+	u32 size;
+	u32 delay;
+	u32 ctrl_flags;
+	enum hfi_panel_dcs_cmd_state mode;
+	u32 reserve1;
+	u32 reserve2;
+};
+
+struct hfi_panel_compression_rc_override {
+	u8 min_qp[15];
+	u8 padding1;
+	u8 max_qp[15];
+	u8 padding2;
+	u8 offsets[15];
+	u8 padding3;
+};
+
+/* Panel ESD configuration. */
+/* Register-read fields are valid only in REG_READ mode. */
+struct hfi_panel_esd_config {
+	u32 size;
+	enum hfi_panel_esd_status_mode status_mode;
+
+		u32 count;
+	u32 groups;
+
+	u32 hfi_dsi_cmd_desc_lsb;
+	u32 hfi_dsi_cmd_desc_msb;
+
+	u32 valid_params_lsb;
+	u32 valid_params_msb;
+
+	u32 status_values_lsb;
+	u32 status_values_msb;
+};
+
+struct hfi_qsync_params {
+	u32 avr_step_fps;
+	u32 qsync_min_fps;
+};
+
+struct hfi_panel_esync_caps {
+	u32 esync_support;
+	u32 esync_milli_skew;
+	u32 hsync_milli_pulse_width;
+	u32 emsync_milli_pulse_width;
+	u32 emsync_fps;
+};
+
+struct hfi_panel_dfps_caps {
+	u32 dfps_support;
+	u32 min_refresh_rate;
+	u32 max_refresh_rate;
+	enum hfi_panel_dfps_type type;
+};
+
+struct hfi_display_vrr_frame_params {
+	u32 frame_interval_ns_lo;
+	u32 frame_interval_ns_hi;
+	u32 usecase_idx;
+};
+
+/* Panel operating-mode capabilities. */
+struct hfi_panel_operating_mode_caps {
+	u32 panel_mode_switch_enabled;
+	u32 vsync_aligned_switch;
+};
+
+#endif /* __H_HFI_DEFS_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h
new file mode 100644
index 000000000000..b767e6ee8e40
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PACK_UNPACK_COMMON_H__
+#define __H_HFI_PACK_UNPACK_COMMON_H__
+
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include "hfi_packet.h"
+
+/* Header size field width. */
+#define HFI_HEADER_SIZE_MAX                                   0x00ffffff
+/* Packet size field width. */
+#define HFI_PACKET_SIZE_MAX                                   0x000fffff
+
+#define HFI_HEADER_CMD_BUFF_TYPE_START_BIT                                   24
+#define HFI_PACKET_PAYLOAD_TYPE_START_BIT                                21
+
+#define GET_HEADER_SIZE(data)           \
+	((data) & ((1 << HFI_HEADER_CMD_BUFF_TYPE_START_BIT) - 1))
+#define GET_HEADER_CMD_BUFF_TYPE(data)         \
+	((data) >> HFI_HEADER_CMD_BUFF_TYPE_START_BIT)
+#define GET_PACKET_SIZE(data)           \
+	((data) & ((1 << HFI_PACKET_PAYLOAD_TYPE_START_BIT) - 1))
+#define GET_PACKET_PAYLOAD_TYPE(data)   \
+	((data) >> HFI_PACKET_PAYLOAD_TYPE_START_BIT)
+
+static inline struct hfi_packet *hfi_packet_first(struct hfi_header *hdr)
+{
+	return (struct hfi_packet *)((u8 *)hdr + sizeof(*hdr));
+}
+
+static inline struct hfi_packet *hfi_packet_append(struct hfi_header *hdr)
+{
+	return (struct hfi_packet *)((u8 *)hdr +
+		GET_HEADER_SIZE(hdr->cmd_buff_info));
+}
+
+static inline struct hfi_packet *hfi_packet_next(struct hfi_packet *packet)
+{
+	return (struct hfi_packet *)((u8 *)packet +
+		GET_PACKET_SIZE(packet->payload_info));
+}
+
+/* Shared command-buffer handle. */
+struct hfi_cmd_buff_hdl {
+	void *cmd_buffer;
+	u32 size;
+};
+
+/* Packed HFI property key/value entry. */
+struct hfi_kv_info {
+	u32 key;
+	void *value_ptr;
+};
+
+/* HFI header fields. */
+struct hfi_header_info {
+	u32 num_packets;
+	enum hfi_cmd_buff_type cmd_buff_type;
+	u32 object_id;
+	u32 header_id;
+};
+
+/* HFI packet fields. */
+struct hfi_packet_info {
+	u32 cmd;
+	u32 id;
+	u32 flags;
+	u32 packet_id;
+	enum hfi_packet_payload_type payload_type;
+	u32 payload_size;
+	void *payload_ptr;
+};
+
+#endif /* __H_HFI_PACK_UNPACK_COMMON_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c b/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c
new file mode 100644
index 000000000000..2f750182aa0b
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "hfi_packer.h"
+
+static int hfi_validate_cmd_buff_size(struct hfi_header *hdr,
+				      u32 allocated_size, u32 bytes_to_add)
+{
+	u32 bytes_used;
+
+	if (allocated_size < sizeof(struct hfi_header))
+		return -EINVAL;
+
+	bytes_used = GET_HEADER_SIZE(hdr->cmd_buff_info);
+	if (bytes_used < sizeof(*hdr) || bytes_used > allocated_size ||
+	    bytes_to_add > allocated_size - bytes_used ||
+	    bytes_used + bytes_to_add > HFI_HEADER_SIZE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+u32 hfi_get_header_size(struct hfi_cmd_buff_hdl *cmd_buf_hdl)
+{
+	struct hfi_header *hdr = cmd_buf_hdl->cmd_buffer;
+
+	return GET_HEADER_SIZE(hdr->cmd_buff_info);
+}
+
+int hfi_create_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+		      struct hfi_header_info *header_info)
+{
+	struct hfi_header *hdr;
+
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !header_info)
+		return -EINVAL;
+
+	hdr = cmd_buf_hdl->cmd_buffer;
+	if (cmd_buf_hdl->size < sizeof(*hdr))
+		return -EINVAL;
+
+	memset(hdr, 0, sizeof(*hdr));
+	hdr->cmd_buff_info = (header_info->cmd_buff_type <<
+		HFI_HEADER_CMD_BUFF_TYPE_START_BIT) | sizeof(*hdr);
+	hdr->object_id = header_info->object_id;
+	hdr->header_id = header_info->header_id;
+
+	return 0;
+}
+
+static int hfi_create_packet(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			     struct hfi_packet_info *packet_info,
+				     const void *payload, u32 payload_size)
+{
+	struct hfi_header *hdr;
+	struct hfi_packet *pkt_hdr;
+	u32 pkt_size;
+	int ret;
+
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !packet_info ||
+	    (payload_size && !payload))
+		return -EINVAL;
+
+	if (payload_size > HFI_PACKET_SIZE_MAX - sizeof(struct hfi_packet))
+		return -EINVAL;
+
+	hdr = cmd_buf_hdl->cmd_buffer;
+	pkt_size = sizeof(*pkt_hdr) + payload_size;
+	ret = hfi_validate_cmd_buff_size(hdr, cmd_buf_hdl->size, pkt_size);
+	if (ret)
+		return ret;
+
+	pkt_hdr = hfi_packet_append(hdr);
+	memset(pkt_hdr, 0, sizeof(*pkt_hdr));
+	pkt_hdr->payload_info = (packet_info->payload_type <<
+		HFI_PACKET_PAYLOAD_TYPE_START_BIT) | pkt_size;
+	pkt_hdr->cmd = packet_info->cmd;
+	pkt_hdr->flags = packet_info->flags;
+	pkt_hdr->id = packet_info->id;
+	pkt_hdr->packet_id = packet_info->packet_id;
+	if (payload_size)
+		memcpy(pkt_hdr + 1, payload, payload_size);
+
+	hdr->cmd_buff_info += pkt_size;
+	hdr->num_packets++;
+
+	return 0;
+}
+
+int hfi_create_full_packet(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			   struct hfi_packet_info *packet_info)
+{
+	if (!packet_info)
+		return -EINVAL;
+
+	return hfi_create_packet(cmd_buf_hdl, packet_info,
+		packet_info->payload_ptr, packet_info->payload_size);
+}
+
+int hfi_create_packet_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			     struct hfi_packet_info *packet_info)
+{
+	return hfi_create_packet(cmd_buf_hdl, packet_info, NULL, 0);
+}
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h
new file mode 100644
index 000000000000..460c11c72416
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PACKER_H__
+#define __H_HFI_PACKER_H__
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+#include "hfi_pack_unpack_common.h"
+
+/* Pack a property ID, version, and size into one key. */
+#define HFI_PACK_KEY(property_id, version, dsize) \
+	((property_id) | ((version) << 20) | ((dsize) << 24))
+
+/* Pack a version-zero property and return its serialized word count. */
+#define HFI_PACK(payload, property_id, ...) \
+({ \
+	const u32 __hfi_values[] = { __VA_ARGS__ }; \
+	u32 *__hfi_payload = (payload); \
+	u32 __hfi_count = ARRAY_SIZE(__hfi_values); \
+\
+	*__hfi_payload++ = HFI_PACK_KEY(property_id, 0, __hfi_count); \
+	memcpy(__hfi_payload, __hfi_values, sizeof(__hfi_values)); \
+	__hfi_count + 1; \
+})
+
+/* Pack a property with an explicitly selected protocol version. */
+#define HFI_PACK_VERSION(payload, property_id, version, ...) \
+({ \
+	const u32 __hfi_values[] = { __VA_ARGS__ }; \
+	u32 *__hfi_payload = (payload); \
+	u32 __hfi_count = ARRAY_SIZE(__hfi_values); \
+\
+	*__hfi_payload++ = HFI_PACK_KEY(property_id, version, __hfi_count); \
+	memcpy(__hfi_payload, __hfi_values, sizeof(__hfi_values)); \
+	__hfi_count + 1; \
+})
+
+/** hfi_get_header_size() - Return the bytes used by an HFI header. */
+u32 hfi_get_header_size(struct hfi_cmd_buff_hdl *cmd_buf_hdl);
+
+/** hfi_create_header() - Initialize an HFI command header. */
+int hfi_create_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+		      struct hfi_header_info *header_info);
+
+/** hfi_create_full_packet() - Append a packet and its payload. */
+int hfi_create_full_packet(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			   struct hfi_packet_info *packet_info);
+
+/** hfi_create_packet_header() - Append a packet without a payload. */
+int hfi_create_packet_header(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			     struct hfi_packet_info *packet_info);
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+#endif /* __H_HFI_PACKER_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h
new file mode 100644
index 000000000000..80c6b2b64cfd
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PACKET_H__
+#define __H_HFI_PACKET_H__
+
+#include "hfi_defs_common.h"
+
+/* HFI header: size [23:0], command-buffer type [31:24]. */
+struct hfi_header {
+	u32 cmd_buff_info;
+	u16 device_id;
+	u16 object_id;
+	u32 timestamp_hi;
+	u32 timestamp_lo;
+	u32 header_id;
+	u32 reserved[2];
+	u32 num_packets;
+};
+
+/* HFI packet: size [20:0], payload type [31:21]. */
+struct hfi_packet {
+	u32 payload_info;
+	u32 cmd;
+	u32 flags;
+	u32 id;
+	u32 packet_id;
+	u32 reserved[3];
+};
+
+/* Command-buffer flags stored in object_id[15:8]. */
+enum hfi_cmd_buff_flag {
+	HFI_CMD_BUFF_FLAG_NONE    = 0x00,
+	HFI_CMD_BUFF_FLAG_ASYNC   = 0x01,
+	HFI_CMD_BUFF_FLAG_NO_WAIT = 0x02,
+};
+
+/* Packet payload encodings. */
+enum hfi_packet_payload_type {
+	HFI_PAYLOAD_NONE                = 0x0,
+	HFI_PAYLOAD_U32                 = 0x1,
+	HFI_PAYLOAD_U32_ARRAY           = 0x2,
+	HFI_PAYLOAD_U64                 = 0x3,
+	HFI_PAYLOAD_U64_ARRAY           = 0x4,
+	HFI_PAYLOAD_BLOB                = 0x5,
+};
+
+/* Command-buffer groups encoded in command headers. */
+enum hfi_cmd_buff_type {
+	HFI_CMD_BUFF_SYSTEM          = 0x1,
+	HFI_CMD_BUFF_DEVICE          = 0x2,
+	HFI_CMD_BUFF_DISPLAY         = 0x3,
+	HFI_CMD_BUFF_DEBUG           = 0x4,
+	HFI_CMD_BUFF_VIRTUALIZATION  = 0x5,
+};
+
+/* Host-to-firmware packet flags. */
+enum hfi_packet_tx_flags {
+	HFI_TX_FLAGS_NONE              = 0x0,
+	HFI_TX_FLAGS_INTR_REQUIRED     = 0x1,
+	HFI_TX_FLAGS_RESPONSE_REQUIRED = 0x2,
+	HFI_TX_FLAGS_NON_DISCARDABLE   = 0x4,
+};
+
+/* Firmware-to-host packet flags. */
+enum hfi_packet_rx_flags {
+	HFI_RX_FLAGS_NONE               = 0x0,
+	HFI_RX_FLAGS_SUCCESS            = 0x1,
+	HFI_RX_FLAGS_INFORMATION        = 0x2,
+	HFI_RX_FLAGS_DEVICE_ERROR       = 0x4,
+	HFI_RX_FLAGS_SYSTEM_ERROR       = 0x8,
+};
+
+#endif /* __H_HFI_PACKET_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_device.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_device.h
new file mode 100644
index 000000000000..790fcca6ac0a
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_device.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PROPERTIES_DEVICE_H__
+#define __H_HFI_PROPERTIES_DEVICE_H__
+
+/* Device-property range. */
+#define HFI_PROPERTY_DEVICE_BEGIN                                    0x00010000
+
+/* DCP hardware version. */
+#define HFI_PROPERTY_DEVICE_INIT_DCP_HW_VERSION                      0x00010001
+
+/* MDSS hardware version. */
+#define HFI_PROPERTY_DEVICE_INIT_MDSS_HW_VERSION                      0x00010002
+
+/* VIG layer indices; the high byte identifies the rectangle. */
+#define HFI_PROPERTY_DEVICE_INIT_VIG_INDICES                         0x00010004
+
+/* DMA layer indices; the high byte identifies the rectangle. */
+#define HFI_PROPERTY_DEVICE_INIT_DMA_INDICES                         0x00010005
+
+/* DCP firmware version. */
+#define HFI_PROPERTY_DEVICE_INIT_DCP_FW_VERSION                      0x00010003
+
+/* Maximum display count. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_DISPLAY_COUNT                   0x00010006
+
+/* Writeback block indices. */
+#define HFI_PROPERTY_DEVICE_INIT_WB_INDICES                          0x00010007
+
+/* Maximum linear writeback size: width [31:16], height [15:0]. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_WB_LINEAR_RESOLUTION            0x00010008
+
+/* Maximum UBWC writeback size: width [31:16], height [15:0]. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_WB_UBWC_RESOLUTION              0x00010009
+
+/* DSI interface indices. */
+#define HFI_PROPERTY_DEVICE_INIT_DSI_INDICES                         0x0001000a
+
+/* Maximum DSI size: width [31:16], height [15:0]. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_DSI_RESOLUTION                  0x0001000b
+
+/* DisplayPort interface indices. */
+#define HFI_PROPERTY_DEVICE_INIT_DP_INDICES                          0x0001000c
+
+/* Maximum DisplayPort size: width [31:16], height [15:0]. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_DP_RESOLUTION                   0x0001000d
+
+/* Downscaler indices. */
+#define HFI_PROPERTY_DEVICE_INIT_DS_INDICES                          0x0001000e
+
+/* Maximum downscaler size: width [31:16], height [15:0]. */
+#define HFI_PROPERTY_DEVICE_INIT_MAX_DS_RESOLUTION                   0x0001000f
+
+/* Core average-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_CORE_AB                                  0x00010010
+
+/* Core instantaneous-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_CORE_IB                                  0x00010011
+
+/* Core power-rail vote. */
+#define HFI_PROPERTY_DEVICE_CORE_POWER_RAIL                          0x00010012
+
+/* LLCC average-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_LLCC_AB                                  0x00010013
+
+/* LLCC instantaneous-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_LLCC_IB                                  0x00010014
+
+/* DRAM average-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_DRAM_AB                                  0x00010015
+
+/* DRAM instantaneous-bandwidth vote. */
+#define HFI_PROPERTY_DEVICE_DRAM_IB                                  0x00010016
+
+/* LSR writeback CSC indices. */
+#define HFI_PROPERTY_DEVICE_INIT_LSR_WB_CSC_INDICES                  0x00010017
+
+/* LSR writeback reprojection indices. */
+#define HFI_PROPERTY_DEVICE_INIT_LSR_WB_REPROJ_INDICES               0x00010018
+
+/* LSR writeback CSC layer indices. */
+#define HFI_PROPERTY_DEVICE_INIT_LSR_WB_CSC_LAYER_INDICES            0x00010019
+
+/* LSR writeback reprojection layer indices. */
+#define HFI_PROPERTY_DEVICE_INIT_LSR_WB_REPROJ_LAYER_INDICES         0x0001001a
+
+/* System-cache staling configuration. */
+#define HFI_PROPERTY_DEVICE_INIT_SYS_CACHE_STALING                   0x0001001b
+
+/* Active layers per display. */
+#define HFI_PROPERTY_DEVICE_INIT_ACTIVE_LAYERS                        0x0001001c
+
+/* Writeback DNSC support indices. */
+#define HFI_PROPERTY_DEVICE_INIT_WB_DNSC_SUPPORT_INDICES             0x0001001d
+
+/* End of device-property range. */
+#define HFI_PROPERTY_DEVICE_END                                      0x0001ffff
+
+#endif /* __H_HFI_PROPERTIES_DEVICE_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h
new file mode 100644
index 000000000000..34a4220393f4
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_display.h
@@ -0,0 +1,480 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PROPERTIES_DISPLAY_H__
+#define __H_HFI_PROPERTIES_DISPLAY_H__
+
+/* Display-property range. */
+#define HFI_PROPERTY_DISPLAY_BEGIN                                   0x00020000
+
+/* Whether DIM layer is supported. */
+#define HFI_PROPERTY_DISPLAY_HAS_DIM_LAYER                           0x00020001
+
+/* Whether Idle PC is supported. */
+#define HFI_PROPERTY_DISPLAY_HAS_IDLE_PC                             0x00020002
+
+/* Whether LM Noise is supported. */
+#define HFI_PROPERTY_DISPLAY_LM_NOISE                                0x00020003
+
+/* Noise layer version. */
+#define HFI_PROPERTY_DISPLAY_NOISE_VERSION                           0x00020004
+
+/* Whether dedicated CWB is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_DEDICATED_CWB                   0x00020005
+
+/* Whether CWB feature is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_CWB                             0x00020006
+
+/* Whether system cache is used for static display traffic. */
+#define HFI_PROPERTY_DISPLAY_SYS_CACHE_DISP                          0x00020007
+
+/* Whether trusted-display mode is supported. */
+#define HFI_PROPERTY_DISPLAY_FEATURE_TRUSTED_DISPLAY_MODE            0x00020008
+
+/* Whether UBWC Statistics is supported. */
+#define HFI_PROPERTY_DISPLAY_UBWC_STATS                              0x00020009
+
+/* Whether dynamic clock control is supported. */
+#define HFI_PROPERTY_DISPLAY_DYN_CLK_SUPPORT                         0x0002000a
+
+/* Whether qsync mode is supported. */
+#define HFI_PROPERTY_DISPLAY_QSYNC                                   0x0002000b
+
+/* Whether AVR Step is supported. */
+#define HFI_PROPERTY_DISPLAY_AVR_STEP                                0x0002000c
+
+/* Whether CWB Dither is supported. */
+#define HFI_PROPERTY_DISPLAY_WB_CWB_DITHER                           0x0002000d
+
+/* Whether system cache is used for writeback. */
+#define HFI_PROPERTY_DISPLAY_WB_SYS_CACHE_DISP                       0x0002000e
+
+/* Whether writeback supports linear rotation. */
+#define HFI_PROPERTY_DISPLAY_WB_LINEAR_ROTATION                      0x0002000f
+
+/* The extended power modes supported by the Display. */
+#define HFI_PROPERTY_DISPLAY_POWER_MODE                              0x00020010
+
+/* The DPU DRAM IB vote for DRAM(LLCC(SDE)->DDR) in Kbps. */
+#define HFI_PROPERTY_DISPLAY_DRAM_IB                                 0x00020011
+
+/* The DPU DRAM AB vote for DRAM(LLCC(SDE)->DDR) in Kbps. */
+#define HFI_PROPERTY_DISPLAY_DRAM_AB                                 0x00020012
+
+/* The DPU LLCC IB vote for LLCC(SDE_master_on_MNOC->LLCC). */
+#define HFI_PROPERTY_DISPLAY_LLCC_IB                                 0x00020013
+
+/* The DPU LLCC IB vote for LLCC(SDE_master_on_MNOC->LLCC). */
+#define HFI_PROPERTY_DISPLAY_LLCC_AB                                 0x00020014
+
+/* The DPU IB vote for MNOC(virt_master-> virt_slave(NOC)). */
+#define HFI_PROPERTY_DISPLAY_CORE_IB                                 0x00020015
+
+/* The DPU AB vote for MNOC(virt_master-> virt_slave(NOC)). */
+#define HFI_PROPERTY_DISPLAY_CORE_AB                                 0x00020016
+
+/* The Mdp core clock in hertz. */
+#define HFI_PROPERTY_DISPLAY_CORE_CLK                                0x00020017
+
+/* Associates a layer before its properties are programmed. */
+#define HFI_PROPERTY_DISPLAY_ATTACH_LAYER                            0x00020018
+
+/* Removes a layer from the display. */
+#define HFI_PROPERTY_DISPLAY_DETACH_LAYER                            0x00020019
+
+/* Commit sequence returned with frame-scan events. */
+#define HFI_PROPERTY_DISPLAY_SCAN_SEQUENCE_ID                        0x0002001a
+
+/* Enables or disables interface auto-refresh. */
+#define HFI_PROPERTY_DISPLAY_AUTOREFRESH_CFG                         0x0002001b
+
+/* Configure the HFI queue. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_HFI_CONFIG                       0x0002001c
+
+/* Reports scratch-memory size required by LSR writeback. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_NEEDS_SCRATCH_MEM            0x0002001d
+
+/* Configure the scratch memory. */
+#define HFI_PROPERTY_DISPLAY_SET_SCRATCH_MEM                         0x0002001e
+
+/* Configure the sync display. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_SYNC_TO                   0x0002001f
+
+/* Configure the LSR. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_CONFIG_MATRIX                0x00020020
+
+/* Configure. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_REPROJ_CONFIG_EXT                0x00020021
+
+/* Configure. */
+#define HFI_PROPERTY_DISPLAY_INPUT_FENCE                             0x00020022
+
+/* Provide a reusable fence. */
+#define HFI_PROPERTY_DISPLAY_REUSABLE_FENCE                          0x00020023
+
+/* Configure the HFI queue. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_CVP_BUFF                       0x00020025
+
+/* Configure the output buffers. */
+#define HFI_PROPERTY_DISPLAY_LSR_WB_OUT_BUFFERS                       0x00020026
+
+/* Configure the LSR. */
+#define HFI_PROPERTY_DISPLAY_LSR_MAPPED_HFI_BASE_ADDR                  0x00020027
+
+/* Configure the shared memory. */
+#define HFI_PROPERTY_DISPLAY_HRP_HFI_CONFIG                            0x00020028
+
+/* Attach output layer before. */
+#define HFI_PROPERTY_DISPLAY_ATTACH_OUTPUT_LAYER                     0x00020029
+
+/* Removes an output layer from the display. */
+#define HFI_PROPERTY_DISPLAY_DETACH_OUTPUT_LAYER                     0x0002002a
+
+/* Set destination ROI for display. */
+#define HFI_PROPERTY_DISPLAY_DEST_ROI                                0x0002002b
+
+/* Configures output fence. */
+#define HFI_PROPERTY_DISPLAY_OUTPUT_FENCE                            0x0002002c
+
+/* The dim layer parameters for display output. */
+#define HFI_PROPERTY_DISPLAY_DIM_LAYER                               0x0002002d
+
+/* The dim layer parameters for display output. */
+#define HFI_PROPERTY_DISPLAY_MISR_CONFIG                             0x0002002e
+
+/* QSYNC mode for video/command mode panels. */
+#define HFI_PROPERTY_DISPLAY_QSYNC_MODE                              0x0002002f
+
+/* Configure resource output. */
+#define HFI_PROPERTY_DISPLAY_SET_RESOURCE_DATA                       0x00020030
+
+/* Set VRR (Variable Refresh Rate). */
+#define HFI_PROPERTY_DISPLAY_VRR_FRAME_PARAMS                        0x00020031
+
+/* The Expected Preset Time which is used. */
+#define HFI_PROPERTY_DISPLAY_EPT                                     0x00020032
+
+/* This property sets line pointer offset time in nanoseconds. */
+#define HFI_PROPERTY_DISPLAY_VSYNC_OFFSET                            0x00020033
+
+/* Update the panel brightness level. */
+#define HFI_PROPERTY_DISPLAY_BRIGHTNESS                              0x00020034
+
+/* Set vsync source to watchdog. */
+#define HFI_PROPERTY_DISPLAY_CUSTOM_WD_TE                                   0x00020035
+
+/* Display color-property range. */
+#define HFI_PROPERTY_DISPLAY_COLOR_BEGIN                             0x00020100
+
+/* Setup 3D LUT. */
+#define HFI_PROPERTY_DISPLAY_COLOR_3D_LUT                            0x00020101
+
+/* Setup IGC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_IGC                               0x00020102
+
+/* Setup GC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_GC                                0x00020103
+
+/* Setup PCC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PCC                               0x00020104
+
+/* Setup PA HSIC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_HSIC                              0x00020105
+
+/* Setup PA MEMCOLOR SKIN. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_SKIN                     0x00020106
+
+/* Setup PA MEMCOLOR SKY. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_SKY                      0x00020107
+
+/* Setup PA MEMCOLOR FOLIAGE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_FOLIAGE                  0x00020108
+
+/* Setup PA MEMCOLOR PROTECTION. */
+#define HFI_PROPERTY_DISPLAY_COLOR_MEMCOLOR_PROT                     0x00020109
+
+/* Setup PA SIXZONE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SIXZONE                           0x0002010a
+
+/* Setup PA VLUT. */
+#define HFI_PROPERTY_DISPLAY_COLOR_VLUT                              0x0002010b
+
+/* Setup PPB DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DITHER                            0x0002010c
+
+/* Setup RC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RC                                0x0002010d
+
+/* Setup SPR_INIT config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_INIT                          0x0002010e
+
+/* Setup SPR_UDC config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_UDC                           0x0002010f
+
+/* Setup DSPP SPR DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_DITHER                        0x00020110
+
+/* Setup DSPP PA DITHER. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_DITHER                         0x00020111
+
+/* Setup Demura. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_CFG                        0x00020112
+
+/* Setup Demura tables. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_TABLE                      0x00020113
+
+/* Setup Demura backlight. */
+#define HFI_PROPERTY_DISPLAY_COLOR_DEMURA_BACKLIGHT                  0x00020114
+
+/* Setup destination scaler. */
+#define HFI_PROPERTY_DISPLAY_DEST_SCALER                             0x00020115
+
+/* Setup QRTC config. */
+#define HFI_PROPERTY_DISPLAY_COLOR_QRTC_CONFIG                       0x00020116
+
+/* Setup LTM initialization params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_INIT                          0x00020117
+
+/* Setup LTM configuration params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_CFG                           0x00020118
+
+/* Setup LTM noise threshold. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_NOISE_THRESH                  0x00020119
+
+/* Setup LTM histogram control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_HIST_CTRL                     0x0002011a
+
+/* Setup LTM VLUT table. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_VLUT                          0x0002011b
+
+/* Setup LTM initial params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_QUEUE_BUF                     0x0002011c
+
+/* Setup LTM initial params. */
+#define HFI_PROPERTY_DISPLAY_COLOR_LTM_CLEAR_BUFS                    0x0002011d
+
+/* Property to configure RGB hist control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_CTRL                   0x0002011e
+
+/* Property to queue RGB histogram. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_QUEUE_BUFFER           0x0002011f
+
+/* Property to clear all queued RGB. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RGB_HIST_CLEAR_BUFFERS          0x00020120
+
+/* Setup AI Scaler. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_AI_SCALER                    0x00020121
+
+/* Setup SSRC configuration. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_SSRC_CONFIG                  0x00020122
+
+/* Setup SSRC data. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_SSRC_DATA                    0x00020123
+
+/* Setup MDNIE. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE                        0x00020124
+
+/* Setup IPC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE_IPC                    0x00020125
+
+/* Setup ART. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_MDNIE_ART                    0x00020126
+
+/* Setup ABC. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_ABC                          0x00020127
+
+/* Setup RC for PU. */
+#define HFI_PROPERTY_DISPLAY_COLOR_RC_PU                             0x00020128
+
+/* Property to configure PA hist control. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_CTRL                      0x00020129
+
+/* Property to queue PA histogram. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_QUEUE_BUFFER              0x0002012a
+
+/* Property to clear all queued PA. */
+#define HFI_PROPERTY_DISPLAY_COLOR_PA_HIST_CLEAR_BUFFERS             0x0002012b
+
+/* Property to setup SPR partial update. */
+#define HFI_PROPERTY_DISPLAY_COLOR_SPR_PU                            0x0002012c
+
+/* Property to setup SPR partial update. */
+#define HFI_PROPERTY_DISPLAY_COLOR_AIQE_COPR                          0x0002012d
+
+/* End of display color properties. */
+#define HFI_PROPERTY_DISPLAY_COLOR_END                               0x000201ff
+
+/* End of display-property range. */
+#define HFI_PROPERTY_DISPLAY_END                                     0x0002ffff
+
+/* Layer-property range. */
+#define HFI_PROPERTY_LAYER_BEGIN                                     0x00030000
+
+/* Whether layer decimation is supported. */
+#define HFI_PROPERTY_LAYER_FEATURE_DECIMATION                        0x00030001
+
+/* Blend operations set by Host. */
+#define HFI_PROPERTY_LAYER_BLEND_TYPE                                0x00030002
+
+/* Blending alpha of the plane. */
+#define HFI_PROPERTY_LAYER_ALPHA                                     0x00030003
+
+/* Z-order of the plane. */
+#define HFI_PROPERTY_LAYER_ZPOS                                      0x00030004
+
+/* Source ROI per layer. */
+#define HFI_PROPERTY_LAYER_SRC_ROI                                   0x00030005
+
+/* Destination ROI per layer. */
+#define HFI_PROPERTY_LAYER_DEST_ROI                                  0x00030006
+
+/* Configures blend roi. */
+#define HFI_PROPERTY_LAYER_BLEND_ROI                                 0x00030007
+
+/* Total Image Height. */
+#define HFI_PROPERTY_LAYER_SRC_IMG_SIZE_H                            0x00030008
+
+/* Total Image Width. */
+#define HFI_PROPERTY_LAYER_SRC_IMG_SIZE_W                            0x00030009
+
+/* SMMU mapped source Image start address. */
+#define HFI_PROPERTY_LAYER_SRC_ADDR                                  0x0003000a
+
+/* Source Format Configuration for each layer. */
+#define HFI_PROPERTY_LAYER_SRC_FORMAT                                0x0003000b
+
+/* Stride for each layer. */
+#define HFI_PROPERTY_LAYER_STRIDE                                    0x0003000c
+
+/* Multi rectangle fetch modes. */
+#define HFI_PROPERTY_LAYER_MULTIRECT_MODE                            0x0003000d
+
+/* Blending background alpha of the plane. */
+#define HFI_PROPERTY_LAYER_BG_ALPHA                                  0x0003000e
+
+/* Source Region of Interest (ROI). */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_ROI                            0x0003000f
+
+/* Destination Region of Interest(ROI). */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_ROI                            0x00030010
+
+/* Total image height of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_IMG_SIZE_H                      0x00030011
+
+/* Total image width of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SRC_IMG_SIZE_W                      0x00030012
+
+/* SMMU mapped start address. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_ADDR                            0x00030013
+
+/* Destination Format Configuration of output buffer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DST_FORMAT                         0x00030014
+
+/* Stride for each layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_STRIDE                             0x00030015
+
+/* Rotation for each layer. */
+#define HFI_PROPERTY_LAYER_ROTATION                                  0x00030016
+
+/* Security policy settings applied. */
+#define HFI_PROPERTY_LAYER_SECURITY_POLICY                           0x00030017
+
+/* The LSR alpha buffer properties of the input layer. */
+#define HFI_PROPERTY_LAYER_LSR_IN_A_BUFFER                           0x00030018
+
+/* The LSR Reprojection layer's plane equation. */
+#define HFI_PROPERTY_LAYER_LSR_REPROJ_PLANE_EQ                       0x0003001a
+
+/* The layer's gamma type. */
+#define HFI_PROPERTY_LAYER_GAMMA                                     0x0003001b
+
+/* The LSR layer's local/remote/other type. */
+#define HFI_PROPERTY_LAYER_LSR_LAYER_TYPE                            0x0003001c
+
+/* The LSR layer's lock type. */
+#define HFI_PROPERTY_LAYER_LSR_LOCK_TYPE                             0x0003001d
+
+/* Sets the LSR reprojection render pose. */
+#define HFI_PROPERTY_LAYER_LSR_RENDER_POSE                           0x0003001e
+
+/* The LSR render frustum properties of the layer. */
+#define HFI_PROPERTY_LAYER_LSR_RENDER_FRUSTUM                        0x0003001f
+
+/* Custom buffers for this layer. */
+#define HFI_PROPERTY_LAYER_LSR_X_BUFFER                              0x00030020
+
+/* The LSR Reprojection pose properties of the layer. */
+#define HFI_PROPERTY_LAYER_LSR_REPROJ_POSE                           0x00030021
+
+/* Source image size of each layer in bytes. */
+#define HFI_PROPERTY_LAYER_SRC_IMAGE_SIZE                           0x00030022
+
+/* Rotation for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_ROTATION                           0x00030023
+
+/* Sys cache related attributes for each layer. */
+#define HFI_PROPERTY_LAYER_CACHE_ATTR                                0x00030024
+
+/* LLCC scid of the system cache to be used. */
+#define HFI_PROPERTY_LAYER_LLCC_SCID                                 0x00030025
+
+/* Sets system-cache attributes for the output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_CACHE_ATTR                         0x00030026
+
+/* LLCC scid of the system cache to be used. */
+#define HFI_PROPERTY_OUTPUT_LAYER_LLCC_SCID                          0x00030027
+
+/* The CWB tap point for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_CWB_TAP_POINT                      0x00030028
+
+/* Configure downscale blur. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DNSC_BLUR_CFG                      0x00030029
+
+/* Source exclusion rectangle region. */
+#define HFI_PROPERTY_LAYER_EXCLUSION_RECTANGLE_ROI                   0x0003002a
+
+/* Configure downscale. */
+#define HFI_PROPERTY_OUTPUT_LAYER_DNSC_CFG                           0x0003002b
+
+/* The security policy for output layer. */
+#define HFI_PROPERTY_OUTPUT_LAYER_SECURITY_POLICY                    0x00030031
+
+/* Sets the disparity-layer injection interval. */
+#define HFI_PROPERTY_LAYER_LSR_DISPARITY_PHASE                     0x00030032
+
+/* Layer color-property range. */
+#define HFI_PROPERTY_LAYER_COLOR_BEGIN                               0x00030100
+
+/* Setup VIG GAMUT. */
+#define HFI_PROPERTY_LAYER_COLOR_3D_LUT                              0x00030101
+
+/* Setup UCSC IGC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_IGC                            0x00030102
+
+/* Setup UCSC UNMULT. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_UNMULT                         0x00030103
+
+/* Setup UCSC GC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_GC                             0x00030104
+
+/* Setup UCSC ALPHA DITHER. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_ALPHA_DITHER                   0x00030105
+
+/* Setup UCSC CSC. */
+#define HFI_PROPERTY_LAYER_COLOR_UCSC_CSC                            0x00030106
+
+/* Setup CSC. */
+#define HFI_PROPERTY_LAYER_COLOR_CSC                                 0x00030107
+
+/* Setup VIG scaler. */
+#define HFI_PROPERTY_LAYER_COLOR_SCALER                              0x00030108
+
+/* End of layer color properties. */
+#define HFI_PROPERTY_LAYER_COLOR_END                                 0x000301ff
+
+/* End of layer-property range. */
+#define HFI_PROPERTY_LAYER_END                                       0x0003ffff
+
+#endif /* __H_HFI_PROPERTIES_DISPLAY_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h
new file mode 100644
index 000000000000..53c7789239a6
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_properties_panel.h
@@ -0,0 +1,198 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_PROPERTIES_PANEL_H__
+#define __H_HFI_PROPERTIES_PANEL_H__
+
+/* Panel-property range. */
+#define HFI_PROPERTY_PANEL_BEGIN                                     0x00040000
+
+/* Sets the total number of timing modes available for the panel. */
+#define HFI_PROPERTY_PANEL_TIMING_MODE_COUNT                         0x00040001
+
+/* Sets the index of the timing mode. */
+
+#define HFI_PROPERTY_PANEL_INDEX                                     0x00040002
+/* Sets the panel clock speed in Hz. */
+#define HFI_PROPERTY_PANEL_CLOCKRATE                                 0x00040003
+
+/* Sets the frame rate for the panel. */
+#define HFI_PROPERTY_PANEL_FRAMERATE                                 0x00040004
+
+/* Sets active dimensions, porches, pulse width, and sync skew. */
+#define HFI_PROPERTY_PANEL_RESOLUTION_DATA                           0x00040005
+
+/* Sets jitter as a numerator/denominator pair for early wakeup. */
+#define HFI_PROPERTY_PANEL_JITTER                                    0x00040006
+
+/* Sets all the compression data for VDC / DSC. */
+#define HFI_PROPERTY_PANEL_COMPRESSION_DATA                          0x00040007
+
+/* Lists available display topologies. */
+#define HFI_PROPERTY_PANEL_DISPLAY_TOPOLOGY                          0x00040008
+
+/* Sets the default topology index. */
+#define HFI_PROPERTY_PANEL_DEFAULT_TOPOLOGY_INDEX                    0x00040009
+
+/* Panel name available for current timing mode. */
+#define HFI_PROPERTY_PANEL_NAME                                      0x0004000a
+
+/* Specifies the type of the panel, OLED / LCD. */
+#define HFI_PROPERTY_PANEL_PHYSICAL_TYPE                             0x0004000b
+
+/* Sets the panel bits per pixel. */
+#define HFI_PROPERTY_PANEL_BPP                                       0x0004000c
+
+/* Enables or disables each DSI data lane. */
+#define HFI_PROPERTY_PANEL_LANES_STATE                               0x0004000d
+
+/* Specifies the panel lane map. */
+#define HFI_PROPERTY_PANEL_LANE_MAP                                  0x0004000e
+
+/* Specifies the R, G and B channel ordering. */
+#define HFI_PROPERTY_PANEL_COLOR_ORDER                               0x0004000f
+
+/* Specifies the trigger mechanism to be used for DMA path. */
+#define HFI_PROPERTY_PANEL_DMA_TRIGGER                               0x00040010
+
+/* Property used to enable appending end of transmission packets. */
+#define HFI_PROPERTY_PANEL_TX_EOT_APPEND                             0x00040011
+
+/* Selects the DSI lane state at BLLP end-of-frame. */
+#define HFI_PROPERTY_PANEL_BLLP_EOF_POWER_MODE                       0x00040012
+
+/* Selects the DSI lane state during BLLP. */
+#define HFI_PROPERTY_PANEL_BLLP_POWER_MODE                           0x00040013
+
+/* Specifies the panel traffic mode. */
+#define HFI_PROPERTY_PANEL_TRAFFIC_MODE                              0x00040014
+
+/* Specifies the virtual channel identifier. */
+#define HFI_PROPERTY_PANEL_VIRTUAL_CHANNEL_ID                        0x00040015
+
+/* DCS command for write_memory_start. */
+#define HFI_PROPERTY_PANEL_WR_MEM_START                              0x00040016
+
+/* DCS command for write_memory_continue. */
+#define HFI_PROPERTY_PANEL_WR_MEM_CONTINUE                           0x00040017
+
+/* Inserts the DCS command. */
+#define HFI_PROPERTY_PANEL_TE_DCS_COMMAND                            0x00040018
+
+/* Specifies the panel operating mode. */
+#define HFI_PROPERTY_PANEL_OPERATING_MODE                            0x00040019
+
+/* Specifies the min backlight level supported by the panel. */
+#define HFI_PROPERTY_PANEL_BL_MIN_LEVEL                              0x0004001a
+
+/* Specifies the max backlight level supported by the panel. */
+#define HFI_PROPERTY_PANEL_BL_MAX_LEVEL                              0x0004001b
+
+/* Specifies the max brightness level supported. */
+#define HFI_PROPERTY_PANEL_BRIGHTNESS_MAX_LEVEL                      0x0004001c
+
+/* Specifies the DSI controllers to use for primary panel. */
+#define HFI_PROPERTY_PANEL_CTRL_NUM                                  0x0004001d
+
+/* Specifies the DSI PHYs to use for primary panel. */
+#define HFI_PROPERTY_PANEL_PHY_NUM                                   0x0004001e
+
+/* An array that lists the sequence of reset GPIO values and sleeps. */
+#define HFI_PROPERTY_PANEL_RESET_SEQUENCE                            0x0004001f
+
+/* Specifies the implementation of backlight control for this panel. */
+#define HFI_PROPERTY_PANEL_BL_PMIC_CONTROL_TYPE                      0x00040020
+
+/* Specifies the implementation of backlight control for secondary panel. */
+#define HFI_PROPERTY_PANEL_SEC_BL_PMIC_CONTROL_TYPE                  0x00040021
+
+/* Specifies whether to invert the display brightness value. */
+#define HFI_PROPERTY_PANEL_BL_INVERTED_DBV                           0x00040022
+
+/* Sets DCS command buffer data for different types of DCS commands. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_INFO                              0x00040024
+
+/* Provides iova of DPU Mapped buffer of HW understandable panel commands. */
+#define HFI_PROPERTY_PANEL_DPU_ADDRESS                              0x00040025
+
+/* Provides dva of DCP Mapped buffer of structures of cmd descriptions. */
+#define HFI_PROPERTY_PANEL_DCP_ADDRESS                              0x00040026
+
+/* Provides D-PHY timing parameters. */
+#define HFI_PROPERTY_PANEL_DPHY_TIMINGS                              0x00040027
+
+/* Entry to select vsync source from GPIO's/Watchdog timer. */
+#define HFI_PROPERTY_PANEL_VSYNC_SOURCE                              0x00040028
+
+/* Selects the pixel-stream trigger for command mode. */
+#define HFI_PROPERTY_PANEL_STREAM_TRIGGER                            0x00040029
+
+/* Specifies the TE Path for command mode panels. */
+#define HFI_PROPERTY_PANEL_TE_MODE                                   0x0004002a
+
+/* Reports whether the panel uses C-PHY. */
+#define HFI_PROPERTY_PANEL_CPHY_MODE                                 0x0004002b
+
+/* Provides the shared DCP address for DCS command DMA. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_DVA                        0x0004002c
+
+/* Provides the shared DPU address for DCS command DMA. */
+#define HFI_PROPERTY_PANEL_DCS_CMD_TX_BUF_IOVA                       0x0004002d
+
+/* Sets the compression rate control override value for the panel. */
+#define HFI_PROPERTY_PANEL_COMPRESSION_RC_OVERRIDE                   0x0004002e
+
+/* Selects the line that triggers DSI command DMA. */
+#define HFI_PROPERTY_PANEL_DMA_SCHEDULE_LINE                         0x0004002f
+
+/* Provides the panel ESD config data required for ESD status check to the DCP. */
+#define HFI_PROPERTY_PANEL_ESD_CONFIG                                0x00040030
+
+/* Specifies the QSYNC parameters of the panel. */
+#define HFI_PROPERTY_PANEL_QSYNC_PARAMS                              0x00040031
+
+/* Provides esync properties for VHM panel. */
+#define HFI_PROPERTY_PANEL_ESYNC_CAPS				     0x00040032
+
+/* Specifies the DFPS capabilities supported by the panel. */
+#define HFI_PROPERTY_PANEL_DFPS_CAPS                                 0x00040033
+
+/* Specifies the frequency stepping pattern of the panel. */
+#define HFI_PROPERTY_PANEL_FREQ_PATTERN				     0x00040034
+
+/* Specifies whether panel requires LP11_INIT mode. */
+#define HFI_PROPERTY_PANEL_LP11_INIT                                 0x00040035
+
+/* Specifies the width of the DMA scheduling window, expressed in number of display lines. */
+#define HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW                       0x00040036
+
+/* Provides DSI bit clock frequencies for dynamic refresh. */
+#define HFI_PROPERTY_PANEL_DYN_REF_CLK_FREQS                         0x00040038
+
+/* Reports supported operating-mode switches. */
+#define HFI_PROPERTY_PANEL_OPERATING_SWITCH_CAPABILITY               0x00040039
+
+/* Selects the display type and priority. */
+#define HFI_PROPERTY_PANEL_DISPLAY_TYPE                              0x0004003a
+
+/* Specifies whether ULPS (Ultra Low Power State) is supported by the panel. */
+#define HFI_PROPERTY_PANEL_ULPS_SUPPORTED                            0x0004003b
+
+/* Specifies the DSI custom command set start index and count. */
+#define HFI_PROPERTY_PANEL_DSI_CUSTOM_DCS_CMDS_SET_INFO              0x00040040
+
+/* Provides per-mode esync timing capabilities for VHM panel. */
+#define HFI_PROPERTY_PANEL_ESYNC_TIMING_CAPS                         0x00040041
+
+/* Provides per-mode qsync timing parameters for panels supporting QSYNC/AVR. */
+#define HFI_PROPERTY_PANEL_QSYNC_TIMING_PARAMS                       0x00040042
+
+/* Specifies the current display format being used by the panel. */
+#define HFI_PROPERTY_PANEL_COLOR_FORMAT                              0x00040043
+
+/* End of panel-property range. */
+#define HFI_PROPERTY_PANEL_END                                       0x0004ffff
+
+#endif /* __H_HFI_PROPERTIES_PANEL_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c b/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c
new file mode 100644
index 000000000000..1a06c3937bda
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "hfi_unpacker.h"
+
+static int hfi_sanitize_cmd_buff(struct hfi_header *hdr)
+{
+	struct hfi_packet *packet;
+	u32 packet_size, total_pkt_size = sizeof(*hdr);
+	u32 hdr_size = GET_HEADER_SIZE(hdr->cmd_buff_info);
+	int i;
+
+	if (hdr_size < sizeof(*hdr) + sizeof(*packet) || !hdr->num_packets)
+		return -EINVAL;
+
+	packet = hfi_packet_first(hdr);
+	for (i = 0; i < hdr->num_packets; i++) {
+		if (total_pkt_size > hdr_size - sizeof(*packet))
+			return -EINVAL;
+
+		packet_size = GET_PACKET_SIZE(packet->payload_info);
+		if (packet_size < sizeof(*packet) ||
+		    packet_size > hdr_size - total_pkt_size)
+			return -EINVAL;
+
+		total_pkt_size += packet_size;
+		packet = hfi_packet_next(packet);
+	}
+
+	return hdr_size == total_pkt_size ? 0 : -EINVAL;
+}
+
+static struct hfi_packet *hfi_packet_at(struct hfi_header *hdr, u32 packet_num)
+{
+	struct hfi_packet *packet = hfi_packet_first(hdr);
+
+	while (--packet_num)
+		packet = hfi_packet_next(packet);
+
+	return packet;
+}
+
+int hfi_unpacker_get_header_info(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				 struct hfi_header_info *header_info)
+{
+	struct hfi_header *hdr;
+	u32 hdr_size;
+
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !header_info)
+		return -EINVAL;
+
+	hdr = cmd_buf_hdl->cmd_buffer;
+	hdr_size = GET_HEADER_SIZE(hdr->cmd_buff_info);
+	if (hdr_size < sizeof(*hdr) || hdr_size > cmd_buf_hdl->size)
+		return -EINVAL;
+
+	header_info->num_packets = hdr->num_packets;
+	header_info->cmd_buff_type = GET_HEADER_CMD_BUFF_TYPE(hdr->cmd_buff_info);
+	header_info->object_id = hdr->object_id;
+	header_info->header_id = hdr->header_id;
+
+	return 0;
+}
+
+int hfi_unpacker_get_packet_info(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				 u32 packet_num,
+					 struct hfi_packet_info *packet_info)
+{
+	struct hfi_header *hdr;
+	struct hfi_packet *packet;
+	u32 packet_size;
+
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !packet_info ||
+	    !packet_num)
+		return -EINVAL;
+
+	hdr = cmd_buf_hdl->cmd_buffer;
+	if (GET_HEADER_SIZE(hdr->cmd_buff_info) > cmd_buf_hdl->size ||
+	    packet_num > hdr->num_packets || hfi_sanitize_cmd_buff(hdr))
+		return -EINVAL;
+
+	packet = hfi_packet_at(hdr, packet_num);
+	packet_size = GET_PACKET_SIZE(packet->payload_info);
+	packet_info->cmd = packet->cmd;
+	packet_info->flags = packet->flags;
+	packet_info->id = packet->id;
+	packet_info->packet_id = packet->packet_id;
+	packet_info->payload_type = GET_PACKET_PAYLOAD_TYPE(packet->payload_info);
+	packet_info->payload_size = packet_size - sizeof(*packet);
+	packet_info->payload_ptr = packet_info->payload_size ?
+		(void *)(packet + 1) : NULL;
+
+	return 0;
+}
+
+int hfi_unpacker_get_kv_pairs_count(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				    struct hfi_packet_info *packet_info,
+					    u32 kv_payload_offset, u32 *num_props)
+{
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !packet_info ||
+	    !packet_info->payload_ptr || !num_props ||
+	    kv_payload_offset > packet_info->payload_size ||
+	    !IS_ALIGNED(kv_payload_offset, sizeof(u32)) ||
+	    packet_info->payload_size - kv_payload_offset < sizeof(u32))
+		return -EINVAL;
+
+	*num_props = *(u32 *)((u8 *)packet_info->payload_ptr + kv_payload_offset);
+
+	return 0;
+}
+
+int hfi_unpacker_get_kv_pairs(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			      struct hfi_packet_info *packet_info,
+				      u32 kv_payload_offset, u32 num_props,
+				      struct hfi_kv_info *kv_pairs)
+{
+	u32 *kv_pairs_counter_idx, *kv_pairs_key;
+	u32 value_size, consumed;
+	int i;
+
+	if (!cmd_buf_hdl || !cmd_buf_hdl->cmd_buffer || !packet_info ||
+	    !packet_info->payload_ptr || !kv_pairs ||
+	    kv_payload_offset > packet_info->payload_size ||
+	    !IS_ALIGNED(kv_payload_offset, sizeof(u32)) ||
+	    packet_info->payload_size - kv_payload_offset < sizeof(u32))
+		return -EINVAL;
+
+	kv_pairs_counter_idx = (u32 *)((u8 *)packet_info->payload_ptr +
+		kv_payload_offset);
+	if (*kv_pairs_counter_idx != num_props)
+		return -EINVAL;
+
+	consumed = sizeof(u32);
+	for (i = 0; i < num_props; i++) {
+		u32 remaining;
+
+		if (consumed > packet_info->payload_size - kv_payload_offset ||
+		    packet_info->payload_size - kv_payload_offset - consumed <
+		    sizeof(u32))
+			return -EINVAL;
+
+		kv_pairs_key = (u32 *)((u8 *)kv_pairs_counter_idx + consumed);
+		value_size = (*kv_pairs_key & 0xff000000) >> 24;
+		remaining = packet_info->payload_size - kv_payload_offset -
+			consumed - sizeof(u32);
+		if (value_size > remaining / sizeof(u32))
+			return -EINVAL;
+
+		kv_pairs[i].key = *kv_pairs_key;
+		kv_pairs[i].value_ptr = kv_pairs_key + 1;
+		consumed += sizeof(u32) * (1 + value_size);
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h
new file mode 100644
index 000000000000..9f893d4ad47c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __H_HFI_UNPACKER_H__
+#define __H_HFI_UNPACKER_H__
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+#include "hfi_pack_unpack_common.h"
+
+/* Extract the property ID, version, and value size from a key. */
+#define HFI_UNPACK_KEY(key, property_id, version, size) \
+	do { \
+		typeof(key) __key = (key); \
+		(property_id) = __key & 0x000fffff; \
+		(version) = (__key & 0x00f00000) >> 20; \
+		(size) = (__key & 0xff000000) >> 24; \
+	} while (0)
+
+/**
+ * hfi_unpacker_get_header_info() - Parse the command-buffer header.
+ * @cmd_buf_hdl: Command buffer to inspect.
+ * @header_info: Receives the decoded header information.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_unpacker_get_header_info(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				 struct hfi_header_info *header_info);
+
+/**
+ * hfi_unpacker_get_packet_info() - Parse one packet in a command buffer.
+ * @cmd_buf_hdl: Command buffer to inspect.
+ * @packet_num: One-based packet index.
+ * @packet_info: Receives the decoded packet information.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_unpacker_get_packet_info(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				 u32 packet_num, struct hfi_packet_info *packet_info);
+
+/**
+ * hfi_unpacker_get_kv_pairs_count() - Count properties in a packet payload.
+ * @cmd_buf_hdl: Command buffer to inspect.
+ * @packet_info: Packet information returned by hfi_unpacker_get_packet_info().
+ * @kv_payload_offset: Byte offset where key/value pairs begin.
+ * @num_props: Receives the property count.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_unpacker_get_kv_pairs_count(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+				    struct hfi_packet_info *packet_info,
+				    u32 kv_payload_offset, u32 *num_props);
+
+/**
+ * hfi_unpacker_get_kv_pairs() - Decode properties from a packet payload.
+ * @cmd_buf_hdl: Command buffer to inspect.
+ * @packet_info: Packet information returned by hfi_unpacker_get_packet_info().
+ * @kv_payload_offset: Byte offset where key/value pairs begin.
+ * @num_props: Number of properties to decode.
+ * @kv_pairs: Receives the decoded property entries.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_unpacker_get_kv_pairs(struct hfi_cmd_buff_hdl *cmd_buf_hdl,
+			      struct hfi_packet_info *packet_info,
+			      u32 kv_payload_offset, u32 num_props,
+			      struct hfi_kv_info *kv_pairs);
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+#endif /* __H_HFI_UNPACKER_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c b/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c
new file mode 100644
index 000000000000..87ea51132bb8
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "hfi_utils.h"
+/**
+ * hfi_util_kv_parser_init() - Initialize a key/value parser.
+ * @kv_parser: Parser state to initialize.
+ * @bytes: Payload size in bytes; must be u32-aligned.
+ * @payload: u32 payload buffer to parse.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_util_kv_parser_init(struct hfi_util_kv_parser *kv_parser,
+			    u32 bytes, u32 *payload)
+{
+	if (!kv_parser || !payload || bytes > HFI_UTIL_MAX_ALLOC)
+		return -EINVAL;
+
+	if (bytes % sizeof(u32))
+		return -EINVAL;
+
+	kv_parser->max_index  = bytes / sizeof(u32);
+	kv_parser->cur_offset = 0;
+	kv_parser->payload    = payload;
+
+	return 0;
+}
+
+/**
+ * hfi_util_kv_parser_get_next() - Read the next property from the payload.
+ * @kv_parser: Parser state, updated in place.
+ * @move: Number of u32 words occupied by the previous value.
+ * @hfi_prop: Receives the packed property key, or zero at end of input.
+ * @payload: Receives the property value pointer, or NULL at end of input.
+ * @max_words: Receives the available value length in u32 words.
+ *
+ * Return: 0 on success or end of input, or a negative errno.
+ */
+int hfi_util_kv_parser_get_next(struct hfi_util_kv_parser *kv_parser,
+				u32 move, u32 *hfi_prop,
+				 u32 **payload, u32 *max_words)
+{
+	if (!kv_parser || !payload || !hfi_prop || !max_words)
+		return -EINVAL;
+
+	if (kv_parser->cur_offset > kv_parser->max_index ||
+	    move > kv_parser->max_index - kv_parser->cur_offset)
+		return -EINVAL;
+
+	kv_parser->cur_offset += move;
+	*hfi_prop  = 0;
+	*payload   = NULL;
+	*max_words = 0;
+
+	/* End of payload is a valid result. */
+	if (kv_parser->cur_offset == kv_parser->max_index)
+		return 0;
+
+	if (kv_parser->cur_offset > kv_parser->max_index)
+		return -EINVAL;
+
+	if ((kv_parser->max_index - kv_parser->cur_offset) < 2)
+		return -EINVAL;
+
+	*hfi_prop  = kv_parser->payload[kv_parser->cur_offset++];
+	*payload   = &kv_parser->payload[kv_parser->cur_offset];
+	*max_words = kv_parser->max_index - kv_parser->cur_offset;
+	if (HFI_PROP_SZ(*hfi_prop) && HFI_PROP_SZ(*hfi_prop) > *max_words)
+		return -EINVAL;
+	if (HFI_PROP_SZ(*hfi_prop))
+		*max_words = HFI_PROP_SZ(*hfi_prop);
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h b/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h
new file mode 100644
index 000000000000..61fdc483ad47
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _HFI_UTILS_H_
+#define _HFI_UTILS_H_
+
+#include <linux/types.h>
+
+#define HFI_UTIL_MAX_ALLOC   4096
+#define HFI_PROP_ID(val)    ((val) & 0xfffff)
+#define HFI_PROP_SZ(val)    ((val) >> 24)
+#define HFI_VAL_L32(val)    ((val) & 0xffffffff)
+#define HFI_VAL_H32(val)    ((val) >> 32)
+
+/* Encode the major and minor feature versions in a property ID. */
+#define HFI_UTIL_PACK_VERSION(major, minor, prop_id) \
+	(((prop_id) & ~(0xf0f000)) | (((minor) & 0xf) << 20) | (((major) & 0xf) << 12))
+
+/**
+ * struct hfi_util_kv_parser - State for iterating key/value properties.
+ * @max_index: Number of u32 words available in @payload.
+ * @cur_offset: Current u32 offset.
+ * @payload: Property payload buffer.
+ */
+struct hfi_util_kv_parser {
+	u32 max_index;
+	u32 cur_offset;
+	u32 *payload;
+};
+
+/**
+ * hfi_util_kv_parser_init() - Initialize a key/value parser.
+ * @kv_parser: Parser state to initialize.
+ * @bytes: Payload size in bytes; must be u32-aligned.
+ * @payload: u32 payload buffer to parse.
+ *
+ * Return: 0 on success, or a negative errno.
+ */
+int hfi_util_kv_parser_init(struct hfi_util_kv_parser *kv_parser, u32 bytes, u32 *payload);
+
+/**
+ * hfi_util_kv_parser_get_next() - Read the next property from the payload.
+ * @kv_parser: Parser state, updated in place.
+ * @move: Number of u32 words occupied by the previous value.
+ * @hfi_prop: Receives the packed property key, or zero at end of input.
+ * @payload: Receives the property value pointer, or NULL at end of input.
+ * @max_words: Receives the available value length in u32 words.
+ *
+ * Return: 0 on success or end of input, or a negative errno.
+ */
+int hfi_util_kv_parser_get_next(struct hfi_util_kv_parser *kv_parser, u32 move,
+				u32 *hfi_prop, u32 **payload, u32 *max_words);
+
+#endif /* _HFI_UTILS_H_ */

-- 
2.43.0

