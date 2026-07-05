Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87508C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF2310E15D;
	Sun,  5 Jul 2026 08:01:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qx5yspbd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L2iYOlQU";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E00510E14A
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664M0oqL4002650
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=; b=Qx5yspbdlfUNL9ii
 fiFxRKEg9URPnF5RyoeNJjfADJQCSK3qyC5AfD6sEW2OE6/AoozW1EnPe5KkSxBq
 gKPJVcQw0bwKU24LhvZ+s9DJopAQI3recdlIKkAcBoi5fyS+V3JFCglRUiq+cuN8
 U7C6j+tdGmA28tmNlaOKCEbAv+8QH1ufWtpPj9VCrOGhNK+G+uXNMyUUzuEoxPml
 UCLHq+EuPap757k7hRNrEMa2aFQTZrgMUA4MU5oEmoXUGteUKnwplgCdL3mjmIJa
 n/itGay7c8Sjh1L4PLaGBmojl2oYXWy3Ks10LI0j/OepYOjWDwN+AKG0iwhPL2+u
 ncSDLg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej7n0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3855a987c0aso188901a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238498; x=1783843298;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=;
 b=L2iYOlQUPQWBd+SQ1RchczUL6WafmEw8Ks9t0Q6Qg8nwiVbNbIvmRp7JKFuavX4TxY
 Y/0oI82Ai6zNj3ihk5v33qiAxolUoPYfQkKwAan+yRcrXTsEM8iGx5MdoaWCD0IQSY4t
 AhfWpk/mYDIYvRlTaIFtpR2/dBBhxmAnYBjG8zTnh1o4OLxMCZlICQ3+Zb/UBnDHdQzn
 8r0Lmwk08L9jKO8hg2Im1QQxihuooBI+DmYR5AyyGBNk/NZrEBcPKMh+NajHFEb2mbnf
 fp5tfW0bdzw8Vg+33/Tmwi++x0jngI1AQXllEl9nbM2zyfcljv4nD4oioMZpS6XycU5V
 uoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238498; x=1783843298;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sp+ST8wLl/chjFA95pjbvu7RH5+AjrCnmVKgwrVuY90=;
 b=i50hEwv5cSL4cLDVUJvfSo7Mi4TSH+z7rmJmgCM/a+OHIgjdK0OmYU8SCpek46iTt2
 lFXqrvMRumSi4ENwLmmjWkBrBfJGKCZRR8wTcp6RBCY3dJ6iHt8fq6IBMaDBepm258o0
 GMdV6pVr/KX90kWUxVSSuId79o5Y+ZIbssUO52BobvPR9nezJLgs/8Gq4bNIdp+9mD7o
 GEAwWKHI9k4O0r9YFPOdIFY3wefqGwF67ivQU7jRuCe39/J3FAbvER/oUfmtyMc4W3HP
 3Qz9oE2XBsItaIuL0Jq3GqYnmUEZRiY4+5eHC9BxCluy+5fEuyQ8IwtnDAYDTCtCPzAC
 +E1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq41pLYjXigZShI7714VR8H1bEgjUc9C/qaYdxhWlBQUoMIUx2HtMbwTUCaiBBEAXfmrphXIdLA2+Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm8GohQs++qJ0+6nSbiw4LTULOJaDbQzaCkhNYGWEKUuShum7/
 NvnqLIfFtW3pwG7YaY1Fh6w9M2h4cwhUGCoU8Fv22Dgfo9az3LrnCUqRU+2EHMCTF4GUo00HVLk
 HHiP1ZyY4aB2n9pfPNMYlwIUgLKHf8Id3ZkCU65v33acvsNyRkL9s6VikqXn5LES8+uVYGkg=
X-Gm-Gg: AfdE7ckuNR/7gwEO+HQZQwgL7Uke/5oeDDHfCsl8pXVRP3vDZx9yvk97/MDmeZx8k/8
 +nML7MwnbonzqUhbrTnPNMT2s/c5BJBnV0YBEtjnItcbFZKg8+O8QLIf6gp0J9/uIwi2eakyKGg
 mLDltgZjXAe+acMYoAhQJHdOiyqezB/ruKb7bRxRvgiK+JxLRKSy0yIT6RtX0n3+Nwg/lml1ylO
 C1nL5HFDrbO7ZVgyuV72gpkpEnLvFnO1M+8d0Zsi4LNIKj1U7lSR55zCtANUnXyPIztJukHH9Fa
 f2u6S6GJt7V/XSXIml/cbOmEEeS2zxB/iptmfa+dlCmW7/TDL52/t48EwijoHxpP8Dl4FaQstGu
 RYPq/GOmp8bRu74oWRzR0XJlA4Clvsc3/DiI=
X-Received: by 2002:a17:90b:51:b0:37e:1ff4:44c0 with SMTP id
 98e67ed59e1d1-38280b9bcfcmr5425861a91.12.1783238497959; 
 Sun, 05 Jul 2026 01:01:37 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37e:1ff4:44c0 with SMTP id
 98e67ed59e1d1-38280b9bcfcmr5425826a91.12.1783238497430; 
 Sun, 05 Jul 2026 01:01:37 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:37 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:10 +0530
Subject: [PATCH v2 6/8] arm64: dts: qcom: kaanapali: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260705-kaana-gpu-dt-v2-6-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=7387;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=833JfZNihmD8RpBWS3GutFMgkG/8R8DJendD6ZgxV4k=;
 b=46vkw/SaKx8RPOpF2uonJXYMzaFLsyvH53JVEeoX2mQ6/NxyaRlwNAFQLaDS88MJT6fF1y6L6
 oV9ZsxiWnmZDhI1TDNu9FpObgoDGJ+U3IOcGvSq28OkNynzmTyXBVp5
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX04UhyMKi2K64
 cX40wFO8OEDhJJ9Oh52QwWwBAaogzKcbPe4KjOPu2pF27/a8hhpFoksf+VSYZZTXF58TkqiEiSP
 YGkPhd7BcXvzooh890BbwH4fDYvu8xE=
X-Proofpoint-GUID: XrZsJfphlk9F0VVeculR9QNpBUV0sMNa
X-Proofpoint-ORIG-GUID: XrZsJfphlk9F0VVeculR9QNpBUV0sMNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX818kwN2IyJvb
 8vQ5Bvy60LlXAB3cuf4+h3J/GKuegfcqeWJAdzxhcjegEtE/pap4X9LJ0S22Mg4WpTzvM/j9sW8
 Nz/S8ZkN6uIZeK48xdgvxrIsXMnHRtDlh+YN0YSjeQmcnKdMK5g1KkQB+RuD4/G+bB3GX435Ezz
 SlWfTzKuNZFeAUe8XpWvxyYJZvg98rZKctF6U5h3OMVu+hhOJp8QfIGrW+EB7KzoWnoLmlUktwU
 Z5BDH5A0Kl7LOm+Cd/8hfxDxaL57xGy1ilXOvveKS7AZnQQRAgFyTUEsHyuei/eMmN5Y8KOHEmX
 DYbz0JxZTG+qr+GEHMGFtu20W8FU6r0g9LIKYRqHUC3krAOlOBswEJnBtesKsuI9O65X81S0yLc
 E/dSbAeYsrudhSaywSIRpDUSoXix4DfNYcPoEHzc7q+gGPjSZwpA5DgxYaU0dSSlRXDLq3WKoMR
 haF+ZNt8dRQdoX6EQIg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a0f62 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FGf9z4Ax-beoPfFoyYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081
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
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 166 ++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 009f0ae1ee16..b8acd9665575 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -26,6 +26,7 @@
 #include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "kaanapali-ipcc.h"
 
@@ -7059,9 +7060,17 @@ nsphmx-3-critical {
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
@@ -7074,12 +7083,27 @@ gpuss-0-critical {
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
@@ -7092,12 +7116,27 @@ gpuss-1-critical {
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
@@ -7110,12 +7149,27 @@ gpuss-2-critical {
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
@@ -7128,12 +7182,27 @@ gpuss-3-critical {
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
@@ -7146,12 +7215,27 @@ gpuss-4-critical {
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
@@ -7164,12 +7248,27 @@ gpuss-5-critical {
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
@@ -7182,12 +7281,27 @@ gpuss-6-critical {
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
@@ -7200,12 +7314,27 @@ gpuss-7-critical {
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
@@ -7218,12 +7347,27 @@ gpuss-8-critical {
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
@@ -7236,12 +7380,27 @@ gpuss-9-critical {
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
@@ -7254,6 +7413,13 @@ gpuss-10-critical {
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

