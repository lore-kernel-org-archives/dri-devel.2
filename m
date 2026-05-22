Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D13CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A477610F53D;
	Fri, 22 May 2026 10:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kSTySAbj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V713QsQd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9238410F540
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:13:12 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M6Y4rC1298124
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DoITA8fvLNtJOW1hfjo3Z8UjqO3tTvhZNsT60HL4KYU=; b=kSTySAbjKJJkJTGo
 5cRLUYa1Jn6d9NM7ZIJtT5S3YFCHomikpvVpsTPUz9+/HlYqwFEe7beB20nFdwMY
 53KoN9+x389KZThvcsegYZqlyFAGjxtK/GGIhNkSCsDc/VgiDtOMSe8Dr5CSfk/y
 IKfIWbRUY0ULG0gUASKOdcOEfAySZthTmqoGPQt3z7MMARqCGZ+qe1SkWyTrIBlJ
 cRpgHNyUD2j+BbWnDCxURRNlEQfjpVmgKmZq8iLb5B7btIaDpzvAnAl6wjmnAmFd
 dWkmnmpMVlBuW3c5AAWb1XSOHIr2KCOzAdaL7nbSRuLnvwFI5m5c7dx7aouLcg4o
 L1uCuQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0afcp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:13:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3662e7756f0so5676676a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444791; x=1780049591;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DoITA8fvLNtJOW1hfjo3Z8UjqO3tTvhZNsT60HL4KYU=;
 b=V713QsQdinBD+M/KLg2bodTBSd/Z4T6Bv2WupeccSDdEo4JbBEQ/EO6KHAgKQbryjt
 KPrH85FB1Vr7eCZxjUS6M15mzzb4HJl2keSMp+xuYhyARUDRoWGS5CcwTqU2vr1pPrS8
 bCEhASpB5UERlsgdBtj1aRFSYRawTnYoBB7EeyYRu47aLMNsI/mn22A9z7UCFtfijLMv
 DlQOfai7SnhD4YvYKGuKVncTHJBUDK5Hzn4QlUnpl/ofNahXNBrI7yZXccc+hysP0dIH
 1FFmSqhEBXlIU+Lo50oKqCqzGmTNpCWDOkAtc3wxmiQRrTSWD3GZJoIP2b5D2OYYUH5E
 qq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444791; x=1780049591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DoITA8fvLNtJOW1hfjo3Z8UjqO3tTvhZNsT60HL4KYU=;
 b=fJT8SI6Xy1Fhsj88xflD10JaIFi84zkeU6IDNw+IvJX+iLFQN6aPFO1JJh9skqWmV5
 21+zyWyYYfu1mtijr3oTj+rNlfiH+++iYzOo2Im7Tfq6VmaAe14MQGGIzR2Vaqy+uW19
 SSonaVtyzsERD3NwJfYTVXsPnX7DQaUtHU4bSlqC3H6T4QQxutIscbxwx+h7v88yR4yO
 y/fTYv42jeXREAeKMyhAJT76UvKZ6pGfHyUWb8pe8Mhqta5+5/rzfsUgw39I2EBbZpX/
 bDbOuJK527uzr+ckfoGWRNKI2QilJqXlm2tJrmtbWShQ9Iu4hYt7vPmY+vAh80VbCu79
 FE0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FdCiHZDIdSgloV4u6dHDyVejOMwuHhqJ3lBbQ7d9cysG5gZzGrQPEH2jk9GDQcLbQvG8tGQW21OI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfw7K8FdXTZnrbX316V9Bm89Gu/mRmkhc4BLPG5jy7AVdbB4Jt
 FiGIOdaPSclJwtiHmpzm9bBeid89YJvzOrcWVGGLNm1tzmJckAGsL99azVUy3y/ZX4mLdbBmWXa
 DRMOSOTzzhd/AEx91bgEiqgFIjFo/3tPMO/mvNoM8euck8XKGxNCRns+Et+7XLTJfkDfOGEQ=
X-Gm-Gg: Acq92OFnueq78yTAMGzEA1cI2qt9qH3s/oaYodk9Dd0xqJzEjtTahLVWeWJ1ZPH+HP1
 i4LkX13Sk5BOPrMl0aodUIZboNgXzRSfQpaWPhJM1hzuF3w8JXMK1bGoaaKEydqeNRaaHlAVmkK
 qMpZ5Upemp8AczUBsMof0PcHJVl2E380WX0sbli4WUhFQZoLPXihZsIFIGR36XUdWuIo5guwptT
 LwyWfZg6gA5nTJzwhECYzjYS/87IUsLvsuSSDhaSO2wAo2tfaf2c5eeHtmqC5DphhdUQ9yKzgpO
 xKwnYzjOGGAGgRFT+h07Aa+e6siDHG4z3cY+kXTURE5KMoRNdAP399tHDlNcU/9yY2S5loDpyJf
 oUT9tBDjtLHgvfS7kAW2QsWsnzGwFKanVW6Cb2XtA0Y+EQQ==
X-Received: by 2002:a17:90b:4ac4:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-36a6741dd7dmr2845266a91.5.1779444791298; 
 Fri, 22 May 2026 03:13:11 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac4:b0:35f:b572:ece9 with SMTP id
 98e67ed59e1d1-36a6741dd7dmr2845229a91.5.1779444790742; 
 Fri, 22 May 2026 03:13:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:13:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:42:01 +0530
Subject: [PATCH v5 5/5] arm64: dts: qcom: glymur: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260522-glymur-gpu-dt-v5-5-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=9184;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xn0Sr46RzO9QMjWQmKHE7i+3Gf4gRPK3q5UWU+NK1fk=;
 b=H/Uy28Sbk+qNyTEhNSg47YjTr7XYAKdDGhs35tS2R9fsH/5iIt2eB3i7MBqvC99rPJraDxMYO
 Zrt0jXlu1LGCLePzYFBh/1VOdRRLSWVr6yV2sjV20iX//ECmglHMfcM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMCBTYWx0ZWRfXwEO59ANtYLRk
 nNhL78sE4d+JzLBN//2/LpwNFCpJollFnnkjwKr8aaZP0Dqrp9MznXlg8ZILH7La/25UZEn84lG
 f+pZdVJFBUPxPC21V+lJaeI1uUFyRdH1rIMIGsWOwfSRS1YIFodeBiWlsezS2VJ5DLg1XuZBrsi
 WFZ+EAiuEGuSq+9bpp0ci//eJ2czkcXUJXGrhMLE/YBHu4HsfjGnzrRpRdcJ5I3yNz9N1rMNIkC
 T4OIJgqpst6ZV6dqtRN4ept0DIARy6+vv/qCIgZpOSF7R1mSPKmwE8qRK2DxCF78AQqTKjbWm07
 SxKKhNkN6PeNXdov8psi16eaSR8P6MwofETG/eljy9d3c7H0iKmoN3tAIIiEEvmpldhGoEUGBfI
 QzJevsuDNi+FywB7c2/0nDmT3Vqi48LR8FSVx/AMNFoiWW/j8ZTYiHHxWSvpWNvgDHw+277IRzB
 pmPCDZcBlCjw0hQUnYQ==
X-Proofpoint-GUID: 5-DIpXFbcaFDr5dKRf3yx-h84cZPk0G2
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a102c38 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1xJfQSZ986TJDthxghQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 5-DIpXFbcaFDr5dKRf3yx-h84cZPk0G2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220100
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

From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>

The GPU does not throttle its speed automatically when it
reaches high temperatures. Set up GPU cooling by throttling
the GPU speed when it reaches 95°C.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 240 +++++++++++++++++++++++++++--------
 1 file changed, 184 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 01a2e32e503b..e109fb5b35a4 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -22,6 +22,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/spmi/spmi.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "glymur-ipcc.h"
 
@@ -7149,13 +7150,22 @@ aoss-7-critical {
 		};
 
 		thermal_gpu_0_0: gpu-0-0-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 1>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu00_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu00_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-0-0-critical {
@@ -7164,16 +7174,26 @@ gpu-0-0-critical {
 					type = "critical";
 				};
 			};
+
 		};
 
 		thermal_gpu_0_1: gpu-0-1-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 2>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu01_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu01_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-0-1-critical {
@@ -7185,13 +7205,22 @@ gpu-0-1-critical {
 		};
 
 		thermal_gpu_0_2: gpu-0-2-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 3>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu02_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu02_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-0-2-critical {
@@ -7203,13 +7232,22 @@ gpu-0-2-critical {
 		};
 
 		thermal_gpu_1_0: gpu-1-0-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 4>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu10_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu10_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-1-0-critical {
@@ -7221,13 +7259,22 @@ gpu-1-0-critical {
 		};
 
 		thermal_gpu_1_1: gpu-1-1-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 5>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu11_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu11_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-1-1-critical {
@@ -7239,13 +7286,22 @@ gpu-1-1-critical {
 		};
 
 		thermal_gpu_1_2: gpu-1-2-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu12_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu12_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-1-2-critical {
@@ -7257,13 +7313,22 @@ gpu-1-2-critical {
 		};
 
 		thermal_gpu_2_0: gpu-2-0-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu20_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu20_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-2-0-critical {
@@ -7275,13 +7340,22 @@ gpu-2-0-critical {
 		};
 
 		thermal_gpu_2_1: gpu-2-1-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 8>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu21_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu21_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-2-1-critical {
@@ -7293,13 +7367,22 @@ gpu-2-1-critical {
 		};
 
 		thermal_gpu_2_2: gpu-2-2-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 9>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu22_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu22_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-2-2-critical {
@@ -7311,13 +7394,22 @@ gpu-2-2-critical {
 		};
 
 		thermal_gpu_3_0: gpu-3-0-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 10>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu30_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu30_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-3-0-critical {
@@ -7329,13 +7421,22 @@ gpu-3-0-critical {
 		};
 
 		thermal_gpu_3_1: gpu-3-1-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 11>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu31_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu31_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-3-1-critical {
@@ -7347,13 +7448,22 @@ gpu-3-1-critical {
 		};
 
 		thermal_gpu_3_2: gpu-3-2-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 12>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu32_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpu32_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpu-3-2-critical {
@@ -7365,13 +7475,22 @@ gpu-3-2-critical {
 		};
 
 		thermal_gpuss_0: gpuss-0-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 13>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpuss0_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpuss-0-critical {
@@ -7383,13 +7502,22 @@ gpuss-0-critical {
 		};
 
 		thermal_gpuss_1: gpuss-1-thermal {
+			polling-delay-passive = <100>;
+
 			thermal-sensors = <&tsens7 14>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
-					temperature = <90000>;
-					hysteresis = <5000>;
-					type = "hot";
+				gpuss1_alert0: trip-point0 {
+					temperature = <95000>;
+					hysteresis = <1000>;
+					type = "passive";
 				};
 
 				gpuss-1-critical {

-- 
2.51.0

