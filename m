Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9A6C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:56:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0047610E7D7;
	Mon, 20 Jul 2026 07:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IOaBsQfu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NWrlmNxe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C70E10E7D7
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:56:22 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7YhCx2045267
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Z/fQ9IgUcPlKcznfvswD9W
 ypgqtISqb/qH+AvKDm84w=; b=IOaBsQfu/GiCPwm2BvViRhfsL6H0Zvelwocwjy
 8nTxBZkCchAclJByye3GIY+zBMxI544WHru6ClAbGAWTmrgw+qxOwcr/sYzY685a
 lVMCdfVXcdeGDJEqHXH90nyBmGT5t8EYnRTxbT/5a4VHXxTCKgcOPC+IsCaJ3NCm
 UqSl+n8fbzhs5/z1RjoTkHxmr7UC4Wk9cS2FuVdS4mMUnQ7KjdL2iZmyTOd4+m6b
 UHlmmSf15kQKq2tE82yWTY9VyLo5FVFBYB5Ru/T1UCRDaSVveLFzcszsXpJEkHmw
 q9LeDYfZhOIRClxLasi9xW7LcP1RE4+8GJLr21L0IbygoJRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfdcg2b6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:56:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e9a2b95b5so1564506685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 00:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784534180; x=1785138980;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z/fQ9IgUcPlKcznfvswD9WypgqtISqb/qH+AvKDm84w=;
 b=NWrlmNxexHFVp9nBsliCv0fC35pN0QwLcN9dOKXFVz42vooilXF3VKAebUrSXzLoGg
 vRn+0cjEQVMQ995e9BPGHeKS/kmYxzpJKIz2UtEIUwxAcPf0O+JOaaEHrJ4Bt8olzwc0
 f6bSNjvsNb3n3PCHuZ3eN9PJXX2raGnXFrX4KCE4S9gqbzq/eavb63yawmId9iirxBAe
 z5I9EspVLDK9wjHO9v+HVTx38DjbuXHz9KvvkiN1+CNvcj49l11iXUkvTuNItSREbx/R
 PEnVTEF6z35oKCVvdw930uGXymLmcTK/OSLQXHl0WuEs92/F6ubyg8Ma1Af3QmNtOIe0
 te5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534180; x=1785138980;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z/fQ9IgUcPlKcznfvswD9WypgqtISqb/qH+AvKDm84w=;
 b=TaqcMXY+bnVDTpSnrNq7MDuK/2G4KjUwbNP4H2Eo7cOvVtDE143d3ZLoOe3/pO+5Ho
 OMpVG/ARG3ILJYCmQqot3elH8kS0AAoMJEAidl/lwwjy89cz0+EefDe3PvZomg/HuGnZ
 YAK1Ej6ZrVVlndQ2aM3zgOsycGwrF9oxcvqwFOwGYd+B123vOWD9WeOyvTU70ke76ncu
 21JLeBZHUi5PgJoECKw+0BtSY9zSsaATp8UxekkpsuugLUwRPXmh+f40MtlMMRj9304P
 YuiJf1PrO1oWvOyO9MYLSXzy/Oy5aHs+MENMUDdzXub5dtcL1xQ45Yar0RkPKHQW4PUc
 fJ1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/VSKL1XGaehgiCp8pMFuK0QEiE0FoxmtJWOTlfa+WlfDZBIONvwuPixy4qcBR7bxDLwQ4vYbsKPQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzq+0gGlWLW0a8uoLXJjNwuVRUkU4jRV5Hjqr6cDn4XWkoHhPj4
 dv6PmozDWsbZWKIuauiRKJp7nBm83rAVwmQROPHuBkjlp7FsJpE0ZoQUliroHSoAVd0TM8AiFfI
 /9X711RKbmlpDz3jk6zBIazyjLKMPLF4xE+GqTz+4MI2E6V1bajDnpWqHhpAwqO2toJpJnqA=
X-Gm-Gg: AfdE7ckWgwuZBVoBPyqEP2iZ7g/+jCZuKL96Hs/ec52KSEgWgT/cSQfYJAHmr1KTsph
 PL24Rie3bcx0J3RCx7E7qSvaqU0c7f1MKhVkmoEwV5Z3E4CH9gRbffTzjgl5tQMw4Bj7uCszZuO
 rmoiQf7o0RZ/+eEyFik+f3VDMPJdwkO5pmzkUsffo7pSDx8A37+2myq0I7wksAdJnfRFGyMpQKk
 Jc6UXsWwnHggCasGSkGhk6AQqqsVAaBlvEQcJuz24il8EtSKP4XRQn9zbwOXV326VMj66nv0khC
 2AKLnQAwmkQLU4JuN3cZR66hH7rBqIzI4wSBK9eSk0EqUoCgmNHLwvQYJYFG3oF0KUBWt65GJ7Y
 duyJwqIa1As7HdAukshT+f/TvuvGthBJL/A7x3XFNujS3nYo+5Q+xJ4eQw1OTpbU=
X-Received: by 2002:a05:620a:d8b:b0:915:cda5:27ff with SMTP id
 af79cd13be357-930b41a0ef0mr1282600785a.45.1784534180513; 
 Mon, 20 Jul 2026 00:56:20 -0700 (PDT)
X-Received: by 2002:a05:620a:d8b:b0:915:cda5:27ff with SMTP id
 af79cd13be357-930b41a0ef0mr1282598985a.45.1784534180046; 
 Mon, 20 Jul 2026 00:56:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52dcd31sm810651485a.2.2026.07.20.00.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 00:56:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 15:56:08 +0800
Subject: [PATCH] drm/msm/dpu: Fix DMA SSPP REC block offsets on DPU v13
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dpu-v13-dma-sspp-rec-fix-v1-1-10d69b4875e7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJfUXWoC/x2MSQqAMAwAvyI5G6gtuH1FPJQm1RzU0qAI4t8tH
 mdg5gHlLKwwVg9kvkTl2As0dQVh9fvCKFQYrLGt6axBSidejUPaPKqmhJkDRrnRDa73HUUXI0H
 JU+ai//U0v+8HWZaJK2oAAAA=
X-Change-ID: 20260720-dpu-v13-dma-sspp-rec-fix-3938a7df3ffd
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784534173; l=3956;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=UIa+Xcp/itVmIeS+C8X4mGvcA9fV/ITHOdiF/RHRt5Q=;
 b=3aWsg+3stCwWnO78PjKfVT8bMaiyFogXBiDrsdNG16X9UwUDn0wfsB8rhajdXeTWOaiW+6OdN
 BGK7395fSz2C5GWYFMfduSnQ9qs5Vi2erF5bB6daVMqhpji636JObMv
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: fteWM2BCRS9dZHR5kWpHsUOhE7UpHWvV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4NiBTYWx0ZWRfX98ujVCPp85qX
 zmKZCSRVQLvL/vrPjy+3dcgzCBssgdzNm8Ivc+Nz9gsdOe8uS2CsO0OafcBchu3xozclVi2aNfv
 bNDlE0e1PVuzOQ+Z26KvUwSjGv+InCHXj95aUlsyNEcIzZmcOUN+sQv+3tPqWs6r8iC2WItXVQY
 DA5jmgxaaAmGIjtTjJTdVVXBzUwKO7AaBPHJLFnwZwwmHUgKvE0A46tliTgLPMcZbez1gDrdXnN
 vVDFtir+roXUc1LIhcYDQ1wZ/F2ev3caSUCthxiyC5vYCnLJwaiq+ywzuY+CYE3/1p1DHxy+Uum
 BzjMXMowA7m9ov5zQJs9fa1f9KMDwKN88WJkslzRx6X9DhnasZbq7cjnRNSMKbI+be6xaZcwRBo
 +EehUfPGuAx1qLN1QKu8TSfG130+Ri7SJ/v603mS87Dre5BEa9ASpfQTqvpbade/msAOuZY1Xf5
 Oh9C9MHcFBLh1pePs6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4NiBTYWx0ZWRfX6B8YWgNNHmpZ
 XeSOu+GMOuXUB68+yR466uJ3pNhqUWhufNo6zH+qZEzENrFQ64bFwyBrOtDiWr6ATkqLhp6ddjo
 zTMgKduufG48wfatozEGWHSpb9GMxws=
X-Proofpoint-GUID: fteWM2BCRS9dZHR5kWpHsUOhE7UpHWvV
X-Authority-Analysis: v=2.4 cv=bv58wkai c=1 sm=1 tr=0 ts=6a5dd4a5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OlMwNCVCb-L7xj7jIJUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200086
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

On DPU v13, the DMA SSPP REC0 and REC1 blocks are located at
offsets 0x1000 and 0x3000 from the SSPP common base.

The existing DMA SSPP sub-block descriptor does not initialize
sspp_rec0_blk and sspp_rec1_blk, causing REC register accesses
to be performed at offset 0 instead of the corresponding REC
block. As a result, DMA SSPP pipes are not programmed correctly
and fail to produce output.

Introduce a DPU v13 specific DMA SSPP descriptor with the correct
REC block offsets and use it for all DMA SSPPs in the Kaanapali
catalog.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h | 12 ++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c             | 12 ++++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
index 06da1583fb1e..85f455a9f29c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
@@ -86,42 +86,42 @@ static const struct dpu_sspp_cfg kaanapali_sspp[] = {
 		.name = "sspp_8", .id = SSPP_DMA0,
 		.base = 0x97000, .len = 0x84,
 		.features = DMA_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 1,
 		.type = SSPP_TYPE_DMA,
 	}, {
 		.name = "sspp_9", .id = SSPP_DMA1,
 		.base = 0xa0000, .len = 0x84,
 		.features = DMA_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 5,
 		.type = SSPP_TYPE_DMA,
 	}, {
 		.name = "sspp_10", .id = SSPP_DMA2,
 		.base = 0xa9000, .len = 0x84,
 		.features = DMA_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 9,
 		.type = SSPP_TYPE_DMA,
 	}, {
 		.name = "sspp_11", .id = SSPP_DMA3,
 		.base = 0xb2000, .len = 0x84,
 		.features = DMA_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 13,
 		.type = SSPP_TYPE_DMA,
 	}, {
 		.name = "sspp_12", .id = SSPP_DMA4,
 		.base = 0xbb000, .len = 0x84,
 		.features = DMA_CURSOR_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 14,
 		.type = SSPP_TYPE_DMA,
 	}, {
 		.name = "sspp_13", .id = SSPP_DMA5,
 		.base = 0xc4000, .len = 0x84,
 		.features = DMA_CURSOR_SDM845_MASK_SDMA,
-		.sblk = &dpu_dma_sblk,
+		.sblk = &dpu_dma_sblk_v13,
 		.xin_id = 15,
 		.type = SSPP_TYPE_DMA,
 	},
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 2e10add84fd7..9a993cdfab85 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -303,6 +303,16 @@ static const u32 wb2_formats_rgb_yuv[] = {
 	.num_formats = ARRAY_SIZE(plane_formats), \
 	}
 
+#define _DMA_SBLK_V13() \
+	{ \
+	.sspp_rec0_blk = {.name = "sspp_rec0", \
+		.base = 0x1000, .len = 0x180,}, \
+	.sspp_rec1_blk = {.name = "sspp_rec1", \
+		.base = 0x3000, .len = 0x180,}, \
+	.format_list = plane_formats, \
+	.num_formats = ARRAY_SIZE(plane_formats), \
+	}
+
 static const struct dpu_rotation_cfg dpu_rot_sc7280_cfg_v2 = {
 	.rot_maxheight = 1088,
 	.rot_num_formats = ARRAY_SIZE(rotation_v2_formats),
@@ -353,6 +363,8 @@ static const struct dpu_sspp_sub_blks dpu_rgb_sblk = _RGB_SBLK();
 
 static const struct dpu_sspp_sub_blks dpu_dma_sblk = _DMA_SBLK();
 
+static const struct dpu_sspp_sub_blks dpu_dma_sblk_v13 = _DMA_SBLK_V13();
+
 /*************************************************************
  * MIXER sub blocks config
  *************************************************************/

---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260720-dpu-v13-dma-sspp-rec-fix-3938a7df3ffd

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

