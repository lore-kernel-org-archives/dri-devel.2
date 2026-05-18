Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F2BCD343F
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABECB10E7E9;
	Mon, 18 May 2026 19:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="obDBykG5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eM+1mqaP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D18D10E9AC
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ICFwNZ2701093
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=M7rs8SEMK1L
 Qu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=; b=obDBykG51Tmw9P6mDKolMxrix7J
 xBiEB7C9CjZuuPVFYtXWUVjndJLAE6MdHZn2XqHR4bMRMPryksQBbjdlPJ3MKKmI
 Kj8QnxE/0e6XMI/iQwMXQYTHP05UI64gUVvJ8X5ZTdoOP1i1dl0MNbfVQymqWK7S
 4ePrkhPJ4p8hCWYv/NAO8mSXLh2EefgrECHmIzGsYEFGXL8kbGD9aPP0MQ9Eplpq
 Ijctdhl1742NTTkAvE6+CLsiSL7FeJOd4XYJZhTqqEUtswRXWJlMv/L6Qu1rZlh/
 i1ac5QTXXUDyNHnadXpnwuLWYFdB0lCCp91ziCBrTbAEgA18dXr6K9WRENA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82mehjxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b4678c6171so28535475ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131295; x=1779736095;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7rs8SEMK1LQu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=;
 b=eM+1mqaPAJ69WqRFlidGCnDyqjrXT+oaN0jh+UQuBAQgf88uDGxHRzv2BPNHG8Yjy7
 dVElYerB5+mfQ1O4fbEOQc2Xkd2yHqjIjV8Ls6g1RKQFr5trYq9kPvLMzbGDysXYwi3w
 DvdwV0Wu/IbDgdm/u01VNoaZnTRBqmPJEVZUjV7Ps5+UXN87Vj/iHhldfKflHe/fJx23
 FW9MsS//0z794etknf92nMSksYKKKZqXEN9t0ESel1tDq5Y726JvHD+0qNI65u1zvEh8
 lWzUcn8ZVhntGpeeIUAASshdNTW9JP3bB4b5pRk70c8BVMZRBLxwWOPXWREcX9YFKnjX
 LpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131295; x=1779736095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M7rs8SEMK1LQu/2/xiK9f0eSs0YeYPU7CAo4VX+afCA=;
 b=fXk2YXTYY3GXMTFksEYI46SauIr19YRmZrsj2I/wo+MKbMvb8VQrikPeG2nQIZ8ZN7
 +AMWXSWonrZ9B776HGqpMT2X3ZAQBpywxjA+NQQtb/YE6fkOtIneSICfyh7p8tTBeZnY
 bBVVA3MkYqVeQLdqrVEd0i0w/jcgJuMYqKzDlTYkLwqw8v7NA3hSO3KLG1Wx9+lO64iy
 yXFWQuO/1p7spWG20lJx0jJK37+V+YZdETmROa3RPLK3I+cEtH0CjVWmhjQfFRFAp8ag
 Kpiir87Zb6UPFgoczM6zvo8wU9Qc3exLASSDNCnvGphQWVRjp3BK0vC2aQZGfCIbdrpH
 gOUQ==
X-Gm-Message-State: AOJu0YyEKhxpaVdlQKrWCXo+jGYt7OLZC3nCoqJXas8gB4w6WzYa45cZ
 8dGtjm6ZfqQUWujiEuWgGZRbO/a7tHoG1jTAcb+U786oIw4eqbveYSe7ud+Yhtg/duO9ZFjIMPX
 wI0RvpMF/30qwAxl0GI2/e453zfIob8N6KlPWaD3aMJsKKk6Cqn5jO1VNCDrnW/F7v+l4U+HsW0
 WmWss=
X-Gm-Gg: Acq92OHG0y6pb3vWIkVORatDj1HLV6pyT9+Kb5A65f5eEDL9oGayMcekt79POt6bUVx
 Atv+ommUiRIteBVbRHDxpyHLf8dIPj2fHCZxcjmw5mq0jACOmxqZ+r4HkT4oyYBi1dqGavcrprm
 kGdgE9RzSoG0drgljBbPK2ntKyz4lcnUJipwT6MFeVWweaEyg9gWbplW44Nd+gRalnqxSQtXaI2
 d5KQISJMjJJ2uU9sNt8KXfqqNfoFiAXmRrogFnOWt5QTJ/dN6+kCm81Ps47ukM7IAkkNAWnyVdm
 1Zu43RHzTqtEMOhttrORR9Jrf9guNUT+nI4313VkTZ7Ty0InDunHTuGmv3U5or15XFA9RXtu0wd
 vg674T+m2EA8lCF+lww3p0CjluS1tKUGZqXrQppExB+U=
X-Received: by 2002:a17:903:24f:b0:2ae:5629:ac55 with SMTP id
 d9443c01a7336-2bd7e887498mr171542895ad.21.1779131295076; 
 Mon, 18 May 2026 12:08:15 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2ae:5629:ac55 with SMTP id
 d9443c01a7336-2bd7e887498mr171542495ad.21.1779131294566; 
 Mon, 18 May 2026 12:08:14 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11ce67sm162668925ad.74.2026.05.18.12.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:14 -0700 (PDT)
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
Subject: [PATCH v7 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Mon, 18 May 2026 12:06:33 -0700
Message-ID: <20260518190735.16236-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b63a0 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tmZHKQuSfWdd6biKE2QA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 0wMYmqtl0akmmIjjO5ily2pkl1IQAV61
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX6tQZmkIC3ARQ
 xIZFzcE+PkNNuGpEKDVI826GDSofhh44GXnmKXMlW+sdhvWf9gRhGPYTodxH6EvxIK8/zHAlHKw
 w6x2RcycN3eois9Hl1dTVLGXjSUo2oD/mVjHJPh5pFccJNRCrkrBXTRx3TuOPsdN2vItrjPCxoa
 CfV48aYYlOqgQ92SW9k9DvJyp6/y9WGoUO+3HTxvJbySnmFrbEMimy3j2xHhe4c6Mi9a0XWFOQl
 ohvRIDmIBZCMUD65NUobacHSoV/OBj6TlT67d6gyePrhw59XzdSGeLyvrs1GgBq7uIWHob45CJn
 6YVG45pHvaYzZIXi4rQiBzy6sk0Xkz0eZXZLiRB2vIu0KIu9mooA5sF/URUQFz8RP66eYySXhJV
 2ENRkGHeNDhQ/DIepkx/2AkRZOmTBh29a/SBOMe33f8U+aBGNDYRZBb7AThOV6MSvQVzRwcVmKb
 MBTKZSmOUOrRQEsxa4A==
X-Proofpoint-ORIG-GUID: 0wMYmqtl0akmmIjjO5ily2pkl1IQAV61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180188
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

