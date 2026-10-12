Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AACDCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF97A10F0D5;
	Mon, 12 Oct 2026 13:08:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67E9C10F0B5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:08:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48B2143F34;
 Mon, 12 Oct 2026 13:08:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CEF1F0089C;
 Mon, 12 Oct 2026 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810529;
 bh=y0WZbGUQD1BEIDYhHiBoWaxT/qrY6ovGmKyOwjI/8YA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OAGopptlj7aBR+m73Cc8aR0Kfc/yjLnrkNnV8q5FrWrerwIRWtmoC09yqvGb2LVbM
 FF57E/CNQvwejmz5Wa0WZoYXvwLk5H16Ogy41v9wYxg0ZGcH2nW73tRWj1ir6CFe27
 /qKd6KeJecCPtqVG9Wg1E4OgheO5MPRbFtved5OfsNZEM/AT12oYTBMQ+JjRDV4Nv2
 royEY2j/NW4eFwrAyYYueDYmyE/HWU3SRrtkcOcT2POgAEvNhQRr5V2N8wyIJ/syba
 FJzx3apGKgkjthpmv4gucTaOAYE9icjTpEyqMAELKb76Le0l+OPtPbFyrAnz3O1RiJ
 30SB66xU9Ltiw==
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
Subject: [PATCH v10 10/18] PCI/P2PDMA: Route Translated Requests under Direct
 Translated P2P
Date: Mon, 12 Oct 2026 16:07:47 +0300
Message-ID: <20261012-fix-p2p-acs-v4-0-v10-10-6ffe7b7a4517@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
References: <20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com>
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

Consult Direct Translated P2P for the PCI_P2PDMA_TLP_TRANSLATED classes.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 0f9bb96f2176..ebc34aae03a1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -546,6 +546,15 @@ pci_acs_p2pdma_request(u16 ctrl, unsigned int tlp_flags)
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
@@ -966,10 +975,11 @@ pci_p2pdma_map_types_unpack(unsigned long val, unsigned int tlp_flags)
  * redirection setting of the ports along the path.
  *
  * The client is the Requester and the provider the Completer. At the path
- * divergence, check Request Redirect and Egress Control on the Requester-side
- * port, and Completion Redirect for read Completions on the Completer-side
- * port. Translation Blocking is checked on every port the Request passes
- * instead, because it rejects a Request rather than routing it.
+ * divergence, check Request Redirect, Egress Control and Direct Translated
+ * P2P on the Requester-side port, and Completion Redirect for read
+ * Completions on the Completer-side port. Translation Blocking is checked on
+ * every port the Request passes instead, because it rejects a Request rather
+ * than routing it.
  *
  * Those controls apply to different TLPs, so every class named by &enum
  * pci_p2pdma_tlp_flags is decided from the one walk and cached together;

-- 
2.55.0

