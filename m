Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E83CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B515E10F0BF;
	Mon, 12 Oct 2026 13:08:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DBC10F0AE
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:08:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB01960229;
 Mon, 12 Oct 2026 13:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBAD1F0089B;
 Mon, 12 Oct 2026 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791810512;
 bh=2sSCU6Q0SZFAXfLBen7fegyLWGZ/skMbkRUb74lwhsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UHHr+9KT5aRqLx86H6eMwXfhXM2PQ7VRQ5L9/ZNyKI5a+eZX3zbm/bHTdxwsJeDJk
 jfxSzYtfKC/R5FKP2faJfPi5EKtHNBpj+VwfBvOdpjafdp0ew/IoQ1373ZBQ1AJUo/
 IhaJ0r4ueVwieoVbA7dHSLzNpo0gUS52KLshUAAoUhZhRHyhVzAp5bwFLL/nok3wE6
 L5UbWFGA9LpFe2vv7KOHGA0Rdio29mzDCExOCcEciOwnYjwdVgdK+VzpttWE6L4lqW
 fQgOFXWHafabHAutnqX4MXrV5ux4E7Jlmw7dldTPeWiOmp6QQ56btebHDoY1arGq32
 CpP69IBpX5xMw==
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
Subject: [PATCH v10 05/18] PCI/P2PDMA: Document directional ACS routing
Date: Mon, 12 Oct 2026 16:07:42 +0300
Message-ID: <20261012-fix-p2p-acs-v4-0-v10-5-6ffe7b7a4517@nvidia.com>
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

P2PDMA documentation describes ACS controls as path-wide, although Request
and Completion controls apply to different transaction directions and only
affect peer-versus-upstream decisions at the path divergence.

Document the client as the Requester and the provider as the Completer,
the divergence port checked for each TLP direction, and the conservative
handling of unreadable ACS state. Clarify which controls disable_acs_redir
changes.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++++-----
 Documentation/driver-api/pci/p2pdma.rst         | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd2..8507ac79a919 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5292,11 +5292,12 @@ Kernel parameters
 				Specify one or more PCI devices (in the format
 				specified above) separated by semicolons.
 				Each device specified will have the PCI ACS
-				redirect capabilities forced off which will
-				allow P2P traffic between devices through
-				bridges without forcing it upstream. Note:
-				this removes isolation between devices and
-				may put more devices in an IOMMU group.
+				P2P Request Redirect, Completion Redirect, and
+				Egress Control features forced off. This may
+				allow P2P traffic through bridges that would
+				otherwise be redirected upstream. Note: this
+				removes isolation between devices and may
+				cause affected devices to share an IOMMU group.
 		config_acs=
 				Format:
 				<ACS flags>@<pci_dev>[; ...]
diff --git a/Documentation/driver-api/pci/p2pdma.rst b/Documentation/driver-api/pci/p2pdma.rst
index 80f8fec9b0e9..40f5268ba9db 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,24 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+The client is the PCIe Requester and the provider is the Completer, whether
+the client reads or writes provider memory. If both are below the same Root
+Port, their paths toward it first meet in a Switch, where the paths diverge.
+A Request enters that Switch through the Downstream Port above the
+Requester, the Requester-side port. If ACS P2P Request Redirect is enabled
+there, the Request is routed upstream; otherwise it is routed back
+downstream through the Downstream Port leading to the Completer, the
+Completer-side port. The path of Completions from a read likewise depends on
+ACS P2P Completion Redirect in the Completer-side port. An enabled Egress
+Control is conservatively treated as a Request redirect.
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

