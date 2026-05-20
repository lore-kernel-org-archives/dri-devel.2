Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EC2CD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5055310F0EB;
	Wed, 20 May 2026 16:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFnma6KF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fa4/cbKh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5351C10F0D5
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:30 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9nYkd446952
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Uh+8YeArH5l
 xuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=; b=iFnma6KFpjfHQwCvKa9dKg5g4oi
 6huJvHDvSuAhS3K03qgn80WzB73AmsXS41pD43k7kETTl9GtIh19uC+UzHn2Cuzv
 7B1A1WS1CCXleHRg8nLU+UIBpEbJky//YPynDPKivBGngzjAIpb5GcNtrIFLIK3J
 /owtwv7ChEMLwkVmcRggcoUZtmm0Xri49bJfAxCovC0GMlcSk5SPMWZRE0jkisRx
 NFQmuz51khnH0oPI62wzj6G4vOf+J/hA0SFZ5RYqNpVP6syyjmE0zpfGkGLhfwQl
 aawwdOnhp3CteSKb89k1cgDnX5gnPEioRAoyGkoyOJM6q2SE25+m22R2jjQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9anrhj48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3662668b825so10204560a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294328; x=1779899128;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uh+8YeArH5lxuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=;
 b=Fa4/cbKh2USsMJeBQLnYg8p1FzxjtrRxdTxZ8SJKjMbo4SzEMUdG+mEoX17qu3ks4W
 6YBnrsLko7REoBxXb5wkp8sVOOVxg1Ihs263goaFj6xF8YcdJjWFeOFE0nIO0NGRXOrF
 fM1wy6Zn0ExJRnrb/uanXUpOAqhFKdtqqL2IS/rq4Kp/Dglf9j7KgCt+QXLR6SuI2ege
 JfWtN5OXL4+/Y2kf19IZIuVHqHDKDulbRnlx9WPWF2Q86FwSn4yeCaYNYnRQmxWypxhK
 cukhukOHj1e1UL+hN2g22TOhbKm0KTpjVMEO0gIqTsrmtnZnAm/H5fUv9R2Fis7ZvBes
 7bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294328; x=1779899128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uh+8YeArH5lxuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=;
 b=U2ge44vBUg5bQEYktsS0iBZVQSwKWIT741ZQHP40XOkXJEBaA6VnUXwRtfFUFggVlD
 8TyP8xCFiYT5GExuNmxR0c+dsBUkKrVyj9taYxQSO60HKaDL2HDgIKdwKkpyot+RsMu1
 yr5h9nrt+5fC4UMoec+dpG0stTm1c3jjps9ixEYottWmtOkl75CSvt9g9dzYrvnkoids
 gLmz8PtXBLuZdfcj3MAU65tf8Os0WqklbX6l2cWsEhYMlIMoNo0k+w/PWSkUt/XUr50s
 2z27VuwAJWxR1R8Yg+PhpcAzNEPNROjd6VVuZ5arnvUlSVzD3ExeupgHchFnKuwVjrIq
 5+Bg==
X-Gm-Message-State: AOJu0Yx2ojcDcFZDSwR01jpSQC+v4d113XzOpwDSSlLcyZVj0MLnV59z
 KTeTqHc2a9NRXY0elfm/TZqvKbstk5DdJfaF3ZR/OOwBMowpi//V1X+nB4Bsjf/T4gI3nTe71GU
 DQYYm8p1o0qZCmQUN7cqFmkQ9tA6U+9ynLpBGSeQVJhdLbX0iQCnPkuEAxNmvUn10dHSCoLiwba
 cfJ6E=
X-Gm-Gg: Acq92OFuesHokTOrVvVji9G/dHIq5u2CWNUDYr6zVtBJxyYmb1H6rkFf+4ZeRdC0cRw
 aAL0aQYjrJafBZDpdKaVCZsbUy4n8KhBiLQqG3jzw0U5cRGGflLeT0KjdsorHe4RnBS/7lkDCuZ
 ySndbykXCec7LDI06OZpQ9xCaLN8t2lyVL+1IoPFCWRS6JLoldD1Ge2abFmEIziIpfLAB6dgY31
 +vNkE0RkJ599vvzB/k58kQFInOX7WPdAzVGDAYMGVjO6bJWznb6WNF/nY55bxYpen9XMoR1eM+J
 Oh0k6sqQA+wVF29C+KXCwiTbMEWcq8I08sNfIJP8qSibVRmCHLHXfqtd8D0v5dNnDWi5Rrbc9pt
 5VHJ+FOiaugK9BKL6Qve3pxEjpzrbyiS0
X-Received: by 2002:a17:90b:53d0:b0:367:db13:aca6 with SMTP id
 98e67ed59e1d1-36951dc1cc3mr24889534a91.26.1779294328092; 
 Wed, 20 May 2026 09:25:28 -0700 (PDT)
X-Received: by 2002:a17:90b:53d0:b0:367:db13:aca6 with SMTP id
 98e67ed59e1d1-36951dc1cc3mr24889499a91.26.1779294327641; 
 Wed, 20 May 2026 09:25:27 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cc56cddsm114371a91.6.2026.05.20.09.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:27 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Wed, 20 May 2026 09:23:53 -0700
Message-ID: <20260520162454.18391-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: m671HoLy9Q8rJJ3iMw_LTdDVnqsCNe8Q
X-Proofpoint-ORIG-GUID: m671HoLy9Q8rJJ3iMw_LTdDVnqsCNe8Q
X-Authority-Analysis: v=2.4 cv=UuJT8ewB c=1 sm=1 tr=0 ts=6a0de079 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tmZHKQuSfWdd6biKE2QA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfXxj0x/iDojAJ8
 PqHCoC44hdBoQJdboRBdM8p5agNjF2tIiLNVjxDfLzrs0iBtP785Y6UzkawgP0bB4Z1g8ZlIcgm
 cz/NJf72YbdXDhn3r90hizINs2WZl5FpabkVUf4WbvYwBrUyYftncwQqESHnf3PNT5j9jhE25An
 RezJIrBt0kkyr07KErRHNXdzlrihyrureSqsc++4TdH0XJFGTRDRK/cGU+s5VZKSq+ieOImjREB
 qTM4lQp5sKxsulwluz3CEu6C2AvQcOtYZUixPRqe9SHmP7eUV1gb168A+QZnQDpfB1/pdKKe0SJ
 F4mt7itv1TjLHjRv3gaPQ3Lj3r2ABCRtbrCz0Ke//CnmfokmA0/ekwaA53G+yKM21kVh3uxFPxa
 LEGvd1ptjgUuySxUS7z65EZyTeqQAgSk/21Zy8wbMFaSOMfAE7Ge2wF7CuonV/OdrNvJSElT0EB
 92aCH4e+qTadxJuCaXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200159
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

