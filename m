Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A286DCD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 06:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3D110E573;
	Tue, 12 May 2026 06:47:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="jYgpr3PU";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE9D10E594
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 06:47:41 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64C4K2Iv1827070; Tue, 12 May 2026 07:47:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=7
 r4lSz93Jahc7mymYkm/e5wHds9mtB/aKcyWFSFv66Y=; b=jYgpr3PUzRZm21VTa
 Y7cnoDfgxgV5HhZ61Tg5BVYhAuAPIdakoHO7QQTk6zFREwEZsXwZri7I2hnhpaOv
 Pj7sznLm6NiWOKgzWi9P9eAqA/qL7bcZYrLECOZD5grpgz932A0yyDRRwZfq8Ghh
 5Lm0QibUy7KSybL0OMB5n/0f6oPnSkw2K+G2NWjACsNtF8oqW6b9Yu8/C0zd6iAo
 fNcSY7NN64UqhIyZ/2lNwSWJ9WrlDfCJ0Obydgw2+psppyYWxTdUAWtcUVOsKIfD
 KYMBu6JSP5kmtKAi+rJWqppYgHnZ/83zHs5F3oB5tEqsjdCMxMLq4p8od3tvouUD
 ml1Tw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e1w0t2c68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2026 07:47:30 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 07:47:27 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 12 May 2026 12:17:03 +0530
Subject: [PATCH 1/4] drm/imagination: Populate FW common context ID before
 passing to the FW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260512-b4-context_reset-v1-1-439bee96ed83@imgtec.com>
References: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
In-Reply-To: <20260512-b4-context_reset-v1-0-439bee96ed83@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778568444; l=2666;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=sOpkAGJgQi0LjNU0RQ5KQdvIzvjthlVmDFrc8BC7oRw=;
 b=8m20PBvPQ0ClONjLlRAzbnAtfBTrfnNRWOAzvhMpV27ZTGoGmBWuGEXFVu+cveEmTEgBChZYh
 SC37KzlPVK0D0GAKeln+8nKrQ0m3cI01prsAp89cG7vDDikbiIa4lH8
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Authority-Analysis: v=2.4 cv=b/6CJNGx c=1 sm=1 tr=0 ts=6a02cd02 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=UnyKJbn5usqPPbLJ8bkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA2NCBTYWx0ZWRfX7sT30HUZqLlo
 6oEzVMUlEEhKzxeI5uGT42IwZLyNZDjafbi0gJHUR1xMk/sehJEBFvG2AnE5jEJ+j/hUZ/q4RJp
 3xok4Ftjxrpm/H32aCA8YRWHDqfUZj9aaoh/faej1ahQO2wBnSlHxf/2G2YSXV593geJj6M3XfE
 aipxdynkfnxCy9T74NBeoJ507NmfBO4vaGDEtLGUO1f1tR3CNlN5/uHgOyDyUJX+NkRe9s3aJx9
 n0DHNw1ulrGy+fk6rDxwqYu0B6PyOj7W5MacIOnJpBgObG6u2yBcYvWnG16seMcO1/EvXq75RC7
 mFk/0xuRYDAEwUBoRbKO3BhrQRYV7JNVNrPXG089LpK3IKyOssI60qCNsLQPnRoC8PVrNN9UMf/
 gxFpH9I7kKXNiOsknQ+zl5YrGe7wMXGal7IwjlGxey3cj8agL8vc31HO8m/ph5TtJfjop7tqMUH
 xazzR0oTy39yUR3qyJg==
X-Proofpoint-GUID: vL3TDsncLgi-aHafrAqagHvRyBycblku
X-Proofpoint-ORIG-GUID: vL3TDsncLgi-aHafrAqagHvRyBycblku
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

Fix context ID value for the FW common context by moving the context
allocation earlier.
Also an old incorrect comment was removed.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_context.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
index 8de70c30b9de..eba4694400b5 100644
--- a/drivers/gpu/drm/imagination/pvr_context.c
+++ b/drivers/gpu/drm/imagination/pvr_context.c
@@ -318,10 +318,14 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 		goto err_put_vm;
 	}
 
-	err = pvr_context_create_queues(ctx, args, ctx->data);
+	err = xa_alloc(&pvr_dev->ctx_ids, &ctx->ctx_id, ctx, xa_limit_32b, GFP_KERNEL);
 	if (err)
 		goto err_free_ctx_data;
 
+	err = pvr_context_create_queues(ctx, args, ctx->data);
+	if (err)
+		goto err_free_ctx_id;
+
 	err = init_fw_objs(ctx, args, ctx->data);
 	if (err)
 		goto err_destroy_queues;
@@ -329,23 +333,12 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 	err = pvr_fw_object_create(pvr_dev, ctx_size, PVR_BO_FW_FLAGS_DEVICE_UNCACHED,
 				   ctx_fw_data_init, ctx, &ctx->fw_obj);
 	if (err)
-		goto err_free_ctx_data;
+		goto err_destroy_queues;
 
-	err = xa_alloc(&pvr_dev->ctx_ids, &ctx->ctx_id, ctx, xa_limit_32b, GFP_KERNEL);
+	err = xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx, xa_limit_32b, GFP_KERNEL);
 	if (err)
 		goto err_destroy_fw_obj;
 
-	err = xa_alloc(&pvr_file->ctx_handles, &args->handle, ctx, xa_limit_32b, GFP_KERNEL);
-	if (err) {
-		/*
-		 * It's possible that another thread could have taken a reference on the context at
-		 * this point as it is in the ctx_ids xarray. Therefore instead of directly
-		 * destroying the context, drop a reference instead.
-		 */
-		pvr_context_put(ctx);
-		return err;
-	}
-
 	spin_lock(&pvr_dev->ctx_list_lock);
 	list_add_tail(&ctx->file_link, &pvr_file->contexts);
 	spin_unlock(&pvr_dev->ctx_list_lock);
@@ -358,6 +351,15 @@ int pvr_context_create(struct pvr_file *pvr_file, struct drm_pvr_ioctl_create_co
 err_destroy_queues:
 	pvr_context_destroy_queues(ctx);
 
+err_free_ctx_id:
+	/*
+	 * Ctx_id is not exposed to userspace and not visible yet within
+	 * the kernel/FW, plus a matching context handle (exposed to userspace)
+	 * hasn't been allocated yet, so it is safe to remove ctx_id
+	 * from the ctx_ids xarray.
+	 */
+	xa_erase(&pvr_dev->ctx_ids, ctx->ctx_id);
+
 err_free_ctx_data:
 	kfree(ctx->data);
 

-- 
2.43.0

