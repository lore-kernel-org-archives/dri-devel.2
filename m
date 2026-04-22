Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C3CF9B5F5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:24:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9976610E98A;
	Wed, 22 Apr 2026 09:24:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHrf/4OQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBY1fdm5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B1910EBD6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:23 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M5MkKV2209084
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ISnEXNmu4DG
 VhMqbwORuMrVkS8MlUvvf+D9exDaKuko=; b=DHrf/4OQ+EA2LvFiKGv3BLcxxH+
 D1keSCX1Mij28qi103rgC+sMN12z+Rtwh5xYixs7OhjZqmMpaX7m4qCYPHPLTULl
 PMq9jyvC3P/fCnmdH6Cbqyx2/6z4hNf3bc5jfqN4AUa/gQHHqQ4F4RskkvhJPA8v
 HLjzugcQN3aD4icLNAM46Et+gHkxVtoAmJMkFpQ0xMZlSO6ep0rDMNoxBjQCQOo7
 OMnZDzTOMyKxKtp5iSDmHtinI4E1KDKQ/vv/HvjP8k/DnMSgahtkKw7F3KMd6KBs
 KlN5Qy8mqMFt2HEUInzR+xyLfL/jezahsWNx1nlBdOV3OIHBVTyBfNprlXw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpengann7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:24:22 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f85179263so6525507b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 02:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776849861; x=1777454661;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISnEXNmu4DGVhMqbwORuMrVkS8MlUvvf+D9exDaKuko=;
 b=BBY1fdm54thu8gPbKXTMPl2rVOOMkJLYsrysEXHpQN8+FuCIHLTI2IdvfQwM7u3yq+
 iv3AFCCgZ0R1PMZ5ulBj1e6JOVLMU50qtYp4s+QLyWBRJXRELaXVekMxvJrA+SyebZ/D
 NVUVwLkxtN0ZQfURrveIo7EdfEHShot/qeExipA3H8m5m9P8h3DSwPABJ2gqU3avzvYP
 wgcse044f6g63UrbVLHMyEmkVGCxSbkyaSAirUMs2oeddDh4YWnm0utPxauPtQl7cpYr
 198dBeqw1ekcFS4drQnd+2Nc3q+1SU1mh2MWSkGfd5CmrC5eHhmwfSuyF2kqZ72n1xyv
 lh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776849861; x=1777454661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISnEXNmu4DGVhMqbwORuMrVkS8MlUvvf+D9exDaKuko=;
 b=bnTHFppUr0svSuID4SMIvD4+FykBW1roMgK4OJzBODif20lVUxpHdD5HRkzISW71hf
 wgBTbif3/lSYVO49w3DLBdxOH7E2RE41S7Vup8MwiVTHiWeTL2nSLNn6kMeEoDTjc8so
 XbQt5Mjg1nieH4uMqoi+t0tMecc8ThDbUamwPy9buM/IqoNOiXN74yCAj19xubouMW6h
 Laag/z2TxYX1ZTyFSF4Fu62XSmVHU3xQJ36g5kKA4OEVE6RanDyoBGZfoQwYlj33y6xM
 vBPTuYEdDJ5DxPoGP/Etrorl3uplz+6M94DMUfWc2GwnyhBqxQXp8RGE7ON1398xEmF5
 qIdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nFm9CIxhRLNTr9LiSuwb97ACkTbDAQNigZD70SrwpU6hvfX0ROZvPQjWADMr1qBlnizfHect+rCE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY9Ld4LHo5y4Ybuh2fXslmcSs27AhpPQtj/gxCMgw4bB2Mc0Dm
 VEx1E4q75iPIv8pKUAnleKJx3EvIjt12HerkXgenQNDePIx6iEJJn5aiyUert2NCLcNAhMHrHTR
 EtIZTaV8iKOvclvahu8vXKzsxGN4nClizkGQuA//w4SxA0QYtdGtiCBAUSWlC4PmkUTk2JQs=
X-Gm-Gg: AeBDievet8FJDnOave2B+eoiO9aHQfYgwjhAkr8+xgClJaNapcgIPbjd4UjQDHCwIT3
 SDSBZhOsVC7cOG3qpVeZpYsE4C21YKO4WK5sTCmyA3ARfZMySHA2ygeFgAokq88WtLSdLPWVe16
 1qFLawg1E7eREO8LW6ClYT426eW9TH8F6dPFQWNc9+rcfXaGAJC8hjB1fHxrroc0+kOdNLsqXqY
 yywYi+XdUp0LGA3/84pXuOfEjh+Bn7pqX2wD6pWziiH97NV5rPRDhIu/CoykRgAoLTZydLde14N
 fljsMZsa/AnBJdt+p55Wpp2Gep2b188DP7QMQOlPfSWv3ETbkZvsMJurwLUP88ZilS7JJUZb/cB
 7a5N5Bzlxv+kbeibChu1hSHHetkO68s1w3FJ9SZnw/5fLw+7Xrj0xgYGBs6sLGK3Q
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-82f9d21d516mr13893529b3a.9.1776849861163; 
 Wed, 22 Apr 2026 02:24:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:116:b0:82f:9d21:d352 with SMTP id
 d2e1a72fcca58-82f9d21d516mr13893499b3a.9.1776849860677; 
 Wed, 22 Apr 2026 02:24:20 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb38ddsm15778576b3a.34.2026.04.22.02.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 02:24:20 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v9 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Wed, 22 Apr 2026 14:54:06 +0530
Message-Id: <20260422092409.4107093-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
References: <20260422092409.4107093-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA4NCBTYWx0ZWRfX12Jl/+2q93v0
 wNLy8JINt6EcLFcfYr2LwUAyisEwVQgrC4Q65sckjzfXmzbWg5aHjrlnZr+76dMA66U6Z10UyNT
 3lnjEh2f7GDcaH1PjILdEjo1ENdbYxucC/QU45uDOxbI/zW5aUeY4e8dgWupY5jh0ibMChwya6u
 V+ECgBvDOXXLxuU99s/VVEMoKdtsKPksEIUj/8+nHQMzs6XsaHH8PsKivMbmx3oZL9YZcw/dOr5
 +odTt3Ln3ieMsdraR1DfI6LKHMHcIYQxyOJ8l6JYEcFhcZ26JCLD8mlrqAiSbzfWzHH1a8Abl1i
 lsJ0GOIr7b60sKyPaq9H6piK36vktjvsfOK/+/32oI/Sq1AaxAO8qkIl5CJJ7n/4JCvUcfOzKhd
 YObVY7HSaVUsHg7m+Fq+oaC6rSOvy7Su7scs9APPg2mQv4R5oC+dg49Y/K1zj5hS2A6GOERB0Yo
 8TFtxmOgCU5NcSdLtRA==
X-Proofpoint-ORIG-GUID: r8lv9htFP0a_6RckMhl1CtA24ClDxjM3
X-Authority-Analysis: v=2.4 cv=RYygzVtv c=1 sm=1 tr=0 ts=69e893c6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=IPuuj3Sbi4WKP8RQR18A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: r8lv9htFP0a_6RckMhl1CtA24ClDxjM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220084
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The fdlist is currently part of the meta buffer which is set during
fastrpc_get_args(), this fdlist is getting recalculated during
fastrpc_put_args().

Move fdlist to the invoke context structure to improve maintainability
and reduce redundancy. This centralizes its handling and simplifies
meta buffer preparation and reading logic.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..a9f507a88c67 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -233,6 +233,7 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int client_id;
 	u32 sc;
+	u64 *fdlist;
 	u32 *crc;
 	u64 ctxid;
 	u64 msg_sz;
@@ -1016,6 +1017,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1118,18 +1120,11 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	union fastrpc_remote_arg *rpra = ctx->rpra;
 	struct fastrpc_user *fl = ctx->fl;
 	struct fastrpc_map *mmap = NULL;
-	struct fastrpc_invoke_buf *list;
-	struct fastrpc_phy_page *pages;
-	u64 *fdlist;
-	int i, inbufs, outbufs, handles;
+	u64 *fdlist = ctx->fdlist;
+	int i, inbufs;
 	int ret = 0;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
-	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
-	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
-	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
-	pages = fastrpc_phy_page_start(list, ctx->nscalars);
-	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
-- 
2.34.1

