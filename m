Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C22C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7FB10E980;
	Mon, 17 Aug 2026 23:07:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="zSvurWKy";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-149.mta1.migadu.com [95.215.58.149])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717EE10E9A7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:14 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=bt/7+fJ4r+GDoo6DgzEOQChvQi99s8eQC7TAlqrTS50=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008032; v=1; x=1787612832;
 b=zSvurWKyllz51nb6IYwu/p1xebGQ4tFu4ly/VECGK9qrpNcPlT1ObqPu5BExG/toT4sa9F6s
 YqOdebcl8JGfyYScQt6PYvthMUU0iyIHzBfeigqYGEhLI12guu/jeuwipTsQBv2vDAGJ564Ji6j
 cKKIeEP9x2dzl9HGV5Tlal5iuaIU2iUX33Tsv5/hokG9IrPowfRpNt86dJjvVEmz0vP65M/hjLh
 OrdsNUtgDCkzVFnCod2MIzNyMkEHiTa8SxHxU3bHggQbywBBgLUMCKxe3xtQfOOOEvlbv1GxgJM
 bwRD6JwHdh9rCUI0EzCdJKfQ7aaVejtSVjdfxGm3aYh1A==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 585beebf9fe66aa7;
 Mon, 17 Aug 2026 23:07:01 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: jacek.lawrynowicz@linux.intel.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH] accel/amdxdna: return early from a zero-length flush
Date: Tue, 18 Aug 2026 02:06:55 +0300
Message-ID: <20260817230655.356785-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
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

SYNC_BO does not constrain its size, so a request for zero bytes reaches
drm_clflush_virt_range(), which ends with an unconditional
clflushopt(end - 1). For an empty range that is the byte before the
mapping, and abo->mem.kva comes from vmap(), so the access lands in the
guard page below the vmalloc area and faults:

  BUG: unable to handle page fault for address: ffffd16fbbc70fff
  #PF: supervisor read access in kernel mode
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 7 UID: 1000 Comm: sync_bo_probe
  RIP: 0010:drm_clflush_virt_range+0x3c/0x70
  Call Trace:
   amdxdna_drm_sync_bo_ioctl+0x124/0x430 [amdxdna]
   drm_ioctl+0x301/0x4c0
   __x64_sys_ioctl+0x115/0x2f0
   do_syscall_64+0xa6/0x3d0

Any process that can open the render node can do this. Reproduced 3 of 3
times on a Strix Point NPU (1022:17f0), by calling SYNC_BO with size 0 on
an AMDXDNA_BO_SHARE object. The import arm takes the same request but
flushes the whole scatterlist, so it survives it.

Nothing needs flushing for an empty range, so answer before choosing a
path.

Fixes: e252e3f3488a ("accel/amdxdna: Revise device bo creation and free")
Cc: stable@vger.kernel.org
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
Trees before amdxdna_flush_bo() existed carry the same call inline in
amdxdna_drm_sync_bo_ioctl(), with args->size passed to
drm_clflush_virt_range() unclamped, so a backport wants the guard at that
call site instead.

 drivers/accel/amdxdna/amdxdna_gem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
index 1c63eff0a4a8..2a16de96e6a4 100644
--- a/drivers/accel/amdxdna/amdxdna_gem.c
+++ b/drivers/accel/amdxdna/amdxdna_gem.c
@@ -1247,6 +1247,9 @@ static int amdxdna_flush_bo(struct amdxdna_gem_obj *abo, u64 offset, u64 size)
 		return -EINVAL;
 
 	size = min(abo->mem.size, end) - offset;
+	if (!size)
+		return 0;
+
 	if (is_import_bo(abo))
 		drm_clflush_sg(abo->base.sgt);
 	else if (amdxdna_gem_vmap(abo))
-- 
2.55.0

