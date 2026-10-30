Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB2606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EtTazA1D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OdXRg/1E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC1F0112A05;
	Fri, 30 Oct 2026 21:21:04 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770F0112A0B
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:24 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULBeKI1256299
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9SOSpuyRfDJ
 mYAf59ZWk5HR4noS5hxVrRszr7A88pRw=; b=EtTazA1Dlt333kQ33G9kYc4k1OY
 6jFrUKDmKzfsgUS0VG2bLe9mP+P1awt/E2fgSsi9OgDgc22zy7LuidtHm1Xg17Aw
 EVBQLQJxvBcH8HIgZB1R+3/mPOOt7hKOekxHCtGeuAPf8mtuMXlUgwPx3NwUsZbN
 iexXnpW8sK+XgpR93/5TDPVyKwaQUpCNozhMTOSzjiHymGRhQ6cy1McpUjt7+0lz
 iDXJA/Ma9c2miFHJYFpaPzrKJDVyHfqaN3TRmnOO9J8R73UFKlnXCXxtINkR/Sb1
 7cN+Fwq1IUDB7vFcNvH4BU/efOU8CBD+N+Z5Q5hYTrI1uVfx06Yk+XpsNug==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0019j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so1691048a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395223; x=1794000023;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SOSpuyRfDJmYAf59ZWk5HR4noS5hxVrRszr7A88pRw=;
 b=OdXRg/1EGa4SLSQl2RrqAdF6clNK2WGJa65Q1gCWytAm5bpP82dlB7Zt6FquhJGb+V
 CnAFEU+XX0a2If391U6utiU9czQhS341QO5vMHo3DQlUEmiA8O6m5HWYjzP8c6MeFQeX
 PLXgoMgJogRIw/4B0Z5uVwh5jKtD5GXhLAK0E76Cv19PdWQjYvytVtePNFrMALgI37lc
 3STK3E+iVG4vZmsNw/D0/H4pUGp7bi43CZDcLd5Jb4CA30s1Ds//yYLNtgOkaqOo7hGY
 z1vEmYB0BXk8XQhA8ggGo8XxFp7LBxorrP7QrHk/XQ7BQvlKM17utBQgnZxMJpOsJbxn
 rAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395223; x=1794000023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SOSpuyRfDJmYAf59ZWk5HR4noS5hxVrRszr7A88pRw=;
 b=VGVhgelTi8TYFClrekzFXGjQqSPCG3r9/BT3nDJwB3+LmXa2xor/uAhX/05/0hMR4k
 MlYVKIZ7KRkazzuoW8g4fJse9Jfa2UmruQE/0I/FZ1wQBX60GvlSf0QBV7Dy7OASiMGk
 /DB//0cYPmOxmpxVmwo6mSL7uZTkjHMaStMB7H0fcnM57RSc4nyptEtLQFYoLUm2Lckk
 xdYcv0QmCbJdIB7JqM9Cxq6WujkX2sGN/jacMQq8ZaARkO7sdFFkRjcEcyydgbKWhK0X
 /4IsNFLcKjQsm5LNB+GLzJ+UkE+rqMuQdC6n4tyilH7E1KNzxK2iBvWNej1fTGgG2iBX
 W6TQ==
X-Gm-Message-State: AFq9FYLs0pf9TJ95iumit/i6nz2aViZIinEqZr0zj1KtrFR4pSFk61M1
 oalGZFSNxs0LqYC2an93f/fANm1ckBFIqucLvtENEZIjFaDkncW1IX9BZJ2ImrB4DF0SmJHgjJ1
 SKmdjQ84+MBeZhbJdKCIT4V2shW6iCjdUft8Y6qhvktVmzkHlWGoF+klcM83dshxkvNX2aITr3I
 yEwDI=
X-Gm-Gg: AYBFou1sN7CctVaVux9m3BuJBOujgSXHoyl/kRuZzjGXexBGQsWdJtS1RyxGF+vIgF/
 KVtUAXHuruw5Zb/6uvZ4llNhLuTPAeoOf5h36bBMhcivdOCEUul2PdUMlodM/k2ZMgxY/gwpTet
 gSNO4URVhLPmTUUkBMhXtNdBlBSwj0vga1YUzK/34cMNVOqgY6P2dXC7yK0JM+TSObtcBahVpWL
 rua+zhdngqxoS9T48QAByQQmPXlsT7Rp+3Qa9sfJbnbEIZ0pWg2/ijlimAHOdEwkPNZt75O3GLB
 F4fb4Gu/tMURTB5Gl7b7XZG7MFdiMD2D/U27L0/kjqo//WVKI9h+dx3Wx/dYfRHBtdroa3G1Ssu
 U5VCH+W+wq+XDmzcxet+4Zb6StFc2SEXYbCoTj2yC6dntM9mlMQtrPQ9CEdbmLGuBX+bzl0DHds
 Dfpc+lFi062NvszhtcMIBBmA==
X-Received: by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5 with SMTP id
 98e67ed59e1d1-3ae897eb741mr3078132a91.11.1793395223251; 
 Fri, 30 Oct 2026 14:20:23 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5 with SMTP id
 98e67ed59e1d1-3ae897eb741mr3078124a91.11.1793395222885; 
 Fri, 30 Oct 2026 14:20:22 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85f37e7esm2711639a91.1.2026.10.30.14.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:20:22 -0700 (PDT)
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
Subject: [PATCH v4 17/19] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Fri, 30 Oct 2026 14:18:19 -0700
Message-ID: <20261030211928.45761-18-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fQ3gmYkopZDCdy8d5L81d0w8iW56kcX3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX7SG4s3/eyW9b
 y9fGV9HfQAzg0/NjupjiOxeNHC/xYcEXtThxIpG61vIzy47EgeN+X5Ah0mZH2jjcEM5Y/jAUA6I
 DGSnthvUdrtLntvdTNDuRoQnAQ/dChhucoZEL6t0/yZp2TXBVzoAj+QYttd9S0mI7h0ifi/ObKq
 Tm0jmrDewPIa7RFMzYqv/TqQOIWNAnlmCDlnIfBKc+ONhou5+CjAciIsXQSdW42+gerkJATNHZp
 M5+L/5UvjIAVfAJz5wdzpo8l1xgaO9GwPHqa9r54Lv4o+FKqdj/iQ1xPYm9FoCShyqR8TZdbdyt
 uQ+K4yv+pnKu1mjw0MFa7J55rjbh4w7iuw4HjKM+p86KlHZ20EWRSiT2uLH6yKd19pMksJhCyZh
 pHT2a3fQ4Myha4Ku0ihNduS98049rKY67yt/COXK3Y3SZwNk4k5kW593wolsRj45bb3JyAdRBiT
 J3bBrjkxZPQxy6R3zpQ==
X-Proofpoint-GUID: fQ3gmYkopZDCdy8d5L81d0w8iW56kcX3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX+XMcnwd5pZLJ
 8n6yRGY7aMUoBb3yZmn/sj2kkim8tMZDoNeYXwFBABI5s38CVvV5JbNo03Fdc1YYPRKVLUpMo6h
 SezoD4CUw9yF/R5+6wVbVrsO638V51k=
X-Authority-Analysis: v=2.4 cv=FvOQbGrq c=1 sm=1 tr=0 ts=6ae50a17 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Dhg23qV5XRRJQlZlKu4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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
index a6146372cf7e..1f8dd688b967 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -258,12 +258,21 @@ static void a8xx_set_cp_protect(struct msm_gpu *gpu)
 
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

