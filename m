Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C34606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cM+MsNCq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FChECdGD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1B410E973;
	Tue, 10 Nov 2026 20:47:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B800710E973
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:47:40 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAJIW08724713
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=hNCvYFJ2RnXoRwOEMSxfDnhAjWKMNDO24Be
 yhdVmt3o=; b=cM+MsNCq59akQglTLxUZMR+ZNAXqoOuWeiS0DxJsrOW4utoRxP/
 WJDwu/hr6BykVKNtSywPkl/sAsOFKnOukWcv/E5w88c6P0422nKL37NGZ+aAji6J
 xwsJNNAJ09youM9HNFPDz7GArFwsv8vaZ54joAyUGBhIuGzShpsdNPKu+oxr97rg
 MGF1vQJNCZzI2QI684/piK3d9iyNz8DB910K3NVAPN0Xj2skzIRQA39p4br1rlWU
 33fxh9QABXPbR+/vtSMP7ptEENVd/zUepugxCBt8VEr6B74/MGokP7HuguikZwiU
 Io0sL8M2dWpMUGisBkQtCDMCiFTf0eFZF1w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv97c8cd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 20:47:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ed08904845so36341285ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794343658; x=1794948458;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hNCvYFJ2RnXoRwOEMSxfDnhAjWKMNDO24BeyhdVmt3o=;
 b=FChECdGDEMcnlcoDFYAJpYkDnCyYIQXkjtBEuAiA1zZFCoLYYo6cryDRW6C7vxJcLu
 CRKdbcuqg1pwYcytKZcvv4flLCUP7dbrqofmt4SjVzWt3ksg1lkpqokmO5KygJx9J2Uv
 NiZzNeG3SpYQeEsgutwZfktflpW2VeD0W6Ux07fI0cvYMfFpN8ZG3Qu5cpNRhxaSW7sW
 8uFk1WLiQegny671U29ezhndricuhNsVXWVSQ5HTYmlvHqWup2u8m1TXYnXp5c9sYKXh
 OUIgmvpxfjnh4Z4FjHdWSMkKjpLMBOAxnBRIUWA0+/Ce8dGF53aoUSPLOdpybB+pajjJ
 NEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794343658; x=1794948458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hNCvYFJ2RnXoRwOEMSxfDnhAjWKMNDO24BeyhdVmt3o=;
 b=gXWQ/ywSSBfzo570VJNr5VNZLy6RqVRFyIeHlVa4b1PVX61ah0A0VZdc5wkXyS8ZB8
 bwMaB2PynjdsREk0E6PUbCwsI/iRcI3fHrqX4GhpBLe6J2cmQ96D1bBh3PoxnyBGQwTx
 5vIpnDbohEpQtaK+VOhAB9OkLYkBYEHHcpOFoRcW1ZCdYlny5DVOUC4JDC98h32XLN4w
 3OxUa44iY+xih5OJVp+W2kU29co3hIvzE6gWCJYSqWIi9I5dgaLprcEmtq1IUIBJqwME
 0oGf+rRPXwbYnCFjS9ncfHQZtWf6ojRilJg8jDjhHX2rtmiwB1goPLiQoEqd9pSjQkeS
 okBw==
X-Gm-Message-State: APuU4Z9mCxdX4Zjf41ULDDuPgNk3HJw4yrhB2StAmnTV1fx6ggUETaiS
 LToHlwc+1h+F74N5WYP2cqC/BMQYx+/yGtoa1XZhxjx1WKmJXmRi2Uq1nnkONTpoQXWDPKDHn6i
 xJ4PcTuZg5rjjR4d9XjzVwniQZHjTPUZWWLyLAeOBzMfDuIKJAuoP2bpF+SA296so3TsZxGzJdn
 ishvy6Mw==
X-Gm-Gg: AYBFou1msm5VALUeYEknOz4doO4mIlo3j62ev/6iYhFBWMH9Os4eKveMUCQwvrYIoy9
 h2kVHO2JusIwWlNvE7q3FLWrYpiZ6CkjmLMN+Q+hNUTe/k5Hu7ZDptjpZxVJMJy81ypRZO48Lo5
 oUVmWx5kS9gGiRstrun/UsggVMZOwEXHDDusGnt5AlNwa/MscgypNBqh+W/iSvRXHANi2kvg4rL
 cgQpBJ4aP5GjVu0cRYDnMHkWgQt7LYzrR/jZWoiRMnDw5VMk2A0DLjClEJZ4kwidhlLWW9K7aus
 RNPOqQYIVFhT24ogVo1Uc19a9JGcmckJRmUZJ4HihMgevAkuCqHm000zzxrxMEXzhzkw9lSPD6Z
 HETMTJ7SSai0+T5aEGnCM/8WTVp8S1zwb0c1StNchsrbn804LmJ0Npy0eCl+lJXJafakP7yshWp
 law/dGJ9vXfsdVptPDM+nUymZJ5ohZpJGAAUrJX8yHRxI5dOXqUJwq9jkntrJEWg==
X-Received: by 2002:a17:902:fd87:b0:2e9:5ed2:c39d with SMTP id
 d9443c01a7336-2edd79bf74cmr3474935ad.36.1794343658472; 
 Tue, 10 Nov 2026 12:47:38 -0800 (PST)
X-Received: by 2002:a17:902:fd87:b0:2e9:5ed2:c39d with SMTP id
 d9443c01a7336-2edd79bf74cmr3474695ad.36.1794343658008; 
 Tue, 10 Nov 2026 12:47:38 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6e0d5c0sm12824535ad.71.2026.11.10.12.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 12:47:37 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a8xx: More nonctx list updates
Date: Tue, 10 Nov 2026 12:47:32 -0800
Message-ID: <20261110204732.531432-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX2dHTMdNw/Hkq
 PSUwM+9Bq0dSQE5Yf5j/FUGL6uDZuki3gyDqAZNaqyGr4DhV2cdbWkzd+sR8Q7T+s/gROj8aaaC
 DtxDd4tF8SYmyJtGgGmaeedKCXNvmylWrQwkVaMVP0jvOdP8G5qe1ATPDsZHLeWFK+w+J1mFZ+R
 j7BqnC4Uwl7CyzVKs/+UEHb1MexcaqPhTk6SpXxn9luY0vd0wkuWUDofGd+vL7Lqu82L8ieXkX6
 d5lYjvzPCxIZcbxFiMBtKtO9SuZHe2LBAeZz4JWLzBty0M23Ve8/gMTF0I+9ImB1lm7O4OY02Gj
 aUGxYBH62BYkIHcIhNM5AJSx0McjjbIKLmDXjVokqPcrOzpVKXmUNo2SZsBWuLZXO/kG9i19m+y
 g4V0OUUFd+EvYivpvTcH3BPJVQR73XAwKwEGuLSTdpi70W+Y2cEY6FyxzOIfU8Obx6G8mjL3y3H
 NAUk4Jk2xL2vqJF9pEg==
X-Authority-Analysis: v=2.4 cv=cJl1IVeN c=1 sm=1 tr=0 ts=6af382eb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=dKKpEi-vj6lmmWfvBBYA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 7fGAId3YfPE4jr1rkCwdZcEBDj5erwGZ
X-Proofpoint-ORIG-GUID: 7fGAId3YfPE4jr1rkCwdZcEBDj5erwGZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4MiBTYWx0ZWRfX5E9wAQ2mrjRM
 3U1C81fiubfnQCa6iEeV4/gek/cIQ4aez3J6PB9FEcbxMR6pufZuijRgmS2gAj2P1A97iwcb+LV
 Q1dZg4A+gL4pZIpGsIghGCfasnHdH+o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100082
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 510c2f6017db..0c6dde3cbea9 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -282,6 +282,7 @@ static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_SLICE_PERFCTR_CNTL, BIT(0), BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
@@ -595,13 +596,15 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	/* Disable Dead Draw Merge scheme on RB-HLSQ */
-	{ REG_A6XX_RB_RBP_CNTL, BIT(5), BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_RB_RBP_CNTL, BIT(5) | BIT(6), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_DBG_ECO_CNTL, BIT(17), BIT(PIPE_BV) | BIT(PIPE_BR) },
 	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
 	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
 	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_SLICE_PERFCTR_CNTL, BIT(0), BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_OVERRIDE, 0x70809060, BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_BV_OVERRIDE, 0x30000000, BIT(PIPE_NONE) },
@@ -611,11 +614,11 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
 	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
 	/* Disable mode_switch optimization in UMAS */
-	{ REG_A6XX_SP_CHICKEN_BITS, BIT(24) | BIT(26), BIT(PIPE_NONE) },
+	{ REG_A6XX_SP_CHICKEN_BITS, BIT(26), BIT(PIPE_NONE) },
 	/* Disable LPAC large-LM mode */
 	{ REG_A8XX_SP_SS_CHICKEN_BITS_0, BIT(3), BIT(PIPE_NONE) },
 	/* Disable PS out of order retire */
-	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00c21800, BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00c20800, BIT(PIPE_NONE) },
 	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
 	/* Disable SP2TP info attribute */
 	{ REG_A8XX_SP_CHICKEN_BITS_4, 0x00000002, BIT(PIPE_NONE) },
-- 
2.56.0

