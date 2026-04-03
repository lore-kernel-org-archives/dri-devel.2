Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C3CE85372
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 14:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58EBD10F372;
	Fri,  3 Apr 2026 14:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Mvw43mvB";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B7410F371
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775225596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7VPU0rCKfWfvPJl/4bosCPDJZ8iv97Cw6zG7IjIUB0=;
 b=Mvw43mvBveue6wUU4etsmb4EtRnjUYBj4bo1UKsZTpKeKvmVuZm46xXPF53caUFMCjLtzv
 pqARb/hvVXm1ylR5iG1HVzIU2/DAQuo8ioQQaI4Mpd80hKEd30DeVtw3QVhC32C3/MZU5u
 QgpXzoBRFvlbNp2kUIIU2dGjORILyVk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-McWhwWbGOhilAWqcCCDeQQ-1; Fri, 03 Apr 2026 10:13:15 -0400
X-MC-Unique: McWhwWbGOhilAWqcCCDeQQ-1
X-Mimecast-MFC-AGG-ID: McWhwWbGOhilAWqcCCDeQQ_1775225595
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-509044f54aaso55643271cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 07:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775225595; x=1775830395;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q7VPU0rCKfWfvPJl/4bosCPDJZ8iv97Cw6zG7IjIUB0=;
 b=mKVK15hm7zmfsekGhJUaukLzDCo8XvoLI1AHnsyt6zhjGHfUiMaCDxvFunFaSYdwFl
 RnUvgUCABs5u4qIEsvkFezEKLblf1VqwNf293Km59KSE6QbwV6mug9aXhCPjfKvHtKH5
 Cp5Hxr9vqxBVEueTYx0ihgAuLn844+kCU/39qIIa12u9qf1v6l/K5eYNqXQL7vOyN9Hr
 JcSiL30yYNQCGiX4huqu4BIMhH0HiqVA7WXwk/tpnccRAtwtsZ0B5MqoV0cR5lOeSrM0
 8/KezxZZ1awQu9AfHpG7BhMVu5rSUszfC5X/UN8iFkrrJSiM9PbVg+2Wdwvfl3LI6S5F
 QmiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4gl2PrHugb5HeWFq+9tfXImT8CCMIfTpGLnuOHYM/MxUkUiewvkI+GZLqPalW7Yw5dJhPMO9VJzA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEdza98W2nfGg0e7ZsyijxUkCB6+nnJI1PY34KN0PBYof5E6OJ
 O6SLp98DFG9YmDAGwirV2Zxggqlv7hqOkTTXocmlvCfeDd8mw4EXbeiHNmIdLRfP/rh/jSuG0eH
 /pAvDIgSsDGr2eU2IIaeqp9p0eYLXhCyKDdclcrEt2qgHCT5shJu3BAnW7X9KgDiqA5o9rQ==
X-Gm-Gg: ATEYQzxka96fdvsHLJhpHXp1lJ2vAWki2zgeHVHGG/TXuqwkK9w6uHBAnryUjrUMD8E
 bMS3SKA65F5BG9MzTE91kiazrO2vSjqOxbCD2A4K0UHSY3jz0F3c5YzD6j7wG9CrQGWcvsTzYGE
 O0STGeIvR176nlyd0LcWzLI5cc7D62VRFVw9HfDethrHipsDhZZHpBV4eLuC12eInun0rF340bY
 h336YDHu5qE+7tCqo9jIe4yBSMar4OCwp9LRy6Q6nc+3qpy4KIhc+TmPyjwwYiqSkMrg0yvM2Rs
 aURHYdrH01ganjAzwkX60/BAPikvupbz8c0r6KPv8HzhnuZO1lkmQQ8friZOv2MX0qF0pbtDjxr
 zc2MobpMhtcyCPgElw2Q0kRhx1/q9bsO4JkN/GD9b3eM5szqI9qCwhO/yl3uVMts=
X-Received: by 2002:a05:622a:1922:b0:509:2ef7:7048 with SMTP id
 d75a77b69052e-50d62cd74e1mr43969871cf.66.1775225594377; 
 Fri, 03 Apr 2026 07:13:14 -0700 (PDT)
X-Received: by 2002:a05:622a:1922:b0:509:2ef7:7048 with SMTP id
 d75a77b69052e-50d62cd74e1mr43969031cf.66.1775225593742; 
 Fri, 03 Apr 2026 07:13:13 -0700 (PDT)
Received: from localhost (pool-100-17-19-56.bstnma.fios.verizon.net.
 [100.17.19.56]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d4d9ad4b6sm40723031cf.15.2026.04.03.07.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 07:13:12 -0700 (PDT)
From: Eric Chanudet <echanude@redhat.com>
Date: Fri, 03 Apr 2026 10:08:36 -0400
Subject: [PATCH RFC 2/2] cgroup/dmem: add a node to double charge in memcg
MIME-Version: 1.0
Message-Id: <20260403-cgroup-dmem-memcg-double-charge-v1-2-c371d155de2a@redhat.com>
References: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
In-Reply-To: <20260403-cgroup-dmem-memcg-double-charge-v1-0-c371d155de2a@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, Eric Chanudet <echanude@redhat.com>
X-Mailer: b4 0.14.2
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1L3CePlX32RlvIh5QQzLZ-4zho6q2Aq00Q9-oKgXPkI_1775225595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Introduce /cgroupfs/<>/dmem.memcg to make allocations in a dmem
controlled region also be charged in memcg.

This is disabled by default and requires the administrator to configure
it through the cgroupfs before the first charge occurs.

The memcg is derived from the pool's cgroup, if it exists, since the
pool holds a ref to the dmem cgroup state keeping the cgroup alive and
stable.

The behavior is quirky. Since keeping track of each allocation would add
a fair amount of logic without solving the problem entirely, disable the
memcg switch once the first charge is issued. Having this as a dynamic
configuration doesn't seem relevant anyway.

Signed-off-by: Eric Chanudet <echanude@redhat.com>
---
 kernel/cgroup/dmem.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 83 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
index 9d95824dc6fa09422274422313b63c25986596de..b65ae8cf0c302ce3773a7aa5f0d6d8223d2c10c9 100644
--- a/kernel/cgroup/dmem.c
+++ b/kernel/cgroup/dmem.c
@@ -17,6 +17,7 @@
 #include <linux/refcount.h>
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/memcontrol.h>
 
 struct dmem_cgroup_region {
 	/**
@@ -76,6 +77,9 @@ struct dmem_cgroup_pool_state {
 
 	refcount_t ref;
 	bool inited;
+
+	bool memcg;
+	bool memcg_locked;
 };
 
 /*
@@ -162,6 +166,14 @@ set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
 	page_counter_set_max(&pool->cnt, val);
 }
 
+static void
+set_resource_memcg(struct dmem_cgroup_pool_state *pool, u64 val)
+{
+	/* Cannot change once a charge happened. */
+	if (!pool->memcg_locked)
+		pool->memcg = !!val;
+}
+
 static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
 {
 	return pool ? READ_ONCE(pool->cnt.low) : 0;
@@ -182,11 +194,17 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
 	return pool ? page_counter_read(&pool->cnt) : 0;
 }
 
+static u64 get_resource_memcg(struct dmem_cgroup_pool_state *pool)
+{
+	return pool ? READ_ONCE(pool->memcg) : 0;
+}
+
 static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
 {
 	set_resource_min(rpool, 0);
 	set_resource_low(rpool, 0);
 	set_resource_max(rpool, PAGE_COUNTER_MAX);
+	set_resource_memcg(rpool, 0);
 }
 
 static void dmemcs_offline(struct cgroup_subsys_state *css)
@@ -609,6 +627,20 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
 	return pool;
 }
 
+static struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *c)
+{
+	struct cgroup_subsys_state *css;
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	rcu_read_lock();
+	css = cgroup_e_css(c, &memory_cgrp_subsys);
+	rcu_read_unlock();
+
+	return mem_cgroup_from_css(css);
+}
+
 /**
  * dmem_cgroup_uncharge() - Uncharge a pool.
  * @pool: Pool to uncharge.
@@ -624,6 +656,13 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size)
 		return;
 
 	page_counter_uncharge(&pool->cnt, size);
+
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(pool->cs->css.cgroup);
+
+	if (pool->memcg && memcg)
+		mem_cgroup_uncharge_pages(memcg,
+					  PAGE_ALIGN(size) >> PAGE_SHIFT);
+
 	css_put(&pool->cs->css);
 	dmemcg_pool_put(pool);
 }
@@ -655,6 +694,8 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	struct dmemcg_state *cg;
 	struct dmem_cgroup_pool_state *pool;
 	struct page_counter *fail;
+	struct mem_cgroup *memcg;
+	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int ret;
 
 	*ret_pool = NULL;
@@ -670,7 +711,22 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 	pool = get_cg_pool_unlocked(cg, region);
 	if (IS_ERR(pool)) {
 		ret = PTR_ERR(pool);
-		goto err;
+		goto err_css_put;
+	}
+
+	pool->memcg_locked = true;
+	memcg = get_mem_cgroup_from_current();
+	if (pool->memcg && memcg) {
+		ret = mem_cgroup_try_charge_pages(memcg, GFP_KERNEL, nr_pages);
+		if (ret) {
+			/*
+			 * No dmem_cgroup_state_evict_valuable() could help,
+			 * there's no ret_limit_pool to return.
+			 */
+			ret = -ENOMEM;
+			dmemcg_pool_put(pool);
+			goto err_memcg_put;
+		}
 	}
 
 	if (!page_counter_try_charge(&pool->cnt, size, &fail)) {
@@ -681,14 +737,21 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
 		}
 		dmemcg_pool_put(pool);
 		ret = -EAGAIN;
-		goto err;
+		goto err_uncharge_memcg;
 	}
 
+	mem_cgroup_put(memcg);
+
 	/* On success, reference from get_current_dmemcs is transferred to *ret_pool */
 	*ret_pool = pool;
 	return 0;
 
-err:
+err_uncharge_memcg:
+	if (pool->memcg && memcg)
+		mem_cgroup_uncharge_pages(memcg, nr_pages);
+err_memcg_put:
+	mem_cgroup_put(memcg);
+err_css_put:
 	css_put(&cg->css);
 	return ret;
 }
@@ -846,6 +909,17 @@ static ssize_t dmem_cgroup_region_max_write(struct kernfs_open_file *of,
 	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_max);
 }
 
+static int dmem_cgroup_memcg_show(struct seq_file *sf, void *v)
+{
+	return dmemcg_limit_show(sf, v, get_resource_memcg);
+}
+
+static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
+				       size_t nbytes, loff_t off)
+{
+	return dmemcg_limit_write(of, buf, nbytes, off, set_resource_memcg);
+}
+
 static struct cftype files[] = {
 	{
 		.name = "capacity",
@@ -874,6 +948,12 @@ static struct cftype files[] = {
 		.seq_show = dmem_cgroup_region_max_show,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "memcg",
+		.write = dmem_cgroup_memcg_write,
+		.seq_show = dmem_cgroup_memcg_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
 	{ } /* Zero entry terminates. */
 };
 

-- 
2.52.0

