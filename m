Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CBACD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72F310E61F;
	Tue, 26 May 2026 11:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lfHn88wO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1+/6m7r";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EDE10E4A5
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:05 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q5xjcK1604516
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yE5zp//7Dfu
 QE0K36XHvwhH9aqHThjhno/dJ8VRxZKs=; b=lfHn88wO1tzZ3YjwQ7qLJba1r/N
 zWBI9ee4GJlrXDpYax4eKjLCEC2tC5/1rek4s0ZwVq6ntueyq2rlKlIbY8G1DkmK
 uM/RLrsKvZ7tSYLsRu3Pb9TVDSew+faoVT07bbaf5MPp6r2AfOKQnXcev7Y2u9X3
 x2Q3RobBvzH1wCYeWLq/c2h+4KErfAUUBUCFyKgcR2zxZeY/bBVX6SG5Si934vR0
 zLT0KUnKxhBXJAuMnzrsK8vTWToIXNbLKaV2Lc4cLd5zVmaY3zSYJfn3pLAPN/b0
 umqbM0nd2IdRbyR0r4iX9GBL8A9ntvH46TDvHzxYH6XZHLOPfgIHigwhq4A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ed5v3s73f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so9477006a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779793924; x=1780398724;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yE5zp//7DfuQE0K36XHvwhH9aqHThjhno/dJ8VRxZKs=;
 b=D1+/6m7rA0McrhtLW/RunxooD1TRBEPClrOmCRLVVZv7oOYsILrh56hxCRcddgZSbP
 tDJihaw1zAwk14/wQ/qeUXRXwJ0znohaxK+LVhml2JbaG94bL7t9f79Zpv5l5PtnGKpq
 KU3NO7iEOpPemYSIC1SiO4DuXxlsY+KDwPf44nNBojGToRjQLC7/3iC5eZHfH+E2K7zV
 yyL8i8aS9aqYa20zpt01EVEIdGbtsKVYO0OFkOjkXXq9JmvQrCHFBbV3s3mB+9zPqV3z
 RXc/S+qINzXPP+cil1niphKuzQza2X18a32kP5BsfYICu4bWWiQWQPSreB4Wvo3o5aka
 kBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793924; x=1780398724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yE5zp//7DfuQE0K36XHvwhH9aqHThjhno/dJ8VRxZKs=;
 b=gJkwPKPfhVTs7PKyIins2u81V6xeReascisi7iMzDQbSq79fa/0WNARJtBG5IqeqhT
 h68CRCMYBg5k9M9Rq9V1iGRvoh8dLdFoV8EXAkr3pO4uj/5QwuWAFqPKlamuCuD8EN5D
 OsPGqUGw4rQmd79A/xSB7OQ3YZjCeSfnsKMPCPSFAndb8CVJ+ZzoE4vhI+kjNqjc0/go
 gb37xxocMVq9lVbPCj1TYBbzPH2rx+JxlCNMzigqhnLdlUdJiZ2Ox6fqvn4vCSWhdhtq
 RRLRSe72r970qvzGZlSBQwWwCAXKM2cir43pAedZu2dmBZAbiSGxVlG3CIF2jGiU/TAb
 z2Ug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vUJQmaBTHVj5thIyGpKC59rFOPbCL3Q46vf7YvlIFNxN8prjpNa+7J8WjsEPDFHfONknWD9QGNHA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwF0X0/DfNZe+aUZAojqTzbfgHHH7FDn/Hvt8y9UKGXMp4oPGGB
 uD1H+W4nXueu9/JrzTNUioHXMbbvLisVhUgqhHfcBo77KQMrptDLv4DfhuGGoeqT5pEH4ualI+2
 N5zVgJRmtdcEKh7PdZEW1C6G4K/0hilRW8nNCxG6rAbjf10nNPqGJ/H/zywS27Fqlbpn3B8g=
X-Gm-Gg: Acq92OGBv3IJbXvzxSyO5id8EBxiUOkwqFKkqdXsFwVkRi6bu2C4O+Q/aBUhLJP95F8
 M75lZvYjoqlILLbOJk2OAqpywn/LGs+glYzbdwSJsEqDp5J47IwFN0+3/gvxT/Mkni2YVevHlWd
 1Xa45tZEAG8L3aawgpKxMvd54IPdUj3m3ryzdO5kinMbIp5Nz/QECFjm0NVQtpXPUFsn+SYL7d2
 WXb3ERcoqsyZ0VWW3fnm+OJD+duT5S+rKemRjRnHZJL0CeMSqeeE8lK1mtg32U2fOjxOi5KU3Rj
 hmBnvopavml5fldh3MelM5pno0UtPQQNAHWRvH1Q6VG6a3ot0dzchESp/8uPJiw2cAWms2PjgHK
 K3gCwYbK0p2uzGspDmviLq+FaFusV9Js3lwcWaaVaEvb2kmcpXzGwogD97sQosh1sduscnE0q7P
 DS396GTQKxczi7LvVu0kohiiuFf1HT
X-Received: by 2002:a17:90b:3b8a:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-36a6749eb2cmr18032373a91.5.1779793923457; 
 Tue, 26 May 2026 04:12:03 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8a:b0:35f:b647:d98a with SMTP id
 98e67ed59e1d1-36a6749eb2cmr18032342a91.5.1779793922963; 
 Tue, 26 May 2026 04:12:02 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4ce6bsm12104253a91.11.2026.05.26.04.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:12:02 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v6 5/5] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
Date: Tue, 26 May 2026 19:11:24 +0800
Message-Id: <20260526111124.515-6-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
References: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX/IjCzEU9gkkP
 iMconkqB4gTVaweIQ09SxfiCGWV9SaXUDXJFJiSjcBWu8dJ2DW1PCi4kmk1MbQv7LHcXtdOBPcd
 YaBm5QgOyikMzYBaW+h4uGWfaU0UDnFYY17sSNnlj1xLAPodevH6xfcrU40vhZYdGovsj8DVBJv
 8LUW01sSNQ8gy4JdV57REoCkv35UidrLPlXbjP6Jp4p/yd25gHPhSQLkRXH5J61B85WqoDJygBc
 8IVcsz5iiih48LG+ASWSo6svKEV4uX2dDgmz5t15LHv5It7rBi2rgIiaFfzndusj+u9GlHaUUBu
 jpB+5A1+atCQcM6ztgnTeJrePCPmjmrW1qezpsqD5kcwTkcF2DaL7rFmc1l7Dc70O7Ktpe188/5
 4FsB05n5CAi+VvoGnd6Mdhx5ARHtVkqZe3jXgeQ7nq4OF28asu9sNIVNADVMAE+RHkEp1dEpFOZ
 pTxQU26nADPjympq9Mw==
X-Authority-Analysis: v=2.4 cv=Zc4t8MVA c=1 sm=1 tr=0 ts=6a158004 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Dpl4kN4VNrDjC7DZWhsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: mPU8lfl5HRtToSPU03gUsX9lKqWtvtIA
X-Proofpoint-GUID: mPU8lfl5HRtToSPU03gUsX9lKqWtvtIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260097
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

From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

Make fastrpc_buf_free() a no-op when passed a NULL pointer, allowing
callers to avoid open-coded NULL checks.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 0208208c2d27..6f3cb4934156 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -418,6 +418,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
+	if (!buf)
+		return;
+
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
 			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
 	kfree(buf);
@@ -510,8 +513,7 @@ static void fastrpc_user_free(struct kref *ref)
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
+	fastrpc_buf_free(fl->init_mem);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
 		list_del(&ctx->node);
@@ -556,8 +558,7 @@ static void fastrpc_context_free(struct kref *ref)
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
-	if (ctx->buf)
-		fastrpc_buf_free(ctx->buf);
+	fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
-- 
2.43.0

