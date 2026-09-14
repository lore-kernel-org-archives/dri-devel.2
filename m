Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA25C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329BA10EBF2;
	Mon, 14 Sep 2026 08:29:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gAzImDQW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E53010EBF2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789374576; x=1820910576;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hKg4PCGNk2wNrs9Knlb1B//IiEEyN66Ryxo2nxVNhkE=;
 b=gAzImDQWnjeKPVrYiQvFjVweGbTjZ0M16fV1Xk9MwPDxrFe9fHOzF5C/
 9AHZjmUubJQSkW3HztIoO4Y15tRdmARRA25Nbz5patnOnku49+laLlifb
 i9bLZKYdh7i6DoHjd//DbuhY2W7Hlj1gE6dzcFe8PVlH+qW4qy4XnavOi
 aAsqjpPmsvihgV0+KhVvcIxLSeZeO6oKBzEneew2AtnLt2DkbyAb4o+gE
 edXWRp9sNAroorX8aqlFTkqfYESD2J8vAxdnGG2ba18fs9j9+nRciPbsb
 8VURVoUcqHTaUviazsQEaZE+57VA1QWdXwDiaQnkLwW4FDFcH4wmuVqUy A==;
X-CSE-ConnectionGUID: JwQ8RiMTTbO24JmePR1Kag==
X-CSE-MsgGUID: dbWxe2aLRfyY69iQAmk9Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89486791"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89486791"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:29:36 -0700
X-CSE-ConnectionGUID: w9d8rWPYRPmcjLYh6BRrRg==
X-CSE-MsgGUID: 1Er2Mk6FT+allFu7gZYrJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="296074011"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 01:29:34 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: Abort pending jobs on file close
Date: Mon, 14 Sep 2026 10:29:29 +0200
Message-ID: <20260914082929.892437-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Closing a file only dropped ivpu_postclose()'s own reference on
file_priv; the context and command queue teardown happened later in
file_priv_release(), once every in-flight job completed and dropped
its own reference. Since nothing explicitly canceled a context's
command queues or jobs on close, any job still in flight kept running
in the background after its owning process exited, until it completed
on its own or the device's own TDR intervened. Make ivpu_postclose()
explicitly abort the context's command queues and signal and destroy
all of its pending jobs via the new ivpu_context_abort_all_jobs().

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 11 +++++++++++
 drivers/accel/ivpu/ivpu_job.c | 11 +++++++++++
 drivers/accel/ivpu/ivpu_job.h |  1 +
 3 files changed, 23 insertions(+)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 647684219e9d..d7faabe0f676 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -393,6 +393,17 @@ static void ivpu_postclose(struct drm_device *dev, struct drm_file *file)
 	ivpu_dbg(vdev, FILE, "file_priv close: ctx %u process %s pid %d\n",
 		 file_priv->ctx.id, current->comm, task_pid_nr(current));
 
+	if (pm_runtime_get_if_active(vdev->drm.dev) > 0) {
+		mutex_lock(&file_priv->lock);
+		if (file_priv->bound && !file_priv->aborted)
+			ivpu_context_abort_locked(file_priv);
+		mutex_unlock(&file_priv->lock);
+
+		ivpu_context_abort_all_jobs(vdev, file_priv->ctx.id);
+
+		ivpu_rpm_put(vdev);
+	}
+
 	ivpu_ms_cleanup(file_priv);
 	ivpu_file_priv_put(&file_priv);
 }
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 084d825f744d..fa04f79e8f7b 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -725,6 +725,17 @@ void ivpu_cmdq_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id)
 	mutex_unlock(&vdev->submitted_jobs_lock);
 }
 
+void ivpu_context_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id)
+{
+	struct ivpu_job *job;
+	unsigned long id;
+
+	guard(mutex)(&vdev->submitted_jobs_lock);
+	xa_for_each(&vdev->submitted_jobs_xa, id, job)
+		if (job->file_priv->ctx.id == ctx_id)
+			ivpu_job_signal_and_destroy(vdev, id, DRM_IVPU_JOB_STATUS_ABORTED);
+}
+
 static int ivpu_job_submit(struct ivpu_job *job, u8 priority, u32 cmdq_id)
 {
 	struct ivpu_file_priv *file_priv = job->file_priv;
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index 6e32fea1eb62..f8b27e9a803f 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -89,6 +89,7 @@ void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv);
 void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv);
 void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev);
 void ivpu_cmdq_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id, u32 cmdq_id);
+void ivpu_context_abort_all_jobs(struct ivpu_device *vdev, u32 ctx_id);
 
 void ivpu_job_done_consumer_init(struct ivpu_device *vdev);
 void ivpu_job_done_consumer_fini(struct ivpu_device *vdev);
-- 
2.43.0

