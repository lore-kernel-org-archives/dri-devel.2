Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE5FFB5191
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 04:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEDA10E074;
	Tue,  7 Apr 2026 04:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="mdsJdW6h";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A595010E074
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 04:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=AZdryoEjym1dfrc8csNMBSh/pD6+gVbxgUBr+ZfMCMA=; b=mdsJdW6hBj4+4e6enWTyx6vv0L
 nWX/ZO1Q37CzQXmdqbssr4bMckGKz/ZsEdHTesiAlfbpMfvufanvVxWDKI+SN4iaeW6g8LB/tmJhR
 ea2SojoO0DQv9Wn6XrG2Ot4MEmptBZYvik95FcUj5X/fOVS5J5KMN9fOH4K57mlA3/YJqxumshadq
 rd2/WKN0j/Ekzg8QnVzE3dBuPBas68DBtjzO+1DRy2Pe1rZ7YXHVD/71OvlS6QD7569QB24Ae+ICO
 7lIGy3xPbPJ4G62D2afLts4Vy73WpZxlEDTn73bfwX3L88oLrRgoi/nl+YcT2FKbPhIPe0YWk4ol4
 Zws0gmug==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1w9yBF-00000005soa-3IbK; Tue, 07 Apr 2026 04:36:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Subject: [PATCH] dma-fence: correct kernel-doc function parameter @flags
Date: Mon,  6 Apr 2026 21:36:48 -0700
Message-ID: <20260407043649.2015894-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

'make htmldocs' complains that dma_fence_unlock_irqrestore() is missing
a description of its @flags parameter. The description is there but it is
missing a ':' sign. Add that and correct the possessive form of "its".

WARNING: ../include/linux/dma-fence.h:414 function parameter 'flags' not described in 'dma_fence_unlock_irqrestore'

Fixes: 3e5067931b5d ("dma-buf: abstract fence locking v2")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Christian König <christian.koenig@amd.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org

 include/linux/dma-fence.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20260406.orig/include/linux/dma-fence.h
+++ linux-next-20260406/include/linux/dma-fence.h
@@ -408,9 +408,9 @@ static inline spinlock_t *dma_fence_spin
 /**
  * dma_fence_unlock_irqrestore - unlock the fence and irqrestore
  * @fence: the fence to unlock
- * @flags the CPU flags to restore
+ * @flags: the CPU flags to restore
  *
- * Unlock the fence, allowing it to change it's state to signaled again.
+ * Unlock the fence, allowing it to change its state to signaled again.
  */
 #define dma_fence_unlock_irqrestore(fence, flags)	\
 	spin_unlock_irqrestore(dma_fence_spinlock(fence), flags)
