Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EFAC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2196F10EACB;
	Mon,  6 Jul 2026 21:05:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nfe2e3kB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UIRYGtNy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8CC10EAD2
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KDqPf1628729
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=Nfe2e3kBjn1flEcj
 9fCTeI8Psnisy1AXPGc3a2t5QPCx3o/OX4aze3IGnGTLw/W7oHQbVFny8/lWiokG
 jBNGIGUimQ98xkXAiv2AOmVBNnqF7X780OUA3zcJwXQ5Y/2mUEBO3H0Uvg6SHVeG
 zpS7ooPd5lUJ35xhwjS2anhkpvmI8Ng4uGuFKiaDIWGk2luoKo7N+hVyo/2hzOtY
 k1ewLJsHXcu7FzvLbheLXOeJXBH0Q/W5sC5MA7E6FP/hJ9/57cJVE/U+UD0erleF
 zjUhO2/MQuszqOdM262shEHp3EBhx/GorCp/N/+NNfgiBvnPUq2+R2V4U4T1nQxj
 Jj8LEg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw18nd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c98136ceff4so5969628a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371929; x=1783976729;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=UIRYGtNyoX+99Edao5iPd9Mjal8W+2395mtlquYZWXPfvoDIm83no1Vl7wJjVHNPaU
 IVsHUORQLnGg7k+4Eyr5ZLbR31kI7MyAI9BeLPz6XzQT3SS/P4z0uklsMUU7wLknsQgF
 eTTCgXRaurFpGNseD/97+oHIgeYmfLJgWNVi6pa9FTf3gkbnnYCWnSYax2J3YBoGmr9C
 WmbidkG+J5m3UD8QqhIyBoOlu0taek4dyrFDBXokiV8WDzT6l0vdYKZPym+FFnmA1eEq
 pzNaleWAbctYPjqBJTlwQ8WscUIlTw0rvkRPtKOP3Y6Yis40O33O8ESKbKebaF5fl+yb
 kehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371929; x=1783976729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=N5GzIASSwFuk1serKEvokJ4emNjBWkmSMpWnBQSsyWVtZGSM/cKcvHlVzbGkZFiCk/
 k7qfO5V+DZN3ETadfbIeyZpARE5ZJW/RnF7wuIMgPUDFI7gUU+VPvSgMd/ICQMZhN44Q
 8LIMJJ60NGzzrr/p2ufYMzH/3B0TNyMbMsUgDLPEIU/mpGqSOdcXtKd3WONB64M+mBbL
 vO0k+JQaYQ+FWT+y6pgl2G9ErrQvFwri6AfC+Zps1ADpPF0BIX5I4YC7k4N+/V1EtI/V
 CK+3b6vhwaCA3AiFHGm/2/4et+ZTR9wOKH1wnQbU6h+oC7LVbs7poNT+HQS8ByNxRMyU
 /OzA==
X-Forwarded-Encrypted: i=1;
 AHgh+RppKDENwecD1b/CT9gJ6qBGG2fdEm9f4wK/GpzI6wnqHj7abAd48hLQPJkHCfFM+YaGyYF57KP+lQo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp/UfOxwddj4JpPq44DzII1ifFhZ3AuugoWH5KBnowMr0tl+Y0
 /bkqeb1pu060W8Hk7uGg96koxagYRsYeUqZiHp097UspM5WnbjZ43Gll4jSYPWMDOqOy68J101y
 MrqL/Vd/kEgXUKykIw2m/wPMeRqzgBAi0kcrddsTfQag7MMpOsmPEqByha4M7YOXwNt2PJs8=
X-Gm-Gg: AfdE7cnlbi5mDPIiwjmhIZsLUO8Dty/pIDzX/hnuNkDH4UQ/7QJwPGSz3DyeHfqVmHk
 EAZO9/A6hyWoz2PDlGpEmQNkF0IfbNsSlrPWviaNx0pqCGVDOko6hp2y8EtGgwetKPnz9lNrp40
 aub03n2PhinH8y2LQNzEuc5MWt87Oo0uX2rGWT3MPvr6efiWwOAmwbAdErvmd52OQpLh/TOpaYR
 xMsFI4jzpK4W9EbYFRxY3+FIdwRBE4nXBFBT6/AyeuEje5vP7AYh4bUk/DLJTrqN4wQwNf46wkW
 Etgb0oHvHXBYalW3x/pTjM13WcoD0df8aUQttPdCFjPUYcUnJY5uXVoNjeNyOHIxJyNKrNxKVPI
 HXTQgdi8x1GxlTTmiS0pR0uTGPHHt/AcVw/U=
X-Received: by 2002:a05:6a20:914d:b0:3bf:6c08:284d with SMTP id
 adf61e73a8af0-3c08ef83fabmr2831630637.60.1783371927243; 
 Mon, 06 Jul 2026 14:05:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:914d:b0:3bf:6c08:284d with SMTP id
 adf61e73a8af0-3c08ef83fabmr2831599637.60.1783371926807; 
 Mon, 06 Jul 2026 14:05:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:26 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:35 +0530
Subject: [PATCH v5 3/7] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-3-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=ql7/qNujURK5g0Rtx0oRe5F0EU5W6LTR4C3UxuwOB5V3LYSyWrfhLBHWlDx7ojbZZsimC6+l+
 g7ggaP35tf3BZydN57xyWo8ihHxk0MOvYi4WuQM9x3G919M+PkRSAFe
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX1POsy39gI05k
 9znzkDOPO0/wZ4yF+mhFCIG7nx1ghR6g+Kq8Tdw3sjf8ZphSQTQjPXkXvc1k0u6QIvN4nZKJjgf
 b5ljQe4etkSdi6F4cjj6pyja97wINc0=
X-Proofpoint-ORIG-GUID: vt_ZdKjG1PYLyncZUVgp1rugyqhK3I8U
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c1899 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX1RVkuSq/UJv5
 TVMQIYp4pV2EjTYAzS8aWP9/u8Hdv7Ms1rC//2UQzoZNQbqlElr/xC4k4Qp6kpbmcR/s6e62G3u
 G7udsATwcAdlgEWccLNsv/swFKhNXATlCA8yFYdJS/BQqfO4iZlIOaY8xE3TSyLzurAZjeFt6AQ
 37ysK01CatUo1D+PDjkK95dJVHEIUnINiOvVHixKucomlULEyfeAkX32XC5zS6Mo4zheG31xFsg
 zmd1v3hSd4wXQIaacVjCLjoVJ65+XbY2ZHS/71uB/43LVKxJTw4TcPS/kXc+Fp/o+C5VRyNWjE/
 O04RuBq47N6ifd7OAzMPV450DdRaIGrSJ1JBmFXIoL9KoqtpGfqI7t1rOlYaLlbRReumnYA+ciT
 obDEvpypJqcWP+66gc7qufcIdwMPOcPhID0AssC8QIuoco6RCJCixJwZcO2GaL+S6oGdbHm6hDX
 W84GCUIwnmwG8xK3gUw==
X-Proofpoint-GUID: vt_ZdKjG1PYLyncZUVgp1rugyqhK3I8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add specific compatible strings to document the GPU SMMU present
in the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..ad15fda5c25e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -108,6 +108,7 @@ properties:
               - qcom,sc7280-smmu-500
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
+              - qcom,shikra-smmu-500
               - qcom,sm6115-smmu-500
               - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
@@ -543,6 +544,7 @@ allOf:
             - enum:
                 - qcom,milos-smmu-500
                 - qcom,sar2130p-smmu-500
+                - qcom,shikra-smmu-500
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
                 - qcom,x1e80100-smmu-500

-- 
2.54.0

