Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA46CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2B310F0D1;
	Wed, 20 May 2026 14:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pXmUISEd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BIKOkhFo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEE2410F0AB
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:47 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6TDa118977
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=; b=pXmUISEdXO3OhvLw
 Y5hMss7UgyhFvve4cwXHa4F2jlhBJfB+3LqRC82Jlqi0+loEHGPGqvFPjExMhKqk
 1UAjIEVm0aPwgqFNlbVUBu9yTa7Nwnq5jptpK6Ba69hvwcp0p8ELnL6UZZ75IZrT
 M5ayS9l7KHEnmyE6sMaxXkO9XxK6uHO7E35U3TQGAGoKsF78GdkiZOJjVzDQQ1Gf
 jkoZotsTXjbsdCsS4IjG57Hmioogq9BPFUzAyUkUHsL0UarEaDS00DnBlzk8RQXG
 i/TZ4opJ/BBt0AkkwdntUcJKEGdvwrT4HVRxz94EusMwlGTp1UYFmmsku+7xiElm
 0q5N4Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886fk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:47 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-960476ee6f5so1919962241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288706; x=1779893506;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=;
 b=BIKOkhFovW5vZRgFtJCdIrNukyCRx39BWRNgWMm8vwd0iQDriycE/FBNBwENyHBT12
 zGiB8h4TJMOjlmLNmqV9B0j71GZQCVBBn8LErOWXUq2zFq2xHrdaQCKk9wa45RP+3EYJ
 30q8eufc6LFCJOAFVQopaZZSPe64ttmaFOW5WZAvnO1KP7rbT6Dh4RzG0W0Ufpy08LZE
 0zHjlpny0FXkFGydnRFmMQ0B0G52cigWlwUb9GXkU6fSMdJX0w9M77JruGK4snY1++QV
 UEn17hjmHK+sweDHJiWFomy683mIYB7KD0mpT7bRuT+dqVU/tAi8EGeK9ddvYkOF9rTr
 DEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288706; x=1779893506;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wJB79bVUZrsbxSexjswx340+SsqpUDunWLmQTkIAkcU=;
 b=eGFxdbpuTpwJRZpzo0mQNp602Nt14L+w3bqMZitBHUjCdA8xIBXYH0XKOxqXk3D3Ca
 rN67r6pOQqwWxvUpm0Vt5lMOC7pQkk/CPPvs8hkkHvSmf22DgB4JAJGo6Kti/M5malul
 GaKbX+XtIEcHPbyHXKT+ntDBvQ0nQ/qZdqu7BBklteeRz4Sz52Q9o9SZgqw/omkri+w+
 Lgf2MHXgq5Pr8cduSOKVayY8o4AcP6OlDrQXzA4ZBMqYVOeOkFzebMcd5i2EDa+CNJnV
 6ldLn+lHKDxH9jTUM0h3YS2sjhct/JkKJyLyszUJaa/UdT+uUTaxtqNBNyBoI8cVFt3o
 HyWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LfwqkqJlfoRIaJi5ZgUZFJbqd83P1sg3E9kRir1lRc7QPsta5ronjFzfK5yQGJLVULSjuLYQLT1k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpLuLIlR8FbbzpSH4OG5jeuJkOkLAX/erOPjOksbVyWFYQ9FE5
 5K+7n0s2XMHfwMPr+pv1h6iBZzFHY7+nFa5oy5+SnDR+7zqn9ee5Hac+TbaVJRD2kV5TGVR93LI
 7ZYPD4dIK85R4fZ5DbimmuHdLKcuNsQ/InnZeHUWSv3DyFl6Zb0yADoIZrZ/FjLfKK/2WS0s=
X-Gm-Gg: Acq92OFmpDeVq7VP62uWly/L6wRAcahQhKWbd6V1hV7hpvGMVMn/gGVrPxUSsjSp15x
 JVSphazCwrCF6q5XpD90RUBTs+Le1oAIVnB9paBJIpRm1vwEO1AnbkZ+pWkvHQ2SMw2xw889h3R
 j0m6RWiyXsVBUh3xdENd6IOIkPTqlA/fo3DAw5VpiW2F+idefhi5vG7CswqLogbL0o0M4Sl4C8Y
 aXtCu+STGicnD2g0kfbPBi5r/Idp8oM7EhQQPpDa4bFCs5SubVo2+rC+psua0eVirrINpXgy5Ka
 XByV2/j5SGUYYt202LC4TrE2N3Ga5GFq4cKRyrxf/tiV/dXhmiaxiKGGRMPcX19pPuBjjgBjDqJ
 Z4Edt+OsZdzg/lXLvkoVQh/kV5NJP/x7lPzER/8XvqwadPDDxzxoq8SJnkNVrjOpAhn/OklpquU
 RKmFdckT9WcWAYSRRA4VPvDLi0+vIgGpR1IpApplFYPAJmyA==
X-Received: by 2002:a05:6122:887:b0:56f:1c32:bd07 with SMTP id
 71dfb90a1353d-5760be3bf61mr15069060e0c.2.1779288705948; 
 Wed, 20 May 2026 07:51:45 -0700 (PDT)
X-Received: by 2002:a05:6122:887:b0:56f:1c32:bd07 with SMTP id
 71dfb90a1353d-5760be3bf61mr15068786e0c.2.1779288704472; 
 Wed, 20 May 2026 07:51:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:20 +0300
Subject: [PATCH v5 13/28] drm/msm/dpu: use new helper to set ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-13-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BQXxAsNkcgoIebP1VAZBuBHx3qvfk0HLeeYsTxoyeyM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQxbvqfQKmaPnD4tcPvQi/baX73UhO9vQWK+86Wc7b6lcC
 b39c+u6TkZjFgZGLgZZMUUWn4KWqTGbksM+7JhaDzOIlQlkCgMXpwBMpPwL+//62KwDRyZ7MDC9
 elu1cm20Y9Ck9SXx1xaZOd5WX7686XvmN+cG5a811sEqLR5b7FUKXjee4Jactidcj+9oREy7+Y6
 voX/UHGpkVUSnqW6MVkpY2/hG1WiRGaOKusUE2f76zby8cjdC/vrxqDJquHOo74q6UWw0R+tIjG
 X/k3WM5t32mYfMsqR0Qq+eULBMeGl6zdVUmON5/hILVt0PM8/avYho91QJyVmz+oVLf8zfLas/P
 +sX898ueuzWF1m5BZp169J7L0185zDlzYE/C16vi5ujMeP0JyfeuC9+AnonLgk8W9cc5LNjR4+Q
 yKLGpXvybzGcqZ9cUyvuldHNtOBaSZluQMYKxu7c2tdlAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: iODOq5Bwrbll4R0x_c5QCsjmpm0A4qYw
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca83 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=46QewcZEoJiMQYndSOUA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX0plhF9+TDakS
 pS+PbJ1u2bxbvxMZarqnMDpG6NYtd6EvBSaZEDUMDio0UNxVDwQwgj8gscLJxCcKa5o19JgPjf0
 T/F/TLR2ESuf4o7FOTpki8JJNvEdCaJ0n83aB6mfLTQLilBwmMO5/qwz/ErSd5cOq8kjTzy9ych
 bvyILqpXXeFm4jaEo8ESJYvI7DWJtVOi5ywvsEByVb7w1Rii7aNcSPBeMbCIj+vfsNLYcgmTjUJ
 XovAIkh95OYtk1TioyIrlGDWBFWRauAndqVL0SCPlWw2Xwu1Gz7wQ46M1OMOtORNzIi4j62waHW
 vcM3Dg6Y24YNzcb7tE9eW6/MNXQ40m7E2TOAzwOn/S+6NG8/Hx4gz7VkWAOKag0whzAg+KiI9zo
 kOrAzjh27UUyZ5GmM0BWLm5ol4FbtOUvOhsicFEJVK2UoxZpgAHR0GwYclf9qvw+lUhIiLDsaji
 tLsBkmSuEr3rpx3V8Lg==
X-Proofpoint-GUID: iODOq5Bwrbll4R0x_c5QCsjmpm0A4qYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
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

