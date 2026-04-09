Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A0E98FC2
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:26:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C920010E727;
	Thu,  9 Apr 2026 06:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3DRb75x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCejNH+c";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190B910E727
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 06:26:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6392o1ps3325993
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 06:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R9COzrVJDDX
 VUzJaQuSwPTmlBGewfpyqlBcsp+gMY8o=; b=U3DRb75xOSbgTHI1ulCEnB8bTog
 isBc2sQ9jSMPjowrTL7ffkJQNyhmStDs1YQt0f8/bSnNmv4kI8GwOykXPeALMQ8W
 ZfclkGzsgJ9lKLasLkbV/P76y8BdSNwDPbo236FytKpAyTmmT40u+ewd8TqE/HRT
 sp4BYLjMv934LM3CNwX4hfrPeWRytTAg0xyPRZp1bFX8w08EYg0sJys+LJiEh2wi
 drLXI9nMQxa7Jn5JUuiX74++Wf5a4EO+TaQ7RZV4slFVZkmgqY7UWTw50jIHs+qo
 OeK2aFXcUE1MuCTm3yZRV8T3KjwPt15eT5ppLylsCnDox8jD4TXyWhgj0vg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddw9msuq8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 06:26:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso1735097a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Apr 2026 23:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775716000; x=1776320800;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9COzrVJDDXVUzJaQuSwPTmlBGewfpyqlBcsp+gMY8o=;
 b=JCejNH+cVpqJq9VGLrHZCGZ2vmJIKo5brqOFB0O+11u1QSI1yDkY6GCCbnQhZgUPat
 BFDV1rIqQvhyoL5bB0x+ZGOEFYzBmwhaAKyAYcI9DqZJDzTAhxX2Gcz0JFWbdTCsW30d
 l9oNyA8nGJWX3Z74lt5O6JkLG7xhwvhpqSsVKC7xk10lexwZf6s7BmffsZG5F0KoD7K9
 dQKO2jVYaRtxBqILUq5cIGxA2W+yEnqxpOUnaRfmzLQZzLy9mm9m18suWJ+lScBFBFtc
 jpIGoZY0/8uWonz6NRqY6gxwWYCJ79RLeyAjxswr4z+wZsTognO3CkMJbqz7nrs9wc5p
 6EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775716000; x=1776320800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9COzrVJDDXVUzJaQuSwPTmlBGewfpyqlBcsp+gMY8o=;
 b=IamnJT0Yh22+V1/VC/UG7R2xB7HOLup/6RrKLzQcpxJ0jcC/D2F/hymPLITdi93fk8
 +/UEQguSTDLu6KbGMM732r9Ym4w+wlU2UzURsaXeXjfwRDvxU3p9hY6D/qGZFAevQW4w
 ZT2hvEuht0TNT0RhKo/1pwWL5mBsUEZqIMBfo7xH6hH+8PgybvfxSaBM6+kqOq2nPL48
 B9FycPeKxeuYGGf471sfJd31+7BfDlxP/VAp9uJwtZCaH1HZysZXKzeE5W920PqcO/wT
 gmcW5nej3vUKLAqO526lB901mmucgIo6A1Ct5zzGeVGd5HDYGGEkMXAbCFJgsTOuq+L8
 Zqww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa+yacPDpy1X0plZEW2gDD2bUsyyd6PTdaK7BHIF+N3X1MNe6K3xKqX+uLIrg7XHmpCvnlnThZL1M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVlW8JaOH7n+H5i2/6WYAqXPri+2ZfwyAfdvaj5oX1JZgscXmv
 PhVtCptHSTtG10xPSaEFCSY9+8eV+oT4fjOLV4rlDHefT0jakpTp8oC62Uegtx/5n3TbaV2ZwL/
 0SKuCnhb/4JskRx1nQtcjYdXZxj9pwkhsOV/1bqTIFrGFr/VMouVyNn3KGy0hXQVRQBhvfaE=
X-Gm-Gg: AeBDieu0w+Q0xwkrLd6Di2irngW7JQFNQ0r/DikTiNkedGujY3e37gj6oL8bIGfqQGl
 /RRcy2CSNGUbbd+XrcTy/yPFdaLn397j3kS10hGf+RsDSTXKPPwDwdhSKGpO+06m9jyy/gvS60s
 53jSPssEQuXzG5Cfotqp1IKZw1n7D2STSXYWTTzEFgmvldSC2LoqapzJNQE9zQVOzvhJQaHT5Pw
 rRH+WtEmyeOkX6RPcUXSsKRCD2F/ce67k407QTgklsXE04fg6zrjEjO7wAPDjuUx0G9M40Cm+8m
 Bj+eDTaOlDTt63VI44kfIkYWqTeSCiH4ycxIEYuCebogjGJPJRcp5gbjvxNVa6eMwRU9jCPsPUu
 CeukOv5WRX3JDd/HNVtwhNWIUOxOPO9icyjLbpiThGJ+fiJxtrHPYTtjM1bQmbb3mW31AtQXjrV
 IFIiNIjUtS/rcIsE8iIQ==
X-Received: by 2002:a17:903:1ab0:b0:2b2:5503:1ba0 with SMTP id
 d9443c01a7336-2b28182c321mr272849565ad.5.1775715999784; 
 Wed, 08 Apr 2026 23:26:39 -0700 (PDT)
X-Received: by 2002:a17:903:1ab0:b0:2b2:5503:1ba0 with SMTP id
 d9443c01a7336-2b28182c321mr272849305ad.5.1775715999314; 
 Wed, 08 Apr 2026 23:26:39 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749cbd4dsm220786795ad.76.2026.04.08.23.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 23:26:39 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, Jianping Li <jianping.li@oss.qualcomm.com>
Subject: [PATCH v4 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Date: Thu,  9 Apr 2026 14:26:16 +0800
Message-Id: <20260409062617.1182-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
References: <20260409062617.1182-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cfPiaHDM c=1 sm=1 tr=0 ts=69d746a0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=4k61BgtcDmjeHYH7visA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: S1GBd8NnCTntH6Pt_dQyhnUuQmc8cmSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NSBTYWx0ZWRfX+SHd//5FFHhJ
 MiybfTOkEaa1O0I9PBWlbXnOeM63IwnCiHNUacvKQ1Cvet+nQlpqr8oMXOjXRQbevLhjJThg92I
 IZl+6PzI2B615Z8kDxd5U85rLyriqb5wM2Or32e0PYRU8vtMg+2olFPbAG5cjknz6IfLUyJTC2/
 kO44A0Bn2MekjIQODEP8kPo5sqorMJbsSjLcNkB2212THrDrvlBb9u+yn+pt04fMG6j9jS00zIj
 +KX1NsSi0KmRSqCRLLyqfwKjJ5fLAnN4eeUSescjKw87nvhf/ixfOWAjz8MCZ3QLilj5pAx2YsX
 uuWPvmp742AOuS3JwKuMb2YZOX2AQja/zQPiaXer7LPu9MYGF4rz4l/AFEvHSDmjZ8TB0vG3dpt
 49DxUtl/CQTV5k/yOAUusszK3JdWWQb5nEp8QrcrVV+ObWA5wy27ASG3r+SSVZd6LjHsoVIyelQ
 OUiKtOdDRoZARv65Ipg==
X-Proofpoint-GUID: S1GBd8NnCTntH6Pt_dQyhnUuQmc8cmSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090055
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

Allocating and freeing Audio PD memory from userspace is unsafe because
the kernel cannot reliably determine when the DSP has finished using the
memory. Userspace may free buffers while they are still in use by the DSP,
and remote free requests cannot be safely trusted.

Allocate the entire Audio PD reserved-memory region upfront during rpmsg
probe and tie its lifetime to the rpmsg channel. This avoids userspace-
controlled alloc/free and ensures memory is reclaimed only when the DSP
shuts down.

Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 104 +++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 148085c3b61a..a67ae991c0b0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	/* Flag if audio PD init mem was allocated */
+	bool audio_init_mem;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
@@ -1295,15 +1297,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
 	char *name;
 	int err;
-	bool scm_done = false;
 	struct {
 		int client_id;
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
 	u32 sc;
+	unsigned long flags;
 
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
@@ -1327,31 +1330,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	inbuf.client_id = fl->client_id;
 	inbuf.namelen = init.namelen;
 	inbuf.pageslen = 0;
-	if (!fl->cctx->remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
-						&fl->cctx->remote_heap);
-		if (err)
-			goto err_name;
-
-		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
-		if (fl->cctx->vmcount) {
-			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
-							(u64)fl->cctx->remote_heap->size,
-							&src_perms,
-							fl->cctx->vmperms, fl->cctx->vmcount);
-			if (err) {
-				dev_err(fl->sctx->dev,
-					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
-					&fl->cctx->remote_heap->dma_addr,
-					fl->cctx->remote_heap->size, err);
-				goto err_map;
-			}
-			scm_done = true;
-			inbuf.pageslen = 1;
-		}
-	}
 
 	fl->pd = USER_PD;
 
@@ -1363,8 +1341,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->dma_addr;
-	pages[0].size = fl->cctx->remote_heap->size;
+	spin_lock_irqsave(&cctx->lock, flags);
+	if (!fl->cctx->audio_init_mem) {
+		if (!fl->cctx->remote_heap ||
+		    !fl->cctx->remote_heap->dma_addr ||
+		    !fl->cctx->remote_heap->size) {
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			err = -ENOMEM;
+			goto err;
+		}
+
+		pages[0].addr = fl->cctx->remote_heap->dma_addr;
+		pages[0].size = fl->cctx->remote_heap->size;
+		fl->cctx->audio_init_mem = true;
+		inbuf.pageslen = 1;
+	} else {
+		pages[0].addr = 0;
+		pages[0].size = 0;
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1382,26 +1377,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount && scm_done) {
-		u64 src_perms = 0;
-		struct qcom_scm_vmperm dst_perms;
-		u32 i;
-
-		for (i = 0; i < fl->cctx->vmcount; i++)
-			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
-
-		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
-		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
-						(u64)fl->cctx->remote_heap->size,
-						&src_perms, &dst_perms, 1);
-		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
-				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
-	}
-err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
-err_name:
+	fl->cctx->audio_init_mem = false;
 	kfree(name);
 err:
 	kfree(args);
@@ -2390,7 +2366,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
 		struct resource res;
 		u64 src_perms;
 
@@ -2402,6 +2378,15 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 				    data->vmperms, data->vmcount);
 		}
 
+		if (domain_id == ADSP_DOMAIN_ID) {
+			data->remote_heap =
+				kzalloc_obj(*data->remote_heap, GFP_KERNEL);
+			if (!data->remote_heap)
+				return -ENOMEM;
+
+			data->remote_heap->dma_addr = res.start;
+			data->remote_heap->size = resource_size(&res);
+		}
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2482,6 +2467,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2499,8 +2485,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap && cctx->vmcount) {
+		if (cctx->vmcount) {
+			u64 src_perms = 0;
+			struct qcom_scm_vmperm dst_perms;
+
+			for (u32 i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+			err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
+						  cctx->remote_heap->size,
+						  &src_perms, &dst_perms, 1);
+			if (!err)
+				fastrpc_buf_free(cctx->remote_heap);
+		}
+	}
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.43.0

