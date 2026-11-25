Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAEC606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 23:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/FV/1fL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2500610E002;
	Wed, 25 Nov 2026 23:28:27 +0000 (UTC)
Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C58FD10E002
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 23:28:21 +0000 (UTC)
Received: by mail-oa2-f9.google.com with SMTP id
 586e51a60fabf-4abbe52a747so2558577fac.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795649301; x=1796254101; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ovv+Ak+qjMJDWOioiOck50/6AvWOLnchdDFocICeClo=;
 b=s/FV/1fLJAoH1ku+5byYeesGRlDtHeiCL7iLKxCyZf4JzKwNcVn3Fw3+Kn/awp62NG
 yOdn1ZQ5tXbIb1XT74gVGIZik9YY3z6elasT5a4n7rrK3lqj8+gp+kNnAeI1jwNzaOvR
 EvmU07OnfL7N3nX/Os96YxLVxw+7seT+ZH0lhlua0INevL2uUq5fF/tMJw/GVTytIb3v
 PftiOHv7Ro5sGHk+Pt+8yhSqztQUXxj5tvnw/jm9B2rP5Ftm1/pd9tQ54PT9FtL1IFLB
 EDmH4swGTNgc9KPKYUeOzIRsW8QszJxqM/LqWm6dAnKEJu8xO31+sn0BssktUu+fjYlH
 mHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795649301; x=1796254101;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ovv+Ak+qjMJDWOioiOck50/6AvWOLnchdDFocICeClo=;
 b=UAYQPPgzjlo9TOd/1gscfBJiyht4/o0e3eid/psUTGFaRkZC9Ldx5ew4D5wtFhTyBg
 QYYm1LjI91cJ4sMd1uIPupm8jFeR8glcknjVmmwQ1/z3B09WiK/x4mSDIkZavGeAlv1x
 6VLLRbbIgOVtfs1iurIyyCljFtBjEfuWRuau/RFQV6yl9aBKdhDebo2vMnSjS5w+0mwz
 b9oFoKWKfPNp6JRJqJ7N+uAqgNFG55B6GeRG793CfWEVg6/tbSeNkXXjDNUJjHb0vkkO
 py4XgNd3Wee0/N14qGlLGr3IO7ctglbmaeiGvqcQ5tHNpOZANE71zNd0al/j9SL/43mu
 k7kw==
X-Forwarded-Encrypted: i=1;
 AL+hErFn+VjcSLKy3AKa28GXyVMz4VEa8S2Hwz/MyAzhSVMW7zKbguaPwv6vYZQUQTrOLymIdecPKP9ASQQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81Hwte55XP6V4T5qxvAvdm2RBBirwkpzEL6snU+rKxDo6zQhgu
 MD4rYwS72KOU4t08JjLNU0OHwbScYRfemB/WYrw99ZK7ivx/RJ/Iww9J
X-Gm-Gg: AZFdTZdEn3LPY7o1COP4eQpjQFf1z17cfcB4sRYFRnd10rYsh0319gWNAGi6ko6/Uhb
 L+SVqBYjGZVca32seNypCSUoqHSWk8Y9XHD6qLIiRcr7xrAakLmgZ/Lv6i+6jkKFeSnUL3C9gJy
 iPz+0ymWW5HxaaQX/JYKs7xe49IfZrhpx0UGxj+xLD2/kIMaVC5k0CL++LKVdJWv+KSTmEyBByM
 CaFVrXUuNE2HIuDi3s7NkK4woxyXoscfWsN0LqV4KMpUwNc3xJdpLhVDB282cx9IXmS46lsslCE
 wVoX4iJt7xQsJEIcF1hZXfjMb+CJRo+++VmJMr5kLV+bTGvptFOglGK9lcn/0A0V9vWzQgBs3xr
 n81UVH3h7NrrjazsG9RxlzUuhDi4y9h35lIE6wTq4Gq3Df4Tw1TiZ+/6fY/m1YFM83h4SbqZAmn
 6cOA2/XJGa5ly+72gvg8KqJRSeM0wrHaGL/LFOm3avlY72Qu7gKUJjuNJUotz56c7nx05Spqv0f
 XTYlb3UWuNERm2R2GZ3OXHBqlYPty6UL8K17kZk9cc/XDwvtyAqta5uIvbtMPLkMw9jJj5JUjHk
 uNIoxmOtq7EDi1wgO5c+OzvtE7IjezZ2Bm2NM97eKzn6EPRwT/uW+vWw
X-Received: by 2002:a05:6871:7a5:b0:4a7:6dc:af65 with SMTP id
 586e51a60fabf-4bc819a3d4emr17566750fac.10.1795649300468; 
 Wed, 25 Nov 2026 15:28:20 -0800 (PST)
Received: from [192.168.0.98] ([50.26.120.197])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4bc60891cf6sm19200748fac.13.2026.11.25.15.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 15:28:19 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Wed, 25 Nov 2026 17:28:15 -0600
Subject: [PATCH] drm/imagination: Don't hold queues.lock across
 drm_sched_stop() on reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-rbrue-suez-pvr-pre-reset-lock-v1-1-0207245c5109@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MWwqDQAwF0K0M+TbQBFthtlL64ePahhYdkiql4
 t4FzwLORgE3BOW0kWO1sHminKRK1L/a6Qm2gXIivehNRK/snS/gWPDnsjoXBzsCX/7M/ZuhQzM
 2bV2rCFWJimO03/nfH/t+AAUV5+RvAAAA
X-Change-ID: 20261125-rbrue-suez-pvr-pre-reset-lock-e2d7f7a44211
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sarah Walker <sarah.walker@imgtec.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Donald Robson <donald.robson@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
 stable@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795649297; l=7208;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=S+pNhDcaReZxyl1Bxd2KOdwf7VmM0eJ5d5VBCJCOPKg=;
 b=Tmk3qgOiSZlieOuGxpdAC+MHCXe01gYek4MKsy29TMIt5lBB8y7Loqf3v6BUwzadPhEd2Y328
 GR+yaZtEhPSDrY1hQGnbYh/UW/yblFDlAq8TuSoJXzc1WCuKcLexF6M
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pvr_queue_device_pre_reset() calls drm_sched_stop() on every queue with
pvr_dev->queues.lock held. drm_sched_stop() waits for the scheduler's
run_job work, and that work takes queues.lock in
pvr_queue_update_active_state(). A hard reset that starts while a job is
being submitted therefore deadlocks: the reset and the queue stay stuck,
and lockdep reports the circular dependency.

Take a context reference on each queue under queues.lock, move the queues
to a list of their own, and stop them after dropping the lock, as the
timeout handler already does. A queue whose context is already being
released has no jobs left and is skipped. post_reset() starts the same
queues and drops the references from a work item, because the last
reference releases the context, which takes reset_sem while the reset
still holds it.

Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/20260630095216.498D61F000E9@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Sashiko flagged this ABBA deadlock in June, in its review of the
drm_sched_entity_fini() fix, and I have hit it on an MT8173 tablet
(GX6250, BVNC 4.40.2.51), first through lockdep and once as a real hang.

Tested on that board with lockdep and a local debug hook that forces a
hard reset from the watchdog under glmark2, plus a 20 ms sleep in
run_job before it takes queues.lock to make the race certain. Without
this patch, the first forced reset gives lockdep's circular-dependency
report, the reset never completes, and the job timeout handler then
oopses on a NULL parent fence. With it, seven hard resets over two
boots (four forced, three that the watchdog started on its own) gave
no lockdep report and no hung task, and new GPU work ran correctly
afterwards.

This patch was developed with the help of an LLM.
---
 drivers/gpu/drm/imagination/pvr_device.h |  7 +++++
 drivers/gpu/drm/imagination/pvr_queue.c  | 50 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/imagination/pvr_queue.h  | 13 +++++++++
 3 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/imagination/pvr_device.h
index c246122b4caf..f495ee9234e6 100644
--- a/drivers/gpu/drm/imagination/pvr_device.h
+++ b/drivers/gpu/drm/imagination/pvr_device.h
@@ -236,6 +236,13 @@ struct pvr_device {
 		/** @queues.lock: Lock protecting access to the active/idle
 		 *  lists. */
 		struct mutex lock;
+
+		/**
+		 * @queues.resetting: Queues stopped by a hard reset, linked by
+		 *  pvr_queue::reset_node. Only used with @reset_sem held for
+		 *  writing.
+		 */
+		struct list_head resetting;
 	} queues;
 
 	/**
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 34b826381aa2..56751c192ce6 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1242,6 +1242,23 @@ static void reg_state_init(void *cpu_ptr, void *priv)
 	}
 }
 
+static void pvr_queue_reset_put_work(struct work_struct *w)
+{
+	struct pvr_queue *queue = container_of(w, struct pvr_queue, reset_put_work);
+
+	pvr_context_put(queue->ctx);
+}
+
+static void pvr_queue_reset_hold(struct pvr_queue *queue, struct list_head *list)
+{
+	/* A put still pending from the last reset hands its reference over. */
+	if (!cancel_work(&queue->reset_put_work) &&
+	    !pvr_context_get_if_referenced(queue->ctx))
+		return;
+
+	list_add_tail(&queue->reset_node, list);
+}
+
 /**
  * pvr_queue_create() - Create a queue object.
  * @ctx: The context this queue will be attached to.
@@ -1375,6 +1392,9 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 	if (err)
 		goto err_sched_fini;
 
+	INIT_LIST_HEAD(&queue->reset_node);
+	INIT_WORK(&queue->reset_put_work, pvr_queue_reset_put_work);
+
 	mutex_lock(&pvr_dev->queues.lock);
 	list_add_tail(&queue->node, &pvr_dev->queues.idle);
 	mutex_unlock(&pvr_dev->queues.lock);
@@ -1402,26 +1422,39 @@ struct pvr_queue *pvr_queue_create(struct pvr_context *ctx,
 
 void pvr_queue_device_pre_reset(struct pvr_device *pvr_dev)
 {
+	struct list_head *resetting = &pvr_dev->queues.resetting;
 	struct pvr_queue *queue;
 
+	lockdep_assert_held_write(&pvr_dev->reset_sem);
+
+	/*
+	 * drm_sched_stop() waits for the run_job work, which takes
+	 * queues.lock, so it can't be called with queues.lock held. Pin the
+	 * queues and stop them without it. A queue whose context is already
+	 * being released has no jobs left, so it needs no stopping.
+	 */
 	mutex_lock(&pvr_dev->queues.lock);
 	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
-		pvr_queue_stop(queue, NULL);
+		pvr_queue_reset_hold(queue, resetting);
 	list_for_each_entry(queue, &pvr_dev->queues.active, node)
-		pvr_queue_stop(queue, NULL);
+		pvr_queue_reset_hold(queue, resetting);
 	mutex_unlock(&pvr_dev->queues.lock);
+
+	list_for_each_entry(queue, resetting, reset_node)
+		pvr_queue_stop(queue, NULL);
 }
 
 void pvr_queue_device_post_reset(struct pvr_device *pvr_dev)
 {
-	struct pvr_queue *queue;
+	struct pvr_queue *queue, *tmp;
 
-	mutex_lock(&pvr_dev->queues.lock);
-	list_for_each_entry(queue, &pvr_dev->queues.active, node)
-		pvr_queue_start(queue);
-	list_for_each_entry(queue, &pvr_dev->queues.idle, node)
+	lockdep_assert_held_write(&pvr_dev->reset_sem);
+
+	list_for_each_entry_safe(queue, tmp, &pvr_dev->queues.resetting, reset_node) {
 		pvr_queue_start(queue);
-	mutex_unlock(&pvr_dev->queues.lock);
+		list_del_init(&queue->reset_node);
+		queue_work(pvr_dev->sched_wq, &queue->reset_put_work);
+	}
 }
 
 /**
@@ -1489,6 +1522,7 @@ int pvr_queue_device_init(struct pvr_device *pvr_dev)
 
 	INIT_LIST_HEAD(&pvr_dev->queues.active);
 	INIT_LIST_HEAD(&pvr_dev->queues.idle);
+	INIT_LIST_HEAD(&pvr_dev->queues.resetting);
 	err = drmm_mutex_init(from_pvr_device(pvr_dev), &pvr_dev->queues.lock);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index 149cc6d124bf..d46e9bb7b4f8 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -90,6 +90,19 @@ struct pvr_queue {
 	/** @node: Used to add the queue to the active/idle queue list. */
 	struct list_head node;
 
+	/**
+	 * @reset_node: Used to add the queue to pvr_device::queues::resetting
+	 * while a hard reset has it stopped. The queue holds a reference on
+	 * its context while it is on that list.
+	 */
+	struct list_head reset_node;
+
+	/**
+	 * @reset_put_work: Drops the context reference taken by a hard reset.
+	 * Context release can't run under pvr_device::reset_sem.
+	 */
+	struct work_struct reset_put_work;
+
 	/**
 	 * @in_flight_job_count: Number of jobs submitted to the CCCB that
 	 * have not been processed yet.

---
base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804
change-id: 20261125-rbrue-suez-pvr-pre-reset-lock-e2d7f7a44211

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

