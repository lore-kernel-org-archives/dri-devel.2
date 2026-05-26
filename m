Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A15CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 11:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2F710E61E;
	Tue, 26 May 2026 11:12:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJBbWzLW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LvALr1eB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790CB10E61C
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64Q6dkaq3263531
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VhYbVLEP74Y
 0H1uCZ5BG5cAHB/9WIR0BIz6pt5j6WzM=; b=EJBbWzLWaqxe+JQct1UrsjZIufP
 6JZkeWQVxdln6F+30j60S7EZHsQPJZ3kbl2Xzk4LVVmQuoYttqvPdcghmlgmKHJf
 DiuUPNY0RUycuMhMPfrJDhXEu6DP9LB9S6mElzGRWXnG+tBSVpfnZB1JT+tY9fex
 zR1GRhC4oIg0vKh+gZugmJdK+JouGdM4U5WCnegAPQ7tq1xPq+lYlE2BzbEoF3pt
 KtTRgJkAajEM1qP3L9ofkZlIyVWb58TNXkeF/S/mQytD0RmDkmkye442jDUgSomF
 HxZu95BaVoJf6vC1G2aoWctKZeQsyXikQe/wT3Ow2Sg1w5dv/cdpwXLicNw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs440a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 11:12:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365ff2ab7beso11202132a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779793920; x=1780398720;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhYbVLEP74Y0H1uCZ5BG5cAHB/9WIR0BIz6pt5j6WzM=;
 b=LvALr1eBAky4opatg2slvSHt0crdGfGdUhRpfmc1f3Wt3P9mSox8X2W51NIYeiB+LS
 5LvoYUkJqV8AgoyVvFH4/1K3kFJIIcCNtbgPHCmBSXIF2YNlwqr3i2MjM5KhsWhgKBCf
 PZfglplZh+oVlY8ahj65Etu98BvKZlSUUyg163iyuNugdMOxZmDrk6bwN4R36vIb3GCo
 SdHexPD+4C67b6+JrGbIN7RnC5ADXYMotzMaWl/KDi/DZ70h3s0BCtnESdHnU2xRC39R
 ZsIG46j+uFO5uRD9uATILf975+7znMQBmqE/Cw1D+1R/H9Xx9P9slyC5hf3ZeO3NYqEz
 1Xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793920; x=1780398720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VhYbVLEP74Y0H1uCZ5BG5cAHB/9WIR0BIz6pt5j6WzM=;
 b=IvcW2P9ID/3NR25/wbwtpS7JZYy4EQpAQ5voqAe/CGkzDTHsWTQlgaav6L6BToobir
 TYpdBcNI6OOqO4UljKBK6ZwlJAXY22G62oLX4jqKRpqRL0JzLK9IrstvnKoV2bGOZkF5
 aksDNj6iSmJuVJCp8ELMsBJxNSgvAXAsBIeAHb6ImGBRb5CCCyrc0m/HLKyGeHsXnSLT
 sULR9+a8UCGPvjFffuUBF3y1EdN2rWpTwAiNu31/hL0OBFyKN0iB56hnp7+i3cRxZfNj
 mR+2eARJ6wxpLsZ7/VklgaUgH+4Z5cNGuFkWM3HqTLwC+kSv7FkifrAQhP9NE85mh0h7
 GUXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LW3iQ9Bx/mFFI8nqiWiJuMhv6zjGvJODZ92kzXKoomW0ZjmeqEP0fOYj8g5/TfTzuG8aLul2iy6k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZvCnTc0Xeb6W/IVTWHZlfFQOXS/u/q6maUoDpgPO7ZOD+rvHK
 KiEYceRq8J0rrlumM8veyLB6pb1H6kqsXq7OJQzioCxyB9SR7OfHh8B5TnaapyrC06qRJ4dSrjs
 XTEMYSucOrfI0bjAVO62PYjsKOR/dRgEQjIjNSz6UA4uVBe8IFmSZgCTDa2AeHG1NpsSPly0=
X-Gm-Gg: Acq92OHSgG/rTxIqhlTNneWk/D7WBp5H7SN2BUlV3PhHO90RRKWJzmEMd+Du9xzEBDr
 rBUkH8WPxLXWGEOwmbd5Ast9etNz7coAAKotEaCQ+yq4cXZHnZfz7Nz0iFSEtRHk8AY3Yn/NgPW
 q2ymLCxJAZj3ILv/6ozpZWLeC5fH7kyF68iFUqKFwkzmsVdy6qgo/bgAOYh4ehAcji2TZqXm4b1
 3jml7G6v7mFUM6JjeLX/c0Y/qUOLrvEkP05QQzCJl4FgTQ6MHdvvp+tS03Fn6GqwDJqFrItnpuj
 8pAMiOCYcWbmGg93BWHqVcSc8bLETlLUxKKa6Zltajn/EPxE6zQMkR8hLtjrGLLZOAfVRHeeqqv
 rVw/GNmJ7time480Y/OzwhueMitPr9+ACmaMwzICOJ4YV+nVyIW7aLEwTVx2F482HkessQt4gMV
 MMZGnH3W5qtSA/wjDTgQ==
X-Received: by 2002:a17:90b:2712:b0:35f:b9f1:fded with SMTP id
 98e67ed59e1d1-36a6c79dd38mr13454545a91.12.1779793918500; 
 Tue, 26 May 2026 04:11:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2712:b0:35f:b9f1:fded with SMTP id
 98e67ed59e1d1-36a6c79dd38mr13454520a91.12.1779793917996; 
 Tue, 26 May 2026 04:11:57 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a72c4ce6bsm12104253a91.11.2026.05.26.04.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:11:57 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v6 4/5] imisc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Date: Tue, 26 May 2026 19:11:23 +0800
Message-Id: <20260526111124.515-5-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
References: <20260526111124.515-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a158001 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vXPY0jRleWu_0xqwLycA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: gYpobpgFvguX7O_CDPUtWB1iBeH2fTCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX4AafbgLmjwz8
 ml3BcFhepz7TIIM37Yg33fiLKjZ8j1BMrtfxIZf2T3UQQtoM/b1gZFH2oEsFvmuILKs+IJq0zs1
 LjJaLu9oeM3KEiw2+jBI32gSPEb+nRAoKMztokSZisZgkW12qL5UjNGXDN1PLQU0IWzXkSWRXQB
 zXXCsfajzTlbv4e8wqqfxSWc6POrVjWKVTsmIOiQcMxtvfcryUBbzyXm5A1B0wYnTEpmTBhKMZJ
 yKylzdjG2WzdS+in9s9RqRt3qLwX0U+R4I6DN/nCWAJG7vnY36PEZTgv0/PuAQWuBoduOFOiNs3
 Y90I3BODfoBgpxpVv5jPLhrFoYcBvTiEpKhczR4ke2XnCzCIOgEVv637E3Ch8VIgYnA3t7cUS6M
 xt7rYXaFyUKpvRsIagq1d8YqmgLzXJCOta6Z/9hkai+9U6mqorsUmI4Biv0FW9Y7TtT7e7pGJWI
 vn4fY5ls3LwHhkDtNZw==
X-Proofpoint-ORIG-GUID: gYpobpgFvguX7O_CDPUtWB1iBeH2fTCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260097
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

Additionally, the current implementation allows userspace to repeatedly
grow the Audio PD heap, but does not support shrinking it. This can lead
to unbounded memory usage over time, effectively causing a memory leak.

Fix this by allocating the entire Audio PD reserved-memory region during
rpmsg probe and tying its lifetime to the rpmsg channel. This removes
userspace-controlled alloc/free and ensures that memory is reclaimed only
when the DSP process is torn down.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 103 ++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f46a8f53970d..0208208c2d27 100644
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
@@ -1344,15 +1346,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
 	if (!fl->cctx->remote_heap ||
 	    !fl->cctx->remote_heap->dma_addr ||
@@ -1383,31 +1386,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1419,8 +1397,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
@@ -1438,27 +1432,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
-	fl->cctx->remote_heap = NULL;
-err_name:
+	fl->cctx->audio_init_mem = false;
 	kfree(name);
 err:
 	kfree(args);
@@ -2425,12 +2399,21 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
 		struct resource res;
 		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
 		if (!err) {
+			if (domain_id == ADSP_DOMAIN_ID) {
+				data->remote_heap =
+					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
+				if (!data->remote_heap)
+					return -ENOMEM;
+
+				data->remote_heap->dma_addr = res.start;
+				data->remote_heap->size = resource_size(&res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
@@ -2438,7 +2421,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2519,6 +2501,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2536,8 +2519,22 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap && cctx->vmcount) {
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+
+		for (u32 i = 0; i < cctx->vmcount; i++)
+			src_perms |= BIT(cctx->vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
+					  cctx->remote_heap->size, &src_perms,
+					  &dst_perms, 1);
+		if (!err)
+			kfree(cctx->remote_heap);
+	}
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.43.0

