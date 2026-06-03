Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB87CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6467811242C;
	Wed,  3 Jun 2026 22:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bygzsrX9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D262211242C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QoJc306BFIQ93zHnQZS7LmfUVtaFrpnzIHQMluzpLSU=; b=bygzsrX9BXMG7uN8cHpre/c567
 bVwlJcSbmncsEyos2YqfAGzzyWy3HZFOAyrWPfBc64NmRY16BfejNow+XVgKmlbKK9iacxVJg6VtP
 lfoaViWzbw6ELCAVu8aQvHUBlKAMXI06s1eIolqYtfIMz+G/7KOkWZUPsaNruYi72uFRbqmtlt+kC
 ST0VzYKDwx4DkHhALnx480/XDhr4byziOs3J8Wv8hNUBS1+kMnC1Ik3jX9R0z8d3CkWNrwTNvn4cX
 q0thlQZ5nMmZK2Z4BnBtQcjwP++xQeso/Kt+e+WhsfazIC4vSO632bADLOMkmhw1y3Ps69hQXdccO
 EUSfOR7w==;
Received: from [189.7.87.67] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wUu25-00CNgx-Ew; Thu, 04 Jun 2026 00:25:53 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Wed, 03 Jun 2026 19:25:11 -0300
Subject: [PATCH v3 09/14] drm/v3d: Make v3d_get_cpu_indirect_csd_params() a
 pure parser
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260603-v3d-sched-misc-fixes-v3-9-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-0-d7114bba55a0@igalia.com>
To: Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3020; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=EdYntO1aPdLJjQZun0b2hyrRZKnu2Jflwnm3s81NHvo=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBqIKnGSMxEnqDXekyoczhA12gUEP6tVN0L2Mc1E
 yb6oJTil9mJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCaiCpxgAKCRA/8w6Kdoj6
 qtn5CADMAT4XIEg0zeKx9hHmxFMXHHfVN6dNSYJTHWWw0iWfRlBaiPK9o1frhAs1+8E8Ll4hWdI
 gR2Pox8vE464kMD8uRnrohbCsEUyFbxUlFXeVq8dX0dtxvBJGvrDLILFkiVbmJlO056hufeYA5z
 v+QY4hTBeVkrRgA2QTqEyqFe6NWPKCPcRRkk/B6BrGGrMcz14RWFXtSgyfBG0srtFHoU7m9j0Fm
 Yi9vV9LSRGvgbZj+pL5rkOIoPa4xsVBaTzvWQ0xFJiIPwkedgUgUCGgGK/nXHURiC0ivtMBj4bc
 KFwdb0ZH/ZHkY82EENp9LPvJaxHfKw1jvfqwXlXytP83hCRF
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

v3d_get_cpu_indirect_csd_params() currently does double duty: it parses
the indirect CSD extension and, while still inside the extension parser,
also creates the CSD/clean jobs and locks their BOs through a separate
DRM exec context. This nested submission deviates from the standard flow
and makes it hard to fold the indirect CSD path into the unified submit
chain.

Stash the parsed drm_v3d_submit_csd args in struct v3d_indirect_csd_info
and have the parser only fill in the parameters. Then, move job creation
(v3d_setup_csd_jobs_and_bos()) into v3d_submit_cpu_ioctl(), where is the
proper place to create jobs.

No functional change, but prepares to move the CPU ioctl into the
unified submission chain.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/v3d/v3d_drv.h    |  5 +++++
 drivers/gpu/drm/v3d/v3d_submit.c | 16 +++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index fae0c53e7aa3..52ed0af67f5e 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -428,6 +428,11 @@ struct v3d_indirect_csd_info {
 	/* Clean cache job associated to the Indirect CSD job */
 	struct v3d_job *clean_job;
 
+	/* Indirect CSD args, stashed by the extension parser and later used
+	 * to create the CSD job from them.
+	 */
+	struct drm_v3d_submit_csd args;
+
 	/* Offset within the BO where the workgroup counts are stored */
 	u32 offset;
 
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index fcaf3a6cfddc..64eba912dc64 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -632,6 +632,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 	}
 
 	job->job_type = V3D_CPU_JOB_TYPE_INDIRECT_CSD;
+	info->args = indirect_csd.submit;
 	info->offset = indirect_csd.offset;
 	info->wg_size = indirect_csd.wg_size;
 	memcpy(&info->wg_uniform_offsets, &indirect_csd.wg_uniform_offsets,
@@ -639,9 +640,7 @@ v3d_get_cpu_indirect_csd_params(struct drm_file *file_priv,
 
 	info->indirect = drm_gem_object_lookup(file_priv, indirect_csd.indirect);
 
-	return v3d_setup_csd_jobs_and_bos(file_priv, v3d, &indirect_csd.submit,
-					  &info->job, &info->clean_job,
-					  NULL, &info->exec);
+	return 0;
 }
 
 /* Get data for the query timestamp job submission. */
@@ -1404,6 +1403,17 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 	}
 
+	if (cpu_job->job_type == V3D_CPU_JOB_TYPE_INDIRECT_CSD) {
+		ret = v3d_setup_csd_jobs_and_bos(file_priv, v3d,
+						 &cpu_job->indirect_csd.args,
+						 &cpu_job->indirect_csd.job,
+						 &cpu_job->indirect_csd.clean_job,
+						 NULL,
+						 &cpu_job->indirect_csd.exec);
+		if (ret)
+			goto fail;
+	}
+
 	clean_job = cpu_job->indirect_csd.clean_job;
 	csd_job = cpu_job->indirect_csd.job;
 

-- 
2.54.0

