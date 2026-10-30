Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E68606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FOnhlUmr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqKnebhL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574A31129F2;
	Fri, 30 Oct 2026 21:19:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7243D10E412
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULHIZr4100819
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cTppngQprFq
 mmQnXKt+iwIha+gqK+EmcdZMfKlGK1H8=; b=FOnhlUmr5+rfYj9MW7X8kj2n+jn
 UjGE67EHLNY3SPwAZbUqRy2+PonXYmP56OnSnn7zdYYVBHdqYwmQcmso/r2WGE2k
 Q/z7bJEW+3MBcEEoQpO3RYZ6ip3BGkBNdgGttFddWnMY0lP6c3sAiw5tLPsdH4by
 lgSvqBdzYRg7HGX5zVnBS22tqLOIv+Uy24yIr8TR4EkciiON41LT/3D4K3y9Vsdq
 GM3wR4aqAIRXeDWD0A2TDsJNt+h5L7+OFDaiw6WKB1jDlRHEJXB694plZSes8OXE
 La+o52APgWgPpqVowzHIRFhbXNV+va+7Ug0v3HfaEuiRrd5l8OmH3B+6YQA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x1016w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ae73921fd1so966008a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395183; x=1793999983;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cTppngQprFqmmQnXKt+iwIha+gqK+EmcdZMfKlGK1H8=;
 b=bqKnebhLQoM79+xZFMwQdbx2fBa7/R1isma5JvHjciD9dWaYn+xFopuixew4HXN7Xx
 E24tz9OgtJRRspmSLpJIjWu2/UXEHMwd/SGzVmMcTNiK5d/5Tg+xccZLNI4fkWEUzKhb
 Psn2yQk1jyYjQNr6vyCCezGAIiO9XOZp6ff829XB8H8uNpWSD3+XYGeFhHdcQFS2dxvS
 iF7sD7rbOA+pUkHEYkVeH8B46hnYk1sCTsNQ3nFqBBcHlCrh4BJC04npRsLlmvhEjiDd
 FzEgcYDwRV5jwgPIaQAzgshz8J4s6G1wB3G8tZhpJlhQEHJLAERL+3yTOck6xdEfxDBm
 nmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395183; x=1793999983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cTppngQprFqmmQnXKt+iwIha+gqK+EmcdZMfKlGK1H8=;
 b=baaSrb4/ozutQLjP1UFwPlNUdyZWRXDEFhl0FM0pPaHYYB9ROuIUz92WdhMfpXAs3Y
 BuNoZa06KPo3RuXbazoYp2AbRDpaxSSErKkyw14EOrChxklabnP/2rpNzPeN9xmyuVFp
 0BldCIPehiZPXxfX2H+72BS3KlVym2aAvLGhQAby4W8MWhqebBeY0xCs8aTvxvDKiwg0
 fCr0q35CjxYXOwff0tH/R7iegcKqXaK9s5dW6G3ANVnmFXITSMKMVhowYwWhs45LdVOk
 DAOn/jqj1VPtBAGedE/PhLhtOvkXBV7wymEdQ/Jr3l3RtC+LgfFRhpj2khnxlqW/D4RW
 RUYw==
X-Gm-Message-State: AFq9FYKx9Vg4N7zHVYSOql4gc1Ttux+Dz9XbCLQBgZ5KX/dFVDICehOw
 sXInACfBe29SoahBz/DMxVbSNHTjZ8DcuzjO+JBCF2o+kFmLXt0eAWTp2MEoeya3FNfJ/OVx/NJ
 4YEYAdvu42hmh2N3shR55/ysAcRZfF4bePO0NxlQQ/PR+17XQwvv3L/KXydGS1HyVB2IO4wU1tW
 213nI=
X-Gm-Gg: AYBFou3cEb9TdpQ3KmGFjdoWnR279c1w/27Ts7buybC2Azu0kQ37bTA+JofCpvqz7Yv
 sO7bFINw5x4sS+JRO34mG2EB7N7rEABhq+8vK2VOQFIyCnzYXTjVrsCAVF6N/l+G5F8Zn941oT2
 pwKHPgOr+OeLNxEWNru14YPlSqOrMihNtJ/Xurd/9xP6ZXP/Nj/cVJtWMLwZuzl9O6QagT9EvQo
 m0Xtrw0Pmtel+3sc3SkA7dqwCdi08JPNXxKnLt5RljSMWO9kvhUfbNfDhrwgRJTvDVL1agWi53+
 HJ0oG6OsDAO7conHQOZKHnNyfGniifhDNi//EEPdKWifzHuQ1J+PM4irTYfVw1AOrQ1lLv9G8nm
 ks3Y3akQQ7YUfzArRcPksj6aUiL4jp/xPNhqweN3XaHh9US7wEi+1oU7cZJhjFmvPZzmRWALMzc
 JPu+21BBFLvZz8839dEWNXK/Y=
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ae897f8c6fmr2641562a91.30.1793395183441; 
 Fri, 30 Oct 2026 14:19:43 -0700 (PDT)
X-Received: by 2002:a17:90b:440d:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3ae897f8c6fmr2641552a91.30.1793395183026; 
 Fri, 30 Oct 2026 14:19:43 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85d4eb25sm2244216a91.0.2026.10.30.14.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:42 -0700 (PDT)
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
Subject: [PATCH v4 04/19] drm/msm/a8xx: Export slice helper
Date: Fri, 30 Oct 2026 14:18:06 -0700
Message-ID: <20261030211928.45761-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jldMyqU5n6Din0zuc-7PO61snttdBxVy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX1TqyNR51z+CZ
 kQgIZqxGxZFrFmRVixH7NLTbOJHrIg5k0JzFLh++R3ZJrapNANM/Na5leAytsD35GVqR5r7ogjf
 QRiME+Wcubmh8FMXhBXFAr5j/FAgwWT2aRrlSNLrlfz68s+ED9eWUS7lgptElTZuw/BCaxjca5v
 SHCyQrJmhfMNmJUnC687CcyH8D+dnuP8u9G7nzSKJhxwgdNos0c4CRXyDuG6bXUQJlgs8HmcaV0
 wSsNS2v2jly7DVFTP8nAz51TLKjB0oMPfuxstRrD8esYHznwJpaO4G79/FlHwFFXtGflD6tT6ga
 8ximKKcyiPrs5ei8Q0qwh2PWLUhPTkSzx6L72ne11hP50AjnhHoGQsxIMmcFXMJON9zMafi8jyR
 656BcRcygXFWQZOKdaNVzLibf41mtA==
X-Authority-Analysis: v=2.4 cv=abD0Dhot c=1 sm=1 tr=0 ts=6ae509f0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=eauOX4bcPKZCCnkqRxoA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: jldMyqU5n6Din0zuc-7PO61snttdBxVy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX3NLhDbsHwNK8
 84L+orucrJ8fjOj/hMTd4WyihYsZB2SL9qnBc+AzpJXxIscb2qGmb2swBvHMJbBxTOw2+imm1d+
 /AWR0km2Jd8ktpqX7aQ6UnjT8HbLQS4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300084
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
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 2a2ddba6761f..6b23d301c144 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -359,6 +359,7 @@ u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a0983e2ee641..8e91edf16ec2 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -127,7 +127,7 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	}
 }
 
-static u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
+u32 a8xx_get_first_slice(struct a6xx_gpu *a6xx_gpu)
 {
 	return ffs(a6xx_gpu->slice_mask) - 1;
 }
-- 
2.56.0

