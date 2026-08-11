Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DBCC5CFEE
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CF9B10EE61;
	Wed, 12 Aug 2026 07:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="bBkmNYWG";
	dkim-atps=neutral
X-Greylist: delayed 484 seconds by postgrey-1.36 at gabe;
 Tue, 11 Aug 2026 20:54:47 UTC
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com
 [91.218.175.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0E4210E385
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 20:54:47 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786481206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ntw0VuP3EeY8k4KPnQJ84+od73prlFVgKVcC4psjLY=;
 b=bBkmNYWGoLopsn087f7L9jlJ5Q3Jwv+PHzJG/NCbk4WbingkQcZg6nlTsInWx/xTcQb0Ci
 jOK3erqfLnKDZjvL6nMhT6flxnTQkb1SbYBu7/uK226/WbBTwuGbPnobGvMioKRQSYl453
 ItP7G/NO/gUuWmWDEUimQS42y9V06/a8yEOkx+2wReYk43lRv6G0wDJei6yLlI5lHnUghl
 6TqOS11EF1Vomx/wtBns0p4m2LtGZV4tZBqOIAkXC+jQpYL5U0q8LXx1eAHd+cKnFAak3+
 WyCPM75veqfcbuziJoTo4Y7g135RAXzRSZzzfsPtBwh+a//+phzrUmH8nhDXUw==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Date: Tue, 11 Aug 2026 23:45:54 +0300
Message-ID: <20260811204556.875037-2-taimuraz@kaitmazov.com>
In-Reply-To: <20260811204556.875037-1-taimuraz@kaitmazov.com>
References: <20260811204556.875037-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

amdxdna_gem_obj_vmap() accepts whatever dma_buf_vmap() returns and only
rejects a NULL vaddr. struct iosys_map is a union discriminated by
is_iomem, so an exporter that answers with an I/O mapping leaves a
void __iomem pointer in map->vaddr, and amdxdna_gem_vmap() stores it in
abo->mem.kva, which callers use as an ordinary kernel address:
amdxdna_cmd_set_error() memsets and memcpys through it.

amdxdna_drm_va_tbl takes a dmabuf_fd, so a BO of type AMDXDNA_BO_SHARE
or AMDXDNA_BO_CMD can be any exporter's buffer. Whether such a buffer is
still in a bus aperture when it is mapped depends on the exporter.
amdxdna attaches without importer ops, so an exporter that implements
.pin has it called before the mapping, and amdgpu's removes VRAM from
the allowed domains as soon as one attachment cannot do peer to peer,
which this driver's cannot; an amdgpu buffer is therefore in GTT
before any of this runs. An exporter using drm_gem_prime_dmabuf_ops
has no .pin at all, nothing moves the buffer, and drm_gem_ttm_vmap()
answers with iosys_map_set_vaddr_iomem() for a VRAM resident object.
nouveau and radeon are in that group, so an NPU paired with one of
those GPUs reaches this.

Refuse the mapping, so it never reaches a caller that cannot use it.
vmw_gem_vmap() does the same for the same reason. Unlike that one, this
path is reachable from an unprivileged ioctl, so it does not warn;
-EOPNOTSUPP is what drm_gem_vmap_locked() already returns here for an
exporter with no vmap op.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1f190b319..b66ec9e48 100644
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

