Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A115606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=O7H7rSKW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8372610FA69;
	Wed,  4 Nov 2026 09:52:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB0810FA69
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=I7UYiBJju99IRyHYhZWYc31PUJj/rp22TJL8Ij7sOX4=;
 t=1793785955; x=2109145955; b=O7H7rSKW4sM9UbL4G519pKFCrFleQnDL9eHRQnxhANvb3yU
 4SSoPrGlAwAxC8dAFICZvmBEwIezJXhzRMHpSLhRwjrt3mo1/2Yf9bHYgssHlhpoFbDUTWpOStkgK
 KeG4H+xrZNhB8rXNDlerNeRqB6JEZmB/CkxEumq6ti7PGcKgMHc40HmPGecTxaeoijbmwCkgDnsGm
 qXk3siTQv6wIWscpE5ATl5LLaXz/EYbX5BvNKiOSlLj30SVwbxXnlf0WwqYpwWdViFVwUQkqM4DjH
 BuyRdXIWy9/YOq4sKll3MhF4vRnWM+V2CdrYe9HJaGOBSH+qpTMPTE1X8gXaKR5A==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xOXfV-00284w-Fy; Wed, 04 Nov 2026 10:52:33 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chia-I Wu <olv@google.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Steven Price <steven.price@arm.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v8 2/6] workqueue: Separate sysfs mutable vs immutable wq
 attribute sanitizing
Date: Wed,  4 Nov 2026 09:52:21 +0000
Message-ID: <20261104095225.32654-3-tvrtko.ursulin@igalia.com>
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

In preparation for adding more sanitization steps split the current ones
into ones which are immutable and the ones which can be modified from
sysfs.

Point being that the mutable steps must only run on the initial workqueue
creation, while the immutable properties need to be sanitized every time
attributes are applied.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Chia-I Wu <olv@google.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Tejun Heo <tj@kernel.org>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com> # v1
---
v2:
 * Drop a redundant helper and improve commentary. (Tejun)
---
 kernel/workqueue.c | 47 +++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 14b87e972ce9..2f0c3f738c70 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5706,6 +5706,30 @@ static void apply_wqattrs_cleanup(struct apply_wqattrs_ctx *ctx)
 	}
 }
 
+/*
+ * Sanitize attributes derived from the workqueue flags and which need to be
+ * enforced on every attribute application.
+ */
+static void
+sanitize_immutable_workqueue_attrs(struct workqueue_struct *wq,
+				   struct workqueue_attrs *attrs)
+{
+	if (wq->flags & __WQ_ORDERED)
+		attrs->ordered = true;
+}
+
+/*
+ * Sanitize attributes derived from the workqueue flags and which need to be
+ * enforced only on workqueue creation.
+ */
+static void
+sanitize_mutable_workqueue_attrs(struct workqueue_struct *wq,
+				 struct workqueue_attrs *attrs)
+{
+	if (wq->flags & WQ_HIGHPRI)
+		attrs->nice = HIGHPRI_NICE_LEVEL;
+}
+
 /* allocate the attrs and pwqs for later installation */
 static struct apply_wqattrs_ctx *
 apply_wqattrs_prepare(struct workqueue_struct *wq,
@@ -5735,6 +5759,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 	 * every possible CPU and never falls back, so it has no default.
 	 */
 	copy_workqueue_attrs(new_attrs, attrs);
+	sanitize_immutable_workqueue_attrs(wq, new_attrs);
 	wqattrs_actualize_cpumask(new_attrs, unbound_cpumask);
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	if (!(wq->flags & WQ_PERCPU)) {
@@ -5757,6 +5782,7 @@ apply_wqattrs_prepare(struct workqueue_struct *wq,
 
 	/* save the user configured attrs and sanitize it. */
 	copy_workqueue_attrs(new_attrs, attrs);
+	sanitize_immutable_workqueue_attrs(wq, new_attrs);
 	cpumask_and(new_attrs->cpumask, new_attrs->cpumask, cpu_possible_mask);
 	cpumask_copy(new_attrs->__pod_cpumask, new_attrs->cpumask);
 	ctx->attrs = new_attrs;
@@ -5919,24 +5945,6 @@ static void unbound_wq_update_pwq(struct workqueue_struct *wq, int cpu)
 	put_pwq_unlocked(old_pwq);
 }
 
-/* the attrs @wq asked for, as spelled by its flags */
-static struct workqueue_attrs *alloc_wq_std_attrs(struct workqueue_struct *wq)
-{
-	struct workqueue_attrs *attrs;
-
-	attrs = alloc_workqueue_attrs();
-	if (!attrs)
-		return NULL;
-
-	if (wq->flags & WQ_HIGHPRI)
-		attrs->nice = HIGHPRI_NICE_LEVEL;
-
-	if (wq->flags & __WQ_ORDERED)
-		attrs->ordered = true;
-
-	return attrs;
-}
-
 static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 {
 	struct workqueue_attrs *attrs;
@@ -5948,10 +5956,11 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	if (!wq->cpu_pwq)
 		goto enomem;
 
-	attrs = alloc_wq_std_attrs(wq);
+	attrs = alloc_workqueue_attrs();
 	if (!attrs)
 		goto enomem;
 
+	sanitize_mutable_workqueue_attrs(wq, attrs);
 	ret = apply_workqueue_attrs_locked(wq, attrs);
 	free_workqueue_attrs(attrs);
 	if (ret)
-- 
2.56.0

