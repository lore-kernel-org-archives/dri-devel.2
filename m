Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D65606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Iq4HKIEG;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QCeXSRoW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E9210FCFE;
	Wed, 11 Nov 2026 17:45:34 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EF910EA96
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:22 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF1Awu2115856
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XEOLUODIyOXWFNay8M/E3b1bVzpi6+JwlNSpxHy2Yv8=; b=Iq4HKIEGTLKBTq31
 +ro3Dgiif/n2EdDc7nciPUjtRtjWa+XBXm9RQzhccFQEDQrW4KIAenq/yUXDPMEs
 Y3z8Xx4S5b1/Mw9QweZKAsUjVvy2tZgpsh3OdXnuE9Mkeyc9uXFVOdHSVBndPul+
 sUd+KQL/8dW0DRnOALV/PUMKHqdp8FOuJtjj8DZJPv/CKI3zMYJZ5JlIGUgvDV8A
 roT8i5T6zLhg+aCKXJHpvj06UbWZGlSgmVu+DanHME/9B0QB7ilt62eG58LXctGH
 rbzHiOB2ETTONeP7bWZNSiNxZQeZ1cl/XHLrnhSjFh/xVVXBgJUQjJ3/3w7/Kf8B
 y/XkZw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvfawkbj3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:21 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so2541653241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794419121; x=1795023921;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XEOLUODIyOXWFNay8M/E3b1bVzpi6+JwlNSpxHy2Yv8=;
 b=QCeXSRoWHLqOLbsxBZvLkLm20lT6HEL8UdVgghXwsian3YxRUli8M7pN7zdcGJqXvm
 qntJILYWhBKM9OrYWaWjIz62qv1tlNuFbfm+90dSOa3JMcKyvMhaf/7TFwRQUCc2per6
 QIbmr/bckfnRTcmMmWmw7AIFfLRL4c5Fv+eW2AKcFFKC1O6Kj9oDUDHmhzsyI6dAuKAd
 UHkkN3EgwNplmXKcThleQ8iwUM/MnQB7AKRIxgmv08WRI5SwmqaofrvY98T9ufqXRtuJ
 lEnkl8+Zt3ygYV0FseZRll96oahnK5d99MHPOoWHgLp8MNq6kC1lIBZp//ZN23wTCdZ5
 64sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419121; x=1795023921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XEOLUODIyOXWFNay8M/E3b1bVzpi6+JwlNSpxHy2Yv8=;
 b=tlC3wzZPsLOT8x1KBVWIaRFWxUHXWnw/0ejwxDzNSfhc3IwGbSzj96xl6RUexchKMR
 A/MaDB/o8nMzoy9qxYEe6A0Vd5XME75VePaSX+gRz5mbucscPp7tmO44IWe4ZbUiV4Gl
 MLUIvt/xGvp5ZXwUxGP5ehV2edsmur+RZESEXISaFmbRsDo/MMvFOGki8+MuM3hqBPi0
 eELs0QGPbrnCdVCTOSpdyyPtfJLdQusScMMvHeg4hwHwo10rKqPzcfUdUo5oZH7mUsjE
 +kBA/AmwqweECmWXvoFG+aGDPSy2LgVQng+zxO4GQKGeyzYKL1tzscPce/dx8IqupCO0
 +Dfw==
X-Forwarded-Encrypted: i=1;
 AL+hErE1JzDUXMW43ZdNQ//1RjwXI67wISP+79xHaD22t0XD81C8mYaqFKOHvq1wu69tQ0KFE7qLrbR10Sw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iilu4r+C8RLakAy0wOtkhfbFbr9x5T39fzXq/Qb/tajvWPfqN
 8Qwu19eOauvYp9pTfkYd+4L8po+80dgYJZKg75fY2Q4JA/Tpo9tSOPi60MVVyLAvfmfTzSEcFNm
 IRt+qfqA7GKYsH+DsVqUBDe+CEgY78WtSqCEg2yQsSZz+7yq/u9gJsc5MuY6VDxIM/dajdyQ=
X-Gm-Gg: AYBFou014habxefOJ6C/u2lyjVOabYQUnfOS7ZhB+wdjAVAgvS8Zf/5Y0n7xYRJTJae
 D5L0w+kB61Yw906KvDRE5WH2pDhvYmpwXuGjiIt9ywqXfl4hutKQFKTvAArGWBPFG948Jl8C0Eq
 ndqo97qe5CGQyJ9wsMy2Ixay8njDMMA5xPMX0W4PCF+mj1EEXpIhW6ENFGlCkOQH4ofptR9AVC6
 bE3mSwWtDsryOGSek1jfH2PmfSinoyZp/eXN/0Z8VqR6Sb8kT3fthVPlLrWUm3m+VWbiF8K0ndG
 WAJEzRPEX5MiJXbwjZskmHDXR+72GwP7W0lpobLuUffvebo6JNUYV+/+PMUpJpPZcj8Ihe6Etpu
 jeT8yA31P/GMyOjWPCsdy+JLNS8G4fho4PRaXT8C51+ysmk+YQF0YPJPKo5Ntw/DKRHCyGw==
X-Received: by 2002:a67:e713:0:b0:7d2:d9f8:21cf with SMTP id
 ada2fe7eead31-7d5061e6d25mr1449259137.29.1794419120685; 
 Wed, 11 Nov 2026 09:45:20 -0800 (PST)
X-Received: by 2002:a67:e713:0:b0:7d2:d9f8:21cf with SMTP id
 ada2fe7eead31-7d5061e6d25mr1449229137.29.1794419120074; 
 Wed, 11 Nov 2026 09:45:20 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e1f5810sm4846525e9.0.2026.11.11.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:45:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 18:45:00 +0100
Subject: [PATCH v2 1/3] arm64: dts: qcom: msm8916: Disable disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-display-msm-of-graph-v2-1-fdf8fd97f49d@oss.qualcomm.com>
References: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
In-Reply-To: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Mahadevan <quic_mahap@quicinc.com>,
 Richard Acayan <mailingradian@gmail.com>,
 Danila Tikhonov <danila@mainlining.org>, Robert Foss <rfoss@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=P4VVgVXWltSSj7aZCWsKHMz6d5FfrRARZf5CW9AC908=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9KmluyyDPrdXA09BqwooVEM09xhRcORFlWDiN
 3+4aN13qeqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavSppQAKCRDBN2bmhouD
 13h0D/9g/KlHv0ldGfuSMu/+ECd2SkWmVhZAMeZfVM4hBVW6e7Iwy0tBAgQ+FdFAeQlv4071Jvv
 2iqe52zPWcrUqQIetrSkmpIDA2HUUyzQe5dFU1vpMg0y9qs5HSJdo9inyv+3flAJhBGGNge/yOf
 itGlewsYMoEB9hr5Pp9aXVb6Twe82u8DQMmtPXBbH+lXfH8ab0ckKLjEdqxVQZk4Jymq/MjZ0L2
 8yWYJhMjeKoGDR4duEJg5pmELVm73zpRB7S3Lo0Nz7qUm7PwS1jpk2tTUEhOY6KnwlTFMNbchs/
 gDGzD4jeQCXvGdpfGV3phA+ml1BqRXzILN6O6rNlCiwOOFhh39FxqqwNfLEI+UOwNbO1vGjY7jS
 wfk2awkbxPxMFXrRPyhohgrgyUCgDlFQ0KGQROwWLL42k6bcEmYnIKCIatcj+Yp8SYwkBzE5Wjo
 nZMJ7/Ny2YUs0Kym1Yk45kPvYFnTipAtJsOVv3shJDvNL0IaH5wk2TMjuMSxu/jR4YO69wnocFb
 CWcqX+FfzI0wNl0POdC5K0QpJdsGNjAohgHKxfywBXsgVu1D2Xqzm8ylkxlNAR2+b2kzDet1lfW
 0dSBmkAn5zRa2uXqLT+lowIrbV53Zr3Vu+SJUy/BxPDQ0LKMT8iEeCYRAIbHtstsh2qY4LcyWGg
 w8SnJdsba8/edug==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX/uUq5/eVmCJx
 TN9WymMRBGwrnQ5Sf5+whKX7hibz9mkYgIlCdfLy7UXR9+QWlKpTUhpneippf4aKnfWIkfOK/tg
 DH9aNzePMdl5m0iDtrA4IRgIiVrZz4c=
X-Proofpoint-ORIG-GUID: KG2ARB64CjP1eMaTjQ88JBDPhC7a6uZb
X-Proofpoint-GUID: KG2ARB64CjP1eMaTjQ88JBDPhC7a6uZb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX2sX/eHFe50B+
 E+3AtQcMrft/ux+S8LE2k7RRev1clczWlSdzzQ5+D3v8L9agSMyG63/i1Io6tb06dJeBYDmgu4/
 Ucj3cPho4fWG6couOiWTurljBwuYAs7escJGIp7iH1suHdqJ4WI0XtJDg0w3tNpiAzO4S7O0rV/
 NJiOChe1lAiPYN/UywlFTeaqYBKinxD7vhoShexRKy9ifBjGOYEGc7XB+ZwDT6Xs04qpWBBTCtx
 8rQb2FzgTPpgQEEiAREfPe/RmLUWV33T2jb6H28eF/z7FcNh/vjJyz27DlknKGHUPf/g0iiR94I
 UCyJ3Vt6fT5hgu8ynxAdBUaoep1vZ8yYIfToCs8R6nhV5eQNbzu2FD8zKfiFSDecUgfZwnFMav8
 mM0AgYDgbrrZn+hKnXr9I8KKB2vX1a4gCLOIRscZpegRUzEGujbd9oo84cjR0cf7DImGZQLdAP5
 6MFo3fg1Us4AedPWgaA==
X-Authority-Analysis: v=2.4 cv=CZadd7rl c=1 sm=1 tr=0 ts=6af4a9b1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=b5eSGgufP5Rg0J_mn4MA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110070
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

MDSS DSI and DSI PHY is useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS.  Linux MSM DRM
drivers will also fail the probe.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts               | 4 ++++
 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts  | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts   | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts     | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts      | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                  | 4 ++++
 7 files changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ba6ccf0db16a..6c94489f5f70 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -262,6 +262,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&adv7533_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
index ce75046ffdac..370ad8b01a1a 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
@@ -218,6 +218,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&adv7533_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm8916_codec {
 	qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
 	qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index 906d31f1ea21..d3adbc7406b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -87,6 +87,8 @@ &clk_pwm {
 };
 
 &mdss_dsi0 {
+	status = "okay";
+
 	panel@0 {
 		reg = <0>;
 
@@ -109,6 +111,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &touchkey {
 	vcc-supply = <&reg_touch_key>;
 	vdd-supply = <&reg_key_led>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index 5b34529b816c..fe333ed489b5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -133,6 +133,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,ltl101at01", "samsung,s6d7aa0";
 		reg = <0>;
@@ -154,6 +156,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-gt510";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
index 3d6d9dd3b8a8..85d1cae19a66 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts
@@ -98,6 +98,8 @@ &mdss_dsi0 {
 	pinctrl-1 = <&mdss_sleep>;
 	pinctrl-names = "default", "sleep";
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,lsl080al03", "samsung,s6d7aa0";
 		reg = <0>;
@@ -119,6 +121,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &sound {
 	model = "samsung-a2015";
 	pinctrl-0 = <&cdc_pdm_default &sec_mi2s_default &secondary_mic_default>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 71b5c98458ff..65de798201eb 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -337,6 +337,8 @@ &mdss_dsi0 {
 	pinctrl-0 = <&mdss_default>;
 	pinctrl-1 = <&mdss_sleep>;
 
+	status = "okay";
+
 	panel@0 {
 		compatible = "samsung,s6e88a0-ams427ap24";
 		reg = <0>;
@@ -359,6 +361,10 @@ &mdss_dsi0_out {
 	remote-endpoint = <&panel_in>;
 };
 
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &mpss_mem {
 	reg = <0x0 0x86800000 0x0 0x5a00000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e39743e22043..7d351cd15f90 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1634,6 +1634,8 @@ mdss_dsi0: dsi@1a98000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				status = "disabled";
+
 				ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -1668,6 +1670,8 @@ mdss_dsi0_phy: phy@1a98300 {
 				clocks = <&gcc GCC_MDSS_AHB_CLK>,
 					 <&xo_board>;
 				clock-names = "iface", "ref";
+
+				status = "disabled";
 			};
 		};
 

-- 
2.53.0

