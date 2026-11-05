Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909260A5BEB
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hs+XDWX3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FE2E1122F9;
	Thu,  5 Nov 2026 10:06:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAC61122F9
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 10:06:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 738EE602C3;
 Thu,  5 Nov 2026 10:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349271F00A1B;
 Thu,  5 Nov 2026 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793873185;
 bh=1wSg0P0JlpDTru459JdaTZtxJPYqqxs66LTFgnBwoG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Hs+XDWX3hyjpS0fjz84Ko2yPFchlZ+d1AQJFkSEHg7J8dLrtYITMGeNLX/z1Waw2A
 9/i77nZQgprsqSVNTvWKo83llgrPVtv8tZZNBqCBpdqTHBOnAi+SKpQ+N76u8fcn6t
 yWlPs95AIMPcJnA95FuUxFgpxf+CCgifp4AScFqYDw89bQQ0kjiJk5THZ9vWBiEAPX
 3YxHhBOaOyGcJDFYy1XhJDD2yy5vX7jaLbrHuML4pkuE5NhRMrtX/TK7tOz5wgQXFk
 dCh9AZ0zXQDB/2A5yv+aqnSy3TxZZfX3ziCWw9T3+8gYETWyd62RxbWZn/iIaYilZn
 dlm9YPql0lcNg==
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
Subject: [PATCH v13 06/19] PCI/P2PDMA: Document directional ACS routing
Date: Thu,  5 Nov 2026 12:04:37 +0200
Message-ID: <20261105-fix-p2p-acs-v4-0-v13-6-3dd065907c3b@nvidia.com>
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

P2PDMA documentation describes ACS controls as path-wide, although Request
and Completion controls apply to different transaction directions at the
path divergence. Functions sharing one PCIe link may instead have no
internal peer route even with redirect controls clear.

Document the Requester and Completer roles, the directional controls and
the forwarding requirements at shared ancestors for host routes. Explain
that unusable forwarding leaves direct routes available, while clearing
redirect controls cannot create an unsupported internal sibling route.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 ++++----
 Documentation/driver-api/pci/p2pdma.rst         | 35 +++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..f7e116703ffcd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5251,11 +5251,12 @@ Kernel parameters
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
index 80f8fec9b0e90..91e6367151f1d 100644
--- a/Documentation/driver-api/pci/p2pdma.rst
+++ b/Documentation/driver-api/pci/p2pdma.rst
@@ -15,6 +15,41 @@ then based on the ACS settings the transaction can route entirely within
 the PCIe hierarchy and never reach the root port. The kernel will evaluate
 the PCIe topology and always permit P2P in these well-defined cases.
 
+The client is the PCIe Requester and the provider is the Completer, whether
+the client reads or writes provider memory. For devices on separate links
+below the same Root Port, their paths first meet in a Switch, where they
+diverge.
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
+Control register needed for a route cannot be read, that route is rejected.
+
+Functions sharing one PCIe link can instead route internally within their
+device. An ACS capability without Request or Completion Redirect support
+means that the corresponding internal route does not exist. Device-specific
+ACS quirks can report the same restriction for functions without ACS, and
+SR-IOV functions without ACS cannot support internal peer traffic. These
+restrictions apply only between functions sharing the link, including ARI
+functions and VFs; they do not redirect traffic to a separate device.
+
+When traffic continues upstream beyond the divergence, ACS Upstream Forwarding
+must be enabled, or provided by a device-specific quirk, at every shared
+Downstream and Root Port on the way to the host bridge. This includes ports
+above a shared Switch Upstream Port as well as ports shared by sibling
+functions. Missing forwarding support or unreadable forwarding controls reject
+the host route while leaving direct routes available. The host bridge must
+also support P2P. Clearing redirect controls cannot create an internal route
+that the device does not support.
+
 This evaluation assumes clients issue strictly ordered Requests carrying an
 Untranslated address. Its result is not defined when clients use Relaxed
 Ordering or issue ATS-translated Requests because those TLP attributes can

-- 
2.56.0

