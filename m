Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA3606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XNMNiiHl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gVhbmHYn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A00410F53B;
	Tue, 24 Nov 2026 12:06:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E36510F53B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:06:15 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOAuMqH3541837
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=56h/egVfcl+cbXmvG3NjDJ9z3RzJgimP+yt
 jMSOP2PM=; b=XNMNiiHlMTXeslx/kRuMtNkrIHTgCc03XcAwd2MSCOmybDiKhXs
 piLIJJdjfbuq0klZr/VXs7N8BIfRXGhkryz4iUHAX1izE4Fu76G/9FK1ErN524Tj
 aSGeSSLHlm2Nd1Q7Wl9upyp0JMo1rtbHewE0C2bjyaBQX2ldVWu4ro1mNlIR47Ma
 1OfRtHLF1uN138yCDxvIOFcJpMTUCpY9hjxzpQelVwx1qg/tzIDBjpz3GuXLm/A+
 UKCSlRLCDuIs9U59Lby2JN1pCW8ekvIwJAlOFgviDTQi/ikTRDp0Nh/8/6XgPwrh
 a6CIKtUBnBNpeVSZkOy3GdiilMEQtDYFj0g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh9gyd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:06:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1cdfb337eso2715397a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 04:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795521974; x=1796126774;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=56h/egVfcl+cbXmvG3NjDJ9z3RzJgimP+ytjMSOP2PM=;
 b=gVhbmHYntKkKLhxpoyuGmkaUXCSPcVzApDi1yoX48HD7x5oKOacjgHJmn7Upu3ej9X
 xBrwAuQ7GSpZrFx6Jj6jzZL2kRVdyU0WEqoXg2ich7nCj5/5vOHptzpTCbiwArnhYVJb
 APpX5MFGhAB7zudj160OjAewOagmFRPGibfylnCWzQg0oB0zucismGANQoJbE2mgYRD+
 eNguC95T9B0c44hsRTkMqacrQqDg3OXIILakE6GJTgGREaUJ6p3ivMv2FIs9iqIX1rlN
 DsB8SeP3k6xKPpy8fBup9Ci9eKsX4CK7riqYpstD3kaz1iTvoKGghuDaza93eq1tV5iy
 rfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521974; x=1796126774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=56h/egVfcl+cbXmvG3NjDJ9z3RzJgimP+ytjMSOP2PM=;
 b=Kqq7mdUZ5qy7c1aGYv+bC/tOhccRMRLvXRhrlA6632uQRG4IT1L2KMG2CChts2wRY5
 iLIr07Lr+hQit8hZZmKw0Eh8Q6r9KP07JtvqMHiIMS58iMK8cxbIL/Y4oWXcILoqng/I
 9y0icBkfcdmczQojRW1K87948LhueAM1PFvrGEmpSlQe8AylSwnF3bWL4E80GEbxvg7F
 oSK+zwVMABzif+Mms9OVtejcvVtfTweabmfb06u0zZYaQmrOjH14e+qdiTcR7zy1WZOZ
 4vsW+aHM/o9pZwHZF1uTBYp4sFR7800k32brs6JUzUmOHEcs8HCiGEq/+cfOAp9rKlB4
 Mwpg==
X-Forwarded-Encrypted: i=1;
 AL+hErGxzrDDEV1Si18wZg4grnm1u5VZ48zF2LDIOJDtaA948539h1P91UFA4KZ081sEkOPMuTaOjbzbDQ8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+kJ92T97dDIzGdjcp2lYHcN3hALCRuW2mwtRytECsTjVPjLRLL
 dokCWt/6mXlHG8NvcP+BlheakPg7UPSa92UvRVGoxreL9gjSh8/9cbN8PCgKRl9yQ96fDexfRr4
 zspJ1WcBMjPFD8GXAfJdFp3vtMzojTaZRLR8HpFjsOUi+6BW7Gpxb0txluKmYRtcfSwqtwVw=
X-Gm-Gg: AZFdTZcuYiB8JiQq7jfA6mQj28YdWsrsokuZE0J1hIg1MIoo0x8ujQJNy3ZCBJCI2oC
 tHEjOxyNxEvcTWdkyLP2tKq3lD8UIP0obQhrj8HTT6lBlQjGbzniRovYOm2c4jrSlK50zOJBC7g
 QjnVHXQ5SNDbNaD8+zOC2E4pfqSeisix0Nw/CtLjqVkOWCjBnZF7TMEkJtqdLycSeXn0k37ubkz
 AQ9ALMDiX9Xx4fFq9TlHKBTdi8mBRwRS6/Bl7MyMxkuqNcGWcPd8bknMml0T6we2nN9w7RLJMoL
 TuNQzQwdj4bqJXB/JA2/aGKmHxuVnr49PCvJNwZ9Pi+EyNQYKqBFSZcizRYiWvL7EGwnnYggj50
 nNzAfIAIm+AvP6Vu7gt2xaVgtYUSYvlGFFRHMW1wCkaYvYTR5b1BYAbmdW+kN2E3J2hQgOpTZYq
 YHiWzlLKbW
X-Received: by 2002:a17:90b:39a7:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3b41c9638b9mr12375870a91.40.1795521973791; 
 Tue, 24 Nov 2026 04:06:13 -0800 (PST)
X-Received: by 2002:a17:90b:39a7:b0:3ac:8897:7baa with SMTP id
 98e67ed59e1d1-3b41c9638b9mr12375844a91.40.1795521973248; 
 Tue, 24 Nov 2026 04:06:13 -0800 (PST)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b41ad0a34asm22324533a91.3.2026.11.24.04.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:06:12 -0800 (PST)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
 gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 ekansh.gupta@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: [PATCH v3] misc: fastrpc: Add cache maintenance for non-coherent
 platforms
Date: Tue, 24 Nov 2026 17:36:04 +0530
Message-Id: <20261124120604.2640046-1-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b057db6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3CrWDfm47Yt55cqVd9cA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX+H/nCn3TPf0v
 NUADjaZ3xRYCMc3pDn5D4fVNrKJEI2PcUeLCsbe5glqJ9jB8ZsYKsksWs6Y9YBsZ1HslLc8UDl7
 d0zywdhyVfWWCvPgzOYUcpCmErDXFSA=
X-Proofpoint-GUID: rGzqveWoMEwagueKy1bl87M_qmEOdqaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXxGNchL4wnzBP
 ZVBzeFdyolHY8cTIcCu+e0tybAs1WG+0tvpQBAbel8GADM1hsqHNlv1vLBKI/KL2TZ1yWX79b7I
 VKYeJRs1HV51wphOMGWR2DxG2DDKJRck/ktjYO4UmFKsnYJPf7C7epIbAdiU/XLyPgwwwJ0X9bu
 20MsUWptoY0q2Sx/+H0HdqcVXYul5Yz18UJHDe+XiRQH9CtisGjKTfA2zsxpviyOf/IyZE89H2X
 xGbdaTRyVuUH6QpTlEQFihBshQnWJDI3/YUvYUP+1OvnBVuePHusK0+mFBrZZvy5+7RQniVaF+B
 yrofxIN5z+0RGKd5sbwYbBdoI2r0D8glRd4ymWBLCL0mUb0PtFaRJHX9r+/1FcW69WEgXamoAIo
 G2i6shTLZVzxQDDcmi/VhaY7td/79iJiz+ZxNkM3c+gphiAhFYz2I6KlgJSrM/ziARQiNXHBmnF
 3MJmjDS5NR5zk8XxPBw==
X-Proofpoint-ORIG-GUID: rGzqveWoMEwagueKy1bl87M_qmEOdqaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

 Patch [v2]: https://lore.kernel.org/all/20260916185850.3686010-1-abhinav.parihar@oss.qualcomm.com/

  Changes in v3:
  - Fix missing max_raix update causes incorrect do_cmo evaluation.
  - Use of_dma_is_coherent() to determine device coherency.
  - Simplify input/output buffer classification and overlap checks for cache maintenance.

  Changes in v2:
  - Fix buffer overlap handling to ensure cache maintenance is performed
    when input and output buffers overlap and the overlap calculation
    suppresses the buffer's mstart/mend range.
  - Add a do_cmo flag to track buffers that require cache maintenance
    even when their overlap range is clipped.
  - Invalidate output buffers before sending the RPC request, preventing
    stale CPU cache lines from being written back while the DSP updates
    the buffers.
  - Use DMA_FROM_DEVICE consistently for both begin_cpu_access() and
    end_cpu_access() when invalidating output buffers.

 drivers/misc/fastrpc.c | 67 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9e760f68bcaf..39ad0ab88aec 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -222,6 +222,7 @@ struct fastrpc_buf_overlap {
 	u64 mstart;
 	u64 mend;
 	u64 offset;
+	bool do_cmo;
 };
 
 struct fastrpc_buf {
@@ -297,6 +298,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool coherent;
 };
 
 struct fastrpc_soc_data {
@@ -666,7 +668,9 @@ static int olaps_cmp(const void *a, const void *b)
 static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 {
 	u64 max_end = 0;
+	int max_raix = -1;
 	int i;
+	int inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 
 	for (i = 0; i < ctx->nbufs; ++i) {
 		ctx->olaps[i].start = ctx->args[i].ptr;
@@ -685,7 +689,10 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 
 			if (ctx->olaps[i].end > max_end) {
 				max_end = ctx->olaps[i].end;
+				max_raix = ctx->olaps[i].raix;
 			} else {
+				if ((max_raix < inbufs) != (ctx->olaps[i].raix < inbufs))
+					ctx->olaps[i].do_cmo = true;
 				ctx->olaps[i].mend = 0;
 				ctx->olaps[i].mstart = 0;
 			}
@@ -695,6 +702,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 			ctx->olaps[i].mstart = ctx->olaps[i].start;
 			ctx->olaps[i].offset = 0;
 			max_end = ctx->olaps[i].end;
+			max_raix = ctx->olaps[i].raix;
 		}
 	}
 }
@@ -714,6 +722,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 
 	INIT_LIST_HEAD(&ctx->node);
 	ctx->fl = user;
+	ctx->sc = sc;
 	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
 	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
 		     REMOTE_SCALARS_OUTBUFS(sc);
@@ -739,7 +748,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	/* Take a reference to user, released in fastrpc_context_free() */
 	fastrpc_user_get(user);
 
-	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
 	ctx->client_id = user->client_id;
@@ -1078,6 +1086,54 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	return 0;
 }
 
+static void fastrpc_flush_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+
+	for (i = 0; i < ctx->nbufs; ++i) {
+		int raix = ctx->olaps[i].raix;
+		struct fastrpc_map *map = ctx->maps[raix];
+
+		if (raix + 1 > inbufs)
+			continue;
+		if (!map || !map->buf)
+			continue;
+
+		if (rpra[raix].buf.len && (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo)) {
+			dma_buf_begin_cpu_access(map->buf, DMA_TO_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_TO_DEVICE);
+		}
+	}
+}
+
+static void fastrpc_inv_args(struct fastrpc_invoke_ctx *ctx)
+{
+	union fastrpc_remote_arg *rpra = ctx->rpra;
+	int i, inbufs;
+
+	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
+
+	for (i = 0; i < ctx->nbufs; ++i) {
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
+		if (ctx->olaps[i].mstart || ctx->olaps[i].do_cmo) {
+			dma_buf_begin_cpu_access(map->buf, DMA_FROM_DEVICE);
+			dma_buf_end_cpu_access(map->buf, DMA_FROM_DEVICE);
+		}
+	}
+}
+
 static struct fastrpc_invoke_buf *fastrpc_invoke_buf_start(union fastrpc_remote_arg *pra, int len)
 {
 	return (struct fastrpc_invoke_buf *)(&pra[len]);
@@ -1202,6 +1258,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		}
 	}
 
+	if (!ctx->fl->sctx->coherent)
+		fastrpc_flush_args(ctx);
+
 	for (i = ctx->nbufs; i < ctx->nscalars; ++i) {
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
@@ -1387,6 +1446,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
+	if (!fl->sctx->coherent)
+		fastrpc_inv_args(ctx);
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
 	/* Send invoke buffer to remote dsp */
@@ -1407,6 +1468,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
+	if (!fl->sctx->coherent)
+		fastrpc_inv_args(ctx);
+
 	/* populate all the output buffers with results */
 	err = fastrpc_put_args(ctx, kernel);
 	if (err)
@@ -2370,6 +2434,7 @@ static int fastrpc_cb_init(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	sess->coherent = of_dma_is_coherent(dev->of_node);
 	sess->sid = sid;
 
 	if (cctx->domain_id == CDSP_DOMAIN_ID)
-- 
2.34.1

