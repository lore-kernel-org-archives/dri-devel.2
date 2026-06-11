Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF02CD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00F010ECC7;
	Thu, 11 Jun 2026 05:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FB7h060F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A42310E714
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781157108; x=1812693108;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qulRGXrfJIQMmattq0CquhG48Z3xqRE6I6egcyZ8Ltg=;
 b=FB7h060Ftk4vRB60a+MQK7682w+6QP4I+ixx5QNBxlsWUMkQZ6IWXCw8
 FY/7IePQtZyY+Kr5IGx6hvRqfp8lv+d29imhPK5dBT7vYes0XmF/5LG1H
 YjjG+z0bwQ+baTNpyAfU+ZYF+QoSA4kAdQ+JMZnIr38o+6OpJs7IfFlVU
 +7Ukyhhg+wAmYVEa0q7oB5AKKgLgBSEN56YoupFKVKGrQ/VZD5jltd8nQ
 BEvfnOJvrigwMovcivL+fpxZ79lUortvXryHII0zNvJZdbHb4Edswe+Xa
 zARNfyb5+9PmFkQkLGw/PPmPamuizuwJLK2D31pYcuZDLEGpb1Yzz0aq1 A==;
X-CSE-ConnectionGUID: /YHXl9A6TA+HYsg1KeiTQQ==
X-CSE-MsgGUID: B0Ia85q6SPipeHlP9hDJtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81967361"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="81967361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 22:51:47 -0700
X-CSE-ConnectionGUID: POWRQkvDSfaLkllWUcx+Xg==
X-CSE-MsgGUID: +rQB2JzmR9mPAeyxleOnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; d="scan'208";a="284468507"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 22:51:45 -0700
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH] accel/ivpu: fix HWS command queue leak on registration failure
Date: Thu, 11 Jun 2026 07:51:40 +0200
Message-ID: <20260611055140.948684-1-karol.wachowski@linux.intel.com>
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

A command queue is considered valid and usable by the driver only when
it has a doorbell ID assigned (db_id != 0), meaning both the FW cmdq
creation and doorbell registration completed successfully.

However, when either ivpu_register_db() or set_context_sched_properties()
fails after ivpu_hws_cmdq_init() has already created the cmdq in FW,
the command queue is left registered in FW while the driver treats it as
uninitialized (db_id remains 0). On the next submission attempt the
driver tries to register the same cmdq again, which fails because FW
already has an entry for it.

Fix by calling ivpu_jsm_hws_destroy_cmdq() on error paths to properly
unwind FW state and allow subsequent registration attempts to succeed.

Fixes: 0c7c13186866 ("accel/ivpu: Add API for command queue create/destroy/submit")
Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_job.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 521931d1f7fc..b24f31a8b567 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -208,9 +208,9 @@ static int ivpu_hws_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq
 	ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv->ctx.id, cmdq->id,
 							priority);
 	if (ret)
-		return ret;
+		ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
 
-	return 0;
+	return ret;
 }
 
 static int ivpu_register_db(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
@@ -281,10 +281,10 @@ static int ivpu_cmdq_register(struct ivpu_file_priv *file_priv, struct ivpu_cmdq
 	}
 
 	ret = ivpu_register_db(file_priv, cmdq);
-	if (ret)
-		return ret;
+	if (ret && vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
+		ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
 
-	return 0;
+	return ret;
 }
 
 static int ivpu_cmdq_unregister(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq)
-- 
2.43.0

