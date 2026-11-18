Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D4606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XCbtDOq/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2540510FECE;
	Wed, 18 Nov 2026 17:10:21 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B26410EC56
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:10:06 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e29c25101so645492f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795021805; x=1795626605;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZBQLeUFC+EGxTcD0YG8dcZStfxcjShj56XwSxsyD+4E=;
 b=XCbtDOq/+VyvhZSTvTrUAbrEEvbKK1ZxqnrIZegA1jELGhNLgg60qnyairF8KA88+B
 hP4W9kjatdWODZoL8yhFg1lBRYNfrcGphK/clvyMFCrzHzw0h7VPRzxqt8DD3UMjiyg9
 jyH4HvGVZJ44o26esA5NVTA5i/etXH3kPSWNPemRWRdNZML+8xgBQMw/f+3WyUXCKa49
 eSQGhYmFjt5rbIHTSazWrOIF71+gL6xcn9E39PP6rrmejDDo296yIdO6+UuLFA+iGk7K
 J7azIMGCmxqB7bDrInXDNM331GM7MC/84IpJqxBh+5nuri133g8QaGMf4CjqHhND6elz
 Rkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795021805; x=1795626605;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZBQLeUFC+EGxTcD0YG8dcZStfxcjShj56XwSxsyD+4E=;
 b=VAswiqNHn8j1QBmz0bZJIV99B6evnrzpz3+q7GlLLsl0hqILhtSKy8XmngeQFO903F
 0PAPYEwzckOfTmT6DCrSbUPfIcshDU/MHSqR1TMVdOLpS5YebGSwVGOS+BH5oBh/IzsB
 +CL7C8kCaZhzTA00mev3+B4qoqsmfnOgyUne/RkrJ37Oaub7NOHugLfWghnepRs4jF9I
 hd9LbjzusowOH8ZAyiuxD0K0MvMNIdxOGwZmMUmP5dyRz6f8X0NLb12jLV642TurEjZO
 ely2Y/Fl/dYbJKDkUVAjvRulwEivQEeJ4enXjTHubMrmihAfovwK0BeViT74rItkzQFy
 j1Zw==
X-Forwarded-Encrypted: i=1;
 AL+hErFGuQb6sfvc/MWZD2BCLrhSOgDzGIn02jXlII/O0tPEE/CvURWS4RcMeBotB/WziUTjFOWHfYIPA1U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8gjzWWKU60dMPAaLjIDcneF3fsUU1c747b4tEnfiSZ6OKkHUbm
 PfcWZUAzhoiPxeaUEUm4l4RjQ1UxM4nnphAq20CbYFxUlGf/4gbXukD8OQUv0oeu54PuGL59742
 nKBqhXESbQmBoH99/1g==
X-Received: from wrmy18.prod.google.com ([2002:adf:e6d2:0:b0:48e:8481:c6ad])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2210:b0:48f:d7cd:a5ac with SMTP id
 ffacd0b85a97d-4a62d6d4ca5mr7655574f8f.0.1795021804316; 
 Wed, 18 Nov 2026 09:10:04 -0800 (PST)
Date: Wed, 18 Nov 2026 17:09:51 +0000
In-Reply-To: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4299; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=utE9D0DUrvzxak4uVxnykRd3EoPT8zB0LcKz7hGMs34=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/dvo0nIOWmUoYahY2hKEfcj5qkiNkVGFSyQY+
 Nzw6sJHkT+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav3b6AAKCRAEWL7uWMY5
 RqNcD/9nMuAC9ogBuQ+g/67v1kbmFenSkpIBWciyy4iighlDS+WYaVya6OR4wOHbcA501p0jsAS
 G9eRzbRUma7y/lDNGAcH21acegjrMFDG4wIpCc+3K1SwTSCRw9udPAAgbSLuZsTTuC5OWpMaaJD
 JsO53Tf1oPjD/Bi/AQjxYfabEkDerQcO0lqGxh7HQ/9r/Pn1TnUz4pOAy393i6A+AOkUOGi/0If
 FQ5Fot3eWtXdA+BLsS0bJBZhnkpBdgvNj9f5bVe1LMNzZk2lJXHXKrpC0s81dSfjYIpyubFCgYG
 elpiusD3N9kNTgdO/+8wPCnS8nHa7FbjzS1EhuSZOVMvOaQUmEEEI9XrsRZJrCR4WrcRcov5T4V
 8tu8BznsK35tULFKkgvXjaIWShOo1yo/fyyYvE+xs3dCrBwTCNpSNlczyugia2tPZ1t2DcxZKKt
 /Xvm1sIfIB7E4qyxlvxq2SNtvUxYiKCDUkXxy4mPrzCGQktMyCbcU4YXh3BX59Cr71mJZBXaxeD
 rsd23Bdw3TtKmvl90D8VzTw5hGuiprT+nGiqRd33M647/pzbJBXDrkm/JkFcpLAbkJ+dI6o66BG
 BH1XnO6hq0f5c2dByxtSOcaREQ/sHtvNsFplRPCbfLTubji9HeO+kt3jDfl7qFs5z3mQf1UfM/J
 luL72X5xY4k9ONg==
X-Mailer: b4 0.14.3
Message-ID: <20261118-ordered-wq-cancel-v1-1-916e01f9affe@google.com>
Subject: [PATCH 1/2] workqueue: fix cancel_work_sync() on ordered workqueues
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>, 
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_PDS_OTHER_BAD_TLD,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is currently a scenario where cancel_work_sync() /
disable_work_sync() does not wait for the work to finish execution on an
ordered workqueue (__WQ_ORDERED). This is because ordered workqueues
contain multiple workqueues internally (pwqs). Consider the following
scenario:

1. @work starts executing on pwq A (pool A), the oldest and only
   unplugged pwq in wq->pwqs.
2. Writing a new cpumask to /sys/devices/virtual/workqueue/cpumask
   allocates a new dfl_pwq (pwq B, backed by pool B) with
   pwq->plugged = true and appends it to wq->pwqs behind pwq A.
3. While @work is still executing on pool A, it is re-queued to the same
   ordered workqueue. Unlike normal workqueues, __queue_work() skips
   last_pool redirection on ordered workqueues so re-queued items do not
   jump ahead of work already waiting on pwq B, so @work is placed on
   pwq B->inactive_works and work->data is overwritten to point to
   pwq B.
4. cancel_work_sync() or disable_work_sync() steals @work from pwq B,
   and try_to_grab_pending() records pwq B->pool->id (pool B) in
   work->data.
5. start_flush_work() only inspects the single pool recorded in
   work->data (pool B, where @work has never executed), finds no worker
   running @work, and returns while @work is still executing on pool A.

Unfortunately, this scenario can lead to UAF if a driver uses
cancel_work_sync() and then frees the work item (or resources used by
the work item). And this happens on ordered workqueues in practice:

- drm/sched: drm_sched_wqueue_stop() calling cancel_work_sync() on
  work_run_job and work_free_job before scheduler teardown.
- drm/xe: gt_worker_disable() calling disable_work_sync() on
  gt->reset.worker and gt->wedge.worker.
- drm/panthor: panthor_device_suspend() calling cancel_work_sync() on
  ptdev->reset.work before suspending hardware.

Thus, fix try_to_grab_pending() to record the pool of the oldest pwq in
wq->pwqs when stealing a pending work item from an ordered workqueue, so
start_flush_work() flushes pool A and waits for @work to finish. If
@work is not actually executing on pool A, find_worker_executing_work()
simply returns NULL.

It is also needed for the soundness of the upcoming Rust ScopedWork
abstraction, which binds a work item to a single workqueue and relies on
cancel_work_sync() in Drop to guarantee that data borrowed by the work
item is no longer accessed once drop() returns.

Cc: stable@vger.kernel.org
Fixes: 58629d4871e8 ("workqueue: Always queue work items to the newest PWQ for order workqueues")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 kernel/workqueue.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index af845214e78b..d7acedfb8b27 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2263,6 +2263,7 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
 		unsigned long work_data = *work_data_bits(work);
+		struct worker_pool *offq_pool = pool;
 
 		debug_work_deactivate(work);
 
@@ -2288,9 +2289,24 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 		/*
 		 * work->data points to pwq iff queued. Let's point to pool. As
 		 * this destroys work->data needed by the next step, stash it.
+		 *
+		 * For ordered workqueues, __queue_work() skips last_pool
+		 * redirection so @pwq may be plugged while @work is still
+		 * executing on the oldest pwq after a cpumask update. Only the
+		 * oldest pwq is unplugged and can be executing @work, so record
+		 * its pool instead.
 		 */
-		set_work_pool_and_keep_pending(work, pool->id,
-					       pool_offq_flags(pool));
+		if (unlikely(pwq->wq->flags & __WQ_ORDERED)) {
+			struct pool_workqueue *oldest_pwq =
+				list_first_or_null_rcu(&pwq->wq->pwqs,
+						       struct pool_workqueue,
+						       pwqs_node);
+
+			if (oldest_pwq)
+				offq_pool = oldest_pwq->pool;
+		}
+		set_work_pool_and_keep_pending(work, offq_pool->id,
+					       pool_offq_flags(offq_pool));
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);

-- 
2.56.1.703.gf848ed807c-goog

