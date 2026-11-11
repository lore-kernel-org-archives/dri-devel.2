Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64415606A8A2
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AGBbzFaX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=G2C1VLIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F1210EAAF;
	Wed, 11 Nov 2026 17:45:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1566010EA9B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:17 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABF0EZJ3289585
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Ncvx1kc+KnyirfS/u1X4r0
 v1xWirGVewXCeeeqzrG2M=; b=AGBbzFaXTQcH7ATZsrVb3OY+ZD9YVm2yYJLVBc
 iwC5BvJZr4bFELQW3pC8bAfQLxCOXKEypHgsBC25ZFPd7ZD2qpg7NoZ/vuEr1tec
 oMf94m1BtIquBTxMnNPB0S0F6Din9TofUW4g4mGp/yF5GsDfdYbkCHKU2C4n1qe+
 CJtF4URKI+DbvyZTLt2uNIFhgQ5zK63MxcLgrhRNfTkRNPAHVKkqMsb6HDa/Gqtz
 th09VJSHBS2UGNde+lQE0DBoQf2sT+10q9Idp6Ike7v4AnY2Wd6m8tAQiiFzmYbf
 uC46NskzqkjTLFN6zQazwD9LJDcNzUTqtGedKc/GvO+iXOTg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvt150xw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 17:45:16 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9987bffdecdso2530187241.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 09:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794419115; x=1795023915;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ncvx1kc+KnyirfS/u1X4r0v1xWirGVewXCeeeqzrG2M=;
 b=G2C1VLIJHIwltsgj2rbsgs36uLaZzcDa3oLjBNPAhXqB8Gguv90M0RVvOUdFMZfVZV
 U9aeMOOTOPfHgIOK5WuZwiVz1iasAq4av9dR/sKP40szB+hy0WTug/oIgkFfDHYb9+iD
 NzqAyq6FcbClkNxneE2EME7Gr87SOBgwvdah/Q2Y2/GbzcdgSpd7DUhnVTBZz77Krcon
 4pu1TVgZ65Q5aEQuOIO0esZmU8zyFoHvK9XegtMQJxWSeDUPxhdKK+E3YTsM1Mscqrm4
 YK7w8Mn5aNmPP05GD1sQLrYCzP8XM0lzQxSBhQD8dBzy/FcaX5EyVFyt4uOy6+08y+1A
 r/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794419115; x=1795023915;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ncvx1kc+KnyirfS/u1X4r0v1xWirGVewXCeeeqzrG2M=;
 b=g0ta3llIGbzzr4y2aemZ0+5ohS/DwTe4wrdLcISZpfk1rAzJFwYQw8v5zBilk7y7Vd
 Dq3RyJLq5Dpnmdx936VuRsvVGfviN5EI3o29lgQ+7+27SC87/Jm1+fuM/sw3rynwH4FL
 be+DBK4fdGD8bIntreA0vszNsA2Qv/QX1CfMeuchBMBWlAFReI9eX9SwquYXhBO3/Ojr
 veBF1KhxjpFSIkxuUtNJ51tfsxZOFDBLJnBXTPkwv6T4egWjRxexPwIXevdEapbuwdFB
 SZTwBnLsRNCEEJNzd7nsv/ObZHPMtJd0nbcV2bP4YSOwsHA32Css3756vr/nWtiJ70Wt
 Bh3w==
X-Forwarded-Encrypted: i=1;
 AL+hErEL9HIcS4GiPScqwHrlVsZ+dAmqt5+5b9FGmwNo6SpJ6ttbLVKArQlPjK9Sa4cA8pKwTO1cjMTMAC0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9AJPu8ltNkeQF0huj6ReLYWMnD36Sb2xWRuB2bh1d8s+Ig+g7e
 Htpog0QoSnwZ1P2RYc6+yaNaZsLWC1PnAeLwDHItwQ/jMEBJiV/08MXltOnHEOIQTp0HAiyNbqa
 BoKFFOyFTf/qH9f03JE8LyHLTBL7ygiR1mAND5E45lWYuUb/oWtrlmnHDy0rV1Q1ySdwxJ6k=
X-Gm-Gg: AYBFou0SHN0ZRnArIUAyuK7atEdEfSGqr3VUbe2uoGxSZ/tVaMbAHoUXszwNRvAJc2f
 pg0uGEq3f/gPj48SAb1aHYBDvP5B5b2qu61veUY+pdltqPdtlsYMl5hYRHTmDm6ZkVAlaf7erbX
 tyW7dLg51r7eSBS1R55kx83TPO5l1J4USlzwqSeT06bNDmMvTR2sljj19dL0+nLPPwVkRmUpQN4
 trsVV5/uobM1oCe2UuTnK7YYN167nqNHqCK5E2XLIo35Sr6QhI8AZjMt6Vv8TFCeGVNVu8Up6y5
 KzszTuJRvjn6A3zMrX5D7frQvFg2CBK/rYFfMspCoB3fustJyCR2CAvhTWaKYSsreMoKDaU0RA0
 p0Q79ugp0/nkl+9sQiPC65FMYYaKLxNb9OnVZJwrN4FnKun9GAQSxqHjfMrrqCdu+CDhJMA==
X-Received: by 2002:a67:e713:0:b0:7d2:d9f8:21cf with SMTP id
 ada2fe7eead31-7d5061e6d25mr1449137137.29.1794419115351; 
 Wed, 11 Nov 2026 09:45:15 -0800 (PST)
X-Received: by 2002:a67:e713:0:b0:7d2:d9f8:21cf with SMTP id
 ada2fe7eead31-7d5061e6d25mr1449109137.29.1794419114825; 
 Wed, 11 Nov 2026 09:45:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.7]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e1f5810sm4846525e9.0.2026.11.11.09.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 09:45:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] arm: qcom: display/msm: Require DSI graph endpoint
Date: Wed, 11 Nov 2026 18:44:59 +0100
Message-Id: <20261111-display-msm-of-graph-v2-0-fdf8fd97f49d@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0K6dkgHEYkr72FYlNLCGGqxA0RCu
 LsFD+DmJy/5/79VsAlkWNySVQQzE5N/RchOidCderUGqIksMpkViCihIR56tYBjB95CG9TQgZI
 lqosuMK9zEadDMJY+x+2j+jFP9dPocf/aGx3x6MNyeGfce38UM4IEac8oC1vitc7vnjl9T6rX3
 rk0hqi2bfsCp0dtlNEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=aXbJomZ5DO59KV9VjzL/jOUnmaWmH1KHQxCz5sW5hBM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq9KmeCDRuPXZQNp+DC6xqfi4nA8Ma4N62VXzkl
 jjJ5Jk2HzCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCavSpngAKCRDBN2bmhouD
 16MfD/0QnpTOf/4Fs23G1SKNkJwzDl5wtvoaxXE4BgjPpbHV0gdtL4k6fDz4pRBab3wXhWVODvX
 Z9VbUU0uryAhuP8rNvQlqNvjOIZ/dT4SVMwtZIfcpuNx4BXUiofqF66iJxX+6xYg2xhps19+A4w
 UkTQEqdk1AgcBQlI64KmzXer8FwdsAfRRQh9nCOXRnh4XE3yJHQaWRiEjkFdg13e0qbdhCaz15F
 A5ad0m7az1E5BYfnwHfcK7KVrt9c1KhuF2gzBPftvtavXb8GkzSTXdKADYTz38juILTuRhx5PJO
 JdLj91aH+ru1irqQHIIqKht1/4gp3xFc7upB5Zs+8iUJep+WGcuTbX+dyraDunKRHEjRILHyf7m
 AkAY+wt8bi4JH/1Rno9sgmW/n7czN56Cy5TnH1vrhmEjDIJYWuiu0KhtcYH/BxAmzvs87tvcCCm
 NiQffrtaQj4PtObnUOdOhM2Jq9GblRc+wC50z87yt/3e/3+3zjbprCl9OsyJ56rCrUV1IfZrRLt
 Ipf9bkzY96aH/U/zXztUSiVXKEtUonhZSBxlF55tBy1H013O68fv6mfAcJxxNT+kFwJBaF7EIEe
 prZqPFXlE3/m24KoU5dzvM010/H5xqhPj2JLvR+G7AujovIYjLSrRoQDh0NtzMsUoqg8WlocRaD
 nMr1jYBBML53SPA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX9ePQRzaM8jZj
 n9eOF/hbU4KwC+r6NB5cRKM4WFVm6ACwbwTumwjQNIeCM25aeIA7g7nDZ/CbPn3TFf+fEiiyWYb
 wW/pfiExH1BLlvZ7ovLyioIPyHsAZlk=
X-Authority-Analysis: v=2.4 cv=Yrya1IYX c=1 sm=1 tr=0 ts=6af4a9ac cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_iFXmH2w7s5zJ4zlvgEA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 4wlMCwOsi8soeLqsgcZaAMhunRvdgRfR
X-Proofpoint-ORIG-GUID: 4wlMCwOsi8soeLqsgcZaAMhunRvdgRfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA3MCBTYWx0ZWRfX8XSOaotH9Mjz
 xFZDp7Qm/kSYDej5vBzvD3HJmTrhb+psow4zn9Q5AE5dTx5xGqj7R/S9Y+Py6xq4H850YeKBs/l
 z9DzlIbgoXyeiRUZdT1uuGRZTEPbdMl/qmxcxw5Y+Z3QeagMkQfNPUfIqEd3qVL0Oqu0q4jx3vk
 ptecaWxWpdiMlMWN0F5am4YZu/Ht5lUMtS5/xGOk3tMd66awfKJmSXra3awX+nWwB1zfXbS8M/N
 8SbtjbbPaDMs9P8H5o2qi5/AEPnWYrJ36kT9j1XeIyhBovq0TthTyDF1FMlyYi1MOUJ8ec2Ehms
 wgcdk+4Fw1ld3bHjFN0AKeSEllhg3rZk/ogWZykn1SY3yaFGRVanPLjycC+Vox4SBU+Zp+Mn94l
 12rSL7bDnCWnmdCh8gYKrxS4eFZ57xciEbeZvs7HPpO+n9T/aGtzxp24LRm20qaHOQoNNbkw80n
 BOXrfLNqGtMNn1w9Dnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_04,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DTS can be applied as is. Then the bindings can go independently.

Changes in v2:
- Patch #1: Update also apq8016
- Link to v1: https://patch.msgid.link/20261110-display-msm-of-graph-v1-0-0f3106f817b4@oss.qualcomm.com

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
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                          | 4 ++++
 arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts              | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts                | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts                 | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts            | 6 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                             | 4 ++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi              | 2 --
 33 files changed, 84 insertions(+), 5 deletions(-)
---
base-commit: e4924298116a18e6fb5b86e8a3b7bcd3b4ea0f46
change-id: 20261110-display-msm-of-graph-a081a5c614b4

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

