Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C5F8C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D4710E18C;
	Sun, 13 Sep 2026 21:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=matt3o12.de header.i=@matt3o12.de header.b="iCUHrDVC";
	dkim-atps=neutral
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B17110EA2A
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:08:48 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1789333726;
 bh=YAfzGGez1KlfbwFRmw6Z8+ppdhSswn0ovC86+tjumRg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iCUHrDVCx5pMJJkUSJ5nLeZX2odZx2TdJUQFVxerVFcRiOZ6Xwg+NfCy1znXa0/+z
 s5LKhhlOMfxWbViL4c3m84lkUKO5PCxnfkypVosDgMePDEW1SIevHQcgXi3fJKyeTG
 O+uUZF/OgXAV4ARKG9adA1PR6tBtvRzGWRTNl9+M5bzWFZ4v0LGRAQ6nDu5pVG9ePX
 Bgp0pGN4AiBXYHiL4aWLWAt53DgPOFd/g/ITYRtRj6jcXvqrYHZUs5xvUTPCX9Ysgg
 bUnEOlm+wIx5RUatkQoV7I4xCAc2l9G7pNK6pL1BMVz65HnYrwHzYrfOJ1qpfmdmrI
 3DJbU/mczEwRA==
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: aliceryhl@google.com, ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Kloiber <kernel@matt3o12.de>
Subject: [PATCH v2 1/2] gpu: nova-core: declare unlimited DMA max segment size
Date: Sun, 13 Sep 2026 23:08:27 +0200
Message-ID: <20260913210828.125655-2-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260913210828.125655-1-kernel@matt3o12.de>
References: <20260913210828.125655-1-kernel@matt3o12.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 21:13:31 +0000
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

The PCI default max_seg_size is 64 KiB. nova-core never raises it, so
mapping the GSP firmware image (~60 MiB) as a scatter-gather table
triggers a DMA-API debug warning when contiguous pages coalesce into
segments that exceed the default:

  DMA-API: nova-core 0000:00:03.0: mapping sg segment longer than
  device claims to support [len=62914560] [max=65536]

CONFIG_DMA_API_DEBUG=y is required to see this warning.

Assisted-by: LLM
Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
---
 drivers/gpu/nova-core/gpu.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fd1414004dd0..edc0207c01a0 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -343,6 +343,13 @@ pub(crate) fn new<'a>(
                 // still constructing it, so no concurrent DMA allocations can exist.
                 unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
 
+                // Nova walks SG segments to build page tables, so their length is
+                // irrelevant to the device.
+                //
+                // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
+                // still constructing it, so no concurrent DMA allocations can exist.
+                unsafe { pdev.dma_set_max_seg_size(u32::MAX) };
+
                 hal.wait_gfw_boot_completion(bar)
                     .inspect_err(|_| dev_err!(dev, "GFW boot did not complete\n"))?;
             },
-- 
2.51.2

