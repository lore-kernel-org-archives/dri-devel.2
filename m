Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46574FE51FB
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B147D10F49F;
	Fri, 24 Apr 2026 09:59:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bkquX0it";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kjezxepe";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E1D410F49F
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O7Z2sS4167485
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hmDUYWP981+
 QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=; b=bkquX0itnfTorykxkEFzaP8qlV0
 VmknViDWfTgl5HqdL7Dsu2TDilmNVzG/B9G1nAXf9WCsuxbPcP9shAa5cvTsD+MZ
 YhjyymbK5HTT6QEZwBagJ1kM2G5HS6Ky/qqY8ZfUrBLqyV5f1qGP4uWwKkv74F42
 x5TPciz/8sqXXIYZK32wiyX3aaYn70000Zxv2qL3T/QITRS+IMsgbnfli6OApPWx
 r1lTmG8UbNWu6dRxTnoOhrdcqRydnx4WIwhxv533cBNYGDCVNeFvMVbC1fEEr7Jl
 xFT+HbcJFUmmfc9wmAfdabPeYiruq1q3AsO6uYebOW3qcEsmKi4BKQNk4RQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr48n0nyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:59:15 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fbceb0181so4165682b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777024755; x=1777629555;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=kjezxepe5snNxi5aQnqgMPHEK7SpeoldUC64Zd8Uu3CrJLh2eo1Jf3Gyla+gp1vvGV
 DH+a1lxjiWKZnNwnvl5qF4SrgwtSG17Pq4LMlOjTnhDKe9tfMwDpuE90+XL4NNMiZnZp
 KKnFIBlVqSKCywjM7ofJ7ZgUdZnL2Hz0fEEpPzP0gFzJjN9KigDzuYwFyO/ZkMXqNq59
 P4zZakg6+mcWKwybXASDPOveI4wGuzWOjyyUkjm3V9Y1RrLJAmwRVOha2tR9ypJEs1Lz
 JZ/MKnpk3uV/rRJxQLFcJhcTBjbvAS7n9vjT33IOy8s8Nj5Ogt8Mwa9ZwnZFM/CpJAxd
 t8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777024755; x=1777629555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmDUYWP981+QEsAdC4yYWGwxCIUyaTrbIpAPDTEiCGc=;
 b=Ui8lxeozWL/xGPAYFVVgZG66swYmRPrfHWlK7tTTXF/mOONhOJidtB4JzkQXpL4vY+
 lrfZ9sTxFkYsfBWY1j6g1TDroYnskY2s3tVOBOfZ1MI+jMQUBdvoOEZYNxf4hCGDJFCN
 fP+aD/SvWivmpwZE/MVY1Ru9nImDGP4g5ccolhqavLfVyh0oexR2G6vRNkVD57okjaGo
 NWVNmNZVYDMwEdfLkx6hIfdOIcViCZ3UiBV/GcAlmV87qW0pbMFTcEQ68O8rrPhsmlal
 JwwA6eT2yKjHajiBEcsqPd1CDWXogVOXTeoTaYGzksuPhU/2zc1QmV02vxfA5f3o1b80
 UILA==
X-Forwarded-Encrypted: i=1;
 AFNElJ969/7C8XKhqooniVzAyMKHz842Rtuhxgh5OnHZlnBuHJLDytkwpsdsgGKeJ2QepHB0iRGX2CdMTUI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykegKeCG3lgfHWMb0eY9VehJZLgA6BJu/LulmYGRpXGdpT6PPU
 GqnRta0x/tY6FSXMS77seiZ8D3AtHx7qg89nWeNzgw5hMG12UA23zkzaabRGuwOvTql6jGd8bdN
 pMZiE33kiOv2rh1UNfIY6lXFN0QBrAKpGTGgu/BptqW3K9I2hjy/BHIf39uk7hA7xpdEUyJw=
X-Gm-Gg: AeBDievWZNMF9uT3tWCPanAqFSyuo865EJG5Fa7z0rpfLTNP091eZ7vdL2NTZGd0J+k
 g9jRxW85REjGqjk/wYgeRcdZrM0lP01Iu2P7dujtvJKcHiAYe9HL15ut5Sz4FhZfBkjWJW92XDj
 odkqH7lLoXRcqEZ191LAcrU4Cbs7yFPBCdn1hRRtISwbvr5KsGL2ShqvWaX1YZDMuMEcPdW+9Ja
 eg8mu+U4CZFNCV3Z3aeSi8Y/KTmbP76IR8lCkcvcVwNnS0KksJmzolzXp65OsuK8QGrAgIYyrXb
 KaVTpEJLGWqZ/WxFIVV/ZhWwbIFnd6jp0Mp8QjB6/pp2IoeBuM9fkcDffCiiw8146krsSRNyo3n
 CMSqnoTAOK8Go/NGvYJWE3eRaW/GPo+atL7yJ600rcRUzVSz79JphttqIIeTgb4tu
X-Received: by 2002:a05:6a00:2ea5:b0:82f:1973:4b96 with SMTP id
 d2e1a72fcca58-82f8c91bc71mr36146466b3a.26.1777024754917; 
 Fri, 24 Apr 2026 02:59:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea5:b0:82f:1973:4b96 with SMTP id
 d2e1a72fcca58-82f8c91bc71mr36146432b3a.26.1777024754364; 
 Fri, 24 Apr 2026 02:59:14 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9d35acsm23679702b3a.15.2026.04.24.02.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 02:59:13 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, ltuikov89@gmail.com,
 konrad.dybcio@oss.qualcomm.com, andersson@kernel.org
Subject: [PATCH v10 1/4] misc: fastrpc: Move fdlist to invoke context structure
Date: Fri, 24 Apr 2026 15:29:00 +0530
Message-Id: <20260424095903.1622565-2-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
References: <20260424095903.1622565-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 0pbJylL5Qw103YeW9HHr9jenqj1AqqIQ
X-Authority-Analysis: v=2.4 cv=VOjtWdPX c=1 sm=1 tr=0 ts=69eb3ef3 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=HL6mAI18knL3XnPGOeUA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 0pbJylL5Qw103YeW9HHr9jenqj1AqqIQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA5MyBTYWx0ZWRfX7Om+bbIW2O0h
 uOB1LKXvcsNAv756WbO98qSflUhG3Fv+Ha/LueKPRMPbip0XG1OKV3Wk6I1cGQKt5jJvOTCLsuK
 6A0P66sQLEEQQ7dFikrvaAniWgUtkYirflt1B6/XLIYAg9LkbUlgsRyn72gFM6YhVlM+7crC7aD
 sFekWJYnsl/AW3Zxbb6kI5CS1fLxJSetCWrYvsAO7qGilVIj2wyL9DIWpCwfWvcDbunFnp8XZL6
 sHgVh8Ogz1kvHpzv/k5Z1AyXpr+hE4ptIhyIfmu3rH1zL+IjGuFNrSEDD3YgyJVTeQ1VbeMZ6+L
 bAVcvHaVxLbLfnNbst8mjIZ7/PGXEXlnIJRuGZ2BcFKua6oeirDBHZwobXxVHZn5H3gcgr+l4Dw
 u6MG6p37XFHIQTgE0R+1niLLrsBjaoeZpP0ALNbVYpatRgLGNHMSAXv01VCAnMSYcd3nYxxGp02
 NfwuMq/N65G9150ZZqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240093
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

