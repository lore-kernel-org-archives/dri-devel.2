Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C734CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0B210F0E5;
	Thu,  7 May 2026 13:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZVRG5Qw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdukfqKL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642510F0E5
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647958HZ260344
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=; b=JZVRG5QwiU9Dzm5O
 zlNRK4EJF5AftHsH0MYq3rY+eHwv1Xkq3LF+lGhsDgdknTccP3eEVkIoSl9DbGCy
 DxdHyWjoGbbnpfHYaNKIKdOaZPVdlA+PRwgJgs7X1fAKDNFLE3+y7WiNX5ESGv2p
 mk82kfphqV0EDjkxu68lAjJ4a+vXHTadso/jh/T/owkCUagEhVvy8IxJxyetSqyp
 SwH/RotGMOzhlHy6aXO3+CBXRO+bVw08fYc29BvnHgrMdb0xIqwllHAfR/DkG3Y3
 l8zELjnAQ+GcaoVRIci9HHlIJxZ1hA59qExdaOZHoD4+c1/JsBQ3fduPcOb9/GMx
 c76Lvg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8t7jr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b458add85aso8492675ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159014; x=1778763814;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=;
 b=KdukfqKL+7OISNM+DjYQ+5yfo6RRxgBCX8thrkft0O1AwkhEe0X3c/2SXakSuCsTXd
 tZevDI1s5gTi3BSZNeVzQhp1DKM0qPM748wRFWPFrAUpuzMrNsgAZSOIDSijx0Bhf9kc
 37c334PP/O+ee4O15keZ7BsB8/GqdedYlB1GI2WW6OHwy5rxqzrQ78GhRkpRX3BIC/mY
 ld5RxxKI+XGOzyIGlKZPdetW2M6cZ0564eK9AyCycAaB3pp9/vH5YuwpbGthxwWzLu7Q
 hAkTD38NI47OPyU+WWqyQ/IP2OFHWmL1JypBenBHO+SMDm0XrSR+fPaxct+uzQEENtiS
 D7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159014; x=1778763814;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=;
 b=oGUPBw/svDpM+Ql7cB4HW8cQX1tCtGRQFbvC7e7uqVcVdkHskht9TOKdkZW8pKrdzP
 0aVMq3zTgkkpZLEZUi9wIqxoMa+1HGWKYYozBFoLXWj4TFHmY1mliNVU80KNc7zdAmLy
 AUI9IJKY0T1yRtbCgWHZb/hZBcm5UIzBFC/eND/wWV3YpQDrCzOBlW2B8Cl2YwsLtohy
 9/KtZb2Zx4AZ3YXQ2bIfdzAtFapH/Jv+t8WQ4Y3xLtprBCZ+DPqWTVexsgLd+DhYoq5a
 B+H/7XMpcBP2/D+xAJuf8bCFg+8MQXcdu5WjoYN4CvpCZRntuXa1bHu5zGQAXrcUi0R3
 frRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9c8Vta7gYVnMT84GwF1n3R0AuSaC09CUe7cSe3dpdGA5Ad9/tby4PoF4CVjJssGHIwSPFvTx2/Ac0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLnnYIe27XHm9dU20Pj/4HKSYhfIRvxcfnPVJLUZHGQrEE/eWR
 6rRVvsMoaRQhxZ51MlC+hxdACowIzkpPxENSb0bGcTUU6BeQDDsc37QsZjZPJAwcXvBr8F1oyRK
 Vtnh5sJdTotiiqufbo+y9IMoABsqhlpeMjoXsncgJn9GSnFCTbvFI7vcCtB/SCDMM8k4+5mM=
X-Gm-Gg: AeBDies+4SVN8fOAotzhHUsFva+MpJWfNWSTvQ2YuVSmGo63WpqzPV4J60pMwc+IwYw
 YmCjwM4LOg7i3Qf2k1NeC5ggrRJ9ZSXU5hqrJXvoJ/VinHfaQ5CAvcOA5bV9UPV6bOTqzYPI38K
 hu8J0vS0VAX7PvGF0TeH1/gg8FwCoMdiJfoALqaQR+rRGyCSVdYbeRcPVRQLpwXanneqCVP3SXq
 oHjlcL9YMJOBFbmb7RiU0KUsAnk2eWgUTjHzI1m99egWYIs2Fo2oLJA1/6fD76cnU2cni5lcrz7
 /NKJeIKYba8L05wLs/ByVvD/LXgvom79KrAnxF2wg4pwy4Ne1lNYVDkTDH3/d/R6HdBQmVn4R2L
 L1lAYIDrON1aXRZyJ26cgTkC7KaLnCvSu7YNmxwDk6rJpTvsZ/e0JDOPjeuG163Nm3u8IZgv/5m
 LFAkT4Q4Ze4FBXFqx1ZlARCA8kfzc5u/18dWRYmlJJpSjKPA==
X-Received: by 2002:a17:902:e790:b0:2ba:bfc:76b5 with SMTP id
 d9443c01a7336-2ba78b40166mr83469985ad.4.1778159013551; 
 Thu, 07 May 2026 06:03:33 -0700 (PDT)
X-Received: by 2002:a17:902:e790:b0:2ba:bfc:76b5 with SMTP id
 d9443c01a7336-2ba78b40166mr83469255ad.4.1778159012871; 
 Thu, 07 May 2026 06:03:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:05 +0300
Subject: [PATCH v4 09/29] drm/msm/mdss: use new helper to set min_acc
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-9-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2ZvEjuy2Z2pk8ChjGlcTOYKmEPN6QT5mYQGegDBtU+w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2Fs8iuCFnWQNAir5YldLxUHTFAidnver1rD
 e3RzpY84X+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhQAKCRCLPIo+Aiko
 1SuOB/0V4A6AKf4Xq2JLN3dEzauZcdbsVigA1P2G7rcn1wTRmUUzfJy1MLCmkAbB9E6LbKtTU3i
 0pp5ghS+oEnMckPZJhS/lG1YKeCe3+ACmvMpre6XWsO2C4kjOGFXwgMvqvCOCe+yQIpOvhQuL7N
 Ot1m/S2VoBCIoyF3DdfALknGheSQykaImIi2LZKD47+1J8oogx20Jm1iz8NvipIBuDyOY910R4g
 fMMo6hyZoOaceSVmLV/eap6xFqMwkDxegpVQibLc3Sdul8fCb8s8Df/JyRikyR5dcqJCTe7exgk
 kTjIS5/zJN7Q3IWcCZjBahmww/eNWC16TNQCKATExwxY+SS3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: pEq-wa5GfN88wwqPhAyxRHKcmG_LTRBn
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fc8da6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=X-e67srwgh_QgMMAbO4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: pEq-wa5GfN88wwqPhAyxRHKcmG_LTRBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX72jvF+qwCXE/
 AZ//SG4Y6Ln+OLFLZDhaVKgR5HfD0fo7QNn94pu7W5LfG/slks/+xnsY0VxbLEvlNp0MR7f+l6f
 JgLbBcHGaWCMYyAh1d0aWuWJw6OcwlIW/yLW+J9TK/0rrsJlYnewff9SFwBAQlyp5+rJP25sYRY
 cJg+cE8LVnlKenXt646NCHBd+4P8sHheqRskiVKqyUBMrQxSv/h2DyU6MoZ44hH6RT/wzcEf9kw
 IG3FL4HOn9EejCU6vglQRwoapGk9Mf79x3xFiR5NamLBe4lXRO+pY/VTcelYBC5DCGSd+EQajeq
 7gleIsIUoWjA+SpS8ouhhnsXCDj8QOhTsOQLlHrb+jk9zTspO60hB+/bfKgRru4vOnrXaR+Q/3T
 KM9tjmSR2I0h65Sw5y+rezZ+hD4wEDhYSXBhbaiFpgEvlEnbfl1Zz0HYSnAPhmaFVrsPmAlbOPD
 pxnDr2ZTvkGFL/YGh4g==
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

Use freshly defined helper instead of hardcoding the checks in the
driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 229b47415f29..9f2b366d45fc 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -172,8 +172,7 @@ static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
-	if (data->ubwc_enc_version == UBWC_1_0)
-		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
+	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
@@ -190,8 +189,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (data->ubwc_enc_version == UBWC_3_0)
 		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
 
-	if (data->ubwc_enc_version == UBWC_1_0)
-		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
+	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
@@ -209,8 +207,7 @@ static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (data->macrotile_mode)
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
-	if (data->ubwc_enc_version == UBWC_1_0)
-		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
+	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 

-- 
2.47.3

