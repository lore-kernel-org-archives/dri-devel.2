Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDBCC5DF94
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF19110E90A;
	Tue, 25 Aug 2026 06:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cVEAhocc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E9B10E90A
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:28:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC549601DE;
 Tue, 25 Aug 2026 06:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1491F000E9;
 Tue, 25 Aug 2026 06:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639291;
 bh=TP56VsXx4o6K0JUttMJo51Rr9+rzcKB07guB4pW2+gA=;
 h=From:To:Cc:Subject:Date;
 b=cVEAhocctiz3IGvk7fyBIg2AOTvIzbAHSnvFlWwjNMLxyOLDAmninH3TYVhdjr+rB
 i1MPsoZp7XzvU4k3FaT4W0xsroh7cCWPH6LOMukTwyZJX7Ul/ZPI/806emzuF5wUPl
 O6oTaj/L5HYfK+syLZK1+LVNZuWpgSGXavWE41+Gq+OCfS0t9UrLmPGpg4pgidtRJg
 P0/Wov3NNvrsJnGNw/IL97svfQWOdzbvvCEV+VQ5lilhAr+xcpC+T9IuUCn2x86ehw
 1UGvl4qtOwVFAN+gfDscahFl+DcUomgUGtB+ZTMMT6tkCumcnsuBtNBZjjDg1ZTquL
 ANYX/YkNVDTYg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Leon Romanovsky <leon@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 0/2] Document the DMA-buf mapping lifetime negotiation
Date: Tue, 25 Aug 2026 09:28:00 +0300
Message-ID: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260820-document-dma-buf-3f8b41e32f57
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

DMA-buf lets an exporter pin, move or revoke the backing storage under
an importer, and which of the three applies is decided by the optional
callbacks each side implements and by whether dma_buf_pin() succeeds.
Nothing in Documentation/ describes that, and the single reference to
the mechanism still names move_notify(), removed in v7.1.

Thanks

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Leon Romanovsky (2):
      PCI/P2PDMA: Update DMABUF lifecycle docs after move_notify() rename
      dma-buf: Document how exporters and importers agree on mapping lifetime

 Documentation/driver-api/dma-buf.rst    |  6 +++
 Documentation/driver-api/pci/p2pdma.rst |  6 ++-
 drivers/dma-buf/dma-buf.c               | 85 ++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 3 deletions(-)
---
base-commit: 8049741ac93acd3a590dac070e12571fddf0e294
change-id: 20260820-document-dma-buf-3f8b41e32f57

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

