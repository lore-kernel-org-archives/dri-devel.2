Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49BDC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF47E10E0BC;
	Thu,  9 Jul 2026 18:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YOeXpkQc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WWDtVIvp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACAC10E0A6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:42:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWvGB2502425
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YaJZjb4/KsYlY/fJsqYf4j
 +G52T7L/prfcMGCaKWj2E=; b=YOeXpkQcd515/k7FfWHfJPz3TfBY/hvqMTILd0
 tr5332HDoyPhuUAk9XCyEKxCOfUgLtR+dKMf2RuuBAvVFt9AaruwF2dh1fSDm7PQ
 y93MrsNC7RViX8TVbA6DHZpRRH7K+KLYmtm0nqW8mruLEOChggGUdITyOtlhzOmm
 z3CLBkIWsbOvXtKrP/jYCrOKVaBODQYgFDcz3XJ/tIbEanqzwM3tAIwxItGbB8PZ
 2ONR4aOH98nhROGtYVDXwLJK/rtMAZCrC0NnFfI9memi3br0RqSNbDFeTjezmn3h
 eq5aFzWUQ+Lgc6GS3nkmcqDDENGShYL0GCJ89L2Qq+YZlu0A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3ucqa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:42:26 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38ce7fabf76so266062a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622546; x=1784227346;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YaJZjb4/KsYlY/fJsqYf4j+G52T7L/prfcMGCaKWj2E=;
 b=WWDtVIvpXf/Eo6IuEI+ZD0X/JPn/RV6L5M70a1eYDUrNAnHaN80JZk7xdzJSCuXR5u
 4iETwx2yozlyR+gnh5uLzqrl0bXjLSRJofp9wxjV+pqqIkUAYmsitTXzKoTOTuMAlXHg
 7iuq0Yvp0VsgTjkPueCE8Jh73MQuUldbYjWqmDwvO643C6ZuDhJJBV1TL2EtdRO4X/zZ
 8dorzE2FocEHGLqihW5TlES/pbGozjHgcQ7vctXnrHVzJ0y4makxDhGWaSNqvsvFcgB5
 Knp48A+dlNRcP3bXm3yhdtD27BiZ7wVnrFWRzID0Nd+m/h/KOtSq9HH4CTpxhH+9gHOQ
 RMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622546; x=1784227346;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YaJZjb4/KsYlY/fJsqYf4j+G52T7L/prfcMGCaKWj2E=;
 b=H1eRcJcs5xCgDHXHMGKC6xKieFrTDu5Cjamfb0VdCn84CcKsYV1QLtWcILhGhTYUy0
 82a0JvTLNVdRjYrTxZTTqclagum4iUsOCznAySk0y0usSSWLnsY86k0RSFXWcw+WhZBo
 +2H6X3hAPdrg1ktz3GrQZz2kcdJC/OP/EDt/Oe3g1xELp5HzESeegcnLhBM63Epfj60o
 oUhuRqrOIychrr5zAGyFgJrYG8E8m093GJbuAyWzOXrRTm16BXEkIhpjpgwUUKetYfFi
 41dADAZUhwq/gxFsR8zSDYQVutxE5LF8vw1k9DiMxTV2HA9WsiJy8WozAmh3MaDx2mPw
 1Ctg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoyFwjljROkuQVscKVHOOIjk73v41SSdNuLVHLmgUGMOjJVk/Ccr4hudig8VlpdgrHS8Zczu14cNeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylmAIRM3vsLUunEXHeU7mNiS9xu9qw/HXUn96i1aKB+jn8rTwr
 3pz6hnuU0YNltbEydjSHvLCLYu2VxbfUDs2lB7XYkSxv+daKKqOIfO6+ju6xS+UtWhzAgME+exd
 XwjoKg2dPprtbZrH8Kyr0pMRiaU5txjVZR6l8SZ7ghxwvhN8g3cSG4S+G6wGngULBM3ZeJUQ=
X-Gm-Gg: AfdE7clXudiHcWLgwpHAy9wtmOPPauS7jaL2vtWXeI47ILuiNnQ5UctZWbwll9v+cyp
 lhLIbjYsfSBzkqUzQcchx5mJA/X6726WVcT/NnQ4Pra+NXtGasJZe042CE9uq+8aBzIoT19M4Mp
 5jnyhw/8t41TKK81l81QkpsOL+WTdAUOa7NWfXdbtFCJ9e4UPJ8Iens0V2E6J/+WEZJdo9TvWkC
 l2sMEZgdYnmXXuXTbd1L6ZLjdi0tGEFVt5nyL76/I1WldcqlnhPT8e2/dd8WtUt4+JfqChd4RE7
 bfveM/XczX6RsitnuLG1wA+mFDSbwkYgaMXP400k2i2tg+6Bh4fs67ux2b3rp4aCyas2ziHPs98
 BazKx8tPNtZmUVE+A0qN76H3751Bs2Sb/x5Y=
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3893f694da8mr9095582a91.4.1783622545881; 
 Thu, 09 Jul 2026 11:42:25 -0700 (PDT)
X-Received: by 2002:a17:90b:1cc6:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-3893f694da8mr9095537a91.4.1783622545278; 
 Thu, 09 Jul 2026 11:42:25 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:42:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v6 0/7] drm/msm: Add support for Shikra GPU (A704)
Date: Fri, 10 Jul 2026 00:11:59 +0530
Message-Id: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjrT2oC/6XUbWvbMBAH8K8S/HoOujs9WGGMfY9RiiydGpHaS
 S0ndJR+98lx0yZbCtn2RiBj/7i7v+SXKvOQOFerxUs18CHltO3LRn9ZVH7t+geuUyj7CgVqoYW
 t8zptBlc/7Pa1koRtYBdFNFX5YDdwTM9H7Mdd2a9THrfDz6N9gOnpVeYAtahtECysdy2A+r7Ne
 fm0d49+23XLslSTdsAzAdSFgEXAiAFIGk+x/USgMwGbC4GmGlpsHLWgDcMngvwQjJAXgpwE4SM
 4hazIfiKoc8FcCKoIASMZsoCB4hXhdR7zwE/7EtU4z7pqXeZ6eimNq0XPz2P95uMUS8c5u2OQq
 8XXtwA+mve+HnZdWf3jJs81WOk5ljSQmf6o4dt1UqF+I++T9/cbv+1jepiyhdqrxoYWg0Dy172
 dG/36qHEj2BkrRWsbMFJazx7BRafZspTEQhjQOl6vQpI4NZY67uo29SH1pzK0NRrJRivizW0JO
 IHZ/+ZZCia6CK1p5D94o8/DJSg8kA5gSdPNoP7omIPz82XCxrSERCjB3QzBe2VhnM8BCOKA2jU
 K7a2MEQBaCQVLCYiobOlrM6S87t1ysx9cSTr9lYVGqqUsyYLQ/2FpQafzybuc7x9pvvPkkUVrr
 GbT3F4Xno2qg3la0QI4b9Gg8LdL9C6lvCu3sPwIynoEfTkODeogg7qW4t3r6y+K0TC9vgUAAA=
 =
X-Change-ID: 20260609-shikra-gpu-5432bdeaf0f7
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=6935;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wLVLoWw0LrkKCLMJUXhrMcAXhPqqQDrohmrpIPaKs2A=;
 b=eg7gbX3vJ0spKkUvS8x/WuFZjbP101gjtKMF+X2+OX9S7sGx/9J7guPjXHYyvfLVL98RG1/RJ
 AMqkFJ+uKibCexHKWOUOddzNHPDPgj6gsk1i0IHdQb8MJkGH1hG9Vgd
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: Npg6V2sGYE-hzQU-paEe6WiL4NDEjTLT
X-Proofpoint-GUID: Npg6V2sGYE-hzQU-paEe6WiL4NDEjTLT
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4feb92 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-nh9RajweDyCoOXDqwUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfXxM47mEVGd2HW
 NsFL8jNmcj/n2oxdX6OPgePgBdqv8+8nCUCOvKJsRCZq03+0TDKv4N+7cEq57GlWvOcYgcRRqaH
 IIh7NgKTSHB9gvYCF6RyX+MTmoZ15DE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NCBTYWx0ZWRfX1mp92H2C8SML
 qgYtk/l0OQdV21A5VJN4/t9u+nchV4wX3kVh9ZJ0NnvlnNSDWYXky/8tidDcEf43powIr3NS94e
 2g9wj3z6ugzSWqzVJcDkEkY5khLUM9OcOU2mhXsn+xfDI9mkDiYfgT96Lz9MwvhyHhM5MePJwjT
 4X44mod3OJyHwAukdTUSnnL4+EP9tBNnE/CAkSywWuHt+Vhup49tEkGpiM+888Lv0ueOTJGZY8t
 bdEnZtYsOn8jSOanVSqu9E9N/ACNvUUC+7lZskBWXw2bT+AIgSp0zMwDmCtiptYDq6Q619cFq8+
 H/6IPCCawJdayNoFztyBSWZ/xAS4lpN539mIEq4bkAyo4J8AIlLpKf/i0tr3Eh/90Wu5sgMtrLe
 ZmDpN3fhMKEJchH+Gd4gbF4ebsd1IZBIJayrFagtmsIIAJrlsEZ/raw5yGREVHIiuBYtKlTNgFs
 Gb56J45LT6nlsEZGT6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
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

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very 
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Mesa side support is already merged:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41762

Included the DT bits in the v3 revision.

-Akhil.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v6:
- Elaborate a bit more in the commit text of gpu cooling patch (Dmitry)
- Link to v5: https://lore.kernel.org/r/20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com

Changes in v5:
- Drop dts patches and enable GPU DT nodes in shikra-evk.dtsi instead (Konrad)
- Update commit text of GPU cooling patch (Dmitry)
- Link to v4: https://lore.kernel.org/r/20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com

Changes in v4:
- Rebased on top of next-20260702
- Included additional DT patch for gpu cooling
- Link to v3: https://lore.kernel.org/r/20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com

Changes in v3:
- Rebase on top of next-20260626
- Included GPU related DT patches
- Link to v2: https://lore.kernel.org/r/20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com

Changes in v2:
- Add a new patch to document the GPU SMMU bindings
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com

---
Aastha Pandey (1):
      arm64: dts: qcom: shikra: Add GPU cooling

Aditya Sherawat (4):
      drm/msm/adreno: Add support for A704 GPU
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      arm64: dts: qcom: shikra: Add A704 GPU support
      arm64: dts: qcom: shikra-evk: Enable A704 GPU

Bibek Kumar Patro (2):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC
      arm64: dts: qcom: shikra: Add Adreno SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   2 +
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi           |   8 ++
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 143 ++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |   2 +-
 5 files changed, 154 insertions(+), 2 deletions(-)
---
base-commit: a9498e40e3e314ade387d3ab0d5cb14f0f3aa1ad
change-id: 20260609-shikra-gpu-5432bdeaf0f7
prerequisite-message-id: <20260608-shikra-gcc-rpmcc-clks-v5-0-94cefe092ee3@oss.qualcomm.com>
prerequisite-patch-id: 59bb0a7828e41f546f734f127d81da83c0adcda9
prerequisite-patch-id: 197da6bcb15cadc47869dba88c8020987b25c335
prerequisite-patch-id: 8ec9c1eb03f052ae232ed54117abed38672c23f6
prerequisite-patch-id: 350db4f4bcdfc0fad9ed57cd5b1723f85ad44f5d
prerequisite-message-id: <20260526-shikra_icc_kconfig-v1-1-c589db2d023c@oss.qualcomm.com>
prerequisite-patch-id: 028f3a3c64f57a611b6ddcfee947c56aa6251e3b
prerequisite-patch-id: e80ea7940b9817449cec21afa6e9e443e007166f
prerequisite-message-id: <20260430-shikra-imem-binding-v1-1-c6976239f90f@oss.qualcomm.com>
prerequisite-patch-id: 80d8ab865b7b0663c5b2878b45b55e2e4fde9c19
prerequisite-message-id: <20260501-shikra-scm-binding-v1-1-93d7faf1b784@oss.qualcomm.com>
prerequisite-patch-id: 8e645e1c6ad6182de4813a726c293654324de1df
prerequisite-message-id: <20260501-shikra-tcsr-binding-v1-1-0c136d193634@oss.qualcomm.com>
prerequisite-patch-id: f6781d2cf0829ccb32f1400623c95739972f2ee2
prerequisite-message-id: <20260630-shikra-edac-v1-0-287b3233241a@oss.qualcomm.com>
prerequisite-patch-id: fb821179cbe1fb1a97b987d04acb5a656aee9c14
prerequisite-patch-id: 1981818fdff444d3bfbe15f5f52a654a73b91c81
prerequisite-message-id: <20260611-shikra-dt-v5-0-103ed26a8529@oss.qualcomm.com>
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: e9f8fc7688e5b366cfbd2449856c0aa524424051
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-message-id: <20260701165051.4122259-1-krishna.kurapati@oss.qualcomm.com>
prerequisite-patch-id: 0cbcb69abbbf83da785619c266c96af624c38a87
prerequisite-patch-id: 1d1ae48f09e537312052f93bff8d04093addc996
prerequisite-patch-id: 6126fcda921fe53b86b3a18c649fd8ff2e1f43d8
prerequisite-patch-id: 3a0482207e363349423f81ee7589328a84752de3
prerequisite-message-id: <20260701162745.4043106-1-krishna.kurapati@oss.qualcomm.com>
prerequisite-patch-id: b4d2580ed983cd0262302ad93304dbe5398e5d6f
prerequisite-message-id: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
prerequisite-patch-id: b5d7f75df02fde56181f576a936baf09d0a72276
prerequisite-patch-id: 3ce52e07ae57139c2e2b71a29ed7d7250f6fcc87
prerequisite-message-id: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
prerequisite-patch-id: 48ecd66c06c4fad81f91283c26ec57d95bbde29d
prerequisite-patch-id: 7d92e5a301d09616840e54dc9e4a81f30a64383c
prerequisite-patch-id: be1a16f53e23dd5ab90210a056c9da3559c6186d
prerequisite-patch-id: 3eff04500c55100c763aeac1f1f8c5768d500500
prerequisite-patch-id: ab22c5fdb2fa65b78ffef76bbe4459c8d5ffe7b2
prerequisite-patch-id: cb24efedb648271ef5c60ace96e2366d89254e8f
prerequisite-patch-id: 8be7df0395c5847a988c7e814c7db878b5932b11
prerequisite-patch-id: 0510992d022cef7317b6efee6765ac78c0225356
prerequisite-patch-id: de4327fcbe81f92a337f429b74e8220969a5b79f
prerequisite-patch-id: 968bffc36646412f8289b917f37e762a4297bcc8
prerequisite-patch-id: 35944403bd4480caad12657342da15ea71c6afbd
prerequisite-message-id: <20260703-shikra-dispcc-gpucc-v5-0-cc13826d4d5a@oss.qualcomm.com>
prerequisite-patch-id: 23b24fb512c882a045ed8339b22269bfc2c5d02c
prerequisite-patch-id: 0e79e46bc5a88849a2f0a410b39c08f3244dfed3
prerequisite-patch-id: 17b412a37859fba801efdbe451db31e5bd77438b
prerequisite-patch-id: 0396ac157aba73a5afd7ba4a8a744847f5a7b433
prerequisite-patch-id: 2b1aecd97b9c073a1b323138cd7a98cb34e3715f
prerequisite-patch-id: 823bc7bc713f6fce1b9de47a266307f1829636b9
prerequisite-patch-id: 1b990e46422307e558300815c1166b90d96fbb9d
prerequisite-patch-id: d78e0b95758b82977d80c7cf18da49661cd181e5
prerequisite-patch-id: f62b00cd64ac3191e0906514443dd43e88746818
prerequisite-patch-id: 0fab99455f954a917fb65348656505cd7ab45bc2
prerequisite-patch-id: b59fd05f9b62bda86079c9d86538b80289110862
prerequisite-patch-id: 71691d8b40e36cdbff6a52c3999ea8bb2c164d70
prerequisite-patch-id: b2868bc50d74afd13c8a0d0fd62301fa9546a211
prerequisite-patch-id: f83f24719ac475317507af09bf08b4a69b02d429
prerequisite-patch-id: c9f2942207341ad4f450b20f049199f35188c02a
prerequisite-patch-id: 3a6e9752793f2d7b084008b47daed10ea572064a
prerequisite-patch-id: 3338cdc5915c1e6b991067d3a7afb734c182663e
prerequisite-patch-id: 59cf68a3a49958a60833aa0464980f8c8d879961
prerequisite-patch-id: 5d146a518f2f76bf9fe93e23a2cfa63c73731883

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

