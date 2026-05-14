Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD46CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73E410F20E;
	Thu, 14 May 2026 13:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+qM+M/Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fe0jo9EG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB6E10F204
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeqCP3049132
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M7rs8SEMK1L
 Qu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=; b=k+qM+M/YsSqPCOCcTYoJhS0HWd8
 aIrB5Q3TZRg7rJIvbL/lo1ZRFJaPLj7D7x65Yjfz/CFmN8uTb1RFSg+VTbdPdHv+
 /t1rdCgQjLOLq6SDBIjU6YWpev9tVeq2RLgU5HB+I4goP5KjNnASoRYdMj9Vru5Y
 SIfNmrB7hCY4QrPCbZtA3Yd+j+VxaMcXGUuaREBE4WIaeznHYevwcO1T2f/WD3yN
 EZvzJV04NiYvkyjoO12UupXJ0trXjoonJyElI9GeDC70QrLG1nbK8KKSxj5hHzfY
 vS8Sux7HdgT6SmeXmpksN/0ScHCJK5hLnmsLphlIFWAvXk5tdPYQ2ngWK4g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5492tc62-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-368ac44b26dso3833317a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766865; x=1779371665;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7rs8SEMK1LQu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=;
 b=Fe0jo9EGvbDPt4Gw3qA8SI5FsQo+Ek9r6IDiXCbQ29xYRlNtlH2pZeQAk2sxZXHtvI
 zDwUwUWQSbttqSIBP8F3T+7yN29gn7b4SP56ETSFwRym5nnbYupVmgvwzIXMqnAWw8Bg
 cZ2nTCHKCg8yOwFi1bYnzjvV5aaD8q4/HZ0YjhxyFZXOy1tJbvh/t+0jX3AZH6kqFMd2
 V1jwyBcEW/D2YGuKDCHQChnh4ri6xaSeWtJfF4O3f5AVrR7wVF6GZ6qIYEZjWeK6/Nxk
 GoiuSzOkCINMMWv37KyQXdAnBb302wb8qCpmnTBedOIC5Kuz2Hwquu54eikYioffl7AV
 B72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766865; x=1779371665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M7rs8SEMK1LQu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=;
 b=HLQ0ixbdezF9V55LAuAGt3CVYFkXBf0C2b7mA2k28nTAQ+vE0e+aflLcDqr3OXDRD+
 7mGtnFVi47E8w0zN46Hn0A0NbZrrUAZXPfr6oqY0k19eSrAdsus1X+P2V8fMcC3Uv4y1
 3W6n5Z2iZioSIZtDzQAsdF/L+YI/E/LBG8DocfkNdrS4DsV/NDDY2qQhGCjqcgB6v9m0
 BvM32yesHsBbAU8Z2NopXuCq3T87ixG/OACHKMVqqKdIxA0L1pNYWCKfyjrS147REJHS
 5bSonhXP5d6PF2FQKpfZfu+Sj3kxVC5dxzBDwhvSCGYscrrwGmgvghWB/WO2IezRgl20
 RisQ==
X-Gm-Message-State: AOJu0YzzXh/AS2mq2b4khkPUTNrlT/WFB+kGH3VKOrTwQBhvsLTaDjwU
 xKs17Mhn4QjBVNTijWqAXzbmvQyPFrnNrsbzoq2HDp3Blq2SEx4iG974NyQZGV/0rLHhaH2/9Jw
 vMRizJKHm43jzEbyJ/ik8O6e/7Aq0SikhdGz/OZ++tzBx7YRnnUVran542FByKQxi14I3MRRM88
 HCs6Y=
X-Gm-Gg: Acq92OGm/Mrsk56QfHUycAHTT3ClEJvqpVDM3Fe/X2uFcUcx5BlvmBYCvnWzXuCa9el
 Xdn44ZkpzkJMdeky2SMsM9v6nrLmQ9E9kUkUHbu5DkOdHCABlc3lWb7Qltnoj0HyXo+PVG6d61Z
 LSDVfC8KjeMqDKI9eNBJPEyCJ88Tsl0Mh9kdi+lqYiG2W5we/4d68KS1QNXxW4jwF0pIM2SAJvR
 QmUICqi0C+ldeWdz1Qz9bCBo+5IAxqVRafuXYfW1NyoJCX7PPTeQ/79OYyT839Qc0kq+tjQt8Gm
 SPeqI39Ck13NyRWH9/k2Oy/KrCsiGeZ5zKPL9+kLUlkpknaQqhv9eBu8rkzBas87LXpE28oTWkp
 2h6uJ8B7AxgJEx8B64IK34M23ZmwwVYlz
X-Received: by 2002:a17:90b:3502:b0:366:d9c:91dc with SMTP id
 98e67ed59e1d1-368f77c9859mr7089985a91.5.1778766864979; 
 Thu, 14 May 2026 06:54:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3502:b0:366:d9c:91dc with SMTP id
 98e67ed59e1d1-368f77c9859mr7089919a91.5.1778766864338; 
 Thu, 14 May 2026 06:54:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3692716c2e1sm1627921a91.2.2026.05.14.06.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:23 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Thu, 14 May 2026 06:39:54 -0700
Message-ID: <20260514134052.361771-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZSMkrbd1yEBaqRnlmpezDe8h0Ftwz2k4
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a05d412 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tmZHKQuSfWdd6biKE2QA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: ZSMkrbd1yEBaqRnlmpezDe8h0Ftwz2k4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX5/N0BbegEcOF
 VVdbR8FFGD0ZTSu2j0UwahcZWnRW0obconP+z35incYXtSzFevFobwAbK5fXzqs7GqYkTP+fQ/h
 2h3K/QaqDgaM2baTiYSBo8WQSPjuX7Ai+SUDJN3wZeIutyzICs+4UeMJ0TK3aUWin3BrK8XbNyO
 MVfsy/go0/GVuUQKx/EPCt7DPaEg0S4ltDwzKpdlt+9rn/I3I9dijxzHxZLVsfKyUMukBmTLqzn
 RUlSB8xPS3PV+iPlW+0D7xG1/nwsjMDx5zcMyP1OieMX8959Pk9jTxxCVLvHj78Sh5Zgc9NMZpW
 +3vu8UyZp3qQqIdNM1gg58mAkr9idf/2JwtCb/xwdkjc+FOoCHX8qVKV8iBnsWRoGBuZrgtrlOH
 XSmPkjB8VdUJ5bKTK0E9IVLanCqrvNWqYLKM9WZIt5ruUGyyCFVx9SUFZadQf0r529Az0lkXoO9
 rXynUq42H6C9kx3yRsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140140
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 +++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ++++
 drivers/gpu/drm/msm/msm_perfcntr.h    |  9 +++++++++
 3 files changed, 28 insertions(+)

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
index 305dcde15c5e..64a5d29feba1 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -35,6 +35,15 @@ struct msm_perfcntr_group {
    const struct msm_perfcntr_counter *counters;
 };
 
+extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
+extern const unsigned a6xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a7xx_perfcntr_groups[];
+extern const unsigned a7xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a8xx_perfcntr_groups[];
+extern const unsigned a8xx_num_perfcntr_groups;
+
 #define GROUP(_name, _pipe, _counters, _countables) {                          \
       .name = _name,                                                           \
       .pipe = _pipe,                                                           \
-- 
2.54.0

