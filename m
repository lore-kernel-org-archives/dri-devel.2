Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69E2CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274D810E05A;
	Tue,  9 Jun 2026 03:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jb2u3vtw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F7IlxHDl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3C710E05A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:00:09 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590s1jP659723
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 03:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cisBsGwi1YI
 qjwGwTWwgeZV3iNbu+JN7OENdgw6CMME=; b=jb2u3vtwrbQWTMWOcQwac7zgp+G
 sBqfS0J4rid2VVUfbvrJx6v08YnQnMUaIkYdByNR8UtHlLsYbTehF7e6QdYb3jvO
 dQgOFRZSKgl4JhRGizhXY0GLXM9u0nMiBVyIAzRvx4rVZ+w0uUlb635rePAGCeqJ
 52MqCQimWDY4CuyaeqFzMAHrfnfJ3ilIcIvjjuzJQVgoSv+Oznp4aSOP4BFnD+8Q
 NRtPugewMW4SM3rCgetyw0AmE+Yu3MDh0mO1OMCzHIODhPRDl6jmUb37dLO2utld
 t9sHcJjFH2Okqu9HYTiuR90bxa0mkywLekebN95GC9pW8Z2h0zeog1SOMyA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m3nfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 03:00:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so3756137a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 20:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780974008; x=1781578808;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cisBsGwi1YIqjwGwTWwgeZV3iNbu+JN7OENdgw6CMME=;
 b=F7IlxHDlqTkKqBtXjkUkbBMwFnDglWKzT3M+ifczpOSSlV99Y0PZiBsu/Dlnv8BvCO
 iSPy4k9s3RbT3rNunN6ea9ZyVrzraO0tRubHQpXyah7IMEgGM6UlZWnVJwHn1OfHIyvg
 Vxzuk1klX41pvCmwJxVbUoOXHan4te+NbeNIsSqitceq4lCdpFByvUIMU9tkM8E6lBNy
 P9yLxK6onLkzZtkpbB4l3HrJ53N1LYcsMUDPJXsE9UuJBoK7ktZVQjxrI7eAiMF+AHHv
 bZv2tfbQ70Ag0IT2w/vFNp66t8R7tE1xAVrcBaLltWrUDsDosARZeSFpRxUVn7LfqBDZ
 fAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780974008; x=1781578808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cisBsGwi1YIqjwGwTWwgeZV3iNbu+JN7OENdgw6CMME=;
 b=HU7O4ZffOsU2U3iNB4o6p9w55gNUW0YHG3te26OOjXP/dAlaQQgc1BMYV2mrxm3LDm
 pxpb8xwV/Kj13zyc6gPBCdiPCxwYI5ZwSKqH3yzR/PxEAlpoyXJ+7IAw9XacQiAqLE/M
 4Y8ribr3oIszm8RhUpbsb9nK6Y8Mmpbc22igytcpkM52Gpk46IF8AMEsf4asqI5TDImN
 7CGiyT85DNnIkXUXH02LL3Ex3SizPCUITrbGSJYR2NiCEj/tlB6ikptXHUqcAGzOz9Cb
 +46RZdx7gTBWkxqZI1i7xdtC3Oi1qPbui8pknKlh5s8imDvZbF0GhJ8ypML6/TwXwurg
 Nngg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/imRQS1GWhKyNaEBgWkVXm16q494YCgBmOSeqi0JIcg8p7XXFNZNfT/ihxnGUagIUUppCSM8/jW+s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwpTtYfMr2CBHNr5SwzqKtpcpnX3JyKEBM5a7FVNJ7HE1zQYDu
 0aggIt9G+42BKxprbfSdWqtLr/esJm5VX2nQiuQVBEgPl0NOuBk1f5r2AyFzjb5oF45AR+Q1Hrw
 4nYu0wRNt1oIysFnM8EF7HSVR8iLV+GRiLRCx+A02M757WgJG0wIAvGp6tTbihRdSF8t32Mo=
X-Gm-Gg: Acq92OHwgCVbSbH94N38P5/iBrIdQlaufnw0UqP9t3k4mqCLqBgDlNCiZeQSMuZd2UV
 7dh37oFDhJSrPSjK1a/7/pWBnhaqF5YW/OnpBW81BtvWHx/uSTaLxq83JBUGvI69GuZnm+K8sdS
 pyaf+uwsKqc+jwqs60PrilHiNSFNIbI+pE0ss6Ay9ebxCoxZoHiGGO5GKVzw350yS4vpTyiIMhR
 lOaDe8IFA/wgqr72hOlmzo6hTD9JAitD/QV3ulFhtlx8bqjiPn+VAoANzbnDuynTFwXclzsCq1A
 jivZ8QRi7pgz6Xqyefja/rpuHzXdZwODFvprEa72Aen82y3AuHUMXjxodXPhDBOkipIn/5umNC5
 ILEUMgnUfkgWppEmDc59P44H48X7e6AD/sGCPji5Wou3l1I0ZI+Q5hpHV+6ERx+Bg0KOh1qTUCo
 q+i1FC4V/OIXP9lonrXhMAt3cYZDq+
X-Received: by 2002:a17:90b:4990:b0:36b:b9c7:35fb with SMTP id
 98e67ed59e1d1-370f0579a1bmr17907740a91.14.1780974008366; 
 Mon, 08 Jun 2026 20:00:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4990:b0:36b:b9c7:35fb with SMTP id
 98e67ed59e1d1-370f0579a1bmr17907685a91.14.1780974007681; 
 Mon, 08 Jun 2026 20:00:07 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712fcb2607sm8713835a91.0.2026.06.08.20.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 20:00:07 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v8 4/4] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
Date: Tue,  9 Jun 2026 10:59:38 +0800
Message-Id: <20260609025938.457-5-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyNSBTYWx0ZWRfX9gVT0RQwQBUa
 MSIUc0QCzlM/2MAA9SQJgEl+NQZLSasIPvswtJzLkYbp4rHN9P58z5WHr+eZuQrzw9gtXpcLN2O
 vBePK81n68mbty0p4CkqDiiq2A+s0e6HVVsOereiY1T7K41dGTGZZ3WdHH97lrnHVOp8JUckZRN
 DAuBIy2c9/J89j1g4XpQRql9rf/hM8WJ4vusdgxw6VA/fvLVQReWg0gyDyRm6jb/XJQpdqkBBAb
 HCa4ZfGppZwkpuPx2qEX6j1YKDF/h6fKOTjQhH9rBxEax48fwm7/zh5aKlkJMZD06dx0IQIUMtt
 HhntCPdXfj+ag1xkNeMTV1Kt5LnSX5E6EG96LpWJVHMfZ9qUKq0hX1/qBUxHUjuMWIpg11blUH2
 /gBm1qWUQV8w8RaakeL0DGRHYKI4agUuoW91VDjSWDKlkr77odTxpeAfj8jq3KMYioXe4l1eJ9X
 APNvHwrZjHmh+akWtxw==
X-Proofpoint-ORIG-GUID: iJ4wCMwNGBWLANQIzthY1w2IrbS-cAqG
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a2781b9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=XYmfcRj0Jzm9BuThv0sA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: iJ4wCMwNGBWLANQIzthY1w2IrbS-cAqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090025
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
index 1942e74535e5..b4912b443b98 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -424,6 +424,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
+	if (!buf)
+		return;
+
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
 			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
 	kfree(buf);
@@ -516,8 +519,7 @@ static void fastrpc_user_free(struct kref *ref)
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
+	fastrpc_buf_free(fl->init_mem);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
 		list_del(&ctx->node);
@@ -562,8 +564,7 @@ static void fastrpc_context_free(struct kref *ref)
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
-	if (ctx->buf)
-		fastrpc_buf_free(ctx->buf);
+	fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
-- 
2.43.0

