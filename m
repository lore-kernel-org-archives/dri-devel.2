Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23B360805AC
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pI5uQ4ai;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BXIVXmqr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF31A10F04E;
	Mon,  2 Nov 2026 16:10:20 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5013310F07B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:10:09 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpBg23512197
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 16:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=sAmuNonNdGJ
 9VJvNEnnfZOa2K2a3VEiqk//+WGZEfFM=; b=pI5uQ4aidauBV1Z5mj4D6J0tDJe
 ECsUWDqSY7Wgr4bvScLMnib4icwyWQfQXnpfpF5KaJoU9tIYP0OfUeKGuaztqCXE
 4/85Kl6vxCXhQGaTJku8DIwCKLOLiIsLK3bFfpQHSTfeHd3NqRfzuwme9GjUHJ6b
 +SxB+l0US6tdi6jGSgu6zwevolxiJcPqkeEgLUtCjWYL+qtsiVgG1ootUFkBjNGE
 GOwbTkQojoj3BxTXOLMiZgem32gn7QcMsTiB/jlDizjZ0g9fyzuZJ23QPq5s5Dy2
 xDZsR80TaSOCx5hh+aXH8u2404KQi4w/XkwyISdLRuEzd7jNktNXuRfWuVQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqfrhtph-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 16:10:08 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc7d2ff0087so1941670a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793635808; x=1794240608;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sAmuNonNdGJ9VJvNEnnfZOa2K2a3VEiqk//+WGZEfFM=;
 b=BXIVXmqrRe6bYCN61sdAdCpadZt0BEwqb46uwrIul0jFY0TwNDy8v2JMFwpQWNSZbV
 ThXOyF+T19K2LqcBnZSXtlWhQ4Nt9A4nNWbOvL3VMAt8UeOgj9qN/c0mTbu1+r1V5TiK
 QcaHKpL3cs2v1D1GpeTxLJrOZA5eCaXfDAZPZRiGx3NMLpgHyOuFVDD7um8gTo4M9xVO
 J9uO7dYgscqJPrQNMRXqiZ3qlZ3b3iC9Y1wHKNUnPWs+l4Ie97wmJG6AlUwTf7o6c3ZA
 upqCKe0+ioGDqwFJSaQTy1iYCzQDNvHdYe9ldccFludy8ReF4UFBlm7ZLbfu7429754j
 7LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635808; x=1794240608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sAmuNonNdGJ9VJvNEnnfZOa2K2a3VEiqk//+WGZEfFM=;
 b=LTtk7S4MiGm9wakkkHWPwEh6zSYBS9YmNqZ5FqDR4XAZMmY0OQlFkf6mgpjgKSnRuL
 63FrCAefDJOzfelFakKYH2dFmjys0gbIYYwnGTo8S6IYw2vP72l6WQcpYQFtvbzhtC7D
 9WAzgZDgw/l/zf2RRj+rObEWvHmShwtCoLVTF5/1iCQcf1tXqfq9ZzuZWZW2mZ/qZY9s
 bngUZcB+slq+9+W8pg2ospN4M8t+mwCGC5ojLMbKIpszjsQkxoVaN41Xp6KDLD3l5V8j
 3t13jy4syX7crGVFFx6x0E6FRdgcTy+ZvOryz/ahQ/nV0tu0m/T5UB0r48TeP6C4BilQ
 9+Cw==
X-Gm-Message-State: AFq9FYKdx8TEUpOkMIc5vNL1FHWm1SqaC/cd6RQ+ifG1nYUdwfoEeZf3
 BnA7rugTI543swbwQ3Pd2YHiAHqUKwMsL5Dj57GVR4niS4owAmvUXGC/xURxezkRQn9xztTlwQR
 PBtAd0ji9sFDW12u8jn1oaEwAPjgRhMirj3X+QDLhvhP18yS7VYlT9wKSHHn6kbtT5eSr7JeM7h
 5Fr9URUQ==
X-Gm-Gg: AYBFou1f+XqnzfId6wK99yMtpXcvLKZOqq0d0THL/bjO419VpRFw4rntKQLWZiiC+Gb
 BYXeVWUx8fu81C8+rwmAGUC2PKQ59c5B9UcdAWR87320Y8WrKMNBky7DPuiiTtLwb6xxxXq1bpe
 Jbu1KLUonf2P8mjN8ocMJwGuUsLP/wzGv4pgWYoOmDg2RQWkKtR6lCTNb82EXDy4uoHViTgg7rS
 RN62UFMUcTrMYZPEIXyp6PalweBZIPW+mO1qqpuBmos8FyanoCGvWv1b2CRm6T5bjz+gXlQeEDz
 72+0C/VxiT/4O5nw0JQ1RaDsqVR2AGkjUBswJLMk7dDuvChZu03h+lZpx0jhw6mGPL37becUGwe
 6yhsd+JiCuzCUunuwujbCQVaECBhOzQRaesFkZ23iu9XLMZ6PiMcEE+1Pu6RLlkcwi7IuOGX4uv
 sGEbznIyC/5d4VX63ZWord7Ew=
X-Received: by 2002:a05:6a21:3b46:b0:3e0:d5c0:74b3 with SMTP id
 adf61e73a8af0-3e928e3722fmr7511708637.65.1793635808004; 
 Mon, 02 Nov 2026 08:10:08 -0800 (PST)
X-Received: by 2002:a05:6a21:3b46:b0:3e0:d5c0:74b3 with SMTP id
 adf61e73a8af0-3e928e3722fmr7511686637.65.1793635807545; 
 Mon, 02 Nov 2026 08:10:07 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada9aa605sm2219688b3a.47.2026.11.02.08.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:10:07 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] drm/msm/gem: Fix VM_BIND range check
Date: Mon,  2 Nov 2026 08:09:59 -0800
Message-ID: <20261102161002.497152-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
References: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HMJWhYtv c=1 sm=1 tr=0 ts=6ae8b5e0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=BFYDg4fWK-pXFiMG0zkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: -LGZXMna5iAqZ4pLyZ4OSZMayiSmxCaO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfXyW+XNLuVcLr2
 1MBIRJ6lwUZWm/yQi9hGD9RlCgLSBzVXMrWzvnILYRdFaZdHPHWfH20rjzpCyJU0xNC6qkqqZMR
 kbLRoWLDIbmfTixJhTvk5l2jmPEL/yI=
X-Proofpoint-ORIG-GUID: -LGZXMna5iAqZ4pLyZ4OSZMayiSmxCaO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX0t2i5B0Jm6RD
 LZ7exnp6uQ5/Bef70BU14QNua5YjMqG2cHNFykSUxTlhbURjOzbFscOuXFXud/b/ZUQOfgThkvM
 oseu5hXDNASKEVPiIcKyJQ6Yrxrrm4Ed/Erc0D2Nq9BM9etnokFMfBlBHeDZHzoZTK34oNxzLC2
 WSiJ05SufrZgELexYtFn/RhaBkLHd/c68/MchC4pKo0UBw1P0fRTTZ0XlU1GbbKhBGyBtDphfQo
 zLjmH4JNnI9xp7+InBxhAgmF/8JlJXwo7qMzOcrzJFFzhVYtS+9j02gAWSy5N5aBO8bPY5bUgQi
 pXlHd9EE+iGETrh0T6DtzqPjr9iEeufbgHFjKxUKZ2djTzVm8kYK/xVcOK5WFIZLj3wggxPDtxX
 azMH8+HJznJ4NSPMVVTvuAoKKiQtJMfINqWi6DmKLk5UzUIFSDUuguCGMCwmiuKM3bPgZzDdAkF
 jOKzBXn9Q/9kZZ5pWqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020064
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

Use size_add() to guard against overflow.

Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Fixes: 3a3bef68a6c1 ("drm/msm: Fix missing VM_BIND offset/range validation")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f687a629629d..922285537dee 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1012,10 +1012,10 @@ lookup_op(struct msm_vm_bind_job *job, const struct drm_msm_vm_bind_op *op)
 	if (invalid_alignment(op->iova))
 		ret = UERR(EINVAL, dev, "invalid address: %016llx\n", op->iova);
 
-	if (invalid_alignment(op->obj_offset))
+	if (invalid_alignment(op->obj_offset) || (op->obj_offset > SIZE_MAX))
 		ret = UERR(EINVAL, dev, "invalid bo_offset: %016llx\n", op->obj_offset);
 
-	if (invalid_alignment(op->range))
+	if (invalid_alignment(op->range) || (op->range > SIZE_MAX))
 		ret = UERR(EINVAL, dev, "invalid range: %016llx\n", op->range);
 
 	if (!drm_gpuvm_range_valid(job->vm, op->iova, op->range))
@@ -1118,7 +1118,7 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 		op->obj = obj;
 		cnt++;
 
-		if ((op->range + op->obj_offset) > obj->size) {
+		if (size_add(op->range, op->obj_offset) > obj->size) {
 			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
 				   op->range, op->obj_offset, obj->size);
 			goto out_unlock;
-- 
2.56.0

