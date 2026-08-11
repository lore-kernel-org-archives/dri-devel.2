Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931EBC5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833B010EB18;
	Tue, 11 Aug 2026 10:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZFhNbWgG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C65110EB18
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443474;
 bh=lcAAaMZkFVpvqzbW1ekUP0RAfWGLsBJ4f5VZYcVrQW8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZFhNbWgGJDJHNFrbiTrXMkjLvVsqm48o5wa/dmm9LDQXiKdL64xIeDqZHvDJbIkWZ
 Ev/r649AAgqwYCEYja2YVf4hhjuR4nDJsy8AD5vcXHwSqIVbUfQl1ODKnfCQgcvZcB
 T0DWLRNEOHYehR5MwYIa3/8PTP7ZHk7iSN2NUtfqy7uqAhxKOxe2rEX0B5emkxKx1W
 /9bV+MCoidJAJaKi9HupJEMs5wRhOEjQfnV8jVj8f4OTvZmPd7x4hwv66LkfMI0NR3
 anpLL6JmE+9h3LkztoGg0sF2/YkWZDJLUHTZWpTRrJh4IvbJw89PB0E7w/EMatNQW0
 mHX2IlT6colbw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9334F17E121D;
 Tue, 11 Aug 2026 12:17:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:48 +0200
Subject: [PATCH v2 14/17] drm/panthor: Track user owned groups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-14-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443467; l=4878;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=lcAAaMZkFVpvqzbW1ekUP0RAfWGLsBJ4f5VZYcVrQW8=;
 b=A+82uoOnOw4n6wtdo3NOs2UIvJoh+JkdgkKrsXaMXK+N9qZti59ELWt5MZ7QCGv3sjyAfZSW3
 T4PTbmaXuikB/tJs/eS86Lc5VhNtpDNLUnGyWvu32rvi8BDRVs6gJ2x
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

A group can outlive its user handle because of internal refs. In order
to fix the unplug logic, we need to keep track of groups that have a
valid user handle so we can release the references that were owned by
the user processes in the unplug path.

This is the prep work to keep track of user owned groups. Note that
the destroyed attribute is dropped because it's equivalent to checking
whether the group is inserted in the user_owned list now.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 39 +++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index f18b2e03f2fd..756c3fa7a242 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -252,6 +252,15 @@ struct panthor_scheduler {
 		 * This list is evaluated in the @sync_upd_work work.
 		 */
 		struct list_head waiting;
+
+		/**
+		 * @user_owned: List of groups that have a valid user handle.
+		 *
+		 * All groups are inserted in this list at creation time through their
+		 * panthor_group;:user_node, and evicted from this list when
+		 * panthor_group_destroy() is called.
+		 */
+		struct list_head user_owned;
 	} groups;
 
 	/**
@@ -587,15 +596,6 @@ struct panthor_group {
 	 */
 	int csg_id;
 
-	/**
-	 * @destroyed: True when the group has been destroyed.
-	 *
-	 * If a group is destroyed it becomes useless: no further jobs can be submitted
-	 * to its queues. We simply wait for all references to be dropped so we can
-	 * release the group object.
-	 */
-	bool destroyed;
-
 	/**
 	 * @timedout: True when a timeout occurred on any of the queues owned by
 	 * this group.
@@ -705,6 +705,17 @@ struct panthor_group {
 	 * panthor_group::groups::waiting list.
 	 */
 	struct list_head wait_node;
+
+	/**
+	 * @user_node: Used to insert the group in the panthor_scheduler::groups::user_owned list.
+	 *
+	 * When the group is created, it's inserted in panthor_scheduler::groups::user_owned,
+	 * and when panthor_group_destroy, the group is remove from this list.
+	 *
+	 * When the device is unplugged, all groups that remain in this list must have an extra
+	 * put_group() called on them to release the reference owned by the per-file group pool.
+	 */
+	struct list_head user_node;
 };
 
 struct panthor_job_profiling_data {
@@ -967,6 +978,7 @@ static void group_release(struct kref *kref)
 	struct panthor_device *ptdev = group->ptdev;
 
 	drm_WARN_ON(&ptdev->base, group->csg_id >= 0);
+	drm_WARN_ON(&ptdev->base, !list_empty(&group->user_node));
 	drm_WARN_ON(&ptdev->base, !list_empty(&group->run_node));
 	drm_WARN_ON(&ptdev->base, !list_empty(&group->wait_node));
 
@@ -1082,7 +1094,7 @@ group_can_run(struct panthor_group *group)
 {
 	return group->state != PANTHOR_CS_GROUP_TERMINATED &&
 	       group->state != PANTHOR_CS_GROUP_UNKNOWN_STATE &&
-	       !group->destroyed && group->fatal_queues == 0 &&
+	       !list_empty(&group->user_node) && group->fatal_queues == 0 &&
 	       !group->timedout;
 }
 
@@ -2403,7 +2415,7 @@ tick_ctx_apply(struct panthor_scheduler *sched, struct panthor_sched_tick_ctx *c
 			 * re-evaluate as soon as possible and get rid of
 			 * this dangling group.
 			 */
-			if (group->destroyed)
+			if (list_empty(&group->user_node))
 				ctx->immediate_tick = true;
 			group_put(group);
 		}
@@ -3691,6 +3703,7 @@ int panthor_group_create(struct panthor_file *pfile,
 	group->tiler_core_mask = group_args->tiler_core_mask;
 	group->priority = group_args->priority;
 
+	INIT_LIST_HEAD(&group->user_node);
 	INIT_LIST_HEAD(&group->wait_node);
 	INIT_LIST_HEAD(&group->run_node);
 	INIT_WORK(&group->term_work, group_term_work);
@@ -3764,6 +3777,7 @@ int panthor_group_create(struct panthor_file *pfile,
 		mutex_lock(&sched->lock);
 		list_add_tail(&group->run_node,
 			      &sched->groups.idle[group->priority]);
+		list_add_tail(&group->user_node, &sched->groups.user_owned);
 		mutex_unlock(&sched->lock);
 	}
 	mutex_unlock(&sched->reset.lock);
@@ -3801,7 +3815,7 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 
 	mutex_lock(&sched->reset.lock);
 	mutex_lock(&sched->lock);
-	group->destroyed = true;
+	list_del_init(&group->user_node);
 	if (group->csg_id >= 0) {
 		sched_queue_delayed_work(sched, tick, 0);
 	} else if (!atomic_read(&sched->reset.in_progress)) {
@@ -4167,6 +4181,7 @@ int panthor_sched_init(struct panthor_device *ptdev)
 		INIT_LIST_HEAD(&sched->groups.idle[prio]);
 	}
 	INIT_LIST_HEAD(&sched->groups.waiting);
+	INIT_LIST_HEAD(&sched->groups.user_owned);
 
 	ret = drmm_mutex_init(&ptdev->base, &sched->reset.lock);
 	if (ret)

-- 
2.55.0

