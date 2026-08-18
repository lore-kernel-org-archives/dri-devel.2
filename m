Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD20EC5B572
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 00:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E70B10E46E;
	Tue, 18 Aug 2026 00:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="zt9FI93q";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-133.mta1.migadu.com [95.215.58.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B97010E46E
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 00:00:29 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=meUpumca9lP5OxbRObx4U862YKjQ5EWm9nNoS0io+F8=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787011227; v=1; x=1787616027;
 b=zt9FI93q/1BWLecmVglOC0MSzlPtFlWkrP9sLAS/01HO+LKxe7lSmSlqMvc51ZmAQPeUXEOM
 x+nJnZ/M9oEGgWPWS5XLsqQAS6vvpJ4/xv/Fj+X9/BjF07bs6VPLMFayWZsUfYjZ4IRQ12O8/W+
 E0McGbntwZcWDKpc2vtPq0p2qM3jVYO514yL6hDCNJwMuYgFL3yT30WwC7DexyD1FSvwH3eXiQe
 uAZrVdlHLfjtTJGcDrrxtm6AjBF8mc3oQDK4GOkptDhQjsh6/TYpVuJNGPYFeT80Y5KD+4kgIHE
 RlqPrMJWHrhX84yDTC8aJyYlbjqQdDTp3fi1PxYzfKHwg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id fe0a1ba9551b2979;
 Tue, 18 Aug 2026 00:00:17 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH] drm/cache: return early from a zero-length clflush
Date: Tue, 18 Aug 2026 03:00:04 +0300
Message-ID: <20260818000004.369311-1-taimuraz@kaitmazov.com>
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

drm_clflush_virt_range() ends with an unconditional clflushopt(end - 1) to
force serialisation. For a zero-length range end equals addr, so it reads
the byte before the region. Where that byte is the guard page below a vmap,
the read faults:

  BUG: unable to handle page fault for address: ffffd16fbbc70fff
  #PF: supervisor read access in kernel mode
  RIP: 0010:drm_clflush_virt_range+0x3c/0x70

Reproduced through amdxdna's SYNC_BO ioctl, which passed a caller-supplied
length straight through, so any process able to open that render node
oopsed the kernel.

clflush_cache_range_opt(), which this mirrors, already answers an empty
range with "if (p >= vend) return", and has no trailing flush to make the
case special. Do the same here, above the CONFIG_X86 test so an empty range
stops calling wbinvd_on_all_cpus() on a CPU without CLFLUSH as well.

The other callers are safe today by their own construction rather than by
anything this helper does: of the 54 in the tree, 33 pass a compile-time
constant, and of the rest only i915's phys pread/pwrite pair takes a length
from userspace, which i915_gem_pread_ioctl() and i915_gem_pwrite_ioctl()
reject at zero before it gets there.

Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/gpu/drm/drm_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index ea1d2d5d2c66..86abee80e5fe 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -156,6 +156,9 @@ EXPORT_SYMBOL(drm_clflush_sg);
 void
 drm_clflush_virt_range(void *addr, unsigned long length)
 {
+	if (!length)
+		return;
+
 #if defined(CONFIG_X86)
 	if (static_cpu_has(X86_FEATURE_CLFLUSH)) {
 		const int size = boot_cpu_data.x86_clflush_size;
-- 
2.55.0

