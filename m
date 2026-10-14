Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE01BCC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90410EB57;
	Wed, 14 Oct 2026 23:51:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC11E10EB57
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:37 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMItdT301175
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=; b=G8tLsI76cPThJ69z
 IBLDwtmos4tR8uMyoRCxTfmwSlK1Nw6CgnbGhY63jy1gKsIxkWsvL//yTBPudf+N
 rOJLOWazuU/UwnlrekIsLZjjK9un4NKl9KvuYpns/Le3eGTuKGSFRqUg5e9FWdat
 AlV+JSv58aWV8M5Kf0FZMQjjryrnTQ40IcwE1n07nouyNaGDrqrn61RHyZDqgExD
 BmTCSTe31YO/f/z5fPeWlWz9Dld5JfGjNTrxq4/S6jSpK3OFDYzf+WAaJ17GdIUH
 HA/tiicEqYS+NPlvvn6NiJqMTgfXTwSVF+KjmCmVH7Vfc8iOTxWUsyiYWN0VIAhp
 SOvocg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4623ygb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cbf2fd504so163019985a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021896; x=1792626696;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=Pvu4Y/Jdz3/0pLfCRhVIVHtyu9drBd9OqEEtgyc3pEC1o28mn5KqXtd2qgj3dMZnoO
 VMMIVxCQGVbjLHouMnwQ3xSmFw/zXLNbMTJ5cHeqfDbhUqlLIO7zrbieRQbYbor110MF
 kOWJal2lmh1vqNpPmA7GMGx1ABX/8w8w8UzizB3Wtt1K9oOjSUgdE94BX9Tu3bNkEOVE
 GUFk6yCS0kGcgoogVJ1W8xfbxl6/m0KYXb5kDkqMFQiscr7xMWWcfiJgy5vWW+jXg4yF
 9fzKJZ0IH4T915grcCBc+2lCe1UG5n8qdT/a3xUemj8icKaen3AkX2zhw+eqsjWLLxAr
 xlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021896; x=1792626696;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cK9XIjoJkCr9hVq/5NleYDwc98kzEkgjzgNbxN/oBho=;
 b=PzK5hZDzcLP4mBkYXLTRURipglZuOfiL1JGRuanUccPQc5FbBr6OsjdMXfJOE7rays
 vLabCV2rlo5sron5FqsbNh3gLPM98lUzXu6n7H+AH06WjwhQZLI3Vc9z1+/RQFij2ds4
 E/GH3n+KNCSyk+y3YiN9b920oLd1wGYnm2atz3JLSCndU6UMoOtIl0ezdTRRwgyBLtM0
 WkFuujBCMemAky2GSQ8WWpti9kdBMZmcQC/KJsDSvCqPKPTl2jPvAuC3Hp2vqdJaQf24
 X/haA3riFBnvBvasd3tDJF2M3MxXzZAeDUP/CbkxS1P6P7w+WMopbLCL1Z7sag0Dd14M
 aRTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgIF3/IYC78GmqJOOBWfzC+y+J/RUWDtknT7OpPLIKd3uGqDvx9sfwZCTncT4ZSdlqUy4dedwbeTw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIeRwgP4QV9zsvYomtKiyQhWSG4kuYLtnN5hOw5RUeEuPlehV+O
 H98IIVSh2WK6xBtCx8T7EMvWp6RuNH4Vx6p6OdESNBsAzrJCYqmBJPc1URhpNJbWnDfZvlTIJay
 ZgXLeel6FJRcqvHMVxMAKgJFHSg/tTccipIrJyckR/aSK/S7aeWzZPgdP28fzVja3lU0hGKg=
X-Gm-Gg: AYBFou2uDVTDWgqq7tat+hFcvq44menMKLpixXkoiO5q1NjVnb0FdGA1dGeYSrSJ5jq
 zUpp3qEFnfHCyWYuqrjjgQZ9kyKdawO+kIGyDkEwfREfMEwFqgiM2rQhQ2Sizi57KKJFFnP0S+w
 kSwtJTyqPOYBToMOOR24i/qut33jgRXCLIk9/9EpNDoERD3UXxgpOdZt8v4UYD8uZipTMz8dnTJ
 W31s8PQkk6JYX8x80YYiaR3z9wZnuBUc0OiWdUtrbVrQQGyYR3mGYgpeKqCLuXbRLS/SRNB4wMT
 PH2PF3oW4b03FbeO5an0BLNYq1UGM9tqKY4wJaV6JeNCxvazxuxfBfQBjYwoQJZoRm26/8wcfLS
 oj57G64OF/UKKUzFEebS6yAXFJRq07WAAArhwFyrBX5tCdVjF0IXTQ0Dy0Hfj255IFmRg7Uth+p
 HdlD+nWRs4ltWc
X-Received: by 2002:a05:620a:628e:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93ebd224887mr2590641085a.18.1792021896066; 
 Wed, 14 Oct 2026 16:51:36 -0700 (PDT)
X-Received: by 2002:a05:620a:628e:b0:93c:8544:6adc with SMTP id
 af79cd13be357-93ebd224887mr2590638485a.18.1792021895674; 
 Wed, 14 Oct 2026 16:51:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafded5414sm2285281fa.16.2026.10.14.16.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:51:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 02:51:15 +0300
Subject: [PATCH v3 3/5] dt-bindings: arm: qcom: add Qualcomm SDM845 HDK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v3-3-1c179cd0d16f@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BF6415btVpAVudmuKDsPZH7SQiNfH+6JB5g0CaPUoN0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0BV5IzDMXa9K9W+5qSi3hDHbsp6MOA/nhD+mf
 UCqX+ni6SCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatAVeQAKCRCLPIo+Aiko
 1ehvB/9caRFwuQem+RxOWHYn2bSAIPtNo2Qe8PRfp6DGf8AMCcKm8wxrUxK/TO4QPxeYuQ9jn1l
 zOARZ/3OChDaR9qF2/YP+TP14iGxZ8x4S8OIVnAZhqbCccm1jTo+t0sykYmsl45ZtsMOf5YpTQC
 tAfaeAdVGelTbxbnOlsip2kzhiAO5zDWDJYP6X4D7EnTmT3C9RAudDNIIxnWER0yJceCRIYSZ7u
 Xfsq9bxDkrfP3NzzU+d8Kc8b0KlLA19fsXVH+dodWqbqOjYgz4ZnVRnyGKro6qxpbGRBPMIArYW
 Bsqn/95e57n54cUj299X7JYm+zoTBAeorgb2jWADT32k4KzI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: s1K6XGnNO-sD_2B9M-4V7qEnusOGEFAD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX+GcN7gn3hISq
 P6ipW+KrgBy4tg7Pov7UuaM/dFrc+ENxeaiUXdVs5OuR4yQ84bQ+dH0FHq5VCKccbGIgt8QrRPS
 p2DzcjmSJU+VV/gkTRV8sHwaTayFyv1ZCnN/nqob4MSDqRIG6Fy1yZtUBloNuCEWDlH3OS0Ou9c
 2haKkmNOzRoVV6m+pMpk4fSB61Xh9T9NFeDahhR7G3JuPauMqzlyGXwa/Gfd3dm7TDH4JCgJ8ao
 BXQz5jFOPjD1HbHz0VnaCy6iwDcK6VzsngZU9QrfxdkCetTjbwXu/WvhO6mLBd4m29hQcxMfF0Y
 E6vIw0TnOSjQNQSWKiB6dq8XeL0V0XidTVHMzi5A8PVAXnSsfEJ7IC3LgZ4Nw5oV299Sw7CeQVz
 KOAsvWr8qpFhcVa4YKvhOWKpbJFBGo/f3T/iJOU9QTj0JCDuTB90BsbpI/CAsaM5CfB5HDK8+Gv
 3mkjIP64sYdpcnyMvow==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6ad01588 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=9nMZPvWkDyzw5AdY2PIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX3q4nxz69q/zD
 n4TtP1sRx6Qh0apzXdgV4ZeOLn08y1ExTZ0mtYN2XqVdvGAN+ya8KdVYNejfCC/3EZHXlm9uUQh
 mzB2NG0tbQ7t9D/SwuSLNEfXCfIWaes=
X-Proofpoint-GUID: s1K6XGnNO-sD_2B9M-4V7qEnusOGEFAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140095
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

Document the mobile HDK for the Qualcomm SDM845 platform.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..dec58f8818df 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1003,6 +1003,7 @@ properties:
               - lg,judyp
               - oneplus,enchilada
               - oneplus,fajita
+              - qcom,sdm845-hdk
               - qcom,sdm845-mtp
               - shift,axolotl
               - samsung,starqltechn

-- 
2.47.3

