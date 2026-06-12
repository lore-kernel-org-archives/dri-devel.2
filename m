Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6707FCD98D8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C88F610F521;
	Fri, 12 Jun 2026 13:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vh/onb7d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4FD10F53B;
 Fri, 12 Jun 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781272466; x=1812808466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mpmpGW+MCEfXXyWOnroMWvjhaZ0eijkdkHSn/yk15Vo=;
 b=Vh/onb7d5LXcB9xJkl/NLOsrQi/76yrFLlT2AS4pn262JlkBixGYSle6
 xYKk/NLwm40sMvE5b2gJZLH7X0oU7vuBzJA5KEZMvWoWw2q0j4T5oPXff
 6GG4FFUeKQJdn8s1V31fhpaBabLVAKwH2qKEwODQCDpIPS+23M6COc4Zr
 chH8eFGzJgLVNy8tktbnYVNc33PScpfxFnkoBjHYD6apqZPNgL7DsRCgn
 umvnEjcZ5oP816VkgFodk46k+EinCv3IklNSyKENCtcvtkdc83mUqkSjY
 qVoB50hHFasgdI4zVUHUUZryUEwzOTkC6UXkPJyD+MCGsWoTmMLGDEgwP w==;
X-CSE-ConnectionGUID: woRQO+PWQwyh8e1/TGOLXA==
X-CSE-MsgGUID: Y7+TX8LlTBqC1nEh88dxjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82163316"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="82163316"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:26 -0700
X-CSE-ConnectionGUID: C77P05NFQuqrguWisOlbUA==
X-CSE-MsgGUID: 09WONNwoR3itXxQQQ50Qsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="242446577"
Received: from slindbla-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.68])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 06:54:22 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michal Mrozek <michal.mrozek@intel.com>,
 John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Lahtinen Joonas <joonas.lahtinen@linux.intel.com>,
 David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 dri-devel@lists.freedesktop.org, LMKL <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] watch_queue: Add a DRM_XE_NOTIFY watch type and export
 init_watch()
Date: Fri, 12 Jun 2026 15:53:39 +0200
Message-ID: <20260612135340.116100-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
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

Add a DRM_XE_NOTIFY watch type for asynchronous error notifications
from the DRM_XE kernel module.

The reason for not registering a DRM - wide notification type is
that the notification type is 24 bits wide, the subtype is only 8,
If this is a concern one could define the DRM - wide subtypes
to be per driver, not common across DRM.

Also export the init_watch() function for use from kernel drivers.
Use EXPORT_SYMBOL() to align with other exports from the same file.

Assisted-by: GitHub_Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 include/uapi/drm/xe_drm.h        |  4 ++--
 include/uapi/linux/watch_queue.h |  3 ++-
 kernel/watch_queue.c             | 13 ++++++++++---
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index bebb0167bd31..8d5e3f06b8d4 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -2550,8 +2550,8 @@ struct drm_xe_exec_queue_set_property {
  * preempt-fence mode or not restartable.
  *
  * An optional @timestamp_ns can be provided to measure the latency between
- * event delivery and the point the worker is queued; the driver logs this
- * once all sanity checks have passed.
+ * event delivery and locking; the driver logs this regardless of whether the
+ * VM was paused.
  */
 
 /**
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index c3d8320b5d3a..c800c153989d 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
-	WATCH_TYPE__NR		= 2
+	WATCH_TYPE_DRM_XE_NOTIFY	= 2,	/* DRM device event notification */
+	WATCH_TYPE__NR		= 3
 };
 
 enum watch_meta_notification_subtype {
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 538520861e8b..701b5c388808 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -445,11 +445,17 @@ static void put_watch(struct watch *watch)
 }
 
 /**
- * init_watch - Initialise a watch
+ * init_watch() - Initialise a watch subscription
  * @watch: The watch to initialise.
- * @wqueue: The queue to assign.
+ * @wqueue: The watch queue (notification pipe) to associate with the watch.
  *
- * Initialise a watch and set the watch queue.
+ * Initialise a newly allocated watch object and associate it with @wqueue.
+ * The caller must subsequently set @watch->id and @watch->info_id before
+ * calling add_watch_to_object() to subscribe the watch to a notification
+ * source.
+ *
+ * The watch queue reference is held internally; call put_watch_queue() if
+ * the watch is not successfully passed to add_watch_to_object().
  */
 void init_watch(struct watch *watch, struct watch_queue *wqueue)
 {
@@ -458,6 +464,7 @@ void init_watch(struct watch *watch, struct watch_queue *wqueue)
 	INIT_HLIST_NODE(&watch->queue_node);
 	rcu_assign_pointer(watch->queue, wqueue);
 }
+EXPORT_SYMBOL(init_watch);
 
 static int add_one_watch(struct watch *watch, struct watch_list *wlist, struct watch_queue *wqueue)
 {
-- 
2.54.0

