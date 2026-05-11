Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67D9CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E8810E8FE;
	Mon, 11 May 2026 22:24:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFX0tL1J";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="htP5lEuM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EF410E8FD
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:24 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6f0E2186257
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=; b=iFX0tL1JwxTdVnpl
 FH2njcSk6DdK2fIRndW8l+GZvPaNPKNCDf9bhXCT3aJp0V3s+BjTkzfYvoSudep8
 s7T37BLi+w1GpiVu1bsR6L0bglurLgO25nwUBj9iQuAWppwEdOTQ2G81NEkB1EUk
 3iWEHaACG/ixFmip/w2m5F760FO6s6KqGtulq37Sd/f0T8r2o0rnWNHKNM9K3RoZ
 aJPWFvIerAUp+xD4/ngdjgpOn5qYkw4K3qN5hJ4Zu8ykTQF741lwvFZtX6y96RoD
 CxMTlB92XG8ESXNUzpEV8lZP+n3yE60mMRzBhJZlH92yyZHmEryoIzdiLtF6OxLo
 wwAZKw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28fv2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:24:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82f6b984b3aso2465160b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538263; x=1779143063;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=;
 b=htP5lEuMIXEO15nafCvS3z5JyE6PErkXLhA+MwEoxSvZz9w5/z9RVywhvPZU6ownex
 7eJwwXPTuw6wneNOdqizZo2URVgkbhkcSJqtgc1O3q/7xUvdRgQZJrHGSGm42CO92CWV
 xWyXIQ+aHYndi2IWZZJVgzj776rpChlVfhPSfIdvVYruXBRasDHDl+AsuPbhJ0lfX4Hd
 nm9MEENYjflJL3b3SeEjZeSXA61FQpoZ1CEaOYBd3q5W0cGrXIM6zQfvEL/NhRbXnsaa
 38njCeVOSgr/axd7uYh5kDfyiyzcwr+SrDFwpybCCiBGECN8HTyQSFB46NhRZp+ucycf
 YApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538263; x=1779143063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=57sKeh8lL4FkccDNyKYVDaGV++c0dT2p9qWmYiR1PEs=;
 b=Tz99QiJobZ2LrcjLxwVxSJrQAZT2Qc+gD9sVjjiPTNicFdmrQieQiSOE5Z3lvzQb9m
 z/Xg91wtJCYrPcZqIusNKHyhIiQ13VICftK2ZlBGLW6KAqwbzu+JHo8kOd/umVXGT76f
 FDcsyY2+WjolQ5SvaB/t+m4TDxNqlzXs9dnYyRGjG6Uz8hJM4W4pu2tqUWtMBtuUgy1r
 5EUV5isYHdGfjiSLB+8xilVXM+RA7QxQCqb3QKDZq/SSXpBOLswmtDcUxMZqz7MaYC2L
 NKbqj0ETl2Q2gmY1MDIhH19mHS5L5gz5bDdOtxlQlObKIzC4DsfCu+wnQSKbyqFEgto+
 WCWg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/I8LfHNBowU9RkzMSK/C76NXxw7V2bG03b/5DT+avVOAzqfGKKaVhiFacrnvo6xCq2e/LcorOF5e8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrFT3OkaAsjuHEvI+cPfW0tBgk9eqHNQuSL7AaFGgSuvNVwH+F
 nQjFeDjjDtaUm7cbyxeTh+DKGlQlgrMqN6SlnAw6cN6BQJg9YWJ+gGUiKXFg7Emxqr0hscpEEDe
 e0Y+uBmD/wOAnJ1ep4RBHpV8Qe7RxL6x56DgrBCtuZbyKp5GmvdsxpBN78vsC/gBvtvHxJUs=
X-Gm-Gg: Acq92OE+pFFb16H9JjGkUE+VXRQLs7nMBqXsYmyotQTp1v5h3Y1o4wgULGQ9jVWePDT
 5zk7/TFijK91WiYh1q6MEkSzw6c1giSh7m3qeK+o2FooJQyK7QS8eJxYKuz6iXi2R/wtfe//csY
 QOO/+Xote8PcdlSTHken60WYTqu7xKZo1xeQlq/G+xZaWJ7MQMzhUjSpeQl670ryVOjib/LZLlb
 pg8ChQ1gpwkvbe3bVmaluzLFADAlsk/C2sNqz/ihx4iy6u7cTUfPlu/4O39kXNyJnoJAT+Xf5Yu
 tdHgR0CS1zRyQU6d5Gcpkd11H6Z/oKmHf7y11Jw4l4Ne0hYIMcdqMkAl288VbtshKiKRjKZLl3b
 +gOKbzHO5BvpOz1rzDIEElt6QTTfMkON++aEBHEQdAFq4bA==
X-Received: by 2002:a05:6a00:4b10:b0:837:80a:5ac7 with SMTP id
 d2e1a72fcca58-83eebf9e24dmr308826b3a.45.1778538262957; 
 Mon, 11 May 2026 15:24:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b10:b0:837:80a:5ac7 with SMTP id
 d2e1a72fcca58-83eebf9e24dmr308788b3a.45.1778538262422; 
 Mon, 11 May 2026 15:24:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:24:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:20 +0530
Subject: [PATCH 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260512-kaana-gpu-dt-v1-6-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=7515;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ag86/kr8s9/wNu8KURJAXOYQ6Bs1j+iLqYPusIeA6fI=;
 b=wM8Owlud/s2u1nqMO3HiUFxdka2NfMzsv82KKylH8Ys+RapuHT1nTFY+UvTkFBsMlWzoxSROh
 bY62uNfVaVvBZFPfMENypFO/HWOelmtCw6Rc+QImvshXpSSNFRR5WwK
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: wNiN8wouFGzLf3UDs8tAILU4M11YGEmg
X-Authority-Analysis: v=2.4 cv=CeM4Irrl c=1 sm=1 tr=0 ts=6a025718 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qhQHLv6gl62QQ5NPC2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfXwvSMaq+kWj3q
 v8mQ1YkbeZA708+GX62gHH+s6QVBVo5vSwJAVIkNfcmJXuHi/Ie+hsya5aO1uCcS5Ofg25RE59I
 kLwrKlv+w6FUou8umA8vnsl2rywE1Amw9eovW+nSruX1TegAfhFR9W7/kD/K3DSiD0xNxgBjgIT
 UJ/bWeBoc+A3KaspFoX4r60879TfnJudmvWCFFyqnU41L7JR01Jex3/376OLyUpAoyvt7xSPC5c
 /UaofBDa7Zx9QOm316w3jDHQjy3MFXi+gkOdqIyKlsZEwiMyeK0VXuKQeoPFFvmPd+pyIUhxC6K
 +8W0DHMN0+kEjH6HEPTgFNmQyWmm4GpThQF8sxBwJpUfWgCMtTHHMblVVwuweslybqt2yrhd3qs
 2iC4BYb2ygHZz4YggWzNMnkEKpigln/099z0VyKTF8cPhiRm+S+6uRcpcbsN3xvfyoCS4Pio5lD
 02zJ+mptS1FtmlCDlDg==
X-Proofpoint-GUID: wNiN8wouFGzLf3UDs8tAILU4M11YGEmg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236
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

Unlike the CPU, the GPU does not throttle its speed automatically when it
reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 165 ++++++++++++++++++++++++++------
 1 file changed, 135 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index c57aea44218e..5089416ec32c 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7045,13 +7046,15 @@ nsphmx-3-critical {
 		};
 
 		gpuss-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 0>;
 
 			trips {
-				gpuss-0-hot {
-					temperature = <120000>;
+				gpuss_0_alert0: gpuss-0-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-0-critical {
@@ -7060,16 +7063,25 @@ gpuss-0-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 1>;
 
 			trips {
-				gpuss-1-hot {
-					temperature = <120000>;
+				gpuss_1_alert0: gpuss-1-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-1-critical {
@@ -7078,16 +7090,25 @@ gpuss-1-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 2>;
 
 			trips {
-				gpuss-2-hot {
-					temperature = <120000>;
+				gpuss_2_alert0: gpuss-2-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-2-critical {
@@ -7096,16 +7117,25 @@ gpuss-2-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 3>;
 
 			trips {
-				gpuss-3-hot {
-					temperature = <120000>;
+				gpuss_3_alert0: gpuss-3-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-3-critical {
@@ -7114,16 +7144,25 @@ gpuss-3-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 4>;
 
 			trips {
-				gpuss-4-hot {
-					temperature = <120000>;
+				gpuss_4_alert0: gpuss-4-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-4-critical {
@@ -7132,16 +7171,25 @@ gpuss-4-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 5>;
 
 			trips {
-				gpuss-5-hot {
-					temperature = <120000>;
+				gpuss_5_alert0: gpuss-5-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-5-critical {
@@ -7150,16 +7198,25 @@ gpuss-5-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 6>;
 
 			trips {
-				gpuss-6-hot {
-					temperature = <120000>;
+				gpuss_6_alert0: gpuss-6-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-6-critical {
@@ -7168,16 +7225,25 @@ gpuss-6-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 7>;
 
 			trips {
-				gpuss-7-hot {
-					temperature = <120000>;
+				gpuss_7_alert0: gpuss-7-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-7-critical {
@@ -7186,16 +7252,25 @@ gpuss-7-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 8>;
 
 			trips {
-				gpuss-8-hot {
-					temperature = <120000>;
+				gpuss_8_alert0: gpuss-8-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-8-critical {
@@ -7204,16 +7279,25 @@ gpuss-8-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 9>;
 
 			trips {
-				gpuss-9-hot {
-					temperature = <120000>;
+				gpuss_9_alert0: gpuss-9-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss-9-critical {
@@ -7222,12 +7306,26 @@ gpuss-9-critical {
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
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens5 10>;
 
 			trips {
+				gpuss_10_alert0: gpuss-10-alert0 {
+					temperature = <105000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
 				gpuss-10-hot {
 					temperature = <120000>;
 					hysteresis = <5000>;
@@ -7240,6 +7338,13 @@ gpuss-10-critical {
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
2.51.0

