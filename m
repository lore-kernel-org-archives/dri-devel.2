Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3D3C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E25D710E2F7;
	Mon,  6 Jul 2026 05:25:06 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2E1110E2F7
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 05:25:05 +0000 (UTC)
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-VB9tyjgnNz2-lO-4WWS0DQ-1; Mon,
 06 Jul 2026 01:25:01 -0400
X-MC-Unique: VB9tyjgnNz2-lO-4WWS0DQ-1
X-Mimecast-MFC-AGG-ID: VB9tyjgnNz2-lO-4WWS0DQ_1783315500
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 172541955F7D; Mon,  6 Jul 2026 05:25:00 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D40CA1956096; Mon,  6 Jul 2026 05:24:52 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
 Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
 Waiman Long <longman@redhat.com>, simona@ffwll.ch,
 intel-xe@lists.freedesktop.org
Subject: [PATCH 09/10] ttm: add support for a module option to disable memcg
 integration
Date: Mon,  6 Jul 2026 15:22:38 +1000
Message-ID: <20260706052330.1110909-10-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
References: <20260706052330.1110909-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wnILd4kq-pbUrvzDptsIVSFwtajWppCgGuzSZG16KZs_1783315500
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

This adds a kconfig and a module option to turn off ttm memcg
integration completely.

When this is used, no object will ever end up using memcg aware
paths.

There is an existing workload that cgroup support might regress,
the systems are setup to allocate 1GB of uncached pages at system
startup to prime the pool, then any further users will take them
from the pool. The current cgroup code might handle that, but
it also may regress, so add an option to ttm to avoid using
memcg for the pool pages.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/Kconfig        |  7 +++++++
 drivers/gpu/drm/ttm/ttm_pool.c | 24 +++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f..35af2ff3450b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -257,6 +257,13 @@ config DRM_TTM_HELPER
 =09help
 =09  Helpers for ttm-based gem objects
=20
+config DRM_TTM_MEMCG
+=09bool "Enable TTM mem cgroup by default"
+=09depends on DRM_TTM
+=09depends on MEMCG
+=09help
+=09  Enable the memcg integration by default
+
 config DRM_GEM_DMA_HELPER
 =09tristate
 =09depends on DRM
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.=
c
index 01b6ff2d8144..b7263d26c990 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -119,6 +119,24 @@ static unsigned long page_pool_size;
 MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool pe=
r NUMA node");
 module_param(page_pool_size, ulong, 0644);
=20
+/*
+ * Don't use the memcg aware lru for pooled pages.
+ *
+ * There are use-cases where for example one application in a cgroup will =
preallocate 1GB
+ * of uncached pages, and immediately release them into the pool, for othe=
r consumers
+ * to use. This use-case could be handled with a proper cgroup hierarchy, =
but to allow
+ * that use case to continue to operate as-is, add a module option.
+ *
+ * This still stores the pages in the list_lru, it just doesn't use the me=
mcg when
+ * adding/removing them.
+ */
+#define DEFAULT_TTM_MEMCG IS_ENABLED(CONFIG_DRM_TTM_MEMCG)
+static bool ttm_memcg =3D DEFAULT_TTM_MEMCG;
+
+MODULE_PARM_DESC(ttm_memcg, "Allow using cgroups with TTM "
+=09=09 "[default=3D" __stringify(DEFAULT_TTM_MEMCG) "])");
+module_param(ttm_memcg, bool, 0444);
+
 static unsigned long pool_node_limit[MAX_NUMNODES];
 static atomic_long_t allocated_pages[MAX_NUMNODES];
=20
@@ -321,7 +339,7 @@ static void ttm_pool_type_give(struct ttm_pool_type *pt=
, struct page *p)
=20
 =09INIT_LIST_HEAD(&p->lru);
 =09rcu_read_lock();
-=09list_lru_add(&pt->pages, &p->lru, nid, page_memcg_check(p));
+=09list_lru_add(&pt->pages, &p->lru, nid, ttm_memcg ? page_memcg_check(p) =
: NULL);
 =09rcu_read_unlock();
=20
 =09atomic_long_add(num_pages, &allocated_pages[nid]);
@@ -370,7 +388,7 @@ static struct page *ttm_pool_type_take(struct ttm_pool_=
type *pt, int nid,
 =09struct page *page_out =3D NULL;
 =09int ret;
 =09struct mem_cgroup *orig_memcg =3D orig_objcg ? get_mem_cgroup_from_objc=
g(orig_objcg) : NULL;
-=09struct mem_cgroup *memcg =3D orig_memcg;
+=09struct mem_cgroup *memcg =3D ttm_memcg ? orig_memcg : NULL;
=20
 =09/*
 =09 * Attempt to get a page from the current memcg, but if it hasn't got a=
ny in it's level,
@@ -847,7 +865,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, stru=
ct ttm_tt *tt,
 =09bool allow_pools;
 =09struct page *p;
 =09int r;
-=09struct obj_cgroup *objcg =3D memcg_account ? tt->objcg : NULL;
+=09struct obj_cgroup *objcg =3D (ttm_memcg && memcg_account) ? tt->objcg :=
 NULL;
=20
 =09WARN_ON(!alloc->remaining_pages || ttm_tt_is_populated(tt));
 =09WARN_ON(alloc->dma_addr && !pool->dev);
--=20
2.54.0

