Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE17606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DnQMeCXp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA6D10E456;
	Wed, 11 Nov 2026 19:25:23 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A562510EA89
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:24 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-8490253aeb6so3309456a34.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425064; x=1795029864;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
 b=DnQMeCXp0nOF3JiQmfIpNllenrczPkowCHQFY3zJnzLauk58aYFV66ZPMCUbXJWrzB
 +kGW3lrzzurPZdtDmbmvGdG6q+9Vk6Cs235BCNPrb9UCuviqHvWBP+SJhgH5bULBkW/s
 Ad5T2sUlK9u4PaTrK6sc7sl+7xcWmno02K9LF4Coowp0LupZji9xjhuDDHJxpqHcQl5B
 dGNfBkM1240AZzaoU/MolxiUvJtXeJgENao9sOwwFfH1IdnUpaQ0kQ50OZ3bYT5sPyrh
 mJ/OIIGs227jp5SYMXZ4Ar2f8qFy7AYV023aSUkmf1qH1CUtRRw+hHE+/he3VeHCoN/C
 FtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425064; x=1795029864;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4+DQ/5hS2/5UfXO0mi1ZgFeMRsr05x8y1FYZlBsi/k=;
 b=ecrezrBAIlKayOZz/P+X5hKUWuQsBsZW+jHHqfVX1QxFuRGAU2fiVjMEfimb5oc5XV
 ZRzyo8ptad+xv4XzIrBN3UFppyDjpkptp57K7/DkId5n78PQOHlKeW7LYjbG44LnX/Kf
 +/Sxg+EkhRi2o4fk1+KdN5b/XUUWUN4Mm07vpePEmzXyLIHiGz670xjyELqNdAodrIH/
 miOeRWcrzshfPOuWICZXkE/IqM/Cc84Xb9Lvbvpl8gubaq9dIJjVjvf7up4MB2TvCjhc
 af57DXx4oTH3Q6VssQ5UmiSHyLSr7vJtCPwovs6RMjWoSbIOfjg34HvRzEQuig8E8Dwl
 MCng==
X-Gm-Message-State: APuU4Z+aH1izIQRiodjxSnAvRp8XmpWqVUmWi9ICfXPpObboAHVo/JVe
 x/1nU4LM93mqrUP0URZYop0UNMBPdEJhJytBUzSQyhm5KxzWA16hz199xrLAoC+SpEbfJD9y8TH
 qQWvV6iXLFJRHhmFRg0asBbfN5T779cwxQiacVFNQXn/1SjAwZiGKAMDMe2zGbp7UHbOxYzNwwg
 ZUERiX6+YnVvJCru5uO7dhSdeZ0e5c05YkLT80mHAxAMmIENHeiwskJ3tzGHE=
X-Received: from jabll4.prod.google.com ([2002:a05:6638:9804:b0:61f:e4cd:8716])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:318a:b0:4af:5d69:1cb4 with SMTP id
 5614622812f47-56b96ad0615mr3028788b6e.15.1794425063307; 
 Wed, 11 Nov 2026 11:24:23 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:10 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-7-dmatlack@google.com>
Subject: [RFC PATCH 6/7] vfio: selftests: Add vfio_pci_find_p2p_pair() helper
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

Add vfio_pci_find_p2p_pair() to locate an initiator device with memcpy
driver support and a distinct target device with a memory BAR of at
least min_bar_size bytes from an array of VFIO PCI devices.

Factor out vfio_pci_has_p2p_path() as the central place to validate PCI
topology and P2P DMA reachability between the two devices in the future.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  8 ++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 48 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index fd130f680a2d..9bda93712859 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -42,6 +42,12 @@ struct vfio_pci_device {
 	struct vfio_pci_driver driver;
 };
 
+struct vfio_pci_p2p_pair {
+	struct vfio_pci_device *initiator;
+	struct vfio_pci_device *target;
+	struct vfio_pci_mem_bar mem_bar;
+};
+
 #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
 
@@ -171,6 +177,8 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair);
 
 int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
 			     u64 offset, u64 length, u32 open_flags);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eca6eb13d7f0..16fc98ed170b 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -378,6 +378,54 @@ bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 	return false;
 }
 
+static bool vfio_pci_has_p2p_path(struct vfio_pci_device *initiator,
+				  struct vfio_pci_device *target)
+{
+	/*
+	 * TODO: Check PCI topology / ACS / host bridge support to verify that
+	 * P2P DMA transactions from @initiator can reach @target.
+	 */
+	return initiator != target;
+}
+
+bool vfio_pci_find_p2p_pair(struct vfio_pci_device **devices, int nr_devices,
+			    u64 min_bar_size, struct vfio_pci_p2p_pair *pair)
+{
+	struct vfio_pci_mem_bar mem_bar;
+	int i, j;
+
+	for (i = 0; i < nr_devices; i++) {
+		struct vfio_pci_device *initiator = devices[i];
+		const struct vfio_pci_driver_ops *ops = initiator->driver.ops;
+
+		if (!ops || !ops->memcpy_start || !ops->memcpy_wait)
+			continue;
+
+		for (j = 0; j < nr_devices; j++) {
+			struct vfio_pci_device *target = devices[j];
+
+			if (i == j)
+				continue;
+
+			if (!vfio_pci_has_p2p_path(initiator, target))
+				continue;
+
+			if (!vfio_pci_find_mem_bar(target, min_bar_size,
+						   &mem_bar))
+				continue;
+
+			*pair = (struct vfio_pci_p2p_pair){
+				.initiator = initiator,
+				.target = target,
+				.mem_bar = mem_bar,
+			};
+			return true;
+		}
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

