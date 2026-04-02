Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64204CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E1010F098;
	Thu,  2 Apr 2026 05:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eu4yUDoR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZk1torL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FE2710F098
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 05:49:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631M4MGK4009757
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 05:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7oB02y7DFV4
 f1UWHYqajk1w575aCaNpMNr02LPqXAcI=; b=Eu4yUDoRtYt7fCso2YhZMhuz9Iq
 WMd1xwGL0ebWGKctydfo25iZKUU66w9s8XmZxv4SUIOqzR6zwMdHy3QVxY1khflX
 pBc6S3OboAI0Au2rvHxWmTbIWuHsayu9nzgi/9ij7hTibffVatkEHctpoRzvirD+
 FNQca2Fj+QLy5iMQ/edMTSszHuIqUawOhbnrkIn5vk7V4cQDRYUpKTXhQdQXp+Rg
 +Z1b4Mz6RgXBSF738Ttv2j1/MhGatNPNwCEp486KixIFa5YBjR7vxNIJTo/YUFkG
 We+SiackFMR2M8rAKsMux8sDulXYD4Pidb7uqAM83yO9pNLylEQ1iCkLY4w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d97e029nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 05:49:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c4664f75fso335686b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 22:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775108987; x=1775713787;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oB02y7DFV4f1UWHYqajk1w575aCaNpMNr02LPqXAcI=;
 b=bZk1torLmX7sS7RYqnjLZwfHhNPv9ah1xZHx2Kef83KX9acEupQdXQV94u9GKmRms4
 OnOH0hGQI3gjfuAfDEGutdJgr5ZqnCVV3BCJQ31WbDkmRhlcISzvhTyhW0dKwWXUgoNY
 bHaoW74P1f0ak8QZXjJbzSqaaJ+igFC+igI4RTPMaNT214ESff0IjKrgirX1fh5cdGOU
 xUUGqerIMF/AYi/dAyCxhNXMYq2KiINk7CLvk8TLmy9W6iHODAzU27RWgqZuut6kMbao
 i+YQOMtvh3ETg1C7m+knvBnFei4HALRcyxxypxiqcSZf7DWtCbiuIwQnVp37nDxzTPib
 TVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775108987; x=1775713787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7oB02y7DFV4f1UWHYqajk1w575aCaNpMNr02LPqXAcI=;
 b=HPt159X0XmU0AFBHZetbv6kmKB8Vl/73eD4DrwGDB32mr2zBbEdEf06+7rFKw6WwGx
 0tAReumIs1XMCHXDLIP4yWjORv03OChKHqUNKxeIuC1soWpsEvcvkau7mFdavknlbKjo
 HBK8wC8wTMgQL0qE81FchC47+zKFvqaP9oQoDmS/GwndTDq3p90q2Rt5ZfXVxfVmJU3B
 Jrumodj1LECWY1squw0JOGj5K3/nEcrRzWH3hHt5o6uO+QeQ4s2GXgKxJdwWHsiE2ah5
 jhtS6OOwBVB+dh7gEeuw4g2a/H0vvvxEK2PCuZ+LioMQ3U5EcEVNx9gpUc9RwhpYB7OL
 jV5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI64qVL4lyM5UJdtSMl9To0AMGWyEu75R1SND4gdi35w+AjfaFOZkaM8Uwa41UPDBK7X4MSkZfVAs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7QvUacLgpgr3NKoLf/Mcxg/mWzdwvmX8aAorrTaLQAdHFqzyp
 LSd/waiyjggnjOSzb8wcdNwe7byFgKeC9OFK2E2pTLVg/h4/xDZd56YEETvdv1+oFvU2+PGwV3t
 hkOQl6BFHbIK2ZvWXPNOqrNlY9UZhvndxjczahhXlbJhYP/fj0wLO2xzI0qsFaLatzNoObA4=
X-Gm-Gg: ATEYQzxMlCy8/KEWQ55L8cLxICZsTHtq5o2oSPIvhpUuVpo1uxwRQbE82upKetWb1SO
 KEHGkJYjYMOLT5pMDbryA8v9iJsXR7I3HVDcpzcLyc96O6MjWgoNn4uxUxFGva1B8b7RoYOIdI4
 WCk1M1kpkIKmTVYAYsxWdLDPJxKv6zNqbYeU6ckJDlnZ4Dn24WkjxDeRDbst73/MYIR76YeIZFl
 ja1y+AKnL7u2zYEUXz28uUwSlxpAcryK5gqPxaVfhg2k3BVqRa1oO2hJSPefPaDttYFrRR5eRpV
 k1CbVW3b47GGp/3jdvskdOrJgKz8LIXrkLotZihjWdoEDlTIgRxaM+k9qSNhm/nwHzT3ghaNtbc
 eZkjVpFRxzHk+K3cSBwUmAv7R5jT72SDyM8FZzDo4b+fFK9QLYruTeA==
X-Received: by 2002:a05:6a00:1c84:b0:82c:e76b:c68c with SMTP id
 d2e1a72fcca58-82ce86e2e62mr7119033b3a.0.1775108987077; 
 Wed, 01 Apr 2026 22:49:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c84:b0:82c:e76b:c68c with SMTP id
 d2e1a72fcca58-82ce86e2e62mr7119003b3a.0.1775108986562; 
 Wed, 01 Apr 2026 22:49:46 -0700 (PDT)
Received: from hu-ekangupt-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b5fb22sm2167747b3a.26.2026.04.01.22.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 22:49:46 -0700 (PDT)
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
To: srini@kernel.org, linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 dmitry.baryshkov@oss.qualcomm.com, andersson@kernel.org,
 konrad.dybcio@oss.qualcomm.com
Subject: [PATCH v7 4/4] misc: fastrpc: Add polling mode support for fastRPC
 driver
Date: Thu,  2 Apr 2026 11:19:23 +0530
Message-Id: <20260402054923.3061925-5-ekansh.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
References: <20260402054923.3061925-1-ekansh.gupta@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fdGgCkQF c=1 sm=1 tr=0 ts=69ce037b cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=TEHdEMHTk_fMHrPBF0kA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: MnYbp1_4MnMu6NVSTEeKhmFoH3NGtY6c
X-Proofpoint-GUID: MnYbp1_4MnMu6NVSTEeKhmFoH3NGtY6c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0OCBTYWx0ZWRfX+8eEwVeLn3bH
 gaXTmPUpn8YGWEsjKHtFLmn5yyNsj20/BxCwsJzisYLataoU3ZbhlOgxgw0q/uC3oXYqNzUaXiB
 I7GHh5NRuqHFlOfgJr8+wKX/LRIIl1zlvKe8BV1+JESnj4hIx+YSjVZkB2X03AIzH4GGfGcQLjJ
 P+iXENkDglPzZawt0gOGNEy7NsVksv7o9xdSM2m2Mjlvow/98gViCImxEwGliqjg98BWi0Psb4T
 +wDyPHgdf3oed8X9pb9IqK2nbNqGRNwzdmtTI/0GQxzhSYkqXbWlysScnpySRuMI1EfBHt4d2RR
 0BRlMcRSRPu5t7RGuT/Iz4qqgCMhD/SNFvXXQE9DsuoBafolWKL1vADs3CUBG8k9PwcWafcdfmU
 7OOvMzSxdMFSPkv6XhAu40EjQnBbxEVUSlHWGe60l5uZ64CIhd3cBBkbUwT/+Ow4Qqeya14Xr4h
 Vk2UiU1+KEWJSiqH7+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020048
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
 drivers/misc/fastrpc.c      | 132 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |  10 +++
 2 files changed, 135 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4363e0cc296b..25f385f4704d 100644
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
@@ -38,6 +40,7 @@
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
+#define FASTRPC_MAX_STATIC_HANDLE (20)
 #define FASTRPC_CTXID_MASK GENMASK(15, 8)
 #define INIT_FILELEN_MAX (2 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
@@ -106,6 +109,12 @@
 
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
@@ -236,8 +245,14 @@ struct fastrpc_invoke_ctx {
 	u32 sc;
 	u64 *fdlist;
 	u32 *crc;
+	/* Poll memory that DSP updates */
+	u32 *poll;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* process updates poll memory instead of glink response */
+	bool is_polled;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -308,6 +323,8 @@ struct fastrpc_user {
 	int client_id;
 	int pd;
 	bool is_secure_dev;
+	/* Flags poll mode state */
+	bool poll_mode;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -923,7 +940,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32);
 
 	return size;
 }
@@ -1019,6 +1037,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	ctx->fdlist = (u64 *)(pages + ctx->nscalars);
+	ctx->poll = (u32 *)((uintptr_t)ctx->fdlist + sizeof(u64) * FASTRPC_MAX_FDLIST +
+			     sizeof(u32) * FASTRPC_MAX_CRCLIST);
+
 	args = (uintptr_t)ctx->buf->virt + metalen;
 	rlen = pkt_size - metalen;
 	ctx->rpra = rpra;
@@ -1188,6 +1209,74 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static inline u32 fastrpc_poll_op(void *p)
+{
+	struct fastrpc_invoke_ctx *ctx = p;
+
+	dma_rmb();
+	return READ_ONCE(*ctx->poll);
+}
+
+static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
+{
+	u32 val;
+	int ret;
+
+	/*
+	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll
+	 * or until another path marks the work done.
+	 */
+	ret = read_poll_timeout_atomic(fastrpc_poll_op, val,
+				       (val == FASTRPC_POLL_RESPONSE) || ctx->is_work_done, 1,
+				       FASTRPC_POLL_MAX_TIMEOUT_US, false, ctx);
+
+	if (!ret && val == FASTRPC_POLL_RESPONSE) {
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
+	do {
+		if (ctx->is_polled) {
+			err = poll_for_remote_response(ctx);
+			/* If polling timed out, move to normal response mode */
+			if (err)
+				ctx->is_polled = false;
+		} else {
+			err = fastrpc_wait_for_response(ctx, kernel);
+			if (err)
+				return err;
+		}
+	} while (!ctx->is_work_done);
+
+	return 0;
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   u32 handle, u32 sc,
 				   struct fastrpc_invoke_args *args)
@@ -1223,13 +1312,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -1812,6 +1902,30 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	return 0;
 }
 
+static int fastrpc_set_option(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_ioctl_set_option opt = {0};
+	int i;
+
+	if (copy_from_user(&opt, argp, sizeof(opt)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(opt.reserved); i++) {
+		if (opt.reserved[i] != 0)
+			return -EINVAL;
+	}
+
+	if (opt.req != FASTRPC_POLL_MODE)
+		return -EINVAL;
+
+	if (opt.value)
+		fl->poll_mode = true;
+	else
+		fl->poll_mode = false;
+
+	return 0;
+}
+
 static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_ioctl_capability cap = {0};
@@ -2167,6 +2281,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_MEM_UNMAP:
 		err = fastrpc_req_mem_unmap(fl, argp);
 		break;
+	case FASTRPC_IOCTL_SET_OPTION:
+		err = fastrpc_set_option(fl, argp);
+		break;
 	case FASTRPC_IOCTL_GET_DSP_INFO:
 		err = fastrpc_get_dsp_info(fl, argp);
 		break;
@@ -2518,6 +2635,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	}
 
 	ctx->retval = rsp->retval;
+	ctx->is_work_done = true;
 	complete(&ctx->work);
 
 	/*
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index c6e2925f47e6..c37e24a764ae 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -16,6 +16,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_SET_OPTION	_IOWR('R', 12, struct fastrpc_ioctl_set_option)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
@@ -67,6 +68,9 @@ enum fastrpc_proc_attr {
 /* Fastrpc attribute for memory protection of buffers */
 #define FASTRPC_ATTR_SECUREMAP	(1)
 
+/* Set option request ID to enable poll mode */
+#define FASTRPC_POLL_MODE	(1)
+
 struct fastrpc_invoke_args {
 	__u64 ptr;
 	__u64 length;
@@ -133,6 +137,12 @@ struct fastrpc_mem_unmap {
 	__s32 reserved[5];
 };
 
+struct fastrpc_ioctl_set_option {
+	__u32 req;	/* request id */
+	__u32 value;	/* value */
+	__s32 reserved[6];
+};
+
 struct fastrpc_ioctl_capability {
 	__u32 unused; /* deprecated, ignored by the kernel */
 	__u32 attribute_id;
-- 
2.34.1

