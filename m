Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC6606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3E3la66;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GC3cnb0o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A60E10EAC3;
	Fri,  6 Nov 2026 23:23:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A37910EAC0
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:49 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoJPI149281
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LDl6oZ2XOhk
 k26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=; b=Z3E3la661HdidD9ghetX+fiWSkH
 gGcSlKk4CFljmb1HyWcc3Kt7foZFrZh/wSdKxPnmw3WUpku1DV7533nhK3ZQtda3
 hnEZ6d1Js0M42Ij9Y4j5s7rVDXFy5YOMtIbekHQ5ktxYr9sNjq/Q+C3hW16lUmoq
 62/GOxKBbXhwdgyJpxNRIcx7UYz7Z3zgn4o5nNqt+Nm/l9wZxv9W/jcshUyzu8OI
 zZ0hsCCjRfUV6N71g2o9Faw6PCVSNLR2Wokqzy8hq1gBEHEsuPEyNOBBCagyWMts
 9Mai1rkp7pzSvjQtEGPpz37uqGamHaf6rRMJA404dq6s9AF5V+fWBES3iZg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyk0rxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so1820861a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007368; x=1794612168;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDl6oZ2XOhkk26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=;
 b=GC3cnb0ouUYaRoOSAzxrLprl/I24S2zRUqzKgx65/OVJgH4awpRPWX5cNTAy5JZGyS
 zYGbzIbRHHr9X4wgUmQG+oDip92Y8f/eji4NSpwb7Q8V4liC1KDYxwm+P9SJbZblvshW
 G9MEPUv+Dpp9P+b5NPIqk3MaZ54Fuh2qmHGjIt0O8G+Lyt6z97oZPMaM0LvJS34eozf/
 bO/KICrFEYkSS0Q7oq+kUigZLqdMcFZulfWWvsYi8/rMXzZTKKrEYasjvzdrSa3EIHhU
 3rBCnjznyDDxcreYp94VU6mzUpiYE//tAJwB2XBz7XgwgOsxvv9i4Hakcg9An3Kg6gRI
 wH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007368; x=1794612168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LDl6oZ2XOhkk26w0HhTOEpg4ruXAQ3r3r2grg6ZkY2A=;
 b=XEeAZN+mxGJBFE3cE5wwZtYWHkKm0spVpp+USPkHy1oPwnd3pwsAdkNcZekIYbhvy/
 dbTgyNodmRqy9eWXFIvi30qDCvUT1C67SFO7P7VRNX9QbtVjD5xo+l+6x2is35NBlEHN
 sFJIPTsq8hd0jZFzQit3s/yJxTA+SwGNiVzjiMdYHIm4UkJsu9iFIgJft1GGPp/zIfV2
 V0/jeEe1187xK9kRYbuGeL4YzMFU4Uy4BakKuoCJBtTxwoUetBLYOx0cCTXbzGAfcU+N
 FOobDEBd/wmlgaA0ZGrAtcZ7yF27DkWzfZht3j53hzu4RnGHGar4cORKlLaFiiGM1Ao+
 ySNw==
X-Gm-Message-State: APuU4Z/IMDw0vU/7e5o4cJPJE8D/ohOobzKsRZz6DBep5YIppLGhER+M
 OdtD69776X7bfoWET4UmeEwuXWMzencEjiWh+4cGOEpCOx4bUyanZahitlRFMY+s4GBpo7p5kdw
 7r9X7hqEoQokrg5ZpK9RuPyAFhCxcrhDI+NWWi9gtY7cFSc7qgutnSYOFp+yWsGhNT7D+gVadc2
 LDHxY=
X-Gm-Gg: AYBFou0xpIIFc1VvF6U00ylfQ78oO6LG1JaVfdtD8nVOfZ39bXTZwsieb0rsNdVUkQN
 eOU2MY878KIH96zbz/EOtbvw/tfEgg9DsURElfLypQyZmJZqTWcEKVGP4lFo78yRJvEEHsADs3F
 Ur7N6x2fyNI3h+DcgS3BqNVW2I7n6Mzw84o9HwHwRq4KmR/QMNb3aIRV+1RLrPRZ2W5mKPs8NS7
 GuGwTWmT1dqMPD2vtgwwIuIe5KMs5mtnOoIrSPVonquqBjIu/wHJH5TtO+oLrGoN5cEPZSBVMoQ
 QC2jszHXOoYFkCoffU2/6ylA0HIuLlTIG6As5DK+wbfZs3NjA6E50A4wt+D0veoqIzviwu/k7G1
 IKSbZEhbqRgrXjwhsvXrwhyHaDELemyBLOZYeur53/MByAZi6ic6DaDt+X89jYa2BydeBq1WsLT
 qaFuSHRmF8uLVx/PjSrzQOgayD6G9xHt/WipnOf1L/xHZNYt0SlsWOcei5lQam
X-Received: by 2002:a17:90b:530c:b0:3ac:8ee9:c8ed with SMTP id
 98e67ed59e1d1-3b0db6bb8a9mr4151462a91.13.1794007368198; 
 Fri, 06 Nov 2026 15:22:48 -0800 (PST)
X-Received: by 2002:a17:90b:530c:b0:3ac:8ee9:c8ed with SMTP id
 98e67ed59e1d1-3b0db6bb8a9mr4151446a91.13.1794007367781; 
 Fri, 06 Nov 2026 15:22:47 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b10585eac3sm659064a91.17.2026.11.06.15.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:46 -0800 (PST)
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
Subject: [PATCH v7 07/15] drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx
 list
Date: Fri,  6 Nov 2026 15:20:59 -0800
Message-ID: <20261106232220.47602-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
References: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TlrZktnNVgedWDpLHJpTBJMvGPH6xCND
X-Proofpoint-ORIG-GUID: TlrZktnNVgedWDpLHJpTBJMvGPH6xCND
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX88NJ8lAf75J/
 uzGg8Ujy+LAqLB7ynLWN4DW5v/fbMCyt+AFm+WVeob5aXgTm4z8P6HgDY7RgfLjt6IFYvnxHrje
 NpKyuJKgm0hCG1MsaiP3abtjnILRRy4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX5vkwzhPY+8vI
 1GSoLvXSe9NDf4C+ZsIKbJQM2y6/4cSaK1IdYWdrb7zXW7Da2v4DX0fA9bRBT0il4YIKbNiPEXL
 dZXWOdBgxtvGWkliNhAQncK9E5QwEJFhv2Y2SWpGXLI62R2gbQAbl0F8bUDrx7XNHrLrIWZz2y2
 4IUPdRfxyUUeIYTckDCANyQp2R5czqr1VPK311YD3tz6SM6381cEIQiuxeb0PVhCYRss6GEnQMw
 dOW6SnxhsZ7ooXMLVkFljQsA5eJLrKWKEXU+6pw6ceQIsW3tkwefbRb9jg6j+JeJRkLR9GL3IDQ
 hMSM9UhiXj4pGUo8IeGoO/Q6+wK/Bfrt/UdTJYqp1/N/xk4/fsChNbXGfby5rKuFLvvRa1F3I2t
 mdMHUo0qzHrsIg3AaD4QGcvGk7JMf8F4XOLQWQ5KZX5TJdrFLXGctAsUSh8pSAQgFJIHm1b1C95
 j73OprftDMaqgdzc0ig==
X-Authority-Analysis: v=2.4 cv=I5Tw19gg c=1 sm=1 tr=0 ts=6aee6148 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=QhgCzLM3CkghMFFZ4C8A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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

