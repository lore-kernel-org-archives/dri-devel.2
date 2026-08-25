Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310F2C5DF9C
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 929AD10E90D;
	Tue, 25 Aug 2026 06:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H1CZwoSh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 000BE10E90D
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:28:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A78E043E76;
 Tue, 25 Aug 2026 06:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAF01F00A3D;
 Tue, 25 Aug 2026 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639295;
 bh=ecQDxocNxhe6h8WbRg2jY1pkJAbLQwhKP5LlEGGTfco=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H1CZwoShDUcMcVFat6MyVVKUti2dBkhBzfiZtrKIP2wentndbsb1zDEhq/+/IyPU7
 zYHDTgOnbFBMNsgfJwrZ3lqEgPsAJuBkynmyJW60IZPmTdyNnKby5B1dcUNmS1Neiz
 5/XtTgiWs4targ6k6uascEufIsAI9dPGaR95AF2JbYk8vppd2UabszovE51evl9BUn
 f5j+rW1f8/k3TfjDmKXm/ILn1ipgcTAM3W77bmVntWKUSILJxrIpMzUDpdX7xO0qdE
 u/0Mzbzwc5LKkrkyJ5y3I9VWo59sbcywF8hTbfCp2AhFnp0ZBVHnIkHuTebpqsV/HU
 NbF9eyV+nzBmQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Date: Tue, 25 Aug 2026 09:28:01 +0300
Message-ID: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
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

From: Leon Romanovsky <leonro@nvidia.com>

Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
documentation pointing at move_notify(), a symbol that no longer
exists. Readers grepping for it find nothing, and this is the only
place in Documentation/ describing the revocation requirement.

Name the current function and record that importers which cannot unmap
within bounded time have to be rejected at attach time, which is what
makes the synchronous unmap on remove() achievable.

Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_invalidate_mappings()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/driver-api/pci/p2pdma.rst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index d3f406cca694..63cff9e4d2c9 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -167,9 +167,11 @@ In this case the initiator and target pci_devices are known and the P2P subsyste
 is used to determine the mapping type. The phys_addr_t-based DMA API is used to
 establish the dma_addr_t.
 
-Lifecycle is controlled by DMABUF move_notify(). When the exporting driver wants
+Lifecycle is controlled by DMABUF revocation. When the exporting driver wants
 to remove() it must deliver an invalidation shutdown to all DMABUF importing
-drivers through move_notify() and synchronously DMA unmap all the MMIO.
+drivers through dma_buf_invalidate_mappings() and synchronously DMA unmap all
+the MMIO. Importers unable to complete that unmap within bounded time have to
+be rejected when they attach, which dma_buf_attach_revocable() checks for.
 
 No importing driver can continue to have a DMA map to the MMIO after the
 exporting driver has destroyed its p2p_provider.

-- 
2.55.0

