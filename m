Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6B2FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E931C10E67F;
	Mon, 27 Apr 2026 10:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EFEf02hj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E82610E67F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:05:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C180544521;
 Mon, 27 Apr 2026 10:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AABDC2BCB6;
 Mon, 27 Apr 2026 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777284314;
 bh=DVp9SIjZvLo7LHKT0aFcqmpT0ICBVAk6Lir7Cpdt3so=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=EFEf02hjKJBrla5RxATE172pEWa4DwdUWoWua5gh3m2gOPQoJLW+WbrcmdAD3D3/1
 v99gfpc4meaM+99m+qRj4h34CwSX5RVI5zESaihlunB+cjRqQ4ZY6CjIso9DrEiu5k
 p4k/kcAxJjWOn4T3CVbTJ6U/a6sjPaeWykhDUU4NOSjDUDpnyOBC+KXnKoXA8YD5OD
 WHetiPxgajNyAhjj0KEHbGBd638DwjLjOCr9NKwwTyusWQ6v5uH+9G11HwdJ67pmIm
 WmVhOTB0btzdyI0xPowk3MtRXzGyWOrrCUMdDACeaFWP3xiG9SQviJx2tbBLzb9Asi
 3zqiJ/wcrR8ug==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 27 Apr 2026 12:04:57 +0200
Subject: [PATCH v5 1/4] dma-buf: heaps: Export mem_accounting parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dma-buf-heaps-as-modules-v5-1-b6f5678feefc@kernel.org>
References: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
In-Reply-To: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=mripard@kernel.org;
 h=from:subject:message-id; bh=DVp9SIjZvLo7LHKT0aFcqmpT0ICBVAk6Lir7Cpdt3so=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvTS6tafvtvWv6mh+bl6Z8bN7Ru6CH7exr7qgFe/Z7H
 a2R+nKyuGMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMRN6WsT44uNxO4ATnvH+P
 vR0PGTDPVPP73xCyY9dW05dJv75PdZf9uMKjwPN4qpt7ys8zTwz2bWOszwvg/KmqaTpHLirus8l
 jZ6VL4n9ypinF5hj4vZJMWpPHuzHs4J6SlX0yOyc4lefe+lkAAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The mem_accounting kernel parameter is used by heaps to know if they
should account allocations in their respective cgroup controllers.

Since we're going to allow heaps to compile as modules, we need to
export that variable.

Reviewed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/dma-buf/dma-heap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a649..a76bf3f8b071 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -51,10 +51,11 @@ static DEFINE_XARRAY_ALLOC(dma_heap_minors);
 
 bool __read_mostly mem_accounting;
 module_param(mem_accounting, bool, 0444);
 MODULE_PARM_DESC(mem_accounting,
 		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
+EXPORT_SYMBOL_NS_GPL(mem_accounting, "DMA_BUF_HEAP");
 
 static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
 				 u32 fd_flags,
 				 u64 heap_flags)
 {

-- 
2.53.0

