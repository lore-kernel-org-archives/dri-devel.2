Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CD5606A33F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=Y0qc1WF5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AC9112509;
	Thu, 19 Nov 2026 15:02:46 +0000 (UTC)
Received: from outbound.st.icloud.com (st-2002d-snip4-11.eps.apple.com
 [57.103.78.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDAA1124F7
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 15:02:39 +0000 (UTC)
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPS id
 4280F180034F; Thu, 19 Nov 2026 14:43:45 +0000 (UTC)
X-ICL-RepId: 01a1f443-79c3-7b8a-a1fe-3efd2e82b56a
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai;
 t=1795099425; x=1826635425; bh=AagRrfKECoq+IXnrLSLY0IQQP1RVQocUwji3lBocfcY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=Y0qc1WF5zdwRp1SMB0pEp3ls1o3Q6qKZY/Wvw1zrftReJplfMmZ4njV5aGIMZZqIKNXTdgCFXdqriuBAbMLg2+YUplY9uG9ywnpK075IFR4+2hSTg5+H3vR/aN09XU6umn7K1O9xTwQ4XStUBJsd260iJ1g28svb9dyHmGDTyY7k5+ajrWhA7LTdNkjS9/P8BUz8u4PosIJygHLkWmo+SODvPU7XeTsW5bdWGrDRyKBG1DbpjttAwtQG65DCicJ+P2w+DgBHdq/LzpiEphfeOBYO7kL43Lgvn84GqrAjqX4zS8UQiOM0+LM2coEEkVNPvIA1V/aeBwA44tk5/t/02Q==
mail-alias-created-date: 1440949576000
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-1 (Postfix) with ESMTPSA id
 3F8B618000A7; Thu, 19 Nov 2026 14:43:42 +0000 (UTC)
From: Aleksei Riapolov <tsbol@icloud.com>
To: mwen@igalia.com,
	mcanal@igalia.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/v3d: Fix double free of the sg_table when a PRIME
 import fails
Date: Thu, 19 Nov 2026 18:43:39 +0400
Message-ID: <20261119144339.43896-1-tsbol@icloud.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1OCBTYWx0ZWRfX4S1TpsbWDdF/
 tN//RJTwGKKaI9YAaHy3Ko8eHFgjVTq2yAYXAK5SiFX4l487ZwcAnZTN3Keeb8KR4ykFZMMSisO
 P+y4B6LEGIPQNKNHVOrVhoXCnEKyS9toi096aIA0z1C8FPN0LKYtxdOf5gfCTrM1Ffn2+w9T6n3
 IyGnI2OiCXV/U00lwFZ9wWhADKAi2NXOnEM59Z8u62z3AEUGDd0+MWa+QucnscKvFzjxSm7FQ/R
 Ptkpe9u4Cz9GCaw+QQ/6d0VL8LPUSJfC0Z7qPYRNZxwEvyOh/j5qCaeWTtb/xe6ynKzuVQ451XG
 f37UjpiWXXouM8gN/7t+vGHIgCNXI3TqrWia9+dMT/OJl7AuDWOiXPjYC/ArfM=
X-Proofpoint-GUID: g22B1CVcR50BvXViFy-jep6oXr0v0Deu
X-Proofpoint-ORIG-GUID: g22B1CVcR50BvXViFy-jep6oXr0v0Deu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1OCBTYWx0ZWRfX+YFiErEPSpKr
 ski/iK+0IdG1rVATDMH0Ji3l/xC21lVelDCDEU3RTAMQaskRw+7SqHCf5tVhbDNLR+g7NHMS4gl
 tBAt3tZcpG5osKdsYKwX/LdoX79mLsc=
X-Authority-Info-Out: v=2.4 cv=J7E/fwnS c=1 sm=1 tr=0 ts=6aff0b21
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=x7bEGLp0ZPQA:10 a=RjkQatE54OUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fajnDIswKVxD1YtQT70F:22 a=66zDSPFCUvy2ELiaIz_N:22 a=VwQbUJbxAAAA:8
 a=v3ZZPjhaAAAA:8 a=V2sgnzSHAAAA:8 a=NZweb_V9ztsy_TvW2F0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Z31ocT7rh6aUJxSkT1EX:22
X-JNJ: AAAAAAABVxeswg63mcG/vtPNAfSmr6bmvvRsMpEemkSaL1M+3Rt8D/JcRiAy42/QcdVU+l
 YzQMgZ+dvkuYDv3cI/SmAcvKIiifHTCQTf1wrBqBksFMxa2JAEnmmcUiZur+1cgL5IzL22
 qapMIpFP7+gtaU4bDHLHnfHlvLlxw0dECj8r4cKrIQZTCXU8krk7Y1tSNke1iTxu+brNIb
 azFx+UeS0yYg+6u7/wP7qLfkz0YkagmjspuN1m+KtNFULNh/HLTsffrd4cojDPJDyf8/Dj
 KwcqGO04QHMbpccmewiRfkeMEU0Pk0L2drqTjzFQdhltgiN7w42LiJi4gICJfOGpTwNxfH
 Zk45ZrVKNubBz2NKcrDKa1gn5Ek01Bc1yol4tkuYgLUDB5bXmjo14D45gaDw6c3nuhjz21
 loE6alS9K61NrtBgC0genqs4+qqnwcNtYLefGl62ravnr0S/qKKMu0XMtbHp0OwCWW1i69
 uni4EiQn9rFBvfpmeFtAldkYZgaVWqQ+52tE+K6OzFSjqskTFs8aqxtrt4GmOSCfSLaCkP
 cKajtuDY+l4p/xls2aO0gTO0+j0V2zxJ7NWzfLTzx4M23K4nOAXWjDb1vClXggOjgJPcmS
 CWYzraSzOEb1DlVygIKzaYCjhoX+MUhaklBRRnma11HkKcDZLKwpjeUIH88UsDza7NK1lv
 vA6Ri8ZTMvhGJEAdnVZfCFcO8A9Shzdh2PAnnRt6jAlFEExuiXN5YfNPGOmn6S0uVNytI2
 LVq8X1KfyP9CWTKMjZtP1WDiC1BiTc06//ibCbs3ooxnkofway+EEICRN7Nr32HtrKadPX
 6zRPBIvdfapkezHQjW5LNfJW+M0G2Dk4Yru/gGB09dLLijSoxj5n2J8x8B4ogRKxkIXWug
 5qHYWfc0QSFupMKBIMj8vypoJWw756WGE6C71s/cjMtL/P4QlwPEYoSgj6K0YRGgKmtgyJ
 yOt+DdlJ/IC/crEKxcdLPUPGCbNqZDqdUN5B9u6xCupZ/vqSg/6RW+qDaxeYkjhdGcMXlK
 uKRMVSYTqSIkodeQByrQQgc2PcvPIHUq4jC7N1eMMqabmHxCeiH5c9yHYqkiiQrqZ6+Q/u
 AudfxwwgZwsT5iIvKq9+5cW421OYJJxeQcf1ARVnCMPxkNhBYzkzlM69oeNZJRH4cn9rOm
 5KlETB5k8NInKnW4ftVBhFcdP1kLSmSZOF1HyJEjlyQC5TqGWd4+r5TKKXmcUDDhkBUoGn
 Yo9J/xbLmGM=
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

When v3d_bo_create_finish() fails in v3d_prime_import_sg_table(), the
error path calls drm_gem_shmem_free() on an object that the DRM core
does not consider imported yet: obj->import_attach is only assigned by
drm_gem_prime_import_dev() after the callback has returned. So
drm_gem_shmem_release() takes the branch for native objects and unmaps
and frees shmem->sgt, which is the sg_table of the dma-buf attachment:

  drm_gem_prime_import_dev()
    sgt = dma_buf_map_attachment_unlocked(attach)
    dev->driver->gem_prime_import_sg_table(dev, attach, sgt)
      v3d_prime_import_sg_table()
        drm_gem_shmem_prime_import_sg_table()   shmem->sgt = sgt
        v3d_bo_create_finish()                  -ENOSPC
        drm_gem_shmem_free()
          drm_gem_shmem_release()
            __drm_gem_shmem_free_sgt_locked()
              dma_unmap_sgtable(sgt)
              sg_free_table(sgt)
              kfree(sgt)
    dma_buf_unmap_attachment_unlocked(attach, sgt)   <- freed sgt

The caller then hands the freed table to the exporter, which unmaps and
frees it a second time.

v3d_bo_create_finish() fails here when the 4 GiB V3D address space is
exhausted and drm_mm_insert_node_generic() returns -ENOSPC, which a
client of the render node can arrange with imports alone. On a
Raspberry Pi 5 (BCM2712, v7.4-rc2) booted with slub_debug=FZPU the
import that hits -ENOSPC oopses:

  Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b87
  pc : dma_direct_unmap_sg+0x90/0x268
  lr : dma_unmap_sg_attrs+0x60/0x1c8
  Call trace:
   dma_direct_unmap_sg+0x90/0x268 (P)
   dma_unmap_sg_attrs+0x60/0x1c8
   unmap_udmabuf+0x34/0x60
   dma_buf_unmap_attachment+0x3c/0xa0
   dma_buf_unmap_attachment_unlocked+0x58/0x98
   drm_gem_prime_import_dev+0x1a0/0x1e0
   drm_gem_prime_fd_to_handle+0x1a8/0x280
   drm_prime_fd_to_handle_ioctl+0x40/0x58
   drm_ioctl_kernel+0xc8/0x140
   drm_ioctl+0x368/0x4e8
   __arm64_sys_ioctl+0xb0/0x110

and the task is left unkillable, as it dies holding the reservation
lock of the dma-buf.

Inside the callback the object cannot be torn down as an import,
because the core has not marked it as one yet. Allocate the GPU address
after the import has completed instead: implement .gem_prime_import as
a wrapper around drm_gem_prime_import() and call v3d_bo_create_finish()
once it has returned. By then obj->import_attach is set, so freeing the
object on failure goes through drm_prime_gem_destroy(), which unmaps
the sg_table once and detaches. .gem_prime_import_sg_table becomes
drm_gem_shmem_prime_import_sg_table() itself.

For a dma-buf that this device exported, drm_gem_prime_import() returns
the BO it was exported from. That BO already has its GPU address, so
the wrapper returns it untouched.

The error path frees the object with drm_gem_shmem_free(), as
v3d_bo_create() does, and not with drm_gem_object_put():
v3d_free_object() expects a BO that v3d_bo_create_finish() completed.
For one whose node was never inserted it would clear page table entries
starting at page 0, decrement bo_stats and call drm_mm_remove_node() on
a node that is not allocated. With drm_gem_object_put() there, the
failing import oopses in drm_mm_remove_node(), called from
v3d_free_object().

v3d_bo_create_finish() now runs after obj->resv has been pointed at the
reservation object of the dma-buf, so drm_gem_shmem_get_pages_sgt()
takes that lock instead of the private lock of a new object, and an
import can return -EINTR if a signal arrives while it waits for it.

With this change, on the same board and kernel:

 - the failing import returns -ENOSPC in each of three consecutive
   fills, and after 50 such failures debugfs dma_buf/bufinfo lists no
   dma-buf;
 - a v3d BO imported back into v3d through a second file is the same
   BO at the same offset over 1000 iterations, with bo_stats back at
   its starting value;
 - a vc4 dumb buffer imported into v3d can be mapped, written, read
   and closed;
 - under labwc, glmark2-es2-wayland runs, and mpv playing 4K HEVC from
   the hardware decoder imports the decoder's dma-heap buffers into
   v3d about 2500 times, none of which is left attached afterwards;
   the time an import takes and the number of dropped frames are the
   same as with the unpatched module, with and without slub_debug.

The kernel log stays clean throughout. Other V3D generations were not
tested.

A reproducer is available on request.

Fixes: 40609d4820b2 ("drm/v3d: Use the new shmem helpers to reduce driver boilerplate.")
Cc: stable@vger.kernel.org
Suggested-by: Maíra Canal <mcanal@igalia.com>
Signed-off-by: Aleksei Riapolov <tsbol@icloud.com>
---
v2: Allocate the GPU address after the import has completed, in a
    .gem_prime_import wrapper, instead of clearing shmem->sgt on the
    error path of the callback (Maíra).
v1: https://lore.kernel.org/all/20261114164451.9222-1-tsbol@icloud.com/

For stable: drm_gem_is_imported() was added in v6.15, so earlier trees
need obj->import_attach in the wrapper.

 drivers/gpu/drm/v3d/v3d_bo.c  | 17 +++++++++++++----
 drivers/gpu/drm/v3d/v3d_drv.c |  3 ++-
 drivers/gpu/drm/v3d/v3d_drv.h |  5 ++---
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index db95a2f..34aca97 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -172,17 +172,26 @@ free_obj:
 }
 
 struct drm_gem_object *
-v3d_prime_import_sg_table(struct drm_device *dev,
-			  struct dma_buf_attachment *attach,
-			  struct sg_table *sgt)
+v3d_prime_import(struct drm_device *dev, struct dma_buf *dma_buf)
 {
 	struct drm_gem_object *obj;
 	int ret;
 
-	obj = drm_gem_shmem_prime_import_sg_table(dev, attach, sgt);
+	obj = drm_gem_prime_import(dev, dma_buf);
 	if (IS_ERR(obj))
 		return obj;
 
+	/* A dma-buf exported by this device comes back as the BO it was
+	 * exported from, which already has its GPU address.
+	 */
+	if (!drm_gem_is_imported(obj))
+		return obj;
+
+	/* The GPU address is allocated only now that the core has set
+	 * obj->import_attach, so that a failure here is torn down as an
+	 * import: the sg_table is unmapped once and the attachment is
+	 * detached.
+	 */
 	ret = v3d_bo_create_finish(obj);
 	if (ret) {
 		drm_gem_shmem_free(&to_v3d_bo(obj)->base);
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 8d914db..70b4e59 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -279,7 +279,8 @@ static const struct drm_driver v3d_drm_driver = {
 #endif
 
 	.gem_create_object = v3d_create_object,
-	.gem_prime_import_sg_table = v3d_prime_import_sg_table,
+	.gem_prime_import = v3d_prime_import,
+	.gem_prime_import_sg_table = drm_gem_shmem_prime_import_sg_table,
 
 	.ioctls = v3d_drm_ioctls,
 	.num_ioctls = ARRAY_SIZE(v3d_drm_ioctls),
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index 7c7bdf6..63a3ca3 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -603,9 +603,8 @@ int v3d_get_bo_offset_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file_priv);
 int v3d_wait_bo_ioctl(struct drm_device *dev, void *data,
 		      struct drm_file *file_priv);
-struct drm_gem_object *v3d_prime_import_sg_table(struct drm_device *dev,
-						 struct dma_buf_attachment *attach,
-						 struct sg_table *sgt);
+struct drm_gem_object *v3d_prime_import(struct drm_device *dev,
+					struct dma_buf *dma_buf);
 
 /* v3d_debugfs.c */
 void v3d_debugfs_init(struct drm_minor *minor);
-- 
2.54.0 (Apple Git-157)

