Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8991CC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 994EA10E0F1;
	Fri, 14 Aug 2026 07:04:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="f0BUIEg4";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E74310E4EB
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 16:47:15 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=qG1QDrNHWq3VEBbfesMlP0OQ2+mC6waGnwBinaj6rCQ=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786639633; v=1; x=1787244433;
 b=f0BUIEg4mXUeS3MWIgn6A7fMrYDnwOA21kMVHpbE7wvmxOLvS00PKrMwAT2eOHJuN8brgtxG
 CX4RN9pYpu/Si0rCnIJEtneCseUyzVIbjSVEZCZW5ZLWxshQ8gsjEMFDQHpG1Gc1ILXLqzXQQgr
 8QzWC8Q2FGAwA5zbpcy2fUuIojmKQvAyWbOMELR6OzaZDVs9jRowNtghJkFf/JgKNXkpQtg1N6c
 weg3H8Xahci9e3IkvljyLRs/WxFjY0UM7gy4qaCwElM/lK7pWG3nJ9Ngz/TUuiicMpe4m7X/qyj
 dZMB0T7xP1o4WgKQzFeUcoJUrWSqwv9pUcbKHEURqRBaw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id e1b94cff074eb71f;
 Thu, 13 Aug 2026 16:47:13 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Date: Thu, 13 Aug 2026 19:46:58 +0300
Message-ID: <20260813164700.43960-2-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813164700.43960-1-taimuraz@kaitmazov.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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
Message-ID: <20260813164658.bXvSEIIEZ2X0aw3Le2xGmDuQSHzT4D-mWJkyiE086Rk@z>

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

