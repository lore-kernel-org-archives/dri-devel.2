Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA4CC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0073A10EFC6;
	Thu, 20 Aug 2026 10:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="W4kE0KL6";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 00BFD10EFC6
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:50:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED321CDD;
 Thu, 20 Aug 2026 03:50:49 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com
 [10.1.25.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18063F66F;
 Thu, 20 Aug 2026 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787223053; bh=NNzpHX/+mcqN6PkciZSU1ANfzwjeDq5G33MuimdG0sw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W4kE0KL6dNp7OqTRKjIPeZLCk+ii0EBnVG/XxDg0MD3rO7EF/L9D3wU3qboJsdbUS
 hheGHwUmyv0wPqNomhF2R63ZFm3H+6Jf70rLU7PG0rKvIRRdZoGQ6/9nse4YwFZOgg
 CciKo6BqLRnmeklVuYxQdzga3B9VQiqUm3w7LMw8=
From: Steven Price <steven.price@arm.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Marc Zyngier <maz@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Thomas Gleixner <tglx@kernel.org>
Cc: Steven Price <steven.price@arm.com>, "T.J. Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 1/2] irqchip/gic-v3-its: Zero shared pages after conversion
Date: Thu, 20 Aug 2026 11:50:24 +0100
Message-ID: <20260820105026.53208-2-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820105026.53208-1-steven.price@arm.com>
References: <20260820105026.53208-1-steven.price@arm.com>
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

its_alloc_pages_node() passes __GFP_ZERO to the page allocator before
calling set_memory_decrypted(). This assumes that converting a page from
private to shared preserves its contents.

For Arm CCA with MEC (Memory Encryption Contexts) the key used to access
the page will change, and so by default the visible data will change.
The host could ensure that it zeros the page, but rather than relying on
the host's behaviour it's best if the guest simply zeros after the
decryption rather than before. Specifically in this case the ITS tables
are required to be zeroed.

Mask out __GFP_ZERO from the allocation request, and do the zeroing as a
separate step after decryption.

Fixes: b08e2f42e86b ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6f5811aae59c..c954bbe9f4db 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -213,10 +213,12 @@ static gfp_t gfp_flags_quirk;
 static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 					 unsigned int order)
 {
+	bool want_zero = gfp & __GFP_ZERO;
 	struct page *page;
 	int ret = 0;
 
-	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
+	page = alloc_pages_node(node, (gfp & ~__GFP_ZERO) | gfp_flags_quirk,
+				order);
 
 	if (!page)
 		return NULL;
@@ -231,6 +233,9 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
 	if (ret)
 		return NULL;
 
+	if (want_zero)
+		clear_pages(page_address(page), 1 << order);
+
 	return page;
 }
 
-- 
2.43.0

