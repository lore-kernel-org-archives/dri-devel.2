Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF30C606EE8D
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XZPrJ/eF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Twa/fNTH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C6810E5E6;
	Mon,  2 Nov 2026 22:05:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A082A10F270
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:05:08 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6ErR3842344
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lD+y/1YnhCQ
 Ues59I9kPAO0opbelgLJYmff3EBA8JLE=; b=XZPrJ/eFgzTlzCNuW5jAm3Z4qFE
 CgWCBgH4Yhbmvrxc5uB9PDLOQwUyHLCnsWIUkxmafifib8ZNxGtPYhHdntkJLBZO
 NDKHeIAetioLIe1lx2MPlEkaue174Th9pk/8qifWuAEQmQVvrvEIJQRca/11HZyb
 PzFd5BAAkCO2LLCIXa5VRp90ciOUQARqglRBBNN0B1IkVvqTUBvoacCkM/Nm5dM9
 tlg+G4Wt2ErCDiOkzKYzWQJHabbaxDUq0W2g4Co4ODZ4iEMeIidx+yXw9PXLZ24u
 DUS4jPxingQJQx1riGS0lsIjhEItDvXFIvtLYAhyqVqEPlaIkFaB1PSFlUw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavjnsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:05:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3adf71ee6a5so4561037a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657107; x=1794261907;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lD+y/1YnhCQUes59I9kPAO0opbelgLJYmff3EBA8JLE=;
 b=Twa/fNTH3+U7+vSJy8oCRI5DsoYq6ElwwBPZeREfAJVGYjy/24ks8AO+/+aYQj8yST
 6WEtkstLa42cm4qBJq9ZqsrLK5YYlOsuhXoNneeGvfm6BFlhtd9LOTeLLbUQYPOmUt/8
 FHo0aY1RleBU+JBiUkC3ZOt4CVAeURt1iwjyH9AwRMTXA2oKV1q1DxI4zI3rOhMZQlZd
 ZimOLEY4D2e8MDEOd5PbchDL7b9NjeTwdl/AXNfarI9Fec7atKADIx7s29DkuaPnxirJ
 Gacpgly3VL6fXb3ayO4QChmtotSmPIswXlQMMS4YCTszLG0KxYghvWw70jtfFvZeSMj4
 dLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657107; x=1794261907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lD+y/1YnhCQUes59I9kPAO0opbelgLJYmff3EBA8JLE=;
 b=jigov1HAAxZ0hgoKAl/71vKSd3SxpP1xgza24FSjet230LPF0JqkuTDc4sbNoVU9zy
 TtQS9DOkGUTDYHt+07Ko4h0gsvkjekzPBxMwXloNVnYkGVLpGAnWA96v3q+QzpfCxQou
 lt4cmrQHVLnOrwPOY30N/NksHftQA52hP6Az+ZSWybmgyE7c/A6pBg2zwYBWnxvah+vM
 ll2LnGrm3uPEk4492SLWBsbuhcU4+JAsnplrX0CgCKHgyeUqesnn2STdOlUGJ0LFcUq0
 um5rYYJ8ycAFMFz1eW5aeSAtq+H0TR5jpdjzgxULEnmDoTnyqdj5IN9mk5oFEgfORM+P
 F18w==
X-Gm-Message-State: APuU4Z/3leCaId/LIuO20j1fVqYaw0itjd6dCUaOqpCWgYVlqxlJOeW0
 zezPG+EJFjPvKM0PY45JLTPqOjx5Y3ldwuQgV+m3UWvKYsE8Py73FaNQ+LtiwdYAxRZavDO4JUM
 oEuCFqRC8/kR82ZZTm1/kT4WjBWmxDHtEjNrXg7CCAePCMEwpmOSBBwu/PbHBxhrQV1c0TAE16i
 Xv9OMnLw==
X-Gm-Gg: AYBFou3n7n0Xn8IKKhrYQ3NCVaWjJUV7zhQIlMrCdbiHDOxAPOeNBWAs9+V18XvXmlR
 bBxQPtEqVcNsYqXsLbuj3B41n5XMeuFvhKx5/5j96QYBGFobcjE90mrgQZKvraNmHyP6EncJxhF
 3SFSAQnCpAreICNzi/8IRdE7bJ5jwqxv219AnhCaiU0MXm1zLGQtqtT2pio7ZDzYv560UwUaTp8
 1QjZkzVeYcprTYodqX50HGowVrU5tbfKlqIjoIl72NRGsa83AbGp4V2MKaRFCu+4Fa6rnvF/NLh
 8Mjrv7/0rm/7hnLVfbFrQpAKdrUtliqoOeEtNvNhfYhV9auSQ11Wr+IjtURJMqGS//nSXHE7BFJ
 LSPn55Hy6Ckf1tp9qdtJfbkfw1bDSsOzOGhbw2IEJhzPQoJz0RlJERFD9ifRux92qlh0CZE1kHv
 +oetQWw5kf1A0DFWifSyrBig==
X-Received: by 2002:a17:90b:1a82:b0:3ac:53e0:4ed5 with SMTP id
 98e67ed59e1d1-3ae89797489mr9555902a91.39.1793657106695; 
 Mon, 02 Nov 2026 14:05:06 -0800 (PST)
X-Received: by 2002:a17:90b:1a82:b0:3ac:53e0:4ed5 with SMTP id
 98e67ed59e1d1-3ae89797489mr9555861a91.39.1793657106224; 
 Mon, 02 Nov 2026 14:05:06 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364a04b8sm358654a12.21.2026.11.02.14.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:05:05 -0800 (PST)
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
Subject: [PATCH v5 13/15] drm/msm/a8xx: Use CP_PROTECT_PIPE regs
Date: Mon,  2 Nov 2026 14:02:57 -0800
Message-ID: <20261102220405.30730-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX973AQLdX9vBN
 OZGpYKzfNNXZjm2HgrMsYop9pgIWz3OAYZ64yZas09a7ZPjL3//AzbsA3/cKvc+F+av5BSJW+1A
 z4aAHWrigUQZ/8NE4Md2oOJZzidd7w9kgcKC55Tm1LN+xG/Akbs6eceeNvTKwmfYveLpUrNCgbc
 uNie6zYrCF7FFaqCw3SX73Jd9jPhDNl53jEZAnwa3cUx42z+U+v31RHQznp/qQJBR72H85hfNnI
 L1Wu6+/OndLvlJ1JsvzLK5sDlFhsSOpGjIOW0b4BOyoBg/oKM4p2pAfk2dIrj7QiL4V1s55NEyw
 5UuY/Lt2Bs7lO2g/e29v1Cf5jGqVNGde0sWsQ6yz+wnWkCOoY47TfVOUmyJozrcy78etgDuyihd
 qCTROeWE7p7avpGBHg8pVm193CMtd5lGuqvFviDFcYfyBwTjTpg2jpyLhhjk40+rEGUcvVKhkuT
 l1BWaoX0ajSpGPTCJjQ==
X-Proofpoint-GUID: rYmQ4p1-TN08uCn0DJ9BaXt9HDfqea8j
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae90913 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Dhg23qV5XRRJQlZlKu4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX4T8iAOss/SZ1
 df3bkECa/0b32dNInJmOTg4dHGmCcCDwpEHtvSVMW3RgLWCAmEsCawIm/KpzYKNaqcpPcoc0ldb
 zOmEuyP0NNK20kuSYsB75M012K8reYw=
X-Proofpoint-ORIG-GUID: rYmQ4p1-TN08uCn0DJ9BaXt9HDfqea8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
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
index 952c46f08d2a..0dd8444cde22 100644
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

