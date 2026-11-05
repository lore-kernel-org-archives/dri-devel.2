Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7746082BCB
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esLlFqvf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 763921122E5;
	Thu,  5 Nov 2026 10:06:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46571122E5
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:05:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AD45A439AB;
 Thu,  5 Nov 2026 10:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80511F00A1A;
 Thu,  5 Nov 2026 10:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793873159;
 bh=fe/evDSNyaXnVj0kmfTZYpJ40ZN+6vDDBqaE+yHUgds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=esLlFqvfKGx8XTi/l9UWCveBJbNxHLH4pLxH1UnkP6qf4fpx9tf+bqLKSCgrtH1i4
 zqjWA40R291i4hkr4im5wr5sRycxAjBJ1akvtp15irC+6xReFRAeV9z1BjyfUY4uT5
 sLI5PxDLzcgjp4g0Egzix/up9M+q1Lq3rzEF9lvjncX8RwUnBtUHcAwI/QpedEQGMJ
 9wX8AOQvP2R9XVm3Dgem2jx3oCRTtkAoCvnA+3zX4LDckdmQYqqEXX53NNCczTlO5d
 bIhYzcyxZdzM9myKXONqTJ6I95MP1wGstg+YDLicYHNonskHm9F9hxkM6/NH34HHFw
 w+MpBR4et7WtQ==
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
Subject: [PATCH v13 04/19] PCI: Reject unreadable ACS controls in isolation
 checks
Date: Thu,  5 Nov 2026 12:04:35 +0200
Message-ID: <20261105-fix-p2p-acs-v4-0-v13-4-3dd065907c3b@nvidia.com>
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

pci_acs_flags_enabled() and the Intel SPT PCH quirk use ACS registers
without checking config-space read errors. A failed read may leave control
state indeterminate yet allow the device to satisfy requested isolation
controls. So can a read that returns all ones with a successful status,
which is what a device that does not answer usually produces.

Return false when either ACS capability or control state cannot be read
or reads as all ones, which neither register can legitimately hold. An
unknown state cannot prove isolation.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c    | 4 +++-
 drivers/pci/quirks.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba81443..6d677695c0f57 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3627,7 +3627,9 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl) ||
+	    PCI_POSSIBLE_ERROR(ctrl))
+		return false;
 	return (ctrl & acs_flags) == acs_flags;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7f1f47ea2ee41..05605c3afe08f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5145,10 +5145,14 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 		return -ENOTTY;
 
 	/* see pci_acs_flags_enabled() */
-	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap) ||
+	    PCI_POSSIBLE_ERROR(cap))
+		return 0;
 	acs_flags &= (cap | PCI_ACS_EC);
 
-	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl) ||
+	    PCI_POSSIBLE_ERROR(ctrl))
+		return 0;
 
 	return pci_acs_ctrl_enabled(acs_flags, ctrl);
 }

-- 
2.56.0

