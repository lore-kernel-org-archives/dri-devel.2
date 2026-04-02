Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF4ACC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19AD10F06C;
	Thu,  2 Apr 2026 05:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aT62KUIC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O79QjBbD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C3A10F06C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:49:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6325VcLd091094
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 05:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gW0pzUiuvZ7
 Sy5PEGDehzgCXNgTwqsOcea/DS5PsqFU=; b=aT62KUICq4vixdMgPXJtK+9K2vq
 ErzhBqMcEVqEKt7wXoGByUuPzG/ep3EP1Jnrj5Zni+3Fel/+K1buR25XI/rPDPK5
 bIXwGNr7qtwFxgBRLGg4zI0BNSK6sWYq+qCOZr6mffX1kVW32gNL4JbpZJ2kFud+
 668rMEp1r0z8QvrRRzXZ/60sq66S1FCDm4jQcbNf+xwaSkqNG7MmcAt6amXxtaRY
 6dHLNvmG5rwupiqnnNNpgK7nQvZyMN3Jjy9R09sjCs+FqJHsnFoS+0S8eIfPskP2
 N+kUjtgg8NZSiYBFd5JvUpQ1gjP5M9OgSR4JCYo3sv+S5UOFG4J7P4kV8fA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9jcu820n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:49:36 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82c8768a704so285118b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775108975; x=1775713775;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gW0pzUiuvZ7Sy5PEGDehzgCXNgTwqsOcea/DS5PsqFU=;
 b=O79QjBbDzXt/RwDTM8hK6gw40B1BeOXxwYhFwRL62A+uFWsVi8ZnXJaG214ys0y8St
 g8smBss/drC1Wgd0wGkgM3syQGr9vpjROJq68opPVV68Lh2BDi9RvVGXHPZRIWn8xHQj
 6WFBl7XNR2pylyp97sH8NLdcNmQlD/uHm/kZHjtkW+9vg0q6JFt5C34naGK2gWNFp18K
 tXPcAhyW8BdhWrEF0tG3az7Lskxj8r/tc/aqJp+BM+5f5nkX7ZXdS/4ZxbUPvbZkjOF8
 z/fqyz3dnm2wLviohy9gbsb6pKYVFadNLo979dZIYFL1GtD0Ldw3JMxOic7IgbOxwUee
 +9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775108975; x=1775713775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gW0pzUiuvZ7Sy5PEGDehzgCXNgTwqsOcea/DS5PsqFU=;
 b=ebHb5Xc58vsELa6dW2yTY3gaR1p0hQNddZZO1KIUGRUGrFc9u5shQe+x11T5M+kwqq
 qiHuB352Y0j5bIR/LE36Xia8bLjKPpFeSOpZSUWAzvVUlPgKfsz/ndcmlKRr0LXBnwhU
 GerFCDK28y0gPMpW5+0bWQO3SFFsY6t+i5pWatXdUJLClXy7aMFiq21VYRQ8nl9hATow
 ySkzRUHC8QBYLc7MM5t2r/XHzGuESTGdRf7Y46dZMcvlTmrEzlD/To7k3Egy67/RbqMh
 MPJ9ZpW4QXLwbIXkwdOZU8JgBNPhEq4kIqQfwRxIiq8LYvjLdYRT7Uv/9S0fh+JrMKN6
 aH8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJpYBRNNcFZDGOBQIfYxHu521o2tOod4WamYhVSW1GWwk0kIpUFdCFkIsWNuBrZ7aBlJvaT+e/mw0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGIKL5TPqXsN9zreSMI8323CXR2IHTjh/cT5yrNt0W6v/DLqpU
 7SH16Ro0n0a3voGEUTVujwtPgdeliQnJQrlxHcOBggnG3cyb0K0Te5JHR1ZGhRXOkYkMpWTQRbx
 OusYYSkAW142O8OTJ85+T712Qz6r/nXviRY2w5hG//XUlaWodvQ/C/mrTTHq+eRLG3ka7n4c=
X-Gm-Gg: ATEYQzxSslfm95/JnlvoUv8WzcRIBfNz77gs3rLyfz6uA/3shvnXzIYZM/GtbIRuXqu
 o+/mRHoI1LO5z/elCoLXQjmyY5eJ8qpeyPRsqF7MDKLVnVAtaRd3D34y1owjRDq9puOCvoHFVW/
 sdLerk4Ya+EbaMh2VXUR4DIUEYuGqqzvTdmWgKSXvmv8oxaCppCrgvxJE+2oJOlO5zUDaFmw7xY
 cmFLw4aes+iu+mK/jEdago6IycOcW1upIVSRprdVnjv7IYMedkLsiqA1Es05Up0o7KO88GRuyZ7
 9IhvL12K06h5Rm3agfRETmulwWL0ZaWSL2zcXfITnzBon8kwmPn13A2vNajEpq0e+vfeSy8iLcK
 USiYGQ4j/aktcmvwsnGzKdfFa4ciU1jDs+J4c07V2ZNyGsAA+ZD6JJA==
X-Received: by 2002:a05:6a00:1d86:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-82ce89b8e11mr5803976b3a.36.1775108975485; 
 Wed, 01 Apr 2026 22:49:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d86:b0:82c:212a:906a with SMTP id
 d2e1a72fcca58-82ce89b8e11mr5803953b3a.36.1775108975015; 
 Wed, 01 Apr 2026 22:49:35 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm2167747b3a.26.2026.04.01.22.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 22:49:34 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
Subject: [PATCH v7 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Thu,  2 Apr 2026 11:19:20 +0530
Message-Id: <20260402054923.3061925-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0OCBTYWx0ZWRfXxTqj1bvO1nkZ
 4kAQXs4E2xxu2hp7qdDQIqJzTVp5yp9YumrA7BREhTYrMOWbmD4SzQdrGffyQSQUJRegMe+dXWA
 WxdfsLy9MygxFbegiKBRTdindiRTevgVcrgVLAbOOnUkyxOzEA9oem+L3Oez2NdqDz0NH8El3ZG
 M1+FwD8iJCSqodbHgWZ+Tt8earf0VDdOpqHjsJQRRHDQRqxvBod4l+7et2L5ZJpjhbccXD7nPmz
 v0f6CqwyuOZM6hI/1cZdjhd6G6UBGuNDnUZus2W9a3z+Kjro2qyyvqqFASJtVQY52DvNC5/xgoq
 lLBHLjukITeg1U3Pn0yvIj+rHHUJEHh8KkLHWTy2HmZSHetOgL/D2Ma70nVOMsp2lEd6Fh+vEnV
 o18oLsij33uFC0scY2d7VMQrdSidQn1/L6uiM7+W9AC82NV3wJqfg3RO4fgOodb+fC66lUZT2m+
 qu6oQ3I/ahsgwueFu7A==
X-Proofpoint-GUID: tOXAclGJor2l3CUKOlwS7SPCpHO9HpVU
X-Authority-Analysis: v=2.4 cv=eYYwvrEH c=1 sm=1 tr=0 ts=69ce0370 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=IPuuj3Sbi4WKP8RQR18A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: tOXAclGJor2l3CUKOlwS7SPCpHO9HpVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020048
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
index 47356a5d5804..11f4ae749e51 100644
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

