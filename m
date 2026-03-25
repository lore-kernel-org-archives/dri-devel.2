Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A33106B50B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C72F10E8A8;
	Wed, 25 Mar 2026 12:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mlhXMX+j";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UmUDm/mc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F0FB10E8A8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:01 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBGIGE241604
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6bHulzvi8uj5fqRnkCJqOhZgc0tBVSXYzU1jRVkjfuc=; b=mlhXMX+j56Bj66vG
 60DTQy7zye4GPRMm3d1tO8P54tvXJYeih8E2BT659jKcSHx/qmnDAVIbUrGqf9kO
 nR18i5MHGxI1DOU9HVDSPZxSdDzVy+1EluW0txFqHDPcKJ6t58pBJRlWh1fgpBT2
 xhZyCdQ1AuomT1RM7CJzQVsaTLb4GYX7bE0nHKjBTRY+mEZfEOlTX5syrGgK/Q0S
 ZaTvm5n450J5JXFTjVZ8LB6lw19WXalC1VAEjOMAFws59cR99bIrSNHh4AtKo/iV
 xtMFXmO+H5huicvTZytoScez2mfUxcNrdTFuPYUH6rHr39xU1WlbVHh929EAnk81
 tbOVeQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4cvp0n93-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:01 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-94d6c5433a0so12581444241.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441020; x=1775045820;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6bHulzvi8uj5fqRnkCJqOhZgc0tBVSXYzU1jRVkjfuc=;
 b=UmUDm/mc6oUgBbmS1n46Jvx8umRSqBrjeNEnnYgAA5/4pRGSCqsb1bzmfTV5JppmBM
 BGa8Slg8j9MK11sKct2Xu0c8DSG+5eUpRjtpQRMRHT7bk+ZIEKOgxQ9X6wwdNMpt8gQb
 FT2sB6G81HjfpornUXPRmbZCcrMznPleqQLq2FkWK9GHC7e1KYWi2q7qmmXeoLa+EpjM
 T2oWffsj3sgRZBcn1wn4OXHMaalB72vb7yEYXcHVlJqkUU0yWk8oUm989axcOWYFpvEd
 pK3aSevApKGtLZNGDfV04/gsnoom8lL75GwBIGKJiShM6OdXUwmww4tRD8+miC45fFAd
 ieqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441020; x=1775045820;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6bHulzvi8uj5fqRnkCJqOhZgc0tBVSXYzU1jRVkjfuc=;
 b=oG1pAA8PEcTSqoFMVvj9oCF+BNgX98j2+cPeg3duhpSi43j+DYoWz3MBga9EMMC1TT
 Awa89bBHSpFEAAwJ+3Su7luZqLwj13VjTleabq35JEZMjrFpArjBigQyoB2INaRcuM94
 yd01QTcwM/iQY+/5vTQGLzsfAXmiJqmi+kRwI7puNvRcIswGoQ3enpxHPpViu1JkDWmT
 gEA+CQsOITI/OHFj+zbITNRBgiprYQP0xAf+wNmOv5tSmh+iK+c00MtI9eVHT47IlMig
 YHpebpNKRwXFJVMkeKP+uyTPvRDT+e4PD9IOJ3X/mbIEujcFkLv/IndK5bfuUo64kFZP
 Tu7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTGMpbGUSgJW5WRAZoHtRdVpONh11HFzmd3arq3vhDOKpkqJaUywWlzVE1L/YDi30vTbVSvQ8zpOI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxozNWRm+2u3aU5b6RAgNuGXmWer8I+cXoDO7yRkTttnb99LbkW
 Jdnno4mhNDnJxCGcikh1C4Kyk2T0CU0VdTcX5g5lIvlOQUSAeorykQwU/wloAEGxtM0JX8FCZra
 xeZQ6ftqejrYWJ993qLe1vzPsEDTsI/3McG+FE4w8uWa0m6zUYtrI2zghYc5B04F47WppHNY=
X-Gm-Gg: ATEYQzz7g50Q75pFrxd9W6ygNRlZgjD6y6SPif8mzvY5ay6MPi9RE3xml0B/cREtePq
 +/bzvrJGK4UjPAfNR97Ak9t9YUyi2iobD2UZz2TFvCcRkf1vf5CJCJdvs2GABilRgXceWqhhuN6
 4e7VoXEzgW0RT3iqOfb4kShPG+FPnZmYIi5EnnNt+IioKAm4QI6N2zZSslYL73AFOTLkyPa3hLi
 15z/XpdsBOzB9nOhwvRoVLVOEmM0P7laE+/CL3llyTeOzng3OjfHhOFG4GA9JXsjNq4wpBjHI9M
 M76SQ5UbqlnqITAQaPHUGT5l0hfVNd/w9grC3hBpWoLVzN5NQz0PW+nj1aObTf6ePHO8FXQ6vjk
 c99ezruI9bqishze4UYmhNaSNwc4gMX1RzBAU8VToZ1NC
X-Received: by 2002:a05:6102:2c0b:b0:602:aac7:b8c3 with SMTP id
 ada2fe7eead31-6038790b9camr1337426137.31.1774441020488; 
 Wed, 25 Mar 2026 05:17:00 -0700 (PDT)
X-Received: by 2002:a05:6102:2c0b:b0:602:aac7:b8c3 with SMTP id
 ada2fe7eead31-6038790b9camr1337403137.31.1774441020095; 
 Wed, 25 Mar 2026 05:17:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:16:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:42 +0100
Subject: [PATCH v3 1/8] dt-bindings: display/msm: dp-controller: Add Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-1-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
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
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9HqjZjYEEXxWYNOsK1BlNwDe2qJ0g5GNTghb4mwsuPA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9Iw5L+afc/dju46TUr2s9Lq2I56+t6xkHzKm
 Q031EeScWaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSMAAKCRDBN2bmhouD
 10BnD/9HuRUfNWdBCJAgc4h4Lhj+HceKAcROYA4eYTZleik5zTcVA2+UoRkuWgVnayYohOp91tH
 +IDCPUYeYVeq/puwXOedqh5gC8e3WUj38YAePe2UWEu9mVsmWAbmkZoq2x13ccL/tPU3aj3RIPK
 kXouMO9KXy1YT6KGcWJjQa8ApumirU9xZ/fThPhLFskgVTShheq6wcEFoO6uEig7FZQzj7v9K/n
 JU1kvj9/hHgTFJnTAqOJ5QHy8c7ivSOhKDt36O5/eQSzBZIBxxnsBvYMRkX+StGC//ro8HPmH89
 M07tkyAjK7D/pgOVz5gKQ10vGjxGTANHzlYFX87padmWaMdIduaKeUhD2soDJSrzrpWDPPb6Ad5
 vq/D61tWXinvbV/7WFXPxeXNWKRz2joYrpaui5CZ3oYdnTkL/QXHebcFITHXFQ0NrupCjV72UdD
 kJ2AMspRNT3par6p/tfZtBlbSs8TOfIjLJEi1v1qoH2T/gfUVctgtcHh2xbLjvhweg614PqT1rU
 kspSJ5Nd5svksyMzI3zlUpFzTYypbob2pUADypVlxFLukEIC90nlslvzKS3/1Bp8YBwJzi30jod
 iHq4bM3+HNL7PH2y8/JudbkKjnUNUIVXoIHlHQk4caI3op96ee8HMA6DQP2PNl2ZfDjaFw5D1MK
 QstMS4EhmQw+K/g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: 1rBTXx_IBD5eyeKP0zjogePr9vcwRDgt
X-Proofpoint-GUID: 1rBTXx_IBD5eyeKP0zjogePr9vcwRDgt
X-Authority-Analysis: v=2.4 cv=Q73fIo2a c=1 sm=1 tr=0 ts=69c3d23d cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HHm6X3FrcUt9TeXg1a0A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX0KBfjt4fyrem
 /NHEB2K/Lf07XTDy+ckC7P/kg6803o9q763a2YAPlFRnMEtqyFWXtMeZqPvdiDDo0NMUIV2zn76
 NhuCFM2H6T27b9UJ27QwJLKfQuUCLGvAmDFJ+6Y0MhRjFs/vxDfuk1/71Vdhlkdw8qKl/Jxmcjn
 3akfTwh85wFjqVQvhoV3lyeRliiNmNwQMzw9lo3v2t8d7/QV6E70iWJvrNGaxz02o+CnhZ6Lbuy
 aK7af3LSHcS7DaZFeqITH9MrXs4bo5lXxE/3wd2IJVIya5rREsni67G2fcm1STYe+bHVALTt4F8
 P8kbwlDNriiM3ZI+MhtgNYNPWc0EIDZr1i9vio21P3ZZ7JtjD/9c6PrZ/48gE7FCWPOYWLlarLN
 PqCOh9nZKhC3Or6H1WBNqzUjhKqux3wkueVNamJlOTObkP0uiXlgdPwYq3f4Eqw1p0QwZTzVq8N
 H5zJauN4QmzzHRHswPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add DisplayPort controller for Qualcomm Eliza SoC fully compatible with
SM8650.  The device looks very similar to SM8750 (same DP TX block
v1.5.1) but with a differences in DP PHY: Eliza and SM8650 use DP PHY
4nm v7.0, SM8750 uses 3nm v8.0.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
1. Commit msg
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 02ddfaab5f56..8239adb7f7d3 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -67,6 +67,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,eliza-dp
               - qcom,sm8750-dp
           - const: qcom,sm8650-dp
 

-- 
2.51.0

