Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDE9F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66E010E465;
	Mon, 23 Mar 2026 20:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqloMYI1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IHHYQErF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FD910E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqX2q3170664
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S55qtoUgugfr63dVcnC+GLJkI8uxi0KX+Hru5AmHH7Y=; b=dqloMYI11CXMm/0S
 keI+hcXWw6XO5qsNaLbzc2snqk79Ajsz1CFDNCPAheowchArt6sr25ayJhV+iAV+
 LZjC52g802mjn+iLMROT9Yd2mCPbQE+XqPDBHpZwdChmqXNUwIzGSwGH0Z8VeNGk
 G5O7Tyr5ry5el3TH9+b1/gtOKjxpSNb6P9/eRPm4JsT1ElSALZc+QBkXIiJg8oTg
 WP8VtX16wCtAlsnYPYs+Pc3giSy97oMKDLkMLRqpgzWdHKycN0HiiWCehktVCUme
 /XzEVVa0lMlpv1UsfHLfXTefIoJHviuQxWcMEBt51jZh5Y1VgyFmsPDUwfXD2otE
 yYqyHw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r21jwk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c74262a2988so13313191a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296776; x=1774901576;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S55qtoUgugfr63dVcnC+GLJkI8uxi0KX+Hru5AmHH7Y=;
 b=IHHYQErFlN+qPZoYh9ZN+TW20AhfgiS1+/JphsuuxrjMqEbJRLBl3Ny+JjuRU3wfR8
 D57qQ9mTVsKOLP+A6Lxa/pqxPbTo6j+nQy+3wm4hlDl/AcYL5eK0XtpRTZvcr1HshkZ8
 rh4/DwLhLsWmX0F0mvugh73oRwOkEQ+gD+R2C7NkNgnabdcdpgR5eF6v2CT4+hPv9m3o
 d8P1/88Q6SZ+VdnD5OIKo3GO7wPrSMTmWCsvqN++7Ezv8q01ZbdVRhb/4XMM18bU40WZ
 XkDSY9Dg/dvqdOqowukrWhAigQuuhVq0wzzxlDjQWjLYvN2/y/hP/B16gXS4nlwF2ZGm
 BNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296776; x=1774901576;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S55qtoUgugfr63dVcnC+GLJkI8uxi0KX+Hru5AmHH7Y=;
 b=TTtd9bmA6Yp6yFhF6dQJzitrrcsLf9xLULk8O4SYZF0Neq++mq1cfc5gLPkEp6ETFl
 9rnUPXTQsKaZ7BH5WlLLkXFgjnwXWJTJhtM9BwT1muzWPUjitw+YTvm3FP0uTJnWP3mX
 TnAz7YK8GQgIBf2OuXuCgNyQUoURvc8vzaMf5sbxkl6F/JaRVmumfmvIgpYtHyNxo1iC
 1BQK9jn7zOh5eyI06Je97Pfj3P/3Ow5lvGGRaCBG7wstKQTBFhhl/pDPjMZi1QVPgaMA
 7PpW9+vBvzMHro8NqZtpSZ0IAnN2mvMer1/POsMajKbARZ6nVqhtrrtRNli2q2Yvocc6
 60ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVExrKngoe7PHmvcY8Vu9WQYpSnsiuo08dYZrIICaC0AzAUeV19e2JptcOHmffuwB5SoK17s0oySyQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWqxPGR2KjjUDU5ggmFXBSnCHtlSB2OkRUYwRsf5neIZAXV80x
 hGSpIYubksA4qPsLfCVQR9W8k+FrlzZCYolOqD3dkfp5T5b+62+TTw0O4Be4vP2SOpXsj9qgCK4
 aLCetgFup0+MOVbjE2pTWoHvWUev5j6Wum6OwrMvOhNeLX09CSlyBrBLXK3xhsN/pbDBBQOc=
X-Gm-Gg: ATEYQzzTj+eIf9iaRJ03WE2dDnEV+REM5ryWp8gHBTQvAXuLQ/Qls0s0AJsgyKWC8ZD
 ZXDPuruBwk6OrH+RWbFV2CDZQNr9mf4vbTTbKRVj3rfQUjXdvwVArhiL6hmyQ2T2KFM14FPMVUK
 qXNVTivRERTE+5q+a+mL57YBM6Fh9NJ/f/9kw6AWGtVupniuPqIRo9Fhb3Jhrhx6ANMV6p1mDVR
 TTCyUArZCzcqJ9rbZcQqj4MVIVMzXfPtvMlmUmsYBKGmhJ75HXkqvi9dxDU9GVlcUYCF1vz954p
 m6Lm32J/t6KsXwMkY1GPjdvXmcWn5wt1iBLQj3d3W878DZSuIga1nTYQNCM/lVUc83JgxGdCCoo
 7/Rcp8Qm/YodvDAQFhVL8g1bdwGxxzWPAkIaIea712dd+Qw==
X-Received: by 2002:a05:6a00:2d29:b0:82c:28de:fa26 with SMTP id
 d2e1a72fcca58-82c28defcd5mr8681513b3a.36.1774296776028; 
 Mon, 23 Mar 2026 13:12:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d29:b0:82c:28de:fa26 with SMTP id
 d2e1a72fcca58-82c28defcd5mr8681498b3a.36.1774296775570; 
 Mon, 23 Mar 2026 13:12:55 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:12:55 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:15 +0530
Subject: [PATCH 03/16] drm/msm/a6xx: Correct OOB usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-3-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=2386;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XU6DfLSnpNWPI66IC/TzgoZVKRNGuruB43NJyqi08Jc=;
 b=0yD/TiCNdFIRXTp7VQT0deosP8kmu4wjice+6AJyGdMDp+3xpyU04YHALqF5QI8cnEA1H0j2C
 hsAba0mO96sD8vFFQv6elOzXlZTlcraC0mQZMsFn00dq6NPbflBufv8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c19ec8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pGJFX0Yo-_9-baE-uFMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ZbtHCW-MI80G0D4mkX_U57BoAi1Hjgye
X-Proofpoint-ORIG-GUID: ZbtHCW-MI80G0D4mkX_U57BoAi1Hjgye
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfXwtF5+0T/X5cy
 gvfrx3zOW5MxzgiaStppgJ3rxx0UZ8NkjJn0gEIaA1mpRaCVqL+393pXwnxaWr4Q5tLUtNsByRy
 nUq1EmRX4SmH07ulTWR0uwVa3bm9ER72yqW9T/4sQV5jxHSxgU44Fhq3jNMx4JYUBuNPpn3LTLr
 AAr4Dx5t6NmX8KqVqkJlVj9WGE7sGEZMxMC3Pb35+iPPxYmWciQWBcT/DyUrLaEn/9vPode0fFc
 Ctpi+7V8sPIlbfzoySInbkKHc104x8FYU93a0/7S7pCu5/I4eq7cK+2xk+MJw0/6Rk9zKaMP89c
 3Z+UaV7DiY4bYCujZSM6jX3mlOkakfZYoQZ8EYkmU1lLG4sebB2OMsEagWai1SnjjFlnZnlK6lf
 /9qb+er2xB1uF3hXjUuyq4+k4Q6xceQ9JBWtzt6G9untg0KeY4fwQcngu8pKp4eKQyZTiHW55Gk
 FQNBNuv3L/WchYeu6Hg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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
index 93bf2c40bfb9..897522778fd4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1603,6 +1603,12 @@ static int hw_init(struct msm_gpu *gpu)
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
index 987c99097d40..d414f24ddbd9 100644
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

