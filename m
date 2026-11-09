Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10896083615
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HeOeUqWP;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bXCSnz4G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6704310F3A0;
	Mon,  9 Nov 2026 14:21:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2F8610E890
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DExFH2927794
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LDl6oZ2XOhk
 k26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=; b=HeOeUqWPjLcPxE/KbIHRW6UMsnm
 kV7Sem4Seb0edhQJvNXTkknowLA1bFLiI83fkfr7KjWC6B9ZXEA5MT9SD7bHDWEv
 oFwvrdsIhlVao+MRbCufOxzuEmcW7DlFgcdIWb7CG5RHNSY4Z3ShQGADvBh5ncDm
 qo9KoyjNtOhvTCatuOwwlZn9qv//MpcklHAdw5t6HwLlRa7lRjhA6nYnXfc3O8sZ
 mI9wfemScIChpgsdk8eex6/B5ugZwJcyaiO/9HfDDhwCinZYXJsND8g3GJ20foNY
 LxaOxcF8opP84BYDnz+J3oQhxRItIXr3v5TMtajIZk658CjI1F52oURaRMw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hubt8rx8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:30 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso1019540a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234089; x=1794838889;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDl6oZ2XOhkk26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=;
 b=bXCSnz4Gpp7bAteqslL/itTdqCkl4bUki+cQNFlR32xgt2S4jEJ13huQU5fTDoET0U
 wl4Izjy3UxQHabd8CtZMp4WUJZ+lRnNbrOzPvE2A7+B9Xk0rk095q2lzG7fd6PCi56Ww
 uOU7ctWs1x9JrCDET+MKq3xCQvPf+jd0mOlhw6JBcI1b4QO9JHO+KzSVnBNUdr1oD5rV
 IwstAPRVqN/fjv82o0kGSFOdHTAIygupnTHBvaVfR+y+yCoiVs/Fb9unhXhtOgt7pOeE
 Q9mjS8nm+p6Dm3K1Jx5Ckjph9S9JqRR8zHVmgB3tkziBeob6shYlw7r7VlJ4dO+jt4rU
 44CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234089; x=1794838889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LDl6oZ2XOhkk26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=;
 b=TeUx0bQxa6ND+VrFlb+jRuh0G8CMPmOXRKltg8EG2mSIbABwkDCNeZz9JV4nf9g5uS
 GggohJQvZjj2OQDnjvzXwfoz9ASUejrZ/CsZFuwisUj6j1rYZwMZKsAtviZUTqZm40Rn
 5U1MaKoyUReB44wax7aikYf/yqnpabd1RCbmbDM5Yh04nNAbHZgSW9C3Byjg7QjsQftT
 Aww+pCLdqOX/4Fwspf0bItT5f/EEXwlrdbHwSbwejAbJaawq46A9UrE/fCxUvu6+WI5g
 r0K5jxpXpklPmkD1B5j1M3+7hw3v2RPZmvJjMXGIyL9z5pa39AkKpxwItFU3cGCGSqEv
 8H/A==
X-Gm-Message-State: APuU4Z8Yn/cnDxpFQcbtqxYiK0wg1YFqBeByLn26UTwjfQJqExZeIOqJ
 r/yoLQ6gplg5vZjxkjcqM206Gv4xlQ2UXJ65MpqoB4wVXDXOygMdFBT2AxxjFLip3j+b4b1mjHS
 0iDSpeW2ra2dB1cGehDZm/hHhi2ibtt5FvBuUpC/eFtEBNHlMpqAJJhWvX5BTh0F3UlBbmpJjPr
 RlVVzTIQ==
X-Gm-Gg: AYBFou2TfSmiWyyc6++izsV5sYwjVH5IHgh+XQ2X9CYmZbzJtTjJcTHjM2bBimKUrF8
 5VC6nLyAk/0jUu/bwuV28hZAO3lSTi2sHZfPMB3XLL3Nor44q99RmE/ApWiaYZ+dwzYt4+R5fa0
 9Re2ttrfaUjFI1t09BGeS04or78mUZjS400ajnCJQ1PyKMGXcto4I3iCxNOichWwneyKlklNVEV
 /W7GMAWWz+5ln1B5hopw52OIub9de4Pun00xZeka0ybltdazGLxyiym5YTgEjBvofBwHaTLNEwB
 5jfc3jsNHquiWE/7irvPGPtdd9gm/y4TTAoxwLzNr48smz90OzLMmoA0/zR3ogugKVW7fH4rj3/
 9QCX2L3M/Z2YM6x4qLHUCR8Q4iVYmbOBrXneU8NolAcsnxjia2goi/PIQLjR2QRJSWhdhfUcqAS
 5073ov5GRvciIZG4LSLO5xOHba03rvyi5YW/NBUyHMWnrvgEtiBMZgrV22zj+pFw==
X-Received: by 2002:a05:6a00:2e9a:b0:892:e080:4edb with SMTP id
 d2e1a72fcca58-8b670d06b6bmr3720678b3a.60.1794234089453; 
 Mon, 09 Nov 2026 06:21:29 -0800 (PST)
X-Received: by 2002:a05:6a00:2e9a:b0:892:e080:4edb with SMTP id
 d2e1a72fcca58-8b670d06b6bmr3720643b3a.60.1794234088997; 
 Mon, 09 Nov 2026 06:21:28 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b64a1e6240sm1391192b3a.53.2026.11.09.06.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:28 -0800 (PST)
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
Subject: [PATCH v8 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Mon,  9 Nov 2026 06:19:53 -0800
Message-ID: <20261109142111.256630-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
References: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX3ibdaAH2W1d3
 qnlc2LTDl+vsjTUIpfHAW565bpvvjG0TWd+lg3hOzjP7I1klV8KLAQEJB61E7eLsxyeDZ2NrB7B
 0Sh8YYkSmA035v2T8KHHHg30sgjKL8DBspCLgsFNKpuR0xWM7IhPJmzrGY2wYhnnJRJhKQqn82N
 vvLyWG7VjaXDFP7/uWovjPQAeR8ks4eVdul9VeaCfCRn9DyhQo2LycmOfNpdfE//JpsIjRtfWZ2
 sIQ3XbAS3M+N6yGU+Ns8KdJQdLiFGVm/Mh94fyppIyXJISf4LtdOdxRDHjslQyKnfpZFYfJuCQT
 A8ApxPsKEDeDCBYFzU6TaChtW+jW70fUomAnsoH+eMK9WikDZkf1vcb10brlZV4oNqOC7OmZx+5
 gknNPjOtVoMpng4ARh77s87OKEo2Iu5Mni+dAorHGqMrBv9yNOW1g1KqSIRNFYYCBhG2z8MauMF
 BW4ysjvaDindEOiNpPA==
X-Proofpoint-GUID: JqSwXGnXCaGGFCPYWqMLLK2Fsu1RzsDG
X-Proofpoint-ORIG-GUID: JqSwXGnXCaGGFCPYWqMLLK2Fsu1RzsDG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX1UtSMssd51Cl
 7h0C4M4P6XTahfKZw/OmrKXZ+0fYhIlPxpA9V1UlqYQyShCEh/UfSGOErilNznmhWrTpNCyC34x
 LPk6WZZFfbFlt/zXmafcNsvMVuapP8c=
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6af1d6ea cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=QhgCzLM3CkghMFFZ4C8A:9 a=x9snwWr2DeNwDh03kgHS:22
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

We can just simplify things and calculate the value, instead of manually
adding it to the nonctx list.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c |  6 ------
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index dd1a5ca91812..6c5ee227243a 100644
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
 
@@ -709,7 +706,6 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
@@ -1102,7 +1098,6 @@ static const struct adreno_reglist_pipe a845_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0C000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
@@ -1161,7 +1156,6 @@ static const struct adreno_reglist_pipe a850_nonctxt_regs[] = {
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, BIT(10) | BIT(9), BIT(PIPE_BR) },
 	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
-	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x12000000, BIT(PIPE_BR) },
 	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 59898b49a201..f65bf82e5c21 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -370,7 +370,7 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 		  hbb_lo << 1 | ubwc_mode);
 }
 
-static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
+static void a8xx_nonctxt_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gmu *gmu = &to_a6xx_gpu(adreno_gpu)->gmu;
@@ -390,9 +390,6 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 			if (!(BIT(pipe_id) & regs[i].pipe))
 				continue;
 
-			if (regs[i].offset == REG_A8XX_RB_GC_GMEM_PROTECT)
-				*gmem_protect = regs[i].value;
-
 			if ((regs[i].offset << 2) >= gmu->mmio_offset) {
 				gmu_write(gmu, regs[i].offset, regs[i].value);
 			} else {
@@ -638,7 +635,6 @@ static int hw_init(struct msm_gpu *gpu)
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	unsigned int pipe_id, i;
-	u32 gmem_protect = 0;
 	u64 gmem_range_min;
 	int ret;
 
@@ -719,7 +715,7 @@ static int hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A8XX_UCHE_CLIENT_PF, BIT(7) | 0x1);
 
-	a8xx_nonctxt_config(gpu, &gmem_protect);
+	a8xx_nonctxt_config(gpu);
 
 	/* Enable fault detection */
 	gpu_write(gpu, REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, BIT(30) | 0xcfffff);
@@ -838,8 +834,8 @@ static int hw_init(struct msm_gpu *gpu)
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

