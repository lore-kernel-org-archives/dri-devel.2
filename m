Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E95ACA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3839810E789;
	Sat, 10 Oct 2026 13:38:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tcgrjq2I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrEdRcQN";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2AE910E5CC
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ACUNtu3958457
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7zWhe6RjYL57QfE53DmuiX8KGjzDUtqFTFh76kpPJSM=; b=Tcgrjq2IZYJIUMAF
 ypYu39+aOM20jB3x8KV5xA/ZUqcOYHTvqeK5TxWyR/CP0XcK6efuxaRVcGCSAQiR
 gDWj+gdhnFpjhX6jN1v9NfVIgX8uhRj60vCbJ/S8UVExWwJdkF3QOL5FsFonyDZr
 xOP8qGlv/h+RI3HJpI8tXZZuAjiCJQBQ727qFRhjlx3UBszhD+AOcXZtwy3EEX7g
 ecLk58qGgzeBrHZWtUU7dlVFNpCaRI+n4JprE2w6d7KMKBqnI5+TCt9e9Xh9CAs4
 I/7CbzxXMW4sJunpik35wN4hYrVpjYivzypd1WT8TOef1k5WZCdTYvxDXvt5kKDb
 91IvCA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9rx9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 13:38:35 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3580c07911eso721623eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 06:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791639515; x=1792244315;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7zWhe6RjYL57QfE53DmuiX8KGjzDUtqFTFh76kpPJSM=;
 b=LrEdRcQNVbpuCtcYl0YOHdlSDgbMBu6NZHT2Oo0A+bh6meKONeaLiy2e+6bkD0Ycn/
 Jo9YLprU3s1Oovd+iWa0SizFR5x8AawhgupliRJKD2RGlmR6bydpZgvJ2n/Z4ZGQ/hEa
 AF0eyhsLi5DUc34tin+quWTiDcL+2YjrcXjc36YWqjKQWo58FZrAV2qBuemQALs0Vs1N
 AFPE0mfKYpoKFlUaohX/3HbAyRoP6izzDtgzs3CoLN5HLYrb7+0iX3yrGacMpsMpfQ+q
 NyzgJzOwwl4slL6fucUrEmqJWAIgVC1O7RIlhPmQuQxGNYQ8jERpqLIf7tT/qwkOYwKU
 oI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791639515; x=1792244315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7zWhe6RjYL57QfE53DmuiX8KGjzDUtqFTFh76kpPJSM=;
 b=R6hdxxwNMFc3PBdUbeSgJcJe5tDTKU6oSMwm7OHp6CE7sSIYtDJwlaX1tWRrccyljR
 w1M38DPa2KwWi7od1ubH0XRDJoEs18Ypa5Ri4B4WCzdSlYhDTnnjXgFL0rMDNbr6/JIi
 /JA9zVf/4615vFJOWRroT+6tHizI5yNAwJntYyxlahFNwsXsyHzHRfIS2WBZtcYCVY09
 WyWS9bAYPIJx+7DlnPkjGCf/t4mC9jwkf/lR0NaT2KYRs+cGDLvylI2eCrzqkbgRYW3R
 dkRa/ko19mP83KU8vx367eSG9va2INIaJ2TuxniJ4kLRluS8epF50Hdqn4pTjFSWVE3u
 m5nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBys9DmyNLm1p56x1X/UMIe+4K0OieoDMKpPfXETJA6wwQdlfjb5k59c3C/dZP+Vkjh+NDxjE+qjvrw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK5gWlaL4EkVfN+kqgZ6Z7ZIRYEwQs/LjjKV3Dfjh/770/svQPf
 hqpUy550+KIV80F/hnehdZ7FaTldalOeB+AlSUZLLEe4xxZw5wyhoOyOU9SgKCPPZhvEzVTowNr
 pNlSl8m+NwZ13L/ZQMdh9bbu97CMxO1vJ71KF26GgMcDFTuspeJy5zp9nR58qKNBIbN6xhsM=
X-Gm-Gg: AYBFou3VC59xec/ws+qFRu02AHS0GB2xtCVCHKznvtwCQHXdWso0rmdc9IIB3M9ZEvE
 zFUhrJZBXtnKAQA4pnTRsgpbpZXmn+rfBqMIuqpN+/xjiEvgNdT6VXqgAnKAzLtQLccgPjC9njT
 zMqKZcmh93W4wLek1GkBRmBo7niw3sK8U4CFFR7QFZIA7iJt2uV6URbGqy+A62NZdFJf71r/sdH
 EBx9fkq10AXRt894RJImwrHnJGhpoBQDZOPm5UbyuZGk2FW3uK76gMJriSRGEO6mZLD2u8pTEtF
 enQREksqUdCsyQi1kzdsmxscFE10Z5xSIx6YKvjyDBjAfQKMIQRUIdvvWRPvK3qw+dDabDEJDZP
 z2R6K99jph+GM97uhWKBUXGBk2g==
X-Received: by 2002:a05:693c:2516:b0:359:2acb:a68a with SMTP id
 5a478bee46e88-3592acba940mr223144eec.13.1791639514575; 
 Sat, 10 Oct 2026 06:38:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2516:b0:359:2acb:a68a with SMTP id
 5a478bee46e88-3592acba940mr223109eec.13.1791639513959; 
 Sat, 10 Oct 2026 06:38:33 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841579sm15232827eec.4.2026.10.10.06.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 06:38:33 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 19:08:21 +0530
Subject: [PATCH 1/4] drm/msm/dpu: keep SSPP priority order for split planes
 on DPU < 5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-pipe_order-v1-1-9d8bd29fd78a@oss.qualcomm.com>
References: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
In-Reply-To: <20261010-pipe_order-v1-0-9d8bd29fd78a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791639504; l=1274;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=+CKkvbiJj9FuNx/24dObi00QtFMeoykrjQaYCce+6/c=;
 b=jPzQqRLXY4oSTEb1UtWBhrvdRJwRVZGC3ezh09qGE1dARJaWLDvzvK0Ts3d4KAmNJHKBmmCCF
 8QsUH21EKI2ATdEDGGpjz/2i5zSGDPwRuKhvJuoXBAgHaMzqTSqVLI7
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6aca3fdb cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=5Iu11NBQVLxP1iIiDlsA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 9pOD50Z8tHRtdJmaUnSPYDU-BnBqAi1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfXyqr2pK7TY4wn
 DBs/fEv3H5mb702e4NjSWzv+jP4QAauScUQrPlc2AFTg5t2JroB/wJx7BGhdhra3fI2e9WrwXRY
 wF2pLVb5xobAnFSrslKdHcGEHTO6fdWxNQniLPVLrJNnb6eNYolpT0sMn1is4IKugJBnsRJvvMq
 vKgaPkPI5V6Xn6usVrSVA0oedE8EBBiLVL7NUphzbhVTx6frIG12BQvFj63LqiSQkyfOuZSAS3u
 epW7J0lj8RXChSNWo914gaOcXapQ+1D//9G9Cy/sZmu+pCPRXEMpW7N4alxA/y+xrwHCVHFdVT6
 IfK0MRTSZ2jRv5jfyUb8GgD3FKJ/vr/MORoJCQBVvC+z2Jol8NHggXLW07tsxhNN9XghndzVkJ+
 rlSBaR/fomOw1MJEKMx3Gi52bJu3CvINAp097rbPyuzr4P10F0QjevVXf9UoBTt8OsNZHkc4Sa8
 aum2Jdh/+M1qfz0wrIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1NCBTYWx0ZWRfX+Jc8EQPmqM91
 vhsiGrIvUuxg2tUUJb+3svKMl4lgkkFRUakCXdVvHPaN+YGvLwQ7K3XROHU4lGzP47/fZfFeh9j
 w6EQw7tvw43K4XV/Mz555/lqd9GBWoU=
X-Proofpoint-ORIG-GUID: 9pOD50Z8tHRtdJmaUnSPYDU-BnBqAi1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100054
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

Before DPU 5.0, the layer mixer places the higher priority SSPP on
the left of a source-split pair. Priority follows the SSPP index
(VIG, RGB, DMA), while allocation prefers DMA, RGB, then VIG.

Swap the two SSPPs when the right one has the lower index. Both are
reserved with the same requirements. Same-SSPP parallel multirect
already puts RECT_0, the higher priority rectangle, on the left.

Fixes: 8c62a31607f6 ("drm/msm/dpu: allow using two SSPP blocks for a single plane")
Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 1a471cdf767b..fe43ea9ae864 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -1245,6 +1245,10 @@ static int dpu_plane_assign_resource_in_stage(struct dpu_sw_pipe *pipe,
 	r_pipe->multirect_index = DPU_SSPP_RECT_SOLO;
 	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
 
+	if (dpu_kms->catalog->mdss_ver->core_major_ver < 5 &&
+	    r_pipe->sspp->idx < pipe->sspp->idx)
+		swap(pipe->sspp, r_pipe->sspp);
+
 	return 0;
 }
 

-- 
2.34.1

