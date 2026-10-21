Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA77606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KomGYbzb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TgvVjWOO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FD410E39B;
	Wed, 21 Oct 2026 20:53:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D3A10E2B5
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:46 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeEa12160406
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Jo2sX9VXnBm
 xIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=; b=KomGYbzb3jXoGHSGWEuHqRomgpd
 NampVVt4ix6+D6ZppcScq7msdaj2lBWsMeOcy/NLdI/X+F0rbHKHkMPpvICyjqx6
 5i82WPVqVzcYBesDi45N67vPlR4O3lMHCKpGkgRNdcgoPNabdKxLLxD58Tp5rBNK
 6xFzMaMpFRnrdK2EyVYq3DOTSY2v9mgsiAyvR0OeYC4Pcw+d9W44c2wa/9sf8iIY
 gpXT0Y0tcUihMCHVuVQDNgpc5nekpzf53YuMX8JsRMASz5uRrpbZCp8pmyFo8LNB
 d/NNhl9vE8REIXA1HjEYPrPnKqEqBnABDY3u6mTNqWWY7dLnUAcsxdDhLJA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3gpnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:45 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a0522cdaf3so826893b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615964; x=1793220764;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jo2sX9VXnBmxIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=;
 b=TgvVjWOOaUg1jKrPsh57JWy+imlIGY/+WMx6DQtHd9408HjYwR27RUYO+8rsNd7EBI
 7pBqhiOOXOrGfvS1M5D3hG1yYGKB3YpuLMhnFOTZkW7aPtXVEa+7UTnRIowcimQTFPqh
 7cxAsXtAtbr4AZPIkuLA9PkwQ1lk3Jpw6z3nxTZ7evXizjz4krOkJm9O/22jbJzb+Lva
 /fZia1u9bnaneBfQsUzgqLQtgJLVHeD/kL/kHJxyJcCr6fgwQhzXBQvxXAPQvnR0HY2f
 DZVSWdCqAg/A9WNEpjZEoiHM3ptxqfOFLDhm6/lwTmZSWRY5LWtndfuWRI1Z4PsWgyWD
 8kJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615964; x=1793220764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jo2sX9VXnBmxIbRFzoUIj/cFn9yYdevX1yQtu2aR0ms=;
 b=2DU1OLktlINCbpqNQSvhdD0rOJ5L97QzCPMD6Dq1dDdkFS/Hiy1HkMon6FJ3UOht1W
 jmZc7oi9leqxdG3BvPcGfnSxG2rbvoVY/5Bywnng4AQwL6vgMmv3u02FQr2xLVUVoCRD
 1vQVLf5U+l6SXyzE8XhErPgjdLDc+7EcWvyGC87segIY3TsmyUdhIuVjLDSPB84B7/ST
 cINpVvB866zB60OhtilknOwKR1oASRFtDz48EoG8FFl9yB0SC7ZlH/SQxAgY23YXdkO4
 YiizXkDaFkvcDxTPi10g5z0Wy5IojeMONXej4hWN6tgm+xS1xL3xPcrfFyMePPFQkRIv
 Q0yw==
X-Gm-Message-State: AFq9FYJ5AjFtDlVN6Baf1HpR0CKqjPlqev/KTBnmvf4FjvDlplmL+Wc3
 6VuH+bcU4W2kAiVyJk3GjBAdJyob8x6ZdLoTRhoWLmx7aWXKxCj6aKKmY7lRqD5eZh6zdP8BLSX
 f6BD9UKexryFF6So2aSo1zgFMWS9ZcMglOYcebz3VAVeAc0CkNzDKyaUqRe9ZVV6a59FL2F+v9l
 Z3cxI=
X-Gm-Gg: AYBFou39rl4CPTTZ+Z8rohpivImNaSoqdMxYCKiyRMbhIVkqv9bT0MMJ6cxfuNSSYVD
 BaoRr9AbPyfg2AI+6l017QL9eD89I8vXAOn5HjO8QTYnRe+kxGP68vKR1sANTrI1bIiVrziajrz
 zSsnza9Gwnb7wgaT2N44lRrz0opwSiKp00pAWExznAGGQbllxHY8JEwuuHjH6+ZNiz7yxzZ70wP
 UkmKZenXeF5iJ4uL4/Eh8jIJT2jiBmP4SD76k3+E+lJHR3s933W778azJf42R+P1gECJKHspsAd
 rGBqiEeZKgHoxqQXqLEHYB8dOJ924Tx5cIXKWsiSSFKdCdcsudx2L//LmCkjxNV/JtFh0OInuma
 YAY30m65hg5jX0vG7rgh2k3tF51B3kZpX2WYdvTGbj1b7uEp/lw==
X-Received: by 2002:a05:6a00:6088:b0:886:5938:cdd4 with SMTP id
 d2e1a72fcca58-8a089cdffccmr2433972b3a.19.1792615964288; 
 Wed, 21 Oct 2026 13:52:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:6088:b0:886:5938:cdd4 with SMTP id
 d2e1a72fcca58-8a089cdffccmr2433953b3a.19.1792615963890; 
 Wed, 21 Oct 2026 13:52:43 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0895db551sm1362064b3a.34.2026.10.21.13.52.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:43 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 05/14] drm/msm/a8xx: Add missing a850 ifpc reglist entries
Date: Wed, 21 Oct 2026 13:41:30 -0700
Message-ID: <20261021204244.67160-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad9261d cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=h-8skOKhzxl6Lr9m04UA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 9lkHJ9zCQaiX8Uc3FG5QYr7mR3ydLcyd
X-Proofpoint-GUID: 9lkHJ9zCQaiX8Uc3FG5QYr7mR3ydLcyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX6v8jnbGCHuqS
 tq0mBjAFOHMFtriczzd/AoKCmYiGJCoW4wogVNOwmULsP32joCGEg8eUadNgRI+CNaW5hJZZbTZ
 Y0r5c+GnhIfwNeCRYgcZ6ntx2jU7dzBDB/Nfk4DlG+UtOBV0g2x93XiQlqg1aAxxTTpZffHXCxH
 90MvKoOb+LikPrzu0ykVCIvosf6a/VvTLN+sR7xRSx12SxKIRDtIu7DEVgU7cjPJYRoRDLIxL6O
 mtiY1k4thj9odixVD+ioepyM81/PSgZGEyG8v3E8sku6IRvd2MugEbsizIb6jhckqgKvl5mQHeA
 Ci+4ttTbib1bYgBfnEFxwbCn3+rRbovU4nvv/ag5NB2V7ENNRi2wHAgFjMEQ8SV44ogbjbhck6G
 RXXMW0uW7SnXFBzJ7ONV7IZup6n0NBC8vtARHqr7VXa2nB1uzj9ofSiSEVbGesA6aLH4/2u2EIc
 znxWga6Kpu1SI2TC3WQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX01AxmKDwgrKE
 uQRnaWkMv/1jOII1Gfw6Lfw4h9Hz5+DUZo/MG4OBfLTT3oVdGeoYqxES/8TU/fFnOtBRt093X0f
 zQOagxemVLCA2FAZ06YyUGiy22H1Znk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210083
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 55a805ab438c..45cd986ad4b5 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -1477,6 +1477,13 @@ static const u32 a850_ifpc_reglist_regs[] = {
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

