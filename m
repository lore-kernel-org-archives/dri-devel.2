Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADE6FED3E2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0241410F5F9;
	Fri, 24 Apr 2026 15:12:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lcsx29i6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyWo9VQQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 636E310F5FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O8iYPl4012181
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hqrgam/FCMU
 6TRDYGic4FvNbNNuPhpsx7Cb0DIkY9Rw=; b=Lcsx29i6XWCGLkBzXoFywk57VYU
 CgWI1XgAfl7h6ESMlUXBOHPZH9N1NuzHYK1PybY3TbegLNfKd5ZDYZVJrwZLHB+e
 qx/R2rkP0z6bhyiqD00UydYh+eoXtBITE5HcJHGuaKZPswdv/NMG99BFXz9tUQXv
 9RLwT3lszlGusRwv5I1doqk/xe8+ucW2Apm9mppDy6OGl3pcLsufYrB3DQD7ID1K
 UpGMTOflUk4y1fGV2Zz2HYj73Vfl2fVNwsBHPVn9WZM6/Wz6WiCYGbncCMdEL1aB
 4IBEdLfo5S6R1p6picxGotbZiMGNsRjrKP20KJJAJjgFmtCgHdLVoj67Jag==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqpq9w02p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:07 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c795fa31e18so4108660a12.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043526; x=1777648326;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hqrgam/FCMU6TRDYGic4FvNbNNuPhpsx7Cb0DIkY9Rw=;
 b=JyWo9VQQtgelBCuOpSOw0CJ2T1KeQZZdWB1nL+9WFxqiWi+tw4M12KOAFOh2+Yr5+U
 xhwuX2x2l7pjXP7jVfDdLkRrFOCjrJU7Mf8GSCuDU1EZcbltaX6cMZC3VHXs2asPnRhA
 UzdpEy14zswYmN1yXEmixnzZoLOPmwu0mX7K0zgkDHKYAxIKvKv5aAaklXf5i2NcTqR0
 oQStDVIhZCaKJNF7zIbcpPG+9huXT/uSumXyVCtvx7Dr3LsP00wDGpuOHS3/hSFq1Das
 bEgA3FWzvtOtADOX+T0DXF4x58jecycSHXUEmC0ll9P9XVMk8s1T575pfGnwtALnBAe+
 4K6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043526; x=1777648326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hqrgam/FCMU6TRDYGic4FvNbNNuPhpsx7Cb0DIkY9Rw=;
 b=FbtJXglYc/KKPC/cZ9CgV6+Kh2/TK1+Tahng2yHZHKcgZ+FXeJNwQRyEcQZqy8zKh2
 KGSNt72vA34aM16csghkRGBC+rVHBG0GUYWhZtGIjO7gTZnf3DfX6lwsfIRoVqyh0TTm
 5JKoQY0XbX8uBoU/kjv0egXMk4ZdzJ603Ecg9nlP3zuQGiBqsNbM13vCvYS1H4UE8gxA
 NUFdXy/1rZMs2p6ATHRo3nNY553VS7Si4rnGNr2XVWkwEmTx8Kl5LIcAkcXstOY+25+C
 PmNidqlq/G/QaqisXJETUm289wEvbVTJgDym/B3wcD8cFBgGKicQnUF7i+cUIY3lUYso
 P+tw==
X-Gm-Message-State: AOJu0YzkR6ZSUJZp48/J48EM0oYC0niaiXkuoRXeON200hWWSHKwuTb1
 +Sdt4kd82n3xtSSNFu8lDi+GQtbAWVP3tiMlIatZT/vCmSTs4D5AnSRgg4APUZX1Ks4M/qcyk3F
 gM0XRf3syZqAe5UNAlaTArJW6B6KS1wIdl9MqdJNnNCWYz6/4w4++UjrM7RwyWHRQ5VqDzTaiUF
 KONf0=
X-Gm-Gg: AeBDieupi8Qk4CM7LpJhg9i8hiKXOCZYXubhxTNEiMZow3LBhWLfDtUaAUpWP843I1q
 T1f22+RSwtStMZODRE5PlTfbI153FMfJuxVEF1QR8Hz2m9ARzBFq12LJ81YHyzNKD0NvGT9YRt0
 4VzLFYTE0vq1KNU4XXGkOG8ngppaFhG+uBGyaS0Q+TGW96UDKdGTqyGk4PYNpZxSzTAvlTEN94L
 NCX5gRULKKsBnFKucx72otb0fy3r+4Nb61JjCNIYGe2a4xYk2IcY3PTyaWV83xxmd8eaQBhYfd6
 LlGXmWYMw1BU69ISjBcnuVJVQPakDoVhbYKcrc3yHfivMLduTvAaXvisxxy+3jJDSP74FjZhczv
 K7fHkp3WRTTjrI7fQOPo7436H2jzFRh23p4PXICdvgD4=
X-Received: by 2002:a05:6a20:7fa5:b0:398:a76e:4ad4 with SMTP id
 adf61e73a8af0-3a08d76d92fmr36814964637.21.1777043526266; 
 Fri, 24 Apr 2026 08:12:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa5:b0:398:a76e:4ad4 with SMTP id
 adf61e73a8af0-3a08d76d92fmr36814927637.21.1777043525796; 
 Fri, 24 Apr 2026 08:12:05 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c797702faaesm17883136a12.23.2026.04.24.08.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:05 -0700 (PDT)
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
Subject: [PATCH v2 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Fri, 24 Apr 2026 08:10:41 -0700
Message-ID: <20260424151140.104093-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXyKblSDHCPfgt
 e7/KxibOSRBhh7x54Gf2Y7X/sj2tV2+YzsKcqsoJrzSQTMcU3sIqzwYSta0I8Lhns4puASETQpD
 OYZtVUbWGTBwDKX5AeSFfz3nFiPwkbwLvLKPsWo1ZMPHvvoF8ttdXpjmkJK1cukEEcccY2C50w3
 mvXhk3JPa8CRpZebKZXqmMgpKzuGrQOMDpga4A2xevNr83rZa+H/RDghn6cWULga47ORbFfrzYq
 Sv6HBsdRYucB+eD/6HDKhf6KMc2HxaPHmcKylbrgv89fJ384hMHtGJ6j+AIOZog7dk5Ics80iOy
 KQkadN21bUXdPfYa5E77+bMU/XFaxuU+jujumb3OaQjSlsqT7uDoK2XrtG/BVXAaUciUA2AetVt
 SJHVtoAdNnvvR/3Jae3Y3JCDk6m5ytgPoalEFLjr/k2+ZgrIxpkHdl7aSYKY+fm0U8FQvpz+mjr
 pcVqJzyRIEKwdNm2JVQ==
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=69eb8847 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=UuwE4gOO9k-hs8zF27AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: M3s-XkegPh0AAPPVOcDedmPywQZB-FLi
X-Proofpoint-ORIG-GUID: M3s-XkegPh0AAPPVOcDedmPywQZB-FLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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
2.53.0

