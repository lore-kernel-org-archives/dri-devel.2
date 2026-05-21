Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156B7CD343F
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 05:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75EBB10F1EB;
	Thu, 21 May 2026 05:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyumxlXq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCpXFEum";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A923B10F1E6
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:50 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KM1T7j3680282
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hmDUYWP981+
 QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=; b=TyumxlXq0YuiU1vHhbZ3KhNYWdZ
 gUJ35ZvQyZ+isC3km2aRsmKlk3NkJ1DMCksumlahLciUmw1JntOwUie+ZiC2eVzw
 yFIiJHhshAMg3PqZgcQsdOYBpq0zK+nYdb31RX9qvCWrA7SM4krQsArdna/fAVNl
 bL4e3fKfm/7f1bUVSI0sLgYhMVuE0nWwJz5bMtvWkAEEvM9q7ZbyKFhb0f/KFl3A
 Hbr4y56PeERuDATqfnJxkWNuwbXJZGtlI4fqHhidCCVtGatCEBfwi4s/6StiIa+y
 rrHn2fZrGPMtT0C1jlg/6DH75UuQ8BZGpQh3tt4c3rb+BWlAlOSXOsyowIQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j3a8n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 05:45:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365faf6006dso5752345a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779342349; x=1779947149;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=bCpXFEumDehD8n94Eis6AcEr+5h8y97YhNYICWw+MUuzgZ6F0AmFbwiIGjklFvoixv
 2hhgOePIcdJk2yYjrt1+n/BqUuJf+ew4E3x+bW0P5uJBmJJGttrS6qSj95dJL0aulZWX
 81Zf2aC9mcW6SSVI0x2uw3Kjv3BgMPp27ct1rOffYANkayuwk9ADn0xRkJ8Tdqthebyc
 RF3M177CTNWTTtmggZIG7p2/vyOmt7P3LxX7z2+xDQvS0MF7EqMw2PLx6UAoynrXBqFC
 ZlHE53f+/X8i2mhlRIYvWag2/rRDroEejZHKtU6VxImdBFL3WV0uUzek1xzPx/yiN1qL
 8nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342349; x=1779947149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=Imv4RaARjhAGhTqwuHZRHGsnJYLy/RwlhXNSX07McWqQZoc9OB9/jXy6Q5y3z5M64k
 O2G/ynoZ36uYQCIFK1a4n18GNeSI/VF27blQHGORbAQEWc0OmxrP23yKb4CDPPuSj2QT
 Mrq6C8eS73CH8Oc+0DsyiYyr8Vd7D18RsdtO+tP+ZOEZueCeuEcAvxW7qljMDbh8Suja
 ltWgeIxBaBelHWAnOHSwbdxnq/yvRSo5JnojzNDXPk+e/AIjsXuUxc3mTU48zOvcAVwV
 +LwFesRKG6bjc6B1Ng4EyB/MlwK5oq4Gc7Etui5gwM+sG+SspZKonDRj4Lli/UTN4x4J
 8Dvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/siJDXHlt/J+A1RPgEkiMnkx7Cpe7CmhjZCgxgpQivERjia8HgVzAavB3MxcP+7kNQHG3uocpZDXY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwU+KfDviaTw8+wtrakan8q5UXUH6qn688F7n4UVzmAuxPkPqxB
 2QNtDlVNzx8Q3FG8P+7BJh25Jt0cjuIlHR+yNk4WVrp88aH65hJBn+mIp30GkO+fae++eRcQSq/
 Rc7ErM9i1hZ1Ru6N8NGUfszPgbEyPtlma0aRbQqOBcAFalfJJkwdIM6Hs8aoL3K82q1Gh4W0=
X-Gm-Gg: Acq92OEBUU1zD1QdaTqOkUZXqXosdDn37y53ijcHNsNqvXlGo5KTGQWEfn3ArClcKMo
 RiIsXG7RSZ34QS4dcoSslFOBVaS51HC6ChYaxna3tYaLcVR0eCedFRZAJIIdBwTe8LAJoGlwyot
 44VzXvOaDT2AMLvDJuWrqsnNbBBbiBc2YSXmKc3IFrejz1df47FJ9Y8F3fXRKDF3h6+zhT2yi3F
 QkuBplRzMVbSBquq21I7zbZ+apPNc5xJvnDY8r1mPc8edxzjRDqNPApltz5Ipo/OsGT0N1qf66g
 GTn1LnFuC7eKstZIr8ptYtCJ44lpBuAn/EqaCvVHlNIFFmwuAJ6gnOz7d5L0L66gYdQA0n0Mdgv
 /j0chHI7wAP48gRph+MlyuRntKMInp7P4QIS2bh3Vhac5tnL8MwWX4G5G3eCrCAf2
X-Received: by 2002:a17:90b:4ed0:b0:369:932a:2b8b with SMTP id
 98e67ed59e1d1-36a451a6651mr1415910a91.11.1779342349019; 
 Wed, 20 May 2026 22:45:49 -0700 (PDT)
X-Received: by 2002:a17:90b:4ed0:b0:369:932a:2b8b with SMTP id
 98e67ed59e1d1-36a451a6651mr1415881a91.11.1779342348496; 
 Wed, 20 May 2026 22:45:48 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3cb323e3sm1474847a91.4.2026.05.20.22.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 22:45:48 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v12 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Thu, 21 May 2026 11:15:36 +0530
Message-Id: <20260521054539.128651-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
References: <20260521054539.128651-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0e9c0d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: d4lQJibmu1MbnHdvIJiaTJ09E6vRfXHx
X-Proofpoint-ORIG-GUID: d4lQJibmu1MbnHdvIJiaTJ09E6vRfXHx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA1MiBTYWx0ZWRfX0EAODwdt2WzT
 oQp52pCp3HTWrpohvS5k0nOuc/I9YTMsjttri5UmqY73aCM+yLdY6xWj10ytUDzQXLZkJU12O17
 qLPgPZjE9nHBXGXQzg2L3n+6ZsVXczB+QKXVgHDyz7Utz3xfOyJF/AKYLJdqdzM6oq6SU5G+Lid
 sde4gJ/47fyqLR99XrC3MAcCwP/SGtx4JE7cGbdMSWsgIs0WDaVRYN+H0uf78abbcIcfGoUdSeo
 ri+8xdA3BX0+FZTPcyiGgXEvt5mG+/wHgcwlfNwyigyGptetCgLt8EC1G0dtyE0KmZyOxLjUZhu
 4dTUUlQ3CT2WPvGhpl8UM+rU2hjdCLmQRFDRJBxgdIVPTsoEn6x9CJBhmVqUO97P2i4JKHs0tMf
 fSrywWvD9XpPg7F5iOxd7TBvFeta8PTVLAvbloqrRO1b2s77AsdPxYwcEACThkkx0iwXqluT3MD
 wHCnY38Z5SILHa+pO2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210052
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

