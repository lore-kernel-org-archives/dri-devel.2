Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58C606D81E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U3vt6U8H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUL6CIyI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DAC10E6E4;
	Mon,  2 Nov 2026 22:04:43 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A4010E6E4
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:33 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K67rZ688384
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7iwNbSoHb/p
 clbGXpf3RwdIP2L7rr7UMQVm34GUYTjc=; b=U3vt6U8Hpxaew0pjCKdmIopp8+Y
 jlIZNIX5Qg4I8Rls0iF/euhoEFTs/FmFPg9lqyXZPsTdp0KqObEhp+zJGdzLOXtR
 BYkxJwCwcq+DVVfLtMdXWK4KDOVzxb5RnJnaOYX5zEDq70eidltHtXBonKp8T2yH
 oG5aIXy+DSGqbx6CDE6PB9et+M53gaBfHjqUwW93Z3W6L5t52EP1hYgdCpSq+cB6
 vTFS6LvtrX1yRDCEElYuIjm7/UUh/1ASdbYRJN08+XS2+9MpwDN1G2lf/gwRfkF9
 vw2mvz+doEGGYl41j30F+7gFYwTAfYjcAmUT8eNc4Xs0XYzJkFZjQlgRAUA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfebdje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e9995cea88so35682545ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657072; x=1794261872;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7iwNbSoHb/pclbGXpf3RwdIP2L7rr7UMQVm34GUYTjc=;
 b=FUL6CIyI8WVQ5joXf8ap+GXLE1VthWhsaoIt1PrommZk484d/4U8T4FeaZUXmAyeoh
 2IuhnZ+x9821MzZ1Yo+KTtrMBwr8hARWazUKjclF7JaUpmc60vVWLmWef3gf+DSULQpC
 nZeZ93MKA8GOxDwMX5Dd4li+CDouQlte9t7V6i5VGa+DHl6mUVQCfx3XQXRMuv4tskwv
 QxeOWy5+fbnxJXsD3sv+q/5ZiFWPhXLDJK56KbxUqF53Lx35X/UJE6up/nx3qPSOU1S0
 G1OhpIUHDs82phZ8lMurlhl1nok0YzT1ZUc9g1w4qZWssr2cKMsE8r1WYeH5D7frOKwH
 Pf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657072; x=1794261872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7iwNbSoHb/pclbGXpf3RwdIP2L7rr7UMQVm34GUYTjc=;
 b=kkyYGV3Lzc8Qngs3tIgl99t52w3BY/JEc1MLSJ9qeITO6tLHXcquAUdfHyuMhZF7Y8
 lIWPNDQjYuwTyXzIebR9Kz4/ZXlR7AF7IFjGUE+mG5ez4G0jzxIF8I5Sve/t356pvpzW
 q198tqDXdVioUKuNpMcHI7xsMAvT7dMesMpqZAmqoyGBPgO+638C4U/z68UwBvLMASMM
 5tiYDj0I524PkyqpukVPXOFga3JwFa6tppDa8GNZOM3Ydndj8hZneYW5pA9cO+Nsmoxy
 PFJjxlzvE2TFwWxKbh+0eyd/RWtIiLQIfHwy5c+5Sly1DS2dcWAE/wAf3GCK9nvi+Y+O
 1cng==
X-Gm-Message-State: APuU4Z8+7QpYYXaly536EKIbPpi2+vwabj7rAIvCnyWR2bKOj7bJn0cS
 pCtBdrNe8LYJJsztaxVbyUzK6PjpulCFhoo0k8EgDgpUHedBRh3ApoAwmE13RnKkFnCRYVNl+Cl
 XtOHDV7ghOcivApDc7vXTABkINi4CisCzN76OvtSs3T7R4d/GJOjzsIenQ4XOrHw47KAuzVonUT
 GV9pyxfA==
X-Gm-Gg: AYBFou2Dvj+EWTQc4b+LDpxDYm2hWIqHSYAvtDYNJINXlrthZijwd2Dnzf6KGJ1mNKk
 5n7Vh1+prd7GeEcY3ffrSc0u5sSoTjwxtLq+tEQaZ0qqvenBF8UNKXxUQJ8HOBu/QJjH5VqvLDe
 5QF0sFsAVHvty0TNz+62FH77wP1Hil9UlPPLRlHQS0SojMAt79OshpF1kGgMFEDeCdJ3aVhVzDt
 dSFO41hoDZO6pOxIoOYqTd147sIkjpCZVIRk/7YSVgxXZmHVM0NKExXPqukc5PckqCjSc1snRJ2
 N32E7OGrRWVccgH5nTlF49b8Fj4LRsWxqvZ6gRyM66T6MPFNw+5dk292AXXZ7dSCSbMX05Efe6E
 Fp6iDAbC0voxd85TWnY+3lnOAP6y+6oje5a/2iOHTnTJ8Zfrbd5kIbTg+X5SUtf0pcRHOqBkqgl
 Se/iRMDdkN647A+Ta0SMsWlyI=
X-Received: by 2002:a17:902:cccc:b0:2e9:6788:937b with SMTP id
 d9443c01a7336-2eb364a0091mr102594395ad.31.1793657072097; 
 Mon, 02 Nov 2026 14:04:32 -0800 (PST)
X-Received: by 2002:a17:902:cccc:b0:2e9:6788:937b with SMTP id
 d9443c01a7336-2eb364a0091mr102594175ad.31.1793657071621; 
 Mon, 02 Nov 2026 14:04:31 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3928104asm32390475ad.53.2026.11.02.14.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:30 -0800 (PST)
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
Subject: [PATCH v5 06/15] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
Date: Mon,  2 Nov 2026 14:02:50 -0800
Message-ID: <20261102220405.30730-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae908f0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=cg0wMmP-TNBUvudz7-YA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX09gDBNz6GHT1
 AvZcDOanwzJrUKShkFKaMktsGflNC3x6JO4AuNCSPY+Yxy3pXukgYAN/RtBEtjjW88Xl2brgSzH
 EBOLG5DfBFMnZhMdKSpmJ6hBaHfsbhKeG0YlybJp4/0eLJV0Asdghr6CbzlT5QFNQLjTjWvuEXR
 Cdtsx0QsWvwEigJeOGJIdAYguxC6VuKx/XlZDPuTFxwe9nZb3rylSWQjxBaGoBHoHWM+CgWlBYU
 GaWmgvRwaVFHVE0VIipFnmF7YoAO5u8qXyEyJ7ZWYel+jhEpuGo1QsND1ILgE3VeGfITqxn36Bg
 GPIEb+2wvpwa5k7VHFfWu1LfkyrZN7/uXgHd2CxfCCuvyKSXbsykR6jYs9tFRlDcgjH+cL/Aa61
 T7c9y/IlsSygw+g9pQaRLhoowOYJKXXYzt38FTipyesDFzveyHbssCS0lRT9XmKmXYjLLiO8W9i
 yubq64Haqb8qQMk0TKg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX0zMeQdrdhoy3
 eD5ZmFh9cl8LzZNLaKnjzRpUZkZSdxn49x9zUiJ5dy7VEc3HV0wAY+wosFdcmMS9ht1g4/1fIZI
 qfK4dE1XYE48R2NQMgFqQm6DN7kJk70=
X-Proofpoint-ORIG-GUID: eeMI48y0XebrSVBXPEC63r-rKwLhKFJf
X-Proofpoint-GUID: eeMI48y0XebrSVBXPEC63r-rKwLhKFJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
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

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 6b299bf1000f..59546fc636cd 100644
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

