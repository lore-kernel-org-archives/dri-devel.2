Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71508F41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6A610E1C2;
	Wed, 15 Apr 2026 11:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lNuAfwfF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwOw/jMB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE4010E1C2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:42 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FALQwA3059042
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ISnEXNmu4DG
 VhMqbwORuMrVkS8MlUvvf+D9exDaKuko=; b=lNuAfwfFic9oteZQ2ytXZckml1E
 OcFEYmslPzLZp/3QOgYO4BlGlxBMgrBJKvdVveGfQBB6U9WMLF5r70FL/lANqYiU
 /feszuvvqEwZQuzAA7CE7LfC2BiRCkWWbiI42hudpNDoEJC5YEfFdrt8bGpTwpQ2
 h9uxWdLv70vbVBw13dlmtIztDhVNRCXULl/rG+969AAOaXpAtRDwGI1p0c7o1TMY
 zC7jEXVI6yans6+4WXPEvzWSN1Vvrz4mVBdG7zvUVPkxL7ZerjsEa22/dtrsWjH3
 CM8AbsQblsQBvvRvUHDY1aqsgkemu3ikJjftgTF5BY0Dnwb+xoQLJ1+ePhA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhtepty01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:25:41 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b2e8ff14e5so29915335ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776252341; x=1776857141;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ISnEXNmu4DGVhMqbwORuMrVkS8MlUvvf+D9exDaKuko=;
 b=DwOw/jMBh6VbC8wyDoUmTLE+exian1PwxXNpsNe1Ns0T/S9V1+qo+AXqfyHHa1PfEG
 vSKjO7CP5UUkArLH18b/kNfqRVP5+08uMM700ZlYEy/CHb+N4KNpDJfY9vazn6ux1qvd
 le+D0lwsIG/7M0gcnTe/6h7gkJpH233E3IK69oJPgE0foaCs3RjlTRzXbN1VE6HO8I6A
 MtCbrOX9uaoSGNpLE7y199jpeP6lDoJx6hbuB5Wrd5dg3P8pvRtAp+f3OCxZ++PE/2Kj
 5XF7HPbwWAl78tCpFttEgvrM/UW1BNNQ4O4Gw18+lT3T4RAjDabRWqhR/XWx0facFw7o
 +A0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776252341; x=1776857141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISnEXNmu4DGVhMqbwORuMrVkS8MlUvvf+D9exDaKuko=;
 b=mSz3KK8BpTYfJ1/vM+0I1DHdBB9NCu4Dyva534oCLSun1ueubPY/GjMzqaJ/lPg1Pq
 MZaZbwMtAcRwOonFbwLEqV7swI00c6OE26yT4s+g/2bolfKQ828hJirqdYLl1R0L+h6W
 MY82CzoThEHDOKyHEyBe75QuQZ+YvhtMUgzUjZWmtkodKXp/z8OCoQLXouLBl+FkixNu
 byrtnnFgsk4ZMZEYKDbw1ZNFp/ksLNAUxGphR3tnuyUjp3m0db60MuX3DdhxuHar0bRu
 RKb1RLBhlgoYArfiZhmbTO/daiAvhoEHyhkVUCNRgDcEFqeEdlwrHxglpfTi4I74BOgw
 b0hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/oJhDN1/ZAgWJlNtdUop4t5ab+DxyNADEU/15zW5TUj7z5Balif5B2IvKF+xbnsXFVfrl0+l0FMdg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxp/F7VXyrzmBMFb/yPGywDCxjYod2zg7jTSWiv2xMWu/ECuVDw
 t2zKdiyVbJkMP/U6oHBWJcbhMUf8uG/HyuHU127ha8m5SLeLVgK60SAtMBoTUyOjFGZsdd8PNs5
 pCRuzkQOwqfoqmeJHB/n/ho5OGISlY7E4Erxb6hUwvc3qcHWPimLyVJS6zc66L0sbTHc2tX8=
X-Gm-Gg: AeBDies3PaWa/LJdz1BvK+w8nBDFY8Z0F1Mp8Brs4/KNi1Br4VhR7iTtlRllsd7tiIY
 5NQ+oQslqcgzwYbs+o6g8p8xIsX7LOxcrW9He/CCsNpvytfpY4FCT5xMjryBhuGTdfNUy1tZQWC
 H5Cwn+/n7Eztun54SVku6oqKc0qJfmRB2Rc1VNz1SxktyMqNXDSYDAOCY6UMkU/5AnxJZPRv8up
 OVs+rQqxAwejTKxSY81YSm+VmHM7l7a4UhCMyNF/z+4gEER676+pD5t7exrBxRiIgns83hZBHyp
 Pj7ZK8l2DR2gvqf7j3J8OA0MZQ0rVGV4Prni0858up6uToC412aRoDdXXtS5rB71oKmDUfufgWb
 edkIH6qKLru4wGTpdPDBXO4elfqYkt17nOGoa3Ohevrvvm7k2qWp3jXMpcz0ludSs
X-Received: by 2002:a17:903:283:b0:2b4:5b9e:4edd with SMTP id
 d9443c01a7336-2b45b9e5280mr123918945ad.9.1776252340595; 
 Wed, 15 Apr 2026 04:25:40 -0700 (PDT)
X-Received: by 2002:a17:903:283:b0:2b4:5b9e:4edd with SMTP id
 d9443c01a7336-2b45b9e5280mr123918545ad.9.1776252339875; 
 Wed, 15 Apr 2026 04:25:39 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4782b6fd8sm26794325ad.73.2026.04.15.04.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:25:39 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 andersson@kernel.org
Subject: [PATCH v8 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Wed, 15 Apr 2026 16:55:27 +0530
Message-Id: <20260415112530.4083240-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
References: <20260415112530.4083240-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Y9wBntInlYfu0ix2W988mG40dTUJ1enx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEwNSBTYWx0ZWRfXxkzhw83K0VqR
 8i+dqqBeErwa39Q9t5fSDtnI5A4WO3Pktdu+PYTNpCRpPYyy9BK4ihKwgcqfRuP5ZS3j7jg890P
 UXY61QSjOy+HAnEyowkTxy5CwhA+vnZn2+QnjrxhOrRxEx6t2IrIw5WlFhSS6QEVDZmOh13XgUY
 tXufTVQjXLLba/5ZoW7yG0HzR+Bdq45B2+kqjWmrv9MEV71XB5/OELTBIMoB7wDtUmb4vHMFT8g
 B5PvCksm+nPEZ87P8SAfRETZ+MmyB8Pdyaj3rtW3uw031M8QHqwX/AaOTCx33wyMBFCB/Rn/dye
 99s3zd3QIKmOTtpYVDiVOaeAGFdDsop03S+9y6nBUCcVeTsWo45pIWi2OH7JJCD3PChv8rO1E6O
 2hc2JmNskBK5U4s/0w8rxVUkfkRVebr3pMdcNks9PkIw7xj2vWwgqKyMvqEZ8kjmFV9z4mnCd42
 4VfKELXiyGAcY5hQtfQ==
X-Authority-Analysis: v=2.4 cv=CoGPtH4D c=1 sm=1 tr=0 ts=69df75b5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=IPuuj3Sbi4WKP8RQR18A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Y9wBntInlYfu0ix2W988mG40dTUJ1enx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150105
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

