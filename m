Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02480CD98DA
	for <dri-devel@archiver.kernel.org>; Sun, 14 Jun 2026 21:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60E4110E136;
	Sun, 14 Jun 2026 21:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsLNiNId";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TNt6vJ3T";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2662210E136
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ELF0fS2556823
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=; b=FsLNiNIdFmZndie2
 tRt5ydKZzUxW/6mifNC4GmEyHdSfZP2CobxkJ+rfx12JrWu8TqPsWEqV6hLQfCzC
 5D84ckxeYSFcD6dJkM/mqv2AzG/hq+FgDJE9/SKyye0hceGdue4YM16lhngWdiXV
 J1rLaeNsLicGxKuzqPvFwYBzODqXhCSFA3hAmAZ90Och1F2ojiBtY8RYhF/Lnp5s
 HhAMSz4BM51OEeD552zbcTie5lu2I72Ki+P2Q8jN+U9xJUdI1G6XPy6eN3kPMJLu
 7zfwOdClIIFat+7IBwXfURaKD+LiOh27fFVZbro9dEXlOFybvshEz8CEPxP/bKJI
 rgmn8Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery954j05-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 21:33:34 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36b9106b0fbso2462217a91.0
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781472814; x=1782077614;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=;
 b=TNt6vJ3TpwGZzBK7/8SCdKYYN1YK+EcpOClMNk6lSMTSxtxy3Fcnv3GR1oAE/IsyPA
 S3xlRNuIm+ukxFg7YgeIpEsX8NmC6/3zxlY2JL8k5K+NLzWluYaID473aeE/Ovp+hFhr
 xREaXwEyzAOa09tTBTTZbApaU+3zeesldLGBAw+rLlR75fZ6C9MO5nZR2WdgmmlW9BJS
 ps1I8mlqRdyahhclmiF4LW+Gs0lUEvpsV5zGps6wPrj+6IwSjF7yS8xeJe9Asvw1xStq
 2DrUD7P4MgUxvYG9DYaY//6tHBz/Rj3+qREZD+DLF/ThAtaXGfX0jENPFxc7DmFXkNNZ
 PzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781472814; x=1782077614;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qtZnYSknyC6VJ7wYBpo4K4Mxwk7AfbIC2xEn+pH4i4U=;
 b=QQ8IGyVcnV1x4LayMVCDQVvqQ/D0a/YiYzx9G3I9sMLZ//MlpeK1GWiiusiVHRr4Mv
 fy+HP7M3w/AJ74WnkPfCadIoMCYcRUgata5swLyLHkWyH7XwCEELVQ4Lg7ngU86xL5/T
 9LHKmjVuOveJpGaP/z7LyGtnWbT/h3se0qhf2XoJJiKkL7hsVBxIBLESP+pqZzOQ2w9W
 TVVe/JLSt0pIAGKDXAjbTbO1PLQuP+e+viG65Sc4bX0+VBr0PEEWzcvrZp3WLRMJWE5d
 ZQcEcBNMYoLRz2XMB45e48H+xroJSNrkO2bT3Ns/AIHrLouMWEKsr6gi6Y6n+LZkS02i
 csAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pupS7L5AyUoAPHtabGIyEQR3BLlIp3Rk/SPOuA0U4Wz7I0FLHJVBnl2BvBaFLbBkMHPJPTwL4jD8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUg87UmaE6ExUAf36I3WWT0BKtBFdh8H8HV7ZtvJu6wKDq2Aa1
 gpb5LlsDz+FKJAeMJZSIPhBknhZxWN5c7oGXVqfONk+9eYcFBCRrJruFl98F35k/MF5C/sdJXOI
 K2tDuelRunUKsAxNharkc8OTqlNvWwMSjO8fpU/BeqyYEYJCB4LfPF1Risvo5oraOTvadYLfcml
 nNWqI=
X-Gm-Gg: Acq92OF9SRrV1wTYS4cis7SaBDmZtn7v/JMdrBRHGZfIgNJ5Ccogw7+ESw811amsprt
 4cq/cppqwI12qIXVaUpK/tzuYpVaxbIvPn74b8sublslMiccTW+uTwYCRKcKGlMULbZAy43TnPg
 Fd1gPN9AEWPFpTuVT/SMAbarX9xSembsLQKH3lWJVobhgHXcuwPoRDtXEjFLUDQW/LVBSlxvIKu
 duRpXBCffMBTtPUOsmAb8p2yzzUWaj81cE+oMg6gsiWU2VNVxcxtjRDQpYOnTMyjw479iS41USL
 raPOlZGCaXEQqD2DLDYkbKJ5kQqUyzgx2YxNhEM5prxwm0RG9Ow8KvAs737f7Itj7mLk5moFB+d
 PD2mok2EKKU7WOOesFHwLtJapgCtKpwnud9aCq3eGhd9Auw==
X-Received: by 2002:a17:902:f790:b0:2ba:838b:bfae with SMTP id
 d9443c01a7336-2c42ee0f946mr95926805ad.18.1781472813699; 
 Sun, 14 Jun 2026 14:33:33 -0700 (PDT)
X-Received: by 2002:a17:902:f790:b0:2ba:838b:bfae with SMTP id
 d9443c01a7336-2c42ee0f946mr95926735ad.18.1781472813306; 
 Sun, 14 Jun 2026 14:33:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 14:33:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 03:02:59 +0530
Subject: [PATCH v2 3/3] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-shikra-gpu-v2-3-2f2d1347c3fb@oss.qualcomm.com>
References: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
In-Reply-To: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
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
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1225;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=S6znqV/U764pfMoWaMCKGZx0PPM7djt7INHbYNV0GNA=;
 b=cHbThRGdErenu+D4xB+6tFiU7NF1g5rTdTt10AdLvYMAoGXwlPggSRFZhJlXinOL4jAjn9CmZ
 z4iqDybCdYpDbwVAijgulh/0R9QqPHqBkUTaY2chI9tFPbAbld9LvBY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: 9a_U-aIJCeu1qHDl7MDd6WU9e-djSGDm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfXwxzVpNYl7086
 qFrtFL9Dj6Ois1yHPGXXCeSXL+ed6m6RSLAWj6/+8BHQzfMRdXO5Za2fB4jIK+xv/oGlNHoCLoz
 I88tzYyCv2qxxWXtPsBn7YTA6Z/Y+0k=
X-Proofpoint-GUID: 9a_U-aIJCeu1qHDl7MDd6WU9e-djSGDm
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2f1e2e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX3DVGUcg9JqMq
 /tR4+M9oe6Lfo2nyDvm2UqIvP0NBHpIpi/IqhtNakZKazGspo3hDFA1vTqDP+x6BYrCW9J9L7Eg
 m06Fz1/b5XM3hQ952lxlcWMqBpDHjwkDtbMgB+mP0RkHdsmTCn3POdZim5tlndbsCmiJpOJJACq
 UZ5ju0e6PEj1/Xe2+c2bdsfY45pwfET4KXGTipa97psQY64GJ+p7dnXZxZN1iXnlocojig1/3xQ
 +HM7mlsTBhKlG2VGAhAjq941kJLceIdap13xxAOd/Y20KwXntmm8UW40giFTVLEP11LJwh7kg2A
 Hnz4V6HrgjQPEKta1HuDTOXL+RH9ATzQh3c70fuHSka9frhaDU+TRWL+ex4bajFEw0wQQ15LG0Y
 RTWTjvnw2Gbj1/ji4hRKWsmdo4rhdMMlfUHqN4RC1jfEjW8js016coPydm2PU61kAO+rDD8EvGi
 6QDq4YcfJ8H9mxXs82A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140228
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
2.51.0

