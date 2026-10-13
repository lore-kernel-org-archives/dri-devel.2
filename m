Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778C6CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D0110E8D2;
	Tue, 13 Oct 2026 14:26:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC19010E8D2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:26:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CA8F602C3;
 Tue, 13 Oct 2026 14:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF61F00893;
 Tue, 13 Oct 2026 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791901605;
 bh=WG+/MfLUa2KXCGjNpEZD5DpO8B15ADgfE37JB04Jd0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cjpjcwhQ08kpVME5luFwPj/OdAFYg5N43adQrydL3gRtJCZThX0Lzs2EZ6vuIFJP1
 FwxR0Jr7FgJXo3ndq3trqHLAfp0W4cc/oxMuVs+2yWTfgie6878z8hJSpHwHqrRiVW
 y1gW0r28Vc4hRu70778+jdQz8xrp+xxoi49wETou07e7n+B73x0ozai5JrmTaYJIKI
 O5mLQHcmvmwsxnzxOlGkYdP2iY2A4S/5olPIReoolz6ILuwkt48vyGwMRatuGZMb0h
 Mz/zTegDcusL++/Eqspm6eek8z0+MbbCzPDfozjawbYzABGAPE3jHqgMQPE/y4xZvv
 KCG/H+dm/Pfyg==
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
Subject: [PATCH v11 19/19] PCI/P2PDMA: Test the routing of clients with ATS
 enabled
Date: Tue, 13 Oct 2026 17:25:27 +0300
Message-ID: <20261013-fix-p2p-acs-v4-0-v11-19-72cf8c96e617@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
References: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
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

A client that enables ATS for the whole device must never be handed a
bus address, and Translation Blocking must reject its peer-to-peer
traffic even when the caller asks for the default class. That has to
hold for answers taken from the cache as well.

Cover those on the fabricated fabric, together with a client that
declared per-mapping ATS keeping the per-class answers and a client
without ATS answering for the Untranslated Requests it will issue.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c       |   8 +--
 drivers/pci/pci.h          |   6 +++
 drivers/pci/pci_acs_test.c | 123 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index a81cd37a1834..df664d43c502 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -1448,14 +1448,15 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 }
 EXPORT_SYMBOL_IF_KUNIT(calc_map_type_and_dist);
 
-static unsigned int pci_p2pdma_client_tlp_flags(struct pci_dev *client,
-						unsigned int tlp_flags)
+VISIBLE_IF_KUNIT unsigned int
+pci_p2pdma_client_tlp_flags(struct pci_dev *client, unsigned int tlp_flags)
 {
 	if (client->ats_enabled)
 		return tlp_flags | PCI_P2PDMA_TLP_TRANSLATED;
 
 	return tlp_flags & ~PCI_P2PDMA_TLP_TRANSLATED;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_p2pdma_client_tlp_flags);
 
 /*
  * A client that translates every address it is handed cannot be handed a bus
@@ -1467,7 +1468,7 @@ static unsigned int pci_p2pdma_client_tlp_flags(struct pci_dev *client,
  * Take the Address Type from @tlp_flags rather than reading the ATS Enable
  * bit again, so the policy and the class it applies to always agree.
  */
-static enum pci_p2pdma_map_type
+VISIBLE_IF_KUNIT enum pci_p2pdma_map_type
 pci_p2pdma_client_map_type(struct pci_dev *provider, struct pci_dev *client,
 			   bool per_mapping, unsigned int tlp_flags,
 			   enum pci_p2pdma_map_type type)
@@ -1486,6 +1487,7 @@ pci_p2pdma_client_map_type(struct pci_dev *provider, struct pci_dev *client,
 
 	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 }
+EXPORT_SYMBOL_IF_KUNIT(pci_p2pdma_client_map_type);
 
 /* Whether the driver of @client called pcim_p2pdma_set_ats_per_mapping(). */
 static bool pci_p2pdma_client_per_mapping(struct pci_dev *client)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 99852cf99732..882a1d8e9316 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1142,6 +1142,12 @@ enum pci_p2pdma_map_type calc_map_type_and_dist(struct pci_dev *provider,
 						int *dist,
 						unsigned int tlp_flags,
 						bool verbose);
+unsigned int pci_p2pdma_client_tlp_flags(struct pci_dev *client,
+					 unsigned int tlp_flags);
+enum pci_p2pdma_map_type
+pci_p2pdma_client_map_type(struct pci_dev *provider, struct pci_dev *client,
+			   bool per_mapping, unsigned int tlp_flags,
+			   enum pci_p2pdma_map_type type);
 #endif
 
 #ifdef CONFIG_PCI_QUIRKS
diff --git a/drivers/pci/pci_acs_test.c b/drivers/pci/pci_acs_test.c
index 369444d2a04a..11c86949c3d1 100644
--- a/drivers/pci/pci_acs_test.c
+++ b/drivers/pci/pci_acs_test.c
@@ -1050,6 +1050,125 @@ static void acs_walk_unreadable_control_test(struct kunit *test)
 			PCI_P2PDMA_MAP_NOT_SUPPORTED);
 }
 
+/*
+ * Route the way pci_p2pdma_map_type_tlp() does once it has a client: the
+ * client decides which flags apply, and the answer is then checked against
+ * what the client can be handed.
+ */
+static enum pci_p2pdma_map_type acs_client_map(struct acs_fabric *f,
+					       bool per_mapping,
+					       unsigned int tlp_flags)
+{
+	enum pci_p2pdma_map_type type;
+	int dist;
+
+	if (!per_mapping)
+		tlp_flags = pci_p2pdma_client_tlp_flags(f->client, tlp_flags);
+	type = calc_map_type_and_dist(f->provider, f->client, &dist, tlp_flags,
+				      false);
+	return pci_p2pdma_client_map_type(f->provider, f->client, per_mapping,
+					  tlp_flags, type);
+}
+
+/*
+ * A client with ATS enabled for the whole device translates whatever it is
+ * handed, so it never gets bus addresses even on a direct route, and
+ * Translation Blocking rejects it even when its caller asks for the default
+ * class.
+ */
+static void acs_client_ats_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	f.client->ats_enabled = 1;
+
+	KUNIT_EXPECT_EQ(test, acs_client_map(&f, false, 0),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+
+	f.client_leaf->acs_cap = 0x100;
+	f.client_leaf->acs_capabilities = PCI_ACS_TB;
+	f.client_leaf_cfg.ctrl = PCI_ACS_TB;
+
+	KUNIT_EXPECT_EQ(test, acs_client_map(&f, false, 0),
+			PCI_P2PDMA_MAP_NOT_SUPPORTED);
+}
+
+/*
+ * The cache holds what the topology allows, filled when the client first
+ * asked. A client whose ATS was enabled after that must still be kept off the
+ * bus addresses the cache recorded.
+ */
+static void acs_client_ats_cached_test(struct kunit *test)
+{
+	enum pci_p2pdma_map_type type[PCI_P2PDMA_TLP_CLASSES], hit;
+	struct acs_fabric f = {};
+	unsigned long cached;
+	unsigned int flags;
+	int dist;
+
+	acs_build_fabric(test, &f);
+	for (flags = 0; flags < PCI_P2PDMA_TLP_CLASSES; flags++)
+		type[flags] = calc_map_type_and_dist(f.provider, f.client,
+						     &dist, flags, false);
+	cached = pci_p2pdma_map_types_pack(type);
+
+	f.client->ats_enabled = 1;
+	flags = pci_p2pdma_client_tlp_flags(f.client, 0);
+	hit = pci_p2pdma_map_types_unpack(cached, flags);
+
+	KUNIT_EXPECT_EQ(test,
+			pci_p2pdma_client_map_type(f.provider, f.client, false,
+						   flags, hit),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
+/*
+ * A client that declared per-mapping ATS picks the Address Type per mapping,
+ * so it keeps the per-class answers even with ATS enabled.
+ */
+static void acs_client_ats_per_mapping_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	f.client->ats_enabled = 1;
+
+	KUNIT_EXPECT_EQ(test, acs_client_map(&f, true, 0),
+			PCI_P2PDMA_MAP_BUS_ADDR);
+	KUNIT_EXPECT_EQ(test,
+			acs_client_map(&f, true, PCI_P2PDMA_TLP_TRANSLATED),
+			PCI_P2PDMA_MAP_BUS_ADDR);
+
+	f.client_leaf->acs_cap = 0x100;
+	f.client_leaf->acs_capabilities = PCI_ACS_TB;
+	f.client_leaf_cfg.ctrl = PCI_ACS_TB;
+
+	KUNIT_EXPECT_EQ(test, acs_client_map(&f, true, 0),
+			PCI_P2PDMA_MAP_BUS_ADDR);
+	KUNIT_EXPECT_EQ(test,
+			acs_client_map(&f, true, PCI_P2PDMA_TLP_TRANSLATED),
+			PCI_P2PDMA_MAP_NOT_SUPPORTED);
+}
+
+/*
+ * A client with ATS disabled cannot issue Translated Requests, so a caller
+ * asking about them gets the answer for the Untranslated ones it will issue.
+ */
+static void acs_client_no_ats_test(struct kunit *test)
+{
+	struct acs_fabric f = {};
+
+	acs_build_fabric(test, &f);
+	f.dn1->acs_cap = 0x100;
+	f.dn1->acs_capabilities = PCI_ACS_RR | PCI_ACS_DT;
+	f.dn1_cfg.ctrl = PCI_ACS_RR | PCI_ACS_DT;
+
+	KUNIT_EXPECT_EQ(test,
+			acs_client_map(&f, false, PCI_P2PDMA_TLP_TRANSLATED),
+			PCI_P2PDMA_MAP_THRU_HOST_BRIDGE);
+}
+
 static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE_PARAM(pci_acs_p2pdma_request_test,
 			 acs_request_gen_params),
@@ -1088,6 +1207,10 @@ static struct kunit_case pci_acs_test_cases[] = {
 	KUNIT_CASE(acs_walk_tb_above_divergence_test),
 	KUNIT_CASE(acs_walk_unreadable_control_test),
 	KUNIT_CASE(acs_map_types_pack_test),
+	KUNIT_CASE(acs_client_ats_test),
+	KUNIT_CASE(acs_client_ats_cached_test),
+	KUNIT_CASE(acs_client_ats_per_mapping_test),
+	KUNIT_CASE(acs_client_no_ats_test),
 	{}
 };
 

-- 
2.55.0

