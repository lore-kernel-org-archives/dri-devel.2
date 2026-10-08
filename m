Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F64CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A69510FD7D;
	Thu,  8 Oct 2026 21:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M7Y59j8f";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EarhM9Uc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B3F10FD7F
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:07:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698Kxwoe807709
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 21:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q+Vkc41unzNxew41NjqyUCYAnUjbaybiTMnS77qN/gM=; b=M7Y59j8fQ+TEaBv8
 KyrSU7dWjYUOkUXB5FaKj4gZKyOg0NTnvlgE8gs8NueMX6MkCVUpAgVLCnaPdLKb
 bq1QZBswHeH98+QQZ19RcqYkbjONhzQbN4pzcAtUFfbUoroEG/MkV//k/pPNsKP8
 ZUYX1qQ4CuI9AXNtZrgsJg2zhK2YW/7+QGBx6SGnh4YmEAIw1P9WCISIraW1hAvY
 rgvpN1nNfJaxiJ7lsn/+m0ORl7f7a+Avs4nqyCy+VtTu8YdupI9cbWNvPQNuU5H6
 cMwKhbprP3WL487wDKviA/sCfs0qkFn6r5NJHyOHKMPY0YssnIxOcAHfk+CpseXS
 O95rwg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxp0n9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:07:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35158d674e1so1458518eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493657; x=1792098457;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q+Vkc41unzNxew41NjqyUCYAnUjbaybiTMnS77qN/gM=;
 b=EarhM9UchXKbgRnxKDHxZpU3gcgam+Awze5GinqO6HI6OwVrfjD+N9DO7B9ZqMgwA8
 cX0uEL+Eq7Qluzqh/P29h0fllpDwcu/oraS2tchlbh5ebGYQLIC+NUnq/Vn0pyoU6nwf
 K5pw1O+ixKkfXhxxWbA3a8nOvWGuFN7k0jPkAKphls7cI+XzZXf0ycUk19Sk+4Ybc2PB
 4oKvCspbulnO67XmVfxcaVDTSMknoMxLiHEkkZbBRjotmDoNCbveBZH0yg4C3qieYke4
 Liypqu9S0dQdxmWK9+t1lx4+dg8P14nYujwMMR9e8V5hnnR/PqL+5dU0HQHHbs3ri8ZP
 m3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493657; x=1792098457;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q+Vkc41unzNxew41NjqyUCYAnUjbaybiTMnS77qN/gM=;
 b=olvgee0xP1tllkh8HKsE9fWFWbFEwLcMQvCFWnNGA3yidmBxQAI2FE0oDRASYsB6/i
 +U9/z6KWjisBtEuYJJXSI3HEd8lzxNt5jDq85VKWD+61ww/i/+VamQnVbJvbeiDOEDAl
 h/fOyn2E0ONpZ3WTVhWuCkT6eeTtJBlCsaIor60eOv7OXlgyk6VZTLMasEC20Tbf65u7
 FywEzQ9CP5J0x78RxlVdq38F3RgX/tOsaaKBHNzNv6SZQ/ckqNbDU0k89AcySv1oaX+n
 ZhVP1E7pu/M59a/Jjnat+374Hv8Xbr1sWilburUvlJ7evIefG9INp5jXLEPncK5tABqe
 0aeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhSstVRfOdA06DqQV+o4Oa1pQ5dSUpdfCK1vkRmpESEf0kiMJbB2ompbS/VGnymntPdNJrjZWZIGU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwLlweYom/5+qdvKUhcmnThyckJ58/a4OioYQehiU5zhcr2MJ0
 c96Pm0i4wrHnOubDXGSyLn95UVaQM1OaEohbv3h5VRpC4v4KENZ8HQccB05J0/6aqq2IrPhQXup
 hFT2Hi2hWDyFjNM6JOKLi6A6KVtR/BWdM5omHFNuyJYvfTre05gCcTpsJbNNUrT0P1Qfsk3E=
X-Gm-Gg: AYBFou1hdQh1OBIE4TlEHJrC6Ls2Rc+2El0Bp8gZS5yNvUOK0W0N0bpJHJfM066RXCQ
 vxOfzejzuWeatpFXpW+PedOb/kweZTtXpslHHuP5l7SdRvLsYHjE/PwlhQy/sWrs3nYizkcXtlh
 prJtM3njq7Zk2i3r5xfz6ereQj06aUcL/IoSHs1QspaF+E9UdYW77UZsEmFKdXXHvPF3fit9g6m
 5YKQlI1b9HH0HdfkRHFbHmu1BcLtvXk6F6rEqK06jIL9l7jx0aiv/lt77H4z4zXfXJZbidmp8OK
 sYE1jVZ7Lx1/Kfza/7aOfbesKtmb+jOhK4Qtw4rJGVt++hOpyxjeZ2Jpq+RAzB7ZFR+bV+H5IVR
 0lNqFG27Fn/pb/yHY+67Rqvc=
X-Received: by 2002:a05:7300:f144:b0:351:6594:94e6 with SMTP id
 5a478bee46e88-3537e085100mr102113eec.39.1791493656720; 
 Thu, 08 Oct 2026 14:07:36 -0700 (PDT)
X-Received: by 2002:a05:7300:f144:b0:351:6594:94e6 with SMTP id
 5a478bee46e88-3537e085100mr102054eec.39.1791493655932; 
 Thu, 08 Oct 2026 14:07:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm634773eec.17.2026.10.08.14.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:07:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 09 Oct 2026 02:36:38 +0530
Subject: [PATCH 4/5] arm64: dts: qcom: nord: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-nord-gpu1-v1-4-a06a6c57bde7@oss.qualcomm.com>
References: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
In-Reply-To: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493618; l=12452;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=5jj3RJ/5IFAiCv3Rof+NOkHigaCXJnGzuVZWWhgkGNQ=;
 b=etf7fNy2G6qqGs1vmRapH2TDTAjQgPfxnyYBFzjsabgU6eSevsB+wqIoG/x7aXky4XUAqWrln
 eq0qXxmvSqsB0lpGmAQxudhEKZBQ4Clr9urEuC2ZMOxbwI3xnDHPMXM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: Z5N01BfJf1lwh7Oy4iue4OA-I6JqakKa
X-Proofpoint-GUID: Z5N01BfJf1lwh7Oy4iue4OA-I6JqakKa
X-Authority-Analysis: v=2.4 cv=LI3z05W9 c=1 sm=1 tr=0 ts=6ac80619 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=oAcwOEFyTfjsga8YSwYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX4d3DUNmHkr5I
 2nenrRo8B2hbR9VbqT7Ucic96Doxd61pIgRbXuVRHtLBkvzBuWS2CNphrmk2S0EWYnx3/6DXasx
 rQs1cMx0tseez5VniP+Z/N4NyU7akqE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX82IDcuM8IB0d
 bCK+mLLjoRr9s/Wd2M1sG+fA7m8EIzjwXF+4On2Rr689ii1cYaoOZP8KvbIXiEJr8Voqp37d4Gd
 s9UN8t/jawFrQrkGo9iJ38/ftGVLHdMtCupu3rhhhzXDPDCwGul3F0mNNlo9tsMn8Bm5kFIQY+N
 sxaqGmpufSvr1BjSUjIXp1ZgZeBwVFCWmxqAPhhyapikEEHR8skBP+FGBG+P9Ckii5DdW9dyYNO
 eBRzo2lRTh45V/vXqqxjP+/y3JlLUbBPZ/RAd6sEp6GZMKe5OKdCNUd69OjEFDLACSq66LwdFeS
 3ijvHIh+Z7bPaB7TnMMguiiRfFZclpBnkJst8citLuJGFMcDfXGy/7XeQMt5xKIlVDvwBKn9Wu8
 v1GFODHEr9ObaAAKhICDXiDImIjXmxnzf6H1P6jY6bpvlLZNEjBTPCGiPb+xU1JEG0NWMfLplcN
 wdQck0U/OcIV3eEq7rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

Unlike the CPU, the GPU does not throttle its speed automatically when
it reaches high temperatures.

Set up GPU cooling on Nord by throttling the Adreno 753 GPU when it
reaches 105°C. Label the GPU thermal zones and their passive trip
points, map them to the GPU as a cooling device, and add a passive
polling delay so the thermal framework can monitor the zones while
throttling.

Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi | 177 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/nord.dtsi          |  80 ++++++-------
 2 files changed, 217 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
index 4379092b7bf8..23370007c974 100644
--- a/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord-embedded.dtsi
@@ -17,6 +17,7 @@
 #include <dt-bindings/interconnect/qcom,nord-rpmh.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "nord.dtsi"
 
@@ -2042,3 +2043,179 @@ opp-403000000 {
 		};
 	};
 };
+
+&gpu_0_0_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpu_0_0_0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpu_0_0_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpu_0_0_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpu_0_1_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpu_0_1_0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpu_0_1_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpu_0_1_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_0_1_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_0_1_0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_0_1_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_0_1_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_0_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_0_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_1_0_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_1_0_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_1_1_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_1_1_0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_1_1_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_1_1_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_2_0_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_2_0_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_2_1_0_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_2_1_0_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_2_1_1_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss_2_1_1_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
+
+&gpuss_2_thermal {
+	polling-delay-passive = <10>;
+
+	cooling-maps {
+		map0 {
+			trip = <&gpuss2_alert0>;
+			cooling-device = <&gpu_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/nord.dtsi b/arch/arm64/boot/dts/qcom/nord.dtsi
index 147d8e595a3a..b032d1d2ad9b 100644
--- a/arch/arm64/boot/dts/qcom/nord.dtsi
+++ b/arch/arm64/boot/dts/qcom/nord.dtsi
@@ -4101,13 +4101,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-0-thermal {
+		gpuss_0_thermal: gpuss-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 1>;
 
 			trips {
-				trip-point0 {
+				gpuss0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4121,13 +4121,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-thermal {
+		gpuss_1_thermal: gpuss-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 2>;
 
 			trips {
-				trip-point0 {
+				gpuss1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4141,13 +4141,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-2-thermal {
+		gpuss_2_thermal: gpuss-2-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 3>;
 
 			trips {
-				trip-point0 {
+				gpuss2_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4161,13 +4161,13 @@ trip-point1 {
 			};
 		};
 
-		gpu-0-0-0-thermal {
+		gpu_0_0_0_thermal: gpu-0-0-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 4>;
 
 			trips {
-				trip-point0 {
+				gpu_0_0_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4181,13 +4181,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-0-thermal {
+		gpuss_1_0_thermal: gpuss-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 5>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4201,13 +4201,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-1-thermal {
+		gpuss_1_1_thermal: gpuss-1-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 6>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4321,13 +4321,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-0-1-1-thermal {
+		gpuss_0_1_1_thermal: gpuss-0-1-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 12>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4341,13 +4341,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-1-1-thermal {
+		gpuss_1_1_1_thermal: gpuss-1-1-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 13>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4361,13 +4361,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-2-1-1-thermal {
+		gpuss_2_1_1_thermal: gpuss-2-1-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 14>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4381,13 +4381,13 @@ trip-point1 {
 			};
 		};
 
-		gpu-0-1-1-thermal {
+		gpu_0_1_1_thermal: gpu-0-1-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens6 15>;
 
 			trips {
-				trip-point0 {
+				gpu_0_1_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4421,13 +4421,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-0-1-0-thermal {
+		gpuss_0_1_0_thermal: gpuss-0-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 1>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4441,13 +4441,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-1-0-thermal {
+		gpuss_1_1_0_thermal: gpuss-1-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 2>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4461,13 +4461,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-2-1-0-thermal {
+		gpuss_2_1_0_thermal: gpuss-2-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 3>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4481,13 +4481,13 @@ trip-point1 {
 			};
 		};
 
-		gpu-0-1-0-thermal {
+		gpu_0_1_0_thermal: gpu-0-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 4>;
 
 			trips {
-				trip-point0 {
+				gpu_0_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4501,13 +4501,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-2-thermal {
+		gpuss_1_2_thermal: gpuss-1-2-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 5>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_2_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4521,13 +4521,13 @@ trip-point1 {
 			};
 		};
 
-		gpu-1-0-thermal {
+		gpu_1_0_thermal: gpu-1-0-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 6>;
 
 			trips {
-				trip-point0 {
+				gpu_1_0_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4641,13 +4641,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-0-1-thermal {
+		gpuss_0_1_thermal: gpuss-0-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 12>;
 
 			trips {
-				trip-point0 {
+				gpuss_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4661,13 +4661,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-1-0-1-thermal {
+		gpuss_1_0_1_thermal: gpuss-1-0-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 13>;
 
 			trips {
-				trip-point0 {
+				gpuss_1_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4681,13 +4681,13 @@ trip-point1 {
 			};
 		};
 
-		gpuss-2-0-1-thermal {
+		gpuss_2_0_1_thermal: gpuss-2-0-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 14>;
 
 			trips {
-				trip-point0 {
+				gpuss_2_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";
@@ -4701,13 +4701,13 @@ trip-point1 {
 			};
 		};
 
-		gpu-0-0-1-thermal {
+		gpu_0_0_1_thermal: gpu-0-0-1-thermal {
 			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsens7 15>;
 
 			trips {
-				trip-point0 {
+				gpu_0_0_1_alert0: trip-point0 {
 					temperature = <105000>;
 					hysteresis = <10000>;
 					type = "passive";

-- 
2.55.0

