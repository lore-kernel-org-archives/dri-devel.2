Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4360CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1752810E8F4;
	Tue, 13 Oct 2026 14:25:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2D2810E8A3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 14:25:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B56F860A52;
 Tue, 13 Oct 2026 14:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D507D1F000FF;
 Tue, 13 Oct 2026 14:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791901538;
 bh=BjTdMoFaO2CEchYCl9cp1x7qqKnBvpdTbTjUMlMqgVA=;
 h=From:To:Cc:Subject:Date;
 b=Fp3xQmHmj8lInW5fszvUA/8NO8UxDy9ieVVG+bfnIUti1PcPxhjFgYiYcTDbed06C
 waRCr2jkTTX9tDJC2W92dqecRYF6Mn4AbAMDFyy7UK3v/emGRYOqXm9F20RYFuoqVb
 wxPHdQJfYxE3DmDeR7Al26V8LYcB57pDi9aN2/7WMKzd0bzmhAla0y1gwqRgxvotKw
 4/0zjYX7g3n7nrfpiGPL04e/QNxLCRpygoWUYi5OFxZ8piqBYboogdq7vRXqfl66Sk
 2p/q9BXpV6tkRxgWzD5qTE2f7ptBu6+hlWTIzfpGd8HgF3E3qdgTy+qIsc5xKl6ImK
 LPLYKwJT/zWvA==
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
Subject: [PATCH v11 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Date: Tue, 13 Oct 2026 17:25:08 +0300
Message-ID: <20261013-fix-p2p-acs-v4-0-v11-0-72cf8c96e617@nvidia.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260821-fix-p2p-acs-v4-0-e72455e3a261
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

PCI P2PDMA applies Request and Completion Redirect throughout both paths.
This misclassifies asymmetric and nested switches, and reports one answer
for every kind of TLP.

Three ACS controls act on TLP attributes the Requester chooses rather
than on the topology: Translation Blocking and Direct Translated P2P act on
a Request's Address Type, and Completion Redirect skips Completions carrying
Relaxed Ordering.

Evaluate each direction at the path divergence, decide every class from the
one walk, and treat a client with ATS enabled as translating unless its
driver declares per-mapping ATS.

This completes the P2PDMA side; dma-buf and mlx5 follow separately.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changes in v11:
- Applied the client ATS policy in pci_p2pdma_distance_many() too, as
  local Sashiko pointed out.
- Read the ATS Enable bit once per query, so the class and the ATS policy
  always agree.
- Documented that pcim_p2pdma_set_ats_per_mapping() needs a successful
  pcim_p2pdma_init().
- The path diagnostics no longer read ACS Control or the bridge bus range,
  and they report a failed cache store.
- Added a KUnit case for Direct Translated P2P without a redirect.
- Clarified the Relaxed Ordering and diagnostics commit messages.
- Honored device-specific ACS redirection, such as Zhaoxin Downstream
  Ports, in a new first patch with a KUnit case, as local Sashiko
  pointed out. Relaxed Ordering Completions are redirected at such a
  port too.
- Clarified in the documentation that a quirk also redirects Relaxed
  Ordering Completions and that Translation Blocking applies only to
  upstream Requests, and labelled the ACS routing debug line with its
  class, as local Sashiko pointed out.
- Treated ACS registers that read as all ones as unreadable, and named
  ports that a quirk redirects instead of suggesting
  pci=disable_acs_redir= for them, as local Sashiko pointed out.
- Ignored ACS quirks of endpoints, which only describe traffic between
  their own functions.
- Link to v10: https://patch.msgid.link/20261012-fix-p2p-acs-v4-0-v10-0-6ffe7b7a4517@nvidia.com

Changes in v10:
- Fixed the Relaxed Ordering description: a Completion carries the
  attribute of its Request (PCIe r7.0 sec 2.2.9.1).
- Used the PCIe terms Requester and Completer for TLPs, ACS and ports;
  client and provider remain for P2PDMA objects.
- Rebased on pci/p2pdma, which includes the prerequisite P2PDMA fixes.
- Added a topology example to the path divergence patch.
- Removed a repeated sentence from the disable_acs_redir documentation.
- Explained the path divergence in the documentation.
- Link to v9: https://patch.msgid.link/20261001-fix-p2p-acs-v4-0-v9-0-1a8e0f50ddd9@nvidia.com

Changes in v9:
- Removed dmabuf patches for now.
- Removed mlx5 per-mapping ATS declaration for now; it comes back with
  the dmabuf patches.
- Link to v8: https://patch.msgid.link/20260928-fix-p2p-acs-v4-0-v8-0-404453b9c435@nvidia.com

Changes in v8:
- Added extra Reviewed-by from Logan.
- Added patches to take care of ATS per-device vs. per-mapping option
- Link to v7: https://patch.msgid.link/20260920-fix-p2p-acs-v4-0-v7-0-ca0828ab697c@nvidia.com

Changes in v7:
- Removed "Document pdev->p2pdma lifetime rules" patch, it gives nothing
  after p2pmem fix.
- Split dmabuf patch.
- Tushar retested the series, so added his Tested-by.
- Added Logan's ROB tags and fixed minor documentation issues pointed
  by him.
- Link to v6: https://lore.kernel.org/all/20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com/

Changes in v6:
- Changed DMABUF to use callbacks and not directly stored pointer.
- Link to v5: https://patch.msgid.link/20260910-fix-p2p-acs-v4-0-v5-0-856087f63c0d@nvidia.com

Changes in v5:
- Rebase on the posted fixes.
- Dropped tags from changed patches.
- Remove Egress Control Vector interpretation and coverage.
- Keep enabled Egress Control conservative as a Request redirect.
- Use pci_dbg()/dev_dbg() for diagnostics and drop the "debug" prefix.
- Removed code comments from "Document the pdev->p2pdma lifetime and RCU
  rules" patch and reduced description to actual lifetime explanation.
- Added note that Linux assumes that TLPs are in strict-ordering and
  untranslated.
- Added code to calculate p2p paths per-TLP type.
- Converted mlx5 to use that new proposed API.
- Link to https://patch.msgid.link/20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com

Changes in v4:
- Reject ACS Violations and unreadable routing state instead of treating
  them as host-bridge redirects
- Added Tested-by tags from Tushar Dave
- Added support to asymmetric ACS routing
- Limited redirect checks to the two ports at the path divergence
- Added standalone ACS routing diagnostics for hardware retesting
- Dropped " PCI: Account for Direct Translated P2P in ACS isolation checks" patch
- Link to v3: https://patch.msgid.link/20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com

Changes in v3:
- Fixed pci_p2pdma_add_resource() error unwinding
- Made pdev->p2pdma teardown wait unconditionally for RCU readers
- Restricted pci_p2pmem_find_many() to pool-backed providers
- Documented the pdev->p2pdma lifetime and RCU rules
- Fixed calc_map_type_and_dist() handling of the verbose argument
- Required the ACS port and target to share a bus before indexing the
  Egress Control Vector
- Gave pci_acs_enabled() and pci_acs_path_enabled() a scope, so the ACS
  Direct Translated P2P rule no longer stops pci_enable_pasid() from
  enabling PASID
- Dropped "Report ACS ports when the paths share no upstream bridge":
  the mapping type cannot change without a shared upstream bridge, so
  the pci=disable_acs_redir= hint was not actionable there and the ACS
  walk only cost config space reads
- Folded the Request Redirect rule into pci_acs_rr_ineffective(), so
  pci_acs_flags_enabled() and the Intel SPT PCH quirk share one copy
- Renamed pci_acs_egress_ctrl_set() to pci_acs_egress_ctrl_is_set(), it
  reads the bit rather than setting it
- Reworded the blocked-path warning: ACS may also leave the direct route
  indeterminate rather than blocked
- Added KUnit coverage for the shared-bus guard, a device with no ACS
  capability and an unreadable ACS Control register
- Added the missing Fixes: tags, a second one on the
  pci_p2pdma_add_resource() unwinding fix (the dangling devres action
  dates to f58ef9d1d135) and one on the Egress Control isolation change
- Link to v2: https://patch.msgid.link/20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com

Changes in v2:
- Added Logan's ROB tags
- Added commas in Documentation patch
- Link to v1: https://patch.msgid.link/20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com

---
Leon Romanovsky (19):
      PCI/P2PDMA: Honor device-specific ACS redirection
      PCI/P2PDMA: Document the TLP attribute assumptions
      PCI/P2PDMA: Derive routing from directional ACS controls
      PCI: Reject unreadable ACS controls in isolation checks
      PCI/P2PDMA: Evaluate ACS controls at the path divergence
      PCI/P2PDMA: Document directional ACS routing
      PCI/P2PDMA: Collect the path's ACS controls before deciding
      PCI/P2PDMA: Answer routing per TLP class
      PCI/P2PDMA: Route Relaxed Ordering Completions directly
      PCI/P2PDMA: Reject Translated Requests blocked by Translation Blocking
      PCI/P2PDMA: Route Translated Requests under Direct Translated P2P
      PCI/P2PDMA: Log detailed ACS routing diagnostics
      PCI/P2PDMA: Add KUnit tests for the ACS routing decisions
      PCI/P2PDMA: Test the ACS P2P routing walk
      PCI: Add KUnit coverage for ACS isolation checks
      PCI/P2PDMA: Document TLP-class routing
      PCI/P2PDMA: Let a client declare that it selects ATS per mapping
      PCI/P2PDMA: Evaluate the ATS path for clients with ATS enabled
      PCI/P2PDMA: Test the routing of clients with ATS enabled

 Documentation/admin-guide/kernel-parameters.txt |   11 +-
 Documentation/driver-api/pci/p2pdma.rst         |  105 ++
 drivers/pci/Kconfig                             |   15 +
 drivers/pci/Makefile                            |    1 +
 drivers/pci/p2pdma.c                            |  942 +++++++++++++++--
 drivers/pci/pci.c                               |    8 +-
 drivers/pci/pci.h                               |   57 ++
 drivers/pci/pci_acs_test.c                      | 1225 +++++++++++++++++++++++
 drivers/pci/quirks.c                            |    8 +-
 include/linux/pci-p2pdma.h                      |   12 +-
 10 files changed, 2292 insertions(+), 92 deletions(-)
---
base-commit: 36038f0e8377ef316b723d0d85b1510bc64069ab
change-id: 20260821-fix-p2p-acs-v4-0-e72455e3a261

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

