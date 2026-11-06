Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F88606A32D
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I6LOmRIZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iTSb617d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A8110EAC0;
	Fri,  6 Nov 2026 23:23:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF2AD10EAD1
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:46 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoUlM766841
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PPgnV+/icpo
 FhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=; b=I6LOmRIZ58oRfznzvkRzyRiyMaZ
 WxMslWBgqRZMqsoHFQG0zoNErjGiDoXCKEgNCwuO+GY4JvhYPUOTw2ApqYbHPG2P
 M0KCSnyiFFIEhDw7ENkD2smjVCvj50Js0IQt1F2XOxHxdGn3UliX73SWnCU7+IuK
 /XQeBMtw0FuaDaQMZSS6itc2NoIJsFt4KdQiaT/IZsWq5f0leb2TrfMRYZvVo8en
 OnmusS7OaqnLeko2i9yfF5jfE7IDAAUl4O+PNWrcG79LSXsGDuPTPyDx14zljnrU
 BFAIuc4jYCj2/ygGD7W6H1lxKYqwgGyV8/adGkJIc49sYCS0Myjf66/Ew0Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk48s8r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so974166a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007365; x=1794612165;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPgnV+/icpoFhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=;
 b=iTSb617dlaQwPaEteRJME4dNpwWvit2DwNMa0HQVf8EDhPi4uPg7cYw5GDpJ8AyWgA
 OPoyUnXU8omGhqECYyaGZyp+LO5ZsYP1g1J0Ra+eXfjc82d0d7zZcrpGFdNY7hxJz5Th
 dY1RZHUt4VLg53ktPg/r6X4HhQdB+J8xIu95HzzknDw002+9e/0cLxb7JIGZyr345UAU
 HX95PJPfpkxQqEmbHPawx+VumJD2Qq6svTHr3HLq+MnLvuNyIrXaqt4ZkxWXaDR2E67v
 UVzf79snijvfIe28IKObGM0XWPzdTwmejbI/BYMq+isLTMTdVGdGBrTPGIyqHA+XGFlu
 4LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007365; x=1794612165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPgnV+/icpoFhI/kUPr3+TxF1BiCW4u9d+dKLSBISVI=;
 b=HDmNT3PrUJzp4079Rq+3vCIZ5+tYm0XR0Zsoz8zn2cq67FnZ8Fb23xKKkeDsWeew3a
 T/EcMw+KFL/WlvGfQ3rC42Xgx1qPWOoDQqJ4MJiBEM5IzKSTKdEka6c520kWunKOeOEE
 8R9azmXaJJjXvrW1wPv5vsmGd4JyKHFFx7/2X7jABpjOp5R+CVDCg9KMDjmsVp9xCmai
 IKy/CuJK9NHko3iIMGQrT/ColLcmYcvgerFx5dKe3G4QWEJcUv4Qb3tCW2VPpV+AHBsy
 Fd/bthCU9y2+uY+qbtPuv/+Rc9zHUCrLodgFg5kSnNxUO3a2kzoYJr/qTXXDoCaFlncq
 Hm+w==
X-Gm-Message-State: APuU4Z8Qqi+gYzdBThns1dR2V0mRGVMFFbm45qYxgWKRPwgOEO2PCdaT
 HlmtrLYQxgvbRu7Tjksg+uVJ3hHpZrPtCfcKGXMV+o/p0INRvbHUYvy/bx4QrOFEN8oBM8n3nHu
 MFoKdVq32CWYX/DTiCBeaFTtbmdPL6YWc41fUvhym01wwh2Ys3ud52cxCWGb4/vxrwxh+F2NQKC
 +eK4zRUQ==
X-Gm-Gg: AYBFou0LIMIcG0fP1iyOg9IQUnOEIXTVTgkqPX/+lr5g9lznuMa6U2Mrn5y1fKfzicj
 PpSc9lR1wqfiHFT5CpY0iGbGXwTpqJUdfF7hvFzjXnFK3KjGmEqK62xZk4wMkw4Jrolvd8dHsNU
 Od/LtZ2f3+k3OPK40EbNK9IdQT0qEjd3xJIsjvnzl/2lO5Vbw0WVMDkCNLZj9dCUEXOMYB9Zw6T
 aBxNpdzKzpyyyZJ+g9ZrDwQJGHkAxUb36L35lJBT6u1nUpk61M0cxrbIHgmhrH0S83Pxw44Kyo9
 6G9YZuc8P2XSuV8lmdNGcKVp25K2n6E7XpM4bL6mYXeA3Xmulz7n4D1cFyRQBatgyCGwJ0bQSnx
 BfNv4qdEWDlFonIgyHwu4zerC4k7J3IbiLLzLuaBZOlYgewU3w9WTsVU4JYwTQRRydNha3u1EjQ
 dZVn15ALoCbuYhIYeOCblgLhWE4ys49XC3oTapMhJzt2+QYekZlImpOMuoW9MZTQ==
X-Received: by 2002:a17:90b:510f:b0:3a5:c08:4c41 with SMTP id
 98e67ed59e1d1-3b0db724f88mr3658908a91.50.1794007364765; 
 Fri, 06 Nov 2026 15:22:44 -0800 (PST)
X-Received: by 2002:a17:90b:510f:b0:3a5:c08:4c41 with SMTP id
 98e67ed59e1d1-3b0db724f88mr3658892a91.50.1794007364325; 
 Fri, 06 Nov 2026 15:22:44 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b10584b66bsm650571a91.14.2026.11.06.15.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:43 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 05/15] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Fri,  6 Nov 2026 15:20:57 -0800
Message-ID: <20261106232220.47602-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX4+zez/JHC4Tw
 xCforetAiS/SpvCkFXvOJrW4I2ZWbnwAXtxZU/V1oArGeUZ/MpcqGHTuH36Lkbyd7rUIe12weKH
 9L3xsYcUlQSswgxdpcvXG3wBF4wnnKl0cNKY/jbnn9O5frMQjiyoZhHgsrPpJKvVFCeEsgaaNLN
 SUEUpYQg0UO0H32+IxnQhpNzSBIIjqBPBPcO990+OhWR8JwhKk2Ex2cguq09ZT5w/iXec717yKQ
 ToNBaB4+4eVEpyGuXnVp6MSl4syb8jcZ6o7P/WdM+WWWLz8OMYmrsbrFIfy2yVRYuFvz0LDcCZm
 r3PJk9Yy63/wHATvn7G4HoAGLfSFhZ2qv5zwMALmxfBTR26NnqgS9hh8Wc4waU2Y2WUB1DXWdrF
 ei6r6Lk3EdiXXg5rUmFst0R6H7C+r+zuGhFEegcml40VWX1O+uz0Yx5/ileSVUyt2jygJLqdStE
 VZ2QEk4FFWyRWz3n3cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX8jgo2BoBNN3I
 nXEWm7qQsiBM8TO0fJ2+LClHlp7S4QJ5mDoWHyqvwww7TRudFUPB1UA1OTLnGrYhej52hNOJArq
 yvagM5i9iPuEElNspZbJFa2wyW5lmhY=
X-Proofpoint-ORIG-GUID: MzVMGet_kOZC246DVavwU_67asELBzhS
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6aee6145 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=vdKEjRuvQ9rlgTdWijoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: MzVMGet_kOZC246DVavwU_67asELBzhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We want to save/restore all of the CP_PROTECT regs across IFPC.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index a3eab0307529..dd1a5ca91812 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1393,6 +1393,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
 	REG_A8XX_CP_PROTECT_GLOBAL(53),
 	REG_A8XX_CP_PROTECT_GLOBAL(54),
 	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
 	REG_A8XX_CP_PROTECT_GLOBAL(63),
 };
 DECLARE_ADRENO_REGLIST_LIST(a850_ifpc_reglist);
-- 
2.56.0

