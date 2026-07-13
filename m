Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F98EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738FA10E53D;
	Mon, 13 Jul 2026 05:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FsyCIB7K";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XICG5H9U";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041B410E53D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:47 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D3AMjF258569
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TPodwT/8PmT
 IoV2zpAVITKv1J5JC+XSCVdQXBOcAIqc=; b=FsyCIB7KbwJydq6Ptp1qA7tL5xr
 rIuxXM+cplWdKwJGGH0HKO+XIIkG3AEeiPF/mn+3VGZc2TnnrGXFG2EPl7138ECH
 Qk9Gx0sPKhmhBW+4EswZaWK8C31mnFDNVTDNW7l6WkXfiRC+NKuAYJ6fk6TfscRs
 IrGE6dcttmGvxKI4rL6QxF85xxnXkEb01M1Kh0hnY2/x88c2ApDrImwb6GhO94r7
 wOTUvU74rxF/BRouC4M+0nnlu7mLpiUU4/eIhEma/PjwZnIiMPUilp9V1G0v4OGs
 qMbvGkCKgxh26l5yQDrpx7pp5G1gplaXZakcQkZUxrstoIyLqRsyBYD4mfA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9hmfaw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:22:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8894570b58so2006050a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 22:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783920166; x=1784524966;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPodwT/8PmTIoV2zpAVITKv1J5JC+XSCVdQXBOcAIqc=;
 b=XICG5H9UlTo5a/jWuZg4dACmGwQh9d5A68zWzDvTO5TxXXtMV1lb+UYqXPIpFaWE0K
 z7R8HpRF7HpSmfPtKYCi3auPaDFpQYtdbqAYuoiEliog1lno8xO/htEeHr5KV6Ue1UhP
 mVBvm5iARlNQg0e4HU1MAg72jty7Z4alQwm7BAaxmmId3ui4A9Cv0X2QUH4x+/TAv1Qt
 D2E5dohBqqg2c40wh3ciC/I/T4sNoS16j+s9I/6/rtkyT/w75rW/UwIFcZjf3de24A2M
 SBV/HVSFd364yRvTnhc7NtW7bxxnkS+1XYtdanR/voxLUPq+ckywmPkGxI0iOIpTeDXE
 HqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920166; x=1784524966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TPodwT/8PmTIoV2zpAVITKv1J5JC+XSCVdQXBOcAIqc=;
 b=q/3ADxyr9N3egTXkrDwsffUtbm5dKg3DHHjQz9pkRk3u7dB6uVn0cp9B5mOQiIdnmg
 JP4QzzufJZXyheRYmY2PD4bQbnvTlVkn9Pdxi9j2pfQcDAuSPwJmZQU91PccbPs21sL2
 wsACRU04geEPVWel5ledMYrL87bZF76zXnkiKL3CRnMnf9FThPfrnuDMCvZIiVjSR133
 AZ0FwcssbtvSdOiEQkQvD9JthfH/FywO2PjXBlCXWizRrhitH37dmNJJIhha0d1yYR+6
 ONm02Q8i8NGb5iaA4WCuiCgaPiVYKbrf33+pMVXnUlrNJ/V6F4W/3DLI1F9NFPChN4sY
 JjKA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqi08BNIv82RT9cZb0ZzZFIjHeJDWi9YCEmk2Ui+NuhyshLFEzhhEB8rxNhfeHlnHSr/OC6G61m26Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz3s6vpmLaVi62qjh6hfBrEPuUqCVHWpDIy3zh/qVt2rhi8V5v
 9+ep26kkL2EBU2tiSBtq+dRHbNJDX6qF7+dzk9FrHZdSVdgeaODzW+I58XT0zBmXpoMToIKKCYi
 fnoURqtNQDaHH6Vc6sAH5di3Z4B5n1ZjXycvdESk8cPuH6ZFxbVWv6ySPTRX1JoyQMRYoNUA=
X-Gm-Gg: AfdE7cmG1i0JdJr1u1Y+gRGoH/pJgFrCeHEjA7txFdKHx67wxgmbPxNrsCN2srR7skg
 xhcWbpQpeYQ6MPS7U2yPBwcTYmh49dhMTyRRq1EN2nycpwPiRevLvy1arAL2NZjbBMmz5VrfusX
 zc9bwtpbWXCBoPiHGlMzyVhACV5oU4oA6NHGqofC0zdffPUCXILxJYqMJ5CPcYJ1uOZU3JDCrir
 dRw/g8S6jQdVbD5ffOAJVkiJNLPVpZa00IH7f6HecMpeAwEYdtkRBCR/u/P6ec/ySnHUFV2S41e
 agW8F8l6zuq2oxrTrg9SsM8XkYi4ChQKT7S0Wsfhkoz3BhgKTV5mbH0hndfGSUw5lERMf/4ZY1S
 7SipIfhQDrrlUppgp1uMU6BQp05nz9X5tawlY5SirQ/I=
X-Received: by 2002:a05:6a21:4a98:b0:3c1:657:4c95 with SMTP id
 adf61e73a8af0-3c11077660fmr7861503637.15.1783920165910; 
 Sun, 12 Jul 2026 22:22:45 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a98:b0:3c1:657:4c95 with SMTP id
 adf61e73a8af0-3c11077660fmr7861490637.15.1783920165393; 
 Sun, 12 Jul 2026 22:22:45 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca75ef0c30dsm6245605a12.17.2026.07.12.22.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 22:22:44 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v13 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Mon, 13 Jul 2026 10:52:33 +0530
Message-Id: <20260713052236.3033744-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Myge7rVf5eHBFjIZooxxG-rzHjkdJpbK
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a547626 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: Myge7rVf5eHBFjIZooxxG-rzHjkdJpbK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfX2unr0EMGMKWK
 zolLW9R4rWrCB/NOU7ng17mWcQ62uSwgnfkn2J3vzYEthV0dK9fmj4QuWWSJoP9UPtEDXNW0qos
 V3BkvZ36xwGgHI6A6c+4jj/M33fFi/rKYWLSB/2V2j2Kq8vdIgBQHnaOjgWOPVqSjzQNFgnu6AB
 S+y9VMbKfW72FwRPZBQ5jxVTe8VYLA++Zqy8vh1BvR6EDEgIRtgz9oVFFNpFblERABVtTveaTYi
 b2/ofI7OLoF9mHDMzTgyQPu5Ig9M24ONkI1qrzssAbNAr/rgaVwfIHCSls82O5uaBqu57yO4hIU
 o0CzcMw8DSQemQf8wDijMrfukodHr7xpmFWETFA03hrOwSgjzbGecPYCZ8prNfcvgCOLesVJQl4
 icZz0x3gntE6J01r2x4PEES3l+a2nUGY96UsyBxmWiq1rXJrssTxhdfvGyfuHQTmWCEjEsbVmuH
 FlVUUaU+jI+GEiiH63g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfX68epEAo+9Idg
 fYjnmX0EDAq4B0ayRyc2we8Q1mQxxiJdnVKhuBe4Lyk1BOfUCYrXzRLIR6VziXVYjrMx8cN1N7K
 yqC/FBUPVnRXNOdEHPjH4Jl7Gfc1cjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130051
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
index d86e79134c68..02c2765e1188 100644
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
@@ -1063,6 +1064,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	rpra = ctx->buf->virt;
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1165,18 +1167,11 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
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

