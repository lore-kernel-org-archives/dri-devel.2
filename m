Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620A606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cu0kvYhj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jXqiP/TL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D4510EAC1;
	Fri,  6 Nov 2026 23:23:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 851E710EACC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo3l3015807
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VPp9DF6FAAA
 hRErFGqfT9QbAEpklRskknKR5KtgUiPY=; b=Cu0kvYhj7tB/OM2arS2p0wF6Udc
 mb1okHrMocb9MdEpYHZwewF9r5wORFgPUoKobjmf9UxKYlUzZ46d6N1NWYrmGxcv
 r0uIl+cRyBZeDhj7dW60k3RidEahbdnZ5gvvoSQ7+gAsBOjAEiGZXvnOPEJit3Zo
 QAuysBh9dBtuOv3maF1VVuwLMnfKzboBIuoTpoW17AI5/024s2xYeDCfaMapTEnb
 p4uivgN8lujzzG83laf4ckmybzlKhVvzHRol3vfhily1FzWBh+OskkmEQdTSMdfK
 JF3YxIIou66UjfOTA5MpBXy+7At+bycshZxUqXSt14jAe0IW7rpvVj2udiQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmeb0vj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-887c99013edso713747b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007363; x=1794612163;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VPp9DF6FAAAhRErFGqfT9QbAEpklRskknKR5KtgUiPY=;
 b=jXqiP/TLsDmX2Isce0XMVShM7hkcxDpqkruJ3aL6NmRRdDGPNono/p/lhVI5K6mt29
 RblpacKb5zGelTk5LGJpu3ma7XT7TdqmFAJNLX5Y9X6gls97DPkYETdP/3RvQHbFjdVw
 D2+2dga26l/qI6zNGeZx0C+/UDTs6NdL8RouBqt9UTrFyx1izAmbkYRQZIVZDnMHNHVN
 ffHvSkUjJWXtV+YTtIA32h8ZbuF8k+Hri1mgPpCiYEeYjATDjenjJ779KdSnDfZmaIjl
 vbMO4wdJhqALUpK15bD9QH/uDCES8WryCMY2ohH6TyKbanKrJqXxJW7bS3jk0F1uEVHf
 kFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007363; x=1794612163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VPp9DF6FAAAhRErFGqfT9QbAEpklRskknKR5KtgUiPY=;
 b=vjnENrZ6XGqdjGwa74aasUB9xEmheIBAHkT3Foo2uxJtrMJybiXT/DIsxh9Rb6cVde
 z8c4MKvVHLO/YVSxVAU7iB58vfk0gi/1St+K0CxB7RRHhmnkPN+ssa+78ljnjJkty0Yx
 DioV/cfryGwSj+1J+ky8in+maB7dl9bJ8zN/m98aiG4hC7ezaSogNNriO8+YJX9M6CYQ
 GEf/EY+Uw88MwTnrvGWW/GK7/fFZjonk8rhq1sullClrhk0cLercIRtDWZgQIJ4+ZoCJ
 mL3jJwW9VALDHykC7H66eeCo0Ni/Eq8+VZznLzCWjudd4e0zpbYSMB3/b9gVelV5MpFl
 xHrQ==
X-Gm-Message-State: APuU4Z+5QVk9woI/6E6lzz9EkQviURIQ+A0tXwO6o667nrj8NxBDDSws
 l3cfRygMA3bWg4nj0zBX25BDxCJoU2D6zFezjewGNNp6sUPWlPxMa0KArz5aUkHOKcuQVHDO7pT
 MsX00vY13TI+t2mD4orDgKMzcIS0raWg/HguqwIaRMSNoZPUnWUZOFwDLrnhZumMBbRg/peerTo
 yWjxDrOw==
X-Gm-Gg: AYBFou2F4rx0OWySAYAE9TC7z82I7QTKZZ7TPi4hmctISegMaQ7kUMKshr9HPtqfDMR
 BCPEcNTg8GB3SW0QiAfsRmTxBZlGqJbGTIxv8iEDhJI3SfJA1or4rwQUleIIHirRCpPc8J9q5bD
 hHbEp5F8ZDNFVq3uKhqlAdPZCcGRy0vPwDaQXk2GzMxah+C9K1AjhuVmzqfWMbsO4uDqfpijuJB
 ABiU9oIzJPwgPHnxVVAeV5tCmuRH6VtlXJvn7tysQL1IMoklW98wbOF5gBzi8skFuKlfCXHDwsG
 dULLsurjFG7gK+wt1ua7sXgFlK9nn5twDt90fYJ3UwXptxFaHNOK75v62+Jf3ik8i8Lzsmasf+G
 0kxxDORC+kNEECQXVxGwL1qcQ9B0mabt4Rj3mz6mKBunlhvfYRbITTVHpYEMHETmlej5fEKVFg3
 GHGZsqzDsjP8rMQt5mTB21xrs56ZJ5SuwqR4ETDKUZNhMQCRvmqOTROUH53exz
X-Received: by 2002:a05:6a21:880e:b0:3e0:b1b2:2af9 with SMTP id
 adf61e73a8af0-3ebb2aa0e0bmr3888494637.60.1794007363514; 
 Fri, 06 Nov 2026 15:22:43 -0800 (PST)
X-Received: by 2002:a05:6a21:880e:b0:3e0:b1b2:2af9 with SMTP id
 adf61e73a8af0-3ebb2aa0e0bmr3888460637.60.1794007363006; 
 Fri, 06 Nov 2026 15:22:43 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b35a3b3a1asm971793b3a.43.2026.11.06.15.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:42 -0800 (PST)
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
Subject: [PATCH v7 04/15] drm/msm/a8xx: Export slice helper
Date: Fri,  6 Nov 2026 15:20:56 -0800
Message-ID: <20261106232220.47602-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WlfTc86hDLCipZTao5JZUtBKEGeHpE5i
X-Authority-Analysis: v=2.4 cv=DOAacCNb c=1 sm=1 tr=0 ts=6aee6144 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=eauOX4bcPKZCCnkqRxoA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX/6a60J/VJCRu
 DQyk9Mb+xvDQPv3EGvpifTbRxOlNTDny4F5o7qeKuCVrO+H7TDvNdiO2I3Z5SqOfCFZlRv3hEFM
 6iTHpY6KHzP9tCLi7mto0vEiUNhIcOM=
X-Proofpoint-ORIG-GUID: WlfTc86hDLCipZTao5JZUtBKEGeHpE5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfXz1sFlwpQp4yP
 HyqRX9qDzLOZ7R9vpSrJaNMQWTsigOhN9Dk5y/ddC1C3BlDBkJbLCDvZtqwWBoQOzHfigY5gC3b
 etHWqvfTaaQ94sRRvRtp6/q2tZg6mCU8RgALY3dqrLWbx0QT1n0x1dGwg+sAD9mOHGpVqFXwRbW
 Y4zQNU4/veCRjiLa2Q6Lw039KUxdzhevoLDTpY+VK1xbgvGdaozekf1ZysM8Sh8FKWvGBe2rfJ1
 7DtsJXg3ucuPVJ8WstHx93XRc11stODe2sVEG+Ym2yeKYEiunKjovfC0Z+Q+4iJz9tBQ65o0y5S
 drhwIVs4MV9Lim9rH5E+TOCNZ09WLph9+1N+NPYZQNFKqej4nf1DVsBuwHNdUI2bYnPXLbcYVFF
 YoxfC8DFCRsfKHHoJiZOuF3jyYHivVzteDXTExMGc24+xqpblva2+YENB29gCA2vjzVKfui5asi
 dfW3DoWyuM2NoFhwmUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060093
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

