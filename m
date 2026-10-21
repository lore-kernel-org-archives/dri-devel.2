Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C9606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHr21vnf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qzagl2vz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDE4112220;
	Wed, 21 Oct 2026 20:53:00 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3ACA1121FD
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKmgw62256174
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RbVliwpgUGU
 KqfTEQkEhVFK/hlI4aw9ogH4W5n+tkqs=; b=jHr21vnfls6HnxHhomsDGQAfWvz
 MPSayghRdrQ+kCCgKAA+Eq2uBEIPLZlY62T60NyDlRlUPqWuZ3Zkz3CQchrx4Fh2
 2K0dqL+OQcMcdv6L0GaZiqIJESKymYSYLomcd61kU8D1/QuGvPegNic1bG/DGzIm
 FEi3bf3NgjME69crZ+7IJ18iX8AoDmVMpXKyc6/5TH4aU0zk3FGByxq3zoLwTAMS
 MAhBR+OtPwgXp3GaOMdH9rWl1rrnnGcNGXMhRKaUC+rE8ltXdQc15g2WI4WGZeIA
 EHZ+hT7rHZzaj0wRBv6pCXSVFJb7otUxogSs1s0PukqpnXQEnCzA4wnQ1lQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0v89077-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so1316568a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615966; x=1793220766;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RbVliwpgUGUKqfTEQkEhVFK/hlI4aw9ogH4W5n+tkqs=;
 b=Qzagl2vz9/baNJIOlYJi6MRY8n8KePy+FElSYKbMpIfOl6p5qbZWfU/FG0NL/zl9K6
 BYAWKJVw91ROVz74IEQvH1zvFqXZATSs9ICT84nHvvDbAYGXZjHcsqs9+fd8Ev+c4ahi
 U0A4dXsLLvHjmsREfZ5sV9uVE9IHqL5+jnOePMin1pnvZYF6kpPkfOitbVhyphMCpl0C
 6fz1VFe7pgorGBrB9lc+KgS/prDgvruUGqKprZPq57VMq4RvskHztBK4YT5z/AeXL18K
 c9sHObw00HSSI0X55pcyvP5lE8R1Q85x0ZpmplOeEWsqbSfaIfKF0tFp9LeqUInARIsb
 z3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615966; x=1793220766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RbVliwpgUGUKqfTEQkEhVFK/hlI4aw9ogH4W5n+tkqs=;
 b=ACyQ+yJe5AkCyKfmCm0dKybyi4NzctmuXr8oysCWibNVf4ZG50aMnEhRAF3OT3xmHl
 DXia3KFUQQz92oKTpHUqu8A97T8lxbvUmYottL2LRWxxDHaYAu8Skc2f9dWjMUU/tLKj
 Fy2pTZVzY0/hJpYx004MgBbabBqIfmG7GcG3+jdwRITQRWYxI4wsIePDxPh7aXsvhGnn
 QJ0dNmQ+A/6M1ttI6Y52PQhNawGgXT1dMF5+PDsRVHgLwSRSMtgyi2GbRdcjUCEddoB+
 EbjrEmSoGGgMziifzrRz91DkOfwWRPdJ8RMEov7gR+vJUznhQsEkBkVIpvlw9yaaM8ts
 mqaw==
X-Gm-Message-State: AFq9FYIBZVn9qKOgz5/n82TpRuj6/flBjUiYwqQ40iLzuk5wapLtj5vY
 6UX94807bMAOFonyI4MkIMKTKAvpGPZwFFmhS7WyEE93AtXxGNy18A0EjiTvuCU1wCGYAmHPTx3
 0N+m/pUUnjezXsr10ZOigXM8aCjndf066xi9I3NGZccDOeW0fw2NpiU7OazTrAyncZwDTIsJUOR
 0WLU0=
X-Gm-Gg: AYBFou120aRBoGQD3fePX07s6iQQD6Mc4gIKTf2ELMHwPCxsQkKirsgkc2FrJnGhkzm
 xqfFaZjxKZceZc2D1VPldhcaspPokCW9rcSUD4J86R2Fp0pqCg3n7ij5RTInm7/bP7jyqloddYA
 HNDA8jMeg7iM0OW8EiHhbMPY3mySBLMzZR0YF2R03Ct/Ylq0ePD2/AAw0ZvD+XmQbP9qupt/jiD
 WECOy3IP3H7T6fez19dZESnNmrgE5YcFIQyEFHn/Nz80Lo2iWXK1MHB0EFfIWs7fqvrdbAXFhHj
 jrAyLXz9tvvCcpg1DiNDzhizos7pkJF8jGHPBBJgMkJqKgqH+VMrl4G56rm9J/3Ikiz6CeBnJ73
 Zb4rXzal9qFUG+PlNPoHc/e3ekbHrJHi+OPoQ97LJSmuTxpDj
X-Received: by 2002:a17:90b:4b0e:b0:3a7:9045:fe29 with SMTP id
 98e67ed59e1d1-3ad86b0c3e1mr2570024a91.4.1792615966026; 
 Wed, 21 Oct 2026 13:52:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0e:b0:3a7:9045:fe29 with SMTP id
 98e67ed59e1d1-3ad86b0c3e1mr2570012a91.4.1792615965535; 
 Wed, 21 Oct 2026 13:52:45 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4933d16sm962668a91.13.2026.10.21.13.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:44 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/14] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Wed, 21 Oct 2026 13:41:31 -0700
Message-ID: <20261021204244.67160-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
References: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9Z8WgP+ c=1 sm=1 tr=0 ts=6ad9261e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX2Q9VR19D9Pbh
 oST9Yl0V6Nv7wNsFdJ8PhLUSfJIkh0WtKtZlO76OHjHUpw8Bq7H1zYsboq9+eMTJUuF0zJF2K0q
 kX3u6FxXhdKkbl5BpkMrt480LV8jIMo=
X-Proofpoint-GUID: 1aEZ4H-pkWPCGoYXh5HETRfZyRE9FS0Y
X-Proofpoint-ORIG-GUID: 1aEZ4H-pkWPCGoYXh5HETRfZyRE9FS0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX6xEyno9/3UO+
 0Tfilk5f0WPRRAmI1mJH7gCDX3Aw5l8bbA5mOExVaw16VgRKp1LeT7KhIYRJX12PjRdRUV4gWxv
 w5QaBfo2bChnoBaDvFoTRGZnmpPsDF5QAa9sX4BUaCNnlzHsTMNXwFpHb7NGT7yFkRuMSVW7Xeu
 wH71crb0IrKCzPTmVKeAqHMe3nmQropxNAJYIS3zMBJMM0WZ9Amnt3W2yjb2IO0fKAtNT3CK6xy
 F52iDr/ECsCZD3ROCqF9zTrpPjFsEqA+mZsJ7hOC7EQCzdULP1MOFLWsvvLxlbSruWuX+TR6kv5
 hH8m5/9uKK3L/2v+s64icREwtliL5ivt18YoHEAvgfqnaekdywWgREcrggMHnU4bhSqICKzBcsn
 4qu+DnqT+qZg8xNJp3oA/JES9HMi/SiId71ueYdI62FYFKYKprcfEfJtwpydBNz4nev8FZZubXK
 hUWQQ5H7NQ+dkfzQHXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210083
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

From hw PoV, it's all part of the GPU.  But from dt perspective it is
it's own device with a separate io space.  So we need to detect this and
direct writes to the correct place.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 8e91edf16ec2..795c16d88f45 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -370,6 +370,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
 	const struct a6xx_info *info = adreno_gpu->info->a6xx;
 	const struct adreno_reglist_pipe *regs = info->nonctxt_reglist;
 	unsigned int pipe_id, i;
@@ -389,7 +390,11 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
 				*gmem_protect = regs[i].value;
 
-			gpu_write(gpu, regs[i].offset, regs[i].value);
+			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
+				gmu_write(gmu, regs[i].offset, regs[i].value);
+			} else {
+				gpu_write(gpu, regs[i].offset, regs[i].value);
+			}
 		}
 
 		a8xx_aperture_release(gpu, flags);
-- 
2.56.0

