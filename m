Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A445606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgy6oCNt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3C510F04D;
	Sat, 14 Nov 2026 16:25:26 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D907710E1B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:24:57 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-36ecc11bd26so219134eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637497; x=1795242297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nuw+0N/N3N3TgZSRfVF3OxMj+eHVfhZTZnHIUjTrdas=;
 b=rgy6oCNtwlXjxGQnoDVh4oyzt+ASkn5KSU3eaO0vWzDRH/+C3aNo27gKK8NpQzqapP
 3AUYPCgQMcn/POwaqFtEcfLFe7CMqSUymWQUozmt/yh7dkIXShlrOlQEQjp9HgY/Myp6
 ul85/MfuL6Kxlo3/qCq3tqG3Wj0oPZKDglo//TWdUN9BILlkcSyBNSiYrH+IS4Klxe6y
 8dPXDyHDIp31RbJtTluRt+iKrpAh9XdzX1WCV9agVbAHxYs7kVj3IpyJU5keJ1cv5hfK
 dNRxrGwKcOQk5UQuk7mpFnWcwZKuLwiQkpRD+1byin10Btk3MReYu7lgBubUjvD5FmAF
 e7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637497; x=1795242297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nuw+0N/N3N3TgZSRfVF3OxMj+eHVfhZTZnHIUjTrdas=;
 b=ccpMP92sAA2kvTxVrL4MxbEkcn+EG1gNxU0syTqXXngzZZGsplWfB+xWVlfmnk9LZK
 h/T1CR62eEDq3Km88ApLylLrtH0jy/XO0ks9TxlOYbB633Q0q1ysUDHfU78pd0F0Rigm
 EuHEPPiv7lNC1OwoZWXFxZZJqQ0xL0cwb2mswS5yowGA5mpC3KE08GgZSJKoGQhJiWjT
 zkxb8PMla+HPFLZaEzLux8+MAX7jC/0xWHwTQtjZvX9meFQ1D5+sPB3AVL0B0z2zwlV6
 onlc0di2h00gwHned96oydAPtnN3pDoHyOOYLGftGg2JLIygMwLuJw8BxAMTJmZzcMO+
 0Opg==
X-Forwarded-Encrypted: i=1;
 AL+hErGwATUn55xnlmDTT8ujEGrdjgyj0A5KDsXUacokrUrD8+3wy/xTzA7R7aKoridQmLySey36ypKFN7s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8P742d3Cpx7lKLZ4nAqvWyynqZWLw3PdWyNK4CYoF/sT0WIMfe
 aNNcQuO6cQgUTSqgWNt1jQ0uXlm/z/uyz8ZJtwCrMJh89Z2vHTkjvbFh
X-Gm-Gg: AYBFou2/OP45fbLLoI7xREeUdAd/h/utmRdmTR4YsrmJ9fF4hmY+H01040QCM+uQLEW
 HHN6yiThprFyFaLxmfSyyy0d9onotdqfAvXyYdqS/+kHwcdkTgwgG0S+POF8wZu3FvWfJMYL3VB
 EGAeyyjc2PrXgbRfk/JImmIb869hI/qEj5cKQqqdm9naM5vWSur8KVcLuFjHB+cUX1CWCOsrb1m
 8CwYoAXPjpJGrRx3DdSY0Q904+z0zYkOhl2xjthTB2O7pA3J+t+Uu5tfV0VngJhBDJ6s6fqlTko
 OQmhW3Z/oeXZ1nMLFPP1qdBkWP67ocYzIr7CMJLxm6rNXQ5eYVno97DNbZ6Kx+JILctA0kVjW/d
 xKnbqmhD+UHZ+6zz7p9/bx2degKC+zrSQrhXceFIUfkDl6do4n/yAcZQ8fjRQNZwKiOuvCaDn8I
 ZBqJJ3emVqRF3mENYFYKnM9So+jGOHOUFYGkiWDuz1AcY4UKZAnYqY+GIZvjAeIwzG4WnHoxhZL
 dzfQmXxuXinOKN6iDVg39ofYyXfabdTslnAx+U5epBF5U+CSFllBlDeV0euYqlgdyA27m1df2jO
 Yka2luoI9scDyjQHWrGUc5xt5jxg/2ogZj7++jDPFWDSkBXrBmm2JXM4lQm9W5fIL2I+eyiFz4o
 +3WrH5RkkHkoEoQZW9p97CtH+
X-Received: by 2002:a05:7301:a0a:b0:36c:a1bc:6114 with SMTP id
 5a478bee46e88-3796038259fmr6483300eec.0.1794637496941; 
 Fri, 13 Nov 2026 22:24:56 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795533170csm13564777eec.7.2026.11.13.22.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:24:56 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Donald Robson <donald.robson@imgtec.com>
Cc: Matt Coster <opensource@mtcoster.net>,
 Sarah Walker <sarah.walker@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH] drm/imagination: Flush the MMU caches after unmaps done by a
 map
Date: Sat, 14 Nov 2026 15:24:48 +0900
Message-ID: <20261114062448.1513-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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

pvr_mmu_op_context_destroy() flushes the MMU caches right away for
unmap operations, but defers the flush for map operations, which it
tells apart by op_ctx->map.sgt being set.

A DRM_IOCTL_PVR_VM_MAP over a range that overlaps existing mappings
unmaps those through the gpuva unmap and remap callbacks, with the op
context of the map operation. The flush for these unmaps is then
deferred like for a plain map, although the page tables that the
unmaps emptied are freed in pvr_mmu_op_context_destroy(), and a mapping
that is replaced entirely no longer holds a reference to its BO. Until
the next call to pvr_mmu_flush_exec(), the MMU caches can still refer
to the freed page tables and to the pages that were mapped there.

Record in the op context that pvr_mmu_unmap() was called with it, and
flush the caches right away in that case as well, before the emptied
page tables are freed, as is already done for unmap operations and as
the comment of pvr_mmu_flush_exec() requires for unmaps.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
This is about the existing DRM_IOCTL_PVR_VM_MAP path. Gyeyoung Baek's
VM_BIND series reworks how map and unmap use the op context, and this
patch does not depend on it. The sashiko review of 5/6 there raises a
related question for the new asynchronous path (BO pages freed before
the MMU flush):
https://lore.kernel.org/r/20261108-pvr-vm-bind-v2-0-730103d2cc9a@gmail.com

 drivers/gpu/drm/imagination/pvr_mmu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 67e73d7d5d0e..84a58ab2ab75 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -1444,6 +1444,13 @@ struct pvr_mmu_op_context {
 		 * ops. Linked list empty at creation.
 		 */
 		struct pvr_page_table_l0 *l0_free_tables;
+
+		/**
+		 * @unmap.unmapped: Set once pvr_mmu_unmap() has been called
+		 * with this op context, which also happens in a map operation
+		 * that replaces existing mappings.
+		 */
+		bool unmapped;
 	} unmap;
 
 	/**
@@ -2293,8 +2300,12 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
 
 	pvr_mmu_op_context_sync(op_ctx);
 
-	/* Unmaps should be flushed immediately. Map flushes can be deferred. */
-	if (flush_caches && !op_ctx->map.sgt)
+	/*
+	 * Unmaps should be flushed immediately, and that includes the ones done
+	 * by a map operation that replaces existing mappings: the page tables
+	 * they emptied are freed below. Map flushes can be deferred.
+	 */
+	if ((flush_caches && !op_ctx->map.sgt) || op_ctx->unmap.unmapped)
 		pvr_mmu_flush_exec(op_ctx->mmu_ctx->pvr_dev, true);
 
 	while (op_ctx->map.l0_prealloc_tables) {
@@ -2486,6 +2497,8 @@ int pvr_mmu_unmap(struct pvr_mmu_op_context *op_ctx, u64 device_addr, u64 size)
 	if (err)
 		return err;
 
+	op_ctx->unmap.unmapped = true;
+
 	return pvr_mmu_op_context_unmap_curr_page(op_ctx,
 						  size >> PVR_DEVICE_PAGE_SHIFT);
 }

base-commit: d48ea86919434695da12d280dccab72b094397e1
-- 
2.43.0

