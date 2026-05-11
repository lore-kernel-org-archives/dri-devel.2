Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFC5CD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A1F10E20F;
	Mon, 11 May 2026 22:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="evefXYKD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DuonvhG1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBCD910E20F
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6cdJ2186992
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=vmbVJwi4WaTGTVT0i5299u
 LCIqKpaUV1SdNvk7Z+siM=; b=evefXYKDR58EE9T3OunshXF5Ag+pvmQjvcM4kQ
 /C2aQdBk4x4t4yp0Y9EvNxSWgefhejdByw0vrsLyZHHW31twNC1yTVo2FNmJI+3T
 1n0zWuAhS0srW0llm+bufiJpv3YLW+NZJtyUl5lc+Y4GOm/4zPTTfe25RtmJCLyg
 Oie6jsmKMjWuCLoiZ2GhbDJE7sU83vxxDb9YM+q/2aBCkpFIDAyZEc1Ei2m5SamM
 S6yHKLWU0r+KVpWWOFYwZoAvCbe1jbpJ+60mdXuIXcIS/GpzVcGBYuFc8hrUnZ/c
 eWFnkEyDH5hbBE1fnwcI8LWMTqEKXbUZq/Ty24gV5U/JUUSg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0rf3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8397b14a689so3041550b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538214; x=1779143014;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vmbVJwi4WaTGTVT0i5299uLCIqKpaUV1SdNvk7Z+siM=;
 b=DuonvhG1u9GgUqYtbHs92y7nA6r8kj8GdY0hqG/q1aKYh9LGzFU0gD2L0BfpmNk/Wb
 Nc1y26cSojjCf7whff/9qp6JgLm+jJmi3SjllLu9Yef8BH8n/6HlHTExXARhNT0ImnpI
 Uj4jhb6PtRaMPIt97Teaeyl66fkcunha25YwhUMMYLA0560OJHvkr35hTzIcJPG7eytn
 vdhRepOJ1YWJeSkD/rR+aJSAkzhA3Kbd9zOSc7C7IcEWy8xL5gZTOzJmhbgx8L/7JF1q
 Qi1HfjYgjH0YU4nwwmXT0Fwr8TXMrenTriDNt9C/g5mIKghJCupJDzXdfldApmEaoNrO
 Nn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538214; x=1779143014;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmbVJwi4WaTGTVT0i5299uLCIqKpaUV1SdNvk7Z+siM=;
 b=jVUyUIouTKmNFY7EakperC96j6thp3KXBAI0ONlqjs12hP14U66LImX5Jl77v+HK7K
 8L7nLQfGZ5Y3wWsLjEeHydS22MTuT1k+8hXJmJlAYvQod8vSoJjamuFTyXyRc7V/OkoH
 md8fA5U6FCXDDifio6CPFSaDPnHaOouAZdCq6eSsNp2uGcyztqVUxgbFYEYpDQeHhtlS
 BQpxJOSV+kXYDD/7LwY3FyEZU00elRljdrzIYBnwCD4Y1T7P+r5josJpmuqnlmtjVhXx
 grJnQ7V72U/lVp3q7kZ6dihX2LJj6Sw6QdW8aaAaPT40Nx+OO4eQwFU5eC44fCHa05Op
 I0nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8A5rs6wU20lo3ZaOYsr2vVYp0mjW+8dfP0MpegQaqok0iGU7/K1rfGzIsXPJR4Hm8paP8XSSrpXoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsGzXGN+4i0mojmv4Se3TXFfWkn4A1Xp40my9beV2dAqm8hOTh
 HC8fsOITpN678C9RIIiTdDjGt0bUjtJp8TKV3FZDnKEGCcTvJ5tVbGbVrwQ7R0S44dWDfO303LO
 u+OCDGWkAtsZ+/UUC1x3hOWD7kxycTBdaDFZEfj4eRWhVTOiG1NJURnE8QThh+QKQMuyrn/Y=
X-Gm-Gg: Acq92OH2cm2EOEGdXxErwluERN9inFT9FLOTnr70FEd7JYZLHGGbi3s05AiAkpHqFhD
 p8nJ+TCQOQLwFKxdzhkfxJp7B9P0cYjcH9Yod/fblmctgPeFkhjmWkCMsNMyXJBmkWJLHqCwHxb
 oL8EnCFS41gqbiuM+Cs3IY586JlQipoSCxsLggv4WsZ703UGyqce+bsG1c2oNAbpK8nvLGwEEM4
 wuDjUO2RcBbRGk4omrBz9Q8rx7eJ5S4T+8cg1zjpu5JhqPiTTwiXDkQHTqdzRYA/M53xCX5O0se
 xrLnVm00W9gwCryhDWCBfz51wmEAvZ1obCeGrWj32oguqtMsrezTTWwH3TCR3khsplC2iTQwIK3
 5oJTUj/QEldl42ZwUkl+U3CNf1B3yPMNAdHsn6tZLDgUkbg==
X-Received: by 2002:a05:6a00:4f96:b0:834:efcb:12b4 with SMTP id
 d2e1a72fcca58-83eebc25edcmr287567b3a.28.1778538214336; 
 Mon, 11 May 2026 15:23:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f96:b0:834:efcb:12b4 with SMTP id
 d2e1a72fcca58-83eebc25edcmr287547b3a.28.1778538213840; 
 Mon, 11 May 2026 15:23:33 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:23:33 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/8] arm64: dts: qcom: Devicetree support for Kaanapali GPU
Date: Tue, 12 May 2026 03:53:14 +0530
Message-Id: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJWAmoC/22OywrCMBBFf6Vk7ZRkkj4sIv6HuIjpWIN9mbSlU
 vx3Y4s7NwNn4J57F+bJWfKsiBbmaLLedm0AsYuYueu2IrBlYIYcU64EwkPrVkPVj1AOsE9znXE
 hlUFkIdI7utl51Z0vGzt6jsE6bE921Z7AdE1jhyJqaR5gNSc8/+Yb8l6vnUV02Coxg+o2g6kfs
 KphQuCQ7TNK1FWWKlWnzvv4Oer6q43DOf5XJWF9Vb+a0f3mTxIE5AollgaF4fKP6vJ+fwDNRLh
 fJQEAAA==
X-Change-ID: 20260412-kaana-gpu-dt-968a70134c22
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
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=2499;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=oZ+yt/RXidFRbw7KkVC6QwWQB7cStOb9OIQ+8ARPiNA=;
 b=z4wkKaTXNXkeDYdY4GxGX/+MroUPOcH6t63HZ1+4kb1hAZt+BGI/ky1jTgoA18Fcdd3BMaoDx
 M+k9TYb3CyQCVJ+t9jflHnoB2osAaht0heuWefIRDO4XXuijct4UNzY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfX5TbhFLJ72K1k
 /fpPJkGNdvByBNKEnOjgKnM6eClrAdRHePAta2fIMdL43inqghpkt4W5NvXNrnGtHTdOInhb6lW
 7GVrMhb86JyKroVCknzJgwBvZiMduRd1YSVxHxRXnQr7+HiE5rxL5IOWV2E1aGXrrJU1YpLVb4p
 4sTuiGrzisMXbDg0dmJ0bNiXkCQZqNgXh7Y5bBV5Yirgl1q+5Y7LT/k2e+VuqCrS4noMUXPSCDD
 JnSq6Ul7frXiOMy/XjQQrpUNmKXTP3nU+xqbs7MQAC/T4Gvm/5z4cHEn+9wUjl1ve3QdH3zGYwK
 oZPLYrynaPSwy6LmQh4cyXs/jcKCHC4A9AAjk2rNSd5Q2jtUEVUDje1F5icxmtlQ3aRh5WpvF1u
 OY75Jmm4Ha7NQGutYdHA4n+jNNnHlHmlayG7gTlIJHOXniz8u1o/6x+UJDZnsK3+fSSaz8rIr7o
 X9g9oPJsqSnQem/xnBA==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a0256e7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RSuC8zd2ZDaJPqFJxW4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: _ygqSwndBQBQgatBiIy2jnMYTTmh5bps
X-Proofpoint-ORIG-GUID: _ygqSwndBQBQgatBiIy2jnMYTTmh5bps
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236
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
on the Kaanapali-based devices. The Adreno 840 GPU present in Kaanapali
chipsets is based on the new Adreno A8x family of GPUs. It features a
new slice architecture with 3 slices, raytracing support and other
improvements.

This series includes patches that updates DT schema, add GPU SMMU,
GPU/GMU support, GPU cooling, and enables the GPU on Kaanapali MTP and
QRD platforms.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Akhil P Oommen (5):
      dt-bindings: arm-smmu: Update the description for Kaanapali GPU SMMU
      dt-bindings: display/msm: gpu: Document Adreno 840
      arm64: dts: qcom: Add GPU support for Kaanapali
      arm64: dts: qcom: kaanapali-mtp: Enable GPU
      arm64: dts: qcom: kaanapali-qrd: Enable GPU

Gaurav Kohli (1):
      arm64: dts: qcom: kaanapali: Add GPU cooling

Jingyi Wang (1):
      arm64: dts: qcom: kaanapali: Add qfprom node

Qingqing Zhou (1):
      arm64: dts: qcom: kaanapali: add the GPU SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   5 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   1 +
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 450 +++++++++++++++++++--
 5 files changed, 441 insertions(+), 31 deletions(-)
---
base-commit: b462608de92a7cac450781f9d8d4c7cf3ccf82db
change-id: 20260412-kaana-gpu-dt-968a70134c22
prerequisite-message-id: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
prerequisite-patch-id: 82e142b3d904e746db0e288fb7ea6812661c3537
prerequisite-patch-id: d141a83ef741d26b03d931cf120b8b541ec51b9c
prerequisite-patch-id: 5bdaf78fd75be779d4aa73b85a185a10d8458366
prerequisite-patch-id: 0263b47f4e1aeb61fc96c6dbd9f7168ffe0eb04e
prerequisite-patch-id: bed1e449dca0167ed99e8c4f1e544ed60ae17014
prerequisite-patch-id: feda87721f22e443f38165787b2b28fe1a40aa18
prerequisite-message-id: <20260512-glymur-gpu-dt-v3-1-84232dc21c03@oss.qualcomm.com>
prerequisite-patch-id: 9175e9ae77ac032c2f0502e2c63bb7b7d1ae4ead
prerequisite-patch-id: a29ab9cea24f74a76a69f144f76f9860e014ad19
prerequisite-patch-id: 6243ab821a3d9cd641a8dca8cdab167fe9da8735
prerequisite-patch-id: 36f4bb7740fd65d808fa6685bce4b03798a547ff
prerequisite-patch-id: 054631082c45d3ab3117f541f0d4d90b660dac73

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

