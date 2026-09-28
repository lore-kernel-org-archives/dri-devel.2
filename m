Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E2ECA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4EC10E993;
	Mon, 28 Sep 2026 11:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AYy3vZeN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA49910E988
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:19:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C056E43F82;
 Mon, 28 Sep 2026 11:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E6F1F00893;
 Mon, 28 Sep 2026 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790594397;
 bh=mB9EKqkzLzypkhdTWBPdUAfJNQuk4resftiaCbJ0Vhw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AYy3vZeNzUSfVd9qqCLfr+jCi3f/iQBED+byl+jLLW7DezK2HbRFX1rWtTCxeJTNN
 sXgUnwkCcruda6PvyOtS7GYkRUj5TD0OOEbFGYesvYhdEIuKRKKPO7bk9F2ow26BmR
 5FYFJDk0bWTTL/p8WgdMl335SgYPUlfRGp0sgx1qI/CtoiIGBpi3JteYFmbv9QCT/Y
 48yT/tG108bIJOtOtX0swGaaKfmrxBsJ5Saqa23jozkdDErMacEC1mqL5v2ijdkNNg
 Hm/gbGdC8saZRKyy5f1BtV+24yYLM6tBXmdYu9UR7XCA015ajnsn6O9ls5Kn87C97y
 lgQRY8UDP2kwQ==
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
Subject: [PATCH v8 03/23] PCI: Reject unreadable ACS controls in isolation
 checks
Date: Mon, 28 Sep 2026 14:19:07 +0300
Message-ID: <20260928-fix-p2p-acs-v4-0-v8-3-404453b9c435@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
References: <20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com>
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

pci_acs_flags_enabled() and the Intel SPT PCH quirk use ACS registers
without checking config-space read errors. A failed read may leave control
state indeterminate yet allow the device to satisfy requested isolation
controls.

Return false when either ACS capability or control state cannot be read.
An unknown state cannot prove isolation.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/pci.c    | 3 ++-
 drivers/pci/quirks.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..f7d94ecf9157 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3594,7 +3594,8 @@ static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
 	 */
 	acs_flags &= (pdev->acs_capabilities | PCI_ACS_EC);
 
-	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+	if (pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl))
+		return false;
 	return (ctrl & acs_flags) == acs_flags;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21f..d5c3e6802840 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4992,10 +4992,12 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
 		return -ENOTTY;
 
 	/* see pci_acs_flags_enabled() */
-	pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap);
+	if (pci_read_config_dword(dev, pos + PCI_ACS_CAP, &cap))
+		return 0;
 	acs_flags &= (cap | PCI_ACS_EC);
 
-	pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl);
+	if (pci_read_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, &ctrl))
+		return 0;
 
 	return pci_acs_ctrl_enabled(acs_flags, ctrl);
 }

-- 
2.55.0

