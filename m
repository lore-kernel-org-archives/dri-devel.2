Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE7C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6243710E354;
	Wed, 26 Aug 2026 21:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="BibETV8A";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 113A210E354
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:28:38 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=RZGV2XpARiVi3foo+WbHvDCezzy1e9pOxD2orUgf6f8=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787779716; v=1; x=1788384516;
 b=BibETV8AeyUUhWA3V1ama2biM9l7lQJ7jAi87egbtb4hhXfqrykf72PQC3ohCTqU8BBkFOst
 rT2dfE47WyRofMuU7UpgPjBdVlVqoKG1wXsThe49P5YEatSbJF+IVW2XoZchwyre07fcDU1rt4O
 zWP35wUes/987hrU9pI9V0KLK7cbygVlc8u81yFx6wqxMH1hzcDYtlesGywbl9aymV00o0tHajb
 25I5AtCsH3dOY4jDk5YutfU7gHK0fprworjm01hzibzkgyP/ilgmL8pdeAsfU+2Z+G1vNHk7RIK
 AL/Sal/WPjocTTwPDp+pNxB0BCacE2CJN3q/xZBi+Cyww==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.110.63)
 by smtp.migadu.com with ESMTPS id dd1549516440c796;
 Wed, 26 Aug 2026 21:28:36 +0000
X-Mizu-Trace-ID: dd1549516440c796
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2] accel/amdxdna: Bound the page count of a user supplied
 buffer
Date: Thu, 27 Aug 2026 00:28:25 +0300
Message-ID: <20260826212825.408846-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f1cbc1bf-2904-e0cf-8fc6-07ce41dad2a2@amd.com>
References: <f1cbc1bf-2904-e0cf-8fc6-07ce41dad2a2@amd.com>
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

Reject a zero length entry as well: it contributes nothing to the mapping
and a table of them leaves nr_pages at zero.

Fixes: bd72d4acda10 ("accel/amdxdna: Support user space allocated buffer")
Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
---
v2:
- XDNA_DBG and %llu, per your comment.
- Reject a zero length entry in the validation loop, and lower that log to
  XDNA_DBG too, as you suggested.

 drivers/accel/amdxdna/amdxdna_ubuf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ubuf.c b/drivers/accel/amdxdna/amdxdna_ubuf.c
index 0e0cd69cd1fb..bf1e4dd7bbc3 100644
--- a/drivers/accel/amdxdna/amdxdna_ubuf.c
+++ b/drivers/accel/amdxdna/amdxdna_ubuf.c
@@ -111,8 +111,9 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 
 	for (i = 0, exp_info.size = 0; i < num_entries; i++) {
 		if (!IS_ALIGNED(va_ent[i].vaddr, PAGE_SIZE) ||
-		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE)) {
-			XDNA_ERR(xdna, "Invalid address or len %llx, %llx",
+		    !IS_ALIGNED(va_ent[i].len, PAGE_SIZE) ||
+		    !va_ent[i].len) {
+			XDNA_DBG(xdna, "Invalid address or len %llx, %llx",
 				 va_ent[i].vaddr, va_ent[i].len);
 			ret = -EINVAL;
 			goto free_ent;
@@ -125,6 +126,12 @@ struct dma_buf *amdxdna_get_ubuf(struct drm_device *dev,
 	}
 
 	ubuf->nr_pages = exp_info.size >> PAGE_SHIFT;
+	if (ubuf->nr_pages > INT_MAX) {
+		XDNA_DBG(xdna, "Too many pages %llu", ubuf->nr_pages);
+		ret = -EINVAL;
+		goto free_ent;
+	}
+
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	new_pinned = atomic64_add_return(ubuf->nr_pages, &ubuf->mm->pinned_vm);
 	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-- 
2.55.0

