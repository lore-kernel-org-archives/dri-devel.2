Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C9B606A332
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fx6AVVCm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WP9cp9WH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 222D910EBDF;
	Mon, 26 Oct 2026 06:22:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D81410EBDF
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69Q4aviP2727103
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YuwHSiZL3NwA/hlV8hnXqesJmj6A6Qp6BFEf7yjW8OM=; b=fx6AVVCmMqKIzVEc
 eHSaXXIOS12RaBbySKnfZepnH7hn3kacg2OBk6QQL3cFbgcBC1RlwV96dsnKFkFV
 5us/sczPaWEOOJC+jp8ViXKkdTcalNypQXMZX1pl6Q1fEGz+k7YHSKwfzReGGT72
 vG9ArDaPu6rCiwZCOLdTjKDzP4zolh9YxLDCu6oGjEAojPzv+ZJLhDAh+RMyO4Fb
 6hqTny5UowKXcQE6h+8laPxUFeIiIwisQl1oWnHHSUUCJaAYukTnGmH+V70tgDhr
 np8dEwvad4WYMM7uD0HIJ+iZ+uCFS96LFouVGRA89+bjFg6Jyauas5ZJ8gT+7KRl
 ffArTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6n5w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 06:22:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e832c03576so52485975ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792995764; x=1793600564;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YuwHSiZL3NwA/hlV8hnXqesJmj6A6Qp6BFEf7yjW8OM=;
 b=WP9cp9WHQ4W5kq0FWVDXabjvuS7SraKt8usUCRJiEVd5mFmg9FjuPAseOSSYtglkua
 hxDlhULnCumWjNbv9z9jUqt8NJMS+ybS/oK22wy6uGkkJnZboH4aSqeZ7gciB1R+wBci
 SJKpO7n43+3RQMP8HgFr08Seq4nITcZapMXMN4xsG4xn/2GCP08RWyz+W/d+Zs/Ix8jJ
 Uo89L+0w+BwuXO2nZGdGqMoRzUqZYqfXt6Q9m8zWTRQGKqpo+tNuY7ie0of27LzlRH/2
 mvHcjYgGZmX2Jr793u/8xoOIyylaSOj6IKXhj+g0xV03WfUWzHkn9yoOAvwIxvLbDzQ6
 i/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792995764; x=1793600564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YuwHSiZL3NwA/hlV8hnXqesJmj6A6Qp6BFEf7yjW8OM=;
 b=Gn0l9ZSuIjy4l7LsG4DrnnRhZgPC15JGwi+QDgQI2mS/P7gpxrHy7uyqHfOUgao+Bd
 iuKFrWUErz7rjVlv4gfn83acKX4iGW/XPhRqeK9BVSC3ldqH4YiMe3EVfHtX7lKQ4Zb9
 1Bf3tDiwSz5x1uqIBbezaKQ+RDkX4OOsXadqbD+shRToWWpCsIBQfNR9w+wda1dNbSLg
 xx1h7w+ZAsQLlvvfyEhbnjstzbqX0/5/T/Ygip+SCK1gUgZQTods6OXGP7ngIlLPmnxZ
 +tiG8g1D7TcHC9MoxtNhgIwVxokAszFYR1vuCoOtnkw/Gr7suQYuvimd5aNn0KWKJ+zO
 Ufcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx43/xgsP2FJXOJjr4ZIgCYBUb6P4mq2aZ2TAlvWc0Kcltx40cdXC2EhnKJEiPIxu/UP2IjfBeAVA4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLu5h0hDs58XtVDEuapwQD1xNcbohOfyyduE80jS6fgqagDY5DE
 +YIogswNPVQwxa6palUQKJ1tUqTszggWx4rwjJtc0DC3I0qEuxPXmfER9iakaQ6OryojPmRTG7M
 1D9g8r96aiFhShoMAwoM2KbJSZx215+rrUEXHf21MlBmyspeItr6QdMa9oLX3i9GJEiYgf/0=
X-Gm-Gg: AYBFou29tZHpFKyrirn+JS5GdpNsNhOfyl9/lTb7Re0zeGGh4Wkhokjycts3EbsuWSI
 ETz7TVOGx8YhvE+tqd0QYdIszzrdmOq9rfcTjxQy8aK5MPXEYPhC1Ax8ng+WRNV1SDpym+gnGNf
 cl1rv568ODb4htIZ2L9WFTFyqzHysbcF995Epy9LVLvEjRPYbzQAVW5KqS3jcsl/QO5cAv98d5w
 zikIF7NM4P0mqEtJ2JULmogjc5D3A4u+8GWyK5mVygxzk/LESr3KoReQJfswSeJnW7f+9goYDom
 a28nXy1/nkBUdjB5wPqidYek0U2fB4EEDGJZsFmPPCWkwMSC69TMEPylaTY1fcRqUaYOANsnBXO
 qyLefLjTJL02WylKRhPDv5nJibVEKWTF+jA==
X-Received: by 2002:a17:903:19c8:b0:2e9:8202:509c with SMTP id
 d9443c01a7336-2ea9c03c530mr51897705ad.7.1792995763484; 
 Sun, 25 Oct 2026 23:22:43 -0700 (PDT)
X-Received: by 2002:a17:903:19c8:b0:2e9:8202:509c with SMTP id
 d9443c01a7336-2ea9c03c530mr51897395ad.7.1792995762884; 
 Sun, 25 Oct 2026 23:22:42 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1a1c56sm12633415ad.44.2026.10.25.23.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 23:22:42 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 11:51:16 +0530
Subject: [PATCH v2 06/23] drm/msm/dcp: Add HFI VirtIO transport
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-jshekhar-dcp-hlos-v2-6-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 virtualization@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792995687; l=33166;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=ph//bQ+MJZe+1zcYqE65tyjt3t9EoAaJXEIz+FYGSEc=;
 b=V1Ts6vhi8jt0B3voV55WvCWtKMbizwTwnK5nByj8duFSL3Z/UPK0jEKBZGur5o3Ba5Z/7hQkg
 vQa5GG8dIQvD9jN8k9Ze1A9C8US/zXOGWSGG+NnC+iBQtCAvamEn2VB
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-ORIG-GUID: KKGO3A2FrW8OGmaGDdM26pGgYAwxzyzF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX401AcutGYinH
 vuNZwC3tjW5IJycvJUUoYEY9z2nz6mf5uA4HsowjPRcQCHo/8gntEl0PWrYu52IIctK5Equ28c5
 Xd79KrHk7YgJ9c340kO4LxVTm0mIXC0=
X-Proofpoint-GUID: KKGO3A2FrW8OGmaGDdM26pGgYAwxzyzF
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adef1b5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=406GoIHoPCoxA1Cj2Z4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAyNSBTYWx0ZWRfX5cA1YNdOSgtt
 nBQZ5DT9SdNgfiMGoqnFnTUvYYnWTlSgkWJTYJA14dvDgGoDksS8oDoT6PjRwmy7MRUgm1Hn1e9
 VcJf/YpGbeZN0QLV1WQlCaylziWq1Ww9gJQwpAubUXGnsWEM1zlkSs5Y3S4JztPZ9L91bntuiaa
 dhtUIhS31V1UVaq59fkP9PtePrPEPSyb1TmLgo+vuI8JjmuC0KZHhsYtw1BTsAgu5ExB0CNBXNW
 iG2TFkfCTN7CY8bJxFqbLgdbaN8mHgtgcBMnSeX5cc6+LUXHaGtf+B8dCtljOtHbE8o6e6rOH94
 JAMLKOZLdDegSWgSDEqmZ/a1b/F1m7x1vSf78DOOluo2Y79B7ESEdf2xHfcVe/yuW8cWti1qNH8
 zeWUNkZWl2HKhwA2dj5RKq87EvR+ik4482urrDLm5lNfPikdcNUaNGGlHXiTygGOiBsojuwPwI5
 3PUhsYLv/0U8yJshiBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260025
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
 drivers/gpu/drm/msm/dcp/dcp_hfi.h      | 169 +++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_core.c | 836 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h |  48 ++
 5 files changed, 1082 insertions(+)

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
index 000000000000..23e1cd39b89d
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi.h
@@ -0,0 +1,169 @@
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
+	/* Protects response queue draining and power callback publication. */
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
index 000000000000..9f7ac798e13c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_core.c
@@ -0,0 +1,836 @@
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
+	if (ret)
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
+	unsigned long flags;
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
+	xa_destroy(&hfi->pending_xa);
+
+	dcp_hfi_free_pool(hfi, hfi->cmd_pool, DCP_HFI_CMD_POOL_SIZE);
+	dcp_hfi_free_pool(hfi, hfi->resp_pool, DCP_HFI_RESP_POOL_SIZE);
+}
diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
new file mode 100644
index 000000000000..cc8a618182fe
--- /dev/null
+++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_priv.h
@@ -0,0 +1,48 @@
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
+#define DCP_HFI_TIMEOUT_RESOURCE_REGISTER_MS	5000
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

