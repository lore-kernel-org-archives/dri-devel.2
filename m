Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589EB606D835
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JLs1JHGD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=grgPCWuT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A126D10F397;
	Mon,  9 Nov 2026 14:21:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0844310F2FB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DFLXP3588649
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VPp9DF6FAAA
 hRErFGqfT9QbAEpklRskknKR5KtgUiPY=; b=JLs1JHGDQ9pTOQGrvmwhOYZlsHp
 kZLPMCv818YuahofRNsqGr/PjsDavbzNDsrtQySSvtzCMo2XwBwwy0ZCj7KPnAka
 XWqE89GBPD7QT3GFHc3Hy17bV8j2RsJTJFC4+GRjx4JNt2HpUEjUpG9CuN1OKZ3a
 pknvJ21f7stEN/gfHshN1dpKo+cy6hUiM+z+fq3QYM4Vc0Ex3+wks7zWS/zTj90D
 KmJw29HKktrTfGcfcyelVWlIn9JkkIR6i9MgixskBkawx0bypChGCHLNAe/2axpR
 XPBiiKL/qDJpfFT19CuLFJz/tRm4s2sv0TFt0JsREswyhKLu0eg0MauQVQw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudcj8jbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so1020938a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234085; x=1794838885;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VPp9DF6FAAAhRErFGqfT9QbAEpklRskknKR5KtgUiPY=;
 b=grgPCWuT5l3z0th5MeMP9F8R7E10s770nWg8ytMd07MQwnuY2alSDV2+gaU1QWgMBo
 PCpZcN67rHjSVkqDnzXN5Zf4gJwUtOzoZ+Or2gJtggxsrapE6W973fgNXjRe/FJ4YiKq
 1XkscL7ptGVU2Tbu/tRFw4A3mLWRdyP7qrAd6iQA8XCPIYbFRcth5nMlE9rEV9m2zB5i
 OHthhhJvPepriW2jER1X8YHnSbyZWZieUGZYNaDbg0kUeAxoFAwFhkVbwrwFUczhCp+/
 aEIu70f+U1dMcJGqRwE4W2i883FuNU30KFu3cHAB+yw1GISvwfvWuVrdQccGznS8Vb/e
 //+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234085; x=1794838885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VPp9DF6FAAAhRErFGqfT9QbAEpklRskknKR5KtgUiPY=;
 b=NPAN4DlwYxoem7+iYGbG7Pgtodp+NxV56Z9M5wGzjadBStI2Mp5wAm+gGNWMMpl8eC
 jiOdarr69MqJCS+DWquaUp/3yYztaQ43c1mL8qgvLwePxN3Rtd7R4oYhhBxjoHe1ic5n
 BZtcog8sE8PqvVuJuwUgGujdDV8Gtn+muGgXPMDNmuQ8/qkorw1qkEaBySLDeZwwXhGj
 ckjlsmMnQE3YWM6BuZZuwFVdyZZ5FcctoEaJzdqk3OCieQU+vQZjsGtGufsJZX+0VXsq
 NHh6nw1tClqJzzLfdpLZMkbLOYacgWquO0fkQ+77gqDtAwWRMj3DsC+fb84ea9jLvMpV
 of3g==
X-Gm-Message-State: APuU4Z9uHAg2vQQynSZ462s/zZJ0Hp0luoPF+QrhN81TEJf7WmgHfWQp
 AxYaaeMfnXY8ua5rvTmjQFhOlC19rnKrtTQxnDU28IkOQ4qBmoklKeffDvGBuJ8sB/enAaYfkCA
 meKl6iUa4NyjBsuAxkOTrSeAkjlYQAhsGxGaCYyMT/Ah2/jCJES32ov2Kst3Rfl8tcWXUJx4bpf
 6FDM8iXw==
X-Gm-Gg: AYBFou1Ccfu24JjS3lnUirzeleWiIHPDPGwV7WOxBKDSjNwpOX2KWTuiDx55LN7ljTM
 ZzNjZQgkrzjd5aKpFp/h3PleKVBZ5IkLKpSPnWV7apZH90GD+cCjUDELAceVNiLPzyeWBSwPWl/
 LB4x+zmb0p4BOGa5pt23NtwEbOr4IlGWZmLuwQpiWgjw8ElqSsMW6gEt3w9uTimtcOllkjTf08m
 4ZBdGYl4O56OJJru9Ds6JGyN41wBwacUmiho8mJL2ZVSiSnOjK8eiVBOjpm2zslTTJ81qZ47TdU
 QCDTGOuNPE9pytYEAXe4ouzV/QWwgwXhX0RlzA7Gt3ChzU/rQNMchQpX1UWK9oi5LRoBWiAMJZC
 xGZXZt0p621RZcGZqtvCuM6ifTPS443JPshNM75cc//zlDdJ7HKYpaV0QX5IkChg/Nz0y27miMH
 oWcx2D9lVc1Z6zyTZQAnJczocKNNniqgd8+MJw3BzQpItszl9iTXrZD8wzDMPRxQ==
X-Received: by 2002:a17:90b:35c2:b0:3b0:a757:e372 with SMTP id
 98e67ed59e1d1-3b12d45fa90mr3663788a91.47.1794234084785; 
 Mon, 09 Nov 2026 06:21:24 -0800 (PST)
X-Received: by 2002:a17:90b:35c2:b0:3b0:a757:e372 with SMTP id
 98e67ed59e1d1-3b12d45fa90mr3663768a91.47.1794234084271; 
 Mon, 09 Nov 2026 06:21:24 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b105864375sm11494129a91.4.2026.11.09.06.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:23 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 04/15] drm/msm/a8xx: Export slice helper
Date: Mon,  9 Nov 2026 06:19:50 -0800
Message-ID: <20261109142111.256630-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MZn6i6cwvjV5Y8Ew2zKn_8hlwM74jWJC
X-Proofpoint-ORIG-GUID: MZn6i6cwvjV5Y8Ew2zKn_8hlwM74jWJC
X-Authority-Analysis: v=2.4 cv=au0nmiZV c=1 sm=1 tr=0 ts=6af1d6e5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=eauOX4bcPKZCCnkqRxoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX0SZhcm4PGiX3
 sW3qHiOq0/a30lXy8O4zIIYOoiz84xIn91Q2s5Q59hq8zuoW4JPZ+uTUq8WdNdU9kqgf8aH+XqC
 Omu938t5EiWfYZIuYhN7cEOnwCSk7Oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX4xvaiJPzvU2q
 vJt375vWkGru59F6z4kPxi1b/ubdojFPFaUwUUbqmnTIPGTTCssKo6n1uTXuN2Ks0iBbpy5rQ8x
 aVuNwEmIU2Hi1Y6Pd+V+WO3Y1Q8UlDnYjOr45E4F0g7rJMNVPIeqWFyITMOSSarEELTrW1TvVM/
 /ssHvl/42Rucyd1vUjgddP7hAn54J1geD03MTEsF7Wwec7I6bn5ueMoZxioIhoeA8k+12pZ1Uwg
 RGAfgl/vs6+b4dd6eE+u4FpB3zAkdmKusmtVQSYOadWYbMK4RDagDn4L+NoeMHB4G9LeVjVLfd1
 QKKIMXzcj7mSv6OO2J4sWZkhqV3nzf7w0Csv61ZGZ5rORXlDvEmBbbRn1/X2D9ka+QFoCEOuDbY
 55JKQOQrsBHkOFnsHl6uh7u5NHd0NfkVmWZDUeE9U0B6xi1ceyi3lzGAkIlimsRv7StMVItiQ0m
 CUVqeaL5q37QEiHv0RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090057
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

Something we'll need from the gpu snapshot code.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index e6ec85b20fb7..4a3898e58aee 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -357,6 +357,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index be81f141300f..a29f8149493c 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -130,7 +130,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

