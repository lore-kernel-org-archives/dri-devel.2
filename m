Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C4AF5A8C8
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E2410E77D;
	Mon, 20 Apr 2026 22:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OCA7oha0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iAKexL6C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FF810E78B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:19 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KHOPu73015375
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r+OvOunmdBc
 9THaENORBIW5PHKBLtBVoo569H18ircs=; b=OCA7oha0Aj/9YG2D6ryGq7JDErz
 GGqw+1sEwN9wthnAeyyeElfv8Kti2EYCdgfFK9CUbjOdDnat3UYZxfvauzjzPnK1
 X/I1+vIg8wj+aHV1Lg7aDco2SoALYwdGTh6kT1kv1cStan+Nq8450FoOjmsrlAQ+
 cttRrVCPKYEQqrzfvsiQHASqXi4FAcyo0uTMx081qqW1Wy53N6w/u/i59JfH6wrM
 BvqWs1BXA8MWJa9eDN8ykW4WB6DhgmON0ME985UI0RZ0UKWkuGmVyYamwwCkVgel
 uUBb2800BZoj1PvUJV2s1D7n1v90UCmYncKQg9OFkDoCU20UMvCOTvRtXcQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjuktc9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b250d3699aso71810815ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724037; x=1777328837;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+OvOunmdBc9THaENORBIW5PHKBLtBVoo569H18ircs=;
 b=iAKexL6Ckp0tiwp6LbY2MeYlxo+x+639OUMO83NdvQ0hUl1yCvRTOCZtF6d6l9/dJg
 usIBfYCQIfGV3k7/keFRdvwstdOMaQphbOp46m3BoubB8cAfVn+fuarhwO3dckrEftuI
 SWUva4/66EEbkQTxxI7MsDcP8c4i4MR05RvyF9CMywJUb4y1o9BOS9EPw2dAT97GDpCk
 dDp0LcZRjMx9fe3R+cZBhwHPmXXzaEiiIfUJRMXFXt1lLOaj3zeoo32+6xBI8bV6ieGK
 E4qtYi8+Weu5eWZbXdsGerhKV5rjZ7a1iqMcxfEvbGyCNzUuyO+dFscmnVePM+O5gF5K
 ljEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724037; x=1777328837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+OvOunmdBc9THaENORBIW5PHKBLtBVoo569H18ircs=;
 b=GwFxtmYRfLwM8/mjXpiyBuk9VtOWvcumU/GTykhXmdMLSBiI7YxZw6wEKEEBRIsBog
 iBTkX0ItOS1L9wDrWhZ78MKj3uua1+1VGA16II5IzupBv4biFZgmXSOuFfhZFWS6fa6Z
 E9OTRlejrMYjv98znwOgGN/VL//ZRsmeZOI86XaY/y4So1RveQkbVKhZLgVWC8nIHkm5
 N9o5w3e3QZst2Eo6xaabee9XqLMJIohYWktLJOR8opD80M0ibREafSVtvFoC6PFw+uzk
 jNUCn1ElnC7y2twhLhMaWKKYIWsM7ClUwtdMAIGT6shQfeKqTgdJXU9mJ8G+aLiRBFLL
 vILg==
X-Gm-Message-State: AOJu0Yy9i1u9CLdHEikzyFdO+DH4negFMyYM6rcs/NzXbpcGibLjX7Sk
 xP3Pl6dVFwqaUv4BTm4OooWGCm2CsjgRNaSS+rvGWEQUAAj7d8/lesRXxXiTIRZAeuZhPsVz5x2
 oxnYjaIDCircT2jGwteJvaVXSwEVAzj06F4lIps+GNAIy/P9CkgJ6ykj2YGmo0W2GCW1MqeKj12
 sv2nY=
X-Gm-Gg: AeBDiesWYNLG0/aCzN+r1oL5kqpNRG2Lrm6kaYBzBG+c13ATjSJv1AsnJ8MV3Nr53W0
 D1S9vuiyioSdz4G2LdpO9dB/mweYZnIbKsjCqiJMgQYy4vHJmDT9AJKF6fXvpOkAtU8Ndbe5iMf
 uEjnhTp3xGg3IB+2WXr9Cd/QX7wpq5gqh3wMafVncLrL27X68DDlkZGSXz83d/fzIdH46/W4H6D
 H0Pz6V8eEYKBVIMWtNfkRNovN5myXPTOc7KCQJi3GPG3GwRX0xc4KUQHDsiTMk+i6/afz0CeU+s
 B0Mi6rhvLbIib4F/ki5oxzgNltTpyuu5p1H3sM2o29d6uBQkinlrzFa/11qBnVQizMOcA0IqGO8
 FnLNj9lOkgMDGyx3O9rxW+7Z/PoM0krpsiMvPmfS4tyk=
X-Received: by 2002:a17:903:3e02:b0:2b4:5a2e:98d9 with SMTP id
 d9443c01a7336-2b5f9f7abd6mr116583525ad.37.1776724036888; 
 Mon, 20 Apr 2026 15:27:16 -0700 (PDT)
X-Received: by 2002:a17:903:3e02:b0:2b4:5a2e:98d9 with SMTP id
 d9443c01a7336-2b5f9f7abd6mr116583215ad.37.1776724036384; 
 Mon, 20 Apr 2026 15:27:16 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20c4fsm142124185ad.59.2026.04.20.15.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:16 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/13] drm/msm: Add a6xx+ perfcntr tables
Date: Mon, 20 Apr 2026 15:25:28 -0700
Message-ID: <20260420222621.417276-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rhgb0sSnMmrmmosztGpnC02g3YZVLs8i
X-Proofpoint-ORIG-GUID: Rhgb0sSnMmrmmosztGpnC02g3YZVLs8i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX8QxV3Pdi1tF/
 E4cxAduCEoafgtW/28zZwKfhKwa+gq5K3q0VlG0nG+5fAjuETYWtgVmsoQG0eEYw1uaw855cM4D
 Ug7a5MuuFZ99jtPoAz6hxTzonNx4+UxlzyY1o/zk1uUfzvg2lnV8wp9PH3kQuA85VvbaY8BJHdh
 yYmohbuhkJdjt7JZWNhxtAUnFC2LYovjOMLIzwkXjE8N+W34VbGLFsc4kEPDoHzZZXNZQUg/AGf
 8HKLIC4J4R5ex2487n8gV6uAeOgN4kPuMwOCTnulYJ6wXydQuQ4UL5qkPZcJ701uQ1XPZ+w1iWb
 bvw7x5JayF7MlrcLNE7ta9cyNCsRLyurZNh5JeEFjabo0BzTGuFl2qBZ67s7PkHad2u+QrqNIvS
 RYVy6qaE3hQwwoiNeInS879jKZbQrXZU0t0ksu7+yzfqHfZzD/NP6iufnHXJfiIiB0fsQyOB21A
 hCgHwLubKHHqKpLn0lw==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e6a846 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=4FiFnV2saKvSNFYXgKsA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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

Wire up the generated perfcntr tables for a6xx+.  The PERFCNTR_CONFIG
ioctl will use this information to assign counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 +++++++
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ++
 drivers/gpu/drm/msm/msm_perfcntr.h    | 57 +++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e578417a4949..727281fbef36 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -5,6 +5,7 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 #include "msm_gpu_trace.h"
+#include "msm_perfcntr.h"
 #include "a6xx_gpu.h"
 #include "a6xx_gmu.xml.h"
 
@@ -2637,6 +2638,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu = &a6xx_gpu->base;
 	gpu = &adreno_gpu->base;
 
+	if ((ADRENO_6XX_GEN1 <= config->info->family) &&
+	    (config->info->family <= ADRENO_6XX_GEN4)) {
+		gpu->perfcntr_groups = a6xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a6xx_num_perfcntr_groups;
+	} else if ((ADRENO_7XX_GEN1 <= config->info->family) &&
+		   (config->info->family <= ADRENO_7XX_GEN3)) {
+		gpu->perfcntr_groups = a7xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a7xx_num_perfcntr_groups;
+	} else if ((ADRENO_8XX_GEN1 <= config->info->family) &&
+		   (config->info->family <= ADRENO_8XX_GEN2)) {
+		gpu->perfcntr_groups = a8xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a8xx_num_perfcntr_groups;
+	}
+
 	mutex_init(&a6xx_gpu->gmu.lock);
 	spin_lock_init(&a6xx_gpu->aperture_lock);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 78e1478669be..8c08dc065372 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -24,6 +24,7 @@ struct msm_gem_submit;
 struct msm_gem_vm_log_entry;
 struct msm_gpu_state;
 struct msm_context;
+struct msm_perfcntr_group;
 
 struct msm_gpu_config {
 	const char *ioname;
@@ -262,6 +263,9 @@ struct msm_gpu {
 	bool allow_relocs;
 
 	struct thermal_cooling_device *cooling;
+
+	const struct msm_perfcntr_group *perfcntr_groups;
+	unsigned num_perfcntr_groups;
 };
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
new file mode 100644
index 000000000000..64a5d29feba1
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __MSM_PERFCNTR_H__
+#define __MSM_PERFCNTR_H__
+
+#include "linux/array_size.h"
+
+#include "adreno_common.xml.h"
+
+/*
+ * This is a subset of the tables used by mesa.  We don't need to
+ * enumerate the countables on the kernel side.
+ */
+
+/* Describes a single counter: */
+struct msm_perfcntr_counter {
+   /* offset of the SELect register to choose what to count: */
+   unsigned select_reg;
+   /* additional SEL regs to enable slice counters (gen8+) */
+   unsigned slice_select_regs[2];
+   /* offset of the lo/hi 32b to read current counter value: */
+   unsigned counter_reg_lo;
+   unsigned counter_reg_hi;
+   /* TODO some counters have enable/clear registers */
+};
+
+/* Describes an entire counter group: */
+struct msm_perfcntr_group {
+   const char *name;
+   enum adreno_pipe pipe;
+   unsigned num_counters;
+   const struct msm_perfcntr_counter *counters;
+};
+
+extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
+extern const unsigned a6xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a7xx_perfcntr_groups[];
+extern const unsigned a7xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a8xx_perfcntr_groups[];
+extern const unsigned a8xx_num_perfcntr_groups;
+
+#define GROUP(_name, _pipe, _counters, _countables) {                          \
+      .name = _name,                                                           \
+      .pipe = _pipe,                                                           \
+      .num_counters = ARRAY_SIZE(_counters),                                   \
+      .counters = _counters,                                                   \
+   }
+
+#define fd_perfcntr_counter msm_perfcntr_counter
+#define fd_perfcntr_group   msm_perfcntr_group
+
+#endif /* __MSM_PERFCNTR_H__ */
-- 
2.53.0

