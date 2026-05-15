Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58327CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66DB10F51C;
	Fri, 15 May 2026 12:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfonqrYN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JJV4bxgv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B84810F51C
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:43:00 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBl7R53512945
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F4ku8bhGpeG
 5gSXCtpcrJJX6a8V20679dhsPTygcnWI=; b=MfonqrYNZml3WtDu0pRbeI4aKMN
 /s9FNCElzmNU+sXhxiBVl0tFO2V5RTtin6OJE34zqUgEjwDSnLYx2Ry0i1v4jlW0
 9GfEL4uVBUHqu/hc6j2VDD8FKqM766YSNz/SdXBfX0vvp+2gcp9I57IUcv3ecY+c
 AzMOuQ35TboxQFdctWmU4u2GvLKW9FlVL3J1yW3H9ep3J4/eJuuNzgQQsyJ1lKNS
 Uw4yjzLz4R4Qkwt5djpOKR998rIw1yviU4pQXbJGLAvIyGgj4AZe5jVshLv3ug1x
 vZXn/OGqsHQ8OoF+3KO46YgeZ0Fk0v67YxshjkHp77BAGjK+FpMyfZqKt/A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vb8wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso85388975ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848979; x=1779453779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4ku8bhGpeG5gSXCtpcrJJX6a8V20679dhsPTygcnWI=;
 b=JJV4bxgvItTtAKyM0aQzizP3lqkxUgoGEv9KZic3NDsCa2uxh63oFa+Wmqqcj6uNV5
 hcpzfXIxK/VfI4qadiysZgF4+aqjjOoJU3FwgCYu+aR19ON8VSTBvV+ltiFldL/WEex0
 N8RFtZSOji8nnrlyrOUE98L0Il403Vavw5tDD+pBEpTt5Zh2Hwl3hJ7IU1dZzHYphU58
 1LrETH4a5bqru+eJEV8l2/UitVZj5hCvOcWtRIs3bnAnJLSQtjy573i+whe9sJ8iGe+h
 sDl9mWhS2Kh+e0Y/nvThQasc5kTexcjspngyV/lOPnuN+jBuX+qQf5P1qJivkLIsKHvj
 Nrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848979; x=1779453779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F4ku8bhGpeG5gSXCtpcrJJX6a8V20679dhsPTygcnWI=;
 b=izKO7SL5Q1BfpnMf3suuSTeNelpg4GZdMUp7vdjefR4QXxdLSLIG2ajYKxkx2mxScw
 YntBWh/D6VIH6cevFYXAw5yh8bLXFxB7oupjII16mIFejZWDRRUrV/v81gdmHEoOeiAI
 YIMmOZWYBZYfIvu1SNSTgSsZJ1OcfCRN/UQ2VF5HGQRnD3Fb0eF3sFyfsLsF/6uhvmx0
 b55jcBol/F242nDwaBg/G+wpf+XbBg5pWWDfdZlpqLG1Jj+UfmALkcS2xx4koWGzfi0N
 5VYd8jXaddwnPAc5uKput8muoPIeeSL2BVJUCICiqx76HnkW9CzXBf/3oHGz+YLO3sXU
 oDDQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qSZoogTepgId0jcPkJdutTQlzasW7cRJqGPenMjlykUG9JQDLGVKrClAc0xGfxuyqlLjhZ8eeJ/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2RhYpxcagMdglF9UHt9e9qVP9ovy7YpvqL4hVmZUSVrmjfP/y
 03u2o+i+r6JW4BTcpsH41DPcathAu1W19jVMgzOViJMNc6BqOGKOkyYAqxamUJUNQJ1QbMz/8n5
 BGmhyq6muV/Fyz10pPGT/GyVQaZNEnXKqfx5qcbrpVFqc7oye5XzC9rqw7q1oHfJcf554X6U=
X-Gm-Gg: Acq92OEgzqbOFJ1RHR2pE6kuUDn/2JXRGRJ8qrNFhJ21yb4a33/OQrBB3YgVHEupin1
 Fz99OXEZLCqH+wcs5TP2RFMA0KjXszVgFSBg5ya+fy4m1SKuMVgOTJuYHhsLugNhR4w4vQ5UBZI
 MtEB4xoXZAYrGBKKT1x9fhobK7KD4ECfQzC2EhX7STJ3hTmKs0d0CY6aDajYLXpG7+ryTEqbwt8
 DdnzCpiw6eC/bycO3hIP8llWgglPnm7ys8F+/7rTPxalfri9Pm4VNvAw/xPIIfrcyiKbLa6CQIW
 ppQAKdPUwPd3uJF+p5jSO714l6q7dJ/1S2ecadbcKsWFVTW3iR/ExNii0T0XLH0de+0R+d5tqP/
 HsAstJOCxYwTl1U3oWMyiv6lUsNsUJYWCbygydPCRyTeVH2xEjaGlvgegWUpU7Bqk9Pcii51igO
 hzfTrK4zwF+wRxa/cVmEU=
X-Received: by 2002:a17:903:990:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2bd7e784bd9mr44811555ad.6.1778848978189; 
 Fri, 15 May 2026 05:42:58 -0700 (PDT)
X-Received: by 2002:a17:903:990:b0:2ae:6259:5aff with SMTP id
 d9443c01a7336-2bd7e784bd9mr44811275ad.6.1778848977719; 
 Fri, 15 May 2026 05:42:57 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:57 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v5 5/5] misc: fastrpc: Allow fastrpc_buf_free() to accept NULL
Date: Fri, 15 May 2026 20:42:17 +0800
Message-Id: <20260515124217.20723-6-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX+QqXp9Auo51b
 41f5wM9F0tp6mBsPduTqMkeFByyJqu53ztiZHFYgbY2kdoEam/Sc2aJHI+PhbvU0awneObMXOwr
 X8apFkfi07nqQv6T1Av43GM0mQPI4b8LNZthfgwkbKnV/storkXn3lJ6nW/BjwPT1bSHxvx8NBq
 4wi3paSXGo1gl4LX/MWw85iJ/Q+n2+gqzbLeUYaNshWlpUQQVHH90VhK2hmPfTvQtL/Lq/DtPOO
 HEVpHsXwzKXwsLsSoKobrnKtGUio8vjzRHOligAkVWJJKW491zpDDCEwAV9g3xMVuqpVxPvn3yl
 xUqvKAOnMaH4+wDkERbgg85w3mpy2fXgzKLrxbQDCiE7irp6asb5pA4h5/0xLkX5F6XVan5gupY
 2M5qYi2N2t+6dWv5yF2+tlBnJkqdCWxuzB4/Vsgksr+WwpnwbHWsjwa8LMPfBvyWzKr8EUVEQNp
 +T3Rm6SkX49d6xhyB2Q==
X-Proofpoint-GUID: l5NBqI8xCwzMKQNMMfYGbQ0fhkAP2kIV
X-Proofpoint-ORIG-GUID: l5NBqI8xCwzMKQNMMfYGbQ0fhkAP2kIV
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a0714d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=GmafkBk8WXepDEkBruoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150129
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

Co-developed-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9c70788afa0f..82bfbf342725 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -416,6 +416,9 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
 
 static void fastrpc_buf_free(struct fastrpc_buf *buf)
 {
+	if (!buf)
+		return;
+
 	dma_free_coherent(buf->dev, buf->size, buf->virt,
 			  fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr));
 	kfree(buf);
@@ -512,8 +515,7 @@ static void fastrpc_context_free(struct kref *ref)
 	for (i = 0; i < ctx->nbufs; i++)
 		fastrpc_map_put(ctx->maps[i]);
 
-	if (ctx->buf)
-		fastrpc_buf_free(ctx->buf);
+	fastrpc_buf_free(ctx->buf);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
@@ -1564,8 +1566,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	list_del(&fl->user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	if (fl->init_mem)
-		fastrpc_buf_free(fl->init_mem);
+	fastrpc_buf_free(fl->init_mem);
 
 	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
 		list_del(&ctx->node);
-- 
2.43.0

