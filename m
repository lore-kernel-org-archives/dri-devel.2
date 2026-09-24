Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AE3C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F295310F7A4;
	Thu, 24 Sep 2026 21:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVMR9lyd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gwe6egVd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBD210F7A4
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:34 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdZO02295182
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5tdcekugkB66ivyH706zrRjgKb9wjBOeIcQvd77Bs0o=; b=cVMR9lydDqbJ2eM0
 G72iokSL9QiT6pKIanwZ1s8jWrDZ4g/wIY+JhOxxFyIDzvJraI4SxTcuxc9G3WWX
 0xpfN47PJGNIKeVj2hUTvT94k564NGArOkbNekewDQPQfE7i/BxfmyQH//CTfYvr
 2B+bt37+AI0O7qCaFVWWbVJf1nFhMm0+GYY0gK8gXzTBeuP5idvzYzLP49Vjgc6Y
 uQAbU5XLo2spsBTVHA/X8EJWn1N+6VQsLT+8IhGeoLYe+UZN++Hn9HD3m1trvt5k
 tx0wN4TzhWCNYqlfMpr3wtzyzs4K5mzOlyg7rLdBJNeZaCAKY5784Pwxs5bb87a3
 Dv7I8g==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw94k8jj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:33 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1437272611eso426810c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284533; x=1790889333;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5tdcekugkB66ivyH706zrRjgKb9wjBOeIcQvd77Bs0o=;
 b=Gwe6egVdLH3fzQeixs77jeg5TmBmpZFuZ0v2jAEtIk4XktMJ1EdiqLFX2czzDqcEGE
 PS9jrnu7IcY8P+QaknJK4PFue779nmU968l7qvhcFbOvdLEHDLDohlWN43YbxsqR5UsB
 hy0NvBCXrZDYNoNGVviDg+qREhOw43wObW8wqZXtDoO14JfkEYfLkcQmTy2rECMD/Gpr
 Pe22F4PjSgJh0Jw238mV8O+sSr9kFMdLDwqgqtBLLUoaHtBx8ydw2z4P5Z8cCj52HxOY
 3O3dzKTiZ7vwEamhdFjQjj8XsP/xscI4uHGu3EqnGWnkP0vJy8tKhRypnTenEF+AyHXb
 AW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284533; x=1790889333;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tdcekugkB66ivyH706zrRjgKb9wjBOeIcQvd77Bs0o=;
 b=cGCTpgP7eJj7UIxDOvf7v1Gbo/PhAb0e0YMWb7FwlOUY8q6SGORoYZWkq918ZA9aIL
 hpq6TqjUAtq4bT614aXYe+Q8E+d1LK39dGNuM2WZn2jsii7RY/7FRrC0/EUOauUsAEPZ
 k2VNwDeErnMeLlkuDEH2+pZtunhp3tHBh+kidn2ArKlnR1gQWh29h5GJ7YuHx03ailRR
 snZxKz7gpeeQp60qiCasUt3CWKwhxDLS3GN1ozm04y/x8EglSfw35Dw9K3k6eM9amQOF
 7KmelM82pKIfh6ds1L64oa0WTHJZxtVSYV0dEKRSs29TiUy29vKYRDiDYJKriSbo1mpr
 gShw==
X-Forwarded-Encrypted: i=1;
 AKwUvByKpgHEAyxzQgDx9TKwmIbQfspXxz/ajgi8dGb03AJxCvOsFlrfEqYN8o907BriAcDl2kKlSuq+bGU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHxBC+U7RBaUcQjmT8b7CknL78veDHAyXjRUSRODj/5Z7xZyz0
 3YVCspRRsKaM+EMxAmiGPFWoW6MnpVzRpx9fIQBReFY6mB7dTsTBMEp4j0yVX/l9BbBKFfGlP1/
 7fVcZQHFOtykL8Oy8Gk0dxXqFNYxjn/7/WJ0fPaKhscjftlz5e4yBkNKx4hpZfa5cIIBBOzs=
X-Gm-Gg: AYBFou2pfO++TE9wFRORA39SWz8clxtzoIm3wfnvBytRfrCQTasROamwgiN+xTe3Nss
 pXe0KnEMDkeMNjkIzH1JyEuapmRSh9i8qfJ/9jBocQawMVS0YwCjwOz/1t8+ntt7+3lpX/ur4QM
 Sc7EW9n2mPThuBuaJbtSHDjxEToUvRQ+MOfoD7xghya8rLXnIG6VVbJYYLBvPBuWBtXm4e28/Y8
 DrXTlfqzig0cC2txWsYXq6lVT6+3kwR5SdbH0EyDfki7Zk4NN+V0KVuUyQmjddvySCbSqDk/1QT
 KqaR7ycaO0wmdTjKDKzd6Xrz2AMnoCc9b9WiiUJbI8GauaoKL3qUee1EfKKZ6zTZLQ+mArk6Iaz
 ulTFankpjluwc56E5T3eLamw=
X-Received: by 2002:a05:7022:3f8b:b0:143:50a0:56d1 with SMTP id
 a92af1059eb24-145ee902dc9mr57124c88.17.1790284532704; 
 Thu, 24 Sep 2026 14:15:32 -0700 (PDT)
X-Received: by 2002:a05:7022:3f8b:b0:143:50a0:56d1 with SMTP id
 a92af1059eb24-145ee902dc9mr57096c88.17.1790284531715; 
 Thu, 24 Sep 2026 14:15:31 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:15:31 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 02:44:35 +0530
Subject: [PATCH 4/5] dt-bindings: display/msm: gpu: Document Mahua GPU/GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mahua-gpu-v1-4-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=1718;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wFWuC08EWZRz11+MVbDa+H+VKqlWAF1+MEP53XMoALE=;
 b=k+Zpqxr+yNVuWSBKTLezYW3OVVU34ewiwjumOVOdyNbZ/VJePl2XAynAMxxfbm/xhPbHYjeDB
 z8R2UG9USMACf0QCKKlrU+RZeBDQVbQpTOfSVYPS4Xm7ALM0l7K/y+n
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=aaj0Dhot c=1 sm=1 tr=0 ts=6ab592f5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=I0ZAm1zAenetWGxY4hkA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: R9V4DuStXLR0DP-oQJB9RroNin41ehkt
X-Proofpoint-ORIG-GUID: R9V4DuStXLR0DP-oQJB9RroNin41ehkt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfXzr+DZk4kPI7U
 c3Q8PL78IOpq5kqfOA2zwXfuVZtkxkhXRBJN/sh+bHFVbPmjvrmxKs0zwIPqnCvAecx9RNw4Rkd
 VNCKuRJXqn3e5ddC1SpdfxGFmOMU2ehYv+QzIZY5RPhP60Gwao07jWFTP/ze4nPjI6wwlbDxTBa
 SU4gnpSDnkkjdA8Ul8IabqhL7WlyC/y8VE6aChQKGF+fBSoQIbZQxv8e3DYGuQ2WpSVFj/cj2/H
 JSbT32DswYgrX8rLXgJXP/lNJdDfJUbrn2k2x6vvwf3UyniEtghh8zRrwRSM/zWMbywIVcrEMpB
 hxKMS60pV/kNiwzGdFs69hQdwOqtK+brMJbEuVOZ7ayjSM7gZ28jpEn6dINDenx6bzWAzsmFqc5
 /XD08KTu1DVROwMwtOo+k/D0H45fLJVpUJY+ISuGwtNhGjAlmCxxtFp5tzVV1RF6JmR0Olc6omi
 dBxzmZzur2ohRvRWklA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX/ePs/Hl/uRBT
 loNmABjCPKACFC2OBqN9GALd3NS+7QKofmySDuQJb/j2dygqcfnvVcRwdeKKvA4b9mkaCM7PknP
 vIOBKK+qmjigdGcoFQugQJTMuqUBh7E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240086
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Adreno X2-85 GPU found in mahua SoC belongs to the A8x family and
is a smaller variant of X2-90 with fewer slices and smaller internal
memories. Update the dt bindings documentation to describe this GPU
along with it's GMU.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 4 +++-
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index f22661447e7c..d10d6147358e 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -363,7 +363,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-x290.1
+            enum:
+              - qcom,adreno-gmu-x285.0
+              - qcom,adreno-gmu-x290.1
     then:
       properties:
         reg:
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index e5efe2d35ddc..8a103f998dd8 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -452,6 +452,7 @@ allOf:
               - qcom,adreno-43051401
               - qcom,adreno-44010000
               - qcom,adreno-44050a01
+              - qcom,adreno-44060000
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.55.0

