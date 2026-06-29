Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B90C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94E6110E728;
	Mon, 29 Jun 2026 07:22:09 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050C610E728
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:22:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53D2E6001D;
 Mon, 29 Jun 2026 07:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA57F1F000E9;
 Mon, 29 Jun 2026 07:22:07 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Memory leak error in qxl unbind
To: =?utf-8?b?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628154051.232214-1-megia.oscar@gmail.com>
References: <20260628154051.232214-1-megia.oscar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 07:21:51 +0000
Message-Id: <20260629072207.EA57F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unchecked `list_lru_init()` return value in `ttm_pool_type_init()`=
 causes a deterministic NULL pointer dereference in the newly added error p=
ath.
- [High] Concurrent debugfs access during module unload or initialization f=
ailure causes a NULL pointer dereference due to a teardown race introduced =
by the patch.

Pre-existing issues:
- [High] `ttm_global_init()` leaks the registered shrinker and list_lrus if=
 `alloc_page()` fails.
--

commit e23de1fd240385312484194a68f533845be6969a
Author: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>

    Memory leak error in qxl unbind

This commit fixes a memory leak and refcount corruption during OOM conditio=
ns
by adding error handling for ttm_pool_mgr_init() in ttm_global_init() and
properly cleaning up pool types if shrinker_alloc() fails.

Link: https://lore.kernel.org/virtualization/20260627105445.89827-2-megia.o=
scar@gmail.com/T/#u

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_dev=
ice.c
index d3bfb9a696a74..c880a04303635 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,10 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
=20
-	ttm_pool_mgr_init(num_pages);
+	ret =3D ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
+
 	ttm_tt_mgr_init(num_pages, num_dma32);
=20
 	glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32 |

[Severity: High]
This is a pre-existing issue, but does the error path for alloc_page() leak
the registered shrinker?

If alloc_page() fails in ttm_global_init(), the code jumps to out: and retu=
rns
-ENOMEM without calling ttm_pool_mgr_fini(). This permanently leaks the
previously registered mm_shrinker.=20

Because the global mm_shrinker pointer is overwritten on a subsequent retry,
the leaked shrinker is never freed. When the ttm module is unloaded, the
leaked shrinker remains registered with the MM subsystem. Any subsequent me=
mory
pressure will invoke the shrinker callback pointing to unloaded module text,
crashing the system.

[ ... ]
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11add..e0c82804a07d5 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
[ ... ]
@@ -1434,6 +1448,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	shrinker_register(mm_shrinker);
=20
 	return 0;
+
+err_shrinker:
+	ttm_pool_type_fini_and_list_lru_destroy();

[Severity: High]
Can ttm_pool_type_fini_and_list_lru_destroy() cause a NULL pointer derefere=
nce
here if list_lru_init() previously failed?

ttm_pool_type_init() ignores the return value of list_lru_init(). If it fai=
ls
due to memory pressure, pt->pages.node remains NULL.

This new err_shrinker path invokes ttm_pool_type_fini(), which unconditiona=
lly
calls list_lru_walk(). list_lru_walk() dereferences lru->node, which would
crash the system on the NULL pointer.

+	return ret;
 }
=20
 /**
@@ -1442,17 +1460,24 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  * Cleanup the global pools and unregister the MM shrinker.
  */
 void ttm_pool_mgr_fini(void)
+{
+	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy();

[Severity: High]
Does this introduce a race condition with debugfs access?

By destroying the list_lru structures here, their nodes are set to NULL.
However, ttm_pool_mgr_fini() executes before debugfs_remove() in
ttm_global_release() (and before the out: label cleanup in ttm_global_init(=
)).

If a user concurrently reads the /sys/kernel/debug/ttm/page_pool file,
ttm_pool_debugfs_globals_show() invokes list_lru_count(). Since
list_lru_destroy() has already set lru->node to NULL, the count function wi=
ll
dereference the NULL pointer.

+	WARN_ON(!list_empty(&shrinker_list));
+}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628154051.2322=
14-1-megia.oscar@gmail.com?part=3D1
