Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F34606A330
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E4AOo+dk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JTULctqT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B8BA10E2F2;
	Sat, 14 Nov 2026 17:55:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D49710F061
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AEHpfHU621867
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=; b=E4AOo+dk9HBpmuCZ
 PCk3NfaPzeok0qV1FH4OUSz93vxqG/od7b6ejpk3HWu+wvReYZ6qR/7g/ZkafhE2
 x9jqvRNVN5NF83HdV8X5v/jrkaAVJXXoJqpUeTU0pNS1YSOltNyGvJvxBXtu9h1f
 hx8/PuxCSn9Byh3bRCkhhE8S0vyZrqzQFC9uLco4GpocjgAevLQSiYWd+xCenFWG
 nanQd3KN9t37qIJ2SuSeNZ5ee34+6qH0FuitvHPhfbd20iYxTfOXG021OW65xkdV
 pK1RbOswUGRern29wfkIwABwIvNM34k48sQ7WdnWlhs/DYVOA3gsV/YjUX7Xi6Ci
 wJ20yQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhjqhdhx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 17:54:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-945b0154705so356023985a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794678895; x=1795283695;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=;
 b=JTULctqTKnMks7H1jGOg4OU0Jh6dh0/9PxS+4JXy9fvslkdfij7QlnCVZyyrKuKJBp
 D5I2XdsWJmzYUmjBKqCqf4wSrWBsW33rwinVWMe20Y+Bqn1Xp3LlvMEpGpqN4wwGiT8j
 QT/UAjkCGal7MynFEIApRszXuXg7SVuZzhS18FjnL/K6NI/l9j+88tsHYOeRQ7lQ0C8W
 lCdUByaf8ecwq4427P7PZp57P43BggQUAkQI2HIKrPX56VzW2zLAaz5SGUwsvhJJicFy
 2m7D4Qe/E6FNnVPFTIgwZatdxbqwYroDI0ys+vNAEiIHCxeYQmsENXmaWmdCaafVc42v
 Yx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794678895; x=1795283695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T9jAmjlpPJzKEesHQGiR1/l1Z0EuOSLOuEzosz2QsKs=;
 b=FE2eN70hMeDyFWKIUSvMym/V52jZxmbUdX2OlhODfZstIYMtFG/PqW0yEUqogrD5VD
 zubpeGx2rTbEyHXxDLT/49/Rc1asia57j3ehHRZdM6CTux/JtwYm4mYb49TiOXweWj+t
 2qxrqP9DwH4IQ8mBv05iDn9uoi3GJSTQYra5FC/bvSIOgoUqxRTPX1Kgh1s+81s2dWu9
 iaZoPo+llQjH7dbmlCwjVsHCLcDCuIkU3uP8Emo7R/sRi2mlUO210EOF+6KXN++t+EAm
 4C9KO3ND8Pf5XVd9XoQ7yEUJN83NoX7E9/lnyj6p+Jr5D65evGuAMPJR0AAewHtgf6cG
 XfYA==
X-Forwarded-Encrypted: i=1;
 AL+hErEHZewSjRPNrX4bZ+wKX4s4VaH11kuUtReSuCLmwGRbqcpVJTsBQ0PEyTbiHCHEaVNKXoqFF4WFVqg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9XRkpLZVU0WNjROKmlyu6TTB0EzEqBcoZr+slI9o9Bu4wHZM/k
 Zzb1YQCZMVURMuTKQ4QvnXQKUWBx/Jth0V77pLwqqHmBxi1pYss22z24wdbiCrobnbV9zYoTHG9
 4ImRg9BRM9ETHRi/slO8y+dZNtnGo/gYjds7iBVDWacw+nXzUD2o+twQRw7/goy7Tlghd3Sc=
X-Gm-Gg: AYBFou1iDqk54Ap9TlEb5O+o6IdZzZwRckOJHFDOaSiLM1++zAfTM8snD5Gtqdp2V0U
 Yn4NhbNu8i0eUaXvqjvwHtg2uTQkQ3xY2ZnMaJhUrTVdTGvlzOrMZT6kKlhY3+DtDV6ig9aNI0g
 lVGuxJsrBn8K9LMIzQ9cmXFuVVkZBCEfzWkr4Tpdq9xae4FjgzLy2HdEi3uhLuI+7uBKsP3OLEm
 8PvFJTJW1Gmnxxauao2HR1LLz8uFZ8rvIuf8M6b/nL09DD14n2vpAuBwrZgTQ8dRt8oOrQSQxx4
 WVBT2O6Nn2L9QW+IiZl7k901q91Ph/AKhiiSqYpJCaEIZ8llxON8d1hCWG0kkBK3CGEp4ol2Aag
 3f2fgS1z8IrTOjJmylrfwcgAnpxIJAsipiG7nU6cYFTrrX+qzuUHjYQ4KzQRyXnbsTffO7w==
X-Received: by 2002:a05:620a:4152:b0:949:6e5f:7395 with SMTP id
 af79cd13be357-9496e5f7ecemr179564885a.79.1794678895441; 
 Sat, 14 Nov 2026 09:54:55 -0800 (PST)
X-Received: by 2002:a05:620a:4152:b0:949:6e5f:7395 with SMTP id
 af79cd13be357-9496e5f7ecemr179560385a.79.1794678894960; 
 Sat, 14 Nov 2026 09:54:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c888b90d4sm11060292f8f.9.2026.11.14.09.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 09:54:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 18:54:37 +0100
Subject: [PATCH v4 2/4] arm64: dts: qcom: msm8996-oneplus: Disable
 disconnected DSI
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-display-msm-of-graph-v4-2-b8de044c6c1b@oss.qualcomm.com>
References: <20261114-display-msm-of-graph-v4-0-b8de044c6c1b@oss.qualcomm.com>
In-Reply-To: <20261114-display-msm-of-graph-v4-0-b8de044c6c1b@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GCFRCKJTBF0tDduwhG+AEpuoFlapsyUUwKoJTS/2B/I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq+KBiwypVbiB/+sME4U5cLI8rqkqaraxGTw7XS
 AfLuhR49AOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavigYgAKCRDBN2bmhouD
 1wE2D/0bw3W8hvBUayS9i62tP7e+l38ABke7P4J+I+RrzXqTv4qtL2nDYgDgCdSaGdxPJAGDerh
 w2VaQ9FXPoE4vbgVdEnaKxlQmrWVj5T/8SXLJBHqj8lr0y2eUKseeMXf7lpcIsiF/ZY3HWaK8Aq
 YuzazYF/QkL7BHFWp/LmhrAAI88rJ6tg7WIqu8tgpoV60niC0JZ7/65Crz+ob5wgqGQC+wQg7+L
 ZmINWEkF0uGLGqWN5FcnoZiMDBpeeqFRwojEeYLeJXK4Bou7uQGD9EsK6J/qL0yV5tFgzgofyrQ
 ExiJ6q0yYSIGvHEdrM5ickJejK/QM1s7zdw7FnWwVc3WC6qjiMJDcP+OGCJIZr4IUZM4WpyMMay
 WZh8l8eQXdKtOhdjZPLFX6KolLmnThXTztldaiyrNV3CKI5epagPQ1sErtlsXQcuZZMbw4eJ5/B
 w/3e7y0oSekT/4DTdeGkGd25ZjLwsjKo2t03kREhnXdnUWZ+GJQUHYSQjTJLaf/Tbz+SKOFJkNt
 70JiMBzyK0vi9MOMrtD4ew1od/Nt7ffKgEXNUI6F7nkBjx+IYzPx/HjKEmoCuBcudPQB+xHYc+N
 JKX+XCiAiDct136ylo4tPlwzVu3PW+ALvv//ANwlq4G9Awn5SBSFIya9mzbHgynvCuX44RzB9/Q
 PPyp6kzg0WUSvbw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: mmlVOgVQ8rLv-YdnsdAt0Ih_mtFLn-pn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX0Cp/sb3k8UVA
 G3lEKX+y0yxCxNkPBR4UUVMY5v/V1uw1yvAeeaC2kc4pbIYSkFuJ2/A6JqyqwRBDCqTruVizRGv
 uZtuFnz9sRW24rn+pUllsDgx4jUhRbWN2GgYr9N6nO2FVz4YayY8fcejzFUWLvebIZGb9C2+aHt
 dCPpCTFEt6dCug9UC6GP9OND1r316eppkNsKFoLehCMXDoKWaP/lz1rTNXjxKUD6XWFO/hxo2Jl
 aJkUUGsX+GAgfO6F6OJzSH/rXGS9n8yVpkk0O8JCbnJ79X9nlJOuwTVgTxW76NnIlv7NvpOP9r1
 WRH5SYnSKkFOWdDfFU7+eA8xeHSomy/GsC+ZHIOYAtoB1T19cCSYz+tW6eGw9zmQzRX1aRdMDNp
 eWdj6OLpGyKoktLYsglbj6bl3pAQGFpKxiioWYBk40yY8OXiYACVZ6Q0SbGKQs8cYt+aOW42IpJ
 LAigpbn3d4DmDateGlA==
X-Authority-Analysis: v=2.4 cv=TqJzFzXh c=1 sm=1 tr=0 ts=6af8a070 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=eMlgcxtRJz0w_Lr9rQYA:9 a=4tUkUnfIpJ8A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: mmlVOgVQ8rLv-YdnsdAt0Ih_mtFLn-pn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA3MSBTYWx0ZWRfX1j1KXpYpLygw
 F767aqRhnQE7kqxS/vozdcNaAFww09/rRdyJqm9ZEKp5QNdoiBDiwgimuJakoioiVnjw9Kfy91k
 yps+S+niOB8gch7BlhXlxpVTFHffktw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140071
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

MDSS DSI and DSI PHY are useless, when nothing is attached (no panel
description in DTS), thus should be disabled in DTS: no bridge will be
registered and no component device will be bound.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 7a3f8afae22d..9c2cef11e7a9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -189,7 +189,6 @@ &mdss {
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l2a_1p25>;
 	vcca-supply = <&vreg_l22a_3p0>;
-	status = "okay";
 };
 
 &mdss_dsi0_out {
@@ -198,7 +197,6 @@ &mdss_dsi0_out {
 
 &mdss_dsi0_phy {
 	vcca-supply = <&vreg_l28a_0p925>;
-	status = "okay";
 };
 
 &mmcc {

-- 
2.53.0

