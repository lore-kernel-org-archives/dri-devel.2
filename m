Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12FECD6E6E
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:48:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F350611A1E1;
	Thu,  4 Jun 2026 19:48:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FI7YkdtT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="acLqsbvU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 791DC11A1E1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:48:37 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654IQBk91813872
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 19:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=sRxjmDJb+ltIpXrcELq5y5l3qHN5CLUNKQ4
 NUVtbFo0=; b=FI7YkdtTWDJGlNmsgtR3JBqCnhDM90lpW6W8L4u2TOY7kQay677
 BnyLwGqmANG2lvioFQYgmSWnuUjGXjH6qEWG7PKUDDbioq3x3Iad0qbHRzPopE5B
 ZHVwpwcXyoY4hT0orlvBXMmVKRre4hVmQULGigX/Lzlsk1/xkL8ob4xZIo+omeqA
 7NqeviynjcJzCrCfjUcQ70QVDOXYvU1UsM6CO4MAHuaw1PgU67A/P6yDCf8oTStO
 0H4YSBxn674U6eyvSzeWT5M2PTUUo8O+/hJWq3rIPfn1Dj0r+rRAwpWDYB7XZEC/
 doTNh29th0q5vOiIMInkUB33Wcymx9Bju+w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eken00akw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 19:48:36 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36d979441eeso1082288a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780602515; x=1781207315;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sRxjmDJb+ltIpXrcELq5y5l3qHN5CLUNKQ4NUVtbFo0=;
 b=acLqsbvUo8CJFk9HWEw1BXwTdQ58TWTOlCT2/t1wBzs2xcHeyEfoqfBtZJHtByViHe
 +Irwdpy77EPuTXpgUdlRzhgOB48QVhBAq1zJL4WugYPAjn6SsO3ztO9pruFBOaJF3uqq
 Y+qIVdBII2iYE3T73C+/ZwTUVgPNvqcbsB0pgfI5trZTw9NUkhGYkBV/uimFZLwAkdY0
 gsSMXN2FcRERA1KT1t7/ivtpHCl5HAA0ft87RdIstEluOofHd6+352UGT0ScpQrz2pY6
 Fbm6qiV4WBpOgkbO1xwGDVx8ctOULvX/T38oPAnmroHads4vu++cXvmzH7LN/zYHHvy3
 ZduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780602515; x=1781207315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRxjmDJb+ltIpXrcELq5y5l3qHN5CLUNKQ4NUVtbFo0=;
 b=mHEM7tizAbJRkZoCGcQUNZWkElOQXETbiihKvNd3XyBVq/R5jpUTJoMycLNaVKRGst
 dusHHt8t6+BGFDfDCIPOmo1yHh2wHJfCJElswxA0LtmXn29iyhvHAVsX7qJNINIvaCVs
 9XTMWFsUXYNp5we3i1DyCzGc6bULBvkFzdfY33IP3WiP6EoTaoUhXzGDjDv++UrWRuSa
 ZEgSIX8i1o2jpFx1STBvuKvkTdnLSalZioga4hCOqKIvPHo9vAwt8nYkcfGelOoh+MBQ
 eAwhezGcRDF9LGTApORSRwiRWA2ftKkINifNaLSFP+90ZTdlaet95ATZN6ykYmPCTf55
 4Ntg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o8RtEt7/eld6WjvWXMJPPfNdBGNCLT5GnCuUkl4/40VjSvzUCiBceWc1XD/sR8FZokM9QK951UM0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzABdGGPofBGdq2wMIu1pNNp/0QQX9p7yHjfWEiNraATiLFumj7
 W0gvUHgtDdHgQeZ8aqaMtulaGn3FPbyOvdKXbi26+wFosHPQ/wJtjfnCVE7bnyH/mBWXDiTRO8U
 OVkdtykajIoC9/h5IcafxyLk5ApnIa8HMrvYb2yVPD4GIzzMeO7WcwvnqIKi0R/5Zjouy9bU=
X-Gm-Gg: Acq92OElUA5yq91zwThFGZiKpybn0/iD/fhgl29ceAFiaj/FySjjiITyMMeGFfKCRfF
 sQpJSjRDDhizIH95L/hhR9b7uv/Qq6mg1Rg5LXnAgfgfatXH3YBVpMQOzX6jGCg9ztXQTfUBNya
 aglT4pH1re/nX6AyjHCNRmIpTMPazNJKDIfz1cdqdoDRcgZRxPdF0530Wm3iD0d04WbypKCppxH
 OAHrVEp0D5AYcMbUiv1sZ1G+jx20qWDtWWWjI1GmEjBqx9XV569iY4mKwuWqkwn4vmm2WBLFXqs
 SZ2nIE8Dmw+lwj3H47hMLB3qQGZIWR71Akq+AI6cSmFgZU1TmNsjnXW7Ua6d1t6bcDGYGpqKmpP
 3uAH9vS8UjZgYl14ze/lh3vc30qAmPLof81oIzEk7yuzdjipOia9PrkxNHoMhR/QewaI=
X-Received: by 2002:a17:90b:4a46:b0:36d:bbe0:de7c with SMTP id
 98e67ed59e1d1-370eeff19bamr421829a91.12.1780602515325; 
 Thu, 04 Jun 2026 12:48:35 -0700 (PDT)
X-Received: by 2002:a17:90b:4a46:b0:36d:bbe0:de7c with SMTP id
 98e67ed59e1d1-370eeff19bamr421807a91.12.1780602514837; 
 Thu, 04 Jun 2026 12:48:34 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-370f913bb37sm108567a91.2.2026.06.04.12.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 12:48:34 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: [PATCH v1] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
Date: Fri,  5 Jun 2026 01:18:11 +0530
Message-Id: <20260604194811.2437567-1-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NCBTYWx0ZWRfX/ujfy7kgndj8
 PVaupiaTHWEzJdm7U7Hu5AmJm2CGEgiq4qZ05ac7QF/LMkGfeF+3DaFPANY/Lhn4ZM0lyNVGuvt
 bzdQ6ANtqWhjhvWIiBxWcFjf5xFJthsP6akDW0NYQ0T7RMLlAKFqYycYT7Z13S9J/oKa6m/MWts
 UOcGUdA8GuMAWdqiXKxr2ZDd0B9nRoFbhDI/RhtXxCXb/O/krg0JD4copiwgcZXzQzmt5oW5LgI
 p6AzdwQVccJsa67vtYOibZrQLBXXYg3jc1kexNl+/Ra/7lv5I7YvisL7mfO1rBMdC7+fbZMavcO
 u8KLuDRunySDDHfqb2+1qUH7de8MjIJy4tqLtR51B2rPyso+AGXI5FAbPNu13zHe8mcs/UZy0WG
 RbJfqHCCH4t68tJNuICxgmzCqgXrzg/XCxa0qvkFKp68PHeTBfnIxjRqZ+T3JpxSapz6/ZwnQwI
 goCjBlBsh5r2uTuSOfw==
X-Proofpoint-ORIG-GUID: GwqNzmkNT1qa8sojUsjxQF_5AbjMUc0d
X-Proofpoint-GUID: GwqNzmkNT1qa8sojUsjxQF_5AbjMUc0d
X-Authority-Analysis: v=2.4 cv=B96JFutM c=1 sm=1 tr=0 ts=6a21d694 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=4mxDCDZnYOL6Ru_i_akA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606040194
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

Some platforms using fastrpc do not support DMA coherency on
HLOS. On such systems, explicit cache maintenance is
required to ensure data consistency for RPC argument buffers.

Add cache maintenance for argument buffers when operating on
non-coherent platforms:
- Flush input buffers before invoking RPC to ensure CPU writes are
  visible to the DSP
- Invalidate output buffers after RPC completion to ensure DSP
  writes are visible to the CPU

Introduce helper functions fastrpc_flush_args() and
fastrpc_inv_args() to perform the required dma-buf cache
operations. These are invoked only when the device is not marked
as DMA coherent.

The coherency capability is determined using the "dma-coherent"
device tree property and stored per session context.

This ensures correct data synchronization on platforms lacking
DMA coherency, while avoiding unnecessary overhead on coherent
systems.

Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..043b6a5548fb 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -255,6 +255,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool coherent;
 };
 
 struct fastrpc_soc_data {
@@ -973,6 +974,64 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	return 0;
 }
 
+static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
+
+	for (i = 0; i < inbufs + outbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+		struct fastrpc_map *map = ctx->maps[raix];
+
+		if (raix + 1 > inbufs)
+			continue;
+		if (!map || !map->buf)
+			continue;
+
+		if (rpra[raix].buf.len && ctx->olaps[i].mstart) {
+			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
+		}
+	}
+}
+
+static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs, outbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
+
+	for (i = 0; i < inbufs + outbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+		struct fastrpc_map *map = ctx->maps[raix];
+
+		if (raix + 1 <= inbufs)
+			continue;
+		if (!rpra[raix].buf.len)
+			continue;
+		if (!map || !map->buf)
+			continue;
+
+		/*
+		 * Skip invalidation if the argument overlaps with the
+		 * RPC control header page.
+		 */
+		if (((uintptr_t)rpra & PAGE_MASK) ==
+			((uintptr_t)rpra[raix].buf.pv & PAGE_MASK))
+			continue;
+
+		if (ctx->olaps[i].mstart) {
+			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
+		}
+	}
+}
+
 static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
 {
 	return (struct fastrpc_invoke_buf *)(&pra[len]);
@@ -1093,6 +1152,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 	}
 
+	if (!ctx->fl->sctx->coherent)
+		fastrpc_flush_args(ctx);
+
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
@@ -1239,6 +1301,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
+	if (!fl->sctx->coherent)
+		fastrpc_inv_args(ctx);
+
 	/* populate all the output buffers with results */
 	err = fastrpc_put_args(ctx, kernel);
 	if (err)
@@ -2217,6 +2282,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	sess->coherent = of_property_read_bool(dev->of_node, "dma-coherent");
 	dev_set_drvdata(dev, sess);
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
-- 
2.34.1

