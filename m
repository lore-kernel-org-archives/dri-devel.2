Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080B7CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D4D10E827;
	Mon,  4 May 2026 19:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYBo1g/Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KJOhR1EW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C7BF10E832
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644IlJRD636001
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nY8Zf16hfaV
 mHNExd3/Edt40koDFD/E4yWO1TVKH8HE=; b=AYBo1g/YCo07xifCZTxImkFEyIs
 2CaoxM5v8ho7UJ80SVUJtQe3XnGk4Y/BnxMSAUDIW7OZMkz6wkNvWAAeIsSVrRtW
 C49FD3Mm18cWyeV15R+LTHzHFdv5VR9LXudxlxiv+3Tgu5ew0Jw/9rl3okv/ef/F
 THPKLSc4V99ZtapUriKLLjKMB7zni7Ag4tKLMTEONo0jaiNCu+VDAX/tZXwJBYCN
 SXPJ5EpJDki7IjqzNOWjzNNQ/6jDQ47VmsvyeSIZPe/gbxG77R8a02het5wrUIfQ
 KQCbPdKQzoNFCiTd9Jqf3NsPw5r7gBl/ySTiEaTGqXGXEvj2S9hO6sJNPVQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxsx49t4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b630753cc38so5853285a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921711; x=1778526511;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=KJOhR1EWOjf8EUYCppcg1zpS56wjSy4/N3ctIMG6jue+6LpCy9Harp6x/59NmRvGpv
 Il89K1BN7ci49H4epWR4nQDMy5rTLBZ6gtef+amO/Qh/aun+Nlpebg6svfbi1sgvRFX6
 Gb+VKsL01HR3/vsabZyyOGee+VlI3mRnNfyY/tXpE6fJUchkjR+wRD1IIg6bu7jPGgUJ
 Fg/Fkk69h2VZQNxbH2d1cF1wH/ELHBEs71CP7CMWFXVMGIsEIWNgLZDWOvY+xso5epX0
 w+85a7iE4WsFBUygzjcgKJn+QjsqVNswIun7iMcmNp8I6DObrRSrme9AKCYCPyFOitHL
 tFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921711; x=1778526511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nY8Zf16hfaVmHNExd3/Edt40koDFD/E4yWO1TVKH8HE=;
 b=CCeqjqb2JwxeJBBPb0HOFaO8WIUsCurJbFeMhEzgptK8tCCCGGu5GSpsi2DqGryQNA
 GNH8+mA+aOrl6xq1kfviFQTAiX7FYvhwglEfZppjmW84wSnShgFpMm14mhS4B8n2Xf4b
 QdU1LGedxhTR7qGhe7U89JTzzT497bHbEjjIhLcpNKJLf1+ScP/mGfuAshhvsFMDGuFt
 Ct029DNCIc8UquWLBAFEal4oE9+Zs10poPoCfm5ccQxUVrNhc/47td3EqzWNZkmk1/EA
 +lF1syznrzI7ElioZE5QJfR5+WNxGTE0Nn6Zr1Ih3tr1PO+mYxX8njDlpB1mDAnyPZHU
 P68w==
X-Gm-Message-State: AOJu0Yw/pnqHTh0tdaF00s6UxNqsCN2jF40bG3lsAisqCM6bWEAhZI06
 FLwivjH5lpZWK67KZYgK4ZX8N8At7vThjC/VGCTtC9HMTrlsGS9alGKsfjjYiPTAoeuYMIsJ3O2
 sqh2vfobVcygbbKH5IAWOIePB3uJJPMd/A57gThe3yPtKH7GsLo3O/DOdfIZ6x163c49+MA5JBf
 j0NQI=
X-Gm-Gg: AeBDieuyb5RVB9ztGgGhzTaubVCY+ypFCZPNLoAkZ8TJZeFJTMpz3LTH5gW8QOXJFd6
 qUB+aiDNZlE8LxY+91Wp2MIFAMtZ4Ogow49UQPcQFvik7fVxxtMXp+5QvisEK0PDVtVsZ3PKE1K
 MF/nD24kEAVLHOl/NcC1qPPSVGp0/YLKE4775p7DfqTO27gzPlTfZ2WR7FRGnjLnN6oEHrMHuRt
 N/T2lUm+JI9o574GLAx2JxEFuu1g/8yjz99oCrmjHX0bSrohgH6MtP6pGATiGPpXEZy47483XAI
 IpjhH0ALrVTY0s+BoBnFyzcRO5uSYTCDe9lS1aCH7t8pvqZgyc/Jyi1tJfI3C5D7C0q8C2Y2mV8
 HESsyTjMABnAw/DjmhiHca48JCT0RjDjwjh5iR3NI0yw=
X-Received: by 2002:a05:6a20:4326:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3a7f1ad133amr11856282637.14.1777921711545; 
 Mon, 04 May 2026 12:08:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:4326:b0:398:8870:b58f with SMTP id
 adf61e73a8af0-3a7f1ad133amr11856247637.14.1777921711051; 
 Mon, 04 May 2026 12:08:31 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc8ad8dsm10017506a12.23.2026.05.04.12.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:30 -0700 (PDT)
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
Subject: [PATCH v3 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Mon,  4 May 2026 12:06:49 -0700
Message-ID: <20260504190751.61052-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX0f6KwL24lIHc
 majuFhSyma8odsNVrDuEqp+8XhHChtkijWE8qXvWkifwllHr6DFXx9R17qboMiuZofXcxs1vfr+
 HesBvRtNPLD09BTZVK3WXi/wI4qhXQMZ18EYWvAXHadgME1h+zzmLFWhijOro1rOaXtThcYdmrc
 tCMP+bxAg3fx/IxPLAyKT0Bat3vJN2EHxS68fkAI9akaX04fGstnrsmHWDNYLF6TNK9mpm3y0vm
 5ju5YdeKPkg7NTLQCz+/1xx4GEvmF0a8t86wUYTsRgOxE/Z23rOhgxdBR8lI56jjYI+5IyQY+2Q
 7V9tbus2kf0cy/dvYlmvNyu4GJLq7SV0d7yIzfr3jGYzz/anzTm9hBEhMo1i1EM94P7dv7QJJ31
 xH+Zk98RFCjRphMHqb4gP5mQNHh917neHdIPS1cUsRZRVi2HdBtTbDAGB04+iptJnHik9ELEUB4
 VaijRoS/SQIc7iX1dzA==
X-Proofpoint-ORIG-GUID: dhjM78UzdLEoW9xp4oEEZ635sLVZo7os
X-Proofpoint-GUID: dhjM78UzdLEoW9xp4oEEZ635sLVZo7os
X-Authority-Analysis: v=2.4 cv=LdIMLDfi c=1 sm=1 tr=0 ts=69f8eeb0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=UuwE4gOO9k-hs8zF27AA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
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

