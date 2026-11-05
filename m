Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA20606EEA3
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MeQAmDzh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M42Gxk2u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF11810FF81;
	Thu,  5 Nov 2026 20:41:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B755B10FE0A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:41:23 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5JOv0C110475
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mVy1ahp/P6z
 Kdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=; b=MeQAmDzhhiBpFrF1d3IIivIjGWM
 cbCswf0+ZEI/c5HNtNi4WfHcnzwLM0jTEF6sVs/qHsN1vaiFxlyh8w3YAfJurhnP
 eTGHvAkq4YmXS5xss+cik/MgjV6xYsLT7Sy6v+peEylSpc+FLkwVq8tWk2wl+FYx
 4PWJuUMVpxLaTAiRVx/tD60MopK+tQCzn540UvylY4GKN/SjFNoKYupZX6NwtFX7
 HBFkrAHn5Eo4pu4vcerP+Cn3asS7qUIFXIByHOfFhnDVhyzJnj4rpQPFgSKrSzVK
 SeBw4rmG0O0dCEbU1QkVTu2a0FqNR+iK1mbacsJTqbVt0Di85I/eqlxxOXA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrrkdth8a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:41:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so2481160a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911282; x=1794516082;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=M42Gxk2u+eZb46xTDoUWCrzJ2AqcZXGQbXhQMncYF7UJpS82oso1s+/qihVIOGtXTy
 Fw+/hbPbAXKqZfK7cYgq2OYanY9aRhMWbd5f7tmM7ZuT/vlUJPi5PsLzTpIjE+1DAKrC
 1ExmLzzpIKFs5/3IjTAnRSO6R13Q3CPtvC2oBUTexERPiDeJue8DOY4SRvqFGIURdOJ9
 7e2ykA5OeI/IKoJS6c/r3eQP9nJkgyZd/MywIGN8tZQQ68r2zB+Xcy03HAgzVl+gw6XI
 s6yXVOEO++l5UBdyYUa38b3YjVsFk//WYoM3P398nWH/QUYbD35zR8ib0+IpV1aJZZtR
 wRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911282; x=1794516082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mVy1ahp/P6zKdu4H9fQ7zteH5AB1M4xbGRPzRcWMmpo=;
 b=NyX94KVKHeSmwQRXrWoweAR3OxtLAp+9M2u4q4KWLy/UFQIeV74HQiXxtElsRF9Ocm
 BguZDK7DjpxmOvPxUXKMsmp1CMGu/ls2anuhSHGhv3D6dTqUfOdX6GW8CAuHmqiQLogP
 9QyQd9/4ip05ssDxg3OIdRl7eKHLt0d6u56zSs2CiHtv2Qz72JQ6pXU+Yk38LRFOyLWI
 xJ6Xq/6lKAPju6qY6zWw0sbq2BmYD87UbFD7FdMfUk97dCZOSxmGg2io1qrhZq8UEKeU
 cNwMr80I0IZPPcSYSpk9I7L4+bliQqDOwuiBFnQjeZFd4kyhZRONuM5EwOoYlPRAnQ3W
 ZUyg==
X-Gm-Message-State: APuU4Z9ucEcirql1Oej5yTdL3fk0peXI0Te7xFk8Hb8GjWNUVR17LUUp
 uf42zbf28az8ng1a1xZXULyo6KgaQyQKi0KgAFRc9mPF8v0YQl8k/vGLFSyHzwFoc7SrrXBXb9y
 AEKe7chySKgGU6ygC9m34tQYT1ulLYsFZWgF02lFrynKeSDDU8TbZ1mkmvWcW/sVy7/9ufBspnp
 DoAlhCQQ==
X-Gm-Gg: AYBFou3j1dL52b8q6LxWdLtdGgO+hZsLBxovol5hXveLOmuUaxYnvqK/46t2IFcQz63
 mucNwgrl32fSySO8zzkoiH3esad9e07YVswpr7l+gb+Sxt9+2vfK8dFU6rOTeaREuplmc2cvCn3
 u+8NsjZKQc6om+kyuysjca4jkvOFU3Xz6kTYeDkfwjJbEHJBylLTWzSlN+6mX1EbGlRxmGHoRXi
 HUY1826IbKLHo8l9cCDPvsvJMMLyJenXr/9LmZBiD3Mq85A+YTzEqIRzFN26duFeCuXvImMs3Kz
 2mOYC+B7a8Hl2EVcrDelBw8nIVgXHYnqt57QkLNbSm90ZT5z3DLw2L9Rc+wjCaqAiHiyfM8Qfjs
 YIHvDDbQXTkfJ4npd5tQWCrIlM+c3tnLUGAe8si4JrGC5FbGgVqHJWU8PB/WV4asCAuTkHMG8wy
 RNl7D/GUhCLYE3NeeCkMJXLYxDflvlTs8q/7nGq4Q3EM2KWw0NI3WhxUCV6xEj+w==
X-Received: by 2002:a17:90b:4b0b:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3b0db6d7710mr164832a91.16.1793911282448; 
 Thu, 05 Nov 2026 12:41:22 -0800 (PST)
X-Received: by 2002:a17:90b:4b0b:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3b0db6d7710mr164816a91.16.1793911281992; 
 Thu, 05 Nov 2026 12:41:21 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0944eb1d1sm5492749a91.0.2026.11.05.12.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:41:19 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 13/15] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Thu,  5 Nov 2026 12:29:39 -0800
Message-ID: <20261105203057.66520-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
References: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xd4cX455 c=1 sm=1 tr=0 ts=6aece9f3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=UnxhJFuZtzOLgjs1IeAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 5ncih5ueekiZRLqiwRbtVzOXpTPI1dPb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX/PMj81VY0W24
 d9D5dWw3u00Ao/ONpiXagXLinW8nu+ZKdxKMGH4/cVW9ncgu9+NmFTZB3cuUXlOQKPk4pmFHpiO
 FEFx61REEa5h2KN0S8aVtsd7pHrjJrk=
X-Proofpoint-GUID: 5ncih5ueekiZRLqiwRbtVzOXpTPI1dPb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfXyk6rf7920qY6
 qp/af36+JbfYYWIl/fEa5zx/etuM5j3IEgU668U4o9B+ZQlkPcGekvTFKEFowWezc4xcpdTD3/R
 N24KOamJ5JlzjLBREglHleIIwrvoZFbxqBcdFLi0UTf098PeGRqFP5g7ca7/GqbXkGV/mPkrqHM
 Q4iRYxpeX0Eb4Skuk8soK4UDrxRiePaXefgdDaTQEZNR0UuYYEYlyIOL9kSQPLFUO76eZ7u7ARo
 /eUcOr9KRTDxMGh3FmTw887zVAAvcWWvc4A6OZjUHJzJX9vYt7KTZvN5oRJz13lUAXDSTL0aVeW
 lSjrZTPJ1VvbTlnZTmllGlTFerb+lfPX2zvUOZJO59ISuZmYx5Vtw4exfQgtkeaEpFgw87uBby7
 8EsXef4p+Aow4kwwunpCTOxpGJ21+9POj9MJfRCBm/Vj4DwomvxExjTwHgGXTm/bV48NsKr91fe
 Bcr5138Wu/SyPFwCHWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
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

If there are not enough global CP_PROTECT_GLOBAL regs, we can use
CP_PROTECT_PIPE regs for the extra spans.  We just need to configure
them the same on all pipes.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f65bf82e5c21..f6afa5b3b0bb 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -261,12 +261,21 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
 
 	a8xx_aperture_clear(gpu);
 
-	for (i = 0; i < protect->count; i++) {
+	for (i = 0; i < min(64, protect->count); i++) {
 		/* Intentionally skip writing to some registers */
-		if (protect->regs[i]) {
-			gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(i), protect->regs[i]);
-			final_cfg = protect->regs[i];
-		}
+		if (!protect->regs[i])
+			continue;
+		gpu_write(gpu, REG_A8XX_CP_PROTECT_GLOBAL(i), protect->regs[i]);
+		final_cfg = protect->regs[i];
+	}
+
+	for (; i < protect->count; i++) {
+		/* Intentionally skip writing to some registers */
+		if (!protect->regs[i])
+			continue;
+		a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_CP_PROTECT_PIPE(i - 64), protect->regs[i]);
+		a8xx_write_pipe(gpu, PIPE_BV, REG_A8XX_CP_PROTECT_PIPE(i - 64), protect->regs[i]);
+		final_cfg = protect->regs[i];
 	}
 
 	/*
-- 
2.56.0

