Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F263CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A2310F0C6;
	Wed, 20 May 2026 14:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXlx5bvW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VyGI6VkO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BE810F0CE
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXYoO1797760
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=; b=cXlx5bvWQP/FaW+H
 rTU6D5GCOT30CwedePsc8rCs7R6wQSEuhOy64TTDq5OlNr6csAvSNWnwNTcXMWvd
 dy57QdsDIpw5mQ8b/orVq0rnF/nvskN0CMe7e5pEmuQYNCdqXpc8zlCUFlSS2JUA
 peCDmfoRpGOqiZuYA92eQbrmI4z1/zLEQJq/hsy34xxZsZgIq+c2RCj1Jynms49d
 0W0hyVw1Oj5VoplGvvDnsnz9mOxL9I1OgH5z/FvycOFlPcRygjbLbdeSzHz/IqQL
 3VkrnGyjkqmSmAkKA+9Bys8mSyB6gY/Tu24sLk5xmdQjBmf1ZcdCuu7dEjT1FsYy
 qM7Scg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu0a2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:59 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6314220f28eso11166749137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288718; x=1779893518;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=;
 b=VyGI6VkOxPu7aoBo03fJ59G+Dvbh4wEh84SrF05BsLv12rYoZmFZndMfcwOUX28+TV
 d3Rgn3JIHWyo5Fm36g5SVB/DoJq5fUG5cCePNCkqq23IIIEfXue9mL95V3EbUjaSwXId
 K57PQl4tyIFPwC7maGxktRMldI7F/NP/Hntn1pygdaqAEspCUO8Rlx2jyQGhNnUcHT0Z
 zee1cQ9L0QVTHc535PU63L/YywiC+2d5cWb52W/Fp6LX3Ax+YRytv0YHyZu8AjHvo6m1
 z/8/o7XHp7ytlzTt0JmSzXXh1JIS3aH3DBBAW67WHSt+udVPaBcT9aseiS/0qgTcA/lR
 aIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288718; x=1779893518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=;
 b=nnVdy3PWWSB3mJShO0JnbbNtF+Tv2fPfvIQGl/Fq21ozRJ+NJFq2n40isSbUpUoK6y
 0Jw7QV+rg5PVUhhEE1C0ZiHVmETKE2HSUy4hko76KOAZdyRXULQbqGLjztK7FhEjUmiZ
 wxHWOOAz8eMAzoxjWAZcPcfKMcMKeCtdJcefcqQmQZEOGhJVBKral23YUMB4jRXtJZM8
 PnKB8OszSs8fEdDTkYULgMKoGJkCoXHeOjDm5xipFKcHdxPDT5nIfFsF8yF0xFQwQbWy
 91z47n5lFqfGPjkmNSnrI+KWK4ywgMPdGQjwr0bcyZJGklKJiO2r3HKMgg9TmP4YNjHk
 Ol6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Nh5jf4XqxCqd7dtg1m5tDn/maWIn1QUQ+Sqd2bNdgMnGJfpDsNxc/VzjUF1N6r66dKJxknKT+nLo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTCYbLzugONFEfKyUC0m3HDKqzKiohV9BV0X5bZV396NnhoySD
 3hjo86UwA1b0shYGXiJkgDFUyvsZdRpL0XhM1i5lGWuj7ajv1n4ajns9YQZJi3iVwit0Vju/cGg
 zzSZxTbZqlSqRQ+VNLm2z8V5NXVRe2ahEcceAaSTpY/wDsk3y9yWmlvre/TQMT5aqyOesexM=
X-Gm-Gg: Acq92OGksdAZWklWUrka0pqZcP6AvN7IOhOpz3/dVoT5s7dI9ua8jnVoHDCHwCWDNtF
 z0FTlDMRj3GaBe51dje/6kphJVYJ3iZZPT322c7Ny5W1NQHGQi34R4rSnZ7ddeRf9p8i9Gd5qA0
 /9JPDnPjj5HQs4+pbKxi+TOIuJn/PBI/mRrD0bDozH0Q9DvAnq4Gw5QqRCSUARs9IbKiTsKB5SW
 OGBnITUxFq4Jnm0DiYSGTO9a3Pp6eIGxsY/0qGohiQsGeJdINPx1K17on8YlJtQpvr3n5ogXVQ/
 Ok5qGAG5F28IPTfgj+N7XRCrd4D9EtxIZLXcNe1X+qd6YqYHlel65tp5igGLI0F4liHBZpszCf5
 vUNodBF/v3TSRmB4SvLmDRMs3oXbJkvqRchevfouyQVFCJfe6ghYAX39mCgIvFzqd0NtXYKarPe
 JIZfdH8lHgTVfNOF+zId7bfx/LcND2hbVIaQs=
X-Received: by 2002:a05:6102:cce:b0:633:4d1a:65e4 with SMTP id
 ada2fe7eead31-63a3d6345a3mr13574212137.12.1779288718120; 
 Wed, 20 May 2026 07:51:58 -0700 (PDT)
X-Received: by 2002:a05:6102:cce:b0:633:4d1a:65e4 with SMTP id
 ada2fe7eead31-63a3d6345a3mr13574174137.12.1779288717500; 
 Wed, 20 May 2026 07:51:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:28 +0300
Subject: [PATCH v5 21/28] drm/msm/dpu: invert the order of UBWC checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-21-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DoG4I3IZOv3niHJgYIouUp5Khp2qZBqtf+51O62ZQvs=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpp1kI2p6oY/1w1wnwOnWK9lPhmL+zMvJ1IF
 ViErCstdcqJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaQAKCRCLPIo+Aiko
 1Wv6B/j1W/lfX0HxKR/gmLivHaUYDny9v75ppJUh/a4v9ZuUk3top9SOIjhHp7Jm+dE0c0GXM/H
 p0z4wob8iPEDk+u23KORPShQ32vu/Tyz9ILfvIog6v1Fr7HQb6cMCmygsCKXba923BERKC50l36
 fUf8wDRDoqr2forNwRkjcTJOfnkbfsKthVqehFD3nXQPYuZYTYtZrirPEfPyBzX/ym1JGPJUQh7
 dGIwvaxqehrQEpGmu31gCTyk/YvY1HfduYiZj7MaUF2IVcPBBkNJTa8L33DfFM8kYpZpEDxQSx/
 wzWxK0oPdajdA0C/jZL8ZOnqCFXDbFhp7XAwO4t3UcVt70c=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX3zTn3o1LPehn
 pLva4FSAKKxlcc9lKw4uxjCV8s+HkeyRjg9BH+NFlJubRj9uJrmQSrrm5wGZw4F1I+Ue47dS8Tu
 0zrIhGTulSiF9ms2zxpVonagI4rfHoCwmGoh98zdSZKhZB6aW/dcaI+7cQnixCz5UD6MjOsQmHz
 igQKW4MJEAx3LJf1bQNSSHBsyV2GGNvwYCk83DY64t+A/T5SQumqeeV8hoH898GzjFng8V6qpVf
 Aj0MSYsviQKdQgze9W/E8VknlOGwOZT2EXhPVnbJQtKiyewnzZLCXnLj+PxfsKhfbPprz0zBRq7
 Vtw8ir81Aeop2UAeNxxwEnr822uf5mhYY3OfZaq9tmThgf+AQbSq8oRhNbw/YwgrQnO0RakGt25
 jZfaWFtZpjSde5leOivwnlgLOP4XgPOUmeJhYbxv16tYL2c5B3tDolv3fcquwv5cIqJMqzsYUBg
 0JoNuU5vr/8BIiXad9g==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dca8f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=l4KHnsLLE-ungWRp-RkA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: WE5DoHIBHtauWaul4agVbBHS0S4y6rM2
X-Proofpoint-ORIG-GUID: WE5DoHIBHtauWaul4agVbBHS0S4y6rM2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

Unlike other drivers, the DPU driver checks for exact UBWC version,
making it hard to add minor versions if necessary. Invert the order of
UBWC checks, letting the DPU driver handle new minors transparently.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 6089a58074ac..b5e50fc1916f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -310,35 +310,35 @@ void dpu_hw_setup_format_impl(struct dpu_sw_pipe *pipe, const struct msm_format
 
 	if (fmt->fetch_mode != MDP_FETCH_LINEAR) {
 		u32 hbb = ctx->ubwc->highest_bank_bit - 13;
-		u32 ctrl_val;
+		u32 ctrl_val = 0;
 
 		if (MSM_FORMAT_IS_UBWC(fmt))
 			opmode |= MDSS_MDP_OP_BWC_EN;
 		src_format |= (fmt->fetch_mode & 3) << 30; /*FRAME_FORMAT */
 
-		if (ctx->ubwc->ubwc_enc_version == UBWC_1_0) {
+		if (ctx->ubwc->ubwc_enc_version > UBWC_6_0) {
+			DRM_WARN_ONCE("Unsupported UBWC version %x\n", ctx->ubwc->ubwc_enc_version);
+		} else if (ctx->ubwc->ubwc_enc_version >= UBWC_5_0) {
+			if (!MSM_FORMAT_IS_YUV(fmt)) {
+				ctrl_val = BIT(30);
+				if (!MSM_FORMAT_IS_DX(fmt)) /* and not FP16, but it's unsupported */
+					ctrl_val |= BIT(31);
+			}
+			/* SDE also sets bits for lossy formats, but we don't support them yet */
+		} else if (ctx->ubwc->ubwc_enc_version >= UBWC_4_0) {
+			ctrl_val = MSM_FORMAT_IS_YUV(fmt) ? 0 : BIT(30);
+		} else if (ctx->ubwc->ubwc_enc_version >= UBWC_3_0) {
+			ctrl_val = BIT(30) | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
+		} else if (ctx->ubwc->ubwc_enc_version >= UBWC_2_0) {
+			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
+			ctrl_val = fast_clear | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
+		} else if (ctx->ubwc->ubwc_enc_version >= UBWC_1_0) {
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
 			ctrl_val = fast_clear |
 				(qcom_ubwc_swizzle(ctx->ubwc) & UBWC_SWIZZLE_ENABLE_LVL1) |
 				BIT(8) | (hbb << 4);
-		} else if (ctx->ubwc->ubwc_enc_version == UBWC_2_0) {
-			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
-			ctrl_val = fast_clear | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
-		} else if (ctx->ubwc->ubwc_enc_version == UBWC_3_0) {
-			ctrl_val = BIT(30) | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
-		} else if (ctx->ubwc->ubwc_enc_version == UBWC_4_0) {
-			ctrl_val = MSM_FORMAT_IS_YUV(fmt) ? 0 : BIT(30);
-		} else if (ctx->ubwc->ubwc_enc_version <= UBWC_6_0) {
-			if (MSM_FORMAT_IS_YUV(fmt))
-				ctrl_val = 0;
-			else if (MSM_FORMAT_IS_DX(fmt)) /* or FP16, but it's unsupported */
-				ctrl_val = BIT(30);
-			else
-				ctrl_val = BIT(30) | BIT(31);
-			/* SDE also sets bits for lossy formats, but we don't support them yet */
 		} else {
 			DRM_WARN_ONCE("Unsupported UBWC version %x\n", ctx->ubwc->ubwc_enc_version);
-			ctrl_val = 0;
 		}
 
 		DPU_REG_WRITE(c, ubwc_ctrl_off, ctrl_val);

-- 
2.47.3

