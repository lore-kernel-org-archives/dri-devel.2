Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B36606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oqN/YOYs;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Co734PPw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D2C10F3A1;
	Mon,  9 Nov 2026 14:22:35 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C7010F3BB
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:22:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEx7P2927789
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MLNc8w9O9Js
 SERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=; b=oqN/YOYsINLFFogdzhegMUXq6ZE
 inCPTkSWDc4mUKH7WcBXVeyHLUoxu+3UV1WV1YP1ncUMU2rXxjIyAAd0Q0O/TVVJ
 qp4lRnk9UXjHFsn6HhAcQ2v+Y5nOwiyvAMLue6TUjIQFd15/h+rGmZKgc6al6WPk
 lraD99FMRe6mavi/Qgx2idCYdY/X1WKvmcnOZuFFYMt1hBGNLWSMAlGLsbcuRwep
 0aV/VsHoLHrVS/7R6utrbsPoIkkk/5S6JvgcHsAmU4Yr60hFyQt8p0A+7tQ008DC
 AMxoLXUjWrNiE169E0tj4/vv+YirzVijIUAzF1Ko84CDNN515Gn/4v8M41g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8rxaj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:22:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e954d87b48so15897335ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234124; x=1794838924;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=Co734PPwvFogY++gXKORuR21hTHfq8ziPndML6Fx6a5tDG2zog9lKCBwRaw/KuG/mi
 EbW0fvuG7w23ALW65hkLzSs7pgerI6SsaO9kCv4HiC4Nvb+FWsDuTgYGjjjUEf78M1UG
 u4aeWZStuohPqDaHQE6W9rj+ee+v6AAuaRb/w4sbPfEFqhDtkK9aMSVoMfyyEr2glbdv
 gRJpZlNzuafc+QlaK8gbgTcnL7W1nFl82BqQSpQ+Ofy/xEy+hsfDeYkrCR6YgQgdbMrv
 sQMYMvDrDD61q+wgPxyv3dGG2SDxXfTTqswCT3bz/BTJnnwhThHxYY9CIi+QiC4KCJ2y
 PosA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234124; x=1794838924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MLNc8w9O9JsSERbr2PEflvjzCsnmV1ZHSOeh3cczHFE=;
 b=gWk9ewV3vHyoBiBjyfHOaXNQ7jKISKMgpP6BlpiOT25dMZMX3l8a0gR3Z/72qvb3XM
 bkAqQfzYrsGstGcg8kiPU5tCJx2pPTvRAZbYb638868edB3pJ4Aq5dvCZuJnwXcXkNEp
 3E4AozYIch0/3/hIZMZ08hAXDjC5fW+k3egIlWycGRGqQLwoMVqG19nfL02+VANa32HA
 YfHqbeN+S60OLJS/qs6qb+vnn91O1Ho4DAxp3+I3FQo1+bIGNwx1flqY7O6GuSX+Z/Wr
 APNczFpaNLmrrDtYoHdReTXtO0OTvh3sXIySP+IJsu0Vrjv28AXmnOoELsOe8EPLo2z3
 UMnQ==
X-Gm-Message-State: APuU4Z/DF9Pgzj+zO3UCw1ytrepI0xhT8UhVaS3fcm7LA5mGc4GM10BW
 WK2bK+VaOOo7a7xVdahRTOtGP0vL3QAqHwH7KdGg7iLDTZh8cIyVBeaCrGBdwHRQSiYLOdwIU/X
 xjHthSfvPtQwuo4ompBMyQ805VYoSIgqfEDg1Hc/vk26m7+0HhHhAPCRk3tsbBZ873NGROQBU1o
 0pQyi5dw==
X-Gm-Gg: AYBFou0zO6dWe+5BRtw2wPF1T591I7ssTvK2eEAITeTvKynj3DwJp0XlhlmG+csR1+G
 70N/vUv+QfK2XkXoXzmHFB4G2o9sjyxVbqwGV/b0rDdC7XmNJnr1FSGohvwxprxhDHEh4cNZ8Oz
 rJBBIi7KKQN4sCCFCz7xWAgDA2Z0Xb+pc4F/l023pxd2YaHN6/KIjhm06YtbvrU7e0SKH5Fv8vo
 9J0QOI8FA7qK/CpCvMXLZrgkjFt7vJ7utNQqnhjpPDbVh4pg0+vPh/nUg8Nn2aXkFt/MBdMS41I
 PUNhEsaVv7dANbjNzUmogr6+Q9MgsVJdtSRVLwaeV9+eXvVDyXtd3ut7c2PZgNr1gt1veqq8RMU
 LK1eBjhA0qoFYfORjlQGrg6zFynD/TRw8He6wWukq9xki8v74AJjj79MII1rOxJ1Tvi748sUd0l
 3QI9H51IboagBZOZ+fLkLNqkjroTXiPn540+L/37Oa/dcuoiDAxOFGh+DoBRW6Cg==
X-Received: by 2002:a17:902:cecd:b0:2ed:118e:7fa3 with SMTP id
 d9443c01a7336-2ed83ff0b55mr47297525ad.39.1794234124226; 
 Mon, 09 Nov 2026 06:22:04 -0800 (PST)
X-Received: by 2002:a17:902:cecd:b0:2ed:118e:7fa3 with SMTP id
 d9443c01a7336-2ed83ff0b55mr47297225ad.39.1794234123803; 
 Mon, 09 Nov 2026 06:22:03 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed81728a9dsm12045375ad.60.2026.11.09.06.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:22:03 -0800 (PST)
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
Subject: [PATCH v8 15/15] drm/msm/adreno: Remove temporary __maybe_unused
Date: Mon,  9 Nov 2026 06:20:01 -0800
Message-ID: <20261109142111.256630-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX/WdyzfJdwUee
 dMfdIqfUkVe0ap2C12CUVTs2bdyC3pYYUjE54Rummmxd5HmqFRf5TGqc/DolIR/tWDLliiabpNx
 ry5nK79WVeSGS9nPROa+CAUDDW+hfrSxmBspEPnEMRmPcnmJWMhMQHy2iXOd4+/WlX6bjqDeOl2
 MDiX+1b/stho1HGw9GqsATtWox8ynMFRybdMWL6vefXcI6A64n1iICCxxOe+W9+Ux/rr8R2WfFc
 TXLKvrIr1k5dgefsgqJR3hivkjeNVCJi1zcD5r2j9WIbnY1JJPbyxhlMjMYKEr0G5lOOZ6xp+v3
 wtQlWEegBRtImLm2A8B7wo0jZx9KsxKptVQxhzAWLzrIiVR0GHkCUUv3taj0UhmLCxo6TW6nw3X
 LOpOAefu+taLv+Z6rLvrw+oHzsANlZ8rburAbl1vfURICFwburA3snev6Rms1dOR8L2p3oy7ocK
 k30PuQbKPpc7hX5/bkg==
X-Proofpoint-GUID: qKlQNJRNgwo1ZYOd_bRCbZloJcHNtCLw
X-Proofpoint-ORIG-GUID: qKlQNJRNgwo1ZYOd_bRCbZloJcHNtCLw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX56BYlPGTAuZs
 2AkaX7nqcYsMJ+vprLpFi6+nsgbbFDIKc9SP9lxzl5/AQyhqJHPM/TLbbtD1TYQL92UsnblZcea
 yqygEdeGobSd4hJy3xh66t/M63M+3k4=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1d70c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057
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

Now that is unneeded.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4c4b904a8657..c5c928c1b084 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -170,7 +170,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name __maybe_unused = {		\
+static const struct adreno_protect name = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

