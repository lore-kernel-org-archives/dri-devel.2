Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AB606EEAE
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeM/btHK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9962C1122EB;
	Thu,  5 Nov 2026 10:06:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FA21122D6
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:05:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 42CE143BC7;
 Thu,  5 Nov 2026 10:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401511F000C1;
 Thu,  5 Nov 2026 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793873156;
 bh=Tb4JGV8lW+i8A2m/AB7bze5JBefc12/UK66I1obVy6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VeM/btHK/QysLlM1cYfXyKoPisKsbQJkcLwb9hY5IVO0ZCMl9djcOk6qGhOTEy/RS
 SXrVkMOZfZImy3Fi5CMUe+2b7qTpNXbphwikZsGYWlMRtD5OL46w567gaCe8DZyIHu
 8YsWC9W496+6+uucLHV7VpEc8QkeIiR0YfjS5EuGQMGGx1rK3MovkLc6/ZzFAZj79i
 SFRdU9TW0HyNtR8hvzYo3MyLUV1qgiBexJVaehxl0quWrU9qfuM6zHGxM84p4FMLga
 pfZpH2R4+ZgKdsFLdF+9iccooKQNioX1lLRduQ7Rgedinsgl8sfPzAJdPWM6uXtXN2
 p3gLzQYTLpTEQ==
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
Subject: [PATCH v13 01/19] PCI/P2PDMA: Honor device-specific ACS redirection
Date: Thu,  5 Nov 2026 12:04:32 +0200
Message-ID: <20261105-fix-p2p-acs-v4-0-v13-1-3dd065907c3b@nvidia.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-fix-p2p-acs-v4-0-v13-0-3dd065907c3b@nvidia.com>
References: <20261105-fix-p2p-acs-v4-0-v13-0-3dd065907c3b@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Leon Romanovsky <leonro@nvidia.com>

Some ports, such as Zhaoxin Switch Downstream Ports, redirect peer-to-peer
traffic without an ACS capability, as their device-specific ACS quirks
report. P2PDMA reads only ACS Control, so below such a port it hands out
bus addresses for traffic that goes to the host bridge.

Take Request and Completion Redirect from a bridge's quirk too. Ignore
endpoint quirks, which only describe traffic between an endpoint's own
functions. Skip bridges on a root bus: they never sit between two peers,
and the AMD southbridge quirk may sleep there during DMA mapping.

pci=disable_acs_redir= cannot override a quirk, so name such ports
separately.

Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 114 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 45260423dfb09..ba94b0f339285 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -21,6 +21,8 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
+#include "pci.h"
+
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -490,6 +492,44 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 	return NULL;
 }
 
+/*
+ * Some ports send peer-to-peer traffic upstream without a standard ACS
+ * capability, such as Zhaoxin Root and Switch Downstream Ports. Their
+ * device-specific ACS quirks say so. Report whether @pdev's quirk says that
+ * @flag is in effect.
+ *
+ * Only ask bridges. The quirks for multi-function endpoints only say that
+ * their functions do not talk to each other directly, which says nothing
+ * about their traffic to other devices. Skip bridges on a root bus too. They
+ * never decide whether two peers connect directly, and for them the AMD
+ * southbridge quirk calls acpi_get_table(), which may sleep. DMA mapping may
+ * call this code where sleeping is not allowed.
+ */
+static bool pci_acs_p2pdma_quirk(struct pci_dev *pdev, u16 flag)
+{
+	if (!pci_is_bridge(pdev) || pci_is_root_bus(pdev->bus))
+		return false;
+
+	return pci_dev_specific_acs_enabled(pdev, flag) > 0;
+}
+
+/*
+ * Add the Request and Completion Redirect that @pdev's quirk reports to its
+ * ACS Control value. Only ever add them: a quirk that covers every device of
+ * a vendor says "no" for the ones it does not know, and that must not hide
+ * their own ACS controls. What a quirk says about other controls only means
+ * that the control does not apply, so ignore it.
+ */
+static u16 pci_acs_p2pdma_quirk_redirect(struct pci_dev *pdev, u16 ctrl)
+{
+	if (pci_acs_p2pdma_quirk(pdev, PCI_ACS_RR))
+		ctrl |= PCI_ACS_RR;
+	if (pci_acs_p2pdma_quirk(pdev, PCI_ACS_CR))
+		ctrl |= PCI_ACS_CR;
+
+	return ctrl;
+}
+
 /*
  * Check if a PCI bridge has its ACS redirection bits set to redirect P2P
  * TLPs upstream via ACS. Returns 1 if the packets will be redirected
@@ -498,14 +538,13 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
 {
 	int pos;
-	u16 ctrl;
+	u16 ctrl = 0;
 
 	pos = pdev->acs_cap;
-	if (!pos)
-		return 0;
-
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pos)
+		pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
 
+	ctrl = pci_acs_p2pdma_quirk_redirect(pdev, ctrl);
 	if (ctrl & (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC))
 		return 1;
 
@@ -520,6 +559,51 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+/*
+ * Sort a port that redirects into @acs_list, the ports to suggest for
+ * pci=disable_acs_redir=, or @quirk_list. That parameter only clears the ACS
+ * Control register, so it cannot undo a redirect that a device quirk reports.
+ */
+static void pci_p2pdma_list_redir(struct seq_buf *acs_list,
+				  struct seq_buf *quirk_list,
+				  struct pci_dev *pdev)
+{
+	if (pci_acs_p2pdma_quirk(pdev, PCI_ACS_RR) ||
+	    pci_acs_p2pdma_quirk(pdev, PCI_ACS_CR))
+		seq_buf_print_bus_devfn(quirk_list, pdev);
+	else
+		seq_buf_print_bus_devfn(acs_list, pdev);
+}
+
+/* Drop the final semicolon. Returns false if no port was listed. */
+static bool pci_p2pdma_end_list(struct seq_buf *list)
+{
+	if (!seq_buf_used(list))
+		return false;
+
+	if (!seq_buf_has_overflowed(list))
+		list->buffer[list->len - 1] = '\0';
+	return true;
+}
+
+static void pci_p2pdma_warn_redir(struct pci_dev *client,
+				  struct pci_dev *provider,
+				  struct seq_buf *acs_list,
+				  struct seq_buf *quirk_list)
+{
+	pci_warn(client,
+		 "ACS redirect is set between the client and provider (%s)\n",
+		 pci_name(provider));
+	if (pci_p2pdma_end_list(quirk_list))
+		pci_warn(client,
+			 "hardware redirects peer-to-peer traffic at %s, which no kernel parameter changes\n",
+			 seq_buf_str(quirk_list));
+	if (pci_p2pdma_end_list(acs_list))
+		pci_warn(client,
+			 "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
+			 seq_buf_str(acs_list));
+}
+
 static bool cpu_supports_p2pdma(void)
 {
 #ifdef CONFIG_X86
@@ -722,13 +806,14 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	struct pci_dev *a = provider, *b = client, *bb;
 	struct pci_p2pdma *p2pdma;
-	struct seq_buf acs_list;
+	struct seq_buf acs_list, quirk_list;
 	int acs_cnt = 0;
 	int dist_a = 0;
 	int dist_b = 0;
-	char buf[128];
+	char buf[128], quirk_buf[64];
 
 	seq_buf_init(&acs_list, buf, sizeof(buf));
+	seq_buf_init(&quirk_list, quirk_buf, sizeof(quirk_buf));
 
 	/*
 	 * Note, we don't need to take references to devices returned by
@@ -739,7 +824,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		dist_b = 0;
 
 		if (pci_bridge_has_acs_redir(a)) {
-			seq_buf_print_bus_devfn(&acs_list, a);
+			pci_p2pdma_list_redir(&acs_list, &quirk_list, a);
 			acs_cnt++;
 		}
 
@@ -768,7 +853,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 			break;
 
 		if (pci_bridge_has_acs_redir(bb)) {
-			seq_buf_print_bus_devfn(&acs_list, bb);
+			pci_p2pdma_list_redir(&acs_list, &quirk_list, bb);
 			acs_cnt++;
 		}
 
@@ -782,15 +867,8 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		goto done;
 	}
 
-	if (verbose) {
-		/* Drop the final semicolon; the list is not empty here */
-		if (!seq_buf_has_overflowed(&acs_list))
-			acs_list.buffer[acs_list.len - 1] = '\0';
-		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
-			 pci_name(provider));
-		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
-			 seq_buf_str(&acs_list));
-	}
+	if (verbose)
+		pci_p2pdma_warn_redir(client, provider, &acs_list, &quirk_list);
 
 map_through_host_bridge:
 	if (!cpu_supports_p2pdma() &&

-- 
2.56.0

