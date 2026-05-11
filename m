Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F111CD484C
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C2210E76D;
	Mon, 11 May 2026 13:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="onziXyfJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TyraEId2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FE5510E746
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:17 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD14H4452800
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nY8Zf16hfaV
 mHNExd3/Edt40koDFD/E4yWO1TVKH8HE=; b=onziXyfJAeQ0gE0fEb2+dLroqHe
 KgTRLUHSAKybG+MaWZLxrAxISf9bPlYYP6NugrZII8vKvB++LGWSZGj2XVFFur0E
 CTmNDv0qm09T3zwqqqprJAoAI4XgRcnDiMsi6d+c6Q5gngnTrx4Q3Y73cJkl9Q5B
 wAbevurssyaYHS38TZjHUVukgegJuAitLP/BzGLSZUJWzIuWh1q3wVl+Dr1NUkrS
 oIbSovLL5tHWhAh1bcGS3QT4j8cmRHjHvYdo54HVIQvnD3SGCt/CFUQnk+y+nq1q
 tQGQQjey3huLpJXAm5SXhqrXIzrRt8UQRHXk9ddhcOzzlggutle7T+ZZVCA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h6gr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:16 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365fc4636bbso8295773a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504475; x=1779109275;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=TyraEId2FRlX8zy1LyvocQ2PrBuuaHiyhD+oRNFukn+glXc7ggpR6iXaJjQyztB/vy
 HbM6jp93HbJ0z3GyoFsLKEDwvrkReViDR92tO44bwMwSTjAXQUXYWOaqcWB4dpdZOwTi
 kPwXJqwLrrFc8IZb3oAP/vAT2mpkqCU/U5gKWNQWWlJ6Dp40a1omJXZmL93NbHQUBWKN
 2ZW1xvBoK5TpD3tlFIQ8N8CKIRkhAe99Od+2h9UFrGqf+qPQOSdEzt+kWShMFX8vp+LX
 SnQxSmzuoEBMcMWVxJq445tu+7pm/2Jam2cmwFbfgYjU79iznjPxHVT/hbhO1IahgTVz
 Nn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504475; x=1779109275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=q/a4Jjjo6Zq6fAdgn+BONQp23g1GP78Mpt0O2/bsy9eb0a3fm44snq6OfmXknj7JKG
 rsH42x18M7EWnVJMIjrWD7cNgMkv3SS1lsRYj9PSnCeyZMa44IsceZGte83vgt2LU4Ey
 eR5JoZfayBC2YMShRJtaOh9iLg/Cv/wW9jKq9CnA8IrqZb/Ro+4SasfqAInPsGk2Egz2
 m9JiSVgirS9Uy2bhZ2GU/VOMHUicE9Y10Ab18Xn5jA4RjNeQ5zIUrLTfVCLPmVahxM9r
 zo9KIEJfk25MW9EvT85EVFOUt+OkU6VX0CTriBWXMIo61R3MajTo6bCuQlXrUo8Rfx1o
 ccAw==
X-Gm-Message-State: AOJu0YwJT/VQD8OU0IK/crbsbjelke10GA9b8aUN4BykQ7yVGbcOubz0
 zkSovEGKHbex0/aj3uZvxJk85kcbKTBpEapW4o0nX3xmn8QJx/alOYpN6b6IRkgAm4Ue6dKQBtE
 Wm6wB+tjUSeb9cebJ7ohMBKaL6Q1j/aW1IKns0Ci5kPk/7r1J210+DieRGMfP4hVpPaAY6yA7vQ
 IIopY=
X-Gm-Gg: Acq92OF3z3Y1Hesa+Itwmf1Suk+QVVk3ERGuf/PlixbKNMZVtFsOEvDJJRyMAJt3jqR
 a1YT6EGU+0qFgCL29rRxGryaPrMo4BQLwp3mlbydoQu0TxEF6C/oUGFJc6D9Giyau8IUPLUvFwR
 nymUfvCm94kANWnwlitSQVe0duf9MUOp4yV0OHNFasQGd0zXbpD4go+9VgcQd56iMEi6zuaVd6k
 xyKKZBqnXe/efRSKPmO3Z4hFLUXHK0P0j36lJRehhINLiAe0o7yR7IE6MjMaA6yZ/PcFp+sNUKS
 WlSqekn8WsyMJQpMjbT7a0Z1S/7LAXbAA3dElGOcqii63DL4iI+4Xy0u4RykuWrj5XQszxVzM86
 mw3rsim2fp58XTsBFtY9nkFuLCITNkAXn
X-Received: by 2002:a17:90b:5746:b0:367:bf59:6f99 with SMTP id
 98e67ed59e1d1-367bf597967mr11496079a91.26.1778504475104; 
 Mon, 11 May 2026 06:01:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5746:b0:367:bf59:6f99 with SMTP id
 98e67ed59e1d1-367bf597967mr11496005a91.26.1778504474449; 
 Mon, 11 May 2026 06:01:14 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d623fd6csm10370504a91.1.2026.05.11.06.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:13 -0700 (PDT)
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
Subject: [PATCH v5 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Mon, 11 May 2026 05:59:19 -0700
Message-ID: <20260511130017.96867-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d31c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=UuwE4gOO9k-hs8zF27AA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX+lXpdTTGqyX1
 t640R8/0tSkzqsQRxJBVWyUVTXiGjebeFUT5gVu/IaQiW+adfgfxtAKWXGQhwiBaG979AJGNhPj
 DRTVCp9g8g3247xNF280z70d6GwmNPMer4uZdPH0sq52e7gHd7GFDj9gI5GM1dWvpSsCkf+QXlQ
 SZ5Yss9M1vzcJIwLukaWYWictqDd5x76bkuy1Ym5lM9RsbwexeKilpAwAQCPGu/XBXnnnaMVKyS
 5bhWHJFytZZvszOv3njDnZ08522WnHg4QtW3VzFGIQniw2ytvzDhDTb2X/bs4yDZw9FwXTmzp9T
 FWXmm+0t5occ59ixPwBH6JmH0G39p6BYCX48A2vmIjYUj1leKvWzPrcPaOnjJtal/9xgHp9v45M
 U6udMIrBFSv8efprwcHFrsnFOHqqMz2M08jqeqYnPXwI2FE6ge1dw/zbVJBmS3STC5PJ3XFPHe7
 1e6JBLSMerzZgXKGYsQ==
X-Proofpoint-GUID: iZIZ1yavayi1anlQRRrbSdhf19VxoHbg
X-Proofpoint-ORIG-GUID: iZIZ1yavayi1anlQRRrbSdhf19VxoHbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110144
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

