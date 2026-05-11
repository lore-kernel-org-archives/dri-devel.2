Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABB6CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8EE10E8F5;
	Mon, 11 May 2026 22:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n672HzHx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XygpsLcP";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B51810E8F5
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK7TK4868141
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=; b=n672HzHxzEtRcoDf
 ir6x/ZJRlEfhbIJOMVkv4eyYqXy8MLDomiRPg2BnI9MdSgbrwtPlxGXcbQrE8ZMH
 Tm79PL/RiDti8cr5SSPqlKYIQPihvq+KgcpIznMhmQ3+VCQyPXo8icYNTV7yNUGw
 h+h/WaJFcROAZG4lMM10n7i6ntRQkn6Qa15zvkAvqPsJr0IFcJWkuhWOv4VUd9mO
 mHCMDbRSS2ZYZRzjxwjrs4HEctl0JYhJKxLP+Bv+3E0GTQiQrfhPpQicVPthpkXk
 WIoWEkPypH5zD1BNsC+BCVVeFbLjkTpgRepjdbQLjiZGJgp1Rarb11OFp2zFmNDq
 IJM12w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28c6e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c828659ecd4so997877a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538230; x=1779143030;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=;
 b=XygpsLcPPkyAf1L8zxQaD5Q5fYZOGfDuBoZbrCyN+/Bm2XrvzqZCZsvrJPyVUTDsbK
 L2luSV5m9Cxu+vs4rF3xLV040FljvJl27xtGmp/MMZCplcwjKvmql946Fw5MJzF251SK
 Jf9M0U00hoLmYHqSf8casdAB4bOc1X/zqF00Xu+eiVOkWgPyZMD0ysjFUIVFKQhj+zxp
 w/NxYBZgCryTOZZvqEnNscy1ZbGHfG44YLTJk2m0BzsE9rb/ZAQ65j9qQgziklCWY1dL
 oOhsVhex27VMfE13QBjmZvJ3fUNLZzPdJ09vUnH0Jc0nWEG6UqA16MrQIGLMFphCOQ7C
 0DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538230; x=1779143030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eXUF9eOdUNAlLXcUL7FmdHp0dlAT98Q3o6ahLF/ZEhY=;
 b=aRvVuMsXxq5WW5w6MIz4l4FpyQwA00xzEsg/yDOxEurGQbM3JkFvf6Y6jays2ZnkX9
 NRn0i4pZPAhhSW7tToEMW4oS1tOUJVzax5onad5gmylo2jZdVTMFQrIEf/+BVvRHN7zf
 k6mCF39q0IF/4lyDWecCgl4ZSkfNXZfdd2uzgSAGpTX1zEkk4rAMJdQiPTfOALCxPJr+
 6aPDXjcYm4Cg5cQ3ogTWAXOzYDFBGjYKjmYBRWtItdO1uIgcANr6tZ2RNxnE5QdE7gZX
 J5QvXJqhWwWKUZEoQd0uKKvruBTGhiN2I/Qe7Qj7XTiEB9EBbdVntmwx1ZM1eVWhAi+R
 Dlmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y3fuHpxPYRIFTWlDGumLX2E0sVyN1viYkq+L7+Plxps828g9BkmbVi8c4ImsggcVV49llX6Ld1h0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTlgiaZSoGddiKSjVW10/jNtt0WQjFGBEyzBf9nd4LskGHOkFF
 1y3P7eC24zEEWMpg1/wctcOPPtYR5LfpwnvnTOiHoN63cGj5+whC3sGJXsORsyXFZgEPSonDcST
 GXAMmdlUbLhNhjKBbWN5pxQnz90OrDyFlcjuvn7bKzwOKdDk+dBPByzY63LsFe9tu7nY2QCM=
X-Gm-Gg: Acq92OFH0aPXnS8i2IpiwuUjxySValwUaVCZo3PmsR3Rf66u/arM06T7kb0o0k+jGvu
 Lk3WJqyQXuzQN2e6/khZfc/hpS9HE+sHCIsdpgiPvtxDErRjSshNgYkXwyIR1V+W8oBbFBmPYgv
 KTWo6+oHMsSiOanckw3sABABORD7oPusP5PtlISjaIzHOIiUyU2ON9yRS+As76Hx7SkQOda/2rl
 yZaTkPpOxKmx/5mzChdq35zBwdPOfgS599wQH1bzz4CLLm95wKoc9ReGAudcYmv0SRYLL+/Rn4o
 pBH/oFL2aBEVKDk8uToA4qtS5ipXmANIX1z2Z9KfmKMWS1KGCHIAWMxVLnuhDpiyOMDoA2TYv3p
 2vwsjVR2ZNsX6bYoJiubWo2po9zzQHLQNHSiEkODAmtkraA==
X-Received: by 2002:a05:6a20:3949:b0:3aa:f7df:6146 with SMTP id
 adf61e73a8af0-3aaf7df68ecmr9095269637.46.1778538230356; 
 Mon, 11 May 2026 15:23:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:3949:b0:3aa:f7df:6146 with SMTP id
 adf61e73a8af0-3aaf7df68ecmr9095222637.46.1778538229874; 
 Mon, 11 May 2026 15:23:49 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:23:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:16 +0530
Subject: [PATCH 2/8] dt-bindings: display/msm: gpu: Document Adreno 840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-2-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=1371;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=j1uKoavk7LSXVTFpinQJ3L50+niGwfT5j/plxH9VxBI=;
 b=dkSBw1s8Hl7c34xGexPilCuQxVMR0sBENGS+SZhwEMiavLDKfYoCy5dsAY7UhE8iKS0QVuwSG
 2dA6b55CTO7AU/2fkPlZlCpIFE/Ms/Ak81W1hhKN6X0xKKbaFWz5JnE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: x9MFQ6hzbEWDu1cSDf40JNUpdwSDXCu-
X-Authority-Analysis: v=2.4 cv=Mv9iLWae c=1 sm=1 tr=0 ts=6a0256f7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=I2s05RQVLi5l9ras6fkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: x9MFQ6hzbEWDu1cSDf40JNUpdwSDXCu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX5Xk0AHu7x8qc
 F/j5i+rmHFU/gSEKO0VkpBGbCUMWQ0NYkTsLt+qVrrFL3lfREiMNWm7H5mAaQ+CQoLJjLdBzlRv
 pGJLgfboq2dRDqp8P6CEm6UcAMPv4Pb6SZv+eiwqzA6j4ETIHWckvIa7qFwt4nGIlBYBlSB0mFC
 37twxlWSgLmxQSRtCEBq0uqI6eLe3c+76tqFE1ZepjefDNL1wMTKgfVErEj5a3NzhMYZwp/dhj1
 ux1Nlj15P5k8m9glIMFN5I+hrs+L1jZVyFDwTQxgGYte+pWBy8UoeLe59+tjyGvQzHGoFyiN8+6
 DgHMB8re05peFyIdyoYpO+WLku/g4/sxvvf1/w9rWhuC6p8E0G1KFnSdO3mL6CAutbPG8EMGnOs
 RQs6iLD3M6Q3TGZilztgMeQbsNNTWS2a4cAuSDIeeu5WQmN07hry4FHSYGQkJUYcbCmlhO03t1S
 +MdaSo/eMWLyvQB7H5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236
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

Adreno 840 GPU found in Kaanapali chipsets belongs to the A8x family.
It is a new IP which features the new slice architecture with 3 slices,
raytracing support, and the highest GMEM size seen so far on a Snapdragon
mobile chipsets. Update the dt bindings documentation to describe this GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index e67cd708dda2..35c6d38dc379 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -415,7 +415,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-44070001
+            enum:
+              - qcom,adreno-44050a01
+              - qcom,adreno-44070001
     then:
       properties:
         reg:
@@ -450,6 +452,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.51.0

