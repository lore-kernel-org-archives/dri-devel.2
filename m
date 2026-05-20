Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E7BCD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20D510F0B3;
	Wed, 20 May 2026 14:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="coCyPRsk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LI5AFurQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FAD010F0B8
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:44 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDXgXS1798322
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=; b=coCyPRskEV/fxgS7
 HkcT432VZ03i/n3vjw2hwqdbupn6FA2Xd2X56hqt39oCUS5AAvIY7uFVIUOfg61s
 kShVE+ZAfSMBdoConruYqX4bnXq0OPzhIeUDpQU4zxPRUqbKVBTiCbcDDUQvQH36
 GvOvKTsMBbPboJbzlR5ZAuNA3ZSDIz9O8/B7XDrwd5Fdx4HoDWS+/7p4S923gMGT
 jdGCh9z/FboxLhpgki6cxH4LIncy7/U4jLHH39uYQnWwolPFQEI4sPza6UWwh6NM
 plqto0OXjgLbSahD/lgBQmPDB+ucekKtz8f8FvgvsM575c+WmOeYOCnrECbCrYha
 XrdmHQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9dxu0a13-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:43 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-63146b7289bso13980988137.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288702; x=1779893502;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=;
 b=LI5AFurQ3Wo8ZcxfLeWZapGj9se3cfEuWaMagdq43tlRUboFhJBOpbOBq5aYMIAvf8
 ebqFT6sQ/1kQOcQ+yLZR3Spsrz6YlD8vDTtNZvaJ0SCMgj4iFjd4Qwr174HvMDMq3ome
 Hw4yfeFVWh+L+AS+bdnqH5tKKXa6SRdJ+cFzdqG+3AHvl6RKiC7eF9de8EXMVj/dkiut
 m6vz3/bptV/zpDojR5Sb2HC6XYSxUUlncX2oXU32nn+ZcGkSAbpp9Ok2lVRsjI5+/vZO
 CJG8KuEEHC3Bp2tA7oo795C00DZZmcWwi+sJbZ50kvwTaQ7GQ+nkVQmA3alHGYA8zNRf
 z9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288702; x=1779893502;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xeqmVqS4sWTzNC5Ka5lPWcTosbNT5mxXRMsZpQCt8rc=;
 b=T8zrvYxO9zU/wK9enJFY5EqdiDmGYm+aG3IrOTyakzQzvGsuBWL3rwMNhTEKBehlAA
 wRw+qSnMoW54Pqgo3W6wHt9NwHn/m6z5iSrSYg+EWbt4yPJ0WceeL5GwC1qRzpyPzEeU
 vIC8afQAdPlea+/zAi1PQuSgXhGwg4VRJOVsYi3Qtc8jPzC0IuQ+5+zU+V0/+H07uKSd
 8WvjZqFv4M8rOkGJPAfQ0+5dUfFPkhIqSOtE5Y8EOV+7Rd1vpfhUQjzSevSegesPPE/q
 gHZHAKpd4eOQ9yZJyiwLrdonlQEyC/sDw+zzk9e705gJjcvS2/AlCYUNl7uJPcltkvW2
 +69w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y9P48uvTEizTTrDitGiyW33t8cR/LPrSiM9iDbcyqXOglcYwGt213EuwzL1059dfYsqNatnalDfY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPvzQOnOI1INMLC9Y5xPMk+3+bz3vUE1f7phPkz32KCNTa8bCb
 fgL2V+uLMsOwPdy3v8z+zc8wmcbIsdEA+L1nbL94elgeSuM1Gv2h9JZYZLK1/zlymQ2F2J1jGAr
 l9tvvh1TIXK9jRg9N8jcrrBi9e00tXLRku1EUGW/V9GvALOY5JansdMghcGrtbVlO+K0fabM=
X-Gm-Gg: Acq92OG9umCrityRl5AGIF7tDmOkXR4isPBdccblEEUQYNxTgaZtnTTSYeGRaUFqfRA
 EZQiCRUYVGMffBkzvT+6E5ipcbKVtrAFZBwr+2z+mfF5fhIijqEl/dVU2W+9rPcpAZn/PMo6rZF
 gStZ4hvp++rh0M5/L2nP6Rs3oKTK4azASUKQm1KB9xPAdFBSxfEEJWpMubM/3FlSGAOTvAaNu8F
 61DYrfxO4AWt5jiQ1Q/GpE8vuzp2nPs+F1Z+KFRfxji/R+ooszmEAlelw8wJE9vDw3eWqNgB8/N
 SOM6vERkuKpKqhV3tAyXmNlJbFrLlZFKojJYIU81wI+QaYdNO1KyZ/gFtviXG5ro8YSI0eR/dhH
 CbNSGciHE+II3PejxkbJLw6VNpT9BBmEXjYV2sb2m+Ad76r8loxeiiibJwYX1lWOQ4bIvDsKvgx
 /4vh9kOEbgsPH+1pj17k9Gdg63HCtzyX4XrJcqIcM0ILwQAQ==
X-Received: by 2002:a05:6102:3911:b0:632:b111:965a with SMTP id
 ada2fe7eead31-638b70ad67fmr12317896137.11.1779288697536; 
 Wed, 20 May 2026 07:51:37 -0700 (PDT)
X-Received: by 2002:a05:6102:3911:b0:632:b111:965a with SMTP id
 ada2fe7eead31-638b70ad67fmr12317880137.11.1779288697109; 
 Wed, 20 May 2026 07:51:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:15 +0300
Subject: [PATCH v5 08/28] drm/msm/mdss: use new helper to set min_acc
 length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-8-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2ZvEjuy2Z2pk8ChjGlcTOYKmEPN6QT5mYQGegDBtU+w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpnSg3pNpgwzfEh3V7TwPJgChmHzrCdBHVlJ
 +Sw3P6JQ5eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZwAKCRCLPIo+Aiko
 1SqkB/9NDgpTEOuwrSiBDqeuqRiL52qgHqQllHdru+mhQOQicKMM6zdSJI+7VvIocBy//xCl74O
 oOkqcYdCdaSvEzPz8sA9s7VozHF/6S/Kx8d+quZkRoiaHL/6oir64aR6ArfQ+gqn9m/Hsmn3Ro2
 Ff6hM9riHxTUfWxgbhRoek0yP+DLvqdVxvDIPoSMNjgtaMSoNYzsjMJ1Ii+qUBdU4RYORk47otR
 7tC4TrtIPVtlC4Oudf4bunUD1AnRBsDaV5FcHZ5bSHxbeIP9420EujU9ePdMG1LM1QQ5xekRSf6
 kBMz8RQCidexoZacg25miN6pyKOGkWvkSxaWyd36tAPMQYpH
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX748eJvfVzHb/
 /IpAfzxkEK/wsCo2dyAuHkMfebdxJtjXN4sB1+ZglL/IN9/8bdpAcn2Enso8Zn1kQrp5eYxF30l
 XipjCdAkaN7ASLCoEN4lQa3sACF1AvR1M/g3tH9EoBPkzFEIjnvZdiD/Slo/lENdA3KhmSNzJY1
 BeVM7a+JvBI6RMHsANpVKstCj3zRGv4CKEB67Gmca2E0fmzfyuyVjGMcyJQqMu2uDCC2HwRiBkp
 Gd/Lp40mHvLTeg9mtur0aW9xdUX7T6CQyS744/Yr0kUJJgowfHhGACIBa7tbMFD+EOK0xZzS8bl
 MEr8LgA1Eo1bMRwQebnyoCRp3LKoEJhYKKFkGr/E6woOkuO3Bl3Jd3plzfBE9HW/jgH8lXDnfmn
 1/V1gwwtOM5f0wcfOmmLVSHQHp6KOmzPEv+zl5XuGhfhaZ0a2AMcF4GvSRxCillh40hAB7vMKyp
 AdsHkI5d3U1o3Vibytg==
X-Authority-Analysis: v=2.4 cv=Zckt8MVA c=1 sm=1 tr=0 ts=6a0dca7f cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=X-e67srwgh_QgMMAbO4A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: q-HonwjM3m5VrifI8sSk58G9vu-mpXsJ
X-Proofpoint-ORIG-GUID: q-HonwjM3m5VrifI8sSk58G9vu-mpXsJ
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

