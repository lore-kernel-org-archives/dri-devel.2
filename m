Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F9606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=EjAuQD9k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A50410FC20;
	Wed, 11 Nov 2026 19:24:28 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3399410EA89
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:19 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4dab94dc3e7so6119544b6e.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425058; x=1795029858;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
 b=EjAuQD9kk9ZETlUx36748GaFjgd0R4TBrmdB028GZFo308c96+8+v8xQkOL5o9xXdB
 mJww4DahVjrZhYVdBzHbC9Evt/gFFY2skDAFbvNtqHUGnEB8KmTM9Gbs5uQOT+a9QvIN
 Qx3otSNTEIpkpT5p3SYQA23hCBQ2WFjxZ9qGM1km8IJ8L9rL20Gf+oqHsOdZ+iA371lB
 0gPubxqCaHqVMKfdKXoUMGOjIl3RPUNngvxj3xDuC0UzSU1W2ZEWNWWjFsHZZDQ97/b1
 MlpAEJYn7PwrB2XUmp9Y9y0FK5/67uSvTQDnhWOeRORBc0CQbKbU0O6iJ4xkIRVjABEb
 5cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425058; x=1795029858;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6lt1PxCFx0agGLbXpFKlY/hoUAzM5xkPqAiIkWnGNA=;
 b=uWI29Baci94TMdA1L8jTkRMb3rWMi/DmDG7QCn0hPfppNiVeAtVche7lfnaeFBUyFa
 X9Hv/Nw+heRAIs4YLgOXP8L5HVlq0ttzdrjXW6kas74NaT5bMmK8UVATfAOcda7aokjl
 mgu7PMGwZlziPomHuKqLy0T8TuKcPpWWD75W0d6sT5bjWnPg1HMRPQu8JeLQenQle07Q
 hlHBkBBU/BASoE2C8RBw78qvZ5Jwgonulq2+Uhqhf72R1eM2W1vnufSXFDbWOT6iCXOk
 6AqFcEpVVzyQjyvgje753wasQwaRRdrs6gyKKyZpHYJN7NA8vVZ+PQZk1z/gnj6pri3J
 ahhQ==
X-Gm-Message-State: APuU4Z/4BkKjry8/SdkpOc0gNRM0nidvrp/OPw9jSGuTBu0XxMv0y5bs
 Y7bNdxDyKHeAEfLjJslapHw2dew3CZf0EtBj8Tk/txbjFOrjk+tUl7E2oIXcJXByOULhR3D31QE
 OIOyxuhoorD6WlennjX7iGbBBsSJHGVEb7eFKqOBzytTqnesKHvQ8KAH3p+V2Tym7EabHqIBtwF
 m5mFboJgmvu8FWXvR8XT+dd7Eli6REXRp90Hg2rm83M0Xqv59+0S1quqcdUtc=
X-Received: from iltr6.prod.google.com ([2002:a92:c5a6:0:b0:542:f469:6209])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:23c7:b0:568:e5f:5dbe with SMTP id
 5614622812f47-56b97d0f43cmr3278637b6e.61.1794425058062; 
 Wed, 11 Nov 2026 11:24:18 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:06 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-3-dmatlack@google.com>
Subject: [RFC PATCH 2/7] vfio: selftests: Verify memory behavior in
 vfio_pci_find_mem_bar()
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
 David Matlack <dmatlack@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Matt Evans <mattev@meta.com>, 
 Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Write and read back test patterns before returning a BAR from
vfio_pci_find_mem_bar(), restoring the original contents and
PCI_COMMAND_MEMORY state afterward.

QEMU's pci-testdev exposes a readable, writable, mmap-capable BAR2
whenever membar=<size> is passed, even if membar-backed=on was omitted
and accesses are dropped as unimplemented MMIO. Probing the BAR upfront
lets callers skip cleanly instead of failing later DMA or fault checks.

Suggested-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index d5308fe61490..9840463594ab 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -13,6 +13,7 @@
 #include <sys/mman.h>
 
 #include <linux/align.h>
+#include <linux/io.h>
 #include <linux/iommufd.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
@@ -265,6 +266,33 @@ static const struct vfio_pci_mem_bar_desc mem_bar_descs[] = {
 	},
 };
 
+static bool vfio_pci_mem_bar_verify(struct vfio_pci_device *device, void *vaddr)
+{
+	const u64 pattern = 0x55aa55aa55aa55aaULL;
+	u16 orig_cmd;
+	u64 orig;
+	bool ok;
+
+	orig_cmd = vfio_pci_config_readw(device, PCI_COMMAND);
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND,
+				       orig_cmd | PCI_COMMAND_MEMORY);
+
+	orig = readq(vaddr);
+	writeq(pattern, vaddr);
+	ok = (readq(vaddr) == pattern);
+	if (ok) {
+		writeq(~pattern, vaddr);
+		ok = (readq(vaddr) == ~pattern);
+	}
+	writeq(orig, vaddr);
+
+	if (!(orig_cmd & PCI_COMMAND_MEMORY))
+		vfio_pci_config_writew(device, PCI_COMMAND, orig_cmd);
+
+	return ok;
+}
+
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar)
 {
@@ -273,6 +301,8 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 				  VFIO_REGION_INFO_FLAG_WRITE;
 	size_t i;
 
+	min_size = max_t(u64, min_size, sizeof(u64));
+
 	for (i = 0; i < ARRAY_SIZE(mem_bar_descs); i++) {
 		const struct vfio_pci_mem_bar_desc *desc = &mem_bar_descs[i];
 		struct vfio_pci_bar *bar;
@@ -300,6 +330,9 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 		if (size < min_size)
 			continue;
 
+		if (!vfio_pci_mem_bar_verify(device, bar->vaddr + desc->offset))
+			continue;
+
 		*mem_bar = (struct vfio_pci_mem_bar){
 			.bar = bar,
 			.vaddr = bar->vaddr + desc->offset,
-- 
2.56.0.567.gdb80ae8cd5-goog

