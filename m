Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D39606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B15rE82b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A81610F338;
	Mon,  9 Nov 2026 13:57:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04DA610F30E;
 Mon,  9 Nov 2026 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232653; x=1825768653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SnYesO6J0TUWKqMJLkyiyFu+amSYSXvoWNOk7TXKKsY=;
 b=B15rE82bIF0Nh/Q4EnX57TtWswqvwX40uwwkk5terbNLSGN1uWWflGaV
 8mdeo2FFlxAjplvqKlAi07V0kIWKTuFr2//wMnIL3TEGJP+KMKzRG9cTG
 OzJVCb9e+oi4KcpVJz6Omj0pEWXdAdxv4Gl2Vj2F0t4HKbdNnNLNsK7Jo
 EUpZEy1nlK7O9wfc4R55qu0iE8GBJ/+9bkbFwbxxb5yyV5PRDTxLzgHnG
 BOBqQ6s5NQnFPzkixG7JDm9mnocltXPG4mIOBENRhfkEs3I9xUFaR/ZXx
 +eYEjijpJRKsSuVdDDl3q7wwHIA4NVNrKebwxjbe6vg4r33R6Sy4YKn9b g==;
X-CSE-ConnectionGUID: Q7kGCJYqTXyFB9SD2L1GFg==
X-CSE-MsgGUID: uow89IQdT86CVWBPbhwYaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850916"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850916"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:33 -0800
X-CSE-ConnectionGUID: Dyjvd57JSgyKtB3Z+yFFwg==
X-CSE-MsgGUID: hmk/ra6ySAuGHcjPNrYN+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202949"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:26 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 16/20] drm/xe/eudebug: Track debuggable exec queues
Date: Mon,  9 Nov 2026 15:55:41 +0200
Message-ID: <20261109135549.4128280-17-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Attention handling, added with the EU control interface later in the
series, has to find the exec queue that raised attention. Track the
debuggable exec queues in a device wide list instead of walking the
exec queues of every client with a debugger attached.

v2: - enabled check under eudebug.lock, document return (Mika)

Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-xe-eudebug |  8 ++-
 drivers/gpu/drm/xe/xe_device_types.h          |  3 +
 drivers/gpu/drm/xe/xe_eudebug.c               | 66 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug.h               |  5 ++
 drivers/gpu/drm/xe/xe_exec_queue.c            | 20 ++++++
 drivers/gpu/drm/xe/xe_exec_queue_types.h      |  8 +++
 6 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
index 50ab7db1f811..237dea4c6699 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
@@ -12,8 +12,8 @@ Description:	RW. Controls whether the EU debugger interface is armed for
 		While disabled, DRM_IOCTL_XE_EUDEBUG_CONNECT fails with
 		-EOPNOTSUPP.
 
-		Writing 0 while any debugger connection is still attached
-		fails with -EBUSY.
+		Writing 0 while any debugger connection is still attached,
+		or any debuggable exec queue still exists, fails with -EBUSY.
 
 		Once enabled, connecting needs no privilege beyond access to
 		the render node: a client may attach to any DRM file it holds
@@ -32,7 +32,9 @@ Description:	RW. Controls whether the EU debugger interface is armed for
 		(runalone), and as its preemption timeout is infinite it is
 		not reset if it does not yield the engine when preempted.
 		Work from other clients on those engines can therefore be
-		held off for as long as such a queue keeps running.
+		held off for as long as such a queue keeps running. Such a
+		queue also keeps the interface from being disabled until it
+		is destroyed.
 
 		Each connection allocates about 4 MiB of kernel memory for
 		its event queue, held until the connection is closed. The
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 73b576547193..354b258f4ca6 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -637,6 +637,9 @@ struct xe_device {
 		/** @eudebug.attached: number of debuggers currently attached */
 		unsigned int attached;
 
+		/** @eudebug.targets: exec queues that are debuggable */
+		struct list_head targets;
+
 		/** @eudebug.lock: protects the eudebug state of this device */
 		struct mutex lock;
 
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index bf4d3ac4e092..03ac45653172 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -2296,6 +2296,13 @@ static int __xe_eudebug_enable(struct xe_device *xe, bool enable,
 	if (!enable && xe->eudebug.attached)
 		return -EBUSY;
 
+	/*
+	 * A debuggable queue keeps its runalone and debug state for as long
+	 * as it lives, so do not drop the interface from under it.
+	 */
+	if (!enable && !list_empty(&xe->eudebug.targets))
+		return -EBUSY;
+
 	if (enable == __xe_eudebug_is_enabled(xe))
 		return 0;
 
@@ -2391,6 +2398,8 @@ static void xe_eudebug_lock_fini(struct drm_device *dev, void *__unused)
 
 void xe_eudebug_init_early(struct xe_device *xe)
 {
+	INIT_LIST_HEAD(&xe->eudebug.targets);
+
 	/*
 	 * Not drmm_mutex_init(), which can fail and leave the lock destroyed:
 	 * the state is read under it from here on. Nothing can reach the
@@ -2466,6 +2475,63 @@ void xe_eudebug_init(struct xe_device *xe)
 		set_cap_state(xe, XE_EUDEBUG_CAP_NOT_SUPPORTED);
 }
 
+/**
+ * xe_eudebug_track_exec_queue - Make an exec queue findable on attention
+ * @q: The exec queue
+ *
+ * Adds a debuggable exec queue into the device wide target list, so that
+ * the attention handling can resolve the hardware context that raised
+ * attention back to the exec queue owning it. Membership does not depend
+ * on a debugger being attached to the owning client.
+ *
+ * Must be called only after the queue is fully initialized, as the lookup
+ * dereferences the lrc array of every queue it walks.
+ *
+ * Return: 0 on success, -EPERM if eudebug got disabled since the queue was
+ * made debuggable.
+ */
+int xe_eudebug_track_exec_queue(struct xe_exec_queue *q)
+{
+	struct xe_device *xe = gt_to_xe(q->gt);
+
+	if (!xe_exec_queue_is_debuggable(q))
+		return 0;
+
+	guard(mutex)(&xe->eudebug.lock);
+
+	/*
+	 * The property checked the enabled state, but a disable may have run
+	 * since. That refuses while queues are tracked, so look again under
+	 * the lock it checks under, or this one would slip in behind it.
+	 */
+	if (!__xe_eudebug_is_enabled(xe))
+		return -EPERM;
+
+	if (list_empty(&q->eudebug.target_link))
+		list_add_tail(&q->eudebug.target_link, &xe->eudebug.targets);
+
+	return 0;
+}
+
+/**
+ * xe_eudebug_untrack_exec_queue - Remove an exec queue from the target list
+ * @q: The exec queue
+ *
+ * Reverses xe_eudebug_track_exec_queue(). Safe to call on a queue that was
+ * never tracked, and safe to repeat.
+ */
+void xe_eudebug_untrack_exec_queue(struct xe_exec_queue *q)
+{
+	struct xe_device *xe = gt_to_xe(q->gt);
+
+	if (!xe_exec_queue_is_debuggable(q))
+		return;
+
+	guard(mutex)(&xe->eudebug.lock);
+
+	list_del_init(&q->eudebug.target_link);
+}
+
 /**
  * xe_eudebug_connect_ioctl - Connect to eudebug interface
  * @dev : DRM device
diff --git a/drivers/gpu/drm/xe/xe_eudebug.h b/drivers/gpu/drm/xe/xe_eudebug.h
index dc92cdbbf75e..ce61537a596e 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.h
+++ b/drivers/gpu/drm/xe/xe_eudebug.h
@@ -54,6 +54,9 @@ void xe_eudebug_init(struct xe_device *xe);
 void xe_eudebug_init_early(struct xe_device *xe);
 bool xe_eudebug_is_enabled(struct xe_device *xe);
 
+int xe_eudebug_track_exec_queue(struct xe_exec_queue *q);
+void xe_eudebug_untrack_exec_queue(struct xe_exec_queue *q);
+
 void xe_eudebug_file_close(struct xe_file *xef);
 
 void xe_eudebug_vm_create(struct xe_file *xef, struct xe_vm *vm);
@@ -83,6 +86,8 @@ static inline int xe_eudebug_connect_ioctl(struct drm_device *dev,
 static inline void xe_eudebug_init(struct xe_device *xe) { }
 static inline void xe_eudebug_init_early(struct xe_device *xe) { }
 static inline bool xe_eudebug_is_enabled(struct xe_device *xe) { return false; }
+static inline int xe_eudebug_track_exec_queue(struct xe_exec_queue *q) { return 0; }
+static inline void xe_eudebug_untrack_exec_queue(struct xe_exec_queue *q) { }
 
 static inline void xe_eudebug_file_close(struct xe_file *xef) { }
 
diff --git a/drivers/gpu/drm/xe/xe_exec_queue.c b/drivers/gpu/drm/xe/xe_exec_queue.c
index 870abbf08d2e..5f39b9cf06c0 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue.c
+++ b/drivers/gpu/drm/xe/xe_exec_queue.c
@@ -232,6 +232,9 @@ static struct xe_exec_queue *__xe_exec_queue_alloc(struct xe_device *xe,
 	INIT_LIST_HEAD(&q->vm_exec_queue_link);
 	INIT_LIST_HEAD(&q->hw_engine_group_link);
 	INIT_LIST_HEAD(&q->pxp.link);
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	INIT_LIST_HEAD(&q->eudebug.target_link);
+#endif
 	spin_lock_init(&q->multi_queue.lock);
 	spin_lock_init(&q->lrc_lookup_lock);
 	q->multi_queue.priority = XE_MULTI_QUEUE_PRIORITY_NORMAL;
@@ -514,6 +517,17 @@ struct xe_exec_queue *xe_exec_queue_create(struct xe_device *xe, struct xe_vm *v
 			goto err_post_init;
 	}
 
+	/*
+	 * Same reasoning as for the PXP list above: the attention lookup walks
+	 * xe->eudebug.targets and dereferences q->lrc[], which is only filled
+	 * in by __xe_exec_queue_init(), so the queue must not be published
+	 * there while it is half-initialized, nor ahead of anything that can
+	 * still fail, as the error paths free the queue bypassing its kref.
+	 */
+	err = xe_eudebug_track_exec_queue(q);
+	if (err)
+		goto err_post_init;
+
 	/*
 	 * Publish the LRC BO back-pointers last: past this point the queue can
 	 * only be destroyed through xe_exec_queue_destroy(), so a concurrent
@@ -684,6 +698,12 @@ void xe_exec_queue_fini(struct xe_exec_queue *q)
 	if (q->xef && atomic_dec_and_test(&q->xef->exec_queue.pending_removal))
 		wake_up_var(&q->xef->exec_queue.pending_removal);
 
+	/*
+	 * Not untracked at kill: a killed queue can still sit on the engine
+	 * with halted threads, and the attention lookup has to resolve it.
+	 */
+	xe_eudebug_untrack_exec_queue(q);
+
 	__xe_exec_queue_fini(q);
 	__xe_exec_queue_free(q);
 }
diff --git a/drivers/gpu/drm/xe/xe_exec_queue_types.h b/drivers/gpu/drm/xe/xe_exec_queue_types.h
index 32893341287d..4e987f73cd1a 100644
--- a/drivers/gpu/drm/xe/xe_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_exec_queue_types.h
@@ -284,6 +284,14 @@ struct xe_exec_queue {
 	u64 tlb_flush_seqno;
 	/** @hw_engine_group_link: link into exec queues in the same hw engine group */
 	struct list_head hw_engine_group_link;
+
+#if IS_ENABLED(CONFIG_DRM_XE_EUDEBUG)
+	/** @eudebug: eudebug specifics */
+	struct {
+		/** @eudebug.target_link: link into xe_device.eudebug.targets */
+		struct list_head target_link;
+	} eudebug;
+#endif
 	/**
 	 * @lrc_lookup_lock: Lock for protecting lrc array access. Only used when
 	 * running in parallel to queue creation is possible.
-- 
2.53.0

