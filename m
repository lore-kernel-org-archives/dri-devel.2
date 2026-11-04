Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61258606A32F
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TWNWqG3j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90D010FA93;
	Wed,  4 Nov 2026 09:52:47 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7244C10FAA4
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=tj/uYvZvM2AYjEEwSyz299JWU7JW4dEqLvB6vr4dY3Y=;
 t=1793785957; x=2109145957; b=TWNWqG3j5vsf+lR6/Xm3Q1ed4vMcuSthn9MzVNJv67vkIFR
 GzP0mf5GrJTiu4zkRmj+QZXRC7+6ZyALpZjBVOIBPLkm9zQoSIHKDag2ppE/9TMAlcwWmbZcPJc/8
 Vi7jkQjYzduN2IVrKpiploEZV4Wo8lMdO95lqwA2O4XuFj/uU4i+IdVewOiOy/LRLHeGY3BSI90Cu
 zCj7yMXoBc1Ud+NLNiEPadKouBu9gJvzBFyZ4vbf+g5qzmwleHHwwNGDA6KKWZxCeZ31Pt1N8aguq
 BMFBigMumHbfE6ivBhJSFnLsNg+UpvTZoU++OTbgq/h4kNozsgCS3gv3B57PyW4Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOXfX-00285F-JX; Wed, 04 Nov 2026 10:52:35 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v8 5/6] workqueue: Imply strict CPU affinity for WQ_RT
Date: Wed,  4 Nov 2026 09:52:24 +0000
Message-ID: <20261104095225.32654-6-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
References: <20261104095225.32654-1-tvrtko.ursulin@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Imply and set strict CPU affinity for WQ_RT workqueues for even lower
worst case execution latency.

With this, a benchmark which measures the GPU submit latency against a
real-time Vulkan queue when faced with CPU saturation, highlights a
dramatic reduction in maximum observed latencies and further reduction in
the median, and 95- and 98-the percentiles:

    us      7.3.0   WQ_RT   +strict_affinity

   median     30     21           11
    min        2      3            2
    max     1038    941          108
   95pct    2384     49           28
   98pct    2922     63           51

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
---
 Documentation/core-api/workqueue.rst |  5 +++--
 kernel/workqueue.c                   | 13 ++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 54697907f2b0..d699c3832b19 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -226,8 +226,9 @@ resources, scheduled and executed.
   implements concurrency management among its workers.
 
 ``WQ_RT``
-  Real-time priority workqueues must be created as unbound. Their worker threads
-  use the FIFO scheduling policy with the lowest applicable priority.
+  Real-time priority workqueues must be created as unbound and will be
+  configured with the strict CPU affinity set. Their worker threads use the FIFO
+  scheduling policy with the lowest applicable priority.
 
   To be used sparingly for use cases such as the real-time GPU rendering
   contexts accessible to privileged clients.
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 637240667cf7..26a26831bee7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5723,8 +5723,12 @@ static void
 sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
 				   struct workqueue_attrs *attrs)
 {
-	if (wq->flags & WQ_RT)
+	if (wq->flags & WQ_RT) {
 		attrs->prio = RT_PRIORITY;
+		/* Strict CPU affinity for low latency execution. */
+		attrs->affn_scope = WQ_AFFN_CPU;
+		attrs->affn_strict = true;
+	}
 
 	if (wq->flags & __WQ_ORDERED)
 		attrs->ordered = true;
@@ -7847,8 +7851,11 @@ static umode_t wq_sysfs_unbound_group_visible(struct kobject *kobj,
 	if (!(wq->flags & WQ_UNBOUND))
 		return 0;
 
-	/* Do not allow priority changes for RT workers. */
-	if ((wq->flags & WQ_RT) && (attr == &dev_attr_nice.attr))
+	/* Do not allow priority and affinity changes for RT workers. */
+	if ((wq->flags & WQ_RT) &&
+	     (attr == &dev_attr_nice.attr ||
+	      attr == &dev_attr_affinity_scope.attr ||
+	      attr == &dev_attr_affinity_strict.attr))
 		return 0444;
 
 	return attr->mode;
-- 
2.56.0

