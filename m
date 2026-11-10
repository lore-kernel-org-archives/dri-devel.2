Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA606BFF8
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lJ3TAB2F;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fCLZHaFZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F70910F681;
	Tue, 10 Nov 2026 12:58:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76F0E10F662
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:00 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAB9u8Q2253416
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=H+mwwfBgfHGTRg9UaddozX
 fFfAVGCo+7WdhMoWki75U=; b=lJ3TAB2FoTFuUj/1kD/GeyLffEzjID6ZEaHA5B
 gaD9NaS4tbNL7wLxiLV6FqeeggxnTy7Kw5QvsNyKv1lcPFe1XRN4vxxbHripYmL0
 A7bO0h73eE/Sqy3C4GgzM0ruU3+bbLeoN9vZxdagX3BC6IEJu9zKOtQ/98Sxg0Z6
 SaM0SVELxxwTE0pAKPDSSYDCRZUgMPtbWtiUrKNSM/YLJbqOIWOlZ5444oEGV2Gg
 UEipX1nEfdH16mXR9BzyAMXq15punf2QZtEFWAasFSzB6rraF24H1HhsG/lrA38u
 YVwc90aPIiDnVgfPSyB6rIDiP8YhwtN2+ww83bOxlCy3y0kQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw48vu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:57:59 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7d2e2cd9c85so1537138137.0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794315479; x=1794920279;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H+mwwfBgfHGTRg9UaddozXfFfAVGCo+7WdhMoWki75U=;
 b=fCLZHaFZZRgqFr76auA/RA5gEGgYTp94wBVheNs80jhdlnOQ9Xe64uvw+KMvY+YV4O
 wgdXxwvQU0UcfjKqbccjeqDnViFHYozlZiqMF1zovOzU2qfHkQiW3nPCz8/zUlE5DwXx
 OUIx0G5mrnJ6P924Sb7saKxMYKn/WhHYz0CW950VrN9Y44NNJ+Sq9rga6joNeszebE04
 AjvXOcBfRFgAnZgLG3UJ3KY9g8U81WtBt9TMv/Qhtd3/aNQNbGx72bdELAbuGI/NDzq3
 iw6ALRMJmc6UtBR1ivjzfuj7d0dsLejhnYoTh12Ydi81qroT6a22DxfYvzqLem/cw8kO
 Cv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315479; x=1794920279;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H+mwwfBgfHGTRg9UaddozXfFfAVGCo+7WdhMoWki75U=;
 b=rUHf3fXgq5mbkU0w6Y7tzsqWJ7utmPRMD/rzsOVO6vJwCbl5o+Brv4pm2F8MIkWbFM
 IIwzZQbDBqtuZ9sGDXYHYu0gTug9v1uBC8coPXZMd8a3V6qS/t2Cpl5t/xllilRn2vG1
 GY7og0HA0beJHOl6IgUuqRPTA/cTyBKocU/94gS4VdqzzmGiSarNSvi193s3l0NpBKai
 milkYMbHVYETKzvn2ZjH10vaSPwbmIUpvau3LFalVE1ZikQ0LdkWQHvyMdk0kHZ0uhLh
 VebjS3XQfMvw08SU/QXCXamDfMNzyOR8EUen39SkXKWl9DUZC7dn016d2Dcf3Gm021Ye
 9Q2A==
X-Forwarded-Encrypted: i=1;
 AL+hErHPyO5sKxxlwiX0C/xmPnyNN/tRqd6uaUklFFijuWQC0BuLBUE0/DzaFgSP4NuxVlmGzrL9owJKpMc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+5waJ2JVLwguWeQzRPmbin8ReKwzLlCRa4L9fZIypzLz8g1d1v
 Yl5tsFqI7hNe/YUoh5hGIiw24Clvv50qm3JmhT1X2uzJDsHwCvenKRL4fYVTF2jjhzjMPOPxRJs
 yN0rczIcprqZVSZ+AW7hUNqao1Yy694/UnEFAnOSjM1N6x8KRFRRAYonuAW1nd69DVH9RPjKYLy
 RYGec=
X-Gm-Gg: AYBFou2Tw3WHrm9MvPe670Zi6FeZJd4xczqulwfmZcd8ywXUo5M13uPgL+Lss0hHJkO
 gylmb6h81Pof3jhnhBTDc4+F4Mpbrj91e+r3Z/YaGiMeSpD//UxMjdMOemM7I8Fbgr0fjShRSIM
 O6DCx+hzWh/t0TiJsiOfYVCe+R9ZogdKSTc321EvLAmraBAOgQV70wfdEdymJBfB+vN1FXhzl3u
 u/SeVCv/83HYOm+v9x0PBU5VQ7w4NEGGFIqV6oWOJqcYdvqFEqpVR3KdhZYQvIh6Lp6yYk4nzK/
 +GiHjPapglUWOK8sqnhPbrFJFbL35pTMHBp14rqLdRfhX667IKCOxUNWVE8vKqRx3nJvz80H/I3
 zrwC+JVGBz2RfpZyr2U4vJoEoYD06/uFdMcd61/DL27u9AcJB9/MgfE+8/RbuK6/rLiV2ww==
X-Received: by 2002:a05:6102:2c8d:b0:7a8:15b9:dd34 with SMTP id
 ada2fe7eead31-7d301ad48abmr861877137.2.1794315478853; 
 Tue, 10 Nov 2026 04:57:58 -0800 (PST)
X-Received: by 2002:a05:6102:2c8d:b0:7a8:15b9:dd34 with SMTP id
 ada2fe7eead31-7d301ad48abmr861866137.2.1794315478372; 
 Tue, 10 Nov 2026 04:57:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fba35csm58422365e9.1.2026.11.10.04.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:57:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/3] arm: qcom: display/msm: Require DSI graph endpoint
Date: Tue, 10 Nov 2026 13:57:41 +0100
Message-Id: <20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQAxA0atI1g1MxIr0KqWLOEZNqTpMVBTx7
 p3W5Vv8f4BJVDF4ZAdEWdV0GhPoloHveewEtUmG3OUlETls1MKHdxxswKnFLnLokV1FfPclFXU
 BKQ1RWt3+2+frsi31W/z8e8F5fgHK9GyLeAAAAA==
X-Change-ID: 20261110-display-msm-of-graph-a081a5c614b4
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=/tEHBo/1L53Cz1wvKQP13TTvfSMPe/VgE4L7czNBqRQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq8xTNYKySglQ0J6E+qNdJThU9Din5uwEj+/k6q
 YSmAOg6wn6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavMUzQAKCRDBN2bmhouD
 16DtEACW7kLeMUKsxhWZScVcuTXcpHcht89n+bbmV6jkN+byb9WiQTXqrUZXRyrbKvUXQeVS21Q
 q/D3M5SPkoGVpO6hFmTPNPCxD/PDAQAVuz1XM+S0dWofbJNUQTAQReOcXrRifj5e+MpJ14MSi1t
 3prdLR4aF5bcvS2bE+M8JQtPT2O0JfO+Hup5OXvropkXYMU3uWqadvvHKPEpCBnt0h2LgyYaV6D
 TQKBhtmjEZn1xc9yoPWEAPvXTOUm1YnXtr2xHhR3GF9tdHUX1juGSCD2LlXSBl3qr4jwlnW8FPp
 C0ORUwPgbmvEAbyV4kYf5MLAGzHA/pMLdPu0aIGuAaNUBtauUFIzeM58bYp8qZLg1wvmEpgRXy7
 1bSkDOAWnS+RfHFO4yOdsWG63Hl/+TER3zaiCMe1s3U54oTM8lGUdFQRZZaD5Dz3jrMw5VBdiPR
 8Or7fD7Ow7MC2ge0fFy1rsbufmQJgByoayi04EP4AYu3mmn96IY6IUIQIzRwcuNaBGPshLvrYA7
 H9cQKQMvdzk/X6j5NvKSaES9TgCdLR62ItvJHmjR0pvXd2axnKJ6DtFDhkKqU4KFMnur8gqyMEv
 Wo1FAHi7CfBEogL163vFaYb1+eG5J2YrXhQVVqeuzliNzN5i5qtxFc2fO+rG5ys2XmOyGg7qeTm
 T7IU0bHdRtlr4lg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX0/aPB7oNtuJ+
 4E9taIZxCUDfvfLvxlEllVPJy2AycFT12X58q2tlO21CFC6uDKVMhTG68zmUruC7Zs0G3xldKqg
 FePh+fUHXmdVfMiAcNkd6HFaKVlHDe+eqe3l330i+cC83Qv9Ll34bPd4NUXb9s/cKG0U3oXf787
 v9zL74snGW8amS8nWBWqZtN0q1+e/5bEuhjK/YbogOlfiQXcn31zUq/tfSxkdEzR08891GIjyEu
 I/IvM1Mt2ZbHamBpXdhIS0fMj8jSenIB/OoH4a+eqNt2oWukGLjomcg6raeH5bWPk9VoF2JqsZC
 qzB2A94OZMzhAJ5y01anSU4vbkLxdEiuVDPUz327TBJcnj0tYy82IMBOziiNByEyfeFUdqQtNTL
 1piRyVZ54UYzq5Wj9Z/GH82WUCcaODOU5i5Ma7t9vrADpBO5y65AxcwSJquYsEcghW/b8v2c5Sg
 NZPZ9pNYjdUqLOXT2rA==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af314d7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=569UQr4CCCqzOnBEreAA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA1MSBTYWx0ZWRfX0CpWV5caeILR
 a1Rp1tLUnzx8sl8qPU9G+ixGyZkp9dnGyDNJbkTu3BxQKwz0FyYUGAqxwFxNVhvP925xgCjPSVv
 9mSOXPluKqO5kXUrEHHvCAnmKyPVTe4=
X-Proofpoint-GUID: EowAiHlzP_aUQIYl18UlbMPtIFSp5sK8
X-Proofpoint-ORIG-GUID: EowAiHlzP_aUQIYl18UlbMPtIFSp5sK8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100051
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qualcomm DSI display drivers won't work without proper endpoint, so be
explicit about this in the bindings, so we can validate the DTS
properly.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      arm64: dts: qcom: msm8916: Disable disconnected DSI
      arm64: dts: qcom: msm8996-oneplus: Disable disconnected DSI
      dt-bindings: display/msm: Require DSI graph endpoint

 .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 6 ++++++
 .../devicetree/bindings/display/msm/qcom,milos-mdss.yaml          | 1 +
 .../devicetree/bindings/display/msm/qcom,msm8998-mdss.yaml        | 2 ++
 .../devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml        | 1 +
 .../devicetree/bindings/display/msm/qcom,qcs8300-mdss.yaml        | 4 +++-
 .../devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml        | 8 ++++++--
 .../devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml       | 2 ++
 .../devicetree/bindings/display/msm/qcom,sc7180-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sc8180x-mdss.yaml        | 2 ++
 .../devicetree/bindings/display/msm/qcom,sdm670-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6150-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8150-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8350-mdss.yaml         | 1 +
 .../devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8550-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml         | 2 ++
 .../devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml         | 1 +
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts              | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts                | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts                 | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts            | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi              | 2 --
 31 files changed, 76 insertions(+), 5 deletions(-)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261110-display-msm-of-graph-a081a5c614b4

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

