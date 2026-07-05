Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2211DC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766EA10E168;
	Sun,  5 Jul 2026 08:15:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLqsR38d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GlrjuFmm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833FF10E163
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:15:19 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664NaprJ146751
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=; b=GLqsR38d3s0O+C3G
 ha/Vk5wbBipwboDBHv0FtJMt7TquCLSezQRxS1rHaQVrLikPi+USFxAIofO8X2Tu
 G33bNA9Fh1OPc+7BmajK7Bq5kQTOIbqwvVkPtnXUBAbj3nZdEzquYpZ15MFSuFqi
 10egRU1BM8d/r9dhlPKw0QPcOiLj98U0vd4w9IMcWg0/7YVCt/0UWC5oSHbu/H/A
 +I0atb2HmOOJQfgM89EunmAdHsdDG2qKX6wybRS63Y0oEQavoHuPJC/3Qx1duOV2
 3Tn9Itr4lXKoPb6rB5cBI81q5a7ZgxcjXcaTXQGwTuzqm33d8vcJ1dmGLYPNp/sZ
 RW3vvw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aaqg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:15:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c82843005eso36357235ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239318; x=1783844118;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=;
 b=GlrjuFmmF5W3+nF00Zx5P2k+4jQpY74yFoY8kCqcLQ9jY6FI7gpFQxlnmZcwmWBgZZ
 8k22zDFQIbQZ1feI79/iA2iLn0NrYZ+upNmj/90M79u4Yk1/uSRAJ/CID9qmUyXwVA5y
 qvY4+StQD87rkUdeg/UnIHazsEADSgqf0s/86x+9zB5j+3BVAjbzVr/WD5a8ejdHrfYI
 4UxdmaSltg5QBfO5CTC2AEJhjziEG6iiGzl6uNxlQ43sqjIOlZu4qRoseMBvuWiPp0Ou
 5+8afG11QnLmA8PGge+sDFMZwmMEtsLL7nWqVQqCVloDj2OtXC74PE0aovTU9DYCZBfl
 9LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239318; x=1783844118;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=;
 b=QCdzKTSzhpWBZHqUJhdwmrk7jQWNlytbV8N6SyAjryV6OGdF8cXASdJLPnoqlaj5ZZ
 DxvB0jhA3N0lu9IwC5FQaSePPDsjBkKqP7adKr37ggGKt7AuLgxe1nsgLpRiLP7dzv1w
 /+nNFkh8hS24CGoEk+B7WT5kY+PXiJznVqs7w4O0qvnlnSyAxwrZJNUDe+hanKD5kvWM
 d+Q2pHptCRAY7zunZ/XTTajWTnkvm8YvR59vRNSdkIjyGVvMYFPZ7ziCmG5MMN67jeBY
 /4Y+AxvM0CuQwOtSeSmwilWmLp+XKltsxHJ74oVSa/dkX40MQSDm3LfMCUKbKASGyIum
 OkoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6AEG1flZy+/rO1RBeZIjUdgJmLzF9ApYEg9oAPERc+f00WqacDWqdBdfjci09d6MHOodbo9JZbsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yysawsf9Fu5kaJXHxm21ohqrUgQJOOIrmKp1+ofHEV/xt+y8QZt
 Esng4qOmi3MV3JI7fzKN/T2tEmIz0isLCi0svH06g9r5qZO2aLzQide73FqAEpBXrJjs7/7ZrjB
 9NYReAyFuc/v1aazTAHqcO/ShBK0QaejCwJmRpu5nr33tXX8zOz9NGF0L2WI0K9GCQtGq5Hk=
X-Gm-Gg: AfdE7ck0HcZ+JRarqfBZvkGnA7hINll3ZUiXBi2D6dXmVANgh6lbUJz/c28hskzUqJ2
 lOO70KRJtpmP7Dqp/dUfWCpOGEgs1ekUF1hoVhqSn5FQK9sOc/wD9pi2rf3J3bo7IZZorap0KRo
 y6whW7NKmCHc8xIhI7VGbru3UCSjGkquZbCtcAdTMyTxvCfTKJKlArsL4mywxcWU5IwpgLj1E1+
 wCDpOAIdtBv9HE+2kLrVWVWjFOJyaCfduzLcmt3SfpJWClApDP5HND7qVCq7PIqe8lze1xHroFV
 4/S7AiGjQYmwC3+f1ZSWLuqoSsyHz1rsQdMqih3lxFId+Np91RXbm+laoeZEJxpkR3QBbRsgi2l
 NPecSEozKATnr8T+W/uTTUywT1EwSNVPOdrk=
X-Received: by 2002:a17:902:ea0c:b0:2ca:329:3d96 with SMTP id
 d9443c01a7336-2cb97e432afmr54557785ad.3.1783239318308; 
 Sun, 05 Jul 2026 01:15:18 -0700 (PDT)
X-Received: by 2002:a17:902:ea0c:b0:2ca:329:3d96 with SMTP id
 d9443c01a7336-2cb97e432afmr54557425ad.3.1783239317878; 
 Sun, 05 Jul 2026 01:15:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:15:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:20 +0530
Subject: [PATCH 5/8] dt-bindings: display/msm: Document Adreno 722 GPU and GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-5-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1907;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SYs6J75vDEjoACg/8a3Xl+R9WIudj3QmUdBCIW4Akd4=;
 b=pgyLEEFK+ZpQAfr6m8Tw3cgMFBAIXB4mjqFjEtA7wyC8js//XGYK0pV9c7S79qGFwGMWPQOEd
 aGXOOqZhfZ2AqPhfgXlTvu/igiit7d6XcfyE5WWNIIiLyd8Zzh1MKgx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXw6yLZVWRRx0i
 F4yLId+on6SJXRmFptdtaxoVlZZedLzwmzFyoxfON+Tdy7btEhgJe+KzNTmQFxZ49f4ve+8nR+p
 tXWhhKZQn6Y6Cu3jDptXKhi7+MDrdCE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX1wMse2jIgPbz
 +WbHB5Kwp5ZIoJimL3c9hZApzkvTJ0h5mZQtfrSMkXSWDqV6zw5/HQAGDTY/my1+eN+TM3gFjDv
 7we/BUm8nfEll1v29gM8+uM4EXkzyJYy9X3bd5mERXyJUlj2qGN3ixFsLInFmUTc8UU3c2WojcR
 biut+Jrdg2wEOUVo7GhY7JyweG2t2koYms4wbPPCOfkl7wY/aMB6xlmDxm0KOVvUmzNz8K6syPQ
 DuY2zIyKP/K29KlpGupKkSr7EO8s5+pB41BG+T0B30K5YEkswwEYr/7qLXVygyzMMnsMN3AWSvR
 ihzTAWIsMlGLZdsNpqbx/46dENm9Y0p8hVE+ursTvXE3XWkdw+UQ0AJqo8KVBB8XtWNtZlI1wMv
 NXGOZsncUSASNHkds4tb2mkquPC2yVXTj1nH/5zfHMOqiBT4QxnfiCcqq21tNe08YgNtbp4DAIB
 1oIiw9xo8RCJIsvotig==
X-Proofpoint-GUID: 4oVgcaOeU6P4zNa2dGxXb-pXTYzrJwtY
X-Proofpoint-ORIG-GUID: 4oVgcaOeU6P4zNa2dGxXb-pXTYzrJwtY
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a1297 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=byR7QgRKzgUKQ7cIeKEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Update the dt-binding docs to document this GPU and GMU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 8578c2f8122e..9e459f12ce3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -262,6 +262,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-722.0
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
               - qcom,adreno-gmu-750.1
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d096632694c9 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -443,6 +443,7 @@ allOf:
               - qcom,adreno-680.1
               - qcom,adreno-690.0
               - qcom,adreno-730.1
+              - qcom,adreno-43020100
               - qcom,adreno-43030c00
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01

-- 
2.54.0

