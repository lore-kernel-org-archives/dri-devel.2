Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37020CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 12:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32F410F517;
	Fri, 15 May 2026 12:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kfPEuxtb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HmkE0QuZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F7B10F517
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBgtRt3197651
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=f+pEnlL/Dwk
 yKv8LqyGHXztzvJ/4aDMHJNFY2G154uM=; b=kfPEuxtbkcMaRh4yvf02rxab1IK
 y+4xxLhLCMVF/XownSzBhds5T8r8YxtR7oGVe0PKvvNWddNWteeLEysKG0/RQyGV
 EN9rnZvvZ/rFYUUAWW2Ve5FMTDF5jNW5ZBCEREbFAA3lkRU0JnsftR5OTkD7iGyN
 kAdNZImLzmSpTYe2JpJtxhvOue99ZRgGuR4LuPsePFON7J/o4+1C2m5zpz9o5x8Y
 WucIaNnqQzC82fHxt7sAcyVpeyeEHkJor3MLTUzeF7yDfJKyipwhCsvCjDFPZhvM
 pGQOXacTiy2EtXjKOF/zOFgNYRXG/gDhlEvFhbVO/QsPKGxL0roD0Ggv3rw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1qb8r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 12:42:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9a3c3c4eeso98588835ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778848972; x=1779453772;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f+pEnlL/DwkyKv8LqyGHXztzvJ/4aDMHJNFY2G154uM=;
 b=HmkE0QuZ0yYlhhVi8Dm3B+Oi60LRO9qpmDYKc88OQ/T67R+TVHB1j81OFHMoRYoVGV
 Zv0NvJDfW0kZkSv8U+TL6TkNDpQfJd9f1NrSUfDTI/DoxdFIfcEMoYlgt74DMDmE4+En
 Nxp0Rg7RwagNKKtPhotL8UwRVPlvNQF3VvlipgRLUB6tTVti/0QYLfcWYxfB1kQYFdvZ
 VfB5HiBXgDfKPFmOXPjcgvttyu9j2FAGafvFEJWixn/8a5d+y2w5UMVYE+rs6JRTZomK
 pJ+C9yUU1r5e5sFeTTN3p/qQiRXREVJIEeaTytfzI+oXHWFUt+CfueUnda/2qJqIYi9e
 N0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778848972; x=1779453772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f+pEnlL/DwkyKv8LqyGHXztzvJ/4aDMHJNFY2G154uM=;
 b=kB4G9V4ICPgZMqM8+mUjpnw/WH2i+bzoKlLq6COy79vWyAWNvUZgRNFiGj3cgQTRI0
 vAP01Xz0If8M8NqE9Y7TRAEbpUZR3b606uc4Q0bHGmczfIYRsV7T5awFFIsMAGhnwbN6
 cMvdgizvKY41ULISU4g3RN0zIAZzG0H4deE6kCxBJTw7sSa2lDT675RaQQcgijy8U8Gv
 9Bqws1NMD24OZA1vNOEm2yBT3Z3pSithP4uPkNQJAT9s4AseHipvhf2igALyEmATBlQT
 FE2RF+L7HRBC/Lf+kjknGJCiMDFBDv7DxzjGtX1EJui6MN7K6wU2+wFTWRyqMYtGvGqd
 nZ1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9C2E8jNDcEZjOU2XI/OX9OtyryyQozVdE+NpREOeKULwl+68AcEesCZf80DSyApFYuMgyN+fad2qE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzH7ZbcbcZFLzvbkmPgMMP9m544VxIGRKFW2BuwYpxevLyzsjjE
 40iXCC3ocH4NgFpzn0y9WeKCe7XGPX9F+e5ZrT99k7R4tLPqDjCIFAK3oH7KhSfwrGVjbIrjI0j
 FH4LaxOkxm6g5a9hOXuoPZRyiyBkyc29LSfi6sctbHLWfvjE0pI21xdCGaxkkwTa8nEFMITTwij
 yeIN/AEQ==
X-Gm-Gg: Acq92OFvz7wXeF5oYzz/KgM555UtDil5Q+w44yUDSSY+ywBAKm1o7sEucHeIya7eU+/
 DV2Y2BkzJ5ZPc3MBIFHJ/9wkNCE/HbV2Ra9Xsro/YtjOpudl/Nm4u6IK9+peuwzYELVfKPLF3L/
 tD+ASCYnR7jyH7nLl+rmK/AlgkgWFcJJvnh2P2rEGfC6QtCWPIcE5f11FQHH2F3JSbPI3+xCpIy
 NriAEcXkfeosZqll4IQhd7MXcB+coyx+su/VPmtJMOKeKGJDcdLePiZplt8tLyg9jrMnrCFgl0N
 94p9SVNrSzU52L1OT+QOO/7m4EGalvP0C9ciEFQcxmOQJhAc/SVW32K56SdiuPkA+Ap4wADAt0Y
 5ilFTORdy5qvV0OYK6YlmEQruoqTvLRLTCuadefg4wa35NklMBcQmZCafBUqFBA2ia09vZiD/37
 zLP2ggpA17j5gOe3qEbiw=
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id
 d9443c01a7336-2bd7e9e263emr43094595ad.40.1778848972246; 
 Fri, 15 May 2026 05:42:52 -0700 (PDT)
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id
 d9443c01a7336-2bd7e9e263emr43094215ad.40.1778848971640; 
 Fri, 15 May 2026 05:42:51 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm56119395ad.25.2026.05.15.05.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 05:42:51 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez-ortiz@linaro.org
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com
Subject: [PATCH v5 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Date: Fri, 15 May 2026 20:42:16 +0800
Message-Id: <20260515124217.20723-5-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
References: <20260515124217.20723-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XmCc5K0da5pRxBXnjxStvhCwXl24Tqds
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a0714cd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=vXPY0jRleWu_0xqwLycA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyOSBTYWx0ZWRfX8uIlZSjzzPic
 W+71H9Ehh2rl9kmvNDDNnoqPiT1Tu1blDqnAmCRm1HepPNXuTOvO2hTargcjyZvkNQmiPsONOOr
 rvTg2YDUj39135jzuWqxiy3NmgSvY7EYBkuYI/vGfy2Dz86VuagW4yjUvIGKwWQP1MPW6GOIP5a
 SuXEkJ9kqpxKt91KqA3cPTtNrKm5vteeQSnND/KS+2bmw+hRyt6OXWYBQI2PTs+e/FcU2yRm+KH
 KSNyhms9s+z3kVc+1zbtmEhA7oph5FwszJzu53tvoxiRlqJLubCkZN0LzR6CrgdlFM6lCAeBSoP
 9yR5NystzkoWQ8bIYzT8mBKl2Lx+Msa0FV9Qb4DUP/kuCMykXGxtpSkkX8vlqTK1tQG1LV/jePz
 mkbAKwfbGhSaQL0xqs2EwSHz/MLaKB5c58mwpBMPtgZmT7/kmGzsQy0RQh4Sh8r4oyz2MDYH7sM
 cSQNYJyMOZ+6XtCC8xA==
X-Proofpoint-ORIG-GUID: XmCc5K0da5pRxBXnjxStvhCwXl24Tqds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
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
 drivers/misc/fastrpc.c | 107 +++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 58 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a0337cce77f3..9c70788afa0f 100644
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
 
@@ -1363,14 +1341,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	if (!fl->cctx->remote_heap ||
-	    !fl->cctx->remote_heap->dma_addr ||
-	    !fl->cctx->remote_heap->size) {
-		err = -ENOMEM;
-		goto err;
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
 	}
-	pages[0].addr = fl->cctx->remote_heap->dma_addr;
-	pages[0].size = fl->cctx->remote_heap->size;
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1388,27 +1376,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
@@ -2397,12 +2365,21 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
@@ -2410,7 +2387,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2491,6 +2467,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2508,8 +2485,22 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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

