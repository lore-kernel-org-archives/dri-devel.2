Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E146606A92B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dkN50QIs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CY113psK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E2210E94A;
	Thu,  5 Nov 2026 16:42:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F4410E698
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:13 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQJWv2004738
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ioes65rnfp8
 5b6fEnzRJDMNqj/Hc3qhj+ZAMKqnw94Y=; b=dkN50QIs8Rqv6MLkEcYPaicy7Bj
 b3MLYjvVMoBoR2Ephi8W+2+8dYc0IDpPH/McXkw+gPGYvnuXkgOuqzrantsYat1k
 yvtVR74hDDQvTx5aZUP8hFkYXmu2mwGSxNK5biQKoANsdVbK3xHuyIlWa4SBvDX4
 R7pX/pVJiSKukgtYTAP1kC98jq/qQM7h1ngOkI9T9/Wcdsr8QFwRhIwIUIt5RZx8
 n7xWN7Smy+SkBK5e/VKVJspJ729UEubZzy1B7m+Xb3gYctjUGfpeTuw1UTNrEN3C
 q9eCNqs0Um2idqsLA1ge6yUOR86Ny/fowLP4H+KjlrM+s/qp1RLMY9AuGFQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd1py5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8b1ae526035so1741334b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896932; x=1794501732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ioes65rnfp85b6fEnzRJDMNqj/Hc3qhj+ZAMKqnw94Y=;
 b=CY113psKIz/tmUIoKWD7HS1xy4zFNx6eP3/2ub1M8GQXTdIbvoYfbDw5LJBsVu/EWm
 YgcXPvzKkqTrJSj0ltrErhDUf0+pvOTZm5iObXSox0z629bKyheBqEy2geUFXnLWAQrJ
 GLWhv+03P4O1W8yFFMTwBu+Sm+IDSDC7tIXUc+BxOvmSLOi9FvaLOjF1JCBqaNaoeq4w
 oS1NvVLZWrNQr2/Utrly3ws7PmV0LSTUf8+wqYRzcB0eygUX9WupDIqnmZ8ZxiygeGDr
 I3WjOPc2rHLnlofLqgHIQJdD+s5XGRCsS25h+rxR9imXdogTqA7WP59FJmkdYoa2zWXH
 glAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896932; x=1794501732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ioes65rnfp85b6fEnzRJDMNqj/Hc3qhj+ZAMKqnw94Y=;
 b=I2ia8UHNe1YFRTkxLF7rs+KcbhsIKO6NlyfIDr1DndWo4ew/qHtU769FYPREhDjIeA
 awT9HD4BemEsbjqy4eAAj4MwRVMF65K2n74jKGg7KPRmrjciKbbsNyoZSCqLor9Tm+VG
 aKep9yt7BS+11OgWxkHyx4GpF6N6+nZtz5fVKNjJto776FnA2E5eM56pD9RSomTVTi5M
 OwsAYWqU5jMq980PszunNF8iFxJZVGjv5vz9NuwpSUJi88BKi9ox+uBjMihoDDD+Elcr
 oO1/TecODBRzz6r3IXH9B389Xe3VFiAxRa/S11znSjZcYwMWb590GyKcEYLcJnuB951u
 eUZw==
X-Gm-Message-State: APuU4Z+dW2GZmh6FEcDhSlgpuGGp0C7zP9DEs5PBrhaSRTSM4IIyqIGS
 laTOhHFdN0d4VZtlw3D53ByNjsG2Ysv6SsO3C2KoX2jX0vsRqqGfNbsrWDN3sfQSttl3um7E0N9
 KBZxaIs8mrBKvZaOe6eCZj8iTWUaBPUSIyiZLBrJR/VBU8iroNK+j4UA2TLF1AnEGieYT9YbZDU
 94lL8NhQ==
X-Gm-Gg: AYBFou3bSpVFsx0AExbm5OgEyULjMy2PTdI/K3xiFGvNv43CkK9YOOap97jVwP6ZWhD
 vgy+bhwECqQytmvAJMTtA7U1KNgpXQkpZsJ05Pj/pv5JJYSdS9ieUBV/Ok0idO658dZNqQmVWDl
 1YoUQzokSKizEI32DChn49gQkT9G528Ficgz0CnnCytltngQTIo7h8lmjofUT8s1M1/G5p4tPkH
 jiQmBsgo3hacEHUJ/Sg/Gf3z6jrxUy4Vyepe8jj9yVuBqg9Xbgy43yAD+Ysf/muAQCzLEaDRhnu
 HNFuI7+hrJFT/70AK7Q/3pWH3OMOMlHHc5+wnkqyr4iulWl5CBml/q0iCPZq7f92Lip4WNrZMAM
 hiJyPdJky1uQDpI+qEW8r71FERdotFwV3s1ndbDoyArgCd30OAC/y75dqkAeovcuB6OgS0Tl5H6
 4ughoY8tIlz4IvAM6IWTxf0MrJADWIVZemKO2faOF1l2FBGSWgOvPxtt/UPP5WtQ==
X-Received: by 2002:a05:6a21:8889:b0:3e0:b71b:a8ed with SMTP id
 adf61e73a8af0-3ebb297fa62mr52186637.13.1793896932545; 
 Thu, 05 Nov 2026 08:42:12 -0800 (PST)
X-Received: by 2002:a05:6a21:8889:b0:3e0:b71b:a8ed with SMTP id
 adf61e73a8af0-3ebb297fa62mr52152637.13.1793896932032; 
 Thu, 05 Nov 2026 08:42:12 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09bb48410sm2289079b3a.46.2026.11.05.08.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:11 -0800 (PST)
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
Subject: [PATCH v6 6/6] drm/msm: Inhibit IFPC for state snapshot
Date: Thu,  5 Nov 2026 08:41:53 -0800
Message-ID: <20261105164158.23263-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX1YbgBPIAsaPH
 7mmDc+Ic2rKutyBoSKm6c/LQx+3tfOgW6pYBzn3scdlx3mbtSSyM9kFtTYnSrluPXxZsSC9QXv6
 W21QJqtO7ZE0qxqBV6RObDjIAJdes+I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfXzad7hy3SPwJa
 PF8MhHpmAPyhxO5lrTFVQXij1Ob6wOhFMfbN9JQNxFHanJNrw3F9d/fzF+ocXOz12QjmTrTJwry
 w7dHM1035xSgV28zFTDJGSwF7A/5nbRNORyDpFk3L17IxfHYdwcicnffRwNDNLw0ulhDpCJoryC
 jRkjADkLqvgpvREr+pgRKLkOi0SY3Q5+k2B5Jp7FNzpAPFKhyugJd956/h2BvmCSKGkeceK59IZ
 LrcaS3RfDcv+lIY54j9Jzfbt0azvugR018OpSbPUgcjGw0HcteuSc64sZgOhC5EsKVwHPbY/cXJ
 4+ZtA4ukIcejOft1+75CJzONAsEEN9HGogA6RFIhTFXp4RB9ApqEbZsDxH9dqQFl8eeDwwto05w
 xc2cs2zz1zU9clB+wiyIJaRxtAuc+gbHXbqQUaxdKUXR0Vh8prxCcRmB9oxPWIOgKYZe/QzDjVo
 QHgRr31Rgoqp7Y4dZmw==
X-Proofpoint-ORIG-GUID: ClOfLYeT2vSAoex_k39oXa5UgViNMU5w
X-Proofpoint-GUID: ClOfLYeT2vSAoex_k39oXa5UgViNMU5w
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aecb1e5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=eWlSUfSnBrBg5eVjM6UA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050066
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
index 98f67b7aab66..e6c872ed1a01 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -83,6 +83,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
 		scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
 			msm_gpu_hw_init(gpu);
+			guard(ifpc_disable)(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
 		}
 	}
-- 
2.56.0

