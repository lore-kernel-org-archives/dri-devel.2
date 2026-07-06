Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3B8C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6044D10EAD1;
	Mon,  6 Jul 2026 21:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="J4DbrB+j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WR4oqoOp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B5B510EAD4
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:55 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEBVK1504985
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=; b=J4DbrB+jhOv5gxN9
 x5IJA/SUxXqaEzWIz+uaTGf9ENjmxrOqUsWX5e8hgxA8bI43ilfHl6PNDT0DG0vb
 WCzY6/oaAcbo1o2Wvhrk4DC/yMZwplNKpkhSHshUGp/lACDR51i2Q0X7Bdocpt2D
 NCco6LOMC78ojg3oIgwq7h5fMW7mprv12lwMWVliMGgduqbgfDtPwo3WRBXkAWZE
 BI77d7v2gE1knBq6320z2tUpFnbDdGEpQe9F7yhe++5G/zc/cBgpxR+JptWFiMkL
 UsGKziW43XCuCrV/T0d0QxLSyA8ngBux9b0bjlIV4Z8fHPm59XSMM4OEFWwpGWnJ
 3zJ6ZA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98jsu8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:54 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cac01e89e3so3744335ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371954; x=1783976754;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=;
 b=WR4oqoOpg2/BgnB9X3OfBaXbPY8uZbgC14wuUjwiRAl1RJeOQwBTIs5weMpZoutJoR
 ZKglLT/z8Qes6SA34AcAt6cyYc1MTGAcDq9IyVfRfYoVcVQaoe9pGsCuPdx1s2cFGL+l
 6RzYG1tn1OQWjUPVpnLFcJrldd/phN1IzCNqzZWxBViql+78J/h1gMn46/3zT7cxNnRQ
 NrhOo0jBrv/z40gfcqEFsaa/2i6oa7lE2LA1CrboEMkVenxV+O4O39nYlWU2PUcsgfma
 jngk/FC0PU0jJWUCMfSD8OCEJ6BqGsqBtqZ0fYou/SLwSoH2aoDQRCpfg+VXAu/W3/O6
 /5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371954; x=1783976754;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qa7nM/+jKtg1HCqC+sdDdPuWIJ6eeiZoNwQFGtncwDU=;
 b=FZdT4+qoHBBKdfxIl34fKZHiJheMLWBJ+mrLF1Ji6hkNe1Gy1c1aQbwBtbCmTxa9+c
 Y+W9ACGW6puzNo8V/NwDRCL8YBL3LVggkV7WdT9YQU1XEIuNW7eKZcypZ3tzJM4mD0ta
 1Q4U6a236GJRpBeaBQ+kvqE63u3S363oBmMpSq/UZu1lyNdy1b9+f470SDADIlmC8t3L
 LjIN9AVVQbxJFdToKlposBeR0xDoU00JpeSvvte7gOnjNVB1tTT/9tiSAvOssSu/NFsT
 hs2emRNVcgWlTrmGhZafT5kUw8EGdOInZDb0lTn7x35nT56kWlXgtccq+/4habgIh7m8
 NTCw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/jYWWYHc/mB2AxtDxpWKqehOtMvo5Qaa0//McaBM19qZ0oOv9VZKMNbFUYfhFwCu9QEyV2oDLKlo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5lgxCZ84AWWJCaz5DognmTIYslGdqESM6aZIr14HCjS2og3u8
 E5DMA8hzUItbdcnj+DdChB34ko+Zsl6+XBjuNpjKQTZiRpfvHt3n7YZIK24QwY5weMIiDi9q/dm
 tFCAnTO4VFvXjC9PKH80dIu6pZitV7zvtJY55UGxHme4wFEV78GaZnugsDyyO4ITRJ6amp/k=
X-Gm-Gg: AfdE7cmOM0lV62twYBvuvvzDuwawT9lNfg87SRzBuDoLyLZfG8ItchtC4DOHvZbMY5o
 Fut8567mnIqq8KfBlhldvrPV1G0ulm6rDeluttDuqS9scDkYX09EfCq4SD79zQisJbBG+4hKzY8
 KSIfIIn8pP0tSXlkVpCuf6xbFUgG687aX9toUG/XxwuFKv0dsxkcVW4v2pvW92ehSpCufpb6H/V
 GCagX6dGaD5Q5yy6DJhoSafoQygxLvAokNpFCWoZkL2Z4pBPIoZLdQy6bOhTp7fA521iIhcMX+0
 AihFu6R40boMYL6HRw7mstslBPvwykQL31hpkkGcurxHQD0uhcmpe6S0rpW4iInksdyVMR9FL/M
 72NyMUPXW6G1XWC9/+DIk5BuC/VJSyj+22Vs=
X-Received: by 2002:a17:902:e751:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cc92ae0e05mr59298065ad.24.1783371953838; 
 Mon, 06 Jul 2026 14:05:53 -0700 (PDT)
X-Received: by 2002:a17:902:e751:b0:2cc:92ae:b36 with SMTP id
 d9443c01a7336-2cc92ae0e05mr59297795ad.24.1783371953336; 
 Mon, 06 Jul 2026 14:05:53 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:52 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:38 +0530
Subject: [PATCH v5 6/7] arm64: dts: qcom: shikra: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-shikra-gpu-v5-6-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1469;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B9OVGtbnZYkfAOGV7e+idMmskau8zD6EYz9PXmb17Gg=;
 b=EocsNCEZuvcYsspXlMq++ZuX9obJ9DqG9XuT+DH7vkNuX9uG1zfPZU+oZXMB/dZF43gnqSmnT
 sPV/SafOjxCC6F8qTmUW9Uv/DOprP1rlIUxv5uQc60NlDPDMd8kGgWM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c18b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QmmV89ZizECaiV4F4FsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX4mlHqqvg0jo8
 XB8TPdDrBeT/zQoIW2juYP6/OeDKc8kTITzjRBs9BII5iGMY+NqSmpIbvbDo9vb95xTT9czn4I8
 0ZrZhUryk/OTBfLBVZWscrdizjfmw3yU04TJbfaj97m78qzOHfRRunSUrUpTxKogL9HoPIbz8FO
 WVyuBx7YYssXixlvHUYtyeTUN/7ZRbu9qZX/1sIhllDYrwge/mCidrL+6VeN5T1NBXk9x+wMaQg
 BD1vpOrOn6fHfNCDejz+OtVIfqdbLzIP3L5advzSleIFRw8ZIQgcmicDqfSX3Xs+g6w2eEjt480
 PGoRIacNGOXyzi//LozKzSAZt3YmWL61XImhKk5sjyYHG4RXr1J+4QhjvXdTJVRi1c4He9bf5+Z
 zl00LYUc8tJYHFkx5YUKESDXISYd4fd+I6da6lgCBB4Q5fLwWKAdLGoXJBbPo1p5tcoUMzlUfyv
 Qk90RJjyTfQAaZDU9Kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX6x96me/VAuVF
 HnobtTjZ6t1dyhITvN582pueuFizR6Oe0tsUXXu7rf3pYDvrAf90P83Gg5sD2uqP0Qv2z3GPyvT
 Mk15Biw1mPKZGr80lOrBZ8KY9v6CC6I=
X-Proofpoint-GUID: tW6qIJR90M-TQwaZAMEr4c7jv_zmANW2
X-Proofpoint-ORIG-GUID: tW6qIJR90M-TQwaZAMEr4c7jv_zmANW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed when reaching 115°C. And
use a passive polling delay to ensure more than one "passive" thermal
point is considered when throttling the GPU thermal zones.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 34261221664b..eeeaa369d3a7 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2510,6 +2510,7 @@ cpuss0-critical {
 		};
 
 		gpuss-thermal {
+			polling-delay-passive = <10>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2519,12 +2520,25 @@ trip-point0 {
 					type = "hot";
 				};
 
-				gpuss-critical {
+				gpuss_alert0: gpuss-alert0 {
 					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
+				gpuss-critical {
+					temperature = <120000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-thermal {

-- 
2.54.0

