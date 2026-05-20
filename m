Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0990DCD5BAE
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3649010EF02;
	Wed, 20 May 2026 06:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FEb0ib7l";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iUz0cxrp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D75510E084
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JM25Cq2143761
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hmDUYWP981+
 QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=; b=FEb0ib7lWqn0d0YTeFBkTMSpWgn
 oXWjr/nDAodLynC3DNsPwDf+m4gMm8L0aweTMZcrqRsHhQvUPdES38xuy4vwb9Y/
 +cJRF6oLOcwWyIH1cANqHz2zxBjXrxKPtHxcQ+m7VFnN5Lkuhprqzjy5reUbB33Q
 26BXA+vUKRVSWlk3zNYRkFQgRzCcm2aOJX/oU7/OSXgb48ukHrSXVrEZrxu0MEWG
 MPQbJkyoRNeN5YPQZ+imNpEVq7KGBbRaSojrHCDVPsTlBsSg27z4RiPYparXdBHI
 hcQImL9gl1bEz9S1IQcB0wIAQ6ahsy1B0p6fhmLmn17+tOQp1FH0KIBNFfA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3tkdaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd00a65673so33016495ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779259863; x=1779864663;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=iUz0cxrpHpGE9+giH68EK+j2puDveb9R97NabVSxcHrD9QOxlNhlZ5IA14rI1CsQts
 UvaXcFSFS0RJmf9V+dK6qyRUpowog8CiLJ3LpZAUh3mtzziHJvMdtR4gAsbU5fo4fZCg
 CMWBShyC1Od2G+0w4yuz8kpv5T6H+7QZgX2Cp4z9pyd4M52cRykiDYKtGVoj0McHZXnz
 5u9QAtkxGU7r0r5teXJH7fFOKcUM9sKRbJsnViChE8qQ+Wyf5Kn8tfkNPjDm870M5g9J
 1CWGBVvWY2kn+SQAcj1d8sgaEJ0iLy06vhZbVt3gXqG/FhAGd1cW17b/fwo1R1da20zy
 u4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259863; x=1779864663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=ex4hJhyr41oVqTRor32l6OcPso0xo4QNZG16Sdw2XXZYqqGuHUs6Mj7SINtveYGZuO
 YxpVDNEWdIeKhS1sYTfI6D7X+My0x+bSfDbmwW8b40PvRTFEHXKz1cr9sCcIYEsvL/H/
 F4gyXV10Dqoa+EfUOj1QTjS1F9SNuSEjbWHaxMyFDeyk5bsMnD2YKUofWd+VazBG1PkN
 gwTGsYoCVRcJMP7vgrZ/qwlM0X6vUwrHeBjhyuA9gtY0S/QxCIGRBIY0MvMJqyRwit6+
 PC0K1pocEmWwCQiOTzIBME23/fQrxWFJeAk8c09ktDblaf7aImGRDwlQLUHb0WjMl+wu
 QYuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/trIG0fiYRnBsvg+U8pP4It8gR1yT3Mpv/fPWkVUxylVyKeJyNNSdV3FX+umRMeQkdo1FZNyfQ7FE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD+d/GAeyRa/2ktP8tXcxwC+K/YtU3/OmnhuXTUwwSN3v3/0fI
 tyqJYrs5nXzhbid/+FeLie9H9PjPBRFQSpqkUtVSJNdSgwdVyW1Zu62oUH3ZV8rCQHOS12j6OZa
 xT33RlFqoFpi5E3Nke8LLqR1/j65Cx011JNxnk8tTzYCXR5phiwwhsDEJrEfOkmH59Soz14A=
X-Gm-Gg: Acq92OHZDo2injF/oAnSSj0dofv7ndKGtxTpl3ukmFYvzPIHnyRNql5vacsJhl9SDZk
 w4wpRs9e7QrFW3EdNujMtPaGtEVmgOpMI/gK8e/XfSSTM6dvLZfO4MY8JajF0H4qzQzz/JXW8up
 eAKe7F0MOY5ZfonfiV5rPuBnTT4oDkUVYVMot1593RvVbrxVf72F9N+YuCpU098hLBKR/O+S0Pn
 h4XrpSeKPJTB6hdCXlJxuwG2gLE8Irc+AfuEl/v3R9dPIjpr2Y8dFROD3vYW7n80iQ0++vNyX9Z
 haYXGrMW24sypBTyPB7fYTlv29E7XY2WdVtErvTYxQeVjbdS3A9Rhs+BMCImKrSwaCtNSVYgsnc
 lNLFvVaU3i1mY4Uc8i/pHaYcjIdC5lwRPgmQ08UtCsV1ZLXb9G8K/Kg==
X-Received: by 2002:a17:903:2c08:b0:2bc:8e7d:3dce with SMTP id
 d9443c01a7336-2bd52b54312mr225423655ad.27.1779259858128; 
 Tue, 19 May 2026 23:50:58 -0700 (PDT)
X-Received: by 2002:a17:903:2c08:b0:2bc:8e7d:3dce with SMTP id
 d9443c01a7336-2bd52b54312mr225423565ad.27.1779259857616; 
 Tue, 19 May 2026 23:50:57 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe51sm206410165ad.2.2026.05.19.23.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:50:56 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v11 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Wed, 20 May 2026 12:20:44 +0530
Message-Id: <20260520065047.3415790-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=feCdDUQF c=1 sm=1 tr=0 ts=6a0d59d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 3SrJjGSuxCzvqtdDFo_iefO9BP-Nyg0Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MyBTYWx0ZWRfX9zil6KmkbS0l
 ujx2nBmgKVNWsI2vij69IADohD311iQ2ORHXQ1Nyunp40LEHipSLC9FGHZdHtRcCa1pGWcai02r
 6drj3mf8VxzIxIctqoTP/7CIO2dxR+IQXiciA14cELzksIWjIJUlrY9eewlT0rDJ/GQiO7BY9x7
 MOX8k/qTm+Qpvhvht3rubWOzQLwMNpSrG3AhISPKU0YXoNqH4+M+u8X2iwoLWPTWCX/SiAf3/nA
 5lMJbeY/JFMOZ2KX2XNM1WBpPX3Dz9EyqukCrgOcNtsbAvbX2o7jtvGoXM74FPucaRo3zoIEVVm
 ffRNGniv2rIOV5BCO5CQ9orentab+sh3AlVMINnubouhw/Of9xMM2vcnRdwQct8vW2tN1xgQ0YX
 PhASJ9rfIctj7emxHThsU1S4rWS0+2P/FehAv0Ygtq+9WV98fO3Pc2Kr/yDg3q9r1Mf8OZizO4N
 GIDYWOSgQtKfN17Mh5w==
X-Proofpoint-GUID: 3SrJjGSuxCzvqtdDFo_iefO9BP-Nyg0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200063
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

