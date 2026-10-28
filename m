Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B68F606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RWhfd01E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0DC710FBF2;
	Wed, 28 Oct 2026 12:21:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6A4C10FBEA;
 Wed, 28 Oct 2026 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793190107; x=1824726107;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uSUVijMosttd3r+D74aa13BspI44MwWWarJwhBOXt5U=;
 b=RWhfd01E9STHMQyglfXfa/oqJu1edTiRR/iUwQci8pewEQawvFnVBTZl
 ZRRUUArXccVhyr8AFcKZFnFtL9F+Bj62fa1Zmy357fbfil2pcZy6GfJPz
 ltJYnRmD+kwdBcn6gaQchzjHagfJAKoEMOfi78GhffKSyn8pXbmXJDhwE
 g/Ti2jOMPYhi3p3QibKp5HdqXUrLTg965X9wFEMzE7cLMOxQJEG7XD0Uh
 aMPfae/RXJuGvT/QGu3HYj1S0VSDQwaNQc7IFfoApZ8+hoeEUmptjJsHF
 tAcN1C1kHXriNS/CVggVgiwBduHKztmEiE0vRaL7UDEjnmWBz2lKOe8ef A==;
X-CSE-ConnectionGUID: fNAdd2dhTrietRBKQUdoog==
X-CSE-MsgGUID: wNDChYEVRAa+rZW5/O0NYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1939034"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1939034"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:46 -0700
X-CSE-ConnectionGUID: /yeMQ7fmR/CNActfP8WUuQ==
X-CSE-MsgGUID: oSSwYHSKRYSH8vueI5o9ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4838505"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 05:21:44 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: rodrigo.vivi@intel.com, matthew.brost@intel.com,
 himal.prasad.ghimiray@intel.com, thomas.hellstrom@linux.intel.com,
 sanjay.kumar.yadav@intel.com, Wang Xin <x.wang@intel.com>,
 Jia Yao <jia.yao@intel.com>, Jonathan Cavitt <jonathan.cavitt@intel.com>
Subject: [PATCH v2 2/4] drm/xe: Disable scheduling early on FD close to avoid
 CAT error cascade
Date: Wed, 28 Oct 2026 17:51:23 +0530
Message-ID: <20261028122125.3772832-3-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028122125.3772832-1-arvind.yadav@intel.com>
References: <20261028122125.3772832-1-arvind.yadav@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matthew Brost <matthew.brost@intel.com>

When an FD is closed with many exec queues, teardown relies on the TDR
path to clean up scheduling. However, the TDR handling is serialized
(i.e., only one exec queue is processed at a time), which can make it
too slow compared to GuC scheduling activity.

In this window, GuC may continue to schedule contexts backed by
invalid page tables, leading to a cascade of CAT errors and repeated
engine resets. This significantly increases recovery time and can
degrade system stability.

To mitigate this, eagerly disable scheduling by sending a self-message
outside of the TDR path. This prevents further scheduling of invalid
contexts and avoids the CAT error/reset cascade.

This change improves robustness and reduces recovery latency in
multiple queue teardown scenarios.

Cc: Wang Xin <x.wang@intel.com>
Cc: Jia Yao <jia.yao@intel.com>
Tested-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_exec_queue_types.h |  2 +-
 drivers/gpu/drm/xe/xe_guc_submit.c           | 46 ++++++++++++++++++--
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
index 74b711abe257..89397e1e6546 100644
--- a/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_exec_queue_types.h
@@ -36,7 +36,7 @@ struct xe_guc_exec_queue {
 	 * a message needs to sent through the GPU scheduler but memory
 	 * allocations are not allowed.
 	 */
-#define MAX_STATIC_MSG_TYPE	4
+#define MAX_STATIC_MSG_TYPE	5
 	struct xe_sched_msg static_msgs[MAX_STATIC_MSG_TYPE];
 	/** @destroy_async: do final destroy async from this worker */
 	struct work_struct destroy_async;
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 9e7c2778029c..a70a166cf2c9 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -2060,12 +2060,23 @@ static void __guc_exec_queue_process_msg_cgp_sync(struct xe_sched_msg *msg,
 		guc_exec_queue_send_cgp_sync(q, 0);
 }
 
+static void __guc_exec_queue_process_msg_kill(struct xe_sched_msg *msg,
+					      bool bound)
+{
+	struct xe_exec_queue *q = msg->private_data;
+	struct xe_exec_queue *primary = xe_exec_queue_multi_queue_primary(q);
+
+	if (exec_queue_enabled(primary) && bound)
+		disable_scheduling(primary, true);
+}
+
 #define CLEANUP				1	/* Non-zero values to catch uninitialized msg */
 #define SET_SCHED_PROPS			2
 #define SUSPEND				3
 #define RESUME				4
 #define SET_MULTI_QUEUE_PRIORITY	5
 #define CGP_SYNC_MSG			6
+#define KILL				7
 #define OPCODE_MASK	0xf
 #define MSG_LOCKED	BIT(8)
 #define MSG_HEAD	BIT(9)
@@ -2099,6 +2110,9 @@ static void guc_exec_queue_process_msg(struct xe_sched_msg *msg)
 	case CGP_SYNC_MSG:
 		__guc_exec_queue_process_msg_cgp_sync(msg, bound);
 		break;
+	case KILL:
+		__guc_exec_queue_process_msg_kill(msg, bound);
+		break;
 	default:
 		XE_WARN_ON("Unknown message type");
 	}
@@ -2225,8 +2239,19 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	return err;
 }
 
+static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
+				       struct xe_sched_msg *msg,
+				       u32 opcode);
+
+#define STATIC_MSG_CLEANUP	0
+#define STATIC_MSG_SUSPEND	1
+#define STATIC_MSG_RESUME	2
+#define STATIC_MSG_CGP_SYNC	3
+#define STATIC_MSG_KILL		4
 static void guc_exec_queue_kill(struct xe_exec_queue *q)
 {
+	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_KILL;
+
 	trace_xe_exec_queue_kill(q);
 	set_exec_queue_killed(q);
 	/*
@@ -2236,6 +2261,23 @@ static void guc_exec_queue_kill(struct xe_exec_queue *q)
 	 * stays set until the queue is torn down.
 	 */
 	suspend_wait_wake(q);
+
+	/*
+	 * We eagerly send a message to ourselves to disable scheduling, as the
+	 * TDR is serialized (i.e., only one exec queue is processed at a time).
+	 * If an FD is closed with many exec queues, the TDR can be slower than
+	 * the GuC scheduling contexts with invalid page tables, creating a
+	 * cascade of CAT errors and engine resets, which is quite slow. Avoid
+	 * this by immediately disabling scheduling outside of the TDR.
+	 */
+	if (kref_read(&q->refcount) && !exec_queue_wedged(q)) {
+		struct xe_gpu_scheduler *sched = &q->guc->sched;
+
+		xe_sched_msg_lock(sched);
+		guc_exec_queue_try_add_msg(q, msg, KILL);
+		xe_sched_msg_unlock(sched);
+	}
+
 	xe_guc_exec_queue_trigger_cleanup(q);
 }
 
@@ -2288,10 +2330,6 @@ static bool guc_exec_queue_try_add_msg(struct xe_exec_queue *q,
 	return true;
 }
 
-#define STATIC_MSG_CLEANUP	0
-#define STATIC_MSG_SUSPEND	1
-#define STATIC_MSG_RESUME	2
-#define STATIC_MSG_CGP_SYNC	3
 static void guc_exec_queue_destroy(struct xe_exec_queue *q)
 {
 	struct xe_sched_msg *msg = q->guc->static_msgs + STATIC_MSG_CLEANUP;
-- 
2.43.0

