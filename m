Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03261606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ceUA+CcR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LnhAvIZU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C05110F947;
	Tue,  3 Nov 2026 23:19:25 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D55710F922
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:08 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKm9S854850
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=q9e5W7qSWUy
 RUqa8cuD0BBaWq/H42JlZYFTsfRPc5E4=; b=ceUA+CcRtaX3hNtwtUqQtfkv4bC
 CpcbX41vuEyT+DEo+RDEIb7ni23NCNcU3O+/j1FnjWT1jhaIdO5AlPf+iwfxrZPF
 D5x4+Qq57Gb56CxzKEALI0PZPZYbpogcV4+Zv2lNFa5G1/wEhFK6MbJqRjpbFS/o
 s6j0RfDSGDToLP4yVy9qsrfhDcP1v0Jie1qz7o5H7iLDOk8RnZ8B1FGUeSSxUhwD
 CfBdMc3rtRzioVNK37CxXkSMyxng5Gt3diaLwjKBSnnKE1rnD77Qq2avviviIYE5
 /5wMZZRpkJm5H6WeL7RSV57YdUgZigBomfHbnhQBSutXInEkfly/b4fYXVA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqpuv8fgf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:19:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ed00709df0so580825ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747947; x=1794352747;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q9e5W7qSWUyRUqa8cuD0BBaWq/H42JlZYFTsfRPc5E4=;
 b=LnhAvIZULw83XRcQkwnSF5P5Q53iidiO9b0TkQB7veBI+1A8+WEarzsvqVWQtV+0Xa
 QjmRUw4gdU9Tq309xLlRsbYAODTWsdf5og62ncIsADtPPYvhVwjP/B2jjyDi/411M2Oy
 wUAR8rmjPO1/yMM3ztz5vYUkndxigt7Wc43kCLhjIx6FKZu6U8MTINbUfiS9efowXbuH
 3yhoxMWdMZQlerqtHaMUX65g6jOOxKeV05NZIRfWYE0ugnMunylaxkn8ly+pJb/2poIh
 Lu1Hq2eseI8ov6ncpg6KIBh0wsCOKtwXWscM0uhDAe/6UODOhSfZT8NJmxgfrlkHEIvO
 AfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747947; x=1794352747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9e5W7qSWUyRUqa8cuD0BBaWq/H42JlZYFTsfRPc5E4=;
 b=PjpPebKS0UT03NhviSNQhKDVYX4CxMkbQXRrufpGroCHQIOo24Axfp96bonmffgw/B
 q366ZcRI4J2OKmMx6oWpzo6NQj0CXWlcBHpC0WlVRCTK+H0TRSylghxPCHQkAcLmVYhQ
 fMGL+0f50g5Vz04BrppcPMV1o/p3IW3h5ISHa4ju4iQBs3+Cmn2Mj/2mbtbgDJjteota
 GdfApekvzOzpQSMXOg+NBvRu40F8G8HgcZ8yPreSGMh5YnCi5N5esvHAxHZOa6QCTzOH
 ieqA/FmvO0xEAt7YxQSdfpe9gCEn4E82LpAFEwrseMDAed3auhVAGw9I5Kz4NftyBroe
 D9Rw==
X-Gm-Message-State: APuU4Z+0V/+BTcynZdzRgnwuR2nqGv3HaImsgUVYrwGCS8XPyjCqHluO
 XLgfGKDf8qbifbu+DmKmwDihubpO7pnhGQ5CmP3MeitcJF622SkLwkiWkHsvc1rebBSLhscvJBT
 gY2dgyUQ2vZ2qLQMFZfLgZccm79p4mPkz8eT4TEO6J0zyEXiFcdroozItPoSehwjNbq4HpK0Kdi
 svEWJUDQ==
X-Gm-Gg: AYBFou1aPbDUuADKJ2kNIkZA6xHfaCDbrpEy5blTLwBubIlLesqvlafe/2XoOT99xsO
 3ufy9KQfAHL19e4UcCeLS7K/MlX+JBL9jeyFizLA9zOdo+QQvBrmG34aBTcOYtwCUEQUdzVVGPD
 Inp8uhY04dWDZ4HPg1eNdisw9KctUJYAlI/7Czud44dEQFGWPTy5bIEGEfnbQbRieul71tI5rSl
 dxq9gpkIybR6ziPA6LoESP3zfXDuDTB/w1YjoUGzBAXqtmEom3f8NT4SiOYomY1k7UYbDIx/TE+
 eQ6/qDLdhmVKWXFMjjYxo+Yve5gNYPHsl5zudHO16F4eQPF6nahCAcJGu1BKBZGAnaLV2hqm0AY
 p9Kogks3Oh1TWuIdJSWzNIa4aVhOpgnM+izRMAWmijBmFlud0glxotf0WnYYibxb/Gb8ZORmmg9
 e/CdQJOVzlCQw4+h9wk93mtTVUat7qEXCZiEo8EQ0ee+zrpMgYtCmLs4/ePA==
X-Received: by 2002:a17:903:1b2b:b0:2e5:54b9:6b5c with SMTP id
 d9443c01a7336-2eb36426f0fmr133796755ad.20.1793747946871; 
 Tue, 03 Nov 2026 15:19:06 -0800 (PST)
X-Received: by 2002:a17:903:1b2b:b0:2e5:54b9:6b5c with SMTP id
 d9443c01a7336-2eb36426f0fmr133796555ad.20.1793747946394; 
 Tue, 03 Nov 2026 15:19:06 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed091723easm329635ad.58.2026.11.03.15.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:19:05 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 6/6] drm/msm: Inhibit IFPC for state snapshot
Date: Tue,  3 Nov 2026 15:18:45 -0800
Message-ID: <20261103231850.17493-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6SsLx9W c=1 sm=1 tr=0 ts=6aea6beb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=eWlSUfSnBrBg5eVjM6UA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: r0d6gYwrRj9xGYoLnnl5jVQxt3H_EpvD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX69k09Hr0Blij
 91vBwW2po+jkz+WP0Tk6cqFrbTdV5pAL8BJXCS9UZc2egIYBU7+JKPCuBvfhgbq1KKVmPm2eKVK
 aIjmR5Xx/TuhSrSrkFpQITt1300nbAU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX9nsz2PIkcjPG
 iA2/60T0nanFvP4/RJiIksqHYrF5ixi2KLsY1aLNiNfbw34iH0DUPLd3NigZwA9yWHY8uH7iSYC
 Z1zzef+EOErkqtXoiQvWd/hhdI0I194KbJbKlr06crqMfTizSAWwfuMjYK5mkUzxl0t1tzGPgwE
 iymTTD3ByKrx2xFBgPfmE5urMIRTTmBWBotn61TFC5vw4NtdzQ7iYMyzyku/I6lEAqRMwOflb49
 g1X0EG0AQwpLvcg3LaxWJ0w5T+HBqDP/u8+TfqkGY4ck7+IZ08Wz3WETHcSNNNw8xz5jhg4r/1f
 sWqmHY4DicMR3pUYqolvvV3Y+YFClmZkpYZm8dxSGD7+6ribPw+jHeUDc87je00m3kHnDQTGmGg
 igjYVk8JLb2kV3sKgzC6fOuXXazRpTdjCvHpctvwLn/EZ8S3g6ZB+fVZc4FN/lZPC/NOJ3OuOb6
 a5wIIXfwW1NgxKU6Ipg==
X-Proofpoint-GUID: r0d6gYwrRj9xGYoLnnl5jVQxt3H_EpvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030092
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

We need the GPU to stay awake for this.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index aa59b28a3392..45df35d3cf90 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -83,6 +83,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
 		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
 			msm_gpu_hw_init(gpu);
+			guard(ifpc_disable)(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
 		}
 	}
-- 
2.56.0

