Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A207CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D9B510E8D2;
	Mon, 11 May 2026 20:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d0sNjVXZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kETi4Qvd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16ACA10E8B9
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6iF0866468
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=; b=d0sNjVXZ00zjAlIZ
 CTI3mnYjq7UvHuLR10YTbJX6asgq7wSFuh6rLkXDFd0BDc6Uay/w9VONomeNe1ju
 Xl5yO/BDTaxKhX+1Fo7yMCz2YQ6WS0MQGBG4nng9HUgyXNUBtYSq+MAlMt0HHXwB
 GF+jPPIGEpgGRV/tAWUzs0+4XhinRkB+USOQ3o8zfEi39QhstLjUfkVGbvQu9CPo
 jQ43yWSwcTxxvTyCfCU+OJ2mbY3Yupn1aTYQT6bXJFKb7MkpmFJm/9GszbX5+cP/
 uOj3DsOcMANKEq/eHvAJsCtWRNiBq1GfvHVt008tluahGNewFxp+7JUCu4xZQK+l
 fHJcfg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2804r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:46 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3662eec51e0so2503297a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778530065; x=1779134865;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
 b=kETi4QvdPm6Nqxlc1res+1wenqPNHQlXbm0k9VXRzripU2Jym6T12Mg74bft475Q+T
 4U445c70Y0JjuaKFg6Kkk/mZuGnP4qXH0pZOUzDSNTJRZ2hJIOl8gUKWoOhigzNwU/cF
 WXfNe1ZOhCOsXtx2r9rF7fjp2xffFoEcEFiudMv+uXwtuI/d0Fd7dV8wSyaZ9TCN5kY7
 ASF3IIAHTcUbJQmXPmHr94/OaU+qmTu6yBntNwAZd8jWLSIpNb70uqnW01aoC2Rw/RRh
 vxJ4LGL/c8unCVc02cEkdYgyP6S7Z3b5gi8l5eXZeKF5A6ZTmCplxJ9haEpeYWOko20D
 OEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530065; x=1779134865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
 b=JMxTFn5UqtcxE9RMIeBGYh1FrYeWjYH9VTVb3e64SMBjyBRTkz+rPx9g9ba1EJt1qm
 LNtWS5WwhQqG3+nXEdfEWbPwplYOEMVkHi1iBz6Ts6lQ1g1C8GkxEUFy+h5tZOkZSgU3
 ttNQu5kzTUuHDIwDy5NsR8Wgzv6zYS9P0ZbhwWOZ7gXiHxK7+wLYfuHgYVw1Z9RdkOu4
 mfMn9gWPBSMVFkqA86zkDub22bONilyEbBh5SYjiRJRZayXWHRrj/+t4S5y+CCFpTMpl
 XYNrHr8NNHSr8pjDw2/g+vKEEy1ttDIuw3rb5OnEaMMccBEyT3oZIXMRfUySdtH3V38G
 s1Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PHEh1x1KN66XtklSOJI9yfTuKgws8yEogU4i7QLcj2Rss/DyGoa1oz5nZ9dc5m5Lcj4Lo2qGW/Cg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx80z5XHPP+wPsgZNQmylGwo7OwamuSU12G0CL+xRnQLB9XGt8k
 wPFwTSh7n6GrquqNvRciKmui9vuglHpW6MheAuYQrLEIkYdfpQBtvpaKG/hjKJdtNa5EJekESA1
 fijakNBgYSMUm+nQVRA5tn6kFPfj8WS24qTQqnXGfEMRcW4XABB9Rm2NR1vxNM4pcMFlWXVc=
X-Gm-Gg: Acq92OET/yw2YBfBYDAoEdcpLPBLLJTKmUaSEgdOtzoFBsx47/yFzXBYReN7cz7rUqG
 Zef6+fLpyTfuIxMn5RZWruHCXaote6m5R0bYe9RnpgQMeo1fxsiZouSHPQp6LkeFUVg1xqTBbDl
 Qbr4xTYvKGcuVs9uNbJwzyD5OwCwhEfyHLylvBpWV1EzeZ7JKsAd5ruClnWo0j0i0Ks+bMPZID1
 KLIjt5oe3cwNH3gptIMEd48SRJryHrKiAzOgoB80qPpY/AAAkAsieb1W3ghHRYz36KFRG78kc1k
 p76//rRKeCl9B57aGkk8eALPL5OiR2rHtAKw+FOCfOZSgIjmBIHn5gwY9rcFnK2v9bRzta5WtzX
 e4PY2Ricaj/wK/obm0Zx7cB3+N016G/1eyVKR/3mV26+gRQ==
X-Received: by 2002:a17:90b:5603:b0:366:479c:59de with SMTP id
 98e67ed59e1d1-366479c5db9mr16833867a91.8.1778530064928; 
 Mon, 11 May 2026 13:07:44 -0700 (PDT)
X-Received: by 2002:a17:90b:5603:b0:366:479c:59de with SMTP id
 98e67ed59e1d1-366479c5db9mr16833821a91.8.1778530064377; 
 Mon, 11 May 2026 13:07:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b01ef884sm64911a91.5.2026.05.11.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:07:44 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 01:37:01 +0530
Subject: [PATCH v3 3/5] dt-bindings: arm-smmu: Update the description for
 Glymur GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-glymur-gpu-dt-v3-3-84232dc21c03@oss.qualcomm.com>
References: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
In-Reply-To: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778530037; l=1014;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+Y9gYZSkWF93iB7//ohDWKNnMjwm/WhLykXaB9JYn4Q=;
 b=jpDwm4lo12mTRBBvFYCZVHEtYZLK8NDrYV9uMGhiHEVL+Az57pN8vnvippGmyAb6k9Dwuf16N
 YUJoaxT0HNWD50FrKsL783ODVVGT63eaKXS5O2cosQz1DA71HvFyD4z
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: MxhpiE_WMU_ninzHTZVJlQzZSKmeYuTl
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a023712 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RQVZ3Ks9ONUmwc3llXAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: MxhpiE_WMU_ninzHTZVJlQzZSKmeYuTl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIxMyBTYWx0ZWRfX+zIU9YXlp/pM
 l9LqBg0H2ABNlPy5P75ekKgTjreIOSpWZ7rEe+uCjX5hwz/Ndu+zp3D8sKRCiywkxovgZTpJSqe
 7DIqZrNtxxX4kZPH6RR1TBhn8yimmLOA0o+tqDob1fCg5ivZXDI/6ZnjCeucbc/7vovTd4mlNge
 2XdWA7CuIUI0y1bNm7Rag/V9em8DaTI6zJH+0tg++tal9ddL2+OWiLXKqmqDySu1to0Mqy++QFD
 ib4ln13yxk8uaMWea8w0Msaa9o78oT43d/8VNIvXQqBLg/PFtPaU4VMUy3LAQbb24cN2eOSpI33
 KZGiUakBKJc5guUbdwcflgvG2GPSbfhPSr75A8/jE8oU8k/hChm6kNdeifmHNizn0YwuD8ToWlM
 iqSh7zPc9qlzhqzzFJpJ4c2IVFKFE1JD0vo/+ADVyOYQ9E/2Vms9cyf6vx0zHKRBr/qVtic9TD/
 v+ktlGGRL8Y1OlVGfeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110213
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

Add the interconnects property to the common SMMU properties and extend
the sm8750 clock description section to also cover Glymur since it uses
the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..b811ece722c9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -566,7 +566,9 @@ allOf:
       properties:
         compatible:
           items:
-            - const: qcom,sm8750-smmu-500
+            - enum:
+                - qcom,glymur-smmu-500
+                - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500

-- 
2.51.0

