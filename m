Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07D8C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE4D10E663;
	Sun, 28 Jun 2026 18:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b7gI6+6E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bcQEqlO3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5098810E663
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHj2OG449403
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=; b=b7gI6+6E+IyJ3GMr
 JGNhNPvvWEuhGi2oyJJfH1DTEQHSNX6FbL0eowjjuI7VjiPh4XSwP7BLOWIIV8Rl
 A5H5QngRwub9KeE5tQw3SGiAAmKJu7prlKkvfGpNEUOOhu1aXTb8G+1dF39AbnKg
 4oRKopXTA/yYrMhvmtRymFr+cNs73lhBW/viD4ZGf+iYgNkZ1dgWeu+0Z40228t+
 DYBk8Md2Oe5xrscuUVFHeMtgpr/2kGYIYYQc1AArU103RO2M5jNoOdoDohy4Pi1j
 ChZgXuVhK9rH0fi/9OIhe9/AqvCbRqFlok0YejzT4ajEv3X9SkySW7YmraHOTTvp
 +5ggHA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tukcex-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so6031573eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671071; x=1783275871;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
 b=bcQEqlO3VhykkoYUN8+WC4RyaR0GMJskWCbkyDRX5DVaV1sx9I0KxH44XSbhELQ09T
 Wxx/ToDU2zj01UTEHghPr6ijDDWUcgLPT+UGwHflo4ES3Zs4mN3SyHp0SWA19ypHl+9z
 vWHoAh6ijkfWJKAhSfQ9ced8fEfc2qQINPVGAhqsH6U7sFkDGHd8/IvurcLv0G4goZ8H
 jK6cwNms6/fgzeJEb3Tm2B4D3zMnXLiMQU/GAxp8I8x4Iv3J4XNGlNJib4ymeHNqGrPm
 PhjuhhCeV3D54+fkqzLgOZguDR73rlGx87wwa9EeKwMoBzcrJc7rwmRwl81IAVbXPHdR
 uJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671071; x=1783275871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RJNbTAj+jMFVYX4XVSum5y6+uZsOGvYQPlgU5ZiXWP4=;
 b=qoM+hpKfS29vakSLm0t7i/46HNgfgfrnGCZ4skINr5JgcpyNynvGewDVpY9yYeuiNr
 /GjZG/cnedtW2ZV3sXTeuv/IkO4TMA1AznjNkuwBNd5z0L9AnQJ4YaLBkH3lOT63Wa+t
 UYCVZTJDIou8kGKTIz+g6rAlhnWI52dRvf57CBTKnHwOAMDFM+9YY07X8hpfs6ZOn4um
 I0mog/SWCjDA7CPBPHLm8xFVpFKrON4x1yj0cbFnrnY0ipzGL9umCk9MCRrSx7oXstxt
 KAiPqqvcFcPdI4/zEUKfTaSnmdv1FPl2jFhI6YBBLUAaeNemGe0UzNYeBHKca8NbicxE
 +2SA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJkzR5iKTwobXVTzeP5Bsdwr2CX2WvQT2S7gCvzRsrXiX8uujjIDKbsu9VIccycFl/R3995j7DmIg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvpuvrTQru9o66UowZFJIyu+JxR1cYH60El6Rkm+qWRK0NsbjO
 f3zbNjdBx0hiO8biL+uKn4F6bHMLE+0EGb7d/4I9kZtkAwlDJtnPHY7BcvVNpyLQpjvQ6KCleGv
 kJEhtBiDk8oeFH80xqIf6O5yghA3GcROjdY3W16+maoqUxg/wTOlFKpVg/kb0PgWrszBxhzgkAW
 a36gQ=
X-Gm-Gg: AfdE7clN2nP1HJ5eQzDEbqorlDysr1eew7KzWYy+weQsmfwwkEcPjsz4fDPbsbC4cxP
 q6YsoNGW8AOQWfFRyE/ONiqNpLgNaktHc6gALQz0qPP3ROluRWicD2LXOqER1Gly3psypqjFXHB
 n2TEWB+1PiOPbU9/rvd2NpB4PGUuWckP48MdsyinazMD/Be0SMrasZdpSkYyCPECBYU5KChy0WN
 +Zwq9xjKAhk3gSQIMjzQWuyTn2yxLrCEWRLhJTFmDkdde8NhWHaxkm+HiexX0CaTFPWJWPiL2xs
 bZSxDDhidhYxmh4tYRLTTICyvYTwA/OfsJ9bK2tY19A95DQfktnIH7jJW2TiaoEgFKagC7xz0pX
 ZnwRFWYHq7U9iKLbmPnOjNnMRXQe3qiVPdLs=
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c84a265a1mr13670333eec.0.1782671071210; 
 Sun, 28 Jun 2026 11:24:31 -0700 (PDT)
X-Received: by 2002:a05:7300:7fac:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c84a265a1mr13670305eec.0.1782671070686; 
 Sun, 28 Jun 2026 11:24:30 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:24:30 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:54 +0530
Subject: [PATCH v3 1/8] dt-bindings: display/msm/gpu: Add support for A704 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-1-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
 Aditya Sherawat <asherawa@qti.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=919;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JBJQ6bZjxqgxmRsc6EMGB+P+JygJ8pgGviEVLPjhEKI=;
 b=22p2wlSkso0sZ4PEQ7LITGuwdJa9RASM+Jq+223nG5cAcH8yMmpZFDMuD6z9JBVhrbUJh2aE9
 UR9CUdoJ8n0B5yFmfy5Fk5N6AuTTQsx6RktlFU2oCAgzHBC3Pba4JXE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: EsdJD3nsTveRD9OxcuvzM4ND1lbIyBnx
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a4166df cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0BLMfrXV4dllX2mv9u4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: EsdJD3nsTveRD9OxcuvzM4ND1lbIyBnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfXweTTqgj1Hb/+
 obaMA4VKoGM0crR0scR0phtYn0bfZei8SVL7t/sQDMMTm+bs4Z2aQqpHdmaCGDaqvQi8B3ne6zB
 uaLgshkkK8qHJTYrx/9hIQ1PfS7Ucs3q3XXqxLkw7dBKacyGUbfsmZSdvxhiacXnSYVdNrOvjOO
 Ulk9SAwbjnGOaoLxqadHu1cCzWuuBU6ixnMrBJnX+prWD9Xz8+bL+dLnkTTGRQvQNwI6oF6Xynv
 zRKzRlSydD6SBur5+pqrg2YNySz/ZhA1PIGYBUotHWO33yzn5x6qxXC/6AW61ZL1H2/q7B6lZAx
 naQy2Zbe8Lvv7g5Wq6uWKrqXZesSGoPwXmru7yiapIROfH/OeGgoLkkJBd2QPixwJnzH7YAiAao
 T0sdEouiJarHIGTz4LY74LVYJjMdpMexj1fe1+cD4V3FfZXT9TQLYIk1QBBwnO4smHWxbgXfXco
 q2oQcS2VnQLcN6KNl4Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX4xPJvUtglZyU
 n2iTw4eVWeoq7biA42YzouGNxdXDo0fV4JtV1/Ei2WdRYyLXItfMf7W9MYhunfAws8h7z+/w8QG
 ej0kI6kRNZ68cO/czMgKxIA91QlG9uM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

From: Aditya Sherawat <asherawa@qti.qualcomm.com>

Adreno A704 GPU found Shikra SoC is an IP reuse of A702 GPU with very
minimal changes.

Signed-off-by: Aditya Sherawat <asherawa@qti.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..8e648bfb3b23 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -353,6 +353,7 @@ allOf:
               - qcom,adreno-610.0
               - qcom,adreno-619.1
               - qcom,adreno-07000200
+              - qcom,adreno-07000400
     then:
       properties:
         clocks:

-- 
2.51.0

