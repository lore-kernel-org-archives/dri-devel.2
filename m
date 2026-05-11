Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A84CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BE610E8CA;
	Mon, 11 May 2026 20:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GEU1xxLy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UMeV/Jc+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D5DE10E8C3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6vjs2574326
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Zt0Wfud40//59YvB4eTabQ
 hvDuaqsHejQA1eTNLDMFA=; b=GEU1xxLyPdyiwXcFM3xamwzoVietPWRBRZL20+
 rJujlGDYZYpfhkLAtMPeDFiKX6DDIBRrfP105FgzBKwyHcEBggnC8FkbZeEnUqYk
 tR0Pb6/aWMzpUn4Ut2OqlsUoCFT8eB10uIjtY+OhxrDWwhvj4DanQ2MIwaaRReRz
 mpbveFghUbcn9QWcwW+cLP5XQqpDt9aIuHxPB3Jv/STo8Ot6bmRucju4Cw3tpcUK
 aDd4gLCLIZqV2vnB3UI46NRCxMEagQqJpwklflf/x6UqhBmAPGZEiGqXt3axbGCQ
 bpXC6nGeBRYuYBy0BOPtYqMe7KjpFHml2DB6+qqpcQrRMHzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv2803f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-365ff2ab7beso5551333a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778530045; x=1779134845;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zt0Wfud40//59YvB4eTabQhvDuaqsHejQA1eTNLDMFA=;
 b=UMeV/Jc+tttrSE7W3Qvt4+V3VyhRXi/fyb+oY1dxW2ruvcmC+xrXD7xmGteDvFdjbl
 cbOvZIPhJrL5K4Kcbxz7x7BjA1pg9XjnFplQ0P12LwQuGe9SzuA65E2Qjquyt7VCz3ci
 ijyqD/v2dpCwbTGCRM5js3esWIgcpgCYf+Zjz4eDm73l9lE5KWncEncEv0MXZbzQDer9
 yy3tGYSQuWfAiU+75upBCQD0ngfd7tMtuKG1/NR8mn5JcPcyMsQ0FXd5qZa4/Hz3Prxe
 7ioRAgJMmvqiEv3p7gKDV0UGTdXxjbt0F82/+mRRxNW5gIG0Tpxb7PBbkf20uzfh1MSM
 zSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530045; x=1779134845;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zt0Wfud40//59YvB4eTabQhvDuaqsHejQA1eTNLDMFA=;
 b=kqILPUJ6lzKxydef/c5XKBZq8KGG6fR+6VAqedSCszCIqSvERpTAOU4ogmlpbof144
 dck/vQ0lHyFwHTe3Ob2VyBVZ6ejKISCSZxE3RliBhnsXihIoLAMk/dYu6z+krXqI3vrJ
 JQzEbKZi2ADnPJKoNSbSmovfAPyIir/OPZMYCzQV6rXauNKvB2jYmxQpvbp5d8UrfLj2
 uqa3e4OWHp+CTHWkkfWsbptZHXK/NS+VEnjNIbJ0YhIuYhOwqKB7L8MZhI8uX0QoGota
 XueY2Fci8HDhk01GeHxpgE7xQB8fJEve898Z42W+TD0ZEdn+R0gBYBoLWRbYSt4mPRM7
 hB3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ka8F4B30p6WGOJxktj4GKMV2uJvbtIacgiaAXwvUAKWXEL6ndDoEwIoGhggIghSQ6dU2kL6hPx9w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkXKLjlJGWzx+rqG2HwBomCgOL3jpHHnoS1u6ctvvdPWm78NO3
 x6ZF0BX4ygEztPpzVGgXY9nAtJQWog95QFUdQ/wz+XMS9Z3JMIjxqnBlKT+J6pkJdZkihlwaZfJ
 lV6KBaXLPlL6eTc2/5DzGw38rthkrmRjavE0n2jBNXspBtqgHvbLnSJl9EEwBeje7kkmNPGI=
X-Gm-Gg: Acq92OHYIQ3tjl3RIk4ch+02TzymAw6b/rCoHk0yVFi82bTdtvKsBJ50r7J91NutX9i
 59ZN1fifAG565rHG1pW8SmHp0UFih0td2/Pg5iXW0Tio1cIOGT5yAhHt8eAt7YTTkaH6BlcPvuK
 iWSj14uc+m9brwPUzkLJXP++sypIFUAIOkGSOo2JZy7sJwUET6NDfKwoMQmTQttVQf78qv6hRas
 NweTyF/7eJY+B7cZTpTJIMaGlcjtA1UgT/m50gRGr9n60c6or59cWqsVOFTXfB2FUirhyvt1tu2
 yvrWQr0RE83pjhpCbl2/aDg89oLCnwcCJfT0MrGX0gb5XDclevNZUzJzr25Quw+x7PAFYUiMLvb
 dYzgQzVgQHK6TQ4UTDNIsQONIvRQguDFlOeR4s61kRmxc4A==
X-Received: by 2002:a17:90b:3c06:b0:368:4a6f:28f8 with SMTP id
 98e67ed59e1d1-368ab827fabmr720600a91.1.1778530045122; 
 Mon, 11 May 2026 13:07:25 -0700 (PDT)
X-Received: by 2002:a17:90b:3c06:b0:368:4a6f:28f8 with SMTP id
 98e67ed59e1d1-368ab827fabmr720574a91.1.1778530044585; 
 Mon, 11 May 2026 13:07:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b01ef884sm64911a91.5.2026.05.11.13.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:07:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Devicetree support for Glymur GPU
Date: Tue, 12 May 2026 01:36:58 +0530
Message-Id: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOI2AmoC/23PbWvDIBAH8K8SfD2LD9MtYYx9jzGCmksq1Niqk
 ZaS7z5jBoNub4S/x/3u7o4iBAsRdc0dBcg2Wj+XwJ8aZI5qngDboWTECJOEMYmn080tAU/nBQ8
 Jc96CIG2pSY1KzznAaK/V+/zac4DLUti0fyKtImDjnbOpa2a4JlzpZ062fgcxqjq0a972AiU/M
 3vnjOmH1Bs/j3bqM8OZY4KVMdAOlEh4YR8+xsNlUadtwqE872hb42hj8uFWr8y07rHjRDwclGk
 RGeUCNKVGyL9iBTP7RQShjwjbkJGyVy1EK7X+B1nX9RtvkDAifQEAAA==
X-Change-ID: 20260226-glymur-gpu-dt-339e5092606b
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778530037; l=3130;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qNkWrZGsSDaD6GrYCTVs1LnnBLeedST67BI1LcY7DLg=;
 b=Qb1B/FRS3gBmWvmRgLXggX/mx3UROYPBmpSOSybuI+G+3XRieCnKXv1FpLxhqCiPAnmGZmPGs
 76O2dUM75BVDdsCuSLX2q56jfX33hxmdZw8AMf+H3g+6x4wBUWVzGiO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=IsAutr/g c=1 sm=1 tr=0 ts=6a0236fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-08r9DDlpfC4vgu8VQ8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 4JmQeCWYNSZOJ4qHURsQuMQUfjYz_pIF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIxMyBTYWx0ZWRfX10rzn3hAtR90
 oKlBN5s6VZul40v7OKKlujHXtIb+kCxmabLKBleA9zZ/yV9lKdVDZpnyXIg6IW6ZrXs+4BkOyzy
 nh4BJUOr0uNYBlkYZzZ9LT+0hOZKRsa/bKjh58R3UGFxU+rpjhZgUU3OwnrVQwxByiMEk2izUhO
 LDewzPG2xoFiE4Zok+KTgimGxbaMFDsFFRFTZjmYFZlpwN9VzP9DyHGiNC/LMJwZtG7lGONvv5R
 X1nsF+NDCkxwO5b96DkBZTytbNDCY0IVqexkchCll+DkfquKWU7ydiGJiRnvizYf1s03Z5kw1lr
 fe72LhHWHpaCdYX8w06w94V1xfaSc5zRgGdK0nH4MhEZf/iUZexdIgBnMBgf5pLrYhGNwa36N15
 39GOJU7TWbn0QeX7XLdBPY9j5d3MQSd2ouV6jv99XqvfYP82CHybZPH14dqQNp2qf0iAkxT7oxq
 TRz0m4gFdKh9R5Ut4uw==
X-Proofpoint-ORIG-GUID: 4JmQeCWYNSZOJ4qHURsQuMQUfjYz_pIF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110213
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

This series adds the necessary Device Tree bits to enable GPU support
on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
chipsets is based on the new Adreno A8x family of GPUs. It features a new
slice architecture with 4 slices, significantly higher bandwidth
throughput compared to mobile counterparts, raytracing support, and the
highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
improvements.

This series includes patches that updates DT schema, add GPU SMMU &
GPU/GMU support. Keen-eyed readers may notice that the zap shader node
is missing. This is intentional: The Glymur-based laptop platforms
generally allow booting Linux at EL2 (yay!), which means the zap firmware
is not required here.

There is an update to the gxclkctl/drm drivers to properly support the IFPC
feature across all A8x GPUs. That series [1] is necessary to properly
support Glymur GPU:
[1] https://lore.kernel.org/lkml/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com/

Just FYI, on top of the linux-next, I had to pick below series [2] to boot
the device properly. But it is unrelated to GPU or this series:
[2] https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v3:
- Add a new patch to fix RSCC base vaddr in drm-msm
- Remove interconnect property from adreno smmu dt and the binding doc
- Add a contrait in GPU binding doc to limit the reg entries for Glymur
  (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com

Changes in v2:
- Keep GPU/GMU enabled by default and drop the enablement patch (Konrad)
- Drop zap shader node from DT
- A new patch to update GPU SMMU dt schema.
- Adjust reg range in dt nodes to avoid overlap. 
- Removed cx_dbgc range as it is already stable across chipsets. This
  region is now part of kgsl_3d0_reg_memory range.
- Link to v1: https://lore.kernel.org/r/20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com

---
Akhil P Oommen (4):
      drm/msm/a8xx: Fix RSCC offset
      dt-bindings: display/msm: gpu: Document Adreno X2-185
      dt-bindings: arm-smmu: Update the description for Glymur GPU SMMU
      arm64: dts: qcom: Add GPU support for Glymur

Rajendra Nayak (1):
      arm64: dts: qcom: glymur: Add GPU smmu node

 .../devicetree/bindings/display/msm/gpu.yaml       |  17 ++
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   4 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 221 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   7 +-
 4 files changed, 247 insertions(+), 2 deletions(-)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20260226-glymur-gpu-dt-339e5092606b
prerequisite-message-id: <20260410-glymur_mmcc_dt_config_v2-v3-0-acce9d106e72@oss.qualcomm.com>
prerequisite-patch-id: f7ab29f2f0241b6536d3b0c0593f0baa0e435221
prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

