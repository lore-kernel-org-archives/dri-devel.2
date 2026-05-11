Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4098ECD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE8B10E8F0;
	Mon, 11 May 2026 22:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKo9MRf3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmWNmmve";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AD9110E8F5
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:43 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6v0Q3444973
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=; b=hKo9MRf3/BMSbuvJ
 o8LINdzdvxd16Af2Put7T6zzZBBUBCJI1tB5ibOUFOhmhaLx9iirsACJRiU2fHj9
 mphD/eMOE/pybz9LFSFRLFTnrpfZuM915o42jL6vn2kmsrpO23Ap3NMwoZcPtStv
 ko/waX+jd3cegtaEimjRbEQ7uNwFH5raSxLj3ECssCrZj5QOupsqKjdRUPhshMEg
 76ECORk0L+sioTLrAdxa65fWi6PllGBYSv4ktJyHsm0+2gxquJ0ZDC2pDkDkFbk9
 c5NDnqy6nCJ5L6bp/KrXE2hk4/y/eSiVAgS8OH8rjFHyMM6/Jj6DpkZuNJVSM0U9
 7zpX/w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0gf89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c828f0f5c23so833054a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538222; x=1779143022;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=;
 b=LmWNmmveB4zlH/UnveNIM/G1mxdODoDDmfTC2zEpb1XUCrC/dGp7ZInePJEaKqmPoO
 nkI8Ljjrn50zGfRh7PgkYn5XhRiG0oSxki5bOa3lc0fbj2tzDgyAOFKIslKkYVMlxj/I
 0CHU+ihxTK902GBSfwnENpKaawqcPoeGB0I6/DTivQ8meIOcUdiKBMWVZsO+3OuakRYz
 cRxLnMqaGnERCCQRQyBaoPH9PdsrCW89bJ0+w/r56oo4D62e4G3TyVj58YDlyTP07ePY
 RfTq4Dzpa/CDFKJlwP2ouRPg1spCvfrdSGA/wXnKuLWtORf+2HRFQFMUlZ+51/SciwdJ
 Ea+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538222; x=1779143022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i1Ik9X4nwCWuWmFkc7YBJISS24AV0UyjAE4EfL4tKIs=;
 b=K4ZalSyzEzq4rX0alN9HBwRD9J5GIjlNINaY63R1v6+ZmS1fWPKZWSSfxJ50CJQE+J
 V/79iCE+gWdK201oHPhrVblN7cQxnfAWNDxa4sTpO+AohBbxvskv2yAAaTdp1iPLMYj2
 prxh9USWPgVxWIzlbQIpkWTtusGVpNq4hsrv/bixVm1zKuipkCqoisLO7z+BOZbn/7Yt
 +GkZMX8sL1Ugvlh7q1x0rV9nPCMn7Ki7E3Vi/dO0SQlw4soQLN58puMhnNZq9V72gMLN
 0R/qbfb1s4hWimDYQl5A9XTAvvApkdE1GTMSa//WeN9R1CHihIbl1RRmAOOae2MrM8f5
 YSog==
X-Forwarded-Encrypted: i=1;
 AFNElJ/I0bfzSBjbJ0CiHNJ0KNd19BP8Z9bu4QnBkjo2qoprM9yEpHKXTlyJ8B9yPVZ3nmZNwN2jHqpXfjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykMqJVctfrMybVWOwYLkAhIC5n0vVI5tI4JU5D1vWE2XzEcqg9
 12PNqV34zQonKl2ju1SpiCDT6xlTq1PO/9x8UHJc4e/ZZUb3AkHNV1IdByAtBcC2n8KqHVFN194
 jmvamQZJT2od5WOKygYnW48jZtl83SIfl57L6/CJaQglhM1C49mHS2Rs/v4igGP7N6MQ8XH0=
X-Gm-Gg: Acq92OGc0FIxbuwPGPnlZGkvDxBzkQ95sM82IuKEyIjO5GrmbMc5mezrK2PBmp7bbBw
 /1EaBtNPkc7hDcv4JqE+a60v+H/EejjavUIoNycQ4Ply+J6SLkGpHNx6cqYMulJK8OPRVX0mog7
 e4nehfxOZaWkWQBRCd/hvPKtG+ZTiB0G9+0ElY029wTTfet4TE4jBXgQoEuG0/r8ihXBo5akK43
 JU2pwgFoJk1W/DiMKUCKFQ79Myl62DSwDDTySe6S5FNN3huYUbUkpD6luv+WLa97hJv7YWcOotd
 Q8V2NLW/dDm9ITmpPAS1FJsCkoXP1a2aoQg0xk0uFdIv0yVsk0wbxroK4ffNkzLCuiE+4xj1fCS
 qZo0jwAshLTR5f0X+ihnm68rwTkVfTi4ZiLt+Joysrg4CNQ==
X-Received: by 2002:a05:6a20:12c5:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3aab12e2f4cmr17859607637.4.1778538222128; 
 Mon, 11 May 2026 15:23:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:12c5:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3aab12e2f4cmr17859568637.4.1778538221662; 
 Mon, 11 May 2026 15:23:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:23:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:15 +0530
Subject: [PATCH 1/8] dt-bindings: arm-smmu: Update the description for
 Kaanapali GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-1-13e1c07c2050@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=866;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFEjGgC4wb1fvQfsiuDZ/uQBzV5scQmb40bLkCfeBGg=;
 b=63jkHzMyfC934McaMS72qQzI1obDzNntWJQBUz0AVtE273amGFUWx7fovSDObmw7m1nz/fPSz
 r8jcxbe20XFBLRx4d/OizdOTrANdLrOMhCUnnVRkTpMBeNetRGijKeL
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a0256ee cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RQVZ3Ks9ONUmwc3llXAA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: BaD57tXh2nB-AZ1Soamfn529tse6hwLG
X-Proofpoint-ORIG-GUID: BaD57tXh2nB-AZ1Soamfn529tse6hwLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX0UfZrT6mYwPl
 cWcFVfyhdJF2qIy3M7QPM88i60ILIcDPxmW5NAcZqNFgAbaHh1SB7T2M7Sf0Vthk6WusBCcok/p
 OH2/R+6eZ/M0bfvWPTKK01FSQKOV5wr7jC2pfK8bd0YZLKfMJ6Ch9Hjva0W0iiOGLnU5+gSj3er
 9IarDXxHFmeARbq3lQLsFEDCpAoM9BYOdVqd9zoOW/jCp7+HJNGF8SrnGDtGBeROdLMqkzmmqm6
 g+XsyJLGFo96n4WpxOXyVSqjKPshCXiXFlbA3Z4HkKAROA1KbvN0HZbdw8tPkgxFf31wk3V5e8R
 DmtQfhsPza8bIjRIEgqd41vsIGHha/FeyutwSKrZE18d5tftuc7mkDJPLtzheruLUAXraOxMv+G
 izlc3Gqhw3rwjuR5avXcWfJzO5BfCLcV8QA/5tIT3mYLD8Oar+eAGUcS1AV/jy1r3eZOR7gsJd1
 hjVupETiuunrgfCGMKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605110236
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

Extend the sm8750's clock description section to also cover Kaanapali GPU
SMMU since it uses the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index b811ece722c9..d1330fc0178a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -568,6 +568,7 @@ allOf:
           items:
             - enum:
                 - qcom,glymur-smmu-500
+                - qcom,kaanapali-smmu-500
                 - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500

-- 
2.51.0

