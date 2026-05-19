Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658C6CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8DC10EB37;
	Tue, 19 May 2026 08:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="cohpLfuB";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8067610EB48
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:25:50 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J5F1UH3681371; Tue, 19 May 2026 09:25:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=d
 48Z1+56qdLVR0QbQZ4Tcoy+T60KNf224nK5Ij3hnNQ=; b=cohpLfuBMTJGizvaT
 cUbVkueARxQY/aiXfee2aqMnmgfI5OBGQtRy4CoWgCeRDUs0HSrFpVwnalQwXS12
 7No/0VTk6yq8fAK68rHEiwvuVEStvaz37bvskidaxk1tvGsdgm+udtodf4Ape85q
 SHEfCcc2338tgZM7n7YqzlGdgz2YW/VmiX6zcI5LUfi66/5QLs1rM9yT7hQSr2fV
 mZpRrQm52w7NO61nHYMaXKdaGvwcjoIy85vcR7ZDSi+4N3UkhVKhQgPwlyWVsa03
 0sv6kw6cOUhjlbGyM/AQa58594LmuEU2xXFTQjLBUQmFfArpqC0IhPTdD2skoq1K
 OIrJQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4e6gnsjda6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 May 2026 09:25:38 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:25:35 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Tue, 19 May 2026 13:55:26 +0530
Subject: [PATCH v2 1/4] drm/imagination: Populate FW common context ID
 before passing to the FW
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260519-b4-context_reset-v2-1-931018a7131d@imgtec.com>
References: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
In-Reply-To: <20260519-b4-context_reset-v2-0-931018a7131d@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779179132; l=2637;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=Ug2j5+k8G5dHLaFRl71m3gxLKZz7rkciSA4tYssbpl4=;
 b=pqFX/dojOMqQfJ4ugyIbXG/PKUAf07gxakFh/6GFqmm2jdcUrZbS4WPjwbPJ6VVNkCt9nDcai
 qVmEwOnc7cLBguDb7x3AmbvZ+1092STsGfAczgiSID765a+50k7s+gs
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-GUID: 91zetRwJNLpjJS6sE_oefdeBynJs_neT
X-Proofpoint-ORIG-GUID: 91zetRwJNLpjJS6sE_oefdeBynJs_neT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4MiBTYWx0ZWRfX86oMjyDG5p99
 vs0QxM9h3iMAme4+g/2TDJFe0opDd7bP/fD1CtugKpXNSv6y+wytHKG7ZJ74pcw/N8LFJ2q9yte
 0OgCrbWHFq/EHv+1oc8Um3Wb3RzNFjNJK0JFSoglB/MMt9LhfWETaU1teSFsS+maosxeGqgpr0w
 gAs0irXg6K9l9xr+TMtNlUEwH4VUHaIwyTwplAA+eC7qtuRIbKH/M40wULP43Fk2JloQQeyLzwG
 v2Devv9PUYQHlRh22r2J53Azwb0jpo2GOMv+4M4dvO4Kzh3IzrcM7dpN8rIuqq+4eV6cFfDLG3w
 JKacQ4fIaJnDOZhx2duTa5ixJAJKPlU+HjqzXLcla6kGFfBel7H8l4P7v9fQR7rnwYVS2KYCoYV
 1engcUlXID1q5kBcgKfaZhXOrQM2ko7NLndd1OMUkUpuEpzlc/32pbUyzFLVb8V+Th6GShhMRTe
 9q4yMqDIfpNLudPvPfA==
X-Authority-Analysis: v=2.4 cv=W9EIkxWk c=1 sm=1 tr=0 ts=6a0c1e82 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=UnyKJbn5usqPPbLJ8bkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

Initialise the context ID for the FW common context correctly by moving
the context allocation earlier.

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

