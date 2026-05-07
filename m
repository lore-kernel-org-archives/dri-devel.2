Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A0CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058E510F0FC;
	Thu,  7 May 2026 13:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmY4plwD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ccFcrR8O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C66510F100
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647958Hc260344
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=; b=VmY4plwDjhCHYlYM
 +Z+AAP7KgsP8llBGO/UbD9X3TbSWHtCYTmNMCia/A7EAbPcS4fdTwsbMYUKo9SXd
 rahkoVLcSzU4lrqMAeYQDAWTBAXTyuk4o9VSkewMn2WynRYp1NgsBQJ34DP1FnyQ
 nB5EeU6prn/by7zBP6gdRwPM6AsTd/yJjRZhpXIyp8LzvG1CMDVd1/fxaOLXrTDy
 IhbO8/T4SKriOzTrJMGZePLooZqj52Jfy7J5yJUnz1Vzpjy0Fuv8jCxTc4YxEl/X
 ZZvJa73v4WTuHGdX4xVFJnD/xcrytWgDHWJRu45ETMGclfIcyyJm4BxAcoOPEnIH
 WDM1ow==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8t7m7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b4530a90fdso20510595ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159029; x=1778763829;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=;
 b=ccFcrR8OCaY+LJrqpCB+Fwv5dn5LGdddztdwwj0uzBiG20S1nsGv1JGyrPD3OeQukF
 MuMPEUt6+1ATqbBHI0GtKo0e/pmreojOpTLw2EHRKKYCwm6reSecoCV4E7RK6utyH0ZW
 oU8AxXUNkAqiMnSCAd9pSk+FHx5WSP+DWIdnzTeIl5YpG8nXoWiQc3q2yKfsa16MOjPp
 eSNmjO0se7MbHcMt7sCnGV5QggF3fAmk3nhqM/jyjVACv7lNKPs6wrdWdKuxd9/FltqE
 ZpYtgtYGk/VycpZZzS8SP7Kmuor3C0shHXZq2RYmeVnc0CRZDoTf1a6bWnEOMCeZ545Y
 aUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159029; x=1778763829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=;
 b=f3MGfpgCMKrOc1h8UhOXgaOIMTq3yt1QleE1cSdwuyRCq5A6/LFvkf4zkbTn91JyDK
 p0Gxe4EDk0KUmLX0MP/Gor+5L/ERq4o/oC10IlIVM6/VAGmlE5b3a9VJ5/8KB9aNvyDi
 mbNibnLyJg6cH+P8VuDH3ARmZQvcmDdxCyv/ebRoD3hoTqReTzDQq4ollhNv4sx8XFjR
 WGPG3uFj15TSZydxNLaUpS/Z/woOD2yotWzQ6wYoXlkoDT/env2KIH6xnsVdspnFak6x
 JT2XWs6HYwwqsUPDcZQsKM53SXQmdoCNxSOWcddAkMzEuC4z881xa9iXCuSWmUfY+0bl
 HOcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XY85Ar197fSscbue+tQJNlzx4V1+yomGYKA83wpgeAeuvpH1cYB2hkzxA52KJFXJwC0cBAumHdsQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGIdUESVPFjrnu6pTq2yMYNXF2vWfkpFVFFlqj2XadbPdTGuN1
 l41deQkxQx8bc0Op6mQ3CFeUjnHtCRRCTJFDRkSDcBXr+9g4Dbfv0ddKjwKGpTtmL11KSERmxvs
 8s7AKoPn+wrpE6WxCbXsZB8KYqkhO9TV4aLhTEMFERmX9ipAQvpqUuWYutd6ZOqmXJ6qlR64=
X-Gm-Gg: AeBDieu0eHWd88NnydOAXsJVQ8rBGMgDt6tC7X2bHq1CabnCvXAcqU+VFELO/J9R4Uo
 BpP8NZ8rFg8bg+LqwUIkeiT0mRjtwn0ZHFCUNJZUEo4D71VGUXdjtN8sDUShcBPLvUfdKlNMbK6
 oXXjYrtsGPaF8uvujAaiDt7IcnNmhSlZLBKQqM/JJjpWQ2CZW09IXecQA5ri9gTp/77zH8ZXZZ0
 5D4UFzfWrw+yJr23DrASSazAHDObqiuNcGpQAQ3Ix5tBV135JRpO66bWdeOLPLZk9GgVqm8MCe2
 bux5n1sO1xaYdCYMtJw/Lia+/B9QdOUvgn17mMJkzW2ASIrzDHniJpUyS44zXjii17XBNtawf5v
 wfJkA+AbD3Y0izAC8yiGoDCN/ggh/aHcrS+WOXLZy7azWHhv0aQ3B5wmq2lnmaGO4qXaICA199p
 S6BqZciFc/5m2N/SriVs+l/1b74hRjgN3cW2cVpXCrdOG9YaBTjo5ul6W9
X-Received: by 2002:a17:903:4b03:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2ba7a2102eemr83850715ad.29.1778159028738; 
 Thu, 07 May 2026 06:03:48 -0700 (PDT)
X-Received: by 2002:a17:903:4b03:b0:2b9:7ad1:bf2b with SMTP id
 d9443c01a7336-2ba7a2102eemr83849895ad.29.1778159028153; 
 Thu, 07 May 2026 06:03:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:10 +0300
Subject: [PATCH v4 14/29] drm/msm/dpu: use new helper to set ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-14-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BQXxAsNkcgoIebP1VAZBuBHx3qvfk0HLeeYsTxoyeyM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Gg97HW7S2QBtityj6ZF3/0f1VawHXqg4xG
 fLihnyoO6CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhgAKCRCLPIo+Aiko
 1Y8DB/98etxhYYzreJFwxxpVfnzD1VfbodcVaUAhsHte5PZ7vdAu3l/05HpIogj2ZmlD8DJR2DE
 oj6/T2Esto34Sc5dlGNZSLdjBrXIcD9FPHV+SJSuT2vf0Ws6e3Hb3IUdeS1RMK/D8SXekm2f5UL
 Uv9OFqCU32NNRiGm+W5pHcdFcnjIfk5r2//igu2Q9J/e3QmO9Ur0FyxSXc/bI5djI7UtJZTNGfd
 prtffJVCuqfxZGPsN4PnCNT9FC/1GdT1Cm/nREzDhkqBS1XvTMcVr9XsEi1T1sh9/tEO+2VhTHl
 9Wy/EYlkHHE8/QL9u5uSe85/5ej65cZ3E/A3s+dlTcFLSGOM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: vdxFnu43UzLZbDBdnxbKiAlDqAFx7FZI
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fc8db5 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=46QewcZEoJiMQYndSOUA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: vdxFnu43UzLZbDBdnxbKiAlDqAFx7FZI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX6upOTCJ0IxDr
 tbB8gGM/ABfC5cPsNCIRFB8W4Qd9vLOX3XCBQd784MC3UY5hTrXVKV9TikqtHZa7LZwfoV+0LHE
 TTkemWQ0h7OuR3qj98CMtPWXyES5T+IAZkVMuDvNlqJSVCeyvimQAO1j+s8rlaeSP135ErWQn8m
 XOu2aa60hoFOkteLAnYY3OanPEpOXZlj2/macWsBCXud/lMeIfmg3qL4YyZGtOdrxoxDq7hjZki
 sXCJyk8AWblxBXIKLYzSHulxDDTLbCsmtfu6J1CC/BG1wDMeXCsu1tthtkzsyfuNyOkk+Y/VcFR
 WEZjRDpCLcqWIDZPjOJtUk84wdsgQE8OIrVs8WzV1kzxzwz5NMyiIvxNX39vPYHdkHxqRHlp7Qu
 NOvXmaTjQyskKgBXIusa3PmFBiVHdB9AsogQPrOVJHc2mGSNvZa4YR0uZ1M1Dl4iWDHOg4hEPeQ
 SOPOBMhWi5+iTefjvSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index d3da70009234..6089a58074ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -318,13 +318,14 @@ void dpu_hw_setup_format_impl(struct dpu_sw_pipe *pipe, const struct msm_format
 
 		if (ctx->ubwc->ubwc_enc_version == UBWC_1_0) {
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
-			ctrl_val = fast_clear | (ctx->ubwc->ubwc_swizzle & 0x1) |
+			ctrl_val = fast_clear |
+				(qcom_ubwc_swizzle(ctx->ubwc) & UBWC_SWIZZLE_ENABLE_LVL1) |
 				BIT(8) | (hbb << 4);
 		} else if (ctx->ubwc->ubwc_enc_version == UBWC_2_0) {
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
-			ctrl_val = fast_clear | ctx->ubwc->ubwc_swizzle | (hbb << 4);
+			ctrl_val = fast_clear | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
 		} else if (ctx->ubwc->ubwc_enc_version == UBWC_3_0) {
-			ctrl_val = BIT(30) | (ctx->ubwc->ubwc_swizzle) | (hbb << 4);
+			ctrl_val = BIT(30) | qcom_ubwc_swizzle(ctx->ubwc) | (hbb << 4);
 		} else if (ctx->ubwc->ubwc_enc_version == UBWC_4_0) {
 			ctrl_val = MSM_FORMAT_IS_YUV(fmt) ? 0 : BIT(30);
 		} else if (ctx->ubwc->ubwc_enc_version <= UBWC_6_0) {

-- 
2.47.3

