Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01CFC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115D188CBF;
	Sun,  5 Jul 2026 08:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KsFB6ywt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Op+KVVTC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671C588CBF
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:14:37 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6651jm2L391370
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Mmu9NS1f13WBdz/LPDqPCJ
 b63FFDMcYOR5yWaGxSv4I=; b=KsFB6ywt4epudRYYTWTMSQw8+mpUkjXrF+Lfvw
 QpVQMQhh7zKPQ+GD7fcYQF4MdsQGJwDBrZx0zZ96jaj/PvF2/hQov+NVHrybgudb
 th7LHRztP7xVnZ56IiCLaDuXkYDjDAUK9Afij97RvN+E2MF49DV2ENABIUHX7JBl
 tgK3JBHvr7RAc36R+Cs20MQH1ZV8MdvoRabm0JPmnBP+6Wc4xjnlaTf/oXJ5TD8f
 0wxIw6Jbgr7in4Mm7QWFdry8lwhmC9bI2iUlUEwFhFFStbtPP57hSrAUwa2pavhm
 UG+yFV0hVUEJCk4wMr/Xa0H7Pp/oC3xRtR5C6+PWlxM6rDsA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6sgh2dng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:14:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c354050c34so19938325ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239275; x=1783844075;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mmu9NS1f13WBdz/LPDqPCJb63FFDMcYOR5yWaGxSv4I=;
 b=Op+KVVTC7wHBFH6ECZJhnSuuaBBRrMRm2PIeVB/cuEhrONlG4XXA1zQdE6QQwYgoiM
 gI1O8joAhzVIqofVeHFVnBb1P41mAng6Rw84y8UNBJhuALbPgK455ua+RZZvAdztzzsl
 Xa4GeIq2MBTR4WCNnkyaY+A0UvWIeGSqzk+/0wp4263dozFyRZ9leEZOp0mrDEJ+jNPJ
 QG779VrIuwUNhM77qVy5P56Q70T3uJ9j/DWkC4mDNzYAQ0rf0WWuVpFqB24cdQdA/n1f
 R/JzbV4+DrQft7cPjJCrnzIu+8GQ3Cvz3w9irguegqmIt1yNdWzekeKijzlnqCDFb7xW
 DfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239275; x=1783844075;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mmu9NS1f13WBdz/LPDqPCJb63FFDMcYOR5yWaGxSv4I=;
 b=q1Ezyg/iXne0ytMxHUNLnt5TGgKCZsOEQt8s++cePkopjKvJIjLqbNC66hBPl4RAro
 OmSI+YcIcUbdySFgTlrspaVLX7SAS2aqQbeWDbs8qP/PDefJA+vGxkRNA5x40pSd6uX1
 ghdRl9vhBnk2z0FCX/XFNjO9DGBPLGt92jhDBv7mIenzVa6lFjOHslhD/LrG3nk80ZDX
 kJnxc1q9p+tzulPHtCw9LEziTtrUb6dV8ZbvIJckynKeLAQdpQVbRMOGBNFEkVuTs0U4
 IZ4GT8GDyQiryuxIPVfphn0SCfRf9mzhRE+pB2U3Q1REuMPvVepSbkiCmum9Ee9xFk0o
 +Xmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIFYl4Fxnt0XMqgqadwCSPncvLPh98FrCZF0DYM/jDMQVNCqtcxJeF7TB567KKuJRIa2FJHQgEAUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzYtnyUk1WzYKkNQbOT1yGwDXpdab4Zar6AvEdgZIcdBfmqb3CU
 klzpvq2W9l2WSZfeEoUcN7F3BCdlYfYYwEsvTkrNHYKTPS6Mj3+ibK8YiuuNTiwf96lEaZb0dte
 OERvIu3sdDdd++o7h0JmDzaru6Cdr9gXA5bnvuiEZA0BYIa6XRdmXmiCSTV5sqOXzGVGXcBg=
X-Gm-Gg: AfdE7ckVwByrmkQ2kHw96HtFubvrnVNm7s0R2ORK/TyqLifYx+bCTT0Ub+FhzKDUjR0
 IFMVdozsc1RLiTbd3brlNyhJviV7cFcxyAhi/bDGLEhIFiFSgq9wzjqO+c0h6gBL4vf/yzoa85+
 Az1yt5NyELkY94LClPiMGwFCruJzFMdeu7eISptaRXfuMAtr1fz8qnOPpLzbNgTcZOSObV7+dTC
 NzNNRUYNG4z44psq3o8DmaoVKrdIa0X511Y6BoHZQqop+IqfOYmQsWZxH3NRFvbc8DEcpzWKRbn
 hmyOu0q3zyyHroj8a9WzCj9nKJqtC63ksIMvv3ltjZ8eVLIwDg4feXQTiRTHRoGWqMoI3J8mlhj
 sVBB0i2MZy0ZL0aVV9FJpKjj4qYmK37fB6DE=
X-Received: by 2002:a17:903:2cd:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2cbb9eeb474mr55795685ad.42.1783239275120; 
 Sun, 05 Jul 2026 01:14:35 -0700 (PDT)
X-Received: by 2002:a17:903:2cd:b0:2c9:97a7:b1eb with SMTP id
 d9443c01a7336-2cbb9eeb474mr55795445ad.42.1783239274618; 
 Sun, 05 Jul 2026 01:14:34 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:14:33 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/8] drm/msm: Support for Eliza GPU
Date: Sun, 05 Jul 2026 13:44:15 +0530
Message-Id: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgSSmoC/y2NaQqDMBBGryL53ZFobUQppfcoInEcbcC4JCpS8
 e6NCwwDb5b3rcySUWRZ6q3M0Kys6loHwc1j+JVtTaBKxyzkoeAxj4Aa9ZNQ9xMQYhUkkcDijsz
 d94YqtRyuT3ayoWFyyvEcskJaAuy0VmPqtbSMcGnD/V+TtfIITL3nsRA8geKKzLXOEfNZgCsOQ
 VxWPKFHEnF8d9b6wySbXe279mLZtv0BUyuNi9sAAAA=
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=2808;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ze1VllbOqZnKEAM3Tp176IzqqLnZ/N83LBmJnq4dOkM=;
 b=9a9GOk9tVX4B1OGU6WAqIUkEf1RpZhendeSNrLU98rnIfNAxFU45RsIYy6SGBU1u/wg9t8oic
 STHhe5reKfWAdXRtit78WKmncVmmgtFAsoHhpnTcMDyGfm8Scoe32zi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=bLkm5v+Z c=1 sm=1 tr=0 ts=6a4a126c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=bIsOEyWjDz43KqZfDzYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX8TCcfeMzN1yF
 MTCYH01FX8PcVMd/mCXDkxXNm8+jHs20JGbyyTGrOgPJV5+PWyVVd///6fB7y4mLy28Y00Qh75C
 ZD8Bp+RrnHyBWBllAwKZZUMrq8WEvxLABUc6cB6Bjyt8VfDDukhCbsPcB7GW5UVhGeYmCH2viyj
 0yHwbVXGHOLDC97JXvo7Svu6SfewsLUvk/+3lpsE6xKxHPGg49Qs8j/mecywAPVBbsDjKXbJH6n
 V3p/I9fdXHhEI31nKzd78ntfkCC968/n4z1/WdZN4Fpw2za3MlkjdhZi5nQ3ymN/AdM9iDCZUka
 i76R3CbDie8gNPt7WC6udn096peYT2V048Vd35WM4tAPjrWinTRKyDlM6Mg9/G+l8mxU2Ybd2Dh
 uIheFQ1xqoGXakhk1U44maRrKIH2oHAv3p3iE4aZ+/zmIaLtpmauTaO1bM5Rcr6gaxrzZWZ/q+m
 x+GIAKOuQkAZjdjkiAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX8zXrndgxnw/f
 G7mJpa1vwFsEnvcO8uRWIvtFSQmVCY+Wz2cg9+FZSvgxdWrbwbBpHNpvE7cNTqlr5Os5X98GKkD
 Ei0l95eyAjcJWwzrWbv/nxK3NWOn6W4=
X-Proofpoint-ORIG-GUID: 7gv46Ft7Ef2ZaJUy2I7DX-ZNkDttDG3p
X-Proofpoint-GUID: 7gv46Ft7Ef2ZaJUy2I7DX-ZNkDttDG3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0
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
Abel Vesa (1):
      arm64: dts: qcom: eliza: Add GPU SMMU node

Akhil P Oommen (2):
      drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant register
      dt-bindings: arm-smmu: Document GPU SMMU for Eliza SoC

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
 arch/arm64/boot/dts/qcom/eliza.dtsi                | 190 +++++++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  38 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  17 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  81 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |   5 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c              |   2 +-
 .../gpu/drm/msm/adreno/adreno_gen7_17_0_snapshot.h | 428 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml      |   2 +-
 14 files changed, 756 insertions(+), 28 deletions(-)
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

