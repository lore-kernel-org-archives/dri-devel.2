Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E443DC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:41:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F9AC10EAE2;
	Mon,  6 Jul 2026 21:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpDozFu2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1NV8Lod";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DA6D10EAE2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:41:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEIlC1639870
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=; b=XpDozFu2LWxD0NRF
 QZAwx0qOAUTH6lndolSEVkfRt/n595rpztqrLrOuI6nsRg9//N6De1vFyrM1T4LO
 b7WRRmMzebi0hZmRsyHdfoMHK7W56FgClPjLXDyPlbP9V+LgptESY5iJgxJs3XeM
 smV2LG49t4ZteKBBOiNOrOuI/7Nl93I7ME/lJ7kk7rPdbdUow0DbkLUAY1O5ATxy
 wasw3XWaXBKMA3YBuvzd1B0EfKPhp6ptaBAagivk9zdlk4IvszFVLB4Kmu6RWybd
 Lx4VnLep/XuW+/3PYc3y1MPFtjD0vkg+sU6XzQE/eLa1kaM617t8pQF6joPn71Hn
 Jfx3bQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r2yfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:41:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8895156101so5304953a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374085; x=1783978885;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=;
 b=j1NV8LoddzwCo5PtPJVHNf0ikbRZuz6dXN6SkW0XtNYY+s1oV9qqTy8etd4Hl0lcZc
 W/ny68XDEcbworUCgna9AEmg34f1Ouj6m3XUp16Q65tt5MsAui56NE7GBIU0ncrDDnoy
 lOyYhNtFFRoHThPunerjpq04Rxfl1vZ4tchkLRpW4rSTgiNLLKwxQMqJa2ckmc5GvSJy
 84i8VgpnByP1NGaNriNDbCnSmmQer/HQEay9Q6kRBeZQ+4HLiSPWr8MAg585GLbUnkZk
 98lD+T4ABqLkNcLpAljT0eSutam7qYLb6zRjohGfjq7Mt7zy6M6Ng8Xd0OPbMYE1BDqL
 Gz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374085; x=1783978885;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QS7BNKTCaR/fMQBlOz5LdyW+kfRopbgNR+7ZmGi8md0=;
 b=EgcxmL6XvB9wS7BtBIzHkEgycKwa5CoQrjsvxzFwTfLdNWWJTTaMpTAhSkMn+kfk7Z
 6YloyR6fGm9hu4oaGey6gPqZ+SoiNw11Zuyzrqm8dzTgUIrIEenz9iJJcDU039csBZ94
 QFcmJRHrjnOJjz3MgRXFvUYpVJxepTI84Wf+dPmHJCwCyPRIIMwGA9/cS5BeiKz+Oajt
 xi9QZexnLlTD6BURl+pzlTIM0uOlGAs7ero61HCQrQQbSoeIhzUNcOvrjU6MNfFp1uxl
 YiekodI9v4WKie3cGo881dn98aocIwpBfv8b47j8A9CF/PCD92b/5+fGaIUhPGNZgCLU
 xZBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6PKET/CPtWLm4+MxjesQ08Kan9MrSa7mEtoj1xoBl4Tzw3t7IB/stZ9nq7AG2depptbXSjz89ZaY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoV2sImlvAndwWuzNPhi098s3sNKawxa9T72ExpMPezlG75row
 31kU4DRLt9kffZQndDggj2v9BEwndFFhOjTDEgvumYqrRfsTi6S4d+O/n1OIyk3nF5vgw74PUnx
 BGClUn4fkV/CFuH4CECBZNVp+17vkXso+sm+tsoUD+A6ZlV4q082p2twBaCUbl9uaXknTGRY=
X-Gm-Gg: AfdE7cncewVaAJc36FnzJDjeJaRp3iGdzo7C9fvg/MLuw+PgO5Fi5MrxzMoyJslJd+o
 gpMEzhlukp/Hrw2LZo4PeX+yGmHSdM5zMM/upImXnKUjXhqhVxlclOdOTd5mW+/PXkwoG83XCHN
 dERpQhgPRRk1Uz+2aX/8Z/3ng1sozzDzLmHlfyv0unxMyNZa9HBAyvdrEeWAC/fjCULjZP3/jfS
 DXmcfgvBkhm7CG2MrVFBBJ54vYHXs7qvgw04Dw5c6gNclTpS/CryP4KgqqYONEWpXsNUQviOQTM
 Qy7kbGF2PcGnbyL4blDQ4vmM3UWnqyGv7k5ZoSaColYBqWNmYvZbYT/WGVPm89HamSlkAOxKQIC
 Ik9wVtoP1BuaTSf0Op/cjtKu1icJAg/JmiTA=
X-Received: by 2002:a05:6a21:3d84:b0:3bf:aff8:f572 with SMTP id
 adf61e73a8af0-3c08ee92e86mr2157329637.32.1783374084978; 
 Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:3d84:b0:3bf:aff8:f572 with SMTP id
 adf61e73a8af0-3c08ee92e86mr2157288637.32.1783374084451; 
 Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:41:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:23 +0530
Subject: [PATCH v3 5/7] arm64: dts: qcom: kaanapali: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260707-kaana-gpu-dt-v3-5-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=7506;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Paj+Uxrzy46nVOxI8FJpxB45y1EA6N7DR+yUmwEsd28=;
 b=/9SEus1VLj49Qfme1/2sFJTqMKJoEjB2c+6dOgkvo1lNSZmEe+k4v216hrME+T4zoLSMe+JWm
 XpEGGms5RCgCKOFHbgu5qiERzejMXQJWm4xUY047q7Ntp9Fzd/QWmBR
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX3j9PKGHL0D1l
 xa7fu2umXdZY+0uQ8FRrcHrp+zndHvyofz36hB6I5jVlwyG7hlVAUjhMjCmz5vcrJ6LXYGIVbQJ
 B3iSVPs+ycQvrGMsg8JTcn9Dm/OahuXgW4wAiau2KIDKUZPqzoA0yB4Yw1ViKmV1Cb2P6Yhd/w0
 eWBjSr40mv7wkKlwqrNgD3u2AAdeNhanMpZl8enoS1E94vsGSQoxPydNju1GFdnmx+4GTew+G5r
 ehUsZg7caiIpXKGdBUQFS44gXj3kKwLrm90GrAzWkRPrP9WFkhoDNLpDdbyS1sTKg+Odne6zuK4
 LgX96ZdS0DDgmBtCpFhFXnK4+liT5IqiTQadyb3T9/vm/25MzZYiLAJQS1w/9BNKfdUAECN6Ba1
 O0dcz+lmZ72vpXcExnM4rZRyRuAxsbPOk6MO0xuibALoGA82Ft+ASsvipWunz8gBeILGnU2AXLt
 nC4cDZ0/m/EZX2T2AvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX5noONF+IrBeF
 ccisG2COvP2Upk4JQtt4p3HkA/mOWgCbOnZAAXMcPqtFYRcC5lXJ3YbQRTs85X6OGrgoyEd8/X4
 sWhSVfF/ZXldROYQCofsBLXkd65ObA4=
X-Proofpoint-GUID: 9IdHg9jdvCdkj-7retj5d5KJHrqA6gG8
X-Proofpoint-ORIG-GUID: 9IdHg9jdvCdkj-7retj5d5KJHrqA6gG8
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2106 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=FGf9z4Ax-beoPfFoyYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218
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

From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when
it reaches high temperatures. Set up GPU cooling by throttling the GPU
speed when reaching 105°C.

Introduce a passive polling delay to ensure more than one "passive"
thermal point is considered when throttling the GPU thermal zones.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 166 ++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index cce2e0a3f971..79bf32a9df83 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7056,9 +7057,17 @@ nsphmx-3-critical {
 		};
 
 		gpuss-0-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 0>;
 
 			trips {
+				gpuss_0_alert0: gpuss-0-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-0-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7071,12 +7080,27 @@ gpuss-0-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 1>;
 
 			trips {
+				gpuss_1_alert0: gpuss-1-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-1-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7089,12 +7113,27 @@ gpuss-1-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 2>;
 
 			trips {
+				gpuss_2_alert0: gpuss-2-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-2-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7107,12 +7146,27 @@ gpuss-2-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-3-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 3>;
 
 			trips {
+				gpuss_3_alert0: gpuss-3-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-3-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7125,12 +7179,27 @@ gpuss-3-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-4-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 4>;
 
 			trips {
+				gpuss_4_alert0: gpuss-4-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-4-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7143,12 +7212,27 @@ gpuss-4-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-5-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 5>;
 
 			trips {
+				gpuss_5_alert0: gpuss-5-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-5-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7161,12 +7245,27 @@ gpuss-5-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-6-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 6>;
 
 			trips {
+				gpuss_6_alert0: gpuss-6-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-6-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7179,12 +7278,27 @@ gpuss-6-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-7-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 7>;
 
 			trips {
+				gpuss_7_alert0: gpuss-7-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-7-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7197,12 +7311,27 @@ gpuss-7-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-8-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 8>;
 
 			trips {
+				gpuss_8_alert0: gpuss-8-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-8-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7215,12 +7344,27 @@ gpuss-8-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_8_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-9-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 9>;
 
 			trips {
+				gpuss_9_alert0: gpuss-9-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-9-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7233,12 +7377,27 @@ gpuss-9-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_9_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-10-thermal {
+			polling-delay-passive = <10>;
+
 			thermal-sensors = <&tsens5 10>;
 
 			trips {
+				gpuss_10_alert0: gpuss-10-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				gpuss-10-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7251,6 +7410,13 @@ gpuss-10-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_10_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddr-thermal {

-- 
2.54.0

