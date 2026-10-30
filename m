Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F6606B7A6
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pffISlYU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QFulSBmG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F2B112A0A;
	Fri, 30 Oct 2026 21:21:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69CD112A07
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAlLL236391
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OtO56gsUOoa
 TL1zmCg+YLEyJHGzsm5OYIr2H6Fpnghk=; b=pffISlYU5dpeafwS1/K8hbF21GC
 MuuC8Gq4SEPXrfF1IV97LqDwyYkXi9KF3CPkxoGUV15ZChucR9Ns0UdW2nG/K18i
 sV+ka3dXez1zya2/wN/xS3cOGTziXy4Dw5twN5P8DnAK10Z4wxwqBK2BV55N9c4K
 kn7lJeC41ffk0cmkeWVIdfp6JzlySYNm59uIvcqAk4sWll9uf9Xfkqj7FYNNp+i1
 +xGmWM+pjJmbUBysOcI3ZkLoz8jhJ7vo5ZRi4i7Tah49D4TNkcfL7f3HV7qExhq7
 vth1nlsM3TJ4zUpAqXYDR6zKvIaC9h6+HVvNx2yPlwGUUdxRnhQXTEISxBw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x001ek-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so951185a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395222; x=1794000022;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtO56gsUOoaTL1zmCg+YLEyJHGzsm5OYIr2H6Fpnghk=;
 b=QFulSBmGX8jpl7AC0DOMXjwkNYgyUyY5fphR3174kGQcODgkAD7POZ33rnL6iB981Q
 kAwTwA4oWkQr16sQSGWLuKHY+ZaBYMUT5pGkIijhS4zpP6AqhkGDCHLVse/agnidtfF4
 1HZTLMgTuAMO0fpWAh8+h2gLoJnXqfCH40kZsEkwEv2tE008DHyWqIvSLwMs4XBfDI1t
 9+TQYdIpdwxQCCREJ+ZhcpJoes/1oA/BKkXUjfw6xEi76n187okcPwpXVuq86c7WvXbF
 qrcDFuBJqOP1qfqivKfGzUY/O79bpjgEQGkiOiK/D9hMPKzM4+iVa5QAjW4JWmldyLD/
 Vttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395222; x=1794000022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OtO56gsUOoaTL1zmCg+YLEyJHGzsm5OYIr2H6Fpnghk=;
 b=s4Gp09W1x2wszNLdXhun8kVRBNaqqPOqQ7+S2u/NMM11Gb39Zkzb5IvSxNk8B0x0z3
 fzh/ju0t2i9nin+RhSwOtTIkFcC/e9GdH8ZUnyl0bry30Fl3DGC7+k734tOtXTTVj75w
 lskEz2qlhmuiLpxSZF3gx4ommeWWnmyHlsFC1YK3snju6Sw3yqpUe77xt2KOgkRfyTk/
 7XgVyNjDVaI/ldsZkQNEcClWmO4p/bOVBE4cAp3lPlbKb/RXTdQJDXXueYz/1HSQVGx+
 kcPi7jozBE1xS7SE/xFJ04XEetCevafnKZ0dMal88oLueLgOunZmnpPzyKb0MfGvG2wi
 c3BA==
X-Gm-Message-State: AFq9FYJxzbJykSTlCDj5xVns759D3xYg8l2OQRIUD02wwpOOHs2ktVMe
 sFb/JlbU/fcnB8aovL8Jb75A0eCEddXXvWBGlzowjY5Plpi7Ow8R7RW4YoMmRtN6Lodg6yKZvvk
 GA6x/GOO2LzudUXgmG6EM+LcHFKx0jn0WsuC4jDK388LP39koetU9gUXwgYm9HTEYbgETyeBoda
 kQW50=
X-Gm-Gg: AYBFou0ESMnKXvLcjVPJGDi5TNRqB8eIOzH89TWV94Sy4t6hJOqjlC7PYTkAs4Pjp7r
 51rEzG+YWANv0LnjahcGapcCLvf3bLO4ap0aaZpLDU8cPTUpDoD4SoDpv5PJMy8xCHWR5afzSrn
 Cz5OF4I2VlQQ2fkEQ1MC58LSFXoFdbHZcjCXFx9YQ6vpNLLAG2qdNCTVJW3XlpRoRzDhfU39jvV
 lOcjIFTvYuRIlKc86iRKfCNgJA3FQFbr6bM5TZPCMCZErJIACQCSSn+dusSxyJmki5hx6whM5Ta
 KGpoG7xzLogEoFRYcLXgvOxqOxOCs+WHq+r498voXGabEFaL3sKTxp8oApCO47yTlVwBK67AfGa
 ONgWR937nvAsUya3mCTO1OBg1CA+A4eGS494NuZrkI+JMDEdymleqQXDPc89mAn9OtTzwDHTouz
 DnXuLjpPjL+GYxTRry46dntQ==
X-Received: by 2002:a17:90b:3ec7:b0:3ac:7406:b49 with SMTP id
 98e67ed59e1d1-3ae896d7a1cmr1764705a91.15.1793395222064; 
 Fri, 30 Oct 2026 14:20:22 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec7:b0:3ac:7406:b49 with SMTP id
 98e67ed59e1d1-3ae896d7a1cmr1764689a91.15.1793395221604; 
 Fri, 30 Oct 2026 14:20:21 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9426ffsm10032472a91.7.2026.10.30.14.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:20:21 -0700 (PDT)
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
Subject: [PATCH v4 16/19] drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup
 reglist
Date: Fri, 30 Oct 2026 14:18:18 -0700
Message-ID: <20261030211928.45761-17-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX+JYkz9K1t1GG
 YbmOI9zscN9XoNJV+KLrC+HwyP0Vfl2EGAGVOJddXTzF72lEaA4OWVvNLUucSUKUGA9buI39ihh
 5mppfDpzpIi6QDEBsc73ywcDznEHQtE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX3PX8X5Tqu+Xr
 /dukHUn9Ovo73fJUz+6JLav1pI0tc8c2ePiN8rby5Okdjm6okUFksq1ci4YyObS4WhDmEwrhyyI
 4olgFZZJYvR6B32Xbr536U7bHZY1jT9IMv7uISOpwIHcy0OPyNqp6mwrRC2xPzv40yeUQMMMo6+
 szh7JRND3obPpxGDBfawj+MKfxE5e/BgVB6vaYe9u4A0kwFp/snzf4N6VTx9dtmMKEmTxpngi+5
 Kt7HCMo3j+p8VS+WqotS408RGBu/KzIkNDUdA11bDpV5HXJh+IUobHzCzQr2Q6tFoSV0Z3ir/EH
 iZuf3Q2cNK8qG6iLfU6PbJEXZiK2T9/OdSoEiVCBgaEVqTJsVHWtNwbUnYZ0eEN7ctKdc41qNvZ
 2cMIaEAbwQzupj/2D7KyP0U2fnCSag==
X-Proofpoint-GUID: q35njwjBb5uEa9dOGrlAKbxb_tjqk9aw
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae50a17 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=GwKEIKth3DexCsueK50A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: q35njwjBb5uEa9dOGrlAKbxb_tjqk9aw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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
	SPF_PASS,UPPERCASE_75_100,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We're going to start using more of the CP_PROTECT_PIPE regs.  Rather
than missing to restore one somewhere, just add them all to the pwrup
reglist.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index ad9141f76d88..6fb35db73db3 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -276,6 +276,21 @@ static const struct adreno_reglist_pipe a830_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -437,6 +452,21 @@ static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
@@ -670,6 +700,21 @@ DECLARE_ADRENO_REGLIST_LIST(a810_ifpc_reglist);
 
 static const struct adreno_reglist_pipe a810_dyn_pwrup_reglist_regs[] = {
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
 	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
 	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -1083,6 +1128,21 @@ static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
@@ -1532,6 +1592,21 @@ static const struct adreno_reglist_pipe a850_dyn_pwrup_reglist_regs[] = {
 		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
 		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
 	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(0), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(1), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(2), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(3), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(4), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(5), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(6), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(7), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(8), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(9), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(10), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(11), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(12), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(13), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(14), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
 	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
 	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
-- 
2.56.0

