Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08B2C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9A9610E514;
	Wed, 23 Sep 2026 10:26:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ow5jyXsp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cM8N7bPn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F8910E092
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA30W94087726
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=66DgdwaIKLKr5JdQuHwyz9
 6tBFu+vZD3qCp5z8b4hG8=; b=Ow5jyXsphKymKzbxbcD7VcjO88M1VonclChz/6
 fFbDB8WrHRJq8SYA0/ybBdsoOlpRubsLDLo7PteueIAJ8RPiWom9dpYeiO+yrG0C
 OB8VNL4Wlh1lGxLz5bUvBT/4f1xy8QZc8yhYTGF3vBR1qFe93x56GFZorbpU/Mcv
 HMcFUsIBOkNdjvbfqrmX+1yKYHd4nm3hKNki+tiZf6YKSMtPYoRrQTy0S/kA5iW/
 ij0CHH/fytRafZa/3DBclfU2rJ0USI3xo7LGsgF/lW1LkyBAsR7lfZBLjvFql/St
 P1WLmecFkQWn9/vJP2J293xOolLyYghlNnO5Xijs7/hP2+tw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c3vda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:26:12 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1438fef603cso1263135c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159172; x=1790763972;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=66DgdwaIKLKr5JdQuHwyz96tBFu+vZD3qCp5z8b4hG8=;
 b=cM8N7bPnX3B5j5zMDZAz3tu2VnTADoHmEgD+EF/EFb8X86+qVCDmwXA9x/+7oaHGIk
 O/VAMnFoANKGK1YNpU6ymnLurkIupUEHZgFikSDbnftD/oiTD6vmSDxTvD7Nrss77fPa
 gmNFFG3gT8tS5LF82iAipYC73ClhQDTx02ljWlobFQ4Q2kyJ8Oxd6rhGA7Q9YORv4Zw3
 4APUPQUd31UaZbz45BMkoJfQdNdbZdFKi+os43XI6KNiBthMgVX7Z3p/YlQcr2JNbAhd
 Gpbbu9K0MY0//Ahgx2LuE06j8zdVoyXvp5l+3JDFCyo+0bGDHMKungBW+NXiezahwbHJ
 Dsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159172; x=1790763972;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=66DgdwaIKLKr5JdQuHwyz96tBFu+vZD3qCp5z8b4hG8=;
 b=f4+kTgAjJIoEOY87CTIVEybWpAHiUY6JW7hEapqyS0BAkfZClu/P7kD+QW5LYKCCsw
 ed0t8eshU+EbLZmyCUY2WxPeGvs3VEIvYgY+zbagT8OyvHkTFk36rgkJs+qFImR3Zbq1
 kHMPYGU49XJrF+T2iPf4IWFvv3wc6kUv9bQkjlN80TzjHKn1mUNUhHGSemC2BL4h1Dvv
 XZ2D0p+OidLkALV3mc1p8Di7vM0e7rWCzNYK/LpG83GJOZK2RPWhe5uI/th2O50BC6oC
 HtGf4tzRQmS1Jgwnmw8fJWTolW5L9RqoI2O3hYg7MXhsd0v1CSuMzralXJfZAqpwq85c
 eMqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWkOcMLm+iV2m0YcKFxfaZxtJdshYF9s85ofbkluH/IYAbv1lXJhCBEwCU2VbPXbF0nVA7Cv8RZSI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXtLH0cuPnXcwCySS1UdWpo4lKt6hGnZqeJaZeyarIsZcR8i8Q
 jTQEBoJjNyzQZbn7xpeBhQ1eM/MyOGyfH0R39S+GgVx2jikKeyQ7G/HMNem3WF2hwnhGbhK9fvv
 YwEUSQmnXvlZJCNZkz8f7IIoP8Eh+h94NYM2K9m463gckHbaw2E/Qathh6AvfAHNbt65EirE=
X-Gm-Gg: AYBFou3wNF7KJt+Rnbyd3ipd0NwUYGLyZbuE+z5EvWlOGITzUWSTTgC2iW5jjJktYwh
 9I5wYWj9GV9J/EHbXO2NYltg6uxl7FncFLSLTOD2CLaJWE+NveMhUzUFnK8zDHVTVzNRkXJvjIt
 8JXIxzKO247YNAwULQkzp4rjK60RIiJghjUd0/DRjITE3kDIabRDPPaA0sU9/7oGc1HFK/phHUC
 kh9rIfjvPa0XFkBBzmkpYvZRV/8sS3EynK46Z+htqWvnf1q3CLlOrMfV2l684ebtFx0fNHxMTr7
 e0zjFyuDkD6HxCSjOxw7MptuJQYhSczQIxjuKlKN5Z1XVgG7xlkVFKokIvoU+XvHtSc8UU3G0IS
 7UQdp/gXM71kOXLdI8gmunls=
X-Received: by 2002:a05:701b:42d3:20b0:144:c12b:dfc7 with SMTP id
 a92af1059eb24-144f91b1609mr2429669c88.45.1790159172199; 
 Wed, 23 Sep 2026 03:26:12 -0700 (PDT)
X-Received: by 2002:a05:701b:42d3:20b0:144:c12b:dfc7 with SMTP id
 a92af1059eb24-144f91b1609mr2429617c88.45.1790159171537; 
 Wed, 23 Sep 2026 03:26:11 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:26:10 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 00/15] drm/msm: Support for Hawi & Maili GPU
Date: Wed, 23 Sep 2026 15:55:40 +0530
Message-Id: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACSps2oC/3WQ0W6DMAxFfwXlea5ISEPDU/9j6kMSTIlUCsWBd
 ar494VQqZPWvVi6lu+xfR+McPRIrMoebMTZk++vUfCPjLnWXM8Ivo6aiVyo/MA5tObLw3mYIN9
 bia5xhZOOxfFhxMbfE+rztOkRb1Mkhq3JrCEE13edD1V2xXuARNVCrP4OiUzaV2XPfrFtqwMMP
 QWYOeSAksuysErogz32RLvbZC4rdBfLPxwBnfGXFUQbxDhhuS2VbWr9F7Je33oK/fidcpl5Ov8
 ZgXhFkFh7i07L2jbWqvesWbz8mpe//CL6c8Vlobl2Sr156LQsyw+VNsAIpQEAAA==
X-Change-ID: 20260811-hawi-gpu-05b4ecfc3c4c
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=4681;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=8sn4KZFE8QRPXBwR4MwJ7ipClSxiceJtkLWDINO78+k=;
 b=DsUz4D67hdyd6XPhezAI9uR9ChUrHnYx30Y4XAdHXd4aZeQA79Nt7T+MCqRt8t6EAUyeabGXU
 hpGX2w4WIaaDGrDGfrsi7Yh+rOAykymJUFViU4O1QFBbm+AJwfiZFBX
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfXyX+yes9uYSCN
 SHpF8SvYyFNgfftgzRCt+fz1nKYoj1gwzYqI88Rgz9fu9eNEkzA/kXBULyjqj2ZDftaW2JncUrw
 nnqFt7NryheJvJigU5H94a09vbOFlIYT0cGRXWpOmZRIdn6CHWtkLg5Uxi7AOCqcZ4Pj6w5AZcS
 j9t7mBuj9k0ad5fSqewkfFbBMrAWopkFEbEygYvSW0iBCE7Bsg+kjOQQsES+KaY3OhTDjL56NEI
 W3K43H8w1f/5E/+iLqLCvPLdZ5BNgRy5GkoBBKwk3oZeJwo2JItirr4RvnBJxFU8bhdueqjHVMf
 LCl35XAjAtQmYYU0UX3RZj4uThPjW0LoGD30BhKwWIcDLKsinhCePe6wSTODaXjH5PLrcw/jZIu
 AwMJNuIW2Z+B6rwvw+/P1q6YeWf8KS7f/Fgc4m/l7mqrVuMicCqfrXOOj95F3OPoT7Hmzrdy1v0
 bfZ+VXfnd8leMpeBpxg==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab3a944 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8
 a=MmXTpdYTAAAA:8 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=qNsRydlZyOFEy5ZRzesA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=7hoCnnChfAR1N-e-f1W3:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: Pnwjm64VTN8cW2976vdKRMrQwb2B17X0
X-Proofpoint-GUID: Pnwjm64VTN8cW2976vdKRMrQwb2B17X0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfXwf3D9FSnebbT
 cqKnA5YUqku7uIyLYsnutWzWx8Z1tHPpzpXSTPZXvhkeuArv5WM0l3cHvScng76N6K/DhNTpfuX
 UWDumACZ5JHVyFuL8aStLIey7G+Mrc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

Adreno 850 is the next generation of A8x GPU present in Hawi SoC. It shares
the ADRENO_8XX_GEN2 family and slice architecture with A840, but has many
architectural improvements. There is a new block Matrix core (MALU) which
helps to accelerate certain compute workloads. Also, there is a new Bx rail
that powes a part of the GPU IP. GMU is now powered by a dedicated GDSC
powered by MxG rail.

Maili GPU (Adreno 845) is very similar to A850, except that it doesn't
have the MALU block.

We will post the Mesa support and linux-firmware support soon. MALU support
will be brought in separately along with its support in Mesa.

As there is no display support available for Hawi/Maili, validated offscreen
testcases that render basic triangles, glmark2-offscreen etc.

The driver/dt-binding patches are for Rob to pickup and the DT patches
are for Bjorn.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Jordan Crouse <jordan@cosmicpenguin.net>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Akhil P Oommen (11):
      drm/msm/a6xx: Honor perfmode_bw threshold on A8x
      drm/msm/a6xx: Fix secondary rail vote in ARC votes
      drm/msm/a6xx: Fix RPMH dependency votes
      drm/msm/a6xx: Factor out RPMh arc-vote helpers
      drm/msm/a6xx: Add BX rail support to GMU dependency votes
      drm/msm/a6xx: Clamp MX dependency vote
      drm/msm/a8xx: Add Adreno 850 support
      drm/msm/a6xx: Send THINMEM config to GMU for A850
      dt-bindings: display/msm: Document A850 GPU and GMU
      arm64: dts: qcom: hawi: Add GPU support
      arm64: dts: qcom: hawi-mtp: Enable GPU

Bhaskar Reddy Valluru (4):
      drm/msm/a8xx: Add Adreno 845 support
      dt-bindings: display/msm: Document A845 GPU and GMU
      arm64: dts: qcom: maili: Add GPU support
      arm64: dts: qcom: maili-mtp: Enable GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |  90 ++++-
 .../devicetree/bindings/display/msm/gpu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/hawi-mtp.dts              |   8 +
 arch/arm64/boot/dts/qcom/hawi.dtsi                 | 336 ++++++++++++++++
 arch/arm64/boot/dts/qcom/maili-mtp.dts             |   8 +
 arch/arm64/boot/dts/qcom/maili.dtsi                | 309 ++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          | 446 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 231 +++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  25 ++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |  16 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  21 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   8 +
 15 files changed, 1407 insertions(+), 99 deletions(-)
---
base-commit: 1e9b8055458b92f9ebab6f39d97ade5265a0b012
change-id: 20260811-hawi-gpu-05b4ecfc3c4c
prerequisite-message-id: 20260923-hawi-dt-post-v1-0-e41473b6298b@oss.qualcomm.com
prerequisite-patch-id: 239c169e15da44519b2dad09ecd92f0052757929
prerequisite-patch-id: 6c586be864944bb1eed773e8c211b898bb1289fe
prerequisite-patch-id: f3d8748ccdb6760563f3e07f701a18388a9408ed
prerequisite-patch-id: b1639353868bed10fd3cbfcd01cfb88b7e737ead
prerequisite-message-id: 20260922-maili-dts-v1-0-ac2b1b76bfd9@oss.qualcomm.com
prerequisite-patch-id: 36f12c16bf9cb0411d8be2f396407c724162189d
prerequisite-patch-id: 28ede1ab83d4b5b56423ebb09bae74b6599b3bac
prerequisite-patch-id: 6b3e28c55c07bfcdca8bfa9219fa0c6c763c6f6e
prerequisite-patch-id: a2007fdaaeaf2981860c54ae5514f5a6f06c6bb3
prerequisite-patch-id: af8aa3c630647336bdaeffa9c88de3650f1e49e4

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

