Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4494AC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8195610E338;
	Wed, 26 Aug 2026 19:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="mn30K/XY";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8B010E338
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 19:57:59 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=ibUvACoBWMWLYMOqttDGfv6DpEUNCOTbV4tFb1siXOA=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787774277; v=1; x=1788379077;
 b=mn30K/XYh0ZbzzcCzU3WpOuOyQ+0x2r8IXpKPSayWb8pifaL114ksd1SI0BinobtYQBoEw92
 HGWXPWkRji0mr9JAGFX6Ei97JthXlCrSZ+MgDqPGDwQCxp/6Qw/EGtixq1xMKJHTfsltAV6F8F+
 1hVkgqmjvXgFy+XElM0cNncY9zVgkYgiCF+9ZiKRLNWKrVBULYpmQEOoXxIPhSy+lgYRkqVrRol
 9jxKXD8pwU7PGJmKMt/EKlxrawy4v9b470VSu1m8YLI28LcZUyy+Iz73XQQTLb3TfFdtABgDpZc
 KKeLe1xc8qN38zDx4mGgafHY+ctosUViwHiwWhVfaKBCQ==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id bcb307ce9318bc8f;
 Wed, 26 Aug 2026 19:57:47 +0000
X-Mizu-Trace-ID: bcb307ce9318bc8f
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] accel/amdxdna: Bound the page count of a user supplied buffer
Date: Wed, 26 Aug 2026 22:57:36 +0300
Message-ID: <20260826195736.358579-1-taimuraz@kaitmazov.com>
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

amdxdna_get_ubuf() puts a per-entry page count derived from a __u64
va_ent[i].len into a u32, then passes it to pin_user_pages_fast(), whose
nr_pages is an int. An entry of 2^44 bytes truncates npages to zero, so
nothing is pinned, the ret != npages test still passes, and ubuf->pages
keeps whatever kvmalloc_objs() returned while ubuf->nr_pages describes the
untruncated count. amdxdna_ubuf_release() then walks all of it. Reaching
that needs CAP_IPC_LOCK and a multi-gigabyte kvmalloc() to succeed.

Reject a total that does not fit in an int. The lengths are page aligned
and summed with check_add_overflow(), so the total is at least as large as
any one entry and bounds the pin call, the offset accumulator and
sg_alloc_table_from_pages().

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
 drivers/accel/amdxdna/amdxdna_ubuf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 0e0cd69cd1fb..da8e32566ae0 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -125,6 +125,12 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	}
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
+	if (ubuf->nr_pages > INT_MAX) {
+		XDNA_ERR(xdna, "Too many pages %lld", ubuf->nr_pages);
+		ret = -EINVAL;
+		goto free_ent;
+	}
+
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
 	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-- 
2.55.0

