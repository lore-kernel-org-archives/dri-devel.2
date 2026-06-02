Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A42CCD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAB3710EC90;
	Tue,  2 Jun 2026 07:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ByZDtz2q";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R1bY4GDH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E508510EC90
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:26 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65245guZ2691969
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XxSW8cHQ3wF
 LpjGnuSGsblT6eUW8Bj573RsJWQBn06Q=; b=ByZDtz2qJQePO976gng7xi8Vjrw
 Se1iBJREMQVB0NCv5VHkj/i6E6BC96Mf5pLS8ymFkolbmhskZh9kfrek7a36N0CP
 WzycxL6DLH2l7B8Z4yznsMsfFgaO/d4FvNnld3cZ7rFegysezQYg1+LMBKP7QJnY
 M9qP2lM05D64ferTiMvouAGa9Y8ZyuA2yH1QRcHchmwlVmSrH31seAANWu8G2HZt
 tdzjxFTnsLQ8+JjUebx789Gjpkd1O+owDiJHBF1C6JK1De8VCsZG9MtQDkAcBqWd
 zMjwnuw5ziress87revQOFIR3v2oaev4F2g/oCjoLAtKm1sp7amLNdLKh1w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumgq1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:18:26 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bc54005a7so5248598a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384706; x=1780989506;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxSW8cHQ3wFLpjGnuSGsblT6eUW8Bj573RsJWQBn06Q=;
 b=R1bY4GDHIpl0kw7TfDTDrajjKGqsxETESsbeXlH73fZqrbPXjyKHp3uDxaEuB5+j9Z
 JFmIyOC/tCcZUSjyZWX3yKyke70ae54S78u8bbqj8O8qoqA+pCAv9zKkToyqNw18pDZb
 o0rASx0CWHvtsmGFHjx1kaVlNcHcLqpzE/8wvjjGmEDMAXi+3vbfVn5v608lUdzft/Z7
 hKK7Ec89nO5aymmuiErTV4T10GWLfantHFdxzHnq09z5syd3v8aHCx4DtiYQartsIeiS
 aqjtaRhHmj1+pPJoG2Koxr2Qz5Lb0XLXrI6K6+CBvAQx7J0WT9AArcbSEGdhQkhOHRGy
 6IjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384706; x=1780989506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XxSW8cHQ3wFLpjGnuSGsblT6eUW8Bj573RsJWQBn06Q=;
 b=hMZrEwVtN2WUjjxj/XqXj6+rAkxvrMpIba6382aytam8wl89s4E8wjpXPnnxn5Y2pv
 pKn/B/GeCisW3ogiJIezv2jA8DQ4FKNdJ7YkRUthCse1mMQRNRjG185QimxKr4LHNvl/
 TAhqZZRFtcgquzeArRPU0jTxTfyg+p+1PHkTNcgPYkhQKL+daWvc41ek94pWaXnJBz3K
 /Ml2WHraQEJa2b235TWl2yBNb1calV65gh3LD3adqwnfHI+bt0zD77LSnp88RXuUXmsK
 3GiqGbUP87dgYdHQSqtZhe3B+g9UwV3fC5T/SsR1ahMXd9mczcDn5RU8yiGV4PLIumXf
 YuEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+Oeq2RT+vXQ2COp8MrIME8kHaapz8TQ/mgmJwT+2vWHSCuevwtQdo+4R/uFWlA9ZPAJfslUsWeYE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbUlSJ6tMPgVUy31Mbf+mUWXTh4Ejg9ku4sNHt6qXE0TzddmWR
 hMkdv2E7qKmys0EXItGiRUFnCFVDYyW6MExaKLblkZFRXYsCMow/kwC8mUFuvH41gYArKhU1FW0
 n2XV+2SEkYoyUMXTfIg4VcFIyFgFEVfCqrfZTEHkX1wsV8qKDLvoh9sxFRQNtFQs6jqJ+TnA=
X-Gm-Gg: Acq92OE1DAa09xqZK1+ofblLJ1DwsXcBVTiVNEunJQar8ZcomUECw2hYiG5WVTUhb5E
 fV8ev+MCbtscBimAyTv00U+SdqHWUHZbbSwuGfKbAjWwfAXORc9juTKkUnfgL/lC/42LOZ83otj
 /y9hD8nonIR/WkbqUtxHKh0MlfLnC+VgZtbLdWjMcc61+pDv4rdoNBoBjQf4qBsBnPa8+/WEvVQ
 AILdQ7ZtS3OLI58LTkv36DysogCeZZHs4hglppzwD64AZ5nUpMP0HlleAiIP89OGVUCoyv0jfHU
 cEDaOCT9YhFuY+/KrV5w3wDWdXwk2bKXaITuNkYo7l23JC5vQ4Whmio2jPzOaMF+dGoM0R5YOb8
 yItLv/c0seJ0DOLqPNflWBAo5zDNL9PmJ/VZgQza6q37NP5PL5dL67JlWJiasqByefeFvjyKeFh
 0Hspl7YmOSofNNO3PPGbyTNWvbNfR6zg==
X-Received: by 2002:a17:90a:fc4c:b0:36b:7f69:c152 with SMTP id
 98e67ed59e1d1-36c501b813cmr15173003a91.18.1780384705758; 
 Tue, 02 Jun 2026 00:18:25 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4c:b0:36b:7f69:c152 with SMTP id
 98e67ed59e1d1-36c501b813cmr15172978a91.18.1780384705241; 
 Tue, 02 Jun 2026 00:18:25 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:18:24 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v7 5/5] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
Date: Tue,  2 Jun 2026 15:17:50 +0800
Message-Id: <20260602071750.526-6-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX7w05R5oWZ98n
 S2gn/SF4ODGWioE/6JoizhzL6FuqCRb2Esg+O+nIM06tcjv0nyBY0yKXrTlUpaUb8UaSuSvRTJq
 Xx1VglubLuAUw/gQ2aGV+jG3IARfpD3D7puKHP7wgxTkNWqhm2vmywpfpbj/Ir2SnwuA9ouWcL1
 3i9hT+351NDoNIjXuFFrroy9JQcda9uhHnvvi26SFQcHxvMeRd0P1LCsU2EcG4AlQwrJ8fuqbXv
 SaP7cKKcFtzeXiRA56V4JTJSgj9iD0YNYRbRftTOn7NOoAnrMM7khCyee9QC7wyNhX7nQXVvuGJ
 9ORKiWO5XB5AHnzptdPWLTcPOimYM4cqw1FSjCnvhJBxkdzsgl8kAyXclI9Mhdqr6hJ9V8Pf5os
 z2NNzfphGTJTK74xhS434mXQYulUgnps8i3dNLTOrV2uU74XBLcueKXLlsF8p2wgNcGt1H2Ec11
 p17dN1h1X+FcM18+Iiw==
X-Proofpoint-ORIG-GUID: GQNlQEVAu8WRYbKy9ua3KXwL503b-Qun
X-Proofpoint-GUID: GQNlQEVAu8WRYbKy9ua3KXwL503b-Qun
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1e83c2 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=XYmfcRj0Jzm9BuThv0sA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020066
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 33be8bed6a0b..370b4f9ca135 100644
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

