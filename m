Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3004F10AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C0210EBE3;
	Fri, 27 Mar 2026 00:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cGt4/Skt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVWa8Yg/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2DF10EBE7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QGKe6a638799
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /0QWIcyBi4nwTeP/7U6Dm9MjiSVn6vYPraSiONht+Ko=; b=cGt4/SktH6vltEmV
 IYqDIVbfhdGPuxWCiwQiXdxVnCoS8GTWfGPxm6wGm4SsRTfg4kX8r2doIAF/0yjz
 S/AWgnCr2YMP5xHEdqUd0YJssbaOsSw7ToVDXhZC1gvrPICKF5Pe4uHSeCTUWb8J
 2cGBrTR2JaNWFtOLM0hotypi2L+y2fHtj4A0BFJr0TRUTM4UuYRnTyR2PDFztpnc
 OzTQbyxHjDud+4w2lcxYKCG5vixf/NVpFmAP1ZIPWGWOS5yXcZ2M4d71m7FhYjQx
 Kq6sApWr+T7mSEFBa0UfA9z+6n+I/GCk9QdDiLZJu0cz4a4YYn2B0O/gzPAxsSsr
 aqy5qg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5883hfmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:55 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35678f99c6eso1251181a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570555; x=1775175355;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/0QWIcyBi4nwTeP/7U6Dm9MjiSVn6vYPraSiONht+Ko=;
 b=hVWa8Yg/8GUlm9h9l5M+3gLx0NpobaKYj5u3JlFDW9jvPLKNjuYcwUeY81g57UeHmP
 P518f4tna+dh90MyHwf3W3HXnZ46e/r5wdYqZhDoOgERgLVMFKbQufqups7W4GnU0uNE
 80KXRnW5j1PZIQQULPq8u7kynlVmyiyZeOyHIglpZwtP+XENczimRrkWN1rlomN0rwTo
 WF+lMz3AMw/y6gmSWLyVwmFox0La5V3M7V5HsFYotzosauKnYjdS5qwSxRnSNoNR8xaY
 DciuKN+oePOBN2eYHpqtwM2y4Fnegp3+9JAkM/dgtX3n/EY5bd6yTJVrlKNn9YHdYhBZ
 oAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570555; x=1775175355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/0QWIcyBi4nwTeP/7U6Dm9MjiSVn6vYPraSiONht+Ko=;
 b=IvdhQLEve7vLmpSEOGpIIHTQLaxH59Np92BJ9OHXstqq7j7SGjLzjTiBIO+GdWPpB3
 a/apm0SZkiYR/egun7vCnR8T4vDk/LjFgawlON2vVaqy3OseAEtn5BpS6tUxpbsWiQN2
 wINszotU/mLt1sS4Y9lMzxdMI0Yj25a2/PfUROq0KwNef6h4Ul0+aiiM8uX32x60q+Wz
 qX2UML/Q2CFqe06H97OJFdDq0zKRw9rc11aPEjqlmvsfBtTf2H0Yf7y1HYVhoAhnJTmp
 xlRbLLfkmZlMYYbSvbzNIjil4PhTYhLC6TElgLK+8bkEyYJ93Jtsh3KpPKkl6YbxPypD
 W2jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVb7tppNsd5GugowHBgV0+L4EY/M3O3/DhYGvd1IKOsyf9BJ1Fy8d4nW3jbcQXa01OdhsOoEx/194=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtVXbIjWoMYCfukUK6VeyY06Y8RHsBtQYjpia/a3kg097xIQzy
 zihoxx6nqgUNp1bkHZgdbNAaPl1S5P2lBn+7wqnpcBno5UcH21EMcSuODWKWPstzSwGTsRPotkX
 /uiEwMSiuqEGQJpI5ZIKzd+mFDpG1rbd4AkxmrB5kscAYc2XwRsFfe5x0lOJ/DYIj3NLBM8c=
X-Gm-Gg: ATEYQzwvRy3ucdMxw+EkV7EEeBWbO1txV+pND1BE3DtXgC+nt0/7lwJgSrNfNVtBv78
 7DUqyB0tUqGr9KfCE7sm4lhJ192eLXlB1FceqSH7O8yUuvaBGavCKxzeqG51qDfPjYnDa00EY1j
 /ICULW5O86S6EO2c87GUAJGhUQ071jnGLbSXDoHePq+VO6sH+kzPVx3zCVIK6cUodMolybte38d
 gtEPkGNZiq4FpVhGf6x4PwwWlnPp6MEuVA1fL7bwlDqbdLrKsJsz9visbSnf5a+5p27efVDm0P0
 5Zj9eSes91QwvuIg15TBzmpUVWgGm8LQnR6Ekr4Ew68rm08izKLVRjelEhpD2Vgh32nsutbCdCl
 mDpxxTkCW3fuwkRvuBqFS80YLo3w5GBY/1S3FtmH0iJ4yGA==
X-Received: by 2002:a17:90b:3b44:b0:35c:1695:24a3 with SMTP id
 98e67ed59e1d1-35c300f9c52mr428541a91.23.1774570554635; 
 Thu, 26 Mar 2026 17:15:54 -0700 (PDT)
X-Received: by 2002:a17:90b:3b44:b0:35c:1695:24a3 with SMTP id
 98e67ed59e1d1-35c300f9c52mr428504a91.23.1774570554024; 
 Thu, 26 Mar 2026 17:15:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:44:03 +0530
Subject: [PATCH v2 14/17] drm/msm/a8xx: Implement IFPC support for A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-14-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=13856;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=9KrXNSvItwGE77aojEyKPtWdQZmTrwH5RndqraHxgzA=;
 b=xttYTBzbMOObwnJ60C8u9XKiyXb/MBtv8K0/ruU9FFqz3ldLBjC0PvKr66zDCvo0GL8O0u130
 znRnmv9saPjAMEXUWqC02luJ2UqE6T5kbRE9EgdSAyQdt9E0whD1nr9
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 9TPrVIVBnNyPdOz09d_kCOELxvUjC90e
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=69c5cc3b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=gVRFLEIR9Vaz-UcNYaQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 9TPrVIVBnNyPdOz09d_kCOELxvUjC90e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX50TN47YzpR1Y
 J5SjazTjDAMWp1bWlct8wVaDzD7uTmheeFYE0YlO+MTTFRRIevIQ6MztVLvPl0FQEAgPpG1CAhE
 OJxX7knRX0YLV9O0y4pj9wOmEM+vq90+oEhkj/4OPtN8YheUtAD/HUZd5BEXDKW63qv79/a+zQE
 HV3KuHGY2PWxpR84/DJBdQdSHagLnWklu42nMsqDVzh5wbqGHim/toJf6GOgtWOgags+tFmxwdq
 J23cudhJjW2Yf8KuLTJaao2U9VZ8YlNaiErokA6GlgAKwWGjvA6zVumwShHmQ1bZxlDgL4KEgmQ
 iIw20SMv3e9Ylwdio+gTr9dvWrf8+KyZg77nPFp5c2AMC7+odyuXtSstkdTwJ+wo8+uTqeFEoZ7
 kGIs9uKU+pllDT4h3FUgbsouulcLrozw3JuNtOUFjAZO3sLwutlQv6pNKmm91G2TI6Q3xtkPM2G
 6O/w/8igqCJuC/Cq2tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
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

Implement pwrup reglist support and add the necessary register
configurations to enable IFPC support on A840

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 185 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  99 +++++++++++++++-
 2 files changed, 281 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 758bc7bd31f6..53548f6e891b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1891,6 +1891,185 @@ static const struct adreno_reglist a840_gbif[] = {
 	{ },
 };
 
+static const uint32_t a840_pwrup_reglist_regs[] = {
+	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
+	REG_A7XX_SP_READ_SEL,
+	REG_A6XX_UCHE_MODE_CNTL,
+	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
+	REG_A8XX_UCHE_GBIF_GX_CONFIG,
+	REG_A8XX_UCHE_CCHE_MODE_CNTL,
+	REG_A8XX_UCHE_CCHE_CACHE_WAYS,
+	REG_A8XX_UCHE_CACHE_WAYS,
+	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN,
+	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN + 1,
+	REG_A8XX_UCHE_CCHE_LPAC_GMEM_RANGE_MIN,
+	REG_A8XX_UCHE_CCHE_LPAC_GMEM_RANGE_MIN + 1,
+	REG_A8XX_UCHE_CCHE_TRAP_BASE,
+	REG_A8XX_UCHE_CCHE_TRAP_BASE + 1,
+	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE,
+	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE + 1,
+	REG_A8XX_UCHE_HW_DBG_CNTL,
+	REG_A8XX_UCHE_WRITE_THRU_BASE,
+	REG_A8XX_UCHE_WRITE_THRU_BASE + 1,
+	REG_A8XX_UCHE_TRAP_BASE,
+	REG_A8XX_UCHE_TRAP_BASE + 1,
+	REG_A8XX_UCHE_CLIENT_PF,
+	REG_A8XX_RB_CMP_NC_MODE_CNTL,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN + 1,
+	REG_A6XX_TPL1_NC_MODE_CNTL,
+	REG_A6XX_TPL1_DBG_ECO_CNTL,
+	REG_A6XX_TPL1_DBG_ECO_CNTL1,
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(0),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(5),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(6),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(7),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(8),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(9),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(10),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(11),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(12),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(13),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(14),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(15),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(16),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(17),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(18),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(19),
+};
+DECLARE_ADRENO_REGLIST_LIST(a840_pwrup_reglist);
+
+static const u32 a840_ifpc_reglist_regs[] = {
+	REG_A8XX_RBBM_NC_MODE_CNTL,
+	REG_A8XX_RBBM_SLICE_NC_MODE_CNTL,
+	REG_A6XX_SP_NC_MODE_CNTL,
+	REG_A6XX_SP_CHICKEN_BITS,
+	REG_A8XX_SP_SS_CHICKEN_BITS_0,
+	REG_A7XX_SP_CHICKEN_BITS_1,
+	REG_A7XX_SP_CHICKEN_BITS_2,
+	REG_A7XX_SP_CHICKEN_BITS_3,
+	REG_A8XX_SP_CHICKEN_BITS_4,
+	REG_A6XX_SP_PERFCTR_SHADER_MASK,
+	REG_A8XX_RBBM_SLICE_PERFCTR_CNTL,
+	REG_A8XX_RBBM_SLICE_INTERFACE_HANG_INT_CNTL,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_2,
+	REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN + 1,
+	REG_A8XX_CP_INTERRUPT_STATUS_MASK_GLOBAL,
+	REG_A8XX_RBBM_PERFCTR_CNTL,
+	REG_A8XX_CP_PROTECT_GLOBAL(0),
+	REG_A8XX_CP_PROTECT_GLOBAL(1),
+	REG_A8XX_CP_PROTECT_GLOBAL(2),
+	REG_A8XX_CP_PROTECT_GLOBAL(3),
+	REG_A8XX_CP_PROTECT_GLOBAL(4),
+	REG_A8XX_CP_PROTECT_GLOBAL(5),
+	REG_A8XX_CP_PROTECT_GLOBAL(6),
+	REG_A8XX_CP_PROTECT_GLOBAL(7),
+	REG_A8XX_CP_PROTECT_GLOBAL(8),
+	REG_A8XX_CP_PROTECT_GLOBAL(9),
+	REG_A8XX_CP_PROTECT_GLOBAL(10),
+	REG_A8XX_CP_PROTECT_GLOBAL(11),
+	REG_A8XX_CP_PROTECT_GLOBAL(12),
+	REG_A8XX_CP_PROTECT_GLOBAL(13),
+	REG_A8XX_CP_PROTECT_GLOBAL(14),
+	REG_A8XX_CP_PROTECT_GLOBAL(15),
+	REG_A8XX_CP_PROTECT_GLOBAL(16),
+	REG_A8XX_CP_PROTECT_GLOBAL(17),
+	REG_A8XX_CP_PROTECT_GLOBAL(18),
+	REG_A8XX_CP_PROTECT_GLOBAL(19),
+	REG_A8XX_CP_PROTECT_GLOBAL(20),
+	REG_A8XX_CP_PROTECT_GLOBAL(21),
+	REG_A8XX_CP_PROTECT_GLOBAL(22),
+	REG_A8XX_CP_PROTECT_GLOBAL(23),
+	REG_A8XX_CP_PROTECT_GLOBAL(24),
+	REG_A8XX_CP_PROTECT_GLOBAL(25),
+	REG_A8XX_CP_PROTECT_GLOBAL(26),
+	REG_A8XX_CP_PROTECT_GLOBAL(27),
+	REG_A8XX_CP_PROTECT_GLOBAL(28),
+	REG_A8XX_CP_PROTECT_GLOBAL(29),
+	REG_A8XX_CP_PROTECT_GLOBAL(30),
+	REG_A8XX_CP_PROTECT_GLOBAL(31),
+	REG_A8XX_CP_PROTECT_GLOBAL(32),
+	REG_A8XX_CP_PROTECT_GLOBAL(33),
+	REG_A8XX_CP_PROTECT_GLOBAL(34),
+	REG_A8XX_CP_PROTECT_GLOBAL(35),
+	REG_A8XX_CP_PROTECT_GLOBAL(36),
+	REG_A8XX_CP_PROTECT_GLOBAL(37),
+	REG_A8XX_CP_PROTECT_GLOBAL(38),
+	REG_A8XX_CP_PROTECT_GLOBAL(39),
+	REG_A8XX_CP_PROTECT_GLOBAL(40),
+	REG_A8XX_CP_PROTECT_GLOBAL(41),
+	REG_A8XX_CP_PROTECT_GLOBAL(42),
+	REG_A8XX_CP_PROTECT_GLOBAL(43),
+	REG_A8XX_CP_PROTECT_GLOBAL(44),
+	REG_A8XX_CP_PROTECT_GLOBAL(45),
+	REG_A8XX_CP_PROTECT_GLOBAL(46),
+	REG_A8XX_CP_PROTECT_GLOBAL(47),
+	REG_A8XX_CP_PROTECT_GLOBAL(48),
+	REG_A8XX_CP_PROTECT_GLOBAL(49),
+	REG_A8XX_CP_PROTECT_GLOBAL(50),
+	REG_A8XX_CP_PROTECT_GLOBAL(51),
+	REG_A8XX_CP_PROTECT_GLOBAL(52),
+	REG_A8XX_CP_PROTECT_GLOBAL(53),
+	REG_A8XX_CP_PROTECT_GLOBAL(54),
+	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
+	REG_A8XX_CP_PROTECT_GLOBAL(63),
+};
+DECLARE_ADRENO_REGLIST_LIST(a840_ifpc_reglist);
+
+static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0, BIT(PIPE_BR)},
+	{ REG_A8XX_RB_CCU_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_RBP_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_CP_HW_FAULT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_INTERRUPT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0, BIT(PIPE_BR) },
+};
+DECLARE_ADRENO_REGLIST_PIPE_LIST(a840_dyn_pwrup_reglist);
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44070001),
@@ -1940,11 +2119,15 @@ static const struct adreno_info a8xx_gpus[] = {
 		.gmem = 18 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a840_protect,
 			.nonctxt_reglist = a840_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
 			.gbif_cx = a840_gbif,
 			.max_slices = 3,
 			.gmu_chipid = 0x8020100,
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index fafeac62aebf..e406681b8c80 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -173,7 +173,7 @@ void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	/* Update HW if this is the current ring and we are not in preempt*/
 	if (!a6xx_in_preempt(a6xx_gpu)) {
 		if (a6xx_gpu->cur_ring == ring)
-			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+			a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 		else
 			ring->restore_wptr = true;
 	} else {
@@ -386,8 +386,87 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 	a8xx_aperture_clear(gpu);
 }
 
+static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
+{
+	const struct adreno_reglist_pipe_list *dyn_pwrup_reglist;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	const struct adreno_reglist_list *reglist;
+	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
+	struct cpu_gpu_lock *lock = ptr;
+	u32 *dest = (u32 *)&lock->regs[0];
+	u32 dyn_pwrup_reglist_count = 0;
+	int i;
+
+	lock->gpu_req = lock->cpu_req = lock->turn = 0;
+
+	reglist = adreno_gpu->info->a6xx->ifpc_reglist;
+	if (reglist) {
+		lock->ifpc_list_len = reglist->count;
+
+		/*
+		 * For each entry in each of the lists, write the offset and the current
+		 * register value into the GPU buffer
+		 */
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+	}
+
+	reglist = adreno_gpu->info->a6xx->pwrup_reglist;
+	if (reglist) {
+		lock->preemption_list_len = reglist->count;
+
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+	}
+
+	/*
+	 * The overall register list is composed of
+	 * 1. Static IFPC-only registers
+	 * 2. Static IFPC + preemption registers
+	 * 3. Dynamic IFPC + preemption registers (ex: perfcounter selects)
+	 *
+	 * The first two lists are static. Size of these lists are stored as
+	 * number of pairs in ifpc_list_len and preemption_list_len
+	 * respectively. With concurrent binning, Some of the perfcounter
+	 * registers being virtualized, CP needs to know the pipe id to program
+	 * the aperture inorder to restore the same. Thus, third list is a
+	 * dynamic list with triplets as
+	 * (<aperture, shifted 12 bits> <address> <data>), and the length is
+	 * stored as number for triplets in dynamic_list_len.
+	 */
+	dyn_pwrup_reglist = adreno_gpu->info->a6xx->dyn_pwrup_reglist;
+	if (!dyn_pwrup_reglist)
+		goto done;
+
+	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
+		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
+			if (!(dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)))
+				continue;
+			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
+			*dest++ = dyn_pwrup_reglist->regs[i].offset;
+			*dest++ = a8xx_read_pipe_slice(gpu,
+						       pipe_id,
+						       a8xx_get_first_slice(a6xx_gpu),
+						       dyn_pwrup_reglist->regs[i].offset);
+			dyn_pwrup_reglist_count++;
+		}
+	}
+
+	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+
+done:
+	a8xx_aperture_clear(gpu);
+}
+
 static int a8xx_cp_init(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = gpu->rb[0];
 	u32 mask;
 
@@ -395,7 +474,7 @@ static int a8xx_cp_init(struct msm_gpu *gpu)
 	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
 	OUT_RING(ring, BIT(27));
 
-	OUT_PKT7(ring, CP_ME_INIT, 4);
+	OUT_PKT7(ring, CP_ME_INIT, 7);
 
 	/* Use multiple HW contexts */
 	mask = BIT(0);
@@ -409,6 +488,9 @@ static int a8xx_cp_init(struct msm_gpu *gpu)
 	/* Disable save/restore of performance counters across preemption */
 	mask |= BIT(6);
 
+	/* Enable the register init list with the spinlock */
+	mask |= BIT(8);
+
 	OUT_RING(ring, mask);
 
 	/* Enable multiple hardware contexts */
@@ -420,6 +502,14 @@ static int a8xx_cp_init(struct msm_gpu *gpu)
 	/* Operation mode mask */
 	OUT_RING(ring, 0x00000002);
 
+	/* Lo address */
+	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	/* Hi address */
+	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
+
+	/* Enable dyn pwrup list with triplets (offset, value, pipe) */
+	OUT_RING(ring, BIT(31));
+
 	a6xx_flush(gpu, ring);
 	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
@@ -702,6 +792,11 @@ static int hw_init(struct msm_gpu *gpu)
 	WARN_ON(!gmem_protect);
 	a8xx_aperture_clear(gpu);
 
+	if (!a6xx_gpu->pwrup_reglist_emitted) {
+		a8xx_patch_pwrup_reglist(gpu);
+		a6xx_gpu->pwrup_reglist_emitted = true;
+	}
+
 	/* Enable hardware clockgating */
 	a8xx_set_hwcg(gpu, true);
 out:

-- 
2.51.0

