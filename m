Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79694C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C575910F4CA;
	Thu, 13 Aug 2026 18:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="HBPUBgqV";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-166.mta1.migadu.com [95.215.58.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09F310F4C9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:33:37 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=qG1QDrNHWq3VEBbfesMlP0OQ2+mC6waGnwBinaj6rCQ=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786646016; v=1; x=1787250816;
 b=HBPUBgqVDSRAysJZ0riEJa3PPvqivGi9124DADm7Q1bbE4YED66nFEJ9S6IY1MIsUJaoDf/p
 Dm4G9CR2oUsgMFJtW3ulwDbjqR5S4Ifo5jdnLxdsWAIlLFNhkR1qqriURYoYcFHtldkfajlqEtq
 PG35Yb2uPhWabpdJigZGGXpf27s4yFY0usjZrkST7hgjCjFiCdIeVpB+suJNTjIcd3cmDStec4Y
 cRa4gnWaQvtcHtYTCnfWoN89IeZReKDLB/eKA/HlLa5djOBmK8GZZ49yrcAi2Q/cTSGY4Uc8sMK
 gbvfO0PBW1B1zSFqgpanAqHfx8UlsrI8rnB6cUVOi0lEA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id de2aaca3983ecfd6;
 Thu, 13 Aug 2026 18:33:36 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Date: Thu, 13 Aug 2026 21:33:16 +0300
Message-ID: <20260813164700.43960-2-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813164700.43960-1-taimuraz@kaitmazov.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

amdxdna_gem_obj_vmap() takes whatever dma_buf_vmap() returns and only
rejects a NULL vaddr. iosys_map is discriminated by is_iomem, so an
exporter answering with an I/O mapping leaves a void __iomem pointer in
abo->mem.kva, which amdxdna_cmd_set_error() memsets and memcpys through.

amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
object, so an NPU paired with nouveau or radeon does.

Refuse the mapping. vmw_gem_vmap() does the same; unlike that one this
path is reachable from an unprivileged ioctl, so it does not warn.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1f190b319bb..b66ec9e4828 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *ma
 
 	dma_resv_assert_held(obj->resv);
 
-	if (is_import_bo(abo))
+	if (is_import_bo(abo)) {
 		ret = dma_buf_vmap(abo->dma_buf, map);
-	else
+		/* Callers use mem.kva as an ordinary kernel address. */
+		if (!ret && map->is_iomem) {
+			dma_buf_vunmap(abo->dma_buf, map);
+			return -EOPNOTSUPP;
+		}
+	} else {
 		ret = drm_gem_shmem_object_vmap(obj, map);
+	}
 	if (ret)
 		return ret;
 	if (!map->vaddr)
-- 
2.55.0

