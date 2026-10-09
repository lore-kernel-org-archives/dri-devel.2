Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A81CA6015
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 01:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAA2810E18C;
	Fri,  9 Oct 2026 01:10:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="hkW0ryOb";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2BC210E18C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=qSjdS+jjbWu2dBBtAcqMX8OeigCICcsVNMw5EqE90jA=; b=hkW0ryObarzrgu2IO6KUf746V9
 zXWkoSJ7DMHPJ9kZ+2R6JkhqcHpx1Cb+0Ml5ngQOCn0JP4UJKu3ePsyeJunC9IIGvPYaPw8JktgxY
 uAIi4t/GaZKGYHwEPDu77YerwxpwmCaW+bLlmPaig9if7LBxKkmF8v8Pmh1syxpXfdqk7NN9xjZDF
 9w+LAwb3dkQk4yIUFBUgZgdRfjg3Yulh+7iiN+MvWF0moLBCAbzn7huQr/bv0PNFnNHX0duKDQgbL
 eKpDhzdA0U9hX8mVyAyFVzrMDHb5mTtNChCbyZMOcTi8pMcZebKJ1NjmWr6ktbYawcfB/t24LnGB4
 CkzfEKFQ==;
Received: from [104.129.159.233] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1xEz8K-00000005EC1-072V; Fri, 09 Oct 2026 01:10:48 +0000
From: "Liam R. Howlett" <liam@infradead.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>
Subject: [PATCH] accel/amdxdna: Fix Kconfig invalid configuration
Date: Thu,  8 Oct 2026 21:10:10 -0400
Message-ID: <20261009011010.3521631-1-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
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

The amdxdna has a soft dependency on the amd_pmf module.  It will use an
exported function if it is available and fall back to another function
if it is not enabled.

amdxdna and amd_pmf are tridstate modules supporting both built [y] and
modularized [m] in the .config file.  Since the amdxdna decides to use
the amd_pmf if it is either a module or built in (see
drivers/accel/amdxdna/aie2_pci.h), then there is an issue if they are
not compiled either both as modules or both as built-in.

Adding the optional dependency to Kconfig does not allow the
configuration from being selected.

Fixes: f66d6cc6891e4 ("accel/amdxdna: Support sensors for column utilization")
Signed-off-by: Liam R. Howlett <liam@infradead.org>
---
 drivers/accel/amdxdna/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/amdxdna/Kconfig b/drivers/accel/amdxdna/Kconfig
index f39d7a87296cd..eddff490b4f75 100644
--- a/drivers/accel/amdxdna/Kconfig
+++ b/drivers/accel/amdxdna/Kconfig
@@ -6,6 +6,7 @@ config DRM_ACCEL_AMDXDNA
 	depends on DRM_ACCEL
 	depends on PCI && HAS_IOMEM
 	depends on X86_64
+	depends on AMD_PMF || !AMD_PMF
 	select DRM_SCHED
 	select DRM_GEM_SHMEM_HELPER
 	select FW_LOADER
-- 
2.47.3

