Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43AFC44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1363B10F8FF;
	Fri,  3 Jul 2026 20:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZxb6vtT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eP9ypAGz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E821110F902
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:36:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPONL1005346
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=; b=SZxb6vtTWsuUX97G
 SzcIb6CGjrgSesGPlc/VNJiwcsqrxlLNsVGeFauhYH4fgRIVWmV25pfpcYn284Tv
 L+NcnawufYpSOTZOWtrx2/CfO1xWv9FPBNaN2FHzkDg7NZoqqzikRV261dd8c4Kb
 IG5lJokMeN8qBCKeXLXTEO8PnABy7osOcXKlQoKbyhwHU80MqpcpbjYogTf8lAM+
 XAerE8rByHdKnfMafJ0YvK/gwSzl98V1D0fvYZFpGL4OqGlh9nTIXstlBMJNqZOe
 IsyZMKeq3MLfXDSwwU4zKpAdMXLFqThg/rnCkZd+nnUpROlaDI2SOygyVXKoQo9I
 l/CR+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycknb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:36:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c889d1eedcdso1421523a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110971; x=1783715771;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=;
 b=eP9ypAGzmU4ZrF7GcqHf/FF/+qBraHqxzaRNa5neUSvHGngrADJAwL2RYQ5DLpCPo7
 EZAG+PyflVfgcywTji/iJ1y/MRhh1h9uljXmMmUCAukWWpNcwY7msv2Ua/rc1rul1YWM
 ORDVESM3k27DDv5gWqgxIh0I9ZEgpCTbOZbhUY2fQ6g8SHkhI+7AncZTT6wo2oea9GWg
 lon275u3gtVmF16XCfq4kqO1WqShHX1yCY7oHuFQec28t09iklg7C2a2xWDZ6Wwy07uT
 o8CWBMfRuWngSVvpko4TvDojRPqYrDOOPCBv558N0PKK2vkUDa8JSl4Q2uaQeftHTxpO
 7TcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110971; x=1783715771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=taQ9EvWyaan7heG3WK46TYaRVPzXBOWXtP1BA9vKA5Y=;
 b=phQdW5fICUtRDwIYBSdicU7nGK5cUtSKW6yy5Db25Dv2b/9VKEy779oQJURmtHGtRx
 Xawu0RLEgAo4gekuToS4QVTnIkefmQk5usX5qZh5evVvBzGE4d1DVWd5uwbq/GzB0N7P
 9pJSAdI8lWetmH+xOG4vzq5rXEjiJDCn1Adln592uwcUa/cOrpOj/MDSX5sxBlkouZCr
 a8Uwf/XjccRNTNxY1d/7ADwe+bYCHQHPvWDAd+mQRpQUAOlui3D9eL8T6j+STXI1izW3
 wxFkmG7L2UYu5V8OQXkyk89l/ge6uiwEOL5UZICLc0rHRQvVr88nvDResra2BW8pqznS
 qf4g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+102ixEnpWQ6F7Ot39/TtSyA4X0iF8u891AA/aOrVPbN+oz11hXOCr3aMyDnrHfvhg0lCei1sjVU8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyoZBO5HqWXaoGYIZlU0PuJ7jKDwlfuoaV6pSps+1ohzAx5QOto
 mMJYglQUTKKGy1MjNlv57Vtnk7ac/9+bua0QGBbiJBSM2Vdb8Roe/9NWX+CJ7dsqExy74NdVLYv
 8CuhJPk5tMIGZpL37AxOt1ircAuPys+kJL8Ab2evQkkJn/Nn7/hegCAsvXdmwtHp8uBi0sZQ=
X-Gm-Gg: AfdE7cnbOofluGvazlkcbGdchBy20i1RIC8i6TQO0l5MEcHKfZXV/K9M5XbwWF7FugE
 R8TnyWwzgfYHlw6Ef3Lp2+nEYMf2cVr2sv/dktfQW8lLQLKLo1m8PRWdYPITl1PKFOFMDr3J7BF
 Ve4/4gxXlEu7Q2xzc6qPsdri0Yx7nkgo8ecPHb7O4WjSLKPGm1844MJ8YMDlFdH41CHQxXSK1Bs
 MpOwKz9WKd01P2QlHpiuIL/JQfBIxiQRf40WFE+4Tpcxy5hOBKtO5mGuWU6w1LeE0vUourPwYh6
 eHHrf8Sqv1CtK6VWBS1Xb6zOFIN9TBl8tKYWHDaed0xw3VegYhrTRVENFYOkZH8tZPu6MqUh5yZ
 Ywi/hyM4KXv5eMk2PEMK6lGH4EPNTj1bLpwk=
X-Received: by 2002:a05:6a20:2447:b0:3bf:c223:4640 with SMTP id
 adf61e73a8af0-3c03e4a33e7mr806113637.32.1783110970888; 
 Fri, 03 Jul 2026 13:36:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:2447:b0:3bf:c223:4640 with SMTP id
 adf61e73a8af0-3c03e4a33e7mr806080637.32.1783110970442; 
 Fri, 03 Jul 2026 13:36:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:36:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:32 +0530
Subject: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1335;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=74nTS/9j7but5S78vS03fz5EaK8dfgZpR5pvQr3ISuw=;
 b=fhhF8bApESeoCdnsnhF6TzHQXTVfkzqJcFK9FQLBZgaMco8/KlnHfQggBrdsaT5VC2tQRhWNy
 UjnSFkiDIsEAWy1Jg6evvcA5ibpUHPzGK0ZoBVjfcDENiYdb8fIeL9R
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX7jbcrRr59rj0
 sfiEPr8AlLuckLledwcQGY/WtzmmULWXBkptMDsCJOHAtkE7KvsCRnfR4Nfujbke7f4zLIlMEXR
 2/ImjHoldzpe+aTn2wXMaYo0Tt7sD7uGQWkg9nWHtoeNczFWUQW+Qyr7/SBlaJvx9GEHuAICHRX
 rHsA+yFIZWuFr5/1lYLLHQZIABFqtGchkeFQ3bHF/HAzHUrkpb+ML9yk+o88FkHv6/eTLaLcf7Y
 behKucUE5z6P4+PVuq3oEbZDQAAVAC+Y26mw9xybBz0pmx91RQxxItDVAhmI6XJgcU0J+G/+9p9
 scelycR5Lur+4RJy7YfpmYnE6EdN9CUcyLGa0gA7ML3Ey3P04ETkQb3kmXcpB5OaB2Eius7skuT
 rSmhm6H3Iek1I9gjzXMTlXO3Sr7fo991lGMch+rqLxnuuxGj/UVmKU17cPPdkxOPrTnoiQwxzMC
 SxzfB77gVWnCtoDmYZg==
X-Proofpoint-GUID: 8LDxGBrRjQZiXuVcqpAVgo9o9hyM5bEA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX4GDaegaQPn9h
 rH2YeNfGWNDKhFr3Gl4GOJPIfiRRo9zLMfrIesA2PuDMkMjG69osTZVK/xsfxv8f2DrPpsPnF+D
 yWepArr5qy7wjpejhhZUd5Vf/cXAIqA=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a481d3b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: 8LDxGBrRjQZiXuVcqpAVgo9o9hyM5bEA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208
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

Set up GPU cooling by throttling the GPU speed
when reaching 115°C.

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

