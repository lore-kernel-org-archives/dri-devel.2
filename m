Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3A5D39419
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C1610F1C5;
	Thu,  2 Apr 2026 11:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="amDYh5Vp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DCpXnG9L";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD80A10F1C5
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328S11O353212
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DjwC/vhaUDCLhEP3xKrjmpFxosYiBAU20RYUklLbtgs=; b=amDYh5Vp3V8Lt4bq
 2nvUq32hgCxNtxzLDU86mdAnFQvkijQdNcos4CDGKGJZ32TNwf0CMjFtnHUI8sV3
 MYFsEFbe6S5v8JmEnwuCBtdSvnQ2ZwSnJjdc7mWB9ISSBOprCCSq2+XLsokG3HMs
 D/5OwxGv2VjFK5OTTkPFPVr32z8lnDfmYgERgD08WQj3g+x+miifhjgLuf9Wnst2
 OdqFyDECbxKMmJB1OGRR9JBN2HfvIYaXY8Yk4eApByvTvVS9OJU6eX5+PnT0lFdq
 oTlxvShpBbtCSRRHfkIpnhq8OrhnTq/QO/ndgUqIyCeFwdeCqg1zHbpd10AueQJH
 9p6ADg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9myh8s43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5091782ab06so36053331cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130332; x=1775735132;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DjwC/vhaUDCLhEP3xKrjmpFxosYiBAU20RYUklLbtgs=;
 b=DCpXnG9LWTT/ggU8+yNji6UaL/RukvnwJW4g88PThq9Au8tNYAjVpSpyLF2fStedv/
 MsZiFjfISOylSQxZcOdGk8e332HEBKH87c0nqlmMSkCk+OGsScKf0ZLnKavfA1PJ013o
 WVdQTve0XSe95UuVyEvb/YcLKklcC1LIr8+GgEyaLiaewnGy2HlV49Yd++RcZXc9K3Z8
 LXoDGNI8YuhwNd9qd0SPaiiXOCXMk5dB/kGLUwrIauqqVfhGHLyYcCQwDGT1g+GFQh5Q
 pJfxmNVZsZmokk6c1REbOZGBlU+V0XUp4o6MsU0MsV/6ojGMpds4xJTEKMinfME6/SPj
 sWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130332; x=1775735132;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DjwC/vhaUDCLhEP3xKrjmpFxosYiBAU20RYUklLbtgs=;
 b=dTbdKJIzMtCCeAfkEQDWtyy2Sun+G2rDHVdUq/hTwGupPQLXhnpWSGota/SNaZKc67
 18mw2X/BLM2PgWpypm6DAYwfYYo7husAhgljjydMmTByJEOxJvQUcl06ut7VCThaHLMl
 yn1kGIc5bUmH8JFOGgn/2qDh8jhvB9B+hQHuzId66ptfOSkggnG1e522AVrr8vb83ZVt
 kwZ1DmsLofnW4P3wzTe6mram9Kta7bY/xVCqkZ6z046KsjFCS0dCu32s3bfjH+83K+V0
 PkBz58zR67yeGDqjOjvJwtatiRUrTZdoJvm5PgSSp7z4FlmnK9QpLplXXStppBiK0woq
 FXoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8RxRvDbLahndWPmIPn3O3m3lrKirVIKXVXxbVNMeEbjP8WHtd1iI/c9LyMq5YC+OG8FunpFAAaM0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8rEnGUMAxGtGLAHeJAYY2bX5EFkkRbP2XYzW3U5RGx3Wn/O65
 TpG3sFN1n6lRDyJQMGWqWuWq1JtBJ0/CSvqRm24Me845WsSrXR1NoNOP8rELivbZVQ6BPifFJPl
 6RL7u4TtteJT75OU8SeM4OAhL10EiiDYAphN1GAbRRR7M55p18LRXpr//It+uPIYwNcOCgOw=
X-Gm-Gg: ATEYQzwoYmLMWjqLox1Eo0Q9EuA4Sm9ontec90kkd6L6XzPLCBM0NvleWFEbJbbR/Va
 TEo1tJg/wAJrN1Pmczt5TEhAo3EdGg6jiC3t5xuOhkZktckgcUUXVcTNA+CT7Lo1Pjrwqmm3RlW
 TfwIEH1TL3seailMUKgPZ1Xaa4cpr7PhIOu6zg4LWh78QJiYeOWBv58WxC3rNxSZggHIZrRQMsz
 zo1J4ktSwnHngUt87QdrJFZxZSTQHFwQzG/Skeuox2cHZ6wov7EDsRaoQwIm+Y0cPvTeJ9hhXQi
 hoNv5eeZbJiPVkvc2ZeggaY2yxnj1GorQ18nrYijuu5JdFWDvASyVuQEPYB7FI3boHC4mDpHJL5
 uCObpKWrEyotUwoqCM3aQWss+ZCGcZ0UoM1EOmgpFQ6rB
X-Received: by 2002:a05:622a:2294:b0:50b:3c78:ddef with SMTP id
 d75a77b69052e-50d3bc8d625mr95625931cf.41.1775130332028; 
 Thu, 02 Apr 2026 04:45:32 -0700 (PDT)
X-Received: by 2002:a05:622a:2294:b0:50b:3c78:ddef with SMTP id
 d75a77b69052e-50d3bc8d625mr95625591cf.41.1775130331630; 
 Thu, 02 Apr 2026 04:45:31 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 13:45:14 +0200
Subject: [PATCH 3/7] dt-bindings: display/msm: sm8650: Correct VBIF range
 in example
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-dts-qcom-display-regs-v1-3-daa54ab448a3@oss.qualcomm.com>
References: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
In-Reply-To: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QE38gDZK+HUt7WqeCx4YYalPwAyNS5l9JXKzbJf+I2E=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbOLSQAFWp8Gr8PlfUDlPv2N2JIbBreG4suU
 r1DrEbDCzKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WzgAKCRDBN2bmhouD
 1ybUD/9dwNBOTsmtrmq33APJ8aDMQgbCwksTIvbY6DI6oY7e0sLHWp/u5gov+jxraVUXbTPcuLz
 dzmsG97gUWM+XDuThzHaLByHAq6WzRloR4WMbrxv7R+vHSKDO5fjB2HqqZnKNve3Gao3lhDIIWY
 cjBDh+pWx/gZ7T11rZO90kIvwLsyd/7RyxI4VwyYhZCC5hpsPx+mkg+NgJp5gylhTg/Lofs2tER
 f+AWIe+qm5dcaSovTqisKz2n5Yyc9f1F9+iXbFjL3iPBJBmojQtHEoXDwVNNh4USNuujCq2pl0T
 eHwjTxUwa6Gtl4vtmtgaaIwP8r2kzl2rfF0u32rlPojCR2t7YD8REgjU2gpcoO81xysVtM61FFz
 RURkwsoRIcGz2FknedRWm6WlOEp1qU6NTB/ZROiHbVx8Cg0OuIVBtLZk3EAMLwlQEA/esROeBTo
 raTv/eA2DQhEMufhJ/29qklDgFC1+IYJH6HXrkFCfg0Q5ZNmA5PuEV73IOMrdKS+8QZebJzwh7k
 qV2ZHrNT0Afvx1T3fRZGJO1gUt75thTZcnsbmR9D22aHpBhTlgBhxkLc0LXe2Y9bThfPA54wP0S
 QTDZhwMgUC3W2wgeHUkZjnCuLn+FglrpN1UNIzPIx+eF7/tTzfRXfRpX0pupqdFdHMM5SmaZpV9
 G1Kgj+AsY4syAXw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: W2ezgSoPfp6Ye33b7uL8E9VNjkFS3GKE
X-Proofpoint-ORIG-GUID: W2ezgSoPfp6Ye33b7uL8E9VNjkFS3GKE
X-Authority-Analysis: v=2.4 cv=JII2csKb c=1 sm=1 tr=0 ts=69ce56dd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=HWmKLdpjvklgZKno_vkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXxpoprI30ZI6/
 ZP/ugEp+QOnumB6NXpCAhV2O3+eRI1ueWlkETKnN2cZYgGvee1iR7GXbXGqL4xGImmxUowWH5lk
 pS5tjgUO6SHHWedR8WnS3bVzZacd8DNKyWfocjY/v5jtGYwio4Cge+ziKJ7awIx6mDo2wZtZpLJ
 fAohgUXiQrc24+r0xxQ1t3iKj/9ACyWnfGjvlqz6ToK/4l8tToaDHtRxq7Lq53b6ADsJ/Nr3eOJ
 FW4I+FoOh9AVqRiTeejTxaFkV7n4Z4FY1mDl+TkDMjptwJPZhNT0b1rApBwS3g6gH818s6yaqnD
 wFzTJ0qMWjFbBPUKq70qDa+ZooFHl1ndMpNhnr4r7pTXEnhWYzvb5gxXQDOouRQEn4NxcCJFm22
 dFP+aowrK6xpGqpFqWhyUID1hfYO8vaybOXT6sZmMbaRGvg28V7GmuCZmqpMKg1djP1MhDx+tB6
 TULKVs/S7FZBVz5/Z5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020105
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

VBIF register range is 0x3000 long, so correct the example.  No
practical impact, except when existing code is being re-used in new
contributions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 2 +-
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index dccac525d202..134321b50897 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -70,7 +70,7 @@ examples:
     display-controller@ae01000 {
         compatible = "qcom,sm8650-dpu";
         reg = <0x0ae01000 0x8f000>,
-              <0x0aeb0000 0x2008>;
+              <0x0aeb0000 0x3000>;
         reg-names = "mdp", "vbif";
 
         clocks = <&gcc_axi_clk>,
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
index a1c53e191033..0f7f79527748 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-mdss.yaml
@@ -112,7 +112,7 @@ examples:
         display-controller@ae01000 {
             compatible = "qcom,sm8650-dpu";
             reg = <0x0ae01000 0x8f000>,
-                  <0x0aeb0000 0x2008>;
+                  <0x0aeb0000 0x3000>;
             reg-names = "mdp", "vbif";
 
             clocks = <&gcc_axi_clk>,

-- 
2.51.0

