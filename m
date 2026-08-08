Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CDCC5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208CA10E080;
	Sat,  8 Aug 2026 20:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTMN9XIB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXIsZNJ3";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FAB10E07D
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:23:53 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678Jw6gg1038367
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TkIUMGU2hl2GkeTmHQvIMOaKv+sTC+mIBj5UNEuGbwo=; b=MTMN9XIBu58E7OxB
 hJZ5p+ZWrKYN15QwdAmdVYkT/hYVE7E2y1+0FCbTK+iGj3xBjyEgChiSQYjsYxra
 YKATdodERT/bcMKlovTu2BX/ks/ni4QKsO9SOKf/BcuNs9dGb5v40NFDTQ/mkyUa
 eE9efPe/2Ons8NrjP+TBV2hjeF8dgU91P3a2SSGqCWXRGNAvgSTUts45LlXY92KE
 n+RUAHd7p4v3sZw385W+Z3X30gJBXxZRgsKCpkOEc9nFIQcq4t5VmO9CzZVRf/Iv
 Fhp8wQrfv2uscDH/5FM19N2+nfZ4dpONn6qUfUcAyFo8jSvhZ/1P61xpatVBSuHf
 UZUKpw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwv1y9qf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:52 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so519737a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220632; x=1786825432;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TkIUMGU2hl2GkeTmHQvIMOaKv+sTC+mIBj5UNEuGbwo=;
 b=UXIsZNJ3JCk367My5ynPAu6u6INlH1kyt6OE7iq5//FdLvXrS16xMIbPxjR+ip4J3J
 s2zzYcpMl7f1MrcCYyswfCsiPyqWS19whGdnlDv1vW8ykiR+x5dMRpFb9KxW5RVzYYXF
 WNRejWZIxtLG4Uax8B4V8hdevn71PtB0fzZjoNvv0kMeq5yzkhEJCGqMMJJ/vKaTd0kf
 EMnN3YtCd5jP+COgjaiRw+H7fzq3usTEUoezbVbqZx/PJTIEmNbjFfgZi4LNkuP/WBo/
 OWbU9FJ/7RbXQIE5/F7n1p0K/qzW1fu52oq+0GQcjnPeo8Pv7WsfiP6JjYZKSUXHxfX1
 915Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220632; x=1786825432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TkIUMGU2hl2GkeTmHQvIMOaKv+sTC+mIBj5UNEuGbwo=;
 b=G2LDL9TQ5Nguw5DoMGZQgIfP1WJawxFrUXINd+1DPsCgeb72qBMiUreUUmH3gbJJpm
 sdAsRBR21ud+u3qbQduKwo8wcSAtzKkCfU0pkNYtXmKePO1EyLEJq8OYrvwb1yC8shIr
 Vp3TpJrKfKP+9zaqWy0dxLs+Na+7VRBh3A6VMXHfTt9fYJpvc+zY51wZi6aI/7eVGLK7
 oAJF30L1UbGeQkQ87N5ZQDGz8tKSU+DWQ1tSKUeTLTJZa0N8VtIbUoQVla3z641Pb39w
 a02geAOMplce7GmDq89WEu3bUkIOrlPnIfe4J5IF7rwAnNzAheKddK5Up+N9WpK7VqtA
 9SEg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpt+deBPe3YZcqT5nmlYpOZqftpj/xw4vXd4lJc3SzpjYfBdihzi6aZSSyDb96gZycHTKYwWfHIM9s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbwMKI0MAY5/SY2IgAoPF6rYmCM4rObDDR1irV2N/Wm95kZJWC
 7AX5DswvDiSSAUFzriUW+CD7Daph7PGODOYp2fHcxHhCg6bAUkxTer9gNOFFLFKdBmeiGIrC03w
 gksaHyiIqFWbGAB5nDa14EwBHIfECCschw0zoagqU9/dQkCwcO4FQmuVPnPBshDxX07WXO50=
X-Gm-Gg: AR+sD137O0jBzSNGDiB0SZktrt8VPVJoKYp3FITK7fQXaFckpLoM8D2h5sKme24V1j1
 Ve53svzOMllIBbkVYsnAkts0apZA4ylI0TICowQ2TmqwWGzpnHERvwd1S0W43C+X2vPxh04pl42
 YA7uUs/MH+fekadIFmk/xWzkFXYQ6iqbzmdBcjTZAs7H+AbLXp9qzP+qLBaR/0rsOKWIw3a85dH
 Q3g8NlQaNOHTSn1xMSRrH34bZybDCKQZmxvtSx86c3bg89TKUoj+7cFbQAxEjKdSZzoScbKt6L1
 hQTra4CXyM0mWa/BJOKcA5xChRpdilQspHsUVrkPxoQjgjDha/ldbxnCgIFCs9Z9uWpAYximbGJ
 jYT9J9+95oO/SEVWT2ETLuO7v
X-Received: by 2002:a05:6a21:6daa:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3cbadc15329mr20294283637.22.1786220631904; 
 Sat, 08 Aug 2026 13:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a21:6daa:b0:3c4:3672:ba6 with SMTP id
 adf61e73a8af0-3cbadc15329mr20294244637.22.1786220631485; 
 Sat, 08 Aug 2026 13:23:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:11 +0530
Subject: [PATCH 4/6] arm64: dts: qcom: sm8750: Add GPU cooling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260809-pakala-gpu-v1-4-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=5104;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ofQkUSc5NcG+CZ9WpupzhlkIDMlUKVF08kmMsHHefpQ=;
 b=FAhfbxRny0gdKk74rvaZBrgOH7vQrV8K6SRdFTO43x9yOxJzV5D9Um5USeg8MueC5B3S8ooHM
 Vd9X4VVxmlkCurIrh++Nb8zwYLZwiTww9UTu6FvgnvpGDhsFjpMX7rV
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: GvDNa-TV6keWhtI8H-lB_ol5ly0D8yKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX0+OyotnKtVvx
 we4+Jp6IigroDM/r9ZZsxq9BjdhWWKs3BgM4haroJ4lprXEteusv1wIjOckVYOOq9nk4vXoP/FL
 tsB3FEOLRY8GMRVc3mCMGcsSIcPcbwufyjaumAuWzI8KUtOZMyt11xN2FDzBdQlxd2V04fjtMwx
 aE+RM0hdLDFJhkntxwpcHlUuDABGNQelPXzJGEdK3PQuFN7NIGEgx6F31ZEfFgsCTmTVODNRhwg
 70HlNofvxlLLWtk8JWmudf6V/6VlfSJQj2DlOkxYZnt1gml6fPPihffb16ToaBgoW2KRIVNxzB9
 wcF+vA5VzNqU59AhueSlQFKLxGt+ZEBIowAWn8uigPpyTio5eDnSYjqcYv4JTzsdEffvss9g7Vr
 eytWSuYp/Vcxn6EbUYVdmIS5jdH8HwS2/a1vq8EhUhiD9ILuvtpGAduWAsHbty3TEcxRwnAuuQ2
 nBKti9pV0R4GKsqhPfg==
X-Authority-Analysis: v=2.4 cv=PbrPQChd c=1 sm=1 tr=0 ts=6a779058 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ZNpuPEAtJ79wbY5eItgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX3SYKQeGEcWon
 7uB4pPbGCUPJAdyKZ0mLwMgiWIjBPnoixNPy7etJt8fnjuRUAhBnDk2wYpLYS0WDKjo4rh044eg
 7g+iZ1EC0ckbdAmJtFYezjXlE3z/CoE=
X-Proofpoint-ORIG-GUID: GvDNa-TV6keWhtI8H-lB_ol5ly0D8yKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

Unlike the CPU, the GPU does not throttle its speed automatically
when it reaches high temperatures.

Set up GPU cooling by throttling the GPU speed
when reaching 105°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 104 +++++++++++++++++++++++++++--------
 1 file changed, 80 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 6ddc8d3fdada..1a960ff855d7 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -6946,10 +6946,10 @@ gpuss0-thermal {
 			thermal-sensors = <&tsens2 1>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss0_alert0: gpuss0-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss0-critical {
@@ -6958,16 +6958,23 @@ gpuss0-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss1-thermal {
 			thermal-sensors = <&tsens2 2>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss1_alert0: gpuss1-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss1-critical {
@@ -6976,16 +6983,23 @@ gpuss1-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss2-thermal {
 			thermal-sensors = <&tsens2 3>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss2_alert0: gpuss2-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss2-critical {
@@ -6994,16 +7008,23 @@ gpuss2-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss3-thermal {
 			thermal-sensors = <&tsens2 4>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss3_alert0: gpuss3-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss3-critical {
@@ -7012,16 +7033,23 @@ gpuss3-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss4-thermal {
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss4_alert0: gpuss4-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss4-critical {
@@ -7030,16 +7058,23 @@ gpuss4-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss5-thermal {
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss5_alert0: gpuss5-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss5-critical {
@@ -7048,16 +7083,23 @@ gpuss5-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss6-thermal {
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss6_alert0: gpuss6-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss6-critical {
@@ -7066,16 +7108,23 @@ gpuss6-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		gpuss7-thermal {
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
-				trip-point0 {
-					temperature = <120000>;
+				gpuss7_alert0: gpuss7-alert0 {
+					temperature = <105000>;
 					hysteresis = <5000>;
-					type = "hot";
+					type = "passive";
 				};
 
 				gpuss7-critical {
@@ -7084,6 +7133,13 @@ gpuss7-critical {
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&gpuss7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		modem0-thermal {

-- 
2.54.0

