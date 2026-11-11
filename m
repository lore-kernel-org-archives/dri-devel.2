Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAF606A33B
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DKlLgMaI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0394410FD6F;
	Wed, 11 Nov 2026 19:24:41 +0000 (UTC)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECEF10EAA4
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 19:24:25 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4cbf700ddccso2545588b6e.0
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 11:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794425065; x=1795029865;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UcDBMAi6slSoQ/pWorFzGuzd7dcaQozRmBe5zIl9XlM=;
 b=DKlLgMaIe+cLaQVYYJLI2z3V8mCwDjRIWebUAGKA911FFAk4hqF4EMubXnxKSzK4uk
 y0vLqtoS6w5680s83Iqbp3pemz1Le2LxmZft8bMr6uB+kwCw9R4zMlY/nso8p5lQFe/M
 0fItW+Q2yc3Y93lcZeDRUAMvm3wB5J4NUNnGrK8C5W3rCSYDLs+BZT58tOY77vRKyKbW
 xU4VjE+IRORW2+e4q/iYOBTTiXkZUAS4cweAQkXcnbF+z1zJJ8x8lW+a0/9XyrXCfoWe
 guMUxKXSZS4X8ohgYxSoDFr7q+fJDVVj/i0Y4Olo0igdxiCGdbJ13DIGgmMRPATJZB8B
 Zj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794425065; x=1795029865;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UcDBMAi6slSoQ/pWorFzGuzd7dcaQozRmBe5zIl9XlM=;
 b=JE7gkUYkCmjA58rL9oST1q/7o/4+OxpbDdH0GZDfJfQMIps1HigpPcO04Nc2+Ex3oH
 HRIZpRsZKUJuXMDoYCko914o26jWIMGfIlB5rCSuGlpSUYSROaFQoG3v5G1TMPmELyWi
 H62NOn+peTvU+radVHoljCQbqFcu/Wf/wOL+ftMqhu7jOgGyZ0I7WPN6Glln8/RZ7DE3
 sVA09aNAwKVJOITgZ2hzbn7wUf1vLsygWRrHGN4RknsMtqJMhl/QH9Khx74oN3Tv1AmY
 AK7ItRK6c4L4abAQMSrAsAEwRdpFT9k90kQ4finXZ9Id5RpVF3mKWAjFaF5J5fh6mVtj
 gfig==
X-Gm-Message-State: APuU4Z/B9PfsuH4NnkVlLP604vX+X/oolKyCR+CY3ZOX4Pdxw0Cxgkfi
 nH6XWLQd2BMoW0blGd+i1ADM9pf6p68bWLQ4XkZkifV1/sS29lZu+rTuoRi2WlvX4/PZ5ecpa12
 CqELgVF6vHw8vMakCMryxlxSWmI+90TKiKm7OuT2lUZ1vIwxEU0LnAl9MNjXbSRoATvtMcYlfsh
 rxVK83ynxHDvnsD8Wg7mgkYGnGFjF95bk6x7sL0bz71oCH0MmugMGv4qd4Q2w=
X-Received: from iogp17-n1.prod.google.com
 ([2002:a05:6602:c3d1:10b0:9c7:87c5:7ce1])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2384:b0:55c:a67:d111 with SMTP id
 5614622812f47-56b962938femr2785367b6e.19.1794425064545; 
 Wed, 11 Nov 2026 11:24:24 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:11 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-8-dmatlack@google.com>
Subject: [RFC PATCH 7/7] vfio: selftests: Add P2P DMA selftest
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

Add vfio_pci_p2pdma_test to validate peer-to-peer DMA between an
initiator device driven by the VFIO selftests driver framework and a
target device exposing a memory BAR located via
vfio_pci_find_p2p_pair().

Map the target BAR into the IOMMU across all supported IOMMU modes
(using VFIO_IOMMU_MAP_DMA on the BAR mmap for type1/type1v2 and
VFIO_DEVICE_FEATURE_DMA_BUF + IOMMU_IOAS_MAP_FILE for iommufd) and test
RAM-to-BAR writes, BAR-to-RAM reads, BAR-to-BAR copies, RAM-BAR-RAM
roundtrips, and iommufd dmabuf revocation when PCI_COMMAND_MEMORY is
cleared on the target.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/vfio_pci_p2pdma_test.c     | 435 ++++++++++++++++++
 2 files changed, 436 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..b391d22b52ca 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -12,6 +12,7 @@ TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
 TEST_GEN_PROGS += vfio_pci_driver_test
+TEST_GEN_PROGS += vfio_pci_p2pdma_test
 TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
diff --git a/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c b/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c
new file mode 100644
index 000000000000..43e1537076ad
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_pci_p2pdma_test.c
@@ -0,0 +1,435 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include <linux/align.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "../kselftest_harness.h"
+
+static char **device_bdfs;
+static int nr_bdfs;
+
+static void set_msi_nonblock(struct vfio_pci_device *dev)
+{
+	if (dev->driver.ops->send_msi)
+		fcntl_set_nonblock(dev->msi_eventfds[dev->driver.msi]);
+}
+
+static void assert_no_msi(struct vfio_pci_device *dev)
+{
+	u64 value;
+	int fd;
+
+	if (!dev->driver.ops->send_msi)
+		return;
+
+	fd = dev->msi_eventfds[dev->driver.msi];
+	VFIO_ASSERT_EQ(read(fd, &value, sizeof(value)), -1);
+	VFIO_ASSERT_EQ(errno, EAGAIN);
+}
+
+static void ram_region_setup(struct iommu *iommu,
+			     struct iova_allocator *iova_allocator,
+			     struct dma_region *region, u64 size)
+{
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = iova_allocator_alloc(iova_allocator, size);
+	region->size = size;
+
+	iommu_map(iommu, region);
+}
+
+static void ram_region_teardown(struct iommu *iommu, struct dma_region *region)
+{
+	if (!region->vaddr)
+		return;
+
+	iommu_unmap(iommu, region);
+	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
+	region->vaddr = NULL;
+}
+
+static u64 pattern_word(size_t index, u8 seed)
+{
+	return (u64)seed * 0x0101010101010101ULL ^
+	       ((u64)index * 0x9e3779b97f4a7c15ULL);
+}
+
+static void fill_ram(void *buf, size_t size, u8 seed)
+{
+	__le64 *p = buf;
+	size_t i;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, sizeof(u64)));
+	for (i = 0; i < size / sizeof(u64); i++)
+		p[i] = cpu_to_le64(pattern_word(i, seed));
+}
+
+static void fill_bar(void *bar, size_t size, u8 seed)
+{
+	size_t i;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, sizeof(u64)));
+	for (i = 0; i < size / sizeof(u64); i++)
+		writeq(pattern_word(i, seed), bar + i * sizeof(u64));
+}
+
+static void assert_ram_eq_bar(const void *ram, const void *bar, size_t size)
+{
+	const __le64 *pr = ram;
+	size_t i;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, sizeof(u64)));
+	for (i = 0; i < size / sizeof(u64); i++)
+		VFIO_ASSERT_EQ(le64_to_cpu(pr[i]),
+			       readq(bar + i * sizeof(u64)),
+			       "Mismatch at byte offset %zu\n",
+			       i * sizeof(u64));
+}
+
+static void assert_bar_eq_bar(const void *bar_a, const void *bar_b,
+			      size_t size)
+{
+	size_t i;
+
+	VFIO_ASSERT_TRUE(IS_ALIGNED(size, sizeof(u64)));
+	for (i = 0; i < size / sizeof(u64); i++)
+		VFIO_ASSERT_EQ(readq(bar_a + i * sizeof(u64)),
+			       readq(bar_b + i * sizeof(u64)),
+			       "Mismatch at byte offset %zu\n",
+			       i * sizeof(u64));
+}
+
+static void assert_no_pattern_leak(const void *bar_pattern, const void *dst,
+				   size_t size)
+{
+	const u8 *pb = bar_pattern;
+	const u8 *pd = dst;
+	size_t offset, chunk;
+
+	for (offset = 0; offset < size; offset += chunk) {
+		chunk = min_t(size_t, 64, size - offset);
+		VFIO_ASSERT_NE(memcmp(pb + offset, pd + offset, chunk), 0,
+			       "Leaked BAR data at byte offset %zu\n", offset);
+	}
+}
+
+FIXTURE(vfio_pci_p2pdma_test) {
+	struct iommu *iommu;
+	struct iova_allocator *iova_allocator;
+	struct vfio_pci_device **devices;
+	int nr_open;
+
+	struct vfio_pci_device *initiator;
+	struct vfio_pci_device *target;
+	struct vfio_pci_mem_bar mem_bar;
+
+	struct dma_region ram_region;
+	struct dma_region bar_region;
+	bool bar_mapped;
+	int dmabuf_fd;
+
+	u64 size;
+	void *ram_src;
+	void *ram_dst;
+	iova_t ram_src_iova;
+	iova_t ram_dst_iova;
+	iova_t bar_iova;
+};
+
+FIXTURE_VARIANT(vfio_pci_p2pdma_test) {
+	const char *iommu_mode;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode)		\
+FIXTURE_VARIANT_ADD(vfio_pci_p2pdma_test, _iommu_mode) {	\
+	.iommu_mode = #_iommu_mode,				\
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_pci_p2pdma_test)
+{
+	const u64 page_size = getpagesize();
+	const u64 min_bar_size = max_t(u64, 2 * page_size, SZ_128K);
+	struct vfio_pci_p2p_pair pair;
+	struct vfio_pci_driver *driver;
+	u64 bar_map_size;
+	int i, rc;
+
+	self->dmabuf_fd = -1;
+
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->devices = calloc_assert(nr_bdfs, sizeof(*self->devices));
+
+	for (i = 0; i < nr_bdfs; i++) {
+		self->devices[i] = vfio_pci_device_init(device_bdfs[i],
+							self->iommu);
+		self->nr_open++;
+	}
+
+	if (!vfio_pci_find_p2p_pair(self->devices, self->nr_open, min_bar_size,
+				    &pair))
+		SKIP(return,
+		     "No (initiator with driver, target with >= %lluB memory BAR) pair found",
+		     (unsigned long long)min_bar_size);
+
+	self->initiator = pair.initiator;
+	self->target = pair.target;
+	self->mem_bar = pair.mem_bar;
+
+	printf("P2P pair: initiator %s (%s) -> target %s BAR%u (size 0x%lx)\n",
+	       self->initiator->bdf, self->initiator->driver.ops->name,
+	       self->target->bdf, self->mem_bar.bar->info.index,
+	       (unsigned long)self->mem_bar.size);
+
+	vfio_pci_cmd_set(self->target, PCI_COMMAND_MEMORY);
+
+	self->iova_allocator = iova_allocator_init(self->iommu);
+
+	driver = &self->initiator->driver;
+	ram_region_setup(self->iommu, self->iova_allocator, &driver->region,
+			 driver->region.size);
+	ram_region_setup(self->iommu, self->iova_allocator, &self->ram_region,
+			 SZ_16M);
+
+	bar_map_size = min_t(u64, round_down(self->mem_bar.size, page_size),
+			     SZ_16M);
+	self->bar_region.vaddr = self->mem_bar.vaddr;
+	self->bar_region.size = bar_map_size;
+	self->bar_region.iova = iova_allocator_alloc(self->iova_allocator,
+						     bar_map_size);
+
+	if (self->iommu->iommufd) {
+		u32 bar_idx = self->mem_bar.bar->info.index;
+
+		self->dmabuf_fd = __vfio_pci_dmabuf_create(self->target,
+							   bar_idx,
+							   self->mem_bar.offset,
+							   bar_map_size,
+							   O_RDWR | O_CLOEXEC);
+		if (self->dmabuf_fd == -EOPNOTSUPP)
+			SKIP(return, "Kernel does not support VFIO_DEVICE_FEATURE_DMA_BUF");
+		ASSERT_GE(self->dmabuf_fd, 0);
+
+		iommu_map_file(self->iommu, self->dmabuf_fd, 0,
+			       &self->bar_region);
+	} else {
+		rc = __iommu_map(self->iommu, &self->bar_region);
+		if (rc && !strncmp(variant->iommu_mode, "iommufd_compat_", 15))
+			SKIP(return,
+			     "IOMMU mode %s does not support mapping MMIO BARs (rc=%d)",
+			     variant->iommu_mode, rc);
+		ASSERT_EQ(0, rc);
+	}
+	self->bar_mapped = true;
+
+	vfio_pci_driver_init(self->initiator);
+
+	self->size = min_t(u64, driver->max_memcpy_size * 4,
+			   min_t(u64, self->ram_region.size / 2,
+				 bar_map_size / 2));
+
+	self->ram_src = self->ram_region.vaddr;
+	self->ram_dst = self->ram_src + self->size;
+
+	self->ram_src_iova = to_iova(self->initiator, self->ram_src);
+	self->ram_dst_iova = to_iova(self->initiator, self->ram_dst);
+	self->bar_iova = to_iova(self->initiator, self->mem_bar.vaddr);
+}
+
+FIXTURE_TEARDOWN(vfio_pci_p2pdma_test)
+{
+	int i;
+
+	if (self->initiator && self->initiator->driver.initialized)
+		vfio_pci_driver_remove(self->initiator);
+
+	if (self->bar_mapped)
+		iommu_unmap(self->iommu, &self->bar_region);
+
+	if (self->dmabuf_fd >= 0)
+		VFIO_ASSERT_EQ(close(self->dmabuf_fd), 0);
+
+	if (self->initiator)
+		ram_region_teardown(self->iommu,
+				    &self->initiator->driver.region);
+	ram_region_teardown(self->iommu, &self->ram_region);
+
+	if (self->iova_allocator)
+		iova_allocator_cleanup(self->iova_allocator);
+
+	for (i = 0; i < self->nr_open; i++)
+		vfio_pci_device_cleanup(self->devices[i]);
+	free(self->devices);
+
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_pci_p2pdma_test, ram_to_bar)
+{
+	set_msi_nonblock(self->initiator);
+
+	fill_ram(self->ram_src, self->size, 0x11);
+	fill_bar(self->mem_bar.vaddr, self->size, 0xee);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->ram_src_iova,
+					    self->bar_iova,
+					    self->size));
+
+	assert_ram_eq_bar(self->ram_src, self->mem_bar.vaddr, self->size);
+	assert_no_msi(self->initiator);
+}
+
+TEST_F(vfio_pci_p2pdma_test, bar_to_ram)
+{
+	set_msi_nonblock(self->initiator);
+
+	fill_bar(self->mem_bar.vaddr, self->size, 0x22);
+	memset(self->ram_dst, 0, self->size);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->bar_iova,
+					    self->ram_dst_iova,
+					    self->size));
+
+	assert_ram_eq_bar(self->ram_dst, self->mem_bar.vaddr, self->size);
+	assert_no_msi(self->initiator);
+}
+
+TEST_F(vfio_pci_p2pdma_test, bar_to_bar)
+{
+	void *bar_src = self->mem_bar.vaddr;
+	void *bar_dst = self->mem_bar.vaddr + self->size;
+
+	set_msi_nonblock(self->initiator);
+
+	fill_bar(bar_src, self->size, 0x33);
+	fill_bar(bar_dst, self->size, 0xcc);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->bar_iova,
+					    self->bar_iova + self->size,
+					    self->size));
+
+	assert_bar_eq_bar(bar_src, bar_dst, self->size);
+	assert_no_msi(self->initiator);
+}
+
+TEST_F(vfio_pci_p2pdma_test, roundtrip)
+{
+	set_msi_nonblock(self->initiator);
+
+	fill_ram(self->ram_src, self->size, 0x44);
+	fill_bar(self->mem_bar.vaddr, self->size, 0x00);
+	memset(self->ram_dst, 0xff, self->size);
+
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->ram_src_iova,
+					    self->bar_iova,
+					    self->size));
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->bar_iova,
+					    self->ram_dst_iova,
+					    self->size));
+
+	ASSERT_EQ(0, memcmp(self->ram_src, self->ram_dst, self->size));
+	assert_no_msi(self->initiator);
+}
+
+TEST_F(vfio_pci_p2pdma_test, dmabuf_revoke)
+{
+	if (self->dmabuf_fd < 0)
+		SKIP(return, "Test requires dmabuf-backed IOMMU mapping");
+
+	set_msi_nonblock(self->initiator);
+
+	fill_bar(self->mem_bar.vaddr, self->size, 0x55);
+	fill_ram(self->ram_src, self->size, 0xaa);
+
+	/*
+	 * Clearing PCI_COMMAND_MEMORY on the target revokes the dmabuf and
+	 * tears down its IOMMU mapping in place. P2P DMA must not reach the
+	 * BAR, and remapping the revoked dmabuf must fail with -ENODEV until
+	 * PCI_COMMAND_MEMORY is re-enabled.
+	 */
+	vfio_pci_cmd_clear(self->target, PCI_COMMAND_MEMORY);
+
+	/*
+	 * Ignore the return values: DMA writes are posted, and not all
+	 * devices report accesses to unmapped IOVAs as errors on DMA reads
+	 * (e.g. QEMU's emulated igb completes reads from unmapped IOVAs with
+	 * zeros). Verify isolation via the destination buffers instead.
+	 */
+	fill_ram(self->ram_dst, self->size, 0x33);
+	vfio_pci_driver_memcpy(self->initiator, self->ram_src_iova,
+			       self->bar_iova, self->size);
+	vfio_pci_driver_memcpy(self->initiator, self->bar_iova,
+			       self->ram_dst_iova, self->size);
+	assert_no_msi(self->initiator);
+
+	iommu_unmap(self->iommu, &self->bar_region);
+	self->bar_mapped = false;
+
+	ASSERT_EQ(-ENODEV, __iommu_map_file(self->iommu, self->dmabuf_fd, 0,
+					    &self->bar_region));
+
+	vfio_pci_cmd_set(self->target, PCI_COMMAND_MEMORY);
+
+	/*
+	 * Revoked P2P writes must not have modified the BAR, and revoked P2P
+	 * reads must not have leaked BAR contents into RAM.
+	 */
+	fill_ram(self->ram_src, self->size, 0x55);
+	assert_ram_eq_bar(self->ram_src, self->mem_bar.vaddr, self->size);
+	assert_no_pattern_leak(self->ram_src, self->ram_dst, self->size);
+
+	/* Once memory decode is re-enabled, the dmabuf can be mapped again. */
+	iommu_map_file(self->iommu, self->dmabuf_fd, 0, &self->bar_region);
+	self->bar_mapped = true;
+
+	memset(self->ram_dst, 0, self->size);
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->bar_iova,
+					    self->ram_dst_iova,
+					    self->size));
+	ASSERT_EQ(0, memcmp(self->ram_src, self->ram_dst, self->size));
+
+	fill_ram(self->ram_src, self->size, 0x77);
+	ASSERT_EQ(0, vfio_pci_driver_memcpy(self->initiator,
+					    self->ram_src_iova,
+					    self->bar_iova,
+					    self->size));
+	assert_ram_eq_bar(self->ram_src, self->mem_bar.vaddr, self->size);
+	assert_no_msi(self->initiator);
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdfs = vfio_selftests_get_bdfs(&argc, argv, &nr_bdfs);
+	if (nr_bdfs < 2) {
+		fprintf(stderr,
+			"P2P DMA test requires at least 2 devices (got %d), skipping.\n",
+			nr_bdfs);
+		return KSFT_SKIP;
+	}
+
+	return test_harness_run(argc, argv);
+}
-- 
2.56.0.567.gdb80ae8cd5-goog

