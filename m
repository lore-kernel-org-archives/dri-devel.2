Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6057BCA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB30510E388;
	Thu,  1 Oct 2026 11:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m37rOJ9v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7753B10E388
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 11:56:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECD2960A58;
 Thu,  1 Oct 2026 11:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A441F0089C;
 Thu,  1 Oct 2026 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790855796;
 bh=FJiSzgsjWJTKuHSDD3BgssMes6luTH/QucCnOlpO4ug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m37rOJ9vwSpy2w5vyFgpZ5cwzBGY9fZV0e0xpsoyAV86czqsAeW/Ym8lbtODjoAcJ
 Sht88J8FJMBcxNhf1XcXvGNxM3ky6kUIwpyVObdnHSWll5IE4N7jvP/Ob2DsrOGAUQ
 kZ1POJXtHoP3gHm59LG4+hIS149xcA5w5n/lWNqMdxsS5ZQdMuRGqqjqQemxuFm4Ib
 e5O/UifP9qxZ28Eer1Pd2mKQ7cANVJ7B1FwoH4c2e4b/lUR8nyYUX8M9ZI34PBBq04
 r1MCLEdKduvsESFvk1KtjRL62zJjHjtSw4D6MVJ5nNl2sKgW9aGfLqpjW+Ro8+0Mb5
 HlUOc9PEHLpQA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v9 10/18] PCI/P2PDMA: Route Translated Requests under Direct
 Translated P2P
Date: Thu,  1 Oct 2026 14:55:18 +0300
Message-ID: <20261001-fix-p2p-acs-v4-0-v9-10-1a8e0f50ddd9@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
References: <20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com>
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

A Downstream Port with ACS Direct Translated P2P enabled routes a Request
whose Address Type is Translated "to the peer Egress Port without
redirection, regardless of ACS P2P Request Redirect and ACS P2P Egress
Control", per PCIe r7.0 sec 6.12.3. P2PDMA assumes every Request carries an
Untranslated address, so it sends an ATS client through the host bridge
even where the fabric would route it straight to the peer.

Add PCI_P2PDMA_TLP_TRANSLATED and consult Direct Translated P2P for the
Requests it describes.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 569a74de3b3a..3fd2cb8d16f0 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -548,6 +548,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_flags)
 		 */
 		if (ctrl & PCI_ACS_TB)
 			return PCI_ACS_P2PDMA_BLOCKED;
+
+		/*
+		 * PCIe r7.0 sec 6.12.3: ACS Direct Translated P2P routes a
+		 * Request carrying a Translated address to the peer "without
+		 * redirection, regardless of ACS P2P Request Redirect and ACS
+		 * P2P Egress Control settings".
+		 */
+		if (ctrl & PCI_ACS_DT)
+			return PCI_ACS_P2PDMA_DIRECT;
 	}
 
 	return ctrl & (PCI_ACS_RR | PCI_ACS_EC) ?

-- 
2.55.0

