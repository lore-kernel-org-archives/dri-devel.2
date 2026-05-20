Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD843CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 06:51:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3031910EF07;
	Wed, 20 May 2026 06:51:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="im9n3Jil";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RG+F+VIZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB99910EF07
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JM02CB1739499
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=orVCR6H6vjR
 l03w7Yllbu5y5Z07UKEr+6JQAjsXp5pw=; b=im9n3JiliYBKzXcY33I5qQA2A1V
 nlAslxKCrlfXn0uviEPvTtwuA8ymNvMi5ncP81M5meyAwu5wg7Gb37csAtG5UyT+
 aPVi0556PWBCNfIvRSlyu4yAWvZeRnT58Bjy8mSwRzW1Hjfkp1mAJWxZHb+NCl30
 KquSHiwhpeN8xmCV5UbeosIIshvvF7c6VYhmwqcZt5+Ni8/5j0BhAN/UUh+wQUJe
 ftbRVlwZNfq2yZ4HQP6oaZ7wAuloRsoTH/MtduUPuZkcRa5EPIxL1h++BcXUvMUK
 xHaVMAxgazTsfMpZDA1SxIldy7Z45SO0srBfqAuehfdy6XDpVGg1jYYrQUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qbbb1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:51:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd5b20aaa6so49193085ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779259871; x=1779864671;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=orVCR6H6vjRl03w7Yllbu5y5Z07UKEr+6JQAjsXp5pw=;
 b=RG+F+VIZh3E2woLYRM4v65Stze56B79HDc3ZVP6sehXIheDOYWeQgL/hAqkBsgUIUV
 w1cBC8pMEVad357lxSg6SxOMXmcRjP48OKGhcb9hRQBIhq8u89QQNzToFHP+bJZjZxuG
 Hq9foxI3GAO6ag85MVlsitKhz7LbDIzru6dQoWc6PybuR6B64KW+mD4L+zOVlrkv3q3P
 yJZmGh1Ck/evkuhEt0dpOTEAgNjzTNHLfbvllCjGRjbJwqnOeA1hBqGfx83TFM31EcNc
 lNq1beoMcEhdCVMZn6sWGqdfaLycRySqqCGHnKGsHXjXD7As1SiMFJ9mzNXUa3wbyrQ6
 pmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779259871; x=1779864671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=orVCR6H6vjRl03w7Yllbu5y5Z07UKEr+6JQAjsXp5pw=;
 b=VHtUd/YBvBgfK+DftSdJY61xfwL4g/vvE5EUsdgcNKJYE9mUJiU2Fnt7h1MMs3eV1U
 s/d9/TQmjO3AySSfTfcR8wPf+TstN94kcJxSGBUH+qAd8o4B7hvadjjPoo8eur6aQOaF
 BARMpzFUW0eX4C5YKGvr9U16p5IeZb+wzuYO56vVUIQ+MqQo0GoY0cywL4BaVQPUkV9i
 FV9rLd0hO5aQgq0TXJjaQZj26oTpjfjGCxZ84TZ+KS6tdMYiIFrP5+hL9YLrNirgDe2y
 nlZer3Ex3j/kguDiE7kuVQUJLYGMsGcr8DlOD9fk97VnzxhJpkeAWR7pp5BbIjSh1EDG
 2MAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rhrE4deb5Zsqtf8rpAQ57L0x0c9QShgTw3f17hK6A3cxcjQgd4gLZ/bRzQd/b47TQC2WagVEbOPE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSTifNGKmdkxPO+9KuopgXu8U++SNd3eUR91ZKMYEBrlUGC12T
 fXv58tusnqgfWK0nIPJZYHPy580j9L7kpV613Xhy63Wld8xN2z/kmAMnrIJOSgEDYGSGBttM/Pf
 DLzOPRfDgELokY+lhoqKUUmjFqMU7e/OBGAGmAmBmjfN86tNDsxXCvumQ38kf+M8aHL6RCEE=
X-Gm-Gg: Acq92OHrJSdShonsNRi8smRy19hICd2m1dFVAzCnBrlg6+MUn/feBInVQHzIHfYLGpZ
 dFVWc9GeqUgcgbiEYQmh7ewhvgDb6kFR3eZ9NtkC2YLbSRJTXFb4dPLI30rp6XAjEGeV5OdiQ2l
 Sj6YA0T9Vp4AmRYi4MKkMP4e1DMDxWNBEzRGEiu1rTpP7r5fXqa5VFAHo0AoSPTzaSnDSHX3RM4
 Xzb0a150PweQQB0r6zoNUBBSiqcUha+nUONd6sCEX2WYE4nwIV+qkIVo3T1le7GlDlsJbcS45Qm
 PB1ofc7iHXbkxZsaIfRFLKM6HS8zrthK6gJolUVzHGoiC8SELU7BGQTgtTyd0su+mPtK8XsioZw
 jgjm7Ko5LIOJcWF+nT3Ad8TWx2nvkNVb2/bXSsCQ9e5Caj6XprgvM/9QWBHL5P55F
X-Received: by 2002:a17:903:2f81:b0:2be:1c3c:72ba with SMTP id
 d9443c01a7336-2be1c3c73cemr90954125ad.32.1779259870544; 
 Tue, 19 May 2026 23:51:10 -0700 (PDT)
X-Received: by 2002:a17:903:2f81:b0:2be:1c3c:72ba with SMTP id
 d9443c01a7336-2be1c3c73cemr90953825ad.32.1779259869996; 
 Tue, 19 May 2026 23:51:09 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5fe51sm206410165ad.2.2026.05.19.23.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:51:09 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com
Subject: [PATCH v11 4/4] misc: fastrpc: Add polling mode support for fastRPC
 driver
Date: Wed, 20 May 2026 12:20:47 +0530
Message-Id: <20260520065047.3415790-5-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
References: <20260520065047.3415790-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nM3nI4fPIueurZEI3uR9CgusnCBP5h-6
X-Authority-Analysis: v=2.4 cv=LcMMLDfi c=1 sm=1 tr=0 ts=6a0d59df cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=Xak7btDuadOZULdqBEwA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: nM3nI4fPIueurZEI3uR9CgusnCBP5h-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA2MyBTYWx0ZWRfX5pGwOo/wkvjO
 03jmmPvkygiJHzOB3v1koZ8AECK/FLYG6HBn0YKwr2o5po6Nl+hyTF8Hj0pf+B39KRgIUl6v81F
 IGyr4ezeYi11/up+79tjS/fRWUxbxfePj+cqFWwZoHqHMowaU8+3P2ovPblh+NTU0iWlmmwfS9W
 ToLu8qNpNcmTAs//SklHKq2YHaTSfgJhdatR376xXNkOmsy+h7u9h0lriQFwZp2NrWgZnpRW8gV
 Xplx9HCdJeHSxzA38UziEjN+s+SEBCzR5pudXeeu3LraFvzZ46NRTVfKyu4JTN6K0cVj95cIRqv
 al8lUe/n3+9CMHrdOmrmgS5l0026+2LFasuskR8Y0TMSZIBaZWmRCzhlfBV8s2+nQNP1Ovf80yd
 TRSE5zioxkxMYDEufpDqT18V1DJOFOlFjDNT677TZ0zNjX9l0nMFxOTrsAui7FMYeo78KRf0iZE
 IdG1MFeoECtJh6u2sKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
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

For any remote call to DSP, after sending an invocation message,
fastRPC driver waits for glink response and during this time the
CPU can go into low power modes. This adds latency to overall fastrpc
call as CPU wakeup and scheduling latencies are included. Add polling
mode support with which fastRPC driver will poll continuously on a
memory after sending a message to remote subsystem which will eliminate
CPU wakeup and scheduling latencies and reduce fastRPC overhead. In case
poll timeout happens, the call will fallback to normal RPC mode.  Poll
mode can be enabled by user by using FASTRPC_IOCTL_SET_OPTION ioctl
request with FASTRPC_POLL_MODE request id.

Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c      | 167 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |  29 +++++++
 2 files changed, 189 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c4a3547a5c7f..aab70947482d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -24,6 +24,8 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/bits.h>
 #include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/iopoll.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -38,6 +40,12 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
+/*
+ * Maximum handle value for static handles.
+ * Static handles are pre-defined, fixed numeric values statically assigned
+ * in the IDL file or FastRPC framework.
+ */
+#define FASTRPC_MAX_STATIC_HANDLE (20)
 #define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
@@ -106,6 +114,12 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+/* Poll response number from remote processor for call completion */
+#define FASTRPC_POLL_RESPONSE (0xdecaf)
+
+/* Polling mode timeout limit */
+#define FASTRPC_POLL_MAX_TIMEOUT_US (10000)
+
 struct fastrpc_phy_page {
 	dma_addr_t addr;	/* dma address */
 	u64 size;		/* size of contiguous region */
@@ -236,8 +250,14 @@ struct fastrpc_invoke_ctx {
 	u32 sc;
 	u64 *fdlist;
 	u32 *crc;
+	/* Poll memory that DSP updates */
+	u32 *poll_addr;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* process updates poll memory instead of glink response */
+	bool is_polled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -263,6 +283,7 @@ struct fastrpc_soc_data {
 	u32 sid_pos;
 	u32 dma_addr_bits_cdsp;
 	u32 dma_addr_bits_default;
+	bool poll_mode_supported;
 };
 
 struct fastrpc_channel_ctx {
@@ -285,6 +306,7 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	bool poll_mode_supported;
 	u64 dma_mask;
 	const struct fastrpc_soc_data *soc_data;
 };
@@ -308,6 +330,8 @@ struct fastrpc_user {
 	int client_id;
 	int pd;
 	bool is_secure_dev;
+	/* Flags poll mode state */
+	bool poll_mode;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -923,7 +947,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32);
 
 	return size;
 }
@@ -1019,6 +1044,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
+	ctx->poll_addr = (u32 *)((uintptr_t)ctx->fdlist + sizeof(u64) * FASTRPC_MAX_FDLIST +
+			     sizeof(u32) * FASTRPC_MAX_CRCLIST);
+
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1188,6 +1216,71 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static u32 fastrpc_read_poll_addr(struct fastrpc_invoke_ctx *ctx)
+{
+	dma_rmb();
+	return READ_ONCE(*ctx->poll_addr);
+}
+
+static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
+{
+	u32 val;
+	int ret;
+
+	/*
+	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll_addr
+	 * or until another path marks the work done.
+	 */
+	ret = read_poll_timeout_atomic(fastrpc_read_poll_addr, val,
+				       (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done, 1,
+				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
+
+	if (!ret && val == FASTRPC_POLL_RESPONSE) {
+		/*
+		 * DSP writes FASTRPC_POLL_RESPONSE to signal successful
+		 * completion via the poll path.
+		 */
+		ctx->is_work_done = true;
+		ctx->retval = 0;
+	}
+
+	if (ret == -ETIMEDOUT)
+		ret = -EIO;
+
+	return ret;
+}
+
+static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
+					    u32 kernel)
+{
+	int err = 0;
+
+	if (kernel) {
+		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
+			err = -ETIMEDOUT;
+	} else {
+		err = wait_for_completion_interruptible(&ctx->work);
+	}
+
+	return err;
+}
+
+static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
+				       u32 kernel)
+{
+	int err;
+
+	if (ctx->is_polled) {
+		err = poll_for_remote_response(ctx);
+		if (!err)
+			return 0;
+		/* If polling timed out or failed, move to normal response mode */
+		ctx->is_polled = false;
+	}
+
+	return fastrpc_wait_for_response(ctx, kernel);
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
@@ -1223,13 +1316,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (err)
 		goto bail;
 
-	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-			err = -ETIMEDOUT;
-	} else {
-		err = wait_for_completion_interruptible(&ctx->work);
-	}
+	/*
+	 * Set message context as polled if the call is for a user PD
+	 * dynamic module and user has enabled poll mode.
+	 */
+	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd == USER_PD && fl->poll_mode)
+		ctx->is_polled = true;
 
+	err = fastrpc_wait_for_completion(ctx, kernel);
 	if (err)
 		goto bail;
 
@@ -1813,6 +1907,35 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	return 0;
 }
 
+static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_ioctl_set_option opt = {0};
+	int i;
+
+	if (!fl->cctx->poll_mode_supported)
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&opt, argp, sizeof(opt)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
+		if (opt.reserved[i] != 0)
+			return -EINVAL;
+	}
+
+	if (opt.request_id != FASTRPC_POLL_MODE)
+		return -EINVAL;
+
+	if (opt.value == FASTRPC_POLL_MODE_ENABLE)
+		fl->poll_mode = true;
+	else if (opt.value == FASTRPC_POLL_MODE_DISABLE)
+		fl->poll_mode = false;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_ioctl_capability cap = {0};
@@ -2168,6 +2291,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_MEM_UNMAP:
 		err = fastrpc_req_mem_unmap(fl, argp);
 		break;
+	case FASTRPC_IOCTL_SET_OPTION:
+		err = fastrpc_set_option(fl, argp);
+		break;
 	case FASTRPC_IOCTL_GET_DSP_INFO:
 		err = fastrpc_get_dsp_info(fl, argp);
 		break;
@@ -2323,6 +2449,7 @@ static const struct fastrpc_soc_data kaanapali_soc_data = {
 	.sid_pos = 56,
 	.dma_addr_bits_cdsp = 34,
 	.dma_addr_bits_default = 32,
+	.poll_mode_supported = true,
 };
 
 static const struct fastrpc_soc_data default_soc_data = {
@@ -2331,6 +2458,29 @@ static const struct fastrpc_soc_data default_soc_data = {
 	.dma_addr_bits_default = 32,
 };
 
+/*
+ * Exception list for older platforms that use default_soc_data but whose
+ * DSP firmware supports FastRPC polling mode.
+ *
+ * NOTE: This list is intentionally closed.
+ * Do NOT add new platforms here. New SoCs must advertise polling mode
+ * support via their soc_data.
+ */
+
+static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unused = {
+	{ .compatible = "qcom,milos" },
+	{ .compatible = "qcom,qcs8300" },
+	{ .compatible = "qcom,sa8775p" },
+	{ .compatible = "qcom,sar2130p" },
+	{ .compatible = "qcom,sm8450" },
+	{ .compatible = "qcom,sm8550" },
+	{ .compatible = "qcom,sm8650" },
+	{ .compatible = "qcom,sm8750" },
+	{ .compatible = "qcom,x1e80100" },
+	{ .compatible = "qcom,x1p42100" },
+	{},
+};
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2397,6 +2547,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 	data->soc_data = soc_data;
+	data->poll_mode_supported = soc_data->poll_mode_supported ||
+		of_machine_get_match(fastrpc_poll_supported_machines);
 
 	switch (domain_id) {
 	case ADSP_DOMAIN_ID:
@@ -2521,6 +2673,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	}
 
 	ctx->retval = rsp->retval;
+	ctx->is_work_done = true;
 	complete(&ctx->work);
 
 	/*
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index c6e2925f47e6..ba1ea5ed426c 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -16,6 +16,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_SET_OPTION	_IOWR('R', 12, struct fastrpc_ioctl_set_option)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
@@ -67,6 +68,28 @@ enum fastrpc_proc_attr {
 /* Fastrpc attribute for memory protection of buffers */
 #define FASTRPC_ATTR_SECUREMAP	(1)
 
+/**
+ * FASTRPC_POLL_MODE - Enable/disable poll mode for FastRPC invocations
+ *
+ * Poll mode is an optimization that allows the CPU to poll shared memory
+ * for completion instead of waiting for an interrupt-based response.
+ * This reduces latency for fast-completing operations.
+ *
+ * Restrictions:
+ * - Only supported for USER_PD (User Protection Domain)
+ * - Only applies to dynamic modules (handle > 20)
+ * - Static modules always use interrupt-based completion
+ *
+ * Values:
+ * - 0: Disable poll mode (use interrupt-based completion)
+ * - 1: Enable poll mode (poll shared memory for completion)
+ */
+#define FASTRPC_POLL_MODE	(1)
+
+/* Values for FASTRPC_POLL_MODE request */
+#define FASTRPC_POLL_MODE_DISABLE	0
+#define FASTRPC_POLL_MODE_ENABLE	1
+
 struct fastrpc_invoke_args {
 	__u64 ptr;
 	__u64 length;
@@ -133,6 +156,12 @@ struct fastrpc_mem_unmap {
 	__s32 reserved[5];
 };
 
+struct fastrpc_ioctl_set_option {
+	__u32 request_id;	/* Request type (e.g., FASTRPC_POLL_MODE) */
+	__u32 value;	/* Request-specific value */
+	__s32 reserved[6];
+};
+
 struct fastrpc_ioctl_capability {
 	__u32 unused; /* deprecated, ignored by the kernel */
 	__u32 attribute_id;
-- 
2.34.1

