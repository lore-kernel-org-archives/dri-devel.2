Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422F606A687
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AR4LaBJQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KQNftcIH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4335610F640;
	Thu, 26 Nov 2026 06:29:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E75010F67D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36Vrg2175838
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3x+nzUgZFQT1swxE+cP9a5IJRqL+LfoRDq7BieNofBU=; b=AR4LaBJQN9cDyBv6
 RKP0y3FpPhhxF0d4iuPwJb1RBU1auVjH148ltowVaiD5zH4zOlwZSeGWEjY1HqkI
 T+bhU88gwhb3/Ky7+3NFhpRDuoHnpKNpkvhDwsth2/h20eO6jVTS0NZ5pUeF2ykY
 U6Q83YMNywirGTSfjuUHRqTmEXdzWjIB3x+NbxTyOCulr00ejriqaCHDHOimaW+v
 kGQlwftOSNI0fXXVH5Ueu+lgxn6UDLlyDB95W8Foe9+g8zbdZJuWh1kW1DORPs5B
 iTmH40xqaJ2IKD8qXHjLq8H5zInYiXMnhdB8+cUDxJfPf/BeUsZ0XENyOcmh0TNx
 i8TiwA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhva7t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:45 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2f040c6e0ceso63064155ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674584; x=1796279384;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3x+nzUgZFQT1swxE+cP9a5IJRqL+LfoRDq7BieNofBU=;
 b=KQNftcIHI25in/GBYbJ608J0mZMyh13QTHlJP2QQwiFmxQs6cDmy0PwpXle7J4NEGC
 KFosMmvGIwQ8z3+g8CzlBZ8Dj9gMhIpZNCmckWpE4FgFXdEvt9f9w/09HNWUuQZ/1qiS
 SOEfK/H+aRAbHvEuQpdEcRYh2X3sJ9Nb+J0K8l6wcMuStSfTvCspEre81/ax703piZuJ
 CRWM2oUM3dp9mPnCYQIro9Z1iqlEm3jHS6LkvxOf4TO98l29SWCoIbNwSs9DX5T60+zh
 R+bEci2MyDavqiFbaMxORH/OyaTIo24iJfvOXaqj/9c4bJdxvMTyi4kZrmbl5ojFcpv+
 Rlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674584; x=1796279384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3x+nzUgZFQT1swxE+cP9a5IJRqL+LfoRDq7BieNofBU=;
 b=N8NjNpb+IdsL4mn4DAkf9vp+jFjfTQV0lXRgoELzlqkWYmuQop1M2foKGs2KtAenCj
 sa762+I8uIgcobuBHxuD++QnaCodMFWRkX16EWFMyegYbgx34Qkxj9icqLcnY58mj0GK
 dq/BjtZwf4gy4dX/HcQGvsCNWOOmynU8gV3rbYnV2J+kmdLqgqgyKxjQkAfQrJGA3GX6
 BGqWjcC7Yqjp0tKWN3zm0AowPEFOdmk4xCAAwV8J0biOyuRcLDJqS0T1PY92Houz37f2
 U5sqzPbUrfrusgY+2bPfFxC8vvc3bxc8bTZ6zxfT3eqOUhkfRIfqPwNdWLd5tztjnOlD
 BlMg==
X-Forwarded-Encrypted: i=1;
 AL+hErH/1Ip+quq0MPqJKGRdjz8PEhOrdeuATpScL6x20d4O1dUthJ0q7ym6qiFUrXTTUCNpOBkVPhHO3uU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9LxlxZcYvpIhBgErT4DdG7f4RzczZOCb3t1alJUCOz1qXtcg6I
 XFPnZvNDeqnoEVnjt6RJvGzpVY201aRxtcj+yYXX2BFIqFw2AK5GSLQodZnOt9rJtsXoUFMRyAA
 DINgF79MHjAt9Wfg69IBlLqawVm7fxUmLAOCclocJzVjyooTqHnw1tAz0uA9lNJ+M9RW8TXg=
X-Gm-Gg: AZFdTZc0WJJtGZ+amOJC3//7vLzYEp8PqZpuzNrRVBv4UecsDlidVH5EXr80GOEGamN
 er5VJX7gcYIwVz7QoNr4Ed/pmo11PYM9J5WEMMrVfHQHLCJOXrIEl9/OJ0Kg+PtJ6knVqRMss7v
 rLqobnsaNmX+g2hY3kvYXd+NER3QSsMSntj0iNh0MO2NTeGaJIpkvT8vR9kPhf1okI9vnviQbkK
 /0ViFOLF23n89ozXp/plyA5LoXTb1tQsc8fszSXwyS+u5FAxOqFE7eMlCadA6SjIy7KaBAecbaU
 IDmbIgeiAB7Oz078vCJrmZqHhqTw7+ciXbQci9qXzdzMxp1mYfrJPYtMEBP6r5rem5I3+0JMuR8
 JPDT8aYHmIWs/rtB2XijKLRNJaKJnFgq0O1YxigFbNkuDuf+oIAAO0vIZauyLDD2nLw8wclizer
 cLJHAz4yL6
X-Received: by 2002:a17:902:dacc:b0:2ea:19bc:2fe2 with SMTP id
 d9443c01a7336-2f03ef59bf0mr200916115ad.10.1795674583546; 
 Wed, 25 Nov 2026 22:29:43 -0800 (PST)
X-Received: by 2002:a17:902:dacc:b0:2ea:19bc:2fe2 with SMTP id
 d9443c01a7336-2f03ef59bf0mr200915665ad.10.1795674582858; 
 Wed, 25 Nov 2026 22:29:42 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:29:42 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:10 +0530
Subject: [PATCH v3 02/21] drm/msm/dcp: Add HFI packet helpers
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-2-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
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
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=34915;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=KEIY5/mRVkqcoMu4OTGXVv0jEqXiJX2TsFLsUHrZROw=;
 b=z7tQFytjpxEospLKB+OjMg9zLmGAJm0Gs7JZy/uhchk2Djb6UQnTmC1et1SsJyZbPE0wItAoW
 96w8zrtZI5tBEj2/D8WtMDWtwLYACSJga4ODeCreXnIZCNdRKyXmvFb
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b07d1d9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=wDQiAsBsKEeCgsny5A0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: BuJefRrNeoGI8T94QF7wT_L6LgKLFTym
X-Proofpoint-ORIG-GUID: BuJefRrNeoGI8T94QF7wT_L6LgKLFTym
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfXxAW4EM9KoRK5
 X19EwVsz4nJ8oQSnowOW6nW2bqy67L59VVVFNEe+dkNRbHQi/nHCAC4IGVxh+8rFYB7IxjPVJOK
 MRVLLQ1qz+kBGEpCRt/e4F2p+5R9mPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX3sEJKi4WJ4/W
 j1Oz6L5aylu8bPZ4imaAU3zNrfMON4unwBIdSb+vou1AeFZdRALQu+ad8dee+BJFxiMr7PUs3/p
 RewrCNKGxh5Pt2Khb+3l57Mu+NfxndNZnFGutPB3VcdCgpHTw5upsPe85w0xU3ZBhBXG5363g7C
 OPjKS6vr78QGopyv7tNSDUyiGXXrnPSdWGGoaxN9w3VrKm4Xc+8cLPNFHJuNCsUXuEMHkpX+VXW
 ZozBXILwerHBkOsQfSwGeS9J5dlRWKjRzDkYP5HmTN+Rxwu3OOFg7ZiJXz2p20B1E7sJGUCUA+l
 VM1jLNmfHSovj/xPh/5rKy3i0UlRyUXUWa4MPQDVymNrgVVk6i4uKxGSRaCGuezuFRnY8ED7fKx
 I9Uh+/RvqFvBcNLGgsA+vax0xvaoHvXJQ8uWcCaEbE9iVTd/cfefAECp42N8gjxLWib8blwcOcX
 eIjHl4N/x97YuWL4tvw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define the HFI packet formats and serialization helpers required to
communicate with DCP firmware. Without common packing and unpacking
rules, the transport and display command layers cannot exchange
commands reliably.

Implement packet creation, property packing and unpacking, and
shared HFI parsing utilities for the DCP transport and command
implementations.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Kconfig                        |  26 +++
 drivers/gpu/drm/msm/Makefile                       |   6 +
 drivers/gpu/drm/msm/dcp/hfi/hfi_defs_common.h      | 182 +++++++++++++++++++++
 .../gpu/drm/msm/dcp/hfi/hfi_pack_unpack_common.h   |  79 +++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.c           | 106 ++++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packer.h           |  65 ++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_packet.h           |  76 +++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c         | 157 ++++++++++++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.h         |  77 +++++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c            |  62 +++++++
 drivers/gpu/drm/msm/dcp/hfi/hfi_utils.h            |  56 +++++++
 11 files changed, 892 insertions(+)

diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index ed1c4775d1e9..df25373d7847 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -114,6 +114,32 @@ config DRM_MSM_DPU
 	  the MSM DRM driver. It is the display controller found in devices
 	  using e.g. SDM845 and newer platforms.
 
+config DRM_MSM_DCP
+	bool "Enable DCP firmware-delegated display support in MSM DRM driver"
+	depends on DRM_MSM
+	depends on VIRTIO_MMIO=y && QCOM_IPCC=y
+	select DRM_MSM_KMS
+	select VIRTIO_QCOM_DCP
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
+	    - IPCC SMP2P mailbox: power notifications and response wakeups
+	    - HFI over VirtIO MMIO: display command/response exchange
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
index 1e246616f83f..ad7b9dbf736e 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -4,6 +4,7 @@ ccflags-y += -I $(obj)/generated
 ccflags-y += -I $(src)/disp/dpu1
 ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(src)/dsi
 ccflags-$(CONFIG_DRM_MSM_DP) += -I $(src)/dp
+ccflags-$(CONFIG_DRM_MSM_DCP) += -I $(src)/dcp
 
 adreno-y := \
 	adreno/adreno_device.o \
@@ -70,6 +71,11 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
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
index 000000000000..291af4716544
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
+			     const void *payload, u32 payload_size)
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
diff --git a/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c b/drivers/gpu/drm/msm/dcp/hfi/hfi_unpacker.c
new file mode 100644
index 000000000000..e5b1a1c48b01
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
+				 struct hfi_packet_info *packet_info)
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
+				    u32 kv_payload_offset, u32 *num_props)
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
+			      u32 kv_payload_offset, u32 num_props,
+			      struct hfi_kv_info *kv_pairs)
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
index 000000000000..71e720ffe3f0
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/hfi/hfi_utils.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include "hfi_utils.h"
+
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
+int hfi_util_kv_parser_get_next(struct hfi_util_kv_parser *kv_parser,
+				u32 move, u32 *hfi_prop,
+				u32 **payload, u32 *max_words)
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

