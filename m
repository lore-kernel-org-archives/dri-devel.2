Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4049606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ifB4zTbM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D398010FC00;
	Wed, 25 Nov 2026 12:03:21 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E415510FC06
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 12:03:15 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1f03f2e8aso49701245e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795608194; x=1796212994;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zmdVCyES1Z5dR10b8jDmGep4AsueZq3jndQhX7uyqEA=;
 b=ifB4zTbMjAZ3ADAB0e2THT1Y4dJReXvAR55b12rER7qTfsDXSkrXq0fYcPwbDIVS+M
 Htj0R2jr6JDu5/EbFQUkfcHMyvhMVYSNICUVSJ/v8UHIQRblRXWc5/2BjCH9YYHdnb/H
 hcNdamNPE0b7L/ZT+vM9+pD37RtfyNMz7Tj81Qgjpq1TrqNLkbOys7cW6Qquqm4EzLza
 q/9LasW5Se8fDLYJeqTATlC2GIwWMTb5pT/IBrhTow1RCBymi3nIwmjhf0rfytMEfMK4
 SKXJTvBEu8ZyOiilIXOPsilFwOPu6cylayVkS8NjiJwwL+1YysX5J+1d0q2ASzPFYPfk
 I4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795608194; x=1796212994;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zmdVCyES1Z5dR10b8jDmGep4AsueZq3jndQhX7uyqEA=;
 b=gc3gisxEwoFnWCdJolM8/tDXfcDjOr6euXbCxytZXXDwtLMTowy5wHIPBDoAtegl5O
 agDeYjGm8g6lKhp8TzRXUTa1jUe9XG5Zsxto7GgQ8SJ8FpP1O550NnoPJ3Hmds7c+KP6
 HAYOfqbYCiuVAMtPsO0PX8F2kNgWNALEI6KGZOPBvt7F0VFETHFuH7UsYBgezEBG+Xjg
 gCvQ/GLaJn5PsK840oM8TvI9czwVkRBnRfR5c1nA8HFhhN1fcbbVBCLB/hycwclCrohf
 PIjFmUtHsgbBl3kmd541ziBo4vzUbs0GL4f94ungfw/TpNnDWnkXp4tuyDy+4qHCzBBD
 hV4A==
X-Forwarded-Encrypted: i=1;
 AL+hErFCB6GDTeVjAlw4bGdnGmFV8h4QaNGJkWjTC0qTEnSFRZaGmiv2vvcQ30Qdy2/Y+7TIhf0YisIWQ2s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+QZTj8jYUE3NI3pl91cZkgwcoON39rnetOpPVHLbrNHAwm+Bhm
 WSIPT0hCNIbXG2x/9f3n637kw6S7n6Oojro0M6U2TKDgpjnTWTd0HiwU4ivsKr8qyge/KhwSM5J
 hzeKBsZL4pejKZGQIww==
X-Received: from wmfq11.prod.google.com ([2002:a05:600c:2e4b:b0:4a3:5dec:ff72])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:e40b:b0:4bb:9a6c:8712 with SMTP id
 5b1f17b1804b1-4bb9a6c8724mr143643655e9.12.1795608194039; 
 Wed, 25 Nov 2026 04:03:14 -0800 (PST)
Date: Wed, 25 Nov 2026 12:03:05 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHjOBmsC/32NQQ6CMBBFr0Jm7ZhONURceQ/DopZfaIJUWoMa0
 rtbOYDL95L//koJ0SPRuVopYvHJh6mA3lVkBzP1YN8VJq10LSInDrFDRMevma2ZLEauDzeloRy
 MPVLZPSKcf2/Na1t48OkZ4me7WORn/9UWYcWN1FDiGuMcLn0I/Yi9DXdqc85fo7B99rMAAAA=
X-Change-Id: 20261118-ordered-wq-cancel-63b02e0feac4
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4860; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=MEqp6I5oT2DwwWG++mrJvLdQqFqXXQNSXG2o5tVy1A4=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBrBs597HHdRB4YFrPM62zg+Un1OBq5rHO+JQWi5
 ndixzfGysqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCawbOfQAKCRAEWL7uWMY5
 RsjWD/93B2e6uccyr9nPTBtpWLMQMe79t5s8KHITEgNqBTKW5udxk2H7X1Bp5+7YH06jKqilyKO
 /IuIQ0hXXTC2kgwqQr3rX/7QgriAet8Neg4Hv2pu92ezFhiKeTujBOolRBvbf097wkzfUz2bAph
 vBHDETsqbE+jmTwNfZqSa1kwhVbMpkcTirDhyiBvzQ/Nitg1Qb8b+iC9LQ/dUObn//dh+7xIsEw
 NuS263rYySpa+2kiVGVFwZA/MWwQpPeEX/I3Fh9CA5OjPvy3CFncddjQFWhMqlPCKcexnVe3EhJ
 hyqnbR8fGRe9HTvYS4qy965R/mY29ExbeC7K+7GyXOMtBr764QvnZGJtxYmhKY/PhdBhUTuBpPU
 2z9msTMWyH5PSW4Gr4066nhFnk675S2eLLJH4C9FepAF5nJ7Lh7vYNSUstfwkxwYA+jCVtn+9BV
 L0vltE8nUVTRsWOrDvClJMQO3PhmBFNAGB8ZUMJOSCulUa5/w01vqUMgf6jidSS8rm26k/v50Cl
 7osTn6PxAv2wFFnY85/QxpK74fssMnmT5o6jRMrO0JdH8XDs5HB0BSrArc0kn7ZGbTL4X3tbfir
 FfReMYRlbEP9yfel5EuuITyXdQa2jdNKYCx2zoFVIZBr2l1sas5fB4jkvMyeNU7ArBH3UWejeY/
 LU2qI2Dc7wNAO/w==
X-Mailer: b4 0.14.3
Message-ID: <20261125-ordered-wq-cancel-v2-1-13620a09773f@google.com>
Subject: [PATCH v2] workqueue: fix cancel_work_sync() on ordered workqueues
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
This came up while figuring out what to do about this sashiko review:
https://sashiko.dev/#/patchset/20261020-rust-workqueue-v3-0-ea7c74d02068%40google.com
---
Changes in v2:
- Drop patch 2 ("workqueue: doc: clarify cancel_work_sync() cross-workqueue
  behavior"), already applied to wq/for-7.5 by Tejun Heo.
- Use list_entry_rcu(pwq->wq->pwqs.next, ...)->pool in try_to_grab_pending()
  without the redundant NULL check, per Tejun Heo.
- Link to v1: https://lore.kernel.org/r/20261118-ordered-wq-cancel-v1-0-916e01f9affe@google.com
---
 kernel/workqueue.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index af845214e78b..9566e8822686 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2263,6 +2263,7 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
 	pwq = get_work_pwq(work);
 	if (pwq && pwq->pool == pool) {
 		unsigned long work_data = *work_data_bits(work);
+		struct worker_pool *offq_pool = pool;
 
 		debug_work_deactivate(work);
 
@@ -2288,9 +2289,18 @@ static int try_to_grab_pending(struct work_struct *work, u32 cflags,
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
+		if (unlikely(pwq->wq->flags & __WQ_ORDERED))
+			offq_pool = list_entry_rcu(pwq->wq->pwqs.next, struct pool_workqueue,
+						   pwqs_node)->pool;
+		set_work_pool_and_keep_pending(work, offq_pool->id,
+					       pool_offq_flags(offq_pool));
 
 		/* must be the last step, see the function comment */
 		pwq_dec_nr_in_flight(pwq, work_data);

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261118-ordered-wq-cancel-63b02e0feac4

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

