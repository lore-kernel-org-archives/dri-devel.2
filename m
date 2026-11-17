Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A3F606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JHFa49HF;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnewq+Wi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B179A10F9CE;
	Tue, 17 Nov 2026 23:01:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A25210F9CB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMf5eg3559176
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 siz/zSKEacfVeoRztgux2I0ev5lyV0Ru2o9fuzMDieo=; b=JHFa49HFZi8l5tFy
 CmopKikXqk5rsjW2LuUpa5eAhXUaRGQY7SB1ehOAcnWzUw6S0llL36a+Yl0O3Mva
 axzMeC7RtNGLZRC7FH+QnvPU9rQd8zQXVAKs9CP3jlb3mxkIp9eB2C+Td38Z/U5P
 CcO3Y8/4H7RLK66FBdhgYfLtXVp5pQdmkC2gXwuZdQ6/EN5c9mhA3F0hl2tgGHsu
 2+HTUs6OJxq77CNYeQR54DZDcVln573O06G5YC2IkcOD6xiLxs/V65VwZIo7hmDY
 wfsLTrDkoPNEmOZhVzfB4tG3L2vjy1/dlffUeBJvkSs/RvKL6I21wHkeAugC/bR/
 aZI9Hg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yvcg4gm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:01:04 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1a5005fd0f8so693948c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956463; x=1795561263;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=siz/zSKEacfVeoRztgux2I0ev5lyV0Ru2o9fuzMDieo=;
 b=jnewq+WiH9demJiG/7jBbdnLHU/97x5g26hRL4OXpOMvzt9xLhqD9IihVSQpDAjFxZ
 TVBPu7ZY2D51CMn+RFLi0CosNwtJbAZaLICY224fz0kUcwSQ1il65fJvQqDpGTX0b8I2
 DEtJlX1OXfJSbC9S7FrVvP0uQ3DLRa97SvTUcWVrG3P7SnmSYmccs1t8zAhLsCjBFd+M
 u2l5cyxotRBaP/qZdJOrf/zehFueu0zab/K/3wCcHtJ/uhvqBa/CcRXm2EV6R+lIhziy
 nPPMjZdIWfBrAfV/3S215RZ2Xd61JxcS9MDBoSDxiDpoT912z7daLcZ3NzSs12VJ/DuO
 1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956463; x=1795561263;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=siz/zSKEacfVeoRztgux2I0ev5lyV0Ru2o9fuzMDieo=;
 b=RXFrJHtK4rfKgvPD7svkdPFikS5qUEFk6aDiuXVj6wHGFhB/6o3jN2aschcCAnLixk
 BTEFMBXkmVp4Ht3xxMHmYf4eFYxZfVphN2KwMbe0e+oGPD3C4W+m00TqQByKpD6irANl
 88jrDdUcdewfPvur6OZlqSDFI1CyJgEttH0e2bKv2950BXM78zRcgXy3BRzznfAgBJ/7
 7YN/U4G+0FjD8ckqEKsrewa8A1/P9iEOlzszJmosyD7Y60D9CWeBEcgfS292Tte/Wh24
 GWkqFvmyCWPgoH0h2Wr+bN33mK5dt+GToNZhY+Jgc0E8NwgQWljl5qGqfpkQ0g3Qmj7y
 gyWw==
X-Forwarded-Encrypted: i=1;
 AL+hErGHXF4PoaxCaF5vq6SOKfu3AXYBnryXUmMXp3ZoRS38TkYtanJyWNG983K95V0r9NMejJcPlTatRiM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/aLhhnRAAnaCJDFQP8J5kYmpfykHsZqzWivHo62UT01aUuZbvH
 vUYUiMWy1Qp9mIVC04iUN29mc7/pEHIAJlyPH5o5dQKDbfPtqHXTwwag+lzK7O6b1dw2ky6ilKV
 gUHavHqdE6j9PC7/JowMf2GY5OXt0FEHY1glTE8qAEzf+/LhrsozMsL6l1e3E6QxdwjG+XBo=
X-Gm-Gg: AYBFou0FORjkkBHksrUeFjjqtprItnsQ58tOvibS1WJnBLlloHsahkH+2M/FgtaLsJb
 3LsyuQTaN+P9XpOhwwaXjhM68legzRAVBJlj+D8DTlr+8MQtE6Xd1M7QNw2przQ7IHSlgFWaWm6
 8W3btcwG6LQX6Mje0miOI8Rk1i0IdsRj0cFgUOmv8icH/hE9s7KAPNnjiIFV3cpgyGeuaRykCrE
 jXjxjvYDW1kyCj/H2aYVXRYgFTXzWs/Wu44lb8lcGsM5dVWBP09a0FIvJwcs32w9dclQ3fZCnhD
 iYizpjgBGXWtMhXqrenIA6HrkKYP4RKTPTbitymYKT6IOojQUDf4JHesuPMN8puL/8410o1SqFe
 /9JDWVi9Qwg8DD8aur8qxgYOlOq0IskFIwUb1nej1ZXCDaAoJk4zucKG8LDK8Xtk6YQAudmowjg
 ==
X-Received: by 2002:a05:7022:ea8a:b0:1ac:f84d:403b with SMTP id
 a92af1059eb24-1b543be9b4dmr878918c88.8.1794956462207; 
 Tue, 17 Nov 2026 15:01:02 -0800 (PST)
X-Received: by 2002:a05:7022:ea8a:b0:1ac:f84d:403b with SMTP id
 a92af1059eb24-1b543be9b4dmr878831c88.8.1794956460143; 
 Tue, 17 Nov 2026 15:01:00 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:00:59 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 04:30:07 +0530
Subject: [PATCH v2 4/5] arm64: dts: qcom: nord: Add GPU cooling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261118-nord-gpu1-v2-4-8d6d9908b7c5@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=10612;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SuG138OamWOX42yW+EJ2Z/O+U9rntMPqKUFY3iKGNrY=;
 b=IWOVDh/BxIsSuEDWbRaV1jLdO9mUdeWdFqlP5EyPPH/OCtQnoJ5r9pBX8iFHDYz43A1hIniNc
 DMzA4zRdUDYAsnNYgo+7Qh90qLXtk2k6UN4AyXElrDkHo4zYbg5K34O
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=R5OWitRX c=1 sm=1 tr=0 ts=6afcdcb0 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=yCG-QwAGxuN6-aCC_u4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: ZtCchwaH1tV1GwteROEBxRQ9staj4pfZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX+Adhdf/CfWRR
 DTjvNuxmSNlMPmcJxJbo3SyZDd8Vc7NtKmGLMSWbLKF4NTZe6yfebkhE4IpnaZEQFwzizHap4bP
 4lJ8+YS9/wZgEP+wGRzsqL5Fxoe0M10=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXwbIRfoJoRLsK
 MTwwkOSg+7GcrvcSOyG4b60s/5ecTh2vnOzOPi8ixPO7iw81mAjXLnaPV5SY5UYzIZM9BY/u3Os
 NYmYc5hZhnkX/ZlRTPTD1G7HUFhcAS4IZLQKHqlWU5FIlpFjCUv1rH+hBRJD2n40aZAx+CwKlZ2
 NDvtNyVfXKdYgmJ60b4eoiww2PDLEEOHUdB4F2D+bEMMw7MrYdywlUd/11WV5dhpjRuXtewWKHI
 09DExFRUwAs+8w+qdUiENyMFhlgca0zOpxLcnyQ7tYI3u+IYcwDrNwgs/GKOu/j04f4u0DZuh4O
 V5abbwNEGTv2d4skhfpnxJ00X3RIKe6Pgf7bfsBwUJQ5Y6ubcea9c75UYjwoShQMV8mYwp06FqC
 whgHFId6qdxIfY+zFDH2AEDm6cQQQCVhgJGm8KWH+ULLT0jX8QmrY0b8L4HM204spVtux7b/lgk
 GMGKLoLxfSVbQuRWhFw==
X-Proofpoint-ORIG-GUID: ZtCchwaH1tV1GwteROEBxRQ9staj4pfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>

Unlike the CPU, the GPU does not throttle its speed automatically when
it reaches high temperatures.

Set up GPU cooling on Nord by throttling the Adreno 753 GPU when it
reaches 105°C. Label the passive trip points of the GPU thermal zones,
map them to the GPU as a cooling device, and add a passive polling
delay so the thermal framework can monitor the zones while throttling.

The thermal zones and the GPU node are both described in nord.dtsi, so
do it there. On the GearVM variant the GPU node stays disabled, no
cooling device gets registered for it, and the maps are simply left
unbound.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord.dtsi | 177 ++++++++++++++++++++++++++++++-------
 1 file changed, 145 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qcom/nord.dtsi
index 36a422db8ea6..3e29c43ca9ad 100644
--- a/arch/arm64/boot/dts/qcom/nord.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "nord-ipcc.h"
 
@@ -5122,12 +5123,12 @@ trip-point1 {
 		};
 
 		gpuss-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 1>;
 
 			trips {
-				trip-point0 {
+				gpuss0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5139,15 +5140,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 2>;
 
 			trips {
-				trip-point0 {
+				gpuss1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5159,15 +5167,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 3>;
 
 			trips {
-				trip-point0 {
+				gpuss2_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5179,15 +5194,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss2_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-0-0-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 4>;
 
 			trips {
-				trip-point0 {
+				gpu_0_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5199,6 +5221,13 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_0_0_0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-0-thermal {
@@ -5342,12 +5371,12 @@ trip-point1 {
 		};
 
 		gpuss-0-1-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 12>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5359,15 +5388,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_0_1_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-1-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 13>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5379,15 +5415,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_1_1_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-1-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 14>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5399,15 +5442,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_2_1_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-0-1-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 15>;
 
 			trips {
-				trip-point0 {
+				gpu_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5419,6 +5469,13 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_0_1_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		amux-7-thermal {
@@ -5442,12 +5499,12 @@ trip-point1 {
 		};
 
 		gpuss-0-1-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 1>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5459,15 +5516,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_0_1_0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-1-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 2>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5479,15 +5543,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_1_1_0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-1-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 3>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5499,15 +5570,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_2_1_0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-0-1-0-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 4>;
 
 			trips {
-				trip-point0 {
+				gpu_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5519,6 +5597,13 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_0_1_0_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-2-thermal {
@@ -5662,12 +5747,12 @@ trip-point1 {
 		};
 
 		gpuss-0-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 12>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5679,15 +5764,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_0_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-1-0-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 13>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5699,15 +5791,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_1_0_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss-2-0-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 14>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5719,15 +5818,22 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss_2_0_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpu-0-0-1-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <10>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 15>;
 
 			trips {
-				trip-point0 {
+				gpu_0_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -5739,6 +5845,13 @@ trip-point1 {
 					type = "passive";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpu_0_0_1_alert0>;
+					cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 };

-- 
2.55.0

