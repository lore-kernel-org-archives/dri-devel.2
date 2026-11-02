Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3A606D80B
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LzTdjSaB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WUvdUgSo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B482A10F264;
	Mon,  2 Nov 2026 22:04:45 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B49AD10F25A
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:34 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6IiJ688636
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R4FMlDFuy4X
 Pwa+EjTfNvoiohThuilBlfKwrrVx7kUw=; b=LzTdjSaBRu5/e4/nNqO7X1f4qZV
 q7RF0ICB4jWsuqRpfs0Fj1+hf0tM86Zx6nH41/fR64NHhh8dsjPpG9VKSSbr4bm6
 1qqYWZbp5wSUu88QGhkB14JsO8Te+f5hVtjMYHkPrduYN4jeumJ1GF0P7BY5MZdl
 ZoDvcDwCGWbiEKPlzG0lH2S+9oxZiofmQ1RctoFQo9yknRdU3vwbdyMuofSUft6W
 aHXpoXpLXENQdT7fdJXme80L7mhpnpkcdVF2/fSUIbd7H1IoJRSNKxavZR6uy+Cl
 ygdQwHByplWcQTM9RP+xOgPEl9V4IfYUvBal7CvJknCI/20af7MNewCkEhA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfebdjj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad704d4760so3135718a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657073; x=1794261873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R4FMlDFuy4XPwa+EjTfNvoiohThuilBlfKwrrVx7kUw=;
 b=WUvdUgSolyGUyJho9eRPMoKx8GcSPmYyPjMDWhyrM/dG/RhEphAOElrocrdh8D8eO9
 YVvUVFSpWgt5oPOXQGRXYPwz1VrKMb1nIIkKlE9dJAWOVMjim281YwjBCROK5ha3/fIN
 fJwXB4FQdiOxn2MY8qen26DBm+MaJXXKh5kHT8mt35dags8oT5yn9gcvCHxDpCQmJ12h
 1NzhyYOtb9SgPMwA6Ib25gjUB/sJIAgpc3pYrpZb1LsfdtDeligMtiyAp+eNhJls0sPS
 AoOje3FfGJ/o7bWfjwZXi2x66Xp9yLS/L8jeSbQMO+6u0L3BS/Nvzfe/SRd1vtLIBJJF
 +uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657073; x=1794261873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R4FMlDFuy4XPwa+EjTfNvoiohThuilBlfKwrrVx7kUw=;
 b=Ib3SRPk6P6ozzJL3/YEBL30vLuDpjFArbZMzlfRH9N3baMNdXcjO1UDfYUCj4znnS5
 ppSq4rjDLS1HjHqJgQDFOEuc+xrfpIGiK9FZcLIiTprDohbDwiPl7MSN0KubvQgGfH09
 +L85ybsB+CItzOgZvnLnS5efuQbQ0ueHkTrJHxxhsxzN7v5iGuMQiCumJDm4sTBccm2x
 YxCQC1yosjAHrODV3Hmh7y/0bng3afBHD7hc9OIN+2ALUNGusgGreaO/wRYf8wAj68G0
 LPzQzSRbRcSsH6vRUaTroOAjjueJS5MpJJQPWJV/mvb3olVIVtSyhMk+WAuMiGsVrcmY
 cGzA==
X-Gm-Message-State: APuU4Z/O7WjA6ZReqWjvCzAHvB1J43nKjtcZmQFHX2oWzyrgoQ3q6gKz
 aUMOUi5VLdTPH1WQLBMpuYmoSy1Y087cnMQyv741AlgDZRA12WrGu0eBGrsnqhAI8wxcrhalBAx
 ai11gSUmkMNZKzmVwWHASNmW5ZJYmonOzAjCNTufzr1cT/0ZxESLzZsfuX3DdxvGj0Zo4Hx+s2h
 5JAw0=
X-Gm-Gg: AYBFou0+3YmlVfm8c9tC4cZHxpbiKFxSnZZcbLaCdHSz6XHlAhMgaSZYpTOL22ergUx
 /YiIB5O4rXRwbtZgX/4+I+gIKXC0wmZsn2c1BlTWdvc0wUqOMM5LuSTV1jw65iknULLW/IULn2f
 QCMc3zihe+8dvz7XJvJR3zLe6LFzsnkJ/JyU2i/yxIsbTJrh+s7n1LS+QXeicXPSNYA440qtknO
 jnI2RN3SEOly0jonXjb4Jwv1N+yLTqEJ4wEhdBSBLZvr1po7H/eCO/32JL3ZCGMP/AFfk4Yd153
 S4EhmbXLm1bpDc0nCJnmq6dcwsQBTdFwGRnbZ7QSbufK6tNCPlmHOtNiQbtyl07O+W0xM6tle4z
 SNG035Svke9Nyg/w9fjEthoId+fJSAIjWMG/k2XrEBwBgIw49oJF2r4+NyV0599bsEGTMkyXM5w
 i2Ri7t7u9WPw8efiOe/WS+Pg==
X-Received: by 2002:a17:90b:3d8e:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3ae8979a140mr8180969a91.40.1793657073423; 
 Mon, 02 Nov 2026 14:04:33 -0800 (PST)
X-Received: by 2002:a17:90b:3d8e:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3ae8979a140mr8180934a91.40.1793657072902; 
 Mon, 02 Nov 2026 14:04:32 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm938308a91.9.2026.11.02.14.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:32 -0800 (PST)
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
Subject: [PATCH v5 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Mon,  2 Nov 2026 14:02:51 -0800
Message-ID: <20261102220405.30730-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae908f2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=QhgCzLM3CkghMFFZ4C8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX9ySzGYlJ+RiQ
 2gAQZhP6f7xRj0CoK2G8haWZ7a2QS6nUoK2Dpsshvo/lt46hzMJYRMYPGlLIcnnXCMGIutEr1MR
 aNYNXlszmtMNp4lYXEDIlAnfSll67ESqiDSWgfXVwF020SwSQ3dzfrb6CIJslsJb+QgQw4kbrhp
 nFCafkd2yMF2MQFNhkeVDsyqueXbqeaeVp86Y0Byl65PJjA+ChGp1edQIy+Qm6cU3cWqdgsyn39
 ekrgQcug7TelgJw85vROzcr+CatKwbPfywTleZwHduprafoxs9xXrSffsRU6bp4FVD3+ob+Cold
 rUUjGqm1jDeBwqVxqAB4hBc7Hv1oulHZMQEEzLBeOT0AApRsDU1MyaewpaJTFeSXZk0vsBIoM7P
 ghHgWl7YuX0xStUKHQHSFmIPqxLRyWqw47fZzo64BuRyCW6dEEFV/XvpwlL0G+H0MvVUuDM1Fhk
 WRfBgJs10SqPKa0n5dA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX8ogOheUEzewE
 iOgOw3ek+84+sVXv75LlXrc9yyf8xC8krteKaoB/h2TYzav5JyEndf/MXDZ2x32o8/DbwZskN0e
 9tE19fkfTYLx8fJMEb2mUFqDZ+1k7c8=
X-Proofpoint-ORIG-GUID: tFlFKYyh_GnOy_ek1b9_Yfkbxm3X1czi
X-Proofpoint-GUID: tFlFKYyh_GnOy_ek1b9_Yfkbxm3X1czi
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

We can just simplify things and calculate the value, instead of manually
adding it to the nonctx list.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c |  6 ------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 45cd986ad4b5..8d85f6cad960 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -27,7 +27,6 @@ static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
 	/* Configure number of outstanding transactions to 32 */
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	/* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitration */
@@ -309,7 +308,6 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x15000000, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
@@ -483,7 +481,6 @@ static const struct adreno_reglist_pipe a810_nonctxt_regs[] = {
 	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x00900000, BIT(PIPE_BR) },
 	{ },
 };
 
@@ -793,7 +790,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
@@ -1186,7 +1182,6 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0C000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
@@ -1245,7 +1240,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 59546fc636cd..952c46f08d2a 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -367,7 +367,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -387,9 +387,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -635,7 +632,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -716,7 +712,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -835,8 +831,8 @@ static int hw_init(struct msm_gpu *gpu)
 	 * GMEM_PROTECT register should be programmed after GPU is transitioned to
 	 * non-secure mode
 	 */
-	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT, gmem_protect);
-	WARN_ON(!gmem_protect);
+	a8xx_write_pipe(gpu, PIPE_BR, REG_A8XX_RB_GC_GMEM_PROTECT,
+		        (adreno_gpu->info->gmem / SZ_4K) << 16);
 	a8xx_aperture_clear(gpu);
 
 	if (!a6xx_gpu->pwrup_reglist_emitted) {
-- 
2.56.0

