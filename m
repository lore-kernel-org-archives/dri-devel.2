Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C14C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4177210E833;
	Thu,  9 Jul 2026 18:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfNQknXE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZB4c5nPg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7173710E833
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:42:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HYZsl2331711
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=; b=YfNQknXE40JDrClz
 EHFnTG1PkwuOYhq2NNByi3fOFBH8S3XdJ4p84LWsrRi0ASDYyQRM6gNf06kEg/bN
 FmGvNqpXo09tetopfi9LGsQt721cySlXMqnluZSFr+ExFKgd3EctkIoJjijlHffR
 GozG87Gp00lltvfk1OLRHKtNJBzN1BJgoU12ex+wHQvFc/duMohJlGRW2SG/S4Bh
 aLHzSmxu8Z/jb+Nh5QEKnNYPrqiUBBCOZl6iRNe57xmTL9prx8PAeJ1NkYNET0F5
 +olZA6fZD3W4xF0nLUTIf5TwqOmC3Mx+PSb/CzLmFn/5wASY+scwjCdwSSzCuNoy
 6HVfcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24rq1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:42:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so311827a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622573; x=1784227373;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=ZB4c5nPgJg80RvCbuxGgfy3pM+CMdHTrgNPx1UGYki7odLYU2pVB9K8B6fmVwuBtxv
 M5v9Yi8v95CSo23d5fp7fE/1wNmN7xUkr30RZCdcy9hYFX8Y8T5QRe0LyH3jo6G3U422
 EIMA3ChaMBn8VQLNnspa0kRHlVlpvKdJwu6PKt+5ucA+0Lc2hbi7qXbrEMwjRQ0W4eyw
 O+gZj4R1D9cVRbHgCA87PCnBnl8K7ia7PG752TuIyc3En320qPhGuO4/7QYaF0vquxwN
 PD3gSZ4/fKopKtOof7SjQx3y22409VP8IKh8bGn8fehb3j9MgXw9z0VNax/ORvkdAjxc
 bCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622573; x=1784227373;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o57AaR11oY74r7NNNrEra2MutbnOlIvU5mENPfvHh4o=;
 b=FfJqFojYbIxjJxDgn6nHWe27pQQ4CpjvBVnclvVIwJheR3hVLOcshCnxTFnqW9y5oB
 hliyx1tyt526jJ/Cexm2o1mtcmbEHK/xN743A/CF7aZLUik8lOQ6j63jZ6zYaO5e4KC2
 8fTkouQFyrXu/Zw/mK3RkHt0tkOiUdKqqQXMRManaKc32Q8VnTc9aJkJaC9GSr+WTlWf
 b4VZQB5gxgslbnjQfnsJDiW01j6QZwW917lhPn7CqrjBfpmwBDKIKqQmcP2Zowx9+nZZ
 aNwGs3z7BidRDdY8z2DC8HKxi3xaAIuc0xBnjt9GIiBVZzZNpc9Yh7z4cfNN8n28/Hfu
 X7FQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGQEZuiZpGzLTdfviTdb1E8rYPuSBk8/IkTI21vRHS3iX0NSjWtLxxfp/Op8e7HWR31+LTo2n1t0I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCmIzNumKoDmxiy9iC+Jr6tWQbQDP5pnrTUFOr61Ocku0rw88c
 nsn1xmdQV3cz3GrLDz44kHsMPpz0eu7NAuNFAMtRE/+8yXUI4EOqIFtq2SIxRsYw0tiwMsB/6eO
 HLCy9/f0wlFiYjUEUr0/xvVRuGkInwG/iU75H0WyUanlz4VyfXGcXgVEqRIqUNQ798Gvsb5g=
X-Gm-Gg: AfdE7clfz8Q+tGiEotxrRWdrIM8GpUCnYksM1E65zZ1qbIBqGDjb4LF9DxB9ToGMR3r
 6XxuCdGZd9ioTyKLo//qfBqHbzyFBQZ9T8gqZL6UcxGWmXOoBh7WT2rDcJ3AOS8depearLCPglp
 J4Jj82cXHq5Pr+z9gDyngouJl0AYkI2TZKWoeB3xZfj5iVH7yCgk/7YCZDee5UPBGDlpTv6o73b
 tnXkt0dS0iRTi2Dv6R5icSnqz/fBvt6z59SY6POz2pHu4ilBmqSrD0aI2g7X8hpQrkf+IwutgAJ
 yIi4C83QDbC9mubxRC2qfezAYlqD6AD5uLZv0F9pm/EuzMpnEVKvlR3deNiKSqJ2KqLdgUjiJBO
 EAqHrdupxIjPDG/xugyMyl7SlNI5APXxMTPA=
X-Received: by 2002:a17:90b:5685:b0:387:e0db:3d8a with SMTP id
 98e67ed59e1d1-38943854a52mr8741851a91.37.1783622572619; 
 Thu, 09 Jul 2026 11:42:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5685:b0:387:e0db:3d8a with SMTP id
 98e67ed59e1d1-38943854a52mr8741825a91.37.1783622572199; 
 Thu, 09 Jul 2026 11:42:52 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:42:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:02 +0530
Subject: [PATCH v6 3/7] dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-3-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1298;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2jQmU1XEfwX7ksFDjORvPn6m0bWV65j9hgt3Tl3GEMo=;
 b=ZHYwuBBmHydbbYbR66h8CvEw070fSbVdXWh3mYBcTePopE1EO2/nQ2AQyCyuVLwlR9uzZCS7X
 FeMi9LFyjJrC962OmSUnxwOhByuza4MZs+vELBPqh9Pj8eXByS5d7P0
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: -eAKne1Pjp2667wHGtuZZihzQIVD0PyM
X-Proofpoint-ORIG-GUID: -eAKne1Pjp2667wHGtuZZihzQIVD0PyM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX90BAnGou6LxR
 U0ndezcJC/PKdqzLy24br1j4p4B+oo9qFydvCf7A6jUKUT5W6xdNtxxaIECnSmdvvdHcatVbfxB
 nVK9tHyzHtrgo/PwuhwZI0uROYSWbaU=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a4febad cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX8fcAYaWoX25E
 sQhRP9NZk2IemAhOojEqga9R3JGkhUSxDmXweE4Ecir8xbOaGsAzoKWMqlKpmf4Q7sRBXaBmXmT
 6EqQhsVBSMARCbGoqXfqwCc0zTwSGW6ik4edNLYFkqYrRS2QwLP4EW7UE/uJ5PZ9Ab8sNJJ1kAl
 fZUQunhL01mrS27gsAeLtbMSZFI8qvjfX3GhxmAFs6q0RMs0st/peP7zOT/EKHC8WUtrWAbj6+o
 fXY1ccdGctfzcW5WMQGTGKJxlvzYmJCMLviEE+01WQ8dCZjEpS0WPHSiBCmH/WN+SrDLntM3Cz/
 jbqTGqrnKEUpYyHGlHKmi+fMj6Iwe3c9WlyzMCSdHZ6gzqnt2J68VhmD9S6spp5LZPJRN3On+6L
 NGX003z+7ECr+gSyOkuXJZxVhSt2r5Yr5g5syvCm7thQJamELnTM0IuTDzJybX+0/Nlxl6vWhlV
 pniw0/Jcj3EUb3ewu5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090184
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

