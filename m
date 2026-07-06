Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317EBC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A7910EAD3;
	Mon,  6 Jul 2026 21:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCWKeDBi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PWdOvXR7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A715810EADC
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:40:52 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEP8c1639973
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 neSdm1nMyL53Us0RPcN1r2C1JTuB4C/N4I75S58aU5M=; b=jCWKeDBiSZ4CNpz3
 UHG/bXB08T8jao6zLEqscXBgQY420HkAGU5CSdqRZHoPcUrRFtKaQJRqfG/PhdR/
 8Fyqd5AqqnT/XiPCqcFt+xHVl50PukrTPOmhiYNbjp56e/dSBVlBYzoxSMGOhJrU
 K+ieZnB1mOAdpwobm8JYAzR4i7LN/o8vIhjd7hNCmqNYLh1+YHNdUf16uZBXhxr4
 OOLNrKtiRzXFwzOJ19BU67H4AV7t5DIBbYV6yuoNLgs4Jvi6XhnXYL0iEH6aJTVo
 eB977Hv/7XMDbFnf5bi5yyA6+P4MJvDH8GdPNc628lR8JYpI3v6xrKEXpIvtp57R
 N0Y9OA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r2ycc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:40:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88d7a75507so5758041a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374050; x=1783978850;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=neSdm1nMyL53Us0RPcN1r2C1JTuB4C/N4I75S58aU5M=;
 b=PWdOvXR7qrofOFRfAAOvSOL+YEYnM2VDVZYYnODdNLKcbY9L6isdyMuCZMaXHxy0d1
 KsqhFM33mWXn9qHXRSL6hmGn4kyfVI9alOcUSjF7M4LsajH33rLUR+3q9Pzf8YQC4GcB
 /V1JpBH71MNkM5nzJ9kW6TdAjiT2z1Pcey2tQNGGKBdpo5oUyERk3o2yNzpbOzUMuiyd
 upKgNX1w2b57OuytsVlUn3ZSkJRjyaHY809zkA+fEZLuM04s6VinNdk738czT1AVrtaG
 5um/T9nz6E49u+HE/pmM2tYbE/5dKA8IKZFMhzRJiIe00mGgVncXCr5GHOVToKJeqwej
 uyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374050; x=1783978850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=neSdm1nMyL53Us0RPcN1r2C1JTuB4C/N4I75S58aU5M=;
 b=Hc+/U8pawAT+2u7ODXsN3HTGY7Gn/jto6l646ogKUHB2AEhUq0EwMfOlt7Dd6YLPMJ
 LqWaqozOUBqJmaq68jJd5jN5xjlvmL3Vi38NYHNdSBhw4/EnzMNnZYsxICFwxJEaWPNJ
 BzSr+8aA5PcBkSqcLM4B30SLRWSX7fpCbzrByrKhRaYgteXayyuI4YX3P7tC1bVYMD+3
 De69GVcbNRKWhvM61TU6fRNdt6tEWH0pCOkV6YZmit2kk8fgG/WeejQEcDXoVrcJNYCE
 3tQQhy7kaqdLXWotdaTUIMOyR3E8XlDpII5C6Sa3kR9f7vBE29Hjog9KHV9UmhUs0LiK
 Reng==
X-Forwarded-Encrypted: i=1;
 AHgh+RoeJfLVmxhMo2GytYNTqWLMWBQr/Y02E6fCYy+xiKSvYx0qWnL3LDC2ERJNL0sS25jkBTRfwxzC9+I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVQq9UbxD26u+yXZWmulDVyG7VQUP/zwI9KROfZ+KdvksyNIjw
 F7S/ebpPr9jawAH4y2twQ8b4NpGgARKWVU6D8DFStlXyH8VDX4enj1/BKdeo/ToQ1nCVq39IAeN
 9H6f2hnWKnFwen8YkGtvNbDouBmE2lqQhktHwcgsmOiGvbB+qyLUrnq5Psv538CsBngKTX6s=
X-Gm-Gg: AfdE7ck9mQfEB9VXA2iasGfRl7iVZ02Yx8AW8NlbCLZcwPuaku26IFUhieiF8zi3Iu5
 LBqN35wGXcLWCeaN0nfYH6BgDUzeCzfV8roeklWBjJUwGfdJ8xR54fZoE2nOEkU2WjjjwswcXvf
 mzqZinLXul248THIL5c+TUNKrgiRTQHnl2JpQXHL9NgZGGMjZd4DgKzl0pSFbJgXQnq5a94DE7T
 qvLcQMXEM7pwALR2JXNF+mZKB5V6SpiGig0sNit8oWN0En26E/I7APIn1H7OsQ8gqHshsCtNPsT
 B4b3HJ8DEzjic8JmM8vZyj6OBxRjwGCGENjW11mk8nEeRUd2c00ks5AF9RILLUM2y3QITfvV/Ji
 YJG3IyBteJwIInFJk97pUVKm3hCzmlCRUhqs=
X-Received: by 2002:a05:6a20:918d:b0:3bf:9bfd:ca95 with SMTP id
 adf61e73a8af0-3c08ef05781mr2677426637.34.1783374050534; 
 Mon, 06 Jul 2026 14:40:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:918d:b0:3bf:9bfd:ca95 with SMTP id
 adf61e73a8af0-3c08ef05781mr2677399637.34.1783374050098; 
 Mon, 06 Jul 2026 14:40:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:40:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:19 +0530
Subject: [PATCH v3 1/7] dt-bindings: display/msm: gpu: Document Adreno 840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-1-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=1363;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=lgLt7qK/jqQ9CHjMSFFe96pTIkCFyU2Iu+KakUcKLvY=;
 b=+P+NDR6cbAXILISO4q4L/6OEYgzU+DHpDtDOQUJr7ifwgex0pOzNyEowCA74kl7n5Srs35yDN
 PxQShTIo/yLAvA2XB1tMHqmYhhHkYJIT008pm2Q5i50KTBBYOTNWTQH
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX4cppqZcvl4C5
 7bNmXgWeMi15p1MXvVjxVzERYyAqMMexEcOhCzqJuC7iK7ftXxVX9aPVmXVmybMSiAqrg95RzW/
 znyGuPVxpi1gzP5pYfWrMDTNhH8JKZKScmzCzjs5AWaD3JguxfdfUMmYBIZHQk4pJrlrGTlT0Fh
 uTx2p5MrirDy3Fs3OiqWR6VM7JE2SH6KqgOdzRc8QtHqR35yzh0WD4HWFZyNjaYJRIZcsycYApM
 qykDXsG+Xr92EAxYcfeXAI7BSL1BXjVBOdn9pPpQ83TD2a/6RtcBDOw33CNx4l7OAkl1D77T/nC
 YFkh02cPWGVaZRVCO0aTK0hlJwpNXP7BERQNCs64KDGDe9W7d7rhi1iXOX3GyU72yJhNypnPPhT
 DvWuz53ZVpaQT8uILby06AGShl8DkVM6VhoOUz8SyTymd8ywhx3O7Ia6r4aAfeX4+hAY3GiIDcW
 Fsrx4BuJH0n40hd9wcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX/IqK1iX8vTAQ
 Vl5D//dDpQzFDsUHQ30pD3YuiIB5KDDvq/9zOokHjmcSDlKv5hVxKvLv5VRLuMyAKTS6mXhaZKV
 igKBpW3LxzNwTrY8Z4BfmNPPfJgTxlc=
X-Proofpoint-GUID: jE93VG4yJsDIAQotjVlBQ4ZwkBCaGMau
X-Proofpoint-ORIG-GUID: jE93VG4yJsDIAQotjVlBQ4ZwkBCaGMau
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c20e3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=2rxQ3qtc42-NlUa7jS8A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060218
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d0b7304c17af 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -413,6 +413,7 @@ allOf:
           contains:
             enum:
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
     then:
       properties:
@@ -448,6 +449,7 @@ allOf:
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
               - qcom,adreno-44010000
+              - qcom,adreno-44050a01
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.54.0

