Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB61910AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FDD10EA51;
	Fri, 27 Mar 2026 00:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FRXC9saY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Kasy7u0o";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC0710E20C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QMClIx2583589
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0IHyaMl4RjylqIprsqHQxbLvzlvJXxYU0f//3lLX3fI=; b=FRXC9saYRLYoZj8J
 n9NZCUoOMUVQzHozBLTaH2Zgk9pFeKpqiXzdAanXMMitnw3LR8aTNKly623ZKozN
 oDQS9xdyZCo+Lnq1rWWQ5kCRou03wit2aEMQCbLzW1qtIp3jSoX1jOv0XtEfFFF1
 0A3YsZYYjHOmKd9HgHKFnCb2/2RuYtM7HaijPtdKgPMMYv+XKIzRNJlkldTJOJhy
 MAW6DjMhCtsryYhLMK5ZJwm2mZHPIs7b/gi2gbdM3Dnimtnwt03HBl6EzkybUu9S
 WKdmEqikaioc9CzBJ/8Y32vSFbTfpyTLf6BimpZARUv8LQ7F/xWhnD2RlhAXiywB
 LF7zmA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6g91x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3595485abbbso2166534a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570496; x=1775175296;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0IHyaMl4RjylqIprsqHQxbLvzlvJXxYU0f//3lLX3fI=;
 b=Kasy7u0owKaIARH4gwd6rzlSGjcU2ZgCQmpoVgYtxdvkRNRj3zf9bm0Bh7cjjtXhG3
 vsgu0afaQt1hBKyTqY6JJwat13dkGOh4PAZm6ABHX9Jb8kZ3gE8Pzp402dtESvLtSQnq
 PFVIcN1K1uFaw2+oi5dMctmUN426kZgVeBDoQH2C+JvtSGFzND9l3Y8MZuLAhcK0mvjw
 HzjF5jgyAUnN6Cagk6nXGq4bxrGRguAPKIp4JeHiD5b/q7hNo/xXG0n3SnGD54013Sn0
 6sc4vbGPO50Q1S3FPgY5+Eo9ajB0eoKuUcAic4qouVbJlC8G0LByGBQJb70QEBGX61ww
 uLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570496; x=1775175296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0IHyaMl4RjylqIprsqHQxbLvzlvJXxYU0f//3lLX3fI=;
 b=AnaW72714YtrbzTN6WlYANwgPBdi2NyGiE9bD0bLE/shR8AYfhAYmb188ET5j2T5/L
 DEmRtt1HyxlpJ2b+aCvSdgxMLGVTBYKfSBhPeqPYeEbucia/KJ3hK3NlV8yFw80z0rul
 6TG759brm/f1OQeLc0J1CmnitoRB5I3qN4um+p6DVfA+saujQm/LWOLYBbuRZ89f2Nwz
 AN6lWHDM1qWf85zhmtYp4KkHArz62BQVKnDAiDTmX8fi/rKEoEjSdlE061TmG/XPl7B8
 iuW4X0rZlDhaSjUzr41+nL+kmWMYlpBPqaeJV/S1UiVllS0NjiyzQYL4r8YQNNrlLa4C
 bQDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiqTl0kHXZJ/vaLgmYeYQwO9qSJG4kpOdr3jnZ83GwPI1EKhIZucFmpexRsFkexrLuC8/WS8rjtWc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzaeo62Jm8KWXXSpMl7XVbu1CBdCL6cti5WeLbWtPSaa/q3M7n5
 So2Wz6O4+vaOSpdr+3VCrSraMgbEtdMwcX/ixpYJH2lsH7n63nhi7jKYmFvJ2rqLKV8CZqOxpKA
 NradLu7glQ19QBmbR4Sy4DlJRDeYAyO+HRibv1aSFAj02KwJPdKt7gN6FiyFbsyuoTl0kKh0=
X-Gm-Gg: ATEYQzwW2aYMBScPiuHb2jyFYOh+M9PWA9b2mtlKUsZA6vlIPz1v2t/Vdv7MTR4+aIh
 9HceKbICFpYfgVK+Tlcus7ylqzXh9Ud6o90lK9OmjTWJIkC17lyJUjxryPJRY+ZXL9WiPrXBsJa
 r0tfP12dw8siMo9MCr33/NmAI4z6QJo7Ltyv97yMQwsKBZIuqZqwyufnzwkmPpwuCvhCa9RRd1A
 C7uM1NZo//xYssLrmCJTOLw8CIvhMEbp8YNLEsn5jfYeifCKeZxm4Qg2xkxAAbVy+m7ufrpAgCY
 u4E86Oibrqp1VhMPQZWe+lQ+SEcswqIt6Y4v6vS7IPVNlQZiEWJmWR41Te5klHQ+EYKhgn7Sk48
 xEEa3eeudcR+S2wOfAlmcCIVFJKwNcpYDQvZHCwvUwUbtvw==
X-Received: by 2002:a17:90b:3fc7:b0:35b:92c1:8a3a with SMTP id
 98e67ed59e1d1-35c2ff86566mr573956a91.14.1774570495964; 
 Thu, 26 Mar 2026 17:14:55 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc7:b0:35b:92c1:8a3a with SMTP id
 98e67ed59e1d1-35c2ff86566mr573943a91.14.1774570495519; 
 Thu, 26 Mar 2026 17:14:55 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:14:55 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:53 +0530
Subject: [PATCH v2 04/17] drm/msm/a6xx: Correct OOB usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-4-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=2386;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=hO+tlaP9kUuhCPlMZ4rX5r+rbJqELgijDL/FNh3qLxI=;
 b=JCCRY+wFjZC/dv8RmXTmyHSKxHHivJNqeDPy4Afv4r9gjuOs+Xovo22uISFWIponXY/StqtNm
 nVcxRp/yh25CZn3k15pPBqmr4JskjaJp7L7xIHrdDgai8j3aCvLzxXB
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c5cc01 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pGJFX0Yo-_9-baE-uFMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: LsY8_tYEB_icuVjP7a_EMVEcQXWpANDb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX7k7GVZ+0xoW/
 0EhVaXekNt+TVtPtdutinQKWBklHNgjkJIjgci+JAw9oDquXB/pKyF6k9t+g9h0oQ7MpPPDylIQ
 TW5/MGOnZA8QyD1DdPRstgVPRbOdwkpa75KBtb4vZLrU0XE36DuOGrxTuJn7WdlbvseNFw/MsA2
 LR0oUxnU86KWsW4KQFUVblenDGerBwrdX5GKTWB9pnH0qIc2/2ff1LXLt+E493PX9VsvhcRK2AA
 RCBSXKSMJl48OIcI9KvDsWYi1fyEMW2H0r2TkxdvobdT5/tG1MwSIF243YzymUllLKnl1VpWnVy
 GN/NhltR30vGPcBDD2KvB6V5nfcYf6GqE/pu5UdWZk7cqTuRKZfIc1KouC82M9bfdHQiCRX9TuX
 diyRhQOcLQiaVv3+HoR5Ta2wmrq8twL+ugQMWvp9K3PqeKhYE67/j+8BIGC9eWM7ppsxtxfjLOt
 8nq/E5EneN4l8Tn1vSw==
X-Proofpoint-ORIG-GUID: LsY8_tYEB_icuVjP7a_EMVEcQXWpANDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

During the GMU resume sequence, using another OOB other than OOB_GPU may
confuse the internal state of GMU firmware. To align more strictly with
the downstream sequence, move the sysprof related OOB setup after the
OOB_GPU is cleared.

Fixes: 62cd0fa6990b ("drm/msm/adreno: Disable IFPC when sysprof is active")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 5 -----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 ++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 ++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 9662201cd2e9..690d3e53e273 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1236,11 +1236,6 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Set the GPU to the current freq */
 	a6xx_gmu_set_initial_freq(gpu, gmu);
 
-	if (refcount_read(&gpu->sysprof_active) > 1) {
-		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
-	}
 out:
 	/* On failure, shut down the GMU to leave it in a good state */
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f8cb8b578661..f4b7fc28b677 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1605,6 +1605,12 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
+	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
+		if (!ret)
+			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
+	}
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 840af9c4d718..fafeac62aebf 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -711,6 +711,12 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
+	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
+		if (!ret)
+			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
+	}
+
 	return ret;
 }
 

-- 
2.51.0

