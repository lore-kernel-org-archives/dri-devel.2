Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A8CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C868910F0F8;
	Thu,  7 May 2026 13:04:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P3yj3RP3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WRgtU24G";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A44F810F0F8
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:04:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pUxv1424459
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=; b=P3yj3RP34ynowjHc
 KH8tQ62u6AU6lrXx0CswJJpmBkwgPkj6ZCNxOzK13o9g3tetFB7qLoq5HGDKsUaf
 y+xFDsHnZ/bVJ8HRrHPqtVM1cksK4WYWOZsMxzd3JY+Ypx2jFzwwvAztVTlZplmT
 iVhH4vLTShxCaHoOE2c9u6enMAe6ZodTCJ09TEXMU6d/8SOOech0JI+9N/BtCmrK
 BIuriT0jfOhd6SQyaMJ8CPBfrkSur+wFMg4W4VHqzqeXMPJEXHvNVNLQ7rBO+AyD
 /GlTPK7zlQykc7ptTL1pNFmdH8hkskF0rITuwJO/YGnd03ON042gyb3K1nxdTJSd
 QYMLNw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfs47r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:04:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4678c6171so8285835ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159052; x=1778763852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=;
 b=WRgtU24GYWi9rEY0syQGM1cwCCOTfi+S7LXHDlpaOl+rauM+yVG02zjuBHsrtd4dhz
 DWU+Ww1FTG7IvGU+dRgiZUSe6fcUxw3yl2tgopMqyY/phdG5Q0TjpHizE3udNn+5HeG9
 ue8D6/OlF3je8EOuswRQXr3q1sprJgcgfDokr+R3g56J1aotLPRDZb4bDfahQ1FZJoRx
 YT9K1CIlhewdABbO0vZv3Sw9MQVPSKMl4zhxijBudmFrMl+NKo1YSAJiPf7aRaeJjD6E
 CDDvTlVa/n1mwY325dH7vIYdO7b86qIM3lM8tbxTPczurySjCkSZRoaNr5QlPeeZiN6s
 VdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159052; x=1778763852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=65lXVsMjORBSo8yjl1njsl0vBunig5XThYQyN3YvEAg=;
 b=VAkmn4L6agttd5JNmQKlINJ6SYGhMMDvG5fD/Vu8161DOShXsLMeEGAqRFlysqznsn
 mMcaKL4Uhtk4LbVs2cBwOTWqNA9cbY8Q7L2Ri6teZFC1/nLrJMzKyuCslp2oqNQm6l+T
 boxXz3x7z+1MbrrgbXgr2Qg369DxNqDI8uMooznArjmvYURo38njk0LlvbpRv3/e9ef7
 zwRaFP5ISoN3MJ2WRCZnPPAoU8+Qa7bahP2BwEbOouxqFzssYNRk4qEZWIKf7+R1tb7+
 /cAvFWso7hmC6z1N0w0bZflxQS1fywH5UpK9lpwnJRyRRjpYGNcdYBqMUyKajsb5Ujvu
 ZRUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ96ORXya9R7IiVs/QfUBCbZx9fzKEnTf8ivlrAWoHDIfrkI33bJ/uH/EEEK/hIVDDKWCPRIxyknWkc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4i8XXQIrRlZ/g5Wk9rVY98aJqOS7/6lMTYWkDGk3eBPHpFQMI
 +K6+MgencZvL9BGqvqQqFiQ8LgyGtCmDqqS/YKMd9m7W8j0yOT8panjhlym4foqRHuemPxpkAm2
 UrgyFQdufl1TH7BkR7wd3zk6zmCLkESnsAoQZx1bvN6DEKQjfsuAL8nDiabhFJdf5cOJe0Ss=
X-Gm-Gg: AeBDieu0k8fbhpkghLAUfMU8Xs+86wBMbjrEPNqPGdf6qOqpQrs0lmGPQo0U18lW/Gt
 Z37vdpP0+oicTvvjfWpdNaj8QzlZad5UmU8BmK92beqyVFBc0LN2jRE3vQni8L9C+OEyx4eX7Jo
 xKBesXzBHxSTr6bnJ6IuGzefiRnrWYG3zCKJOKRtZq+c7YftwntI+Yo0OTxgAYZ4kHO/f5YT9iU
 QRgLDygbPJ/1kbfEafmRzoErvxBRL301BetL0nlxSFBxnvnDQlsncgAw/VMaKHV3K9EiJjSrfXP
 nI6TouSp8CkXD4t3ZRYp0Ginnfkb8jGylAtB4Ripu6tbcGckGc4xMQ+6L3flr0Iro+/4tBmhySI
 EI5bQGTt7YVTIsi/nvLunB46EYKR6KPH4erjcXUbjlIFTeDs0T1LAffiwBrPgZS7otBFGWDwGIf
 tTxXdOz/5JFAu2Mi2pxJu6ykzPInsCBEyywO8zA7TGGe0giQ==
X-Received: by 2002:a17:903:4b2b:b0:2b7:aa20:3c61 with SMTP id
 d9443c01a7336-2ba798bb914mr91530785ad.33.1778159051782; 
 Thu, 07 May 2026 06:04:11 -0700 (PDT)
X-Received: by 2002:a17:903:4b2b:b0:2b7:aa20:3c61 with SMTP id
 d9443c01a7336-2ba798bb914mr91529775ad.33.1778159051156; 
 Thu, 07 May 2026 06:04:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:04:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:18 +0300
Subject: [PATCH v4 22/29] drm/msm/dpu: invert the order of UBWC checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-22-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DoG4I3IZOv3niHJgYIouUp5Khp2qZBqtf+51O62ZQvs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2HUEraf80SK8FcVrFsUgTTsbMX6pEtcrmT6
 84e8ALkn/qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhwAKCRCLPIo+Aiko
 1T19B/9uakUauWGXv/L+z92aCcBh59+PkV7ZXbHO7mA2eOI2XrPKOIgYB5DmL+phKbxUDbcmFjv
 yesFNpJGkO+31N3Zee9gWy1GYKnAUIu7rg44/flECZjoWZaYDZLnT6W21fe1qgNmIUg37XhjIoB
 hBgGXgP5ReYxCdaHyWBFLVQd5bLS6A6EI6TuiOh8t3OtbIApjjJMdFKwYlGubAA4WGLJegis+58
 ga5YeKmLVJ01/9fZQtMfgJOoIW04Hc2GqxVtOQzHZqduHDy1viyFHgsgn0KAVGVR+ySuhoyo/Z6
 cxHJ76qcjN05aXbVN7+hLlK5bwdRtvJN8RzyZTnPMaMwRhu5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc8dcd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=l4KHnsLLE-ungWRp-RkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX9gkYFga3oSo2
 Ytz6ayVlGXuMR9FEI/6UsDs1aItUVV3LKiR+YZqZ0F463mr/EWhnOkQCsULmsg4nez2fV7DKDf6
 +xMRccGR2L3GZ0IHNqcLzECnZP0D5QyYfgG5TflKbsWGJlhmJ/bxZr54VOnnIvQHbrdvxaRPx+/
 OnNBTe1PjW6sXY7XU8YYDQk3SO7/62pYWuzAa0mpVlTMR6ol1URzaheuXB8ppqHaL0ZAkKwmW9R
 Q0+LfuDBM5hMXUu1hQkqsz4pLB7u4yN/kNjE28CQN9Vvbd/agCg6hZlj8pO97yXgeuhGFRPenBo
 nf8/VU3lMLG98+i5zVh8FxB1fLmsMo6EHohzTbqJ0tbvLCSsO3HkC6tV28uzceW0ozqXh6sD6we
 m9qNrqmYlGLiS/cRyB8REMaEYmV8FrN0Q+Rtw1dIRQZ5IfhHQsxfDgczMEdhF7euw0Fe85xI+h/
 lXmW+EDN1FAQyXC88Rg==
X-Proofpoint-GUID: yccVDbnhXUsQOBKm5_303XRmb2MAX-u8
X-Proofpoint-ORIG-GUID: yccVDbnhXUsQOBKm5_303XRmb2MAX-u8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

