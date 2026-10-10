Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C29CA9EC1
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 15:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F14CE10E98D;
	Sat, 10 Oct 2026 15:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p8lspO1z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAMIK321";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D237410E14E
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:36 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AFPEjF1372346
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=zJJw/DI8ngRKeXSlMVGBqvE60gQxz1Wxbry
 XJfp539c=; b=p8lspO1z0v/qQxdHH0G4yGU6jeK8eCjQU3rIWmeg06WK4kKC6UV
 iqPuAh7EtS6NGaPGyuUYbwUcWqw4dWc6nUFcy6ky1LeMFAQSScXvl1G2oyNJTJVH
 ygourMayIenfSF3ISQBU+JkpdjoG1U7kRx1E53E+fx7BikQNMsennnnX0VMv7rm3
 D8CJQ+hf8UHVLDMPQ4QSwbMiPSHq6sne/v7Gygl1sEkOvBB0XydwaYGy5si5EnwL
 XnTKwwbX5T2Zog+49F/ay7VlulkCVb3QQnRONcg/j1aybinCiYT9vHIOAcEJy2qH
 dJXu1KQopugUGV9rwzUQxLSYGfLXonO2c2w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7cc69ewv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so341019a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791646894; x=1792251694;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zJJw/DI8ngRKeXSlMVGBqvE60gQxz1WxbryXJfp539c=;
 b=XAMIK321rjKfOMmYr1gVbZ2JDllsUomf6WD/tBA9sLN4f4hYjUOfgQVA4TW5ITqHYg
 0hqCW2l8PNDSPOQRGy1RB83kMqx0u2S3FGPnWXJUFHk1v9obl9UU30l1hJgPiDnDA6xJ
 YLTsR1BXMD4c1YXIv4L2Xt8VR/d6zI0yPhXS0ricmK0kdWZsXIoF3ldCkf9AGhgWxm9R
 +A8gCU0SZqpR1teyx7ghSJr8+3bWiuOH3TmMD/KrAZKd47Bzs+L4/L2tAJV8t0LjjjPJ
 9uRaMakRsp2rZIWccqT1PTz5O/u//RkKH5UeppBTcBl6yRbmM0tsSbxYuUZJZgPKU9lC
 tDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791646894; x=1792251694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zJJw/DI8ngRKeXSlMVGBqvE60gQxz1WxbryXJfp539c=;
 b=QELV2ibdeNsLijYrJxlmk3iUPHZKypXfyUNff9uY8rmj6BV3uVhYBO4mRai8+Y64BA
 KEi/BTzTdFiKsHdnarIKlBHFq19xn1DnYeTgLsPPC5Swb2m7xRQDPkgXV1W9bA60V/5l
 xNCjn2wK4Js00Yl48Vgw2lwLNMWbyLfjx4WKEeWIXgknG5mu4BxRdrEXmmjIkzH3U/XY
 jqSIsC4gjzRmLWIIzd5knw6oXTXXtQX3cYNy7nYNlwtuGBEle7y6yKB96GLiwmcGv+X+
 ed2+47vz0mKs6RF2L2YtubOg7bs+ih0Frmbhq0KyuV3tT20NqqHZyp5xFzdzGuqf1Qhc
 b76A==
X-Gm-Message-State: AFq9FYK/GGHqOkKLnH6CQ3JgDMc9TUk4+2dPkbVHBe28bnZEZ4xtt9za
 mBp5W6XNRulNs95n90Za2DEgfMWmcYB65S5D4rqL8DtR1pgy/xF+zRf8W0oJcB6wQiSwTONbCsc
 o23lyi4ZDGfjC0od9RS3L/P4uCVo1GY1Ov2+aPBvaUgHiwigFxbsKi4j8lpL0vp2j/7JYtChV4+
 4Nf4k=
X-Gm-Gg: AYBFou2cKko1EjFFBpfrm9xF4vVW473EKrlMaU1Fg+uTlVgOO5bx0utoCanen4//Pmc
 Tov4+E0ijo4qPuh8VOaR49vUQrGT+Ne9kmVTRt7O23V9DBopV8qfqEnWiz8mUBVQnoBlEpKLuPm
 oLehbailXsnlDO0FP3TY0MEFslEgg2LdOr8PZoHTZMlPGcfPQsJIxPI0Yx4ZmcG9P+dzXitAd88
 npLVH/4m3bwyFL0bX+AtDGCh4jxOGs8OTw0eBsEwVcXFHCZMRiQH3SWvZd5xCH8t0s4C3cUbKvE
 +FwSGHgNusOINdTCw7hN/OKRhLPZ3ddIY32poXrVPa3gScPSAnh1Z6LnbwGnmjjIMM86bmzxwG1
 uJhIXTCWp3ipBfYeyg8ad2I09lidHY1RUfvp1EFBCa3rS+lz8AQ==
X-Received: by 2002:a17:90a:c10e:b0:3ab:2d17:51c8 with SMTP id
 98e67ed59e1d1-3ab3a29028cmr4380592a91.8.1791646893708; 
 Sat, 10 Oct 2026 08:41:33 -0700 (PDT)
X-Received: by 2002:a17:90a:c10e:b0:3ab:2d17:51c8 with SMTP id
 98e67ed59e1d1-3ab3a29028cmr4380575a91.8.1791646893212; 
 Sat, 10 Oct 2026 08:41:33 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab38f2f866sm11038550a91.10.2026.10.10.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:41:32 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/2] drm/msm: Split a6xx/a7xx/a8xx device tables
Date: Sat, 10 Oct 2026 08:41:18 -0700
Message-ID: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: otYiExyll5UocNgNdU9J_rovzjjuZsgH
X-Authority-Analysis: v=2.4 cv=XdQcX455 c=1 sm=1 tr=0 ts=6aca5caf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=sLlx88fqiuOlAInOgu0A:9 a=zZCYzV9kfG8A:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA2MiBTYWx0ZWRfXye7CFr6kSYw0
 vopWsGvgPKBfctR1XD/4vnoBwPA6K46CHtZS7VUPI5x2p5Ay1NpDnAwYcvsNC15cNKb+BiPlPCw
 HpTyzOrK4kzVsoRZ9+yOrjcSlFA4yMZ2QjIDVKg3rZEsr0p2lYZS5JuHH0SVoe7uuPfeqY3AxK9
 iI39AtwdyjeP43XxOGRkobLYxA35HMPCyY+vTh7JR/4A209cZ23eiMSm1C0odEzc2Zvyw4+AfMl
 TWa09/RFPbRWlwXSGq/uC6CfeKE0yAvlFnx67YllpgliCRvcQ/px559VENNsv2FOV0eLK08TvUZ
 evOwZbuLDv9Xy4n/8qeqkp2JX5UwlSt9ZOt3WbjuoIkjlDrxJRiBJryNU8dq5W8kiVedPk1eIlo
 7dHdc5rSoF3nGdu3awH9mksmmFs3H0cCpWYLga1GdPDdvdgdXruXOu3HPpuwhh5nzw05lmUmKqa
 VRyhtwIWYRj4GeiEcvA==
X-Proofpoint-ORIG-GUID: otYiExyll5UocNgNdU9J_rovzjjuZsgH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA2MiBTYWx0ZWRfXw2m0OYc3zlZI
 MQIOO7aZ0L88/KzB9YBSav7LxXSrwLevBvu+HyUBR+7oZIXvCROVy3Eu9p+6+bTh2tPrK5vSPmb
 zrYjw2xJYPO4U0kZRo6K9BSmxZLGTxI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610100062
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

Prep work for a8xx GPU snapshot and related changes.

v2:
- Duplicate a640_gbif reglist to avoid sneaky extern
- Link to v1: https://lore.kernel.org/all/20261009131927.551319-1-robin.clark@oss.qualcomm.com/

Rob Clark (2):
  drm/msm/a6xx: Move a702/a704 to a6xx list
  drm/msm/a6xx: Split out a7xx/a8xx device tables

 drivers/gpu/drm/msm/Makefile              |    2 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 2432 +--------------------
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c |  502 +++++
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 1846 ++++++++++++++++
 4 files changed, 2411 insertions(+), 2371 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a7xx_catalog.c
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_catalog.c

-- 
2.55.0

