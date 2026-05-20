Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68660CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEDC10EF3A;
	Wed, 20 May 2026 07:13:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XMlWCcI5";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD9910E0A6
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 06:07:30 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-304106b1204so942663eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 23:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779257249; x=1779862049; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FkbUxOw9XQFqUtX2Z9eJ32TNe+t+n97l8FjGhNB6Arg=;
 b=XMlWCcI5tQQnL6TCcXJq6l4yIYZ2bEHFL26pbn4ufYpEjLdlB7jKiAogF4HexKdjYc
 w/qHa1olShE64cHYHcVIBLJAj4cOBYwBOMKetfe1IcylQMQnQ614WokHWpmM650wTWUN
 aiwFcMtdEKQzuU+FHfyNQwlAKpITbC0hJs1lPTANl8NfLGciXNGcAJtYbcQ3d1V93p+x
 0LIDiagO9KGcXko9tib5idKPkenXTZyIuOiMLSOGyIcCy98LqrH+a6pQ4FRgY7hdYNpP
 ppwTaGhKPgjo4KBNXxOPEvUtwigx59/uLFxBKaQvzkLx7pp/luTs7goBq6ziecbheVVO
 K2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779257249; x=1779862049;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkbUxOw9XQFqUtX2Z9eJ32TNe+t+n97l8FjGhNB6Arg=;
 b=K50Nh0X+zkMJ79a3oMPe9RbJSCkZn91Wiq7x9pXzbJey6u8HKf/hqSGMZALLejKfxZ
 TVoOubGEVJRMrcAUm71thLrr6rBBUEhei9xnF/UC5gI3Mhxq5jmPXdCidzzmkyykTQSA
 ki5q8L1a/3mRXtioKl2BDqlweiTAQXfxF1HNEMntntovGEt76UtwR4zJ2U92AUA+6jQ+
 3Jnzh8OC5LEYPUYALLk9qLfNEoOtEnlQErPfJ6SbJVTXK0jTKShO6/MpKjxXMycjesoB
 O6FBAbg9wH5ORpy74eiknj6dj5VC4cXJUpyDhiZRGSvmv7yykQAVjZVpJWXOvCU9DXNp
 qftw==
X-Forwarded-Encrypted: i=1;
 AFNElJ99/RGn8pwp9iFLA6q6V3+zW4c+DLQDzhavzMYWb3azm0k78lmN3YVu8l5reu/T9kISKTufCNxXfAA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxz+c4bNtL5yWUY9rx1TgsXTxJ77fDMWF4xTAif8tKGJLDnulko
 vbHdkiSghO3ZUYzis0WRxdOsyXs0U9kqBlVGP4MzVxatJlznsrP/5Ui3
X-Gm-Gg: Acq92OFImkM4y7isAZbgW/tqHkQ23AzEHy90u2VUImz9tDg5ueADiJtaaGBulj8WV+5
 1JZxeGfxyjYXDB6Un8W49Oonko/9jooU/k8mdyWWTrXK4IjL+vmUNEVjiwPVbydbDCnFxzOLGPm
 RMlRPgvbCGZ3Ef8/scNGeCpvQ4j4TMvzNNa/Gp/mSPeUwf4Ams8HVodlI4PtPm/WYC1rZD6XSzG
 QqR29x3x0JOKdMFb1QO2Tw3Pq9cclL6j0QnV+LHLOyA4KbYXBxm8VWNtV21UBtR1h8PI0Rg1CY3
 2roFr203bnnDiDH+3KA9mrM1R36pqhWLJPdEvlF6n0lGKAD7mIHDVdKB9OomPD1DtciUmAmO/2v
 UDBqv9obRuHEJCt5DzxUqWp9cVudiPo9WiWBzis66mTQ4BuQEGPaVNNfUcU9i/yQHE2ulFaS7Ba
 bA7poJ0lQIANg/981W4rk2MgLN7B7P3vGG6yw6ILmG5A==
X-Received: by 2002:a05:7301:600c:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-303982b788dmr10220464eec.8.1779257249365; 
 Tue, 19 May 2026 23:07:29 -0700 (PDT)
Received: from wujing.localdomain ([74.48.213.230])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30294500a97sm20885330eec.9.2026.05.19.23.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 23:07:29 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Wed, 20 May 2026 14:07:20 +0800
Subject: [PATCH] cgroup/dmem: implement dmem.high soft limit and throttling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBvIfiy7SrSQnHIWVmhFIN49a
 fkt3osQyDMFGIsInh4OfOwZoixgsXrfCNlkQ13VsuqEwpX0dXtC48ih5c2ikEr1oh3M0gyQu9P
 Tyu//nOaUPnDDIj9jAAAA
X-Change-ID: 20260519-feature-dmem-high-16997148dc38
To: Maarten Lankhorst <dev@lankhorst.se>, 
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

Introduce the "high" soft limit for the dmem cgroup v2 controller.
When a cgroup's device memory usage exceeds its high limit, tasks
belonging to that cgroup are throttled by being forced into a sleep
before returning to user space, instead of being failed outright
as with the "max" limit.

Key changes:
- Add high counter configuration to dmem_cgroup_pool.
- Add over-high check in the try_charge path and set TIF_NOTIFY_RESUME.
- Inject the dmem throttling handler into resume_user_mode_work.
- Implement the handler to perform a 100ms interruptible sleep for
  over-limit tasks.

This mechanism provides smoother over-subscription support for device
memory resources.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
This series introduces the "high" soft limit and associated task
throttling mechanism to the dmem cgroup v2 controller.

The device memory (VRAM) management currently only supports hard limits
(max), which leads to immediate allocation failures when reached. This
can be disruptive for GPU-bound AI workloads. By introducing a soft
limit, we allow cgroups to exceed their quota temporarily while
applying backpressure via task throttling before the process returns
to user space.

The mechanism is inspired by the memory cgroup's high limit:
- When usage > high, the task is marked with TIF_NOTIFY_RESUME.
- Upon returning to user space, it triggers a 100ms sleep.
- This provides a smoother over-subscription model for GPU resources.

Qiliang Yuan (1):

cgroup/dmem: implement dmem.high soft limit and throttling
---
To: Maarten Lankhorst <dev@lankhorst.se>
To: Maxime Ripard <mripard@kernel.org>
To: Natalie Vock <natalie.vock@gmx.de>
To: Tejun Heo <tj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
To: Michal Koutný <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/cgroup_dmem.h      | 10 +++++++
 include/linux/resume_user_mode.h |  2 ++
 kernel/cgroup/dmem.c             | 60 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
index dd4869f1d736e..d58972de7c910 100644
--- a/include/linux/cgroup_dmem.h
+++ b/include/linux/cgroup_dmem.h
@@ -21,6 +21,13 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 			   struct dmem_cgroup_pool_state **ret_pool,
 			   struct dmem_cgroup_pool_state **ret_limit_pool);
 void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
+void __dmem_cgroup_handle_over_high(void);
+
+static inline void dmem_cgroup_handle_over_high(void)
+{
+	__dmem_cgroup_handle_over_high();
+}
+
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
 				      bool ignore_low, bool *ret_hit_low);
@@ -51,6 +58,9 @@ static inline int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64
 static inline void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 { }
 
+static inline void dmem_cgroup_handle_over_high(void)
+{ }
+
 static inline
 bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
 				      struct dmem_cgroup_pool_state *test_pool,
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mode.h
index bf92227c78d0d..afcab20998c41 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -8,6 +8,7 @@
 #include <linux/memcontrol.h>
 #include <linux/rseq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/cgroup_dmem.h>
 
 /**
  * set_notify_resume - cause resume_user_mode_work() to be called
@@ -58,6 +59,7 @@ static inline void resume_user_mode_work(struct pt_regs *regs)
 
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
+	dmem_cgroup_handle_over_high();
 
 	rseq_handle_slowpath(regs);
 }
diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 4753a67d0f0f2..f77c692b887b1 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -15,6 +15,7 @@
 #include <linux/page_counter.h>
 #include <linux/parser.h>
 #include <linux/refcount.h>
+#include <linux/resume_user_mode.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
 
@@ -156,6 +157,12 @@ set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_low(&pool->cnt, val);
 }
 
+static void
+set_resource_high(struct dmem_cgroup_pool_state *pool, u64 val)
+{
+	page_counter_set_high(&pool->cnt, val);
+}
+
 static void
 set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 {
@@ -167,6 +174,11 @@ static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
 }
 
+static u64 get_resource_high(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->cnt.high) : 0;
+}
+
 static u64 get_resource_min(struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.min) : 0;
@@ -186,6 +198,7 @@ static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
 	set_resource_low(rpool, 0);
+	set_resource_high(rpool, PAGE_COUNTER_MAX);
 	set_resource_max(rpool, PAGE_COUNTER_MAX);
 }
 
@@ -685,6 +698,9 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		goto err;
 	}
 
+	if (page_counter_read(&pool->cnt) > READ_ONCE(pool->cnt.high))
+		set_notify_resume(current);
+
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
@@ -835,13 +851,24 @@ static ssize_t dmem_cgroup_region_low_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_low);
 }
 
+static int dmem_cgroup_region_high_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_high);
+}
+
+static ssize_t dmem_cgroup_region_high_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes, loff_t off)
+{
+	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_high);
+}
+
 static int dmem_cgroup_region_max_show(struct seq_file *sf, void *v)
 {
 	return dmemcg_limit_show(sf, v, get_resource_max);
 }
 
 static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
-				      char *buf, size_t nbytes, loff_t off)
+					  char *buf, size_t nbytes, loff_t off)
 {
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_max);
 }
@@ -868,6 +895,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_low_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "high",
+		.write = dmem_cgroup_region_high_write,
+		.seq_show = dmem_cgroup_region_high_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{
 		.name = "max",
 		.write = dmem_cgroup_region_max_write,
@@ -877,6 +910,31 @@ static struct cftype files[] = {
 	{ } /* Zero entry terminates. */
 };
 
+void __dmem_cgroup_handle_over_high(void)
+{
+	struct dmemcg_state *dmemcs;
+	struct dmem_cgroup_pool_state *pool;
+
+	dmemcs = css_to_dmemcs(task_get_css(current, dmem_cgrp_id));
+	if (!dmemcs)
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pool, &dmemcs->pools, css_node) {
+		unsigned long usage, high;
+
+		usage = page_counter_read(&pool->cnt);
+		high = READ_ONCE(pool->cnt.high);
+
+		if (usage > high)
+			schedule_timeout_killable(HZ / 10);
+	}
+	rcu_read_unlock();
+
+	css_put(&dmemcs->css);
+}
+EXPORT_SYMBOL_GPL(__dmem_cgroup_handle_over_high);
+
 struct cgroup_subsys dmem_cgrp_subsys = {
 	.css_alloc	= dmemcs_alloc,
 	.css_free	= dmemcs_free,

---
base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
change-id: 20260519-feature-dmem-high-16997148dc38

Best regards,
-- 
Qiliang Yuan <realwujing@gmail.com>

