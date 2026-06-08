Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C922ACD8CA7
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 23:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4033810EE90;
	Mon,  8 Jun 2026 23:36:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dfe1Wp4+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N7pwb4lg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA89B10EE90
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 23:36:54 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658NEsDi901184
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 23:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZYk44gZi0gQL9cYyDZb0Pr
 aSrIqM6bq6tOD+CvfB8fg=; b=dfe1Wp4+8YJo75IuupNucxzuE/twbtpGtsnDUs
 D2Wuw4ncj7zES6qNewC4xFlum8ix4jk3lLiKnvxsvx47jYfE/0JSoQivnu41Wj6m
 eTETIjbRVp/4b3daTc6rzvUf2nk6fMnq5FrpMGT32HBkBwpkxbsUynmcYCGErCtS
 OKxt8YAb2pGbk1h7u6DAO0d8ozkC073oone6OxBMgvc7U98rPH8fUFzCuBWude9O
 rxJWKCtbrR+iNCR683gEy9EZZWZdpGgEdoMksZanpcFgfeVDVEI9ujxI7g2zpowg
 Q2YzrTPyoA+wWLA8q1XBTtHPvo8pJirAldqxUtr1wMOht+6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enwsvaxd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 23:36:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0c32f4b1bso51425125ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780961812; x=1781566612;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYk44gZi0gQL9cYyDZb0PraSrIqM6bq6tOD+CvfB8fg=;
 b=N7pwb4lg3F/yKc+tW0HyLPQWOcDbgL5CXgcMyLBKcWb4mzL41zwNzWalkY5g5Jua8J
 e1Q7bg+OqZgZlNdkQxjSYjcBE4e5imswqun0S9ki8cHhBWTjxxknEPo6raI2GyzhjrkQ
 YVeBxyUCgLoeGEvpRzs6302BdGgPS5k9FZqs/MzckOMMf/2eLojfCi6eVh40cRO2p89b
 u8WFDpSb9YEsQtPF/gyd68cMBWSPCDQb/Z+cZ+tKKqUVkWPgGn5BwhP7sOGvuU+DEyKt
 DbCC5XgapuPMTAcoHyrzfGxArnlfmn3BjzchzOZcHfRRkrudpJtglzRapKv0ciVBzJsh
 ogRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780961812; x=1781566612;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYk44gZi0gQL9cYyDZb0PraSrIqM6bq6tOD+CvfB8fg=;
 b=gSZ4FcDKurHxVnw5m8HJr637gS/opk/sTxxk9T1tEX4AcnYDn0Gyri/fyNw3TqAI0T
 AsRCXsLUTpia9zHvIqLvVsV4kJ026mPJ05QGCzUgD4VHPMcxfeyfs5QVWv7fQE9lBUMG
 uUpqi+dhnKfyCMdbR4jDUv8vza5ie5Lb1gO4Ir3F/X3E1Qr6RhzfMV0Y7OZYjIcBcQn+
 EQhbqveGlbBPtXsSFiNYjNUQRY+wt8EBqKTEs57VfMVHE/0xBvwLuJUagh/YbcmdixzE
 wsfQ5ACs5cOHloL6SrHxa3mITXb1ICQclxXY6L0BmIxsr+0yQEc/k0uHq2x82hCLGppJ
 A/Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+vEuHwBgLNg4bqXulxwTKYgA7V3fdbbbrtbYVqgO7cw1+cP21zFYYl3E8Pq4EWS6B/iKhCYY9zDfE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmS8WJnLwNiKtOVWFKGKjWTl2Hacd9+/DAkFRtAHPYaocDfPZ0
 h5nkvB1mbCAcTbisJzXIaLVcqa2QutYdrU0etoqXoj89RMUrjR1yX/CMjgUMVHdseceFWCgnumJ
 AiHWO+n8a7P88Wb+K0sZDllyaYWOTZ4vZd+DeTn0F1xSlnj6ADF/140yEylHknH5W9ChPdTM=
X-Gm-Gg: Acq92OFyy8Ww4JTygriixc5Zp9T4Lh8889WnFouW2I5RGskswdXTMIFipCj2sgbsUg8
 keA4FOuGlRDUwqNMfe9GSiKHwFVjeaT5/Bi4/D/bSeCACAsgh5J0p/GN5888EkJ7PpJzoI47GFi
 zC8oywm7weHlDLikTv4YP6ztarLBFHTUhjVk2aGgLDVf+okqbxVq6A57ovIilXzsxuGHavCOwvk
 ypIYwE2czgwfWkE3VjvIQjF/HgJSZ3POrf4udNqmfqlcZ34bDjllFc7+705t2Peaff3PlWlHXBD
 waTe0tSc6hgIicl2ty7/OqGT4/6AEfzOY1l+aiaR/xl3Jw9ch0dhYMSIIV1ObRQLfXai7MvLFT3
 BneaU92iJFNAUE7OhC8zLLoTxnfqlqSCqZxWTbp3gjtpaP/2qd18V+PBY
X-Received: by 2002:a17:903:1b44:b0:2c0:c262:b925 with SMTP id
 d9443c01a7336-2c1e7f9252fmr205752215ad.25.1780961812381; 
 Mon, 08 Jun 2026 16:36:52 -0700 (PDT)
X-Received: by 2002:a17:903:1b44:b0:2c0:c262:b925 with SMTP id
 d9443c01a7336-2c1e7f9252fmr205751785ad.25.1780961811867; 
 Mon, 08 Jun 2026 16:36:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c24edc8ad7sm66206975ad.42.2026.06.08.16.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 16:36:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/msm: Add support for Shikra GPU (A704)
Date: Tue, 09 Jun 2026 05:06:28 +0530
Message-Id: <20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxRJ2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3eKMzOyiRN30glJdUxNjo6SU1MQ0gzRzJaCGgqLUtMwKsGHRsbW
 1AFdqybpcAAAA
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
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Aditya Sherawat <asherawa@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780961805; l=965;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2NmZWaJbIB33VnT9ZsYiOup4YkK+p77o9Tr+gBsdYRc=;
 b=1/B6F5tMzl92zsNhiGGCcyT+PvRqnKjT3hrSSl1IsdYCfywRdpbiG9Ou5ujtqqz5AfLz3whCe
 dVeU+IN6Pb5AyXEJI+69OE/qZSUsuy5BHUFC+4CQEAQKnJo+q1QlFPB
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: LvxS-FFD4O90FaLBHYvVZuQVe5wCmNfG
X-Proofpoint-ORIG-GUID: LvxS-FFD4O90FaLBHYvVZuQVe5wCmNfG
X-Authority-Analysis: v=2.4 cv=dIaWXuZb c=1 sm=1 tr=0 ts=6a275215 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=bc7Rx1KwavqhM_SNCYcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDIxNyBTYWx0ZWRfX55yvCX2SDxXO
 l8CMUs5+Sk8/9iC6tBbPt0x+wamuIRae6DRzdi0w40a8dVUtxsTn3cdZ1/hHRo2odvcMcs5g4Tx
 V1gaS13SjubZdYdblBZ491huCeBPEVrjXu3ytc24c/wvn+vH9WPrIjJ4rpZ5LuBIBaoO8egbzIc
 u04asNPIxY5g/1hXmil5VPKK4bY4obK0pO4ubX79xThRHQ871qtbx4vuPKI0QOG7zaZ/uBm7d2o
 85VLFIRc17tL2y+vueOTAp90zi1QVKR+Qp0KbU2mRoE23Oa09wxsmk1tAN/n/FCLL0eoXJrJhaK
 fobXYwyQuvqc73Hs/h7gLQvfXQqWOwR7uKebrZVcF5D75yULLzpibPtvcqAszE4iO6+npxrotdN
 CE90+J8jPHcX1zMJY1MLHwa2R2hRc+YsNAd1BCDfAaMNQmEOjNfPHWYowEyOVjqjXJ7ewOjSHOg
 QXLLzCBxkhANVGWO7eg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080217
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

The dependencies for the devicetree patches are still on the mailing
lists. So I will send that separately.

-Akhil.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Aditya Sherawat (2):
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      drm/msm/adreno: Add support for A704 GPU

 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c              | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 9a967125427e03c7ebc24d7ad26e9307e8403d4e
change-id: 20260609-shikra-gpu-5432bdeaf0f7

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

