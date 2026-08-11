Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 487E7C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E314910EBDA;
	Tue, 11 Aug 2026 13:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LWEN0LAq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E3D10EBD2;
 Tue, 11 Aug 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=zGzgVAtmhTQa8WZPkMeoIS86WIwJJu/KtuYMng5Z2IU=; b=
 LWEN0LAqlQ1Xf87sS5jm2qyHvL32EI4gCMd84h+xd+x9dotWM1Awz0xGM5YRULp5uYLFFgoN5C6y3
 8pZ2eckKVU82CqcxPmyW9Vxrs8PlHKL6qo22ZmS//ZhNp9bCkvMhj7ITWaYNbQj5bPzhtp0Yiy+UU
 3WTPl8uiuz0mRUJF415E4EFqFgVBHN1NCWs5SC9sctvVF8hI/JBweE1+enDmBN96VZ6utdGE7Zog0
 67VngdVBixDNEAQDYBKKTOLKdBYCscNivTAfR6k02BOj8Cr+pLLdkozWrDNaRlWQFIkXIbMCvATVx
 znHIahs7/MFgjqBiK3kA0w8axkwrae0NkA==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtmpn-00H9mg-AL; Tue, 11 Aug 2026 15:48:03 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 03/20] Revert "drm/xe: Remove drm_sched_init_args->num_rqs
 usage"
Date: Tue, 11 Aug 2026 14:47:41 +0100
Message-ID: <20260811134758.96339-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
References: <20260811134758.96339-1-tvrtko.ursulin@igalia.com>
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

This reverts commit 4ca491d6ccf2daea813e67ed4b42e7b272f0687d.
---
 drivers/gpu/drm/xe/xe_dep_scheduler.c | 1 +
 drivers/gpu/drm/xe/xe_execlist.c      | 1 +
 drivers/gpu/drm/xe/xe_gpu_scheduler.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_dep_scheduler.c b/drivers/gpu/drm/xe/xe_dep_scheduler.c
index 004aac8b89e6..51d99fee9aa5 100644
--- a/drivers/gpu/drm/xe/xe_dep_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_dep_scheduler.c
@@ -78,6 +78,7 @@ xe_dep_scheduler_create(struct xe_device *xe,
 	const struct drm_sched_init_args args = {
 		.ops = &sched_ops,
 		.submit_wq = submit_wq,
+		.num_rqs = 1,
 		.credit_limit = job_limit,
 		.timeout = MAX_SCHEDULE_TIMEOUT,
 		.name = name,
diff --git a/drivers/gpu/drm/xe/xe_execlist.c b/drivers/gpu/drm/xe/xe_execlist.c
index cc33ae80e8cf..0d0db66c6ea2 100644
--- a/drivers/gpu/drm/xe/xe_execlist.c
+++ b/drivers/gpu/drm/xe/xe_execlist.c
@@ -328,6 +328,7 @@ static int execlist_exec_queue_init(struct xe_exec_queue *q)
 	struct drm_gpu_scheduler *sched;
 	const struct drm_sched_init_args args = {
 		.ops = &drm_sched_ops,
+		.num_rqs = 1,
 		.credit_limit = xe_lrc_ring_size() / MAX_JOB_SIZE_BYTES,
 		.hang_limit = XE_SCHED_HANG_LIMIT,
 		.timeout = XE_SCHED_JOB_TIMEOUT,
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.c b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
index 67d8ce368486..9c8004d5dd91 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.c
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.c
@@ -66,6 +66,7 @@ int xe_sched_init(struct xe_gpu_scheduler *sched,
 	const struct drm_sched_init_args args = {
 		.ops = ops,
 		.submit_wq = submit_wq,
+		.num_rqs = 1,
 		.credit_limit = hw_submission,
 		.hang_limit = hang_limit,
 		.timeout = timeout,
-- 
2.54.0

