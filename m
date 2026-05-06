Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A12CD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091E810EE4B;
	Wed,  6 May 2026 17:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4vYDOcS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c1BYt5h3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99B3F10EE47
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:11:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646H52Kd1953121
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nY8Zf16hfaV
 mHNExd3/Edt40koDFD/E4yWO1TVKH8HE=; b=a4vYDOcSiiN0dP9oZK53PrvzSbQ
 DrNMA7b5x7Z5P7hOiM/krxyULrnGlBcxln28lKPS1ZFk1SwSRaoEK83B82MG9gea
 wgHu4ACKegp17Qk0u+5w/yl54nNhTd6MLuzduSYk+GT7DUmMPjqQMlKFuUGXoccv
 o4YH/lsX7DN9VasidTp0SvECj5laJs4QRdkdQOE7f0PKpZRB3Qd9SC8MvJFYvLlf
 IKQ5ENPpzB/zWXfwr0vggL0gaq/xdfjlYZW2upDwZgbi241UtEXJmzM4Fe9VyfIY
 XY8Uy1jekKAzPdlZKonU48jO2MSgUnnrHhHIJZMGLdoddCfX2Byhm1BAGxg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc1mhq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:11:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso16072827a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087518; x=1778692318;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=c1BYt5h31Lnu8CCtUSX4LI2Bg1i0Hg17wpgk7+RoFhihBAtGTEZNlCWvaZjfCn35Ws
 KX3BZUBu9rsu/ZBnXjP+3EhSXukop4e0YKMiOgsKOfExwjDU1iD490hPTSZQc5ev2wuv
 nQ9HJiDWCDcXCJslEYhVR3HJQTQ6oB644+HgpBazv6Mc1C0VMmiptkAeqOgP/lc2QVgv
 Kyc23cCadbuaWkVb9mUIHEeAi/29jDE6/8wI4tftOZ+JO26ahaPN2kLC+98rM9VuqLn8
 UxxZjYHsEq7yHpU+OokqghBukhHvoopVuubjhYMEAqlwlmE+tG9C21Lj38hgt8b36Wci
 7CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087518; x=1778692318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=b4okL7AB4SL8Sf6jQUJm7Rt7A3ljtEgHXcXcOrdWvuZZwDUh7Js3Sq87ccN3qbYNA3
 RXz59FaK5Khi74Cr0K1QAxjls2UAXYIL2PVFoABblVcAwc5oTI3HEtBBdEFjwdVCfg3C
 X/Cfj6GiUZTBuDO5A57DdrULb3XBU/P2ulaYraOKmndx9LF9uEKigQAOgV/55b8ea+wx
 f7KPc4fFpFpIQODo5g+mHFz1cMYkLGjnRbqS+QQjSp243hziizBJsqUL3I5JNROaWZJw
 xC29YRRm0Yoe7yuIPvf3MhIc09VcEas/2hMujuuQVJ+3MhkcpiJ+4D00TgVBKNIo6/ix
 pMxQ==
X-Gm-Message-State: AOJu0YwEU6OTpQEf+EAN0Y1lBObtvQ4J/BUr7kuhmfFRSfMtdTvs0CwX
 8wGZUrbcO485XN/liiJb/rLhzsu3zBrWBkdAdn5k+JU4PtSHVCtoF0VCsJWmcSiZPlYdFeziwBi
 XrLGHY4lZ0d1xsx9VAwpJt3IpRtRncEl7QuKK25K5HxupBOkEd/NCMy2kcrKbzsnmLBpxs7q8d5
 Ogn70=
X-Gm-Gg: AeBDieux7quI2KDNpxkVTWqtXbR+ski6kGsKIAaTtMBEbgor77Pm2R9Vw3AdekCobTS
 MR9KGu7rIsf0JAsQlYSoZI3ztnTDtaoSry60DSKUptlxwLB/PeCPgD1ygUEsJo/wuTHLKUlXsR9
 xf4c0cvw/JBdS5nhxrWcieRaRlnI2U7680kMpRg4wjeVWk1DwvuT9YdVCOvmbjvbb0SOSgpOUJu
 JNsz+THIyhy5ypIGCXu3XDODhYCBCbqFKr6RwAliMTUaRpmwFw5YHpa9ql1i51eHOwBgSTtx8qU
 ZyI3u4uMWSbd6SLITBG1qWtRB0jqqs1BiHMCxmLCG3RRKt5r7kKRXow/yzuTNeHGwVipVKPztts
 RDbMBBrjhdUxTBvfJfdRW6yduzktKKSZj+w2jASIyvR4=
X-Received: by 2002:a17:90b:4b87:b0:365:46aa:e68c with SMTP id
 98e67ed59e1d1-365abe79170mr4073662a91.15.1778087518038; 
 Wed, 06 May 2026 10:11:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4b87:b0:365:46aa:e68c with SMTP id
 98e67ed59e1d1-365abe79170mr4073619a91.15.1778087517517; 
 Wed, 06 May 2026 10:11:57 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-365b4fb5f1esm2963395a91.14.2026.05.06.10.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:11:57 -0700 (PDT)
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
Subject: [PATCH v4 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Wed,  6 May 2026 10:10:30 -0700
Message-ID: <20260506171127.133572-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX6MQkoC2Eq5zO
 JPGsqHOXvW54bAmGTVqqI6IyibmPkdXYQCScYWnq7oW40lnO3O4d8GifEGE94cAIvsw6rjJbsZw
 0h50B91iflyYboCy2F7VJ3ePwOF79lpf2rSCLIs2a/hcoTtMLI8N8ccDy/uzhR0Mik7mWp9vguf
 KGELiSef/54pATJMggoKqawpMHtoUtiK+85SV8AE0AWL0t2HGnqK/ScDvUdFrolUsQB750Yf+0D
 EF/gFWYQL7NmjV/7SE5Tt+H/2dtCuiD8LsGWfJiljDEepb2FpUoKtd3E25g3Lr3UWwwPPx6eIJq
 T1JdJz6u3yCX7SrxbXUzQPQ37cR/5vajXEBDI0UjZ/RNw4xxDyFx1ywZLPYYstaWlR/m1vYtYzj
 sX/4SdBFWaZdoF9FTliEi+k0opgaifbJYfjDeq4kJ5vsZTV2t4bpkD/MbOM6UbR/mwpq41DBWMj
 CkRqf6QsA8IIkKHbEyg==
X-Proofpoint-ORIG-GUID: bfHXoVhNkhHv8rsZhm0wyT7-Kl6aqxp9
X-Proofpoint-GUID: bfHXoVhNkhHv8rsZhm0wyT7-Kl6aqxp9
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb765f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=UuwE4gOO9k-hs8zF27AA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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
2.54.0

