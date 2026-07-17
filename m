Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD8FC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0083E10E4E9;
	Fri, 17 Jul 2026 20:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HW0ZOYY2";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJenNFo2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D1D10E4F0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:51 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJteSK2906453
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=sVH+YK2y1vG4lsBrivCXnD
 TuyI7sx5ytr7WDEkhCxnA=; b=HW0ZOYY2FpGcSHpEnfmuVuVyl9JGzmftZEOCaD
 DsPsngIbXbdhA2BGmz7sYPEGS85X8TT+PrP63hasVtmNBcfIrxQPKe1OweE6cB0y
 UZBkk5VqbXoAgBUN8f3zGdBpQbzwVtlQjeys1cqOQKK6iK82SMb2vtBoSUARukYE
 VZ6uWk/mf6YOPdDbB0Jv4SMQbE19eWNZFdLlGrlSGH/Nkd+eqw5FqyjJOgPo5DIG
 tza7D2JwV9v9GT/hcX2om3TNECdCCoBXVMFRKPOcvMhja9Mzo+blHVySnLrNJX0/
 VUM9EzkUB6lDaCNV7mzpqoLH+CGgXAbepodZX/stvLNr//OA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrsq8qfa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:41:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e095fd889so9693564a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320909; x=1784925709;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sVH+YK2y1vG4lsBrivCXnDTuyI7sx5ytr7WDEkhCxnA=;
 b=FJenNFo2G2STCdZZaAyV6coM2d+ZMDl8jrw7K0qlFR195y09R7lYYp0fAyzFecztdM
 uUTtK0cLXqHUlkXQWXZzSyKWcpv9l5uFX+02jkzmqCLCI//ZkN3CJFqyUOrkflfajOPf
 HOYcDr20W9GVqRTb1x0JrESyG1Jc09YsiIQtlgPTxg42vdF0lTySYZeFspMGzzHe3kCq
 AXuKA2nNUncsYr0doOPQvkBDkP17Q2abmSxtmHhrNNZTL4vlcrRuiqUq2H6LG5T3C4xR
 iyswtACn/8AicjQPLaIh0HbSXr2ebSBW3dVGofuhRA/io2qiziFOtKUDaA03Ym7NBFKE
 Fw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320909; x=1784925709;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sVH+YK2y1vG4lsBrivCXnDTuyI7sx5ytr7WDEkhCxnA=;
 b=CakKGcPZbbep0Cy/CG6mbM/580jbf9iNzQ9uTuDXnLdK6PYIQle1KA0t/FyL4QQFCe
 X41Ix3pwrUwmsiEvWb/iQJa6rggUE/MWkpYGphOcXhKrUWJuJTIjDKQKhgDSt7ZWgc4A
 E1wW2ZqnOD89yoSCzB3x8mC+loXsrpXCjTuC2kCkbCZPFtKq7h8fBWY0x1zCKgfETPOP
 kuZEHYIKjI6wEmfZdHzBNXZWg01RROuv5r84zYm7bEY7zFXua3dKrsg6Btnf64OhYOv2
 N4RC1Wj5TGwok4a6wc+Y+djwsJlg4JcgMk9GoOaXO8omYAcSOlSH40ZQ1cR34mTr9pI+
 KsVA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs+WoCcNKzq8kttHTHfIC1sA8+ka3QhMwWUutTHm90SAllKMynSuiWMkxGgWej0KSx4RTYg0K/SvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+NvPnOxhea8D1CgCC8NEO8gssidTTxwwVBwEbRMM+WrbjKDYM
 7s2sLEAbzbnHNb0yJIWT2GtZj+ElGm0Lp6Ddcdr5QHwyEshzSduPvcdbDQOvRyCxd0a7QHGNyGM
 R+0hZYO2CXbvLsOmXO7mGV3lDxtprPZUfP6pWCqiX8i7YmdgWXoUj9m3ViBrJS36LiUG/aWU=
X-Gm-Gg: AfdE7cnEW38j51GKisi/7cEfen8knujG816shKerQX8gyXl9rXW+jjGKaCYRkIMwery
 7W6gT0Wj4NWJEEer1xIQ8Z5Bh6u/DhSi9HIrBgHRSi9Exbi2ARtH4go1zZFmPqelf7cvcOrSHGu
 D2EQJxqgJGW4+9A7ds/F11zYA/FH32LIZHbZyFLB/E5AKC7wNymOZm2n6mV7aajJaH8aYv/P7l7
 VRoQdTVSyKjqMMC2Geg4iv7gq+ZwnhAf6f3u2FnqCpW1yw3wULl72yWVBOe7fBTRD/NCxtcJOVW
 oKnt7+jhNPhPseEfJvF+bvVwRIjA1IqXtez6jkXqtLDsgy85p8UYea9qNl/YisJgcYYUR/SAbq0
 WJVhCE026iLetg5rYezd0f4rw
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38e4b454d1cmr4623516a91.10.1784320909233; 
 Fri, 17 Jul 2026 13:41:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1dca:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38e4b454d1cmr4623483a91.10.1784320908803; 
 Fri, 17 Jul 2026 13:41:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:41:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/9] drm/msm: Support for Eliza GPU
Date: Sat, 18 Jul 2026 02:11:25 +0530
Message-Id: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWTWmoC/2WP22rDMAyGXyXoei62m6Q4jLH3GCU4itIa6qS1k
 tADefc5bi4GAyH4dfh+6QVMwRFDlb0g0OzYDX0U+iMDPNv+RMK1UYOWupQHmQu6uKcVp+skCLF
 TJi+x2SPE+Wugzt0T6+f41oFuU0SO7yI0lkng4L0bq6yn+yg2rF73PTHbZFhln6lRSiOazbL2v
 kas51LEkEId2k4aKkwu8Xtg3t0me1nRu5i+YPU/Ox6H8EivzSodsNkVf76YVaSh6dS+yNum1eY
 fDY7LsvwCx3XanCkBAAA=
X-Change-ID: 20260704-eliza-gpu-eccf1946cb3c
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=3090;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=6VEjrqVhr7MezwfVHfIVDsIN0YyS4xKPQEXFGvXAkd4=;
 b=SNwxy/SDmWuwEjIaqCpTdLVsE7jZE/sH0Uta1x17D2avioGP0wvW5JmMtKbo/r0IwoMsTchaW
 sdJOBpo6jhuBxTd0mN2Iwym1w7M71JU8qdNIuLFrokRXTF7MmACLhLE
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX7OdzFaUY19/V
 AnwT3FkIMyTDxbldHfJoW64sIn8NgadH/Q/Fjl3TGrXjQyXj5kmzy3qF4A4fbw8ieT3TWP6V3f8
 GhV+S5UiqUwO7MtQKh49+8Jdg9FRrm8=
X-Proofpoint-ORIG-GUID: ry7tc9CSxyE81_pX9Qm8yAh0wjEovEkD
X-Proofpoint-GUID: ry7tc9CSxyE81_pX9Qm8yAh0wjEovEkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX+XMwIphNtWbr
 GM/G1o1b77ZNt3/FdiT2v26f1jzUyjiNcdU+6Z6Fs4RLwescPKs65KSIHA55UH419hsR0/cIBsU
 +3mc41VAdcGE3AsTt/TCM1PDsVW4fTjgVGSYYOn1fKxomVfoMsbR3iovKzOEB0C2n19ybQVxEKH
 rXdzhFJec6xwuQM8qbcz4KANG/AsRYk1FK4tAfNu82nAlXxBqJtm2eypaoxwlXKaMOFTHPCdxIo
 ftnHXFUGoS4YjGygKY8uEOrmLaI+3D5Ql6GYRwtvuTgilhxZuHlzsDgxPvFno3QdK1U5UHeVDBx
 nHr+SDnqfWzf0Pshe43g6+0cGp7NGtLqRxrg5NyJ65GocP+f+qLP6HW/G/tA6M8GXvuZQLcN8Ly
 CYc/3AjU7Ba6GeE0Q0SPrhUPzYQxBMo6TzGCXy0SKJ9lDJpNtZU2F7fl44osdMXZsjd8CpwKeT3
 o+dh2lVSDbUz2otyuwA==
X-Authority-Analysis: v=2.4 cv=OJIXGyaB c=1 sm=1 tr=0 ts=6a5a938e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VR85YU2tW1KY0NdMjCQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170212
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

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include smaller cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

The first few patches that updates driver and dt binding docs are for
Rob Clark and the remaining devicetree bits are for Bjorn to pick up.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Add a new patch for GPU passive cooling
- Rename firmwares to gen717*
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com

---
Abel Vesa (1):
      arm64: dts: qcom: eliza: Add GPU SMMU node

Akhil P Oommen (2):
      drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant register
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

Gaurav Kohli (1):
      arm64: dts: qcom: eliza: Add GPU cooling

Puranam V G Tejaswi (5):
      drm/msm/a6xx: Fix RBBM_CLOCK_CNTL3_TP0 value in a730_hwcg
      drm/msm/a6xx: Add Adreno 722 support
      dt-bindings: display/msm: Document Adreno 722 GPU and GMU
      arm64: dts: qcom: eliza: Add GPU nodes
      arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |   1 +
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm64/boot/dts/qcom/eliza-mtp.dts             |   8 +
 arch/arm64/boot/dts/qcom/eliza.dtsi                | 209 +++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  38 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  17 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  81 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   5 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   2 +-
 .../gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h | 428 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   2 +-
 14 files changed, 773 insertions(+), 30 deletions(-)
---
base-commit: a9498e40e3e314ade387d3ab0d5cb14f0f3aa1ad
change-id: 20260704-eliza-gpu-eccf1946cb3c
prerequisite-message-id: <20260609-b4-eliza_mm_cc_v6-v6-0-17df09e5940c@oss.qualcomm.com>
prerequisite-patch-id: ecae5e45a33a79ec3f500e3f318e3a0129fddfb7
prerequisite-patch-id: 19fe32e5af810250eef42dab488c982ef70c055c
prerequisite-patch-id: 60dde5421adbc86f355b4899bedd0d7a1a0c4e5e
prerequisite-patch-id: 58c9dbb18795c662ea22c3a82b07d6465f604e08
prerequisite-patch-id: 0c6e220ecf2b42776f990ea5b98ba4ee97d229ee
prerequisite-patch-id: 0e0bed1091d12c102e2542b1c2931f61a543f2b0
prerequisite-patch-id: c0f22b4ff0bb79935848dde50c524f6063011ebb

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

