Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93990F43691
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C224E10EA35;
	Fri, 17 Apr 2026 10:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="p7SBiHC1";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 764F310EA34;
 Fri, 17 Apr 2026 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jv0b2JEOW9iBn3iWe6GzH0NQUfx7OxVSJdPJRTHu/TE=; b=p7SBiHC1/hNW/7lehUj7OIfUe7
 GcOP4REeMxB55OBUiMgezGIYjBKmBpbMHs/QnjOcxD1SmATHgtBj9YpolM6xC68ieINicKWNm+lI/
 /XLmZojZrNBHWHgNtmSEvGyrqZn5cPWPT8DuTTPZh/C4NabYaLQUXo6iprGz5f5I7o0d7HDfiM7bY
 FyvA24toGNRqUyNzvHdnEspNRhVp6+LdEiR+uMNRFokXtZRTT9HGCB6owd3x7tDPaePyasTRAexOz
 iErc6IFjySzTYzr5nKlrES8vJm6KMPmgHtslWXCqDlbVsiQOHdbvHYhMc0ol+vqn9LXtrHLGFbFAK
 7XRwSpog==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wDgaQ-00HPVR-4K; Fri, 17 Apr 2026 12:38:10 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, kernel-dev@igalia.com,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthew Brost <matthew.brost@intel.com>
Subject: [PATCH v8 28/29] drm/xe: Remove drm_sched_init_args->num_rqs usage
Date: Fri, 17 Apr 2026 11:37:43 +0100
Message-ID: <20260417103744.76020-29-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
References: <20260417103744.76020-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove member no longer used by the scheduler core.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_dep_scheduler.c | 1 -
 drivers/gpu/drm/xe/xe_execlist.c      | 1 -
 drivers/gpu/drm/xe/xe_gpu_scheduler.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.c b/drivers/gpu/drm/xe/xe_dep_scheduler.c
index 51d99fee9aa5..004aac8b89e6 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.c
@@ -78,7 +78,6 @@ xe_dep_scheduler_create(struct xe_device *xe,
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
 		.submit_wq = submit_wq,
-		.num_rqs = 1,
 		.credit_limit = job_limit,
 		.timeout = MAX_SCHEDULE_TIMEOUT,
 		.name = name,
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index 755a2bff5d7b..1f8d358e60fd 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -337,7 +337,6 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 	struct drm_gpu_scheduler *sched;
 	const struct drm_sched_init_args args = {
 		.ops = &drm_sched_ops,
-		.num_rqs = 1,
 		.credit_limit = xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
 		.hang_limit = XE_SCHED_HANG_LIMIT,
 		.timeout = XE_SCHED_JOB_TIMEOUT,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index 9c8004d5dd91..67d8ce368486 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -66,7 +66,6 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 	const struct drm_sched_init_args args = {
 		.ops = ops,
 		.submit_wq = submit_wq,
-		.num_rqs = 1,
 		.credit_limit = hw_submission,
 		.hang_limit = hang_limit,
 		.timeout = timeout,
-- 
2.52.0

