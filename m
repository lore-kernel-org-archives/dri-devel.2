Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3060A2602
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nXKMaPCU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KIifbzRQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C0F210F884;
	Tue, 27 Oct 2026 23:05:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC8210F891
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtDNH3823282
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=s64e3dkDh8b
 RM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=; b=nXKMaPCUL+E+tC6x5Xzzpullc1L
 9bVs2OBJHdJqX/y+E8ZcO/vyrSX7C28PZGvv/+KRv9hvADqmcYaYaQPaCAtiUnwK
 rzgfaN49iW+jpAs5Gk5tvqZ1yXAIJxCJmXIJDY52j0madOQ0S3bouZM+mpDcMFpz
 px+qCoo42jmPkYQj6/UBNrdAoCF3b36FvvyC7LMNJwpJiaUvxHOfJzdbPahWftGv
 HAu9hVvLn4Xz2MKLo8awJYViML4kiDAxkInPuNXDAoE1KrPxsQneks5rXpe2y7MD
 vC8y/tvACwKKWCwSI7RgLVvWovIAo7vCMGJLjLtHQ9el4+nM9z/Hoijpl8g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk2qe0hd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e9995cea88so2703165ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142318; x=1793747118;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s64e3dkDh8bRM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=;
 b=KIifbzRQjUeyALkZ8kWn//Nh/BnvUAKkQYM2w83420jKnvjyy2uMKtI18luvshW35h
 NFTGf3u//gII7V0cTe75D+yp3vedpB2IwLekSjMOKIZG0cYDNc9fHFbmH8nUNmJWvCZU
 6VEMTzowfEl4ZpTvmrQTbV3ejBvT8E0JTBR91N0265bw6r3htDyC/F6I6GFrDYCG6u/o
 5MZy0/MyRhVipGdnW4PQyiTid39jBVdnJLs8PZi7Rugl7EwDCVdG1m/nDQr8VlcObpwd
 OLhyVZda6wuGQtxbFrP8TPYRl1nY+MG23hDIrhzpMVUYUiD3cmifp6sXALeX0o00aTRj
 dwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142318; x=1793747118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s64e3dkDh8bRM5DK2RGthae0FkYgQUX5ZSt/5PXVdcQ=;
 b=FlX20g33Z7NHfXWhXI+Q68UqZhrSjv+K7Yzcp8EJ3Muz6JAJtRCXoPPA6FGHeRYQu2
 NvGiX27S5LLKOq+4+ZBkE0gr9D9CHfPoJ0/4sbSDKmykkgdNLS4K7XQhjAsucpYRq8MW
 32xMIVcurbqBz0inEdNGaT7fJD/MTWaWGgNjHg9hstzeydLGqYMmhfDT3+0iyZD5DorL
 Ac0FWbIrz4hB6NXz55jdiD3xTZUuK5nIuxNn+gaYUIdD/Krt1UA7rrZ2i7fpwqziuqj7
 N3pXUts/3l0e+jeGW9y2CHrJDHjbYtaSm+X6EKkUuQUB1qu5exiOwx7zwJWAT05gbIZR
 85Ug==
X-Gm-Message-State: AFq9FYL/TJPCYnjbXjHKkZESlB7Wr5o/Dyi9rnKmnRGkl00GkkfkNCvg
 nVdK6lNkQtYUTiGhh+2CrkMXvuDsD8nKJdEdGUu144YcgEUfCdEwcYVLKk4KhjfSGCx3HeQ1ETS
 xDczloXXrUP4+loCWz2h/lejS94ZWcRI2bkC+fYxAHL9zflDAm12GPLrXAj7tvMMWtmBo9RDxkM
 24PXU=
X-Gm-Gg: AYBFou2z89LnvgxpzcNvXfMoyXf7vt82xN5HuWCYLb4a4ja0V8sYkzo/KvAw+OdHWoa
 tGX8L6G+MF3TTOCbSdcVEMNOTo1bDr+oYi7MtLL6fn4G9AgCQWG625+yCOtwUTWIn3SnkQJqx/P
 o3fC2sF4v/sRIGQ7zwnsvFi0YLzOZ/lmHvZh++KpWtpzuLIy67kl5Z1D30O7ynSlmUnGMQdTHDw
 wA44Qgao1dUNV+U1y35ZtT7zkdGGjMHianOFfNMm0dmykBOLfIlITq6Su3ftkRxrtm2ljU3sZfD
 M9WqgtMW0UMUrzlqJYCHZjQe1QSVZOP/VrJIf1is3dWbcoLFuDEQl2byOBQUd9OuSM/vFccrGkP
 s3VWwIKhejR9zqz9v4qtL52byPKcQpytKiYfDNKW6JW5i0hRLVGCasFCbdgnBJLJPyGOyw83RkZ
 EI4aiSzV9JNV34Z5xvPEXeG3g=
X-Received: by 2002:a17:902:e945:b0:2e8:34f9:735f with SMTP id
 d9443c01a7336-2eb004f3183mr6574885ad.16.1793142318528; 
 Tue, 27 Oct 2026 16:05:18 -0700 (PDT)
X-Received: by 2002:a17:902:e945:b0:2e8:34f9:735f with SMTP id
 d9443c01a7336-2eb004f3183mr6574485ad.16.1793142318005; 
 Tue, 27 Oct 2026 16:05:18 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6c91e1bsm14488035ad.59.2026.10.27.16.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:17 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/6] drm/msm: Treat !mapped as an error
Date: Tue, 27 Oct 2026 16:04:49 -0700
Message-ID: <20261027230452.130031-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7Pf2KbvYCIMlFyu1d3YCC2S9IwdzJ5si
X-Authority-Analysis: v=2.4 cv=YuGa1IYX c=1 sm=1 tr=0 ts=6ae12e2f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=IbsCIv0Bno-BzyZ2rGMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX5/t0YoBQUgIa
 I8fOpXu6Q2+dqH6onjJEeI2qTJ0KO0J2NAEDHe9OxCYDVPhwXk0zRuGcPgwmO7rjCwOkjbtybFw
 C7XIZi/jNCd/yIFsCq6KzsQceHxCIFQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX1aPl7dMiaUOe
 GwoseAlmp/Ah0D2rbJsEJKQZ8xOcSOuEvYDI17Fa8bkc9SQ5UcPYJhjzG266uVXdoGHWhRhcHzN
 OcFjAbiUcv5BuQ8uBMbfVagD6ub5GYkIzS79OhWw3QdS76ZERC5uQ6kLqYu0yC2K8kcA1Xj7xbr
 wukQqEpJD+fn/7WVT+Za2ACntoF9V8WmXfrpVOpmq+/uxmC0XAACHczmQC3funHJD4T4c3lw+oD
 RQbS3liSaiySXBdhMRt3/pfio0bFUI3GpCDBsiKr2bavU4yXUXAtHo3dr8hfI8WqRiwdGWyEB/B
 PfezAdd2ARdLFpwu8cJuQAc6O4m32ZfItfrqWk5lTvo45f3KIRn8uAflUO0RUB+AaAyxsKej61O
 b/KBNQz/AOz3FfQmO8Oekw66UmtiTmtx4sS4f8DrViQu4YtQUw390LlF7s7LRNSntUI7a/2/IS8
 KEqYca2/Yn/sVcS3Luw==
X-Proofpoint-ORIG-GUID: 7Pf2KbvYCIMlFyu1d3YCC2S9IwdzJ5si
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270093
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

Rather than silenty mapping nothing, treat this as an error.  It should
never happen, but if it does we want to flag the VM as unusable.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index c2950d32c507..255972323f9a 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -186,6 +186,10 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
 			size -= mapped;
 			len  -= mapped;
 
+			/* If nothing was mapped, consider it an ENOMEM. */
+			if (!ret && !mapped)
+				ret = -ENOMEM;
+
 			if (ret) {
 				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, ops);
 				return -EINVAL;
-- 
2.56.0

