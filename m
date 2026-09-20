Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AF0C982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABEB10EA03;
	Sun, 20 Sep 2026 11:42:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O8gddd5m";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3585D10EA03
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:42:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ACA4E6022B;
 Sun, 20 Sep 2026 11:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742D01F000FF;
 Sun, 20 Sep 2026 11:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789904535;
 bh=NXMIcf51pqX530la2Oa4PtVUCCs8cvksEPgvaOoHW6w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O8gddd5mp15jUZ7kAPto2BM0TiYEG9lPjMo3u6tZV2oTCYB/z2oVvT7t55gHU2zHI
 qcIkOcLR2zMrIWygs1uIZXQcLoGEFnTc2f03QsJQCGlIIjv1JMHKqsOB2lbKioEr9O
 FN5BjV3Y1/HCnYpWUm6uNYl9uP2d1aGHOCvdmUjMHjPG8uYUHW5wQmZ5Dco0hvBU/q
 5ewprFrKDxXjh8/K/DwCa8NAGqHHEA7YEb/nfJLHA9Ph5GWiSZqMTpug3uYgPcSxjn
 rZvDYzyMoM/SfOGbXd8mevmrcPx5veD+CJxu+iPq8E2tG+rxeXZgiCzQY0EKzndK4N
 PKUSne8y4blgw==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Ankit Agrawal <ankita@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Randy Dunlap <rdunlap@infradead.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v7 05/19] PCI/P2PDMA: Document directional ACS routing
Date: Sun, 20 Sep 2026 14:41:17 +0300
Message-ID: <20260920-fix-p2p-acs-v4-0-v7-5-ca0828ab697c@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920-fix-p2p-acs-v4-0-v7-0-ca0828ab697c@nvidia.com>
References: <20260920-fix-p2p-acs-v4-0-v7-0-ca0828ab697c@nvidia.com>
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

P2PDMA documentation describes ACS controls as path-wide, although Request
and Completion controls apply to different transaction directions and only
affect peer-versus-upstream decisions at the path divergence.

Document the fixed client and provider roles, the divergence port checked
for each TLP direction, and the conservative handling of unreadable ACS
state. Clarify which controls disable_acs_redir changes.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++------
 Documentation/driver-api/pci/p2pdma.rst         | 13 +++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..bc83e07dd5fc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5291,12 +5291,15 @@ Kernel parameters
 		disable_acs_redir=<pci_dev>[; ...]
 				Specify one or more PCI devices (in the format
 				specified above) separated by semicolons.
-				Each device specified will have the PCI ACS
-				redirect capabilities forced off which will
-				allow P2P traffic between devices through
-				bridges without forcing it upstream. Note:
-				this removes isolation between devices and
-				may put more devices in an IOMMU group.
+				Each device specified will have the PCI ACS P2P
+				Request Redirect, Completion Redirect, and Egress
+				Control features forced off. This may allow P2P
+				traffic through bridges that would otherwise be
+				redirected upstream. This may allow P2P traffic
+				through bridges that would otherwise be redirected
+				upstream and thus this removes isolation between
+				devices and may cause affected devices to share
+				an IOMMU group.
 		config_acs=
 				Format:
 				<ACS flags>@<pci_dev>[; ...]
diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 80f8fec9b0e9..42b18610bf7d 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,19 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+The client remains the PCIe requester when it reads or writes provider memory.
+Where the paths diverge, the kernel therefore evaluates P2P Request Redirect
+and Egress Control on the client-side port, and P2P Completion Redirect on the
+provider-side port for completions from a read. An enabled Egress Control is
+conservatively treated as a Request redirect.
+
+Below the divergence, the route toward the other branch is already upstream,
+so those P2P redirect controls do not affect it. Redirect controls for the
+reverse transaction directions do not affect the mapping. P2P DMA is routed
+through the host bridge when either applicable port redirects. If an ACS
+Control register cannot be read, P2P DMA is rejected because the kernel cannot
+establish a usable route.
+
 This evaluation assumes clients issue strictly ordered Requests carrying an
 Untranslated address. Its result is not defined when clients use Relaxed
 Ordering or issue ATS-translated Requests because those TLP attributes can

-- 
2.55.0

