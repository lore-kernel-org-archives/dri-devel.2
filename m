Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14188CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D97910FD7A;
	Thu,  8 Oct 2026 21:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TMrc9B65";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TMHgLrZI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1557F10EA4B
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 21:07:09 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L0BRo3858666
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 21:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qkepF2/gI8XkHqq9Zdif/+
 4ePDfuAtYx0d2zgLKoctI=; b=TMrc9B65CA7fCBxrrDjjD4XLcAd1EQ+cmdd9TP
 JF9lTVG8cvg2UO3ub9I4RbY84NCyVwGeA0ZAEA88Izu0YVfq4OKaGZLkti0P2AVF
 iURaXxF4Az4DWxed/NiNq3xpA5JTBb8mTKMOBZV8a8j8NivyoDGd450tt3vxXIXz
 kF5axqGhGv1k5BRGSO3Jxr+I/VG8JUf0K+SrQl6pugLASuSzu+7Jwj5ozQ0KbQPz
 Ep0icAnZXj96A2K4MtWkk+lt1NcLVJ3rikRIBkY6nRJzXQlHgOKLmnQAmZDrF33u
 XOoRRfwCGUILDx+SVX/RhoVioMyumpUiKG3iW1RS7YzdBbAg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9khu19-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 21:07:07 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3425098ae4bso5939895eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 14:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493627; x=1792098427;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qkepF2/gI8XkHqq9Zdif/+4ePDfuAtYx0d2zgLKoctI=;
 b=TMHgLrZIXPdPYtK9RqXUP2ZBNtdu/UINyncZK4tY1xyMsumUx03JVSWS/JvTkw94cV
 F79F2SHSCPofX4fJal62i6j9tZ31u3fe1DFCg9N1CEQ6PUV56Gf3hzkbOP4XcVf4VHHv
 /0+7DKdkXe8AmxG2Uh5QVgbt3gh8gnTZxnGREmKXERM2dOhJx/3d+ERgVu8TRCGjND7f
 dDZ9CACG5RXSxw5QyMZmk4jR0/u/l1uBIfV7gdIk5ehNjsyiHVQHFlL1Lr8RHLun6uut
 4U/Nz2azk0PmV+wznBUzB8RmDRegthTMnKdkzRqPu765Qnr4TpvNwLer0bWqDiwma6WS
 1pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493627; x=1792098427;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qkepF2/gI8XkHqq9Zdif/+4ePDfuAtYx0d2zgLKoctI=;
 b=NDgEVqYZ65f2P15J3xCfx1Ebf7K26da3V+sPlod1h5sHaRBsPUV9ujt9HLU0O84CoD
 LrRatnev8HijuNPzNLMkYAw4L9AmMhWwYkbzQGtiSATxJNfgZ9YwNTFGbWW7/ikiTGP8
 QX7r8o6F/oUN1ZLPLOdyaDgY+SfJHLYeSqmZqm6ohKjTS93vA9cOuAf/QhxOSUWYMtIz
 h7Xg9sIirptlpj6NTBifjlBG2lfH9JT1wmKELGIHkvCcJakOfTRy4lJ4ILQsT1o2/8mO
 RW8Hr6OlKwxR7M+x33z0gML/Gd20sr1YtUf6AL6Rnj4NdFTDnAycjfoNkr3OP3cqrxad
 CHFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1oNHhZJ9jHlQCWOMoYOSo3IWYWw0LDvNG8p/Ad45Y6Od8j8+Ya5+AEatMZQfECHWNksjsLiAluv4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ6qfDEbOHYCwUifc0Wvgz2s2UZ7uC2GkjbB6QoE0QQhjdsUdkV
 gGlPyuM/m41dT4N/nREIkk4Dj1AhwZXED0BvDVlkxtc7it/Y+Iu/ES43/yzQOIVQMioNUGGXvs5
 K9Jg8a8iMwiZWSRkGCYQ2fZrSBcd1gbJZnCYKX1WxLGLOqSlwGET3jUOwjXSSQDjuAZ0EUiI=
X-Gm-Gg: AYBFou324pyQewUOx0ZVAKfMB5INqbc09XkmALSzFEZINvNb/gc4jgDiuI+kGLkbxom
 ByRI090JtewdvCo7lxDUwcWeGnV46fMi5wYws4TjJyuChBqf4v5+AvZXyKRxODbA0PVkHZKhQej
 C7Nolrulqj+HyD77nfLCONv3xAYUo8rbDPKYloHMlxEDvCKKgQHUyOD4AhiNRZHO1YyfsCVuA8A
 7JpAc34VTx6NmZ6/RyAiLb615MWGsJK3Mi9RNP0ElURFzMp0c8IeRXOZcJ/0a+VhQnQIwxLIy42
 uwT+snRwEZHBDKkDNBjmoeuCTYl2iLhYpwjFKNUckW0XNdI4Bo0ruTfdFGOBl2++DH0vKpqAZAy
 7NimAFiFU3BOcDorAONRuBXw=
X-Received: by 2002:a05:7301:6487:b0:351:695d:c942 with SMTP id
 5a478bee46e88-3537e01235fmr96075eec.11.1791493626681; 
 Thu, 08 Oct 2026 14:07:06 -0700 (PDT)
X-Received: by 2002:a05:7301:6487:b0:351:695d:c942 with SMTP id
 5a478bee46e88-3537e01235fmr96028eec.11.1791493626045; 
 Thu, 08 Oct 2026 14:07:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cab27d5sm634773eec.17.2026.10.08.14.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:07:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/5] drm/msm: Support for GPU in Nord
Date: Fri, 09 Oct 2026 02:36:34 +0530
Message-Id: <20261009-nord-gpu1-v1-0-a06a6c57bde7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANsFyGoC/y2OSw6DMAwFr4KybqKY8gmseo+KRQouRCoJxKRCQ
 ty9AbqxNE/PY2+M0BskVicb8/g1ZJyNALeEtYO2PXLTRWapTAuQUnHrfMf7KQAvsQRdgcYiv7P
 Ynzy+zXq6ns3FHucQlcsVspcm5K0bR7PUicV14X9teeyPSKTPg3Vy5LJKM6kyJXMBMoUyVxw4D
 Wj7+JkTfXAPRyTmoD+HU8TBmn3/ATHlVR7TAAAA
X-Change-ID: 20261008-nord-gpu1-7e71a91ae653
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Aastha Pandey <aastha.pandey@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791493617; l=1744;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OAsh6BHsJWICYaqgCYPxTfrGA9OgSXttDi2giyj8A0Y=;
 b=YgHWFIUSJr0YEcLnzDSY5byxjOWwNyX+PJZro+6umZXkfli7BA+dmcwc3RKILkKkwlwg3vjxi
 O/rDZCbeDreAvPHn4DN73Fqf2ryoiCHknbeQClyPMDFg9UMrvYfZctY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: JSEflkrGWs_LKKJ2VqX4xo_2h6ZRsvAw
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac805fc cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=eQK-ig326sWed8EMzPoA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX2ZScHWDYiwul
 4ygq5sAnE5RTXSa5GAXcTUVOUwODaIAa7l44BH7aozIDEx+yU3Ro8jAziSzABFHAE8UAm9gF8g4
 j/sqrDKpeZRGqvx/ht8gNAo0jp+n07c=
X-Proofpoint-GUID: JSEflkrGWs_LKKJ2VqX4xo_2h6ZRsvAw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX9b5Yotju0I8t
 8mOMJGgCBKV9FeSLZO6UPvcdy4RL8MT1Rwf3MUxq91AU7wU6/wBVcE5Pg0LU5P7Y0v1lU/93DXR
 1mBRJfr7m+Xk7+QbzmQEgJuxgl59jCGs3q3AEnpjqgZk4Z+B8jUm9ADPx1GxOsWpEH434cwp7jX
 guErltyNxbGJJMy4KBOngwoXQue+A2vFmWPHaUAz+iY6bOWy2DIDS63+H6su5kYDmWtSC3oscl9
 JOvkyGzsNUonbCQgutkqk/ioLDwZ5vUw5HtE4alKSNHb00Bsv7Pju+sDIGifeYv8yYDHNzRXioc
 pjio//c9CeMrZbn8dpSjtUxWCTkdzxBb7qTIwu/V8m40k05/UdMnNAZbStNW4nJqNfRJSl4OiJM
 mLp+GG5MNlOmpaj3eSf/xxg0ko86uY5ZIxb4w0LAUcaQ6hzSWXOL1AcvCPekv7aUEKYXtYlTUVq
 3QSF/HQD4Ci4RRPNnEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080084
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

Nord is the first Snapdragon chipset with 2 integrated GPUs. It has
an Adreno 753 GPU which is very similar to the existing A750 (SM8650
chipset) and an Adreno A735 which is similar to the Adreno X1-45 GPU.
This series adds support for the A753 GPU. A735 support will come later
in a separate series.

The driver and dt-bindings patches are for Rob Clark and the devicetree
bits are for Bjorn to pick up.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Aastha Pandey (1):
      arm64: dts: qcom: nord: Add GPU cooling

Shivam Rawat (4):
      drm/msm/a6xx: Add Adreno 753 support
      dt-bindings: display/msm: Document Adreno 753 GPU/GMU
      arm64: dts: qcom: nord: Add Adreno 753 GPU and GMU nodes
      arm64: dts: qcom: nord-rrd: Enable Adreno 753 GPU

 .../devicetree/bindings/display/msm/gmu.yaml       |  33 +++
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 arch/arm64/boot/dts/qcom/nord-embedded.dtsi        | 293 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/nord-rrd.dts              |   8 +
 arch/arm64/boot/dts/qcom/nord.dtsi                 |  80 +++---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c          |  35 +++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   5 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |   5 +
 9 files changed, 423 insertions(+), 43 deletions(-)
---
base-commit: cf4a8255a424f691f95dfa378e88336f33aa8ae4
change-id: 20261008-nord-gpu1-7e71a91ae653
prerequisite-message-id: 20260924084805.1021758-1-shengchao.guo@oss.qualcomm.com
prerequisite-patch-id: 62d07f5574a5d15ac0097efcea4a70dc96331cb3

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

