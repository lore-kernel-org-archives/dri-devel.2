Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD81DC5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E691810EFC3;
	Thu, 20 Aug 2026 10:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mlwwcH/a";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D6C5C10EFC3
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:50:49 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62090153B;
 Thu, 20 Aug 2026 03:50:45 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com
 [10.1.25.29])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A10D3F66F;
 Thu, 20 Aug 2026 03:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787223049; bh=s+cclRtih9v6Hs6kBVo28nQebq5TpBMtlvcObiYbvrQ=;
 h=From:To:Cc:Subject:Date:From;
 b=mlwwcH/aloHp948hET2x3PglkjTmwV/C1vkj4LhUjCsvHCVxnIRjXXyQwKoBYSh4b
 W+TlkspsuCda4N8/HpdlCseT+Wzo469vRfIBo0hw8qEsFKeS3KGD/R2gvOJo0XQPrb
 myWmYHFHFnn8mQ0++38cbrZszC/fDjicPCDrukH8=
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
Subject: [PATCH 0/2] Clear shared pages after private-to-shared conversion
Date: Thu, 20 Aug 2026 11:50:23 +0100
Message-ID: <20260820105026.53208-1-steven.price@arm.com>
X-Mailer: git-send-email 2.43.0
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

Arm CCA includes "Memory Encryption Contexts" (MEC) which allows the
private and shared data accessible to a guest to have different memory
encryption keys. Consequently when converting memory to shared, the
memory encryption key used to access the physical page will change.

Both the GICv3 ITS driver and the system_cc_shared dma-buf heap
currently allocate memory with __GFP_ZERO and then decrypt it. With MEC
the zeroing is done with the wrong encryption key and the data visible
after decryption may be ciphertext. The RMM is required to scrub the
data, but may perform this scrub with a different encryption key to the
eventual key that will be used for shared access.

Fix these two sites by avoiding the __GFP_ZERO during the allocation and
performing a clear_pages() call after the decryption.

Steven Price (2):
  irqchip/gic-v3-its: Zero shared pages after conversion
  dma-buf: heaps: Zero system shared heap pages after conversion

 drivers/dma-buf/heaps/system_heap.c | 14 +++++++++++---
 drivers/irqchip/irq-gic-v3-its.c    |  7 ++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.43.0

