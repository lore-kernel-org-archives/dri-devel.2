Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF49C5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BC6A10E075;
	Sat,  8 Aug 2026 20:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kt+u8FVE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IilkfzaS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2736C10E073
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:23:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678Jw2RN732828
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LdzD5p1HJXZooPEGcGX0tp
 QPvvizEG9tLbaiZX0cVG8=; b=kt+u8FVEh/bU2DfPfFoMg2I3guthlAy9iOyC+V
 NdAfLJtskO4y0En7SYPgtF7/bCQPhbXQVXB/Bul2PZe8kObpTNV45sXQ1G4+CrwG
 x7BCKcDSAEHj+Z2niKb66eB7ZXB4D3o+ZX453KJZY1Di9bkUu2B51fj1IbY0MxLu
 J7LlnUPqWsIixMn3k5opQU+ODasu2MXu/M3A1BQCrCBtzwVg8zRQ2ld0QnmM2BCd
 275qEjDp2vhaV4wr15rL64c14avRsM1sMuLfEauGUIjFF015KbfPBBFEeyTIvmcv
 EXNW/FsTgJJ3hVsZcWwsZ3xelvfn7+lFvnycf/q5tJ2bvncQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwvhv9n1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc86a9ef97so14950925ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220603; x=1786825403;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LdzD5p1HJXZooPEGcGX0tpQPvvizEG9tLbaiZX0cVG8=;
 b=IilkfzaS2m+BceN4ad8ndEJzQYg2f3ppA5eNokxnbkkRZbpHjfsI9gyNM4qytca4Rr
 PymBCjY+bmVuzy9YRnYk/XcchP9lqqjV9u5extCEHGx138uSZh5585AHPpCNLhpUS4iu
 KitzYPQ7iB/KSRCjrja9QEv3QZQfE6XgwObM3H5CCXpLhf6UVjlhbtCCUa1ZoaB9M4nz
 qiUqF68e/FhanM9/J2Ef3AuPbfA8BkBJxFvboUv1An6cWFpaT4H8O+1NQR00V2GiVMwz
 kLuMxOLgm6UlcS47YwT+29KHFXmCOEOG38Iyp40ncwDfrlY34/kiHRgDQ4GbXYJqhp4V
 /mhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220603; x=1786825403;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LdzD5p1HJXZooPEGcGX0tpQPvvizEG9tLbaiZX0cVG8=;
 b=MVJ4vwk6szxlKcdV7XU/EsvTwpYKGenC8swaXQfCPHBqvDre1Cillaqkhu3EX8ub3w
 4eb8G4PgmL/pbEbPNpZ9Eg+ZW1FT7XcejgtZE/CoqFbDFH0mHVqQPFkoYUUQ0LO+GrIk
 vD4684qJzTwq4PqgilYnd4MlD7Lgt/7+3ISNMl9KVnvtz00gd9CdebvPBwxnUZVAECTT
 5rVU3x9w34+cMWB1qIWTmFUY1KPeXJqymjKAXiZlMGv2ZnFyQ944mAAyNoZCo88CqBT4
 gV7a0uEl1rn9zR3Qrk9XVU6pLZGTa8m2sS2p67sPcI7nBMp/O1VHkINOVP13wZXAZreY
 FZeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoOgjGbCstg1NnPEB4WYkVTygdX/8wPcED0uQErC2T4ch/IpzoGYGTs3Mw88f7t60geixzruzXHPHs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywyl+7eMRkERq5NFooZgaQ9RUVFmK0anGV+5EQ8MGnpl+smb+mA
 QMWzXZ435gLSbP3G7jxuT44JUGJ0gvwToIwvsPzTwrsWhh3hahYX8P9qvs300QrSB3d0/f8cjvi
 4KQ8D0AATKxw1y+L4A+0dOclEbQvBFQk1gCBIxBxQu+l5qeCh5lvb3td7JoT0bXnaQ9Vc2G4=
X-Gm-Gg: AR+sD13CKzntChtrpmQcyES61kppViOVKVscTpx4VEl587Z0pPIqPXRLK0KmXAgc1vK
 fLM2Tg+ozi7ewswzWbhtNJG3U++R6dA/qJzMh65GbItonhDhMm2pzyEE91y8VMeC9oJ5PhXy6Ul
 KlLY97frkWLT8foN4enxmI8GEhanHxuBFh5+Vhq2VXXwWY/gIMyXsBKQSP7IDzX5l2iFDL5hVho
 8ZJQzBxN7SxY1YpdxmpsLFhL6tb4tZaGImLDm+TiGDN0/wdU5V/uW3KnL1DFFU7tb7ZxFXv9oOi
 sO9GzcFPZfxgHxdc/Nc2tMBtG0PR7SINDQ46HDWjOGJ9hAI/XDkkXC+6fjsz6R1ziNpItCRPmg/
 YMDYEF94K+2xLZsuajCK8FW9s
X-Received: by 2002:a17:903:1a83:b0:2cf:8131:75f4 with SMTP id
 d9443c01a7336-2d0ca7fbca5mr425586335ad.11.1786220602839; 
 Sat, 08 Aug 2026 13:23:22 -0700 (PDT)
X-Received: by 2002:a17:903:1a83:b0:2cf:8131:75f4 with SMTP id
 d9443c01a7336-2d0ca7fbca5mr425585695ad.11.1786220602356; 
 Sat, 08 Aug 2026 13:23:22 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:22 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/6] drm/msm: Support for Adreno 830 GPU
Date: Sun, 09 Aug 2026 01:53:07 +0530
Message-Id: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuQd2oC/yWNWwqDMBBFtyL5bsQEjQ9K6T6KSIyjDfWZiSKIe
 2+MMAycGe65B0EwGpAUwUEMbBr1NDpgj4Corxw7oLpxTHjERRTzjM7yJ3tJu3mlDPJc5SJlIku
 JC8wGWr172ae82cCyOqe9j6SWCFRNw6BtEYywW+q9WSSu/ACI0jcWwdM/UhZfTUpVja02Qd0wy
 kTdJjzLk5Q37wkxXFbZX9LQrRcpz/MPiRq6RNYAAAA=
X-Change-ID: 20260428-pakala-gpu-1e99c9671687
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=2014;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=oLLjuOgK040qtaqEeDmQSIpMa5K6dCEHSb8JedTqI74=;
 b=srshORzAuxD4g4wGlcmuEJtAGJPscUkJp828BRyJ8VY8A4AOd3/8du7f4Nuh4lQ0FyKudpgBx
 PE24IaRCe10C+2L0hvUBBExVelnQaIofQRhJejQ0tASWmvLdyM8ToVi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=eqbvCIpX c=1 sm=1 tr=0 ts=6a77903b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pO2zmJmEa73fCFxjQ5kA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: OmHYOgPSHptsWzm7RSd-CWI3nZ5ThYbP
X-Proofpoint-GUID: OmHYOgPSHptsWzm7RSd-CWI3nZ5ThYbP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX4thJH1jGEAnb
 LgMzKQR2QGQ4RH24ARK9pbt70TEMh2CqVEyOWcq+1AaOFwFgj6792Fwee960ECYxCbDsrxll20j
 oMvOr//7yU4t6djmMU8xsqe14hAj3ClF7XjDym9ve6euKOC1uxA2lZct9zWgKPp1HtHuu1KeVAI
 lCYc4+zSnP+dSrTEUohSKkpeiY63b7CtUXaK9wY2u8Jf6mi5sN+VVkGxkY4xPqw/gztvfD67CMf
 8kfpFVfc2VnNNOJ+jltxDqb/r51hGc5u4Bvt8HfLkJGVtQF4sVLhKba7tj4ye5dDLqaRyw198uz
 eHuu/83kWfo7bBZCssDdVq0WYBx/NV5uCkN2qXPH/Oq1FVPZSIYcl0VZl+cfI9HcZ174hnJNDuv
 aSV0ay3BosnuzypjAtImiAZIqXJlbahwptWnN8NFS0BmK8w1/zLLLawUzfhNPJltlxIFvGlV9tx
 YobMRBbuyBOhIaqenMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX1eUY2zYqpvr7
 t3BWPuGCqHjwDaF3pTGTxSdGsTd6vqpQDk5LFD9rERG4YUYFZHgPm9IcyKefXTgzzhQ7lP1WqYT
 8hb6Shwmv3DAoFWhRc9+G5OJ9LA8Oy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

This series add support for Adreno 830 GPU present in Snapdragon SM8750
chipset, which is almost 2 yr old now. Adreno 830 is the first GPU in
AdrenoeA8xx family [1]. So, architecturally A830 is very close to A840 GPU,
so we just need to add a catalog entry to describe the GPU along with the
necessary register lists. Both Mesa support and firmwares at
linux-firmware repo are already available. Mesa needs a correction to
the chipid value which will be fixed soon.

Patch [1] & [2] are for Rob Clark and the remaining devicetree patches
are for Bjorn to pick up.

[1] https://lore.kernel.org/lkml/20251118-kaana-gpu-support-v4-0-86eeb8e93fb6@oss.qualcomm.com/

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Gaurav Kohli (1):
      arm64: dts: qcom: sm8750: Add GPU cooling

Jie Zhang (5):
      drm/msm/a8xx: Add support for Adreno 830 GPU
      dt-bindings: display/msm: Document Adreno 830 GPU/GMU
      arm64: dts: qcom: sm8750: Add GPU and GMU nodes
      arm64: dts: qcom: sm8750-mtp: Enable Adreno 830 GPU
      arm64: dts: qcom: sm8750-qrd: Enable Adreno 830 GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |   4 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts            |   8 +
 arch/arm64/boot/dts/qcom/sm8750.dtsi               | 335 +++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 334 ++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 8 files changed, 672 insertions(+), 26 deletions(-)
---
base-commit: d56fa0b2bd2d9b2fddc10e8f5bdd42d56676935c
change-id: 20260428-pakala-gpu-1e99c9671687
prerequisite-message-id: <20260714-gpucc_dt_v6-v6-1-16bf5289572d@oss.qualcomm.com>
prerequisite-patch-id: c050130345665caf00f2390fb3da0adc62667eb4

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

