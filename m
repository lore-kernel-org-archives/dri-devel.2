Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFDBC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F5E10E8F4;
	Mon, 29 Jun 2026 14:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="y7JvbR+d";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA5910E8EF
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:01:55 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAXncK2986140; Mon, 29 Jun 2026 15:01:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=eFp27M8+rXe5/a3IsDbFTZu
 7Igo65FkD3sgjW5yJiPw=; b=y7JvbR+dmMNKdIE4/Kll3fmPrmLybzTK9amNIv5
 ERRqtXQ96eh7nywoqVY4e98dWn7mpiZLx6O8i+OE/fDkom82MZQsmFHryOIjsOCG
 fvrdgF7NnQSQXl4BM7wy5nhtgedjwTfxSLkoiYgc4O+BMoSE4ilTsKmoYdnHsR7V
 pRdqpenE7Ky05icDreQ3MtKzm1f6F75MWJXT4ZF0oftz2OKiElWjY87mKNs8yxfv
 BFkDgbVHjmLCP/P8XNZ19JnNpN7q0yAzUoywbwDaP9ChdkQ+BBFGRMGqmzic2mDw
 f52Z+tI0C6yah9UMch1B5Ii3Uc1Q0Qt1mE6xudgBxwfcciw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4f24snss7e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 15:01:35 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 29 Jun
 2026 15:01:32 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Mon, 29 Jun 2026 19:31:25 +0530
Subject: [PATCH] drm/imagination: Fix returned size for DRM_IOCTL_PVR_DEV_QUERY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260629-b4-b4-query-v1-1-d17fe10b32c4@imgtec.com>
X-B4-Tracking: v=1; b=H4sIALR6QmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyNL3SQTECosTS2q1E1KSzazSDZKNk1OTVMC6igoSk3LrACbFh1bWws
 AOYonvV0AAAA=
To: Frank Binns <frank.binns@imgtec.com>, Alessio Belle
 <alessio.belle@imgtec.com>, Alexandru Dadu <Alexandru.Dadu@imgtec.com>,
 "Luigi Santivetti" <Luigi.Santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782741692; l=2413;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=E8MT69zAw5TGjKNhh02c+TERKSB02PUSC/tl6nKfm4U=;
 b=mYwgpH/kso1zwqdO/ToCGJyFRthUUexaF/5piez2fgF7sXGWai+vzqIceJhupXC9YdT8QSWga
 rx+7NSzJOopCachciALx5dc7NvnyzbLN75A58fC6kms+G5pd3uAQM/T
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNiBTYWx0ZWRfX6aXjrRDzQGVE
 rpCs1HowPl23UR9zED3aTPH/v3rDLYN6xvWg5PNPPs2RfUFOGhuz2ZQas/ZaBv5fuSb/wSvrbP9
 6EBVVvd/5PGVkJn7Ox/sVvBPmSehj7U=
X-Authority-Analysis: v=2.4 cv=We48rUhX c=1 sm=1 tr=0 ts=6a427abf cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=zSf4H7TkD-6S84OFmusA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: bzFL9VRcZrBKQfaEPaFOvRfs-kJpXyVO
X-Proofpoint-GUID: bzFL9VRcZrBKQfaEPaFOvRfs-kJpXyVO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNiBTYWx0ZWRfX7PcNpHAm84+Y
 4aPZQA2D+J9vGLuwXuJxQ35RAp1Eq1M5MeqqLmR2NqEC5vCdnNaSW24ADRHAotVAyKfFM7e1wnP
 ejOyB4dpAdE6FVjbNFz2woZXMT3nX+1x2WtlnqJ67e7UOV666vaMQLELNmJ+WgDe4aoFlswOBmg
 yg3LK6oNYEfWOMTNoVRe7k8ZJBNVLTQfB4UC5bntJTefFvKk0OcUYrTmZGjWB2mtr78ypkF2eeK
 KsM0HHxRvVORAaHV3JKIosxxFILdH/abtcZlAsDpf+ZZcRj+CH8A2ncTP6MvaGFFKjsNIJebpHP
 CHgZ9i8N9Voof5OuqDrGrhaL32GeUEU0GngGqFi0Axk7bkHepLv2v1Wev5oecX5Ab2uieLgQMeZ
 ZDZItvxwybndrkh5VGEBDrjKkArFcWa5Aj6M/5AFMakuPf68S3xAt/LhHOh/111/QMX+NgBJMQl
 aWBBehBT7x4/meFp4mQ==
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

For a few subtypes of DRM_IOCTL_PVR_DEV_QUERY, driver was overriding
the returned size unconditionally. This would have resulted in
increase of reported size beyond the amount of data returned to
userspace when args->size < size of query structure.
Updated behaviour matches with the description of
drm_pvr_ioctl_dev_query_args.size and written byte length.
None of the structues of DRM_IOCTL_PVR_DEV_QUERY changed after addition,
so change will not break any compatibility with earlier version.

Fixes: f99f5f3ea7ef ("drm/imagination: Add GPU ID parsing and firmware loading")
Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 6 ++++--
 drivers/gpu/drm/imagination/pvr_vm.c  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index ca3042d14253..ee86c74df0d7 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -515,7 +515,8 @@ pvr_dev_query_quirks_get(struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
@@ -596,7 +597,8 @@ pvr_dev_query_enhancements_get(struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index e1ec60f34b6e..396d349fb6ce 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -1019,7 +1019,8 @@ pvr_static_data_areas_get(const struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 
@@ -1069,7 +1070,8 @@ pvr_heap_info_get(const struct pvr_device *pvr_dev,
 	if (err < 0)
 		return err;
 
-	args->size = sizeof(query);
+	if (args->size > sizeof(query))
+		args->size = sizeof(query);
 	return 0;
 }
 

---
base-commit: 60dc0946bbad3eef8bc66a5a8b09b98dbc6e09c0
change-id: 20260629-b4-b4-query-bfc68c2c5cef

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

