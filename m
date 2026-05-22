Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E43BCD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1B10F6A9;
	Fri, 22 May 2026 17:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="air3kRtD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VVdISnjw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2875710F6A9
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:48 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MHY3RS1800770
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Uh+8YeArH5l
 xuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=; b=air3kRtDA09Uyrt7IzbcPzQktN0
 kG6T/kwCP8BohzLfrNGshaB2Tj39ogphVQDFxhFyb0927MiL0dB3UPIB8PgpF7AZ
 sYWu0L8jVbACAYIpD4VGDPN8JUeKOl4VvQ/7mLoeOlQJq0IHpE+LPKvOb53QQO7k
 icUWQlb4hpwktDGNiBf5aEBhX+cS/5MPDBc3dNCAU9NhKgXqzOmnIWGPK0H+z81J
 2l2AJm7SapDSBzvjHnHAQahMw2Ap4snWuYzDRKy3hOvnjX9t7GtiiXLdlGx0eOry
 gwgch9R49yjlqkP50XMbiNGzpeg5w8ljB1KeUgvnKIbxYuQGXyQ3Zw7anIQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ean9g1q69-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:47 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba224c3ffdso179690935ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471287; x=1780076087;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uh+8YeArH5lxuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=;
 b=VVdISnjwAxdY1Bq6dofXlWhNr5X6Jk7z2crgVvbYIo5WNBwetPTzu/WNZcKvDO6D1H
 x0ichHKPKARsof/uvCIqWptaO8jfQarojNsO0Wph39L6246skXZ96Cg6UYH3ytDEIfTa
 rzp1ZOjXhkCUtxD2fo9mxrdWhNhXVmsmvqNFnOBihpTHeY7o0SNbsH3IWvbYmKLxFWUn
 6xgpi9+g0YffGl1JPNd/PzVKQplyTkO2wAaOuVSwfd7ovXzYyOS848L1R7UmZqo9ImXU
 ciVfXPacMyn9WQJBZ3dW+p0sZO7/Bo6EcfFkkRyVmAzsPcDzPkDbjZpi69KC3S27U5OG
 GbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471287; x=1780076087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uh+8YeArH5lxuIrq/0DkppLWphYU2zvQ1bZwgrXCWVs=;
 b=ES6KjZ3duR/k7+9+X4mnU1OkpfGDS9POOMcBSbtRXtiuIr1PkYIlhSwLuqyH7UoUfz
 2sBZPWGHCbZAAPsjmqYMrnQD8yd04M2CqZRNXw3B5QfSrCDMSg36gO1NrlSAQ1kuOlZa
 5pQcHL/A93EexWZDYv12AR+llUqlXks1JExdRIcqWmlLImEJGqTYMFnNbQag1ZQsvThj
 Mnac3X4bGo2WayL3KhwXp7CIAhezrqH8Gpfd8RBiAnGEESiq7D+4EJdbEa1tNifrc7RZ
 5AJkCKS9gNPz5kvF2bES/5K6CXVa4K3bQFECFIaqZkXpEU0XNHLNyy4+GvZaoiK+iJRK
 FW6w==
X-Gm-Message-State: AOJu0YxQdvTR1F9yZp6J+wRp7QJdBJXZY9oRSEd6wH087MtS7fe0osVF
 /RPDPX6BGl4ZDmFR31h4rcKqsDfxRjnnjV+SJr3ZQHdS6Fnzak8Urr0FbI5hJPaRM00AE1qEuTg
 C17Qn4bCzMwgE6O5YJYkOxl7JVi+f5nEVEc0aKtNhTesxpJdB40J3C3swsELk4q8m/jC7y9okM+
 9qBY4=
X-Gm-Gg: Acq92OF2u5S/wM6a7vxogMHQT1SKjlPnzKM1ZYsI9YXoi5Npib7o1NZvOzgAcTOCsJr
 mAZtU/BRzYagy/+xsdAaUa5NUbShQyQsBb0NdRlhlrxKUYFUpCIZ4/eZw1f/IVnCRSp2ofpYROO
 3fPgA4BSAbqfUzdCiu/kom263fnFMFB1jypUh7YHSzFS+pWHXv2ugBXKAUWPW5RL8JkboM9fK4H
 9XFi5EAJzyPI7g54zdO+WzKA02jtYI/18tHz1UAhuWlqgfbr4WN/MnOU6z5pNEfFK7mkJA7Qv6H
 2+o2wzr4k9eGJujP3BGkjfOAHrCZx7YIWL5ARxuZEsalzCUzCkfcZHQ/KTPd8Ky274dYwit7DEX
 IxnJ4Y+C2QPGXJJJQq0D/hAZoNrV0HQ20
X-Received: by 2002:a17:903:350d:b0:2b2:4cd2:e162 with SMTP id
 d9443c01a7336-2beb065aa18mr50980535ad.34.1779471286965; 
 Fri, 22 May 2026 10:34:46 -0700 (PDT)
X-Received: by 2002:a17:903:350d:b0:2b2:4cd2:e162 with SMTP id
 d9443c01a7336-2beb065aa18mr50980165ad.34.1779471286487; 
 Fri, 22 May 2026 10:34:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f9100sm21464675ad.37.2026.05.22.10.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:46 -0700 (PDT)
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
Subject: [PATCH v9 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Fri, 22 May 2026 10:32:52 -0700
Message-ID: <20260522173349.55491-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gv9jUzO8JkDTpcnIeuWv_-DKrBOpHHbm
X-Authority-Analysis: v=2.4 cv=B/qJFutM c=1 sm=1 tr=0 ts=6a1093b7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tmZHKQuSfWdd6biKE2QA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: gv9jUzO8JkDTpcnIeuWv_-DKrBOpHHbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfX9sE8kyBXq//h
 nHJBvMXilwroLSdqBJIPQzX1BK1O+qLISLkg1dmWP6kbdV0uHSKC+NdfeJ/UL35HkLAfiPgESjN
 A+4JSmhh9h4sJbCyJcIUZQwLasZVtt4VcwlDbStg5uhVFLVHgaM/zkQgjJ+MWvTCwRTle3bKody
 G32q7XQF78y8IOo5+sChB0GEuhnA67TKy+lnuF4yFwTnD38n1z/tVq+9ZoD6iZ+M/DY4aBnmIig
 LCefid3Y3vrdY9u/UignAmEDamCMcGwno3ifqacb5MeTZhDhrVUAC/rlxKOd2/UXe/Aj44K3IHx
 M++Lj49I4wn1+66hCQk6+BoUz4lC29nCUSpGOwgT+hVj/QLUttmMdhpjPJfMT0tvnChJBzlyYNS
 f5vgxQOGOtsjb3KFMmdBIvXpv09t8nDMvD58sM4nidNf3qiXmnHQ7V0pppqk1741283hGoZJagg
 wAu2iPLBSvKgPOnzOQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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

