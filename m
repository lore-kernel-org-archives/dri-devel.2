Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A56606A33E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=aYzbJrDb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D6C910ECA6;
	Wed,  4 Nov 2026 08:58:05 +0000 (UTC)
X-Greylist: delayed 545 seconds by postgrey-1.36 at gabe;
 Tue, 03 Nov 2026 11:41:48 UTC
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com
 [111.22.67.139])
 by gabe.freedesktop.org (Postfix) with ESMTP id A193310E759
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmss.chinamobile.com; s=default; l=0;
 h=from:subject:message-id:to:cc:mime-version;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=aYzbJrDbeP/7tWdxMtcgSSwEmNgpxtzQOdod7HkyQTJqQm7k0/rVAhtJkCUkEj4NlxtHLqxuPtW9c
 fnHDvM8syOzQaHV+iJxisUeDMFuSlM8d+hnY+rzWqfgq//vPtkFIsMTmzl/BQqSUXyvgFLnVAP0XLu
 UvNcctGqZC7YOQZ4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae9c651deb-91fd9;
 Tue, 03 Nov 2026 19:32:38 +0800 (CST)
X-RM-TRANSID: 2ee56ae9c651deb-91fd9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from dsh.local (unknown[10.55.1.72])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76ae9c654b7c-f8a46;
 Tue, 03 Nov 2026 19:32:38 +0800 (CST)
X-RM-TRANSID: 2ee76ae9c654b7c-f8a46
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: kraxel@redhat.com, vivek.kasireddy@intel.com,
 dri-devel@lists.freedesktop.org
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf/udmabuf: do not warn on huge user-controlled
 allocations
Date: Tue, 03 Nov 2026 19:32:37 +0800
Message-ID: <20261103-udmabuf-nowarn-1-yuehongwu@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.43.0
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by
default") size_limit_mb defaults to INT_MAX, so a user can ask for a
buffer of up to 2 PB.  pgcnt is taken from that request and
init_udmabuf() allocates an array of that many pointers before the memfd
is even looked at.

For a request above 1 TB the array is larger than INT_MAX bytes, so
kvmalloc() hits

	WARN_ON_ONCE(!(flags & __GFP_NOWARN))

in __kvmalloc_node_noprof(), returns NULL, and udmabuf_create() turns
that into -ENOMEM.  The warning is reachable from userspace through
/dev/udmabuf, and with panic_on_warn=1 a bogus ioctl turns into a kernel
panic.

The size is user-controlled and the allocation failure is handled
already, so pass __GFP_NOWARN for the page array, the pinned folio array
and the per-item folio array, matching how other subsystems handle
user-controlled sizes.

Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
Signed-off-by: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
---
 drivers/dma-buf/udmabuf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index df6dd00..47e130e 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -190,11 +190,17 @@ static void unpin_all_folios(struct udmabuf *ubuf)
 
 static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
 {
-	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt);
+	/*
+	 * pgcnt comes from a user supplied size, so do not warn when
+	 * kvmalloc() refuses an impossibly large array.
+	 */
+	ubuf->pages = kvmalloc_objs(*ubuf->pages, pgcnt,
+				    GFP_KERNEL | __GFP_NOWARN);
 	if (!ubuf->pages)
 		return -ENOMEM;
 
-	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt);
+	ubuf->pinned_folios = kvmalloc_objs(*ubuf->pinned_folios, pgcnt,
+					    GFP_KERNEL | __GFP_NOWARN);
 	if (!ubuf->pinned_folios)
 		return -ENOMEM;
 
@@ -387,7 +393,8 @@ static long udmabuf_create(struct miscdevice *device,
 	if (ret)
 		goto err;
 
-	folios = kvmalloc_objs(*folios, max_nr_folios);
+	folios = kvmalloc_objs(*folios, max_nr_folios,
+			       GFP_KERNEL | __GFP_NOWARN);
 	if (!folios) {
 		ret = -ENOMEM;
 		goto err;
-- 
2.43.0



