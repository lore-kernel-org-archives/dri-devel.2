Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C61CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCA110ECA8;
	Mon, 14 Sep 2026 10:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XBeLfT4r";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T2Kek1Z5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A0F10ECA2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:40:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E9nQu6773139
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=kmGKNQS/caVsWFVS0K6md8Yq/Ng3yDqp2+7
 Su9CofKM=; b=XBeLfT4rdS5reL1zeWXMvc21OQKiUY64erkAmejdbqsJki3FCbp
 wEcWilUOPLrSfDc5m3XeYd30WDmpgSyPD8S1rV7Ciip5ONNwlmPxlJ5nHWqY8ZoY
 QR4cQXpLq9rVwWYpSqTpJtCDRwvC0o6JS3spf2JmnCRdPOlgnnbaJUF0gTUYJmxl
 JN1DNuE8rLK/UxpRAa+HyNFHFYloO8lZS7x1b5irbSEv9g6aWWPRZ9AS9GCUAc+q
 EvCuaD+SEcGB5mKaWrlkQkJyIi31/MjQfRTIpsJp90C/26+8XlwtSwGIlCPPn+uj
 gXDtZjsdgDANlJgWHLh5Ix68IjrWinsHAQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevrdtb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:40:29 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-395543dc382so4254047a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789382428; x=1789987228;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kmGKNQS/caVsWFVS0K6md8Yq/Ng3yDqp2+7Su9CofKM=;
 b=T2Kek1Z5rvSHeD+XRW7gocNQR9thoexi4zgu4Y/z/9ogXV+GYPLvKX1cfaO6CcsDQR
 ln3/3l8mk/9ViDN1h602IO8R6VvPFy6cQjrtPZ81cvnJSHECoCcIZJRB/2Z6UNIN0/Jm
 AZc27RSvxbwkcM9CN/2fnTtlsiuj9DKJy9PpEHTMa3QrUG0jRss81qPwJvl6vWdHSxWi
 7th7tx2AunMfLglzVQipEkLuiXn0AUjRO61qAP/nucJ0r0YEcqE9cBtFEVRKjosfYWZ5
 jTmZ46ra+r3BVEbwtCZqICZX2es4el/KreIBfxfbirwcWw4On0PV9IAGWhJu/deYtP1B
 WjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789382428; x=1789987228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kmGKNQS/caVsWFVS0K6md8Yq/Ng3yDqp2+7Su9CofKM=;
 b=PGX4KcpwWE/g8ovX5bJmd2FXB2nzL4qAul/udfmwAQJqTar7aNhF8orZS5UY1pZZP8
 Ci1S6eft/xJAondJK+pB0otX9TtM5GoRJywyZGV4cZYepGBWyaYpQGfnxkKY1OEszz70
 soK+I1ViRvv6Jhib46k1waVlAMeSQ0syxQpFX9zdWOYASA2ZPCk2gHKleuH8E2+KFkTx
 EvaFNzt+tmzDR74Tdn93SQ30n+mhY5//gAvOuQp7L40xXHTtEmsWcRsPXVs5aKs72diQ
 Mw+lC9oy0B0DIpLOO8hO2yOVpB7b+UF3MJBr964IykhoWFtbETf5RKEuRFmv3FtE9fVp
 748A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB4cpqArIQRg52w5ZSfxTR+SGFYrduRLBsgH9meGUQUuWmDmMhuoXT8WbtffaZ5Sqa4F9WO4Af4fo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNqEjxJUPKHd7kfWqXTVar09N6cM5zesfyNfPnHbBm1+IwalTY
 Mqc68fN6xNZ+PhkYwNpWKPQvdJSWkMNrqAzv9IPQ4dgIN5ivccV9s1jglmXKWxSb7GfK/+sJTXP
 Dl2OttyyaMQo9AxJhzrxRypVHaFx4sD8iKE6x7/QhzJRAlKEN4KqERJpPIn2/qr8SNX6SIPo=
X-Gm-Gg: AYBFou2KvqnsdYAAlfBDPzFZdFqyLCpbxmtgyrRMqkNFxfIAoWgepUSFwSsqy8BIJjw
 pxzt8xijYen/98g/Jn9rxwhDyBqxIInwXgXLoLPSTVolBcE4YX4psCHUWxFuCIjMj2jBXqhIK9x
 bv3sN7rsxvJsvagvzD5BlB15pzJzAO9eAYkdL9guG9er7WIuPkwFW7fwy4XM0iALbgv9gz4+7D8
 akUefDrJsJCX+xeohgK1Yeck4+rGSG3yGWncZ7pYTXWP5CkWo9UABfDTgBYnqebi/Y9hYIXUUEM
 bkfxRjQUbrDXjrwJzYhQzhw+oPtyJ11lUqiSTv3Z9r4DR2lfVpX9cJZ8uOVIMRl8Us//3sOmbA9
 FGuEfJQClv2F0QXKfbFtP5lo/RIEDL13QSWtOS/OU5iF9CZn8QyHisqW9iP1QjG/FAnsLwoWj
X-Received: by 2002:a17:90b:590b:b0:39d:f720:c5a5 with SMTP id
 98e67ed59e1d1-39df720d07bmr1003613a91.15.1789382428029; 
 Mon, 14 Sep 2026 03:40:28 -0700 (PDT)
X-Received: by 2002:a17:90b:590b:b0:39d:f720:c5a5 with SMTP id
 98e67ed59e1d1-39df720d07bmr1003519a91.15.1789382427491; 
 Mon, 14 Sep 2026 03:40:27 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39db996bde4sm14328042a91.7.2026.09.14.03.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:40:27 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Ling Xu <quic_lxu5@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v4] misc: fastrpc: avoid duplicate DMA mappings in
 fastrpc_create_maps()
Date: Mon, 14 Sep 2026 18:40:19 +0800
Message-Id: <20260914104019.492-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YkpaY09ZuzBasr866KoamuaoDbgcIzsF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE1MiBTYWx0ZWRfX0fh6tpvm3kQg
 vnIt9xKaFo4m4i18W37skD8Ee3v6tfMs7O+0l/vK35Q7oKTjU3gOYaQOSjoJSUwcaMRYtKSATZL
 FgIoWCcO7ogVKUUUEj0xJ8g5K2Jeeqc=
X-Proofpoint-GUID: YkpaY09ZuzBasr866KoamuaoDbgcIzsF
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa7cf1d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=jcsToSEUEPbHcpESBJIA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE1MiBTYWx0ZWRfXyZnZJ4yBnGDy
 EISr+OeeQAJ1oCkCqjt17poTeZrSx4ySafdVsLVi9MKIDzjzsM9P2Z4Jn0mxOrFAsmRiUAmA2z/
 gCqlaqbFb3i8rSNhkV26p/TsYxiXDCAke6Q6tmgEjIO+83dFwTGpArPoOJNMqHVDptjqT2LKnsa
 WpVY1mHsTv47DupdsCSVkf2EpUbtV3j0dI9IUVaImNKEbizWM5wkVPlLwGG8c6wcuFYJvjWVtuq
 xXZd5Mm9N1xFV62B+SCRmg7Rbz9kzP/dD7PdQc8vne/vpCZ+xu62xkQ7h5HLs4VMk0ENH09WJbR
 8GHOo3N7kieB+/GC8ZZZbqBuJ3K3ssMmwnLmMPLJWNgFcicVVsLjJs26l34+VcyTpE5YIBg2UEl
 GqzjH6KtDOoTm4A5oQj4jmfCqAe9BBLM8Y2E/xqGDe2csfDM2m7xcu3Gyom3eoB3zKLFMfSm8hV
 QKWhcF7w/n6Xz8ATJwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140152
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

DMA handles passed as invoke arguments (scalars beyond nbufs) may refer
to the same dma_buf fd as an input/output buffer argument. Taking an
extra reference for such DMA handle maps leads to duplicate mappings and
an unbalanced reference count, since DMA handle maps are released
separately when the DSP returns the fd through the fdlist.

Fix this by not taking an extra reference for DMA handle arguments
(take_ref = false) and tagging them with FASTRPC_MAP_DMA_HANDLE. As
these maps are borrowed references, fastrpc_get_args() re-validates the
map via fastrpc_map_lookup() before dereferencing it, so it is not used
after being freed. fastrpc_put_args() only releases maps flagged as
FASTRPC_MAP_DMA_HANDLE and clears the flag to guarantee the map is freed
exactly once.

Fixes: 10df039834f84 ("misc: fastrpc: Skip reference for DMA handles")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
Patch [v3]: https://lore.kernel.org/all/20260805060940.41414-1-jianping.li@oss.qualcomm.com/

Changes in v4:
- Do not expose FASTRPC_MAP_DMA_HANDLE through the uapi header. The flag
  is only set and consumed by the driver, userspace never passes it as an
  input flag, so define it privately in fastrpc.c instead. This also keeps
  FASTRPC_MAP_MAX as the real upper bound of the uapi flags.
- Drop the FASTRPC_MAP_DMA_HANDLE rejection in fastrpc_req_mem_map(): with
  the flag no longer in the uapi, userspace cannot pass this value through
  the MEM_MAP path, so the check is dead code. The commit message paragraph
  describing it is removed as well.

Changes in v3:
- No functional changes.
- fastrpc_put_args(): document that clearing map->flags without a lock
  is safe because the DSP reports a given fd in the fdlist only once,
  so no concurrent fastrpc_put_args() can race on the same map's flags.

Changes in v2:
- Rework the commit message to describe the DMA handle reference and
  lifetime problem more precisely.
- Introduce a new FASTRPC_MAP_DMA_HANDLE uapi flag and a 'flags' field
  in struct fastrpc_map to explicitly tag DMA handle maps, instead of
  relying only on the nbufs boundary / take_ref.
- Plumb an mflags argument through fastrpc_map_create() and
  fastrpc_map_attach() so DMA handle maps are tagged at creation time.
- Re-validate the borrowed map in fastrpc_get_args() via
  fastrpc_map_lookup() before dereferencing it, to avoid a
  use-after-free when the map was created with take_ref = false.
- In fastrpc_put_args(), only release maps tagged FASTRPC_MAP_DMA_HANDLE
  and clear the flag afterwards, so such maps are freed exactly once.
- Reject FASTRPC_MAP_DMA_HANDLE in fastrpc_req_mem_map(), since these
  handles are already mapped implicitly during the remote invoke and
  must not be mapped again through the explicit MEM_MAP path.
---
 drivers/misc/fastrpc.c | 56 +++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4fac2caca86..58f27e271317 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -52,6 +52,9 @@
 #define FASTRPC_CTXID_SEQ_SHIFT	16
 #define FASTRPC_CTXID_SEQ_MASK	GENMASK_ULL(63, 16)
 
+/* Map the DMA handle in the invoke call for backward compatibility */
+#define FASTRPC_MAP_DMA_HANDLE  0x20000
+
 /*
  * Newer DSP firmware implements a PD (Protection Domain) notification
  * framework that sends PD state notifications upon request. The PD exit
@@ -253,6 +256,7 @@ struct fastrpc_map {
 	u64 len;
 	u64 raddr;
 	u32 attr;
+	u32 flags;
 	struct kref refcount;
 };
 
@@ -879,7 +883,7 @@ static dma_addr_t fastrpc_compute_dma_addr(struct fastrpc_user *fl, dma_addr_t s
 }
 
 static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+			      u64 len, u32 attr, struct fastrpc_map **ppmap, int mflags)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
@@ -896,6 +900,7 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 
 	map->fl = fl;
 	map->fd = fd;
+	map->flags = mflags;
 	map->buf = dma_buf_get(fd);
 	if (IS_ERR(map->buf)) {
 		err = PTR_ERR(map->buf);
@@ -970,13 +975,13 @@ static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 	return err;
 }
 
-static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
-			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd, u64 len, u32 attr,
+			      struct fastrpc_map **ppmap, bool take_ref, int mflags)
 {
-	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
+	if (!fastrpc_map_lookup(fl, fd, ppmap, take_ref))
 		return 0;
 
-	return fastrpc_map_attach(fl, fd, len, attr, ppmap);
+	return fastrpc_map_attach(fl, fd, len, attr, ppmap, mflags);
 }
 
 /*
@@ -1047,23 +1052,25 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 	int i, err;
 
 	for (i = 0; i < ctx->nscalars; ++i) {
+		bool take_ref = i < ctx->nbufs;
+		int mflags = 0;
 
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1 ||
 		    ctx->args[i].length == 0)
 			continue;
 
-		if (i < ctx->nbufs)
-			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
-		else
-			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
-				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		/* Set the DMA handle mapping flag for DMA handles */
+		if (i >= ctx->nbufs)
+			mflags = FASTRPC_MAP_DMA_HANDLE;
+
+		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd, ctx->args[i].length,
+					 ctx->args[i].attr, &ctx->maps[i], take_ref, mflags);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
 		}
-
 	}
+
 	return 0;
 }
 
@@ -1195,6 +1202,16 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		list[i].num = ctx->args[i].length ? 1 : 0;
 		list[i].pgidx = i;
 		if (ctx->maps[i]) {
+			/* It is possible that map is created with
+			 * mflags FASTRPC_MAP_DMA_HANDLE and take_ref
+			 * is false. Check if map still exists or is
+			 * being freed as take_ref is false
+			 */
+			if (fastrpc_map_lookup(ctx->fl, ctx->args[i].fd,
+					       &ctx->maps[i], false)) {
+				ctx->maps[i] = NULL;
+				return -EINVAL;
+			}
 			pages[i].addr = ctx->maps[i]->dma_addr;
 			pages[i].size = ctx->maps[i]->size;
 		}
@@ -1244,8 +1261,17 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
+		/*
+		 * DMA handle maps are released when the DSP returns the corresponding fd in
+		 * fdlist. The DSP is expected to return a specific fd only once in fdlist,
+		 * so no two fastrpc_put_args() paths should clear the DMA_HANDLE flag for
+		 * the same map concurrently.
+		 */
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false) &&
+		    mmap->flags == FASTRPC_MAP_DMA_HANDLE) {
+			mmap->flags = 0;
 			fastrpc_map_put(mmap);
+		}
 	}
 
 	return ret;
@@ -1621,7 +1647,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	fl->pd = USER_PD;
 
 	if (init.filelen && init.filefd) {
-		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
+		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map, true, 0);
 		if (err)
 			goto err;
 	}
@@ -2244,7 +2270,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 		return -EFAULT;
 
 	/* create SMMU mapping */
-	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map);
+	err = fastrpc_map_create(fl, req.fd, req.length, 0, &map, true, 0);
 	if (err) {
 		dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
 		return err;
-- 
2.43.0

