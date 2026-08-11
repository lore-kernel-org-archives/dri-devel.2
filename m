Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC09C5CFE7
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7937310EC25;
	Tue, 11 Aug 2026 14:07:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IkBEda3/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A9610EC1B;
 Tue, 11 Aug 2026 14:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=o9S4nWcawbMNqjClF7tBycyDy12Pje5M5RQ6tB2EFcI=; b=IkBEda3/rhkftEkMSaXoXYLi51
 6fSYPK5KUTqpKOecW8aDW/bLrmtkna/bVOYbQRG3t8HKYExWa98J7thVQ4PSOzxTl7fhfVWEzbWYa
 vcr4vRX8NdPL+5kilBiZ2KSaL4bG6bofUGr+6ZwiW6u1wEpfSUPjiC0SNBMhD96aA/BIVZK0DhVsK
 70eELYWG2b5IT8v/WMYZp0aX5aO7E83Pzy67wqJIdaSWCyKlB9sqQxb82o95WsJXW3kQ3yivrGEPv
 bc6Ph75mblPKJhq4SDIkViPwChq7NiLG1VYAZujOxmVbRKyZdLK/yWJJKBVkKfADenkL3iei9ZdVo
 7FZ5Q+Hg==;
Received: from [90.249.211.112] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtn8n-00HBed-VK; Tue, 11 Aug 2026 16:07:42 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Luke.Wildhardt@proton.me, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH v2 02/20] Revert "drm/sched: Remove
 drm_sched_init_args->num_rqs"
Date: Tue, 11 Aug 2026 15:07:19 +0100
Message-ID: <20260811140738.96974-3-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
References: <20260811140738.96974-1-tvrtko.ursulin@igalia.com>
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

This reverts commit d09339388b778f04dd9e638befa2594c9cb4290b.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Luke.Wildhardt@proton.me
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 include/drm/gpu_scheduler.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 363d13fc929f..da5d142506f2 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -607,6 +607,8 @@ struct drm_gpu_scheduler {
  * @ops: backend operations provided by the driver
  * @submit_wq: workqueue to use for submission. If NULL, an ordered wq is
  *	       allocated and used.
+ * @num_rqs: Number of run-queues. This may be at most DRM_SCHED_PRIORITY_COUNT,
+ *	     as there's usually one run-queue per priority, but may be less.
  * @credit_limit: the number of credits this scheduler can hold from all jobs
  * @hang_limit: number of times to allow a job to hang before dropping it.
  *		This mechanism is DEPRECATED. Set it to 0.
@@ -620,6 +622,7 @@ struct drm_sched_init_args {
 	const struct drm_sched_backend_ops *ops;
 	struct workqueue_struct *submit_wq;
 	struct workqueue_struct *timeout_wq;
+	u32 num_rqs;
 	u32 credit_limit;
 	unsigned int hang_limit;
 	long timeout;
-- 
2.54.0

