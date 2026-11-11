Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D26070066
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MEIVm5xo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF0710E32D;
	Wed, 11 Nov 2026 19:24:27 +0000 (UTC)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3076910E456
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:18 +0000 (UTC)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4e937c5bd4fso2650750b6e.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425057; x=1795029857;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c1gmqyzGXPZYxPfKkRYqwd2gnFVkzUbXgN8JNV1Au+8=;
 b=MEIVm5xogkTJ5iU25Gz01c+bAuWtOwQ52rGOI2y1MZ6jWQ8koXzy05t8WX5FaV7js0
 g1TwWY2hgtqcfve1SydZuQTBaL7JhXlWOTPEbKzrHLbZTV0dbkfiUdJOv2P++BoROJQc
 sAG85oDOXzOXIJiMyvm3jawmw7EKQ+p6+6kaG1BYkUU66ayrdfWfC4jkpWMSQdeKyi5V
 Nxj2yerkyTEqbu1iiBZ2uTh7zB42jXWe3YBFY9ZPyMwzVc7aXfOdiHcb89SsuCD7RpoP
 TzJEPUsjCGvHpUBqNmkyAVE/KU3OKGrGl3UvAVBMygna/BCv9xnxEZvubuxwnvkvn4xD
 +uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425057; x=1795029857;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c1gmqyzGXPZYxPfKkRYqwd2gnFVkzUbXgN8JNV1Au+8=;
 b=AEOpZnoenY+/+/XQXa6ZMdQbUmhn43/kxxrS1U/BfN+ivi2WlnhcAPamIp/sRAieAj
 D2Xkq8h7oPud2iEnzmEZ4K/PCzS2dlhJQvCJg4Gg/zCV3SKdQI6lnV/KRmREFXZX4jHO
 lt2oCgvZbLA8LE6Qd1gOBnJaKqNsbj7/C8k9OtEizatOurvwECqDN58I4bgHWpNujnCy
 6Js0iAFAK4aNkPKjrIbY6j/gpSlHamX81Cnfr6VaPclIySgW5K8S7vhNGz/mWuE+AlRZ
 8JIfu38dvfoJ3tsbJV+N4fdzo6TtgI6C11C0yHvAdZD7H7auL2rlhoTsP5cyViqp4ZAr
 auIA==
X-Gm-Message-State: APuU4Z++bDNpOfMIU/n67QkylFqOQG1mTwKcRAqj/vecfi/Ppw22uUrz
 e92ZQUnDHV1rm3B3aOHR47XArrG/jNnBxTGRO/fBmB91Dr4GXQppWFCk1VjG7kj+4Mj073c+SO1
 C1pV5L67IG1eqmzIqd3/8ETkk/F51zuQEORVCIeoMb7FYBaZF2c+7i8HKHgQOj7gW5OjCfwGTg0
 TRtInVjptenA5LLnFe9Kt+6e0YTXfmiztp75PTqZ8B0lwyXfYh3XJ4f6KnFOc=
X-Received: from ilbdx27-n1.prod.google.com
 ([2002:a05:6e02:421b:10b0:53d:3ab5:58fa])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1382:b0:567:f784:f939 with SMTP id
 5614622812f47-56b9791019amr2605655b6e.51.1794425056843; 
 Wed, 11 Nov 2026 11:24:16 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:05 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-2-dmatlack@google.com>
Subject: [RFC PATCH 1/7] vfio: selftests: Add vfio_pci_find_mem_bar() helper
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

From: Mina Almasry <almasrymina@google.com>

Add vfio_pci_find_mem_bar() to libvfio to locate a BAR (or range within
a BAR) of at least min_size bytes that behaves like ordinary memory and
can be safely read and written without device-specific side effects.

Detection is backed by a table of known devices, starting with QEMU's
pci-testdev (1b36:0005) BAR 2 when configured with membar=<size> and
membar-backed=on.

Suggested-by: David Matlack <dmatlack@google.com>
Cc: David Matlack <dmatlack@google.com>
Cc: Matt Evans <matt@ozlabs.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     | 10 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 67 +++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 007adc322c1e..19d458adba1a 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -15,6 +15,13 @@ struct vfio_pci_bar {
 	void *vaddr;
 };
 
+struct vfio_pci_mem_bar {
+	struct vfio_pci_bar *bar;
+	void *vaddr;
+	u64 offset;
+	u64 size;
+};
+
 struct vfio_pci_device {
 	const char *bdf;
 	int fd;
@@ -162,6 +169,9 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 		(device_id == vfio_pci_config_readw(device, PCI_DEVICE_ID));
 }
 
+bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
+			   struct vfio_pci_mem_bar *mem_bar);
+
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 4063a0e2b3df..d5308fe61490 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -19,6 +19,7 @@
 #include <linux/log2.h>
 #include <linux/mman.h>
 #include <linux/overflow.h>
+#include <linux/pci_ids.h>
 #include <linux/sizes.h>
 #include <linux/types.h>
 #include <linux/vfio.h>
@@ -245,6 +246,72 @@ static void vfio_pci_bar_unmap_all(struct vfio_pci_device *device)
 	}
 }
 
+#define PCI_DEVICE_ID_REDHAT_TEST	0x0005
+
+struct vfio_pci_mem_bar_desc {
+	u16 vendor_id;
+	u16 device_id;
+	u8 bar_index;
+	u64 offset;
+	u64 size;
+};
+
+static const struct vfio_pci_mem_bar_desc mem_bar_descs[] = {
+	/* QEMU pci-testdev with membar=<size>,membar-backed=on */
+	{
+		.vendor_id = PCI_VENDOR_ID_REDHAT,
+		.device_id = PCI_DEVICE_ID_REDHAT_TEST,
+		.bar_index = 2,
+	},
+};
+
+bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
+			   struct vfio_pci_mem_bar *mem_bar)
+{
+	const u32 rw_mmap_flags = VFIO_REGION_INFO_FLAG_MMAP |
+				  VFIO_REGION_INFO_FLAG_READ |
+				  VFIO_REGION_INFO_FLAG_WRITE;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(mem_bar_descs); i++) {
+		const struct vfio_pci_mem_bar_desc *desc = &mem_bar_descs[i];
+		struct vfio_pci_bar *bar;
+		u64 size;
+
+		if (!vfio_pci_device_match(device, desc->vendor_id,
+					   desc->device_id))
+			continue;
+
+		VFIO_ASSERT_LT(desc->bar_index, PCI_STD_NUM_BARS);
+		bar = &device->bars[desc->bar_index];
+
+		if ((bar->info.flags & rw_mmap_flags) != rw_mmap_flags)
+			continue;
+
+		VFIO_ASSERT_NOT_NULL(bar->vaddr);
+
+		if (bar->info.size <= desc->offset)
+			continue;
+
+		size = bar->info.size - desc->offset;
+		if (desc->size)
+			size = min(size, desc->size);
+
+		if (size < min_size)
+			continue;
+
+		*mem_bar = (struct vfio_pci_mem_bar){
+			.bar = bar,
+			.vaddr = bar->vaddr + desc->offset,
+			.offset = desc->offset,
+			.size = size,
+		};
+		return true;
+	}
+
+	return false;
+}
+
 void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 			    size_t config, size_t size, void *data)
 {
-- 
2.56.0.567.gdb80ae8cd5-goog

