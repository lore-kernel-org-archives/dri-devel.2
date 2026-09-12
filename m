Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4874DC88E59
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 15:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC8E10E71F;
	Sat, 12 Sep 2026 15:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TT0/FNeN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3P642k5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8660A10E71F
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:09:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CEdijb3250011
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Y86yJvxE2YzZDSDBzkxgu7LIWB5oUTdTWrV
 QFoYNlZk=; b=TT0/FNeN1dsS79JksacI3EvHp0CovXEJEt6QGB7lEjvOWzxQqpl
 Gl/8W1SzHH18cQ4ymfen7V/dJUesODf0zWAlg4elwA4xH6ZkijtfNeQ/eTQ3MRXD
 soJNgh4mTEVbzY2WvZOLnAQmh02srKNypq9b7Hhdr6CWdPTc/jDO+2qV2Au0QINt
 hXLlcH2/i6BozM/eFtfNkk7p3tu3NhMbxzt4BgMoGYvvbAknCgBIQ+6myYRP/Z1O
 LjodWYLxbSpgr41gBaEFsYNfYAAdwofSWkkkZGReAzjHqCB8bwL6pBS078hAaXCh
 BaRh1ASLbHaHaeZYZUGk5F1PC4kn03pwuCw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c174u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 15:09:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b8088202so1645244a12.3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789225761; x=1789830561;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y86yJvxE2YzZDSDBzkxgu7LIWB5oUTdTWrVQFoYNlZk=;
 b=d3P642k5CVuI4Zsd4olyN/6vW/JK9wX3q6BMnYmV3br0ckO8Ssasm5F/JouM3Jptja
 cuE4J1yQ84njGokSgudgHlJN4Ny6izyUrGyPmMUBG8vSqw3Cfbm3iN2pnEoTZgswYcZc
 UaddTOdkuTmFGUij6bPYbzhcEwvZ8fi3KkJPJCex274fT1Neu7L1Wxii8KZbxAMmFgvx
 SU0Jf50x4NQ02O2VuE0FkBgRebQ/ghyTh9IFLMeDxQd6OsY9tJR1oeGK2LLNHAlU3P6G
 NknynHqnZXD090hG1p9bJhjsgDL5frTD0DfebzCWDlkUS0sxJITL7ek3k/kEghpV/4YN
 7Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789225761; x=1789830561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y86yJvxE2YzZDSDBzkxgu7LIWB5oUTdTWrVQFoYNlZk=;
 b=j/BNX4CTzq/bNsE2G0yaow03GxIL+/dBY+cvlrJcf4Hkt5Az+Sxi36bjhYSv8pDal9
 vUOvK/kKtwlVfxTKP+ueMY7ILUVSSfEF9evgUALnmwhNLFfLVqFAFfuR1WRMLUeils/5
 te4sQKLWC0nK2Z/ctW3BtCDpwXbela5yTBa2UzRbxItjPIiX3HW3W5Lpf7c5GFE18Orw
 CF8wqbUtXq8jcBSPlRhfDSrj5XoPN5fWrYnVGIXJ8c2oeSoQSPbuJ05eh6xwK6tQk+yO
 tLcJ/VzSk61mevr6ptQo32I2QAd6jnwUiQDfIu+84Xx2YgLH9BFpm45oWoS5lBgSAouv
 +rjw==
X-Gm-Message-State: AFuF++mB0bz55YewY6Fd1o9vKiMRJItb8CRj6ZBDlC317Wsgn6ME8O3O
 3894/p7JMBV6nBSPMlvtJ44iLMeZu5tJqN52yVf+xyCgxJzMFgpBLBVoGISN9tijUwGivgLBC01
 4tGbzdyfD6yM1EXIZW3nbEINQ/Ep+FNy6X/f5rofMLAY+PeJ0ll4aRSuSeY4930GZ4gpNxdmVSW
 X6Pek=
X-Gm-Gg: AYBFou15s39KIsF5RDwOa0+moMp4y0tj2uqc1Lxx8KNhh1dopI1Ft9oQTIkEwqd3nPz
 RxZoVvhTMj2k8w9m3XjUzvDU5jGORy7xb4k/nER8vGRPP0zXxZboEjaPJFZRGtcWds+A7nepU4e
 I6FfoqegwsjVwlYrOpyAZhywiQTyNBjHkFJqXzFr1gDZp8zurHCNGUJO7WrBGBjxHtlCrYwYVkH
 f/bra5cR25a5B0jzMosN2galziVxPSUzzup7npXu5bsz6ZnX/BRrAlw5oZkaAOqhi/17aRXZbPZ
 kmknD6t4cUM1amTrVp2NzB5fhpxaPZcrDCCSeMORhCzuA4nCNUjv2EtOHLkXvl3cA8tddYVoGK/
 7aGfNxMpvVtu0C0YSWY6ZNn/OcnJceRbF4arg03m41NlO0BY=
X-Received: by 2002:a05:6a21:6016:b0:3d1:39e9:b261 with SMTP id
 adf61e73a8af0-3daecb013demr18650576637.0.1789225760840; 
 Sat, 12 Sep 2026 08:09:20 -0700 (PDT)
X-Received: by 2002:a05:6a21:6016:b0:3d1:39e9:b261 with SMTP id
 adf61e73a8af0-3daecb013demr18650511637.0.1789225760410; 
 Sat, 12 Sep 2026 08:09:20 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc4c6549d95sm2564095a12.12.2026.09.12.08.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 08:09:19 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Greg Ociepka <greg@ferrisoft.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx+: Increase GMU FW init timeout
Date: Sat, 12 Sep 2026 08:09:14 -0700
Message-ID: <20260912150915.28700-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yjPiPjw26rx2EQAf7ccTz6tDJBRCu7FU
X-Proofpoint-GUID: yjPiPjw26rx2EQAf7ccTz6tDJBRCu7FU
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa56b21 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8lTVeMJbxB4f0FvlbnAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDIyMCBTYWx0ZWRfX40FoICTO8b+M
 NbBiVwxClAq0Zy2Qa1UjT8tRPfuPM2Juk1W0pW8eoOouJ3q1UN8jfqdhb0kliPAZhNxgNy9twY3
 XQkfwEQHTktd3UzKOVCU6ah4c4HjcEGzRyh7+9hhbVzIC/YQWolQ5S/4k+QbKnY9egA7MIYVKnA
 JJ7IocI3MW2rxoeFJD+mgsvnpNWPS2GiHKqsSNZ69Tt0X6Z+jb5RLiUpTP9W7TYUnI8uezDhTYe
 K5fyKPy9r/MQR/hfxV0spl+9hUg08Rhg537Si4D5QJAcVYXC316cxFvXJ2JbSObwX86HrtW/jgr
 I9o1DBj57N25A4xtXmlooHFDS+iCwnbEZL5+vIl1qFAnr2WBnloFlRP7jpn57T15WwjRLSor2/7
 idcMO7OsRMuBokcqvrihorrBZ9Qz5Al3iOhTyLKVw7693Oi/DEd8ymBN2nE8OF5YJfiJX7LQ9kR
 +sJUTjiGR+kYjpGJKKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDIyMCBTYWx0ZWRfX2Dzv7WaCfTda
 pw0CTH83sEfoHhTc3oZEmAShd/LwEnXY0Vx3L45a1HHh3ADkEknszuHc5OPi3FgKxab/Oyw9iFD
 Jwr4dijRO8wsHwLe2Asj/91fCf4YktY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120220
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

We were using 10ms, kgsl uses 100ms.  In practice it is usually takes
less than 10ms, but very occasionally goes a bit above 10ms, leading to
a "GMU firmware inialization timed out", from which point things go
south.

There are probably some things that could be done to speed up init, like
increasing GMU freq.  But to be safe, increase the timeout to match
kgsl.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2170bf7bb045..9290010c8cdd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -320,7 +320,7 @@ static int a6xx_gmu_start(struct a6xx_gmu *gmu)
 	gmu_write(gmu, REG_A6XX_GMU_CM3_SYSRESET, 0);
 
 	ret = gmu_poll_timeout(gmu, REG_A6XX_GMU_CM3_FW_INIT_RESULT, val,
-		(val & mask) == reset_val, 100, 10000);
+		(val & mask) == reset_val, 100, 100000);
 
 	if (ret)
 		DRM_DEV_ERROR(gmu->dev, "GMU firmware initialization timed out\n");
-- 
2.55.0

