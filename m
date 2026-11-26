Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ON8KzKrm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WPSwzekZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C46310F6B7;
	Thu, 26 Nov 2026 06:30:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522EC10F6CF
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36W7R2175893
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AM7xKUZOEMYpYdWupRI+Lalaf2e11Q7JSnkEBr0G9Uk=; b=ON8KzKrmtLVVI0pd
 xAKQPrM+sogefyJyo7LjyhavbwEkJrllmhv0P3h93qLXL0/8a2YEGFC3PY3QFQFQ
 DSoczyoV/FawzX3MEIrpaI8foVOt443YP7MzQl9z2ryIgjyew3Nq3OyipOkD7FyV
 GLDaJEOOEr6CeyP7Gyym4hN10OWJ1sDUBciAfNPrBsBgDRxLNrPEe4dg48+u1lVM
 a+lbL/nhcEFt2aMQxlYgSTTRgVsiH9p2MLZkr4mlZ9yrbd801qS7/CIEh29TQUnc
 8j5GveyJFwQki8AnDmz16gRpcyM2gKNek1HoEefzGIOHhaBWMDyh2YIh5AVJ3VO8
 i2TReg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vuhvabh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:30:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2f053f95aadso56437385ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674619; x=1796279419;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AM7xKUZOEMYpYdWupRI+Lalaf2e11Q7JSnkEBr0G9Uk=;
 b=WPSwzekZj02Z4Snn8oj7lIh0Pac5BAAaMB0EPVh06gUqPq11M/6Dx0LsitUZni3gfp
 qK5shykvnxShga9XC+UOPMg8jMwIIsI5v8Na0JQoCvFqHNCpZaId/LXWRInBEvVfssmS
 roWtppLtdRVuEqf6C2TcDOI1nE78VTwaY1/iFoS4PpzQIaPHJVOLXl1vOjnE6VZL/CXr
 msaPUDA+hwzJEbBtgKz+3V8CckxwhLVOVue/mKmlMnLwlfIYGeLwyxQwf4KDKTEcckka
 3xPqb6B5iPSw7TA2YqHopI2qdWk5kZSl32uKYSaE5b91DwQ8vxPJSYwXz9rgpS+nK+8w
 c+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674619; x=1796279419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AM7xKUZOEMYpYdWupRI+Lalaf2e11Q7JSnkEBr0G9Uk=;
 b=nSa4o9RZ0Wr1jeq8+gfRNIX2goVPlQ3+qx+hAQZ5zpOgCW8PAD9x3OT6fT7IbcJpuO
 y7kYJ1ut5Ks0T5yllLgWV1N2baSU835wHDkPredu2Ty6neAEzS/VkzjzWogUj5UlAhSO
 BIz9e6kCHYKikB/q8ay5Im+uJrOTMrMNFbiFQduOjUrSMC6cSCpQWRlkwWBo2gp1zN36
 VPYlj4v/1B9W3+iKLIl7YWXvl52aFAvno/+ZLWkeCVcIhF1FtQt657n69meRMmxQqPdU
 zDAxGRAtroBWDulQIuaEuuOMaVJ7nFMcZzDIc8t+v9X7MuWh9dKgHFcsfSNd3FHBXzZG
 +s1Q==
X-Forwarded-Encrypted: i=1;
 AL+hErETNMyjhOsIzZpvqAPUCmNE8GyClSv7zQY43r90gEzQcQIy0fTWwGDqka45zLVFbpjIZC8vhq8Za2M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ItJ9ay7WD1jPH+YIvZmwNea1c7mQPOk5tMoIs8Gd6cAYHQwkM
 zVjWs5NLQKWxqX6yTAj/XzSl/FJBrmLoRM1IyjIA0zANuibDvulOlIsYMqNFpBeKeoDN8GtYhBW
 fy9prBZJrD6VvboQws1VWnocCwqsP7OZRDSie7YuSI+IVI//ToXxDaG7tPRm/fzlZK4062F4=
X-Gm-Gg: AZFdTZdWnODX4mILzAYSe0/ddsAPS0rmcpbEm6u3LZFuhSrbZFIk7oL1GmPWU8O4fC2
 EIhk/YTL9+CItmOTMboFkLG5dlLKaiZrE0EA0ryFwMf9a70MMQ4G5jynyO/9oYshaa2sRgr7tyk
 1nF6hFuzSSnCkKc2iu6vuypqESmTrrs9PiyoQ3xsz3+zhKrAjLkMe69VLT71htSVUSrDfCX14aj
 Aqf/ut9YB187XZj/U7uVQHImP0D5oMg7vdFchwxaLpM+9uIWKJfZlgyTzwPSOFZoiJdag3NmdIl
 Ma6ezr4cjemm1iS2JlhP9H3wMIfMg/9stzJaaIZqQl27w/RWsiCo8bYoRqqENSWDKp6k8InJgxp
 pT8qV21uJZ5ynTZocZE0OvY7O2javFdArDb9fW7qAmA/cPaMgzW6qDdSFCb8gnjfR6Yw+VicuNR
 wVm23ry/r6
X-Received: by 2002:a17:903:19c5:b0:2dd:ad73:5b6c with SMTP id
 d9443c01a7336-2f0ea5af0acmr18750035ad.28.1795674618807; 
 Wed, 25 Nov 2026 22:30:18 -0800 (PST)
X-Received: by 2002:a17:903:19c5:b0:2dd:ad73:5b6c with SMTP id
 d9443c01a7336-2f0ea5af0acmr18749535ad.28.1795674618084; 
 Wed, 25 Nov 2026 22:30:18 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:30:17 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:14 +0530
Subject: [PATCH v3 06/21] drm/msm/dcp: Add HFI VirtIO transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-6-f1e9d7505039@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=34147;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=BqdLAD+cB8OeUEetpLM++M6VEUOAvED2HzLGC2Rb5nY=;
 b=vA7FMtrVnl8nnOaYjgFrp4GblcT81GNKhPQUnuZLZHIgMVgQqOY3TU7DYYhs75KDv6MlOUflR
 sXcS873vRZ8DrwyEMRs2ZwPV8gIpxaSS0nRI/kBGF3wWOO0s88OpAKq
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6b07d1fc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=406GoIHoPCoxA1Cj2Z4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: Sbc_RcJnTlXcawJJLQpwG0X0YQKoLHMQ
X-Proofpoint-ORIG-GUID: Sbc_RcJnTlXcawJJLQpwG0X0YQKoLHMQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX+FQcmgHfsRCx
 tbZhXX/a7aQLxU9hSHd0WtlzbowbA8qUkMKX73pdn/QYRNtrjl9bOv/jwF0VFMRiGhUviB//xzU
 fGwkyvIQFsx15a82/iuoSzAO+DIi0xU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX/hG37EUn+1k6
 mIclExnMvbH+FF8HKDT4J+NxQg1OJkHleANhpdkewbIi7KCSiauCsdSZ6hicAwLtQGmPc7mMMwX
 juaTjsG7ygDtJLeUHjx0Ayu/7VRrUB3t+JEEBVplTdTBu2JljIEqNJ1bZRlACuX8AN5KK3pBSp4
 Cfa52mjZ00+SrZB/ozhK4Hisu6xC7khvRqu0wVg51VO8r/wY5CRNqZ5uHP/rDq9lJHhqMF7TuKO
 1mBTC5fUACElt1Z4M14P6IQBKCyMKnKNMqo8+lhx7M2rVdwDoGJehMLtitBFqQDtFNnsEjht2LT
 bn/rlG9JJFzk05+qgdiPTDDZviA/KiA8cWvJ86xc8gFGLTkNAk5PS7dn0kupFleonsF59j/cpSZ
 Q7RK2SEniCK3B0oizOD2EbQicvqAEcjPpr5siF2xlESx5DSUihAqzJrOQ6aid1F/3zcangACRzG
 +RlZ5EBHHGg/Fu7izmQ==
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

Implement the HFI transport between Linux and DCP firmware over
VirtIO. The display backend needs a transport that owns DMA buffers,
submits HFI packets, receives responses, and completes commands
without exposing firmware queues to higher layers.

Allocate and manage command and response buffers, handle VirtIO queue
callbacks, provide synchronous and asynchronous submission paths,
and synchronize transport teardown with in-flight activity.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile           |   1 +
 drivers/gpu/drm/msm/dcp/dcp_drv.h      |  28 ++
 drivers/gpu/drm/msm/dcp/dcp_hfi.h      | 171 +++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 871 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h |  47 ++
 5 files changed, 1118 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index ad7b9dbf736e..56c48fe2e2c5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -72,6 +72,7 @@ msm-display-$(CONFIG_DRM_MSM_MDP5) += \
 	disp/mdp5/mdp5_smp.o \
 
 msm-display-$(CONFIG_DRM_MSM_DCP) += \
+	dcp/dcp_hfi_core.o \
 	dcp/hfi/hfi_packer.o \
 	dcp/hfi/hfi_unpacker.o \
 	dcp/hfi/hfi_utils.o
diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.h b/drivers/gpu/drm/msm/dcp/dcp_drv.h
new file mode 100644
index 000000000000..44d9b2cd5171
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_drv.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DCP_DRV_H__
+#define __DCP_DRV_H__
+
+#include <linux/init.h>
+#include <linux/notifier.h>
+#include <linux/platform_device.h>
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
index 000000000000..9c80e38aa96f
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -0,0 +1,171 @@
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
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_pack_unpack_common.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_defs_common.h"
+
+struct dcp_drv;
+
+/* Queue 0 carries commands; queue 1 carries responses and events. */
+#define DCP_VQ_CMD	0	/* TX: all commands */
+#define DCP_VQ_RESP	1	/* RX: all responses and async events */
+#define DCP_NUM_VQS	2
+
+#define DCP_MAX_DISPLAYS	4
+#define DCP_HFI_CAPS_BUF_SIZE	4096
+
+struct dcp_hfi_caps_cache {
+	struct completion device_done;
+	struct completion display_done;
+
+	u8 device_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 device_len;
+	u8 display_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 display_len;
+	u8 vig_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 vig_len;
+	u8 dma_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 dma_len;
+	u8 vig_r1_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 vig_r1_len;
+	u8 dma_r1_buf[DCP_HFI_CAPS_BUF_SIZE];
+	u32 dma_r1_len;
+	u32 pipe_caps_received;
+};
+
+#define DCP_MAX_SSPP_COUNT	16
+#define DCP_MAX_VIG_PIPES	DCP_MAX_SSPP_COUNT
+#define DCP_MAX_DMA_PIPES	DCP_MAX_SSPP_COUNT
+
+#define DCP_MAX_BLOCKS		8
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
+	/* Number of displays reported by firmware. */
+	u32 num_displays;
+
+	u32 dsi_count;
+	u32 dsi_indices[DCP_MAX_BLOCKS];
+
+	/* Maximum dimensions reported for DSI display modes. */
+	u32 max_width;
+	u32 max_height;
+
+	u32 max_planes;
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
+	/* Protects response queue draining. */
+	spinlock_t resp_drain_lock;
+	struct list_head resp_repost_list;
+	struct delayed_work resp_repost_work;
+	struct xarray pending_xa;
+	/* Protects pending_xa and completion publication. */
+	spinlock_t pending_lock;
+	/* Allocates non-zero packet IDs for HFI transactions. */
+	atomic_t packet_id;
+	/* Blocks new work once transport teardown begins. */
+	atomic_t shutdown_in_progress;
+};
+
+int dcp_hfi_init(struct dcp_drv *drv, struct virtio_device *vdev,
+		 struct virtqueue *cmd_vq, struct virtqueue *resp_vq,
+		 struct device *dma_dev);
+void dcp_hfi_stop(struct dcp_hfi *hfi);
+void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi);
+int dcp_hfi_restore_queues(struct dcp_hfi *hfi, struct virtqueue *cmd_vq,
+			   struct virtqueue *resp_vq);
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
+				      enum hfi_packet_payload_type payload_type,
+				      void *payload, u32 payload_size, u32 tx_flags);
+#endif /* __DCP_HFI_H__ */
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
new file mode 100644
index 000000000000..9c46a4560a0d
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -0,0 +1,871 @@
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
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/virtio.h>
+#include <linux/workqueue.h>
+
+#include "dcp_hfi.h"
+#include "dcp_hfi_priv.h"
+#include "dcp_drv.h"
+#include "hfi/hfi_packet.h"
+#include "hfi/hfi_packer.h"
+#include "hfi/hfi_unpacker.h"
+#include "hfi/hfi_commands_display.h"
+#include "hfi/hfi_defs_common.h"
+
+static int dcp_hfi_prepost_resp_bufs(struct dcp_hfi *hfi);
+
+u32 dcp_hfi_next_packet_id(struct dcp_hfi *hfi)
+{
+	u32 old, next;
+
+	do {
+		old = (u32)atomic_read(&hfi->packet_id);
+		next = old + 1;
+		if (!next)
+			next = 1;
+	} while ((u32)atomic_cmpxchg(&hfi->packet_id, old, next) != old);
+
+	return next;
+}
+
+#define DCP_HFI_BUF_ALLOC_RETRIES	3	/* Bound command-path stalls. */
+#define DCP_HFI_BUF_ALLOC_SLEEP_US_MIN	30000
+#define DCP_HFI_BUF_ALLOC_SLEEP_US_MAX	40000
+
+static struct dcp_hfi_buf *_dcp_hfi_buf_alloc(struct dcp_hfi *hfi,
+					      struct list_head *free_list,
+					      spinlock_t *lock,
+					      const char *pool_name)
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	_dcp_hfi_buf_free_locked(buf, &hfi->cmd_free_list);
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
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
+				     int status)
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
+						     len, sizeof(struct hfi_header));
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
+			   size_t cmd_len,
+			   struct dcp_hfi_completion *comp)
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
+				   u32 cmd,
+				   enum hfi_cmd_buff_type cmd_type,
+				   u32 object_id,
+				   enum hfi_packet_payload_type payload_type,
+				   void *payload,
+				   u32 payload_size,
+				   u32 tx_flags,
+				   void *resp_data,
+				   size_t resp_len,
+				   unsigned int timeout_ms)
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
+		cmd, dcp_hfi_cmd_buff_type_name(cmd_type), object_id,
+		packet_id, payload_size, timeout_ms);
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
+		      enum hfi_cmd_buff_type cmd_type,
+		      u32 object_id,
+		      enum hfi_packet_payload_type payload_type,
+		      void *payload,
+		      u32 payload_size,
+		      u32 tx_flags,
+		      void *resp_data,
+		      size_t resp_len,
+		      unsigned int timeout_ms)
+{
+	int ret;
+
+	ret = dcp_hfi_send_sync_on_vq(hfi, NULL,
+				      cmd, cmd_type, object_id,
+				      payload_type, payload, payload_size,
+				      tx_flags, resp_data, resp_len,
+				      timeout_ms);
+	if (ret && cmd == HFI_COMMAND_DISPLAY_MODE_VALIDATE)
+		dev_dbg(hfi->dev, "HFI mode validation rejected mode: %d\n", ret);
+	else if (ret)
+		dev_err(hfi->dev, "HFI command 0x%x failed: %d\n", cmd, ret);
+
+	return ret;
+}
+
+int dcp_hfi_send_no_wait_flags(struct dcp_hfi *hfi,
+			       u32 cmd,
+			       enum hfi_cmd_buff_type cmd_type,
+			       u32 object_id,
+			       enum hfi_packet_payload_type payload_type,
+			       void *payload,
+			       u32 payload_size,
+			       u32 tx_flags)
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
+				      enum hfi_cmd_buff_type cmd_type,
+				      u32 object_id,
+				      enum hfi_packet_payload_type payload_type,
+				      void *payload,
+				      u32 payload_size,
+				      u32 tx_flags)
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
+			 enum hfi_cmd_buff_type cmd_type,
+			 u32 object_id,
+			 enum hfi_packet_payload_type payload_type,
+			 void *payload,
+			 u32 payload_size)
+{
+	return dcp_hfi_send_no_wait_flags(hfi, cmd, cmd_type, object_id,
+			payload_type, payload, payload_size, HFI_TX_FLAGS_NONE);
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
+		 struct virtqueue *cmd_vq,
+		 struct virtqueue *resp_vq,
+		 struct device *dma_dev)
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
+	spin_lock_init(&hfi->resp_drain_lock);
+
+	atomic_set(&hfi->packet_id, 0);
+	atomic_set(&hfi->shutdown_in_progress, 0);
+
+	INIT_LIST_HEAD(&hfi->cmd_free_list);
+
+	xa_init(&hfi->pending_xa);
+
+	INIT_DELAYED_WORK(&hfi->resp_repost_work, dcp_hfi_resp_repost_work);
+	INIT_LIST_HEAD(&hfi->resp_repost_list);
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
+	for (i = 0; i < DCP_HFI_CMD_POOL_SIZE; i++) {
+		hfi->cmd_pool[i].data = dma_alloc_coherent(hfi->dma_dev,
+							   DCP_HFI_BUF_SIZE,
+							   &hfi->cmd_pool[i].dma_addr,
+							   GFP_KERNEL);
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
+void dcp_hfi_stop(struct dcp_hfi *hfi)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->cmd_lock, flags);
+	atomic_set(&hfi->shutdown_in_progress, 1);
+	spin_unlock_irqrestore(&hfi->cmd_lock, flags);
+
+	cancel_delayed_work_sync(&hfi->resp_repost_work);
+	dcp_hfi_cancel_pending(hfi, -ENODEV);
+}
+
+void dcp_hfi_quiesce_queues(struct dcp_hfi *hfi)
+{
+	struct dcp_hfi_buf *buf;
+	unsigned int len;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
+	if (hfi->cmd_vq)
+		virtqueue_disable_cb(hfi->cmd_vq);
+	if (hfi->resp_vq)
+		virtqueue_disable_cb(hfi->resp_vq);
+	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
+
+	if (hfi->cmd_vq) {
+		while ((buf = virtqueue_get_buf(hfi->cmd_vq, &len)) != NULL)
+			dcp_hfi_buf_free(hfi, buf);
+		while ((buf = virtqueue_detach_unused_buf(hfi->cmd_vq)) != NULL)
+			dcp_hfi_buf_free(hfi, buf);
+	}
+	if (hfi->resp_vq) {
+		while (virtqueue_get_buf(hfi->resp_vq, &len))
+			;
+		while (virtqueue_detach_unused_buf(hfi->resp_vq))
+			;
+	}
+}
+
+int dcp_hfi_restore_queues(struct dcp_hfi *hfi, struct virtqueue *cmd_vq,
+			   struct virtqueue *resp_vq)
+{
+	struct dcp_hfi_buf *buf;
+	int i, ret;
+
+	hfi->cmd_vq = cmd_vq;
+	hfi->resp_vq = resp_vq;
+
+	INIT_LIST_HEAD(&hfi->resp_repost_list);
+	for (i = 0; i < DCP_HFI_RESP_POOL_SIZE; i++) {
+		buf = &hfi->resp_pool[i];
+		INIT_LIST_HEAD(&buf->node);
+	}
+
+	ret = dcp_hfi_prepost_resp_bufs(hfi);
+	if (ret)
+		return ret;
+
+	atomic_set(&hfi->shutdown_in_progress, 0);
+
+	return 0;
+}
+
+void dcp_hfi_deinit(struct dcp_hfi *hfi)
+{
+	xa_destroy(&hfi->pending_xa);
+
+	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);
+	dcp_hfi_free_pool(hfi, hfi->resp_pool, DCP_HFI_RESP_POOL_SIZE);
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
new file mode 100644
index 000000000000..f255db3a96b1
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
@@ -0,0 +1,47 @@
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
+
+#define DCP_HFI_TIMEOUT_INIT_MS					2000
+#define DCP_HFI_TIMEOUT_CAPS_MS					1000
+#define DCP_HFI_TIMEOUT_DISPLAY_MS				1000
+#define DCP_HFI_TIMEOUT_MODE_MS					3000
+#define DCP_HFI_TIMEOUT_COMMIT_MS				2000
+#define DCP_HFI_TIMEOUT_DISPLAY_DCS_MS			10000
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
+			   size_t cmd_len,
+			   struct dcp_hfi_completion *comp);
+
+int dcp_hfi_pending_add(struct dcp_hfi *hfi, struct dcp_hfi_completion *comp);
+
+struct dcp_hfi_completion *dcp_hfi_pending_find(struct dcp_hfi *hfi,
+						u32 packet_id);
+
+#endif /* __DCP_HFI_PRIV_H__ */

-- 
2.43.0

