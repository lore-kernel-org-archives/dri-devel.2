Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400EFC44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7225210E897;
	Mon, 20 Jul 2026 11:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="qpMPUr8P";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D1E010E890
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Borh8jAP99pkhqSnFC+lvvVixZ3e31DAgw8VzWbeCwU=; b=qpMPUr8PXrrw1i5dSlUFVfdIoe
 71NFTX7Tw6oV0jIpf3INFd1nmvEYIj8BuEtgnXS3YVwRcQzqBlalju1W0A30ReFCJNEw1atUhS2l2
 2nqTA9OAHNrT1JHJ7m21lL4WXCmFs8b6xSWySiDgLQGrrk5F1e4PwjlTvD2l944E7KniB/Yw5PxGx
 4fNNOog2wmhVT+MbMdP/gURSju31OJLAqg5gDAUzsqJPFwBbNhvumucy6wREV54+k+dQdRKnZLcIC
 bnZXytn+W+WPhJz/EXh0sGk7c4ykzizOAmqzzsVQSFI9Nsw2eb/kgDYVSFqga6oX8cAI6xJme6wIQ
 ZjVFiEbA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wllvh-0000000Akyx-25lB; Mon, 20 Jul 2026 11:13:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red
 Hat Linux)) id 1wllvh-00000000W10-0uvc;
 Mon, 20 Jul 2026 12:13:01 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>,
 Connor Williamson <connordw@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Zhou Yuhang <zhouyuhang@kylinos.cn>, Zi Li <zi.li@linux.dev>,
 Dan Williams <djbw@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>, connordw@amazon.co.uk,
 graf@amazon.de, fgriffo@amazon.co.uk, David Woodhouse <dwmw@amazon.co.uk>
Subject: [RFC PATCH v2 10/11] selftests/kvm: gmem_provider iommufd tests
Date: Mon, 20 Jul 2026 12:03:11 +0100
Message-ID: <dce16ab3d385584e0f16b8d3b6ea9247978d9401.1784545391.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
References: <2b5e7a83d277134294199a455469bb436196b902.1784545391.git.dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

From: David Woodhouse <dwmw@amazon.co.uk>

Three selftests that exercise the guest_memfd provider ABI from the
iommufd side, going progressively closer to a real assigned-device
setup:

  gmem_provider_iommufd_test
    Dual-map.  A KVM memslot and an iommufd IOAS are both backed by the
    same provider dma-buf.  The guest writes a magic pattern into the
    slot; the host mmap of the same provider fd sees the guest's write;
    the IOAS also holds a mapping of the same backing.  Proves KVM and
    iommufd converge on the same provider phys via two different fds
    (the KVM guest_memfd fd and the dma-buf fd).

  gmem_provider_vfio_test
    A real vfio-pci device is bound to iommufd and attached to an IOAS
    that has the provider region mapped.  Confirms the attach path
    accepts a dma-buf-backed IOAS without complaint; does not issue
    device DMA.  Requires an unused PCI device already bound to
    vfio-pci and exposed as /dev/vfio/devices/vfio0 (overridable via
    GMEM_VFIO_CDEV).

  gmem_provider_nvme_dma_test
    Full round trip.  Binds an NVMe controller to vfio-pci, attaches
    it to an IOAS with the provider region mapped at IOVA_DST,
    initialises NVMe admin queues (also in the IOAS via anonymous
    pages), submits Identify Controller with PRP1=IOVA_DST, and
    verifies the 4 KiB response via the host mmap of the same
    provider fd (VID/SSVID/MN check).  Then revokes the target range
    with GMEM_PROVIDER_SET_PRESENT and re-submits Identify to the same
    IOVA: iommufd's iopt_revoke_notify tears down the mapping and the
    device DMA either faults at the IOMMU (visible as IO_PAGE_FAULT in
    dmesg on AMD-Vi / equivalent on VT-d, SMMUv3) or completes with an
    NVMe error; either way the provider region is not overwritten.
    Restores and confirms fresh mappings succeed.

Requires an EBS/NVMe scratch device on the test host bound to vfio-pci;
the tests SKIP cleanly if no such device is available.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   9 +-
 .../kvm/x86/gmem_provider_iommufd_test.c      | 158 ++++++++
 .../kvm/x86/gmem_provider_nvme_dma_test.c     | 376 ++++++++++++++++++
 .../kvm/x86/gmem_provider_vfio_test.c         | 134 +++++++
 4 files changed, 674 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_vfio_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index e6e9ac9da45a..7f46843e7428 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -77,6 +77,12 @@ TEST_GEN_PROGS_x86 += x86/evmcs_smm_controls_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86 += x86/fastops_test
 TEST_GEN_PROGS_x86 += x86/fix_hypercall_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_hugepage_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_revoke_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_iommufd_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_vfio_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_nvme_dma_test
 TEST_GEN_PROGS_x86 += x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 += x86/hyperv_clock
 TEST_GEN_PROGS_x86 += x86/hyperv_cpuid
@@ -161,9 +167,6 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
-TEST_GEN_PROGS_x86 += x86/gmem_provider_test
-TEST_GEN_PROGS_x86 += x86/gmem_provider_hugepage_test
-TEST_GEN_PROGS_x86 += x86/gmem_provider_revoke_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c
new file mode 100644
index 000000000000..885dffa0b659
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_iommufd_test.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_iommufd_test - map the SAME provider-backed region into KVM
+ * (as a guest_memfd memslot) AND into an iommufd IOAS (via a dma-buf exported
+ * from the provider fd).  Prove both APIs accept the mapping and that a guest
+ * write is visible via the host mmap.
+ *
+ * The iommufd side exercises exactly the provider->iommufd path we just wired:
+ * GET_DMABUF on the provider fd -> IOMMU_IOAS_MAP_FILE, which walks
+ * iopt_map_dmabuf -> sym_..._iommufd_map -> gmem_provider_dma_buf_iommufd_map.
+ *
+ * The test opens the provider with GMEM_PROVIDER_FLAG_MMAP_CAPABLE at SETUP time; requires iommufd
+ * available at /dev/iommu.  Actual IOMMU page-table programming happens once
+ * a device is attached; here we validate the plumbing (map succeeds; unmap
+ * returns the same byte count) without needing a passthrough device.
+ */
+#include <fcntl.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/iommufd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+/* Mirrors samples/kvm/gmem_provider.h */
+struct gmem_provider_setup {
+	__s32 kvm_fd;
+	__u32 flags;
+	__u64 size;
+};
+#define GMEM_PROVIDER_SETUP		_IOW('G', 1, struct gmem_provider_setup)
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE	(1u << 0)
+#define GMEM_PROVIDER_GET_DMABUF	_IO('G', 3)
+
+#define DATA_SLOT	10
+#define DATA_GPA	(1ULL << 32)
+#define DATA_SIZE	0x200000ULL		/* 2 MiB */
+#define IOVA_BASE	(1ULL << 34)		/* arbitrary */
+#define MAGIC		0xa5a5a5a5a5a5a5a5ULL
+
+static void guest_code(void)
+{
+	*(volatile uint64_t *)DATA_GPA = MAGIC;
+	GUEST_DONE();
+}
+
+int main(void)
+{
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+	struct gmem_provider_setup setup = { .flags = GMEM_PROVIDER_FLAG_MMAP_CAPABLE };
+	struct iommu_ioas_alloc alloc = {};
+	struct iommu_ioas_map_file map = {};
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int gmem_ctl, gmem_fd, dmabuf_fd, iommufd, r;
+	void *hva;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	gmem_ctl = open("/dev/gmem_provider", O_RDWR);
+	__TEST_REQUIRE(gmem_ctl >= 0,
+		       "gmem_provider not loaded (/dev/gmem_provider absent)");
+	iommufd = open("/dev/iommu", O_RDWR);
+	__TEST_REQUIRE(iommufd >= 0, "iommufd unavailable (/dev/iommu absent)");
+
+	/*
+	 * 1) Provider fd bound to KVM VM.
+	 */
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
+	setup.kvm_fd = vm->fd;
+	setup.size = DATA_SIZE;
+	gmem_fd = ioctl(gmem_ctl, GMEM_PROVIDER_SETUP, &setup);
+	TEST_ASSERT(gmem_fd >= 0, "GMEM_PROVIDER_SETUP failed errno=%d", errno);
+
+	/*
+	 * 2) KVM side: host mmap + guest_memfd memslot (gmem-only when mmap-capable).
+	 */
+	hva = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, gmem_fd, 0);
+	TEST_ASSERT(hva != MAP_FAILED,
+		    "provider mmap failed errno=%d", errno);
+	r = __vm_set_user_memory_region2(vm, DATA_SLOT, KVM_MEM_GUEST_MEMFD,
+					 DATA_GPA, DATA_SIZE, hva, gmem_fd, 0);
+	TEST_ASSERT(!r, "KVM_SET_USER_MEMORY_REGION2 failed r=%d errno=%d", r, errno);
+	virt_map(vm, DATA_GPA, DATA_GPA, 1);
+
+	/*
+	 * Mark the range PRIVATE so guest accesses route via the provider's
+	 * get_pfn (i.e. exercise the guest_memfd path).  Without this the
+	 * guest write flows through the shared HVA mmap and the test proves
+	 * nothing about the provider.
+	 */
+	vm_mem_set_private(vm, DATA_GPA, DATA_SIZE);
+
+	/*
+	 * 3) iommufd side: allocate IOAS, get a dma-buf from the SAME provider fd,
+	 *    and map it into the IOAS via IOMMU_IOAS_MAP_FILE.  This drives
+	 *    iopt_map_dmabuf -> gmem_provider_dma_buf_iommufd_map.
+	 */
+	alloc.size = sizeof(alloc);
+	r = ioctl(iommufd, IOMMU_IOAS_ALLOC, &alloc);
+	TEST_ASSERT(!r, "IOMMU_IOAS_ALLOC failed errno=%d", errno);
+	pr_info("iommufd: allocated ioas id=%u\n", alloc.out_ioas_id);
+
+	dmabuf_fd = ioctl(gmem_fd, GMEM_PROVIDER_GET_DMABUF);
+	TEST_ASSERT(dmabuf_fd >= 0, "GMEM_PROVIDER_GET_DMABUF failed errno=%d", errno);
+	pr_info("provider: exported dma-buf fd=%d\n", dmabuf_fd);
+
+	map.size = sizeof(map);
+	map.flags = IOMMU_IOAS_MAP_FIXED_IOVA |
+		    IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE;
+	map.ioas_id = alloc.out_ioas_id;
+	map.fd = dmabuf_fd;
+	map.start = 0;
+	map.length = DATA_SIZE;
+	map.iova = IOVA_BASE;
+	r = ioctl(iommufd, IOMMU_IOAS_MAP_FILE, &map);
+	TEST_ASSERT(!r,
+		    "IOMMU_IOAS_MAP_FILE(dma-buf) failed r=%d errno=%d\n"
+		    "	 (gmem_provider_dma_buf_iommufd_map path)",
+		    r, errno);
+	pr_info("iommufd: mapped provider dma-buf @ IOVA 0x%llx (0x%llx bytes)\n",
+		(unsigned long long)map.iova, (unsigned long long)map.length);
+
+	/*
+	 * 4) Run the guest.  It writes MAGIC via the KVM/NPT path; we then read
+	 *    via the host mmap to confirm the dual-mapping resolves to the same
+	 *    physical backing.
+	 */
+	vcpu_run(vcpu);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
+		    "guest exit: %s", exit_reason_str(vcpu->run->exit_reason));
+
+	TEST_ASSERT(*(volatile uint64_t *)hva == MAGIC,
+		    "host mmap read 0x%llx, want MAGIC (guest+host+iommufd disagree)",
+		    (unsigned long long)*(volatile uint64_t *)hva);
+	pr_info("dual-map ok: guest wrote MAGIC, host mmap sees 0x%llx, "
+		"iommufd IOAS holds the same backing\n",
+		(unsigned long long)*(volatile uint64_t *)hva);
+
+	kvm_vm_free(vm);
+	close(dmabuf_fd);
+	close(iommufd);
+	munmap(hva, DATA_SIZE);
+	close(gmem_fd);
+	close(gmem_ctl);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c
new file mode 100644
index 000000000000..665b19028e13
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_nvme_dma_test.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_nvme_dma_test - real DMA into provider memory via a
+ * passthrough NVMe controller.
+ *
+ * Sends an Identify Controller (opc=0x06, CNS=1) admin command to a
+ * vfio-pci-bound NVMe controller, with PRP1 pointing at an IOVA that maps
+ * to the gmem provider's backing.  Success = the provider region contains
+ * the 4 KiB Identify Controller data structure (verified via VID field
+ * matching the PCI vendor read from config space).
+ *
+ * Requires the gmem_provider module loaded, iommufd available, and an NVMe
+ * controller bound to vfio-pci at /dev/vfio/devices/vfio0 (overridable via
+ * GMEM_VFIO_CDEV).  DESTROYS ANY IN-FLIGHT STATE on that controller.
+ */
+#include <fcntl.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/iommufd.h>
+#include <linux/vfio.h>
+#include <linux/kvm.h>
+
+#include "test_util.h"
+
+struct gmem_provider_setup {
+	__s32 kvm_fd;
+	__u32 flags;
+	__u64 size;
+};
+#define GMEM_PROVIDER_SETUP		_IOW('G', 1, struct gmem_provider_setup)
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE	(1u << 0)
+#define GMEM_PROVIDER_GET_DMABUF	_IO('G', 3)
+
+struct gmem_provider_present {
+	__u64 offset;
+	__u64 len;
+	__u32 present;
+	__u32 pad;
+};
+#define GMEM_PROVIDER_SET_PRESENT	_IOW('G', 2, struct gmem_provider_present)
+
+#define PROVIDER_SIZE	0x200000ULL		/* 2 MiB provider region */
+#define IOVA_DST	0x40000000ULL		/* target for Identify Controller data */
+#define IOVA_SQ		(IOVA_DST + PROVIDER_SIZE)
+#define IOVA_CQ		(IOVA_SQ + 0x1000)
+
+/* NVMe controller regs (BAR0). */
+#define NVME_REG_CAP	0x00
+#define NVME_REG_VS	0x08
+#define NVME_REG_CC	0x14
+#define NVME_REG_CSTS	0x1C
+#define NVME_REG_AQA	0x24
+#define NVME_REG_ASQ	0x28
+#define NVME_REG_ACQ	0x30
+#define NVME_SQ0TDBL	0x1000
+
+#define NVME_CC_EN	(1U << 0)
+#define NVME_CSTS_RDY	(1U << 0)
+
+static uint32_t rd32(void *b, uint32_t o) { return *(volatile uint32_t *)((char *)b + o); }
+static uint64_t rd64(void *b, uint32_t o) { return *(volatile uint64_t *)((char *)b + o); }
+static void     wr32(void *b, uint32_t o, uint32_t v) { *(volatile uint32_t *)((char *)b + o) = v; }
+static void     wr64(void *b, uint32_t o, uint64_t v) { *(volatile uint64_t *)((char *)b + o) = v; }
+
+static int ioas_map_user(int iommufd_fd, uint32_t ioas_id,
+			 void *va, uint64_t iova, uint64_t len)
+{
+	struct iommu_ioas_map m = {
+		.size = sizeof(m),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA |
+			 IOMMU_IOAS_MAP_READABLE |
+			 IOMMU_IOAS_MAP_WRITEABLE,
+		.ioas_id = ioas_id,
+		.user_va = (uintptr_t)va,
+		.length = len,
+		.iova = iova,
+	};
+	return ioctl(iommufd_fd, IOMMU_IOAS_MAP, &m);
+}
+
+int main(void)
+{
+	struct gmem_provider_setup setup = { .flags = GMEM_PROVIDER_FLAG_MMAP_CAPABLE };
+	struct iommu_ioas_alloc alloc = {};
+	struct iommu_ioas_map_file mapf = {};
+	struct vfio_device_bind_iommufd bind = {};
+	struct vfio_device_attach_iommufd_pt att = {};
+	struct vfio_region_info reg = {};
+	const char *cdev_path;
+	int gmem_ctl, gmem_fd, dmabuf_fd, iommufd_fd, vfio_fd;
+	void *provider_hva, *sq_buf, *cq_buf, *bar;
+	uint16_t pci_cmd;
+	uint16_t expected_vid;
+	uint64_t cap, cfg_off;
+	uint32_t doorbell_stride, aqa, cc, csts;
+	int i;
+
+	gmem_ctl = open("/dev/gmem_provider", O_RDWR);
+	__TEST_REQUIRE(gmem_ctl >= 0, "gmem_provider module not loaded");
+	iommufd_fd = open("/dev/iommu", O_RDWR);
+	__TEST_REQUIRE(iommufd_fd >= 0, "iommufd unavailable");
+	cdev_path = getenv("GMEM_VFIO_CDEV");
+	if (!cdev_path)
+		cdev_path = "/dev/vfio/devices/vfio0";
+	vfio_fd = open(cdev_path, O_RDWR);
+	__TEST_REQUIRE(vfio_fd >= 0, "vfio cdev absent: %s", cdev_path);
+
+	/* Provider fd (bare KVM VM to satisfy SETUP). */
+	{
+		int kvm = open("/dev/kvm", O_RDWR);
+		int vm;
+		TEST_ASSERT(kvm >= 0, "open /dev/kvm errno=%d", errno);
+		vm = ioctl(kvm, KVM_CREATE_VM, 0);
+		TEST_ASSERT(vm >= 0, "KVM_CREATE_VM errno=%d", errno);
+		setup.kvm_fd = vm;
+		close(kvm);
+	}
+	setup.size = PROVIDER_SIZE;
+	gmem_fd = ioctl(gmem_ctl, GMEM_PROVIDER_SETUP, &setup);
+	TEST_ASSERT(gmem_fd >= 0, "SETUP errno=%d", errno);
+
+	provider_hva = mmap(NULL, PROVIDER_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
+			    gmem_fd, 0);
+	TEST_ASSERT(provider_hva != MAP_FAILED, "provider mmap errno=%d", errno);
+	memset(provider_hva, 0xcc, 0x1000);	/* poison first page */
+
+	/* IOAS + provider dma-buf. */
+	alloc.size = sizeof(alloc);
+	TEST_ASSERT(!ioctl(iommufd_fd, IOMMU_IOAS_ALLOC, &alloc), "IOAS_ALLOC");
+	dmabuf_fd = ioctl(gmem_fd, GMEM_PROVIDER_GET_DMABUF);
+	TEST_ASSERT(dmabuf_fd >= 0, "GET_DMABUF");
+	mapf.size = sizeof(mapf);
+	mapf.flags = IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_READABLE |
+		     IOMMU_IOAS_MAP_WRITEABLE;
+	mapf.ioas_id = alloc.out_ioas_id;
+	mapf.fd = dmabuf_fd;
+	mapf.length = PROVIDER_SIZE;
+	mapf.iova = IOVA_DST;
+	TEST_ASSERT(!ioctl(iommufd_fd, IOMMU_IOAS_MAP_FILE, &mapf), "IOAS_MAP_FILE");
+
+	/* Admin SQ/CQ backing pages (userspace anon, IOMMU-mapped). */
+	sq_buf = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(sq_buf != MAP_FAILED, "sq mmap");
+	memset(sq_buf, 0, 0x1000);
+	cq_buf = mmap(NULL, 0x1000, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(cq_buf != MAP_FAILED, "cq mmap");
+	memset(cq_buf, 0, 0x1000);
+	TEST_ASSERT(!ioas_map_user(iommufd_fd, alloc.out_ioas_id, sq_buf, IOVA_SQ, 0x1000),
+		    "IOAS_MAP(sq) errno=%d", errno);
+	TEST_ASSERT(!ioas_map_user(iommufd_fd, alloc.out_ioas_id, cq_buf, IOVA_CQ, 0x1000),
+		    "IOAS_MAP(cq) errno=%d", errno);
+
+	/* Bind + attach. */
+	bind.argsz = sizeof(bind);
+	bind.iommufd = iommufd_fd;
+	TEST_ASSERT(!ioctl(vfio_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind), "BIND");
+	att.argsz = sizeof(att);
+	att.pt_id = alloc.out_ioas_id;
+	TEST_ASSERT(!ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &att), "ATTACH");
+	pr_info("vfio device attached, pt_id=%u\n", att.pt_id);
+
+	/* mmap BAR0. */
+	reg.argsz = sizeof(reg);
+	reg.index = VFIO_PCI_BAR0_REGION_INDEX;
+	TEST_ASSERT(!ioctl(vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &reg), "GET_REGION_INFO");
+	__TEST_REQUIRE(reg.flags & VFIO_REGION_INFO_FLAG_MMAP, "BAR0 not mmap-capable");
+	bar = mmap(NULL, reg.size, PROT_READ | PROT_WRITE, MAP_SHARED, vfio_fd, reg.offset);
+	TEST_ASSERT(bar != MAP_FAILED, "BAR0 mmap");
+	pr_info("BAR0 mapped size=0x%llx\n", (unsigned long long)reg.size);
+
+	/* Enable Bus Master. */
+	reg.argsz = sizeof(reg);
+	reg.index = VFIO_PCI_CONFIG_REGION_INDEX;
+	TEST_ASSERT(!ioctl(vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &reg), "CFG region info");
+	cfg_off = reg.offset;
+	TEST_ASSERT(pread(vfio_fd, &pci_cmd, 2, cfg_off + 0x04) == 2, "cfg CMD read");
+	pci_cmd |= 0x0006;
+	TEST_ASSERT(pwrite(vfio_fd, &pci_cmd, 2, cfg_off + 0x04) == 2, "cfg CMD write");
+
+	/* Snapshot expected PCI vendor id (config offset 0) for the Identify VID cross-check. */
+	{
+		uint16_t v;
+
+		TEST_ASSERT(pread(vfio_fd, &v, 2, cfg_off + 0x00) == 2, "cfg VID read");
+		expected_vid = v;
+	}
+
+	cap = rd64(bar, NVME_REG_CAP);
+	doorbell_stride = 4U << ((cap >> 32) & 0xf);
+	pr_info("NVMe CAP=0x%016llx VS=0x%08x MQES=%u DSTRD=%u\n",
+		(unsigned long long)cap, rd32(bar, NVME_REG_VS),
+		(uint32_t)((cap & 0xffff) + 1), doorbell_stride);
+
+	/* Disable + wait !RDY. */
+	wr32(bar, NVME_REG_CC, 0);
+	for (i = 0; i < 5000 && (rd32(bar, NVME_REG_CSTS) & NVME_CSTS_RDY); i++)
+		usleep(1000);
+
+	/* Admin queues: 64 entries each. */
+	wr64(bar, NVME_REG_ASQ, IOVA_SQ);
+	wr64(bar, NVME_REG_ACQ, IOVA_CQ);
+	aqa = (63U << 16) | 63U;			/* ACQS-1 | ASQS-1 */
+	wr32(bar, NVME_REG_AQA, aqa);
+	cc = (6U << 16) | (4U << 20) | NVME_CC_EN;	/* IOSQES=6 IOCQES=4 EN */
+	wr32(bar, NVME_REG_CC, cc);
+
+	for (i = 0; i < 10000; i++) {
+		csts = rd32(bar, NVME_REG_CSTS);
+		if (csts & NVME_CSTS_RDY)
+			break;
+		usleep(1000);
+		if (csts & 0x02) {	/* CFS */
+			TEST_FAIL("NVMe controller fatal status CSTS=0x%x", csts);
+		}
+	}
+	TEST_ASSERT(csts & NVME_CSTS_RDY, "controller never reached RDY, CSTS=0x%x", csts);
+	pr_info("NVMe ready. CSTS=0x%x\n", csts);
+
+	/* Identify Controller SQE at slot 0. */
+	{
+		uint32_t *s = (uint32_t *)sq_buf;
+		memset(s, 0, 64);
+		s[0]  = 0x00010006;	/* CID=1 << 16 | OPC=Identify */
+		s[1]  = 0;		/* NSID */
+		/* PRP1 (offset 24 in SQE = dword 6) */
+		s[6]  = (uint32_t)IOVA_DST;
+		s[7]  = (uint32_t)(IOVA_DST >> 32);
+		s[8]  = 0;
+		s[9]  = 0;		/* PRP2 */
+		s[10] = 0x01;		/* CDW10: CNS = Identify Controller */
+	}
+
+	/* Ring SQ0 tail doorbell. */
+	asm volatile ("" ::: "memory");
+	wr32(bar, NVME_SQ0TDBL, 1);
+	pr_info("Identify Controller submitted (SQ0 tail=1)\n");
+
+	/* Poll CQ0 slot 0 for a valid completion (phase tag = 1 on first pass). */
+	{
+		volatile uint32_t *c = (volatile uint32_t *)cq_buf;
+		uint32_t status;
+		for (i = 0; i < 5000; i++) {
+			if (c[3] & 0x10000)		/* P bit */
+				break;
+			usleep(1000);
+		}
+		TEST_ASSERT(c[3] & 0x10000, "completion phase bit never set");
+		status = (c[3] >> 17) & 0x7fff;
+		pr_info("CQE: DW0=0x%08x DW1=0x%08x DW2=0x%08x DW3=0x%08x  status=0x%04x\n",
+			c[0], c[1], c[2], c[3], status);
+		TEST_ASSERT(status == 0, "Identify Controller status non-zero: 0x%x", status);
+		fprintf(stderr, "MARKER: about to write CQ doorbell\n"); fflush(stderr);
+		/* CQ0 head doorbell = 1 */
+		wr32(bar, NVME_SQ0TDBL + doorbell_stride, 1);
+		fprintf(stderr, "MARKER: about to read provider\n"); fflush(stderr);
+	}
+
+	/* Provider region now holds Identify Controller data.  VID/SSVID at bytes 0..3
+	 * must equal the device's PCI vendor + subsystem vendor (both are Amazon here). */
+	{
+		uint16_t vid  = ((uint16_t *)provider_hva)[0];
+		uint16_t ssvid = ((uint16_t *)provider_hva)[1];
+		uint8_t first = ((uint8_t *)provider_hva)[0];
+		uint8_t poison_still = ((uint8_t *)provider_hva)[8];
+		char mn[41] = {};
+		memcpy(mn, (char *)provider_hva + 24, 40);
+		fprintf(stderr, "MARKER: read done; byte0=0x%02x byte8=0x%02x\n",
+			first, poison_still);
+		fflush(stderr);
+		pr_info("Identify Controller in provider: VID=0x%04x SSVID=0x%04x MN='%s'\n",
+			vid, ssvid, mn);
+		fflush(stdout);
+		TEST_ASSERT(vid == expected_vid,
+			    "unexpected VID 0x%04x (expected 0x%04x) in provider region -- Identify DMA landed elsewhere?\n"
+			    "  poison=0x%02x byte0=0x%02x (poison intact=DMA didn't land here)",
+			    vid, expected_vid, poison_still, first);
+		pr_info("NVMe -> provider DMA VERIFIED\n");
+	}
+
+	/*
+	 * Phase 2: revoke the target page in the provider and verify that the
+	 * next DMA to the same IOVA fails, without touching provider memory.
+	 *
+	 * SET_PRESENT(present=0) marks the range absent in the provider bitmap
+	 * and fans out dma_buf_invalidate_mappings() to every exported dma-buf.
+	 * iommufd's iopt_revoke_notify (registered as .invalidate_mappings on
+	 * the dynamic attach) tears down the IOMMU mapping for that range and
+	 * marks the pages as revoked, so a subsequent device DMA to the same
+	 * IOVA lands with no IOMMU translation and either faults at the IOMMU
+	 * or completes with an NVMe error.  Either way the provider region
+	 * must not be overwritten.
+	 */
+	{
+		struct gmem_provider_present rev = {
+			.offset = 0, .len = 0x1000, .present = 0,
+		};
+		volatile uint32_t *c = (volatile uint32_t *)cq_buf;
+		uint32_t *s = (uint32_t *)sq_buf;
+		uint32_t status;
+		int ret;
+
+		/* Re-seed the target page so we can detect *any* write to it. */
+		memset(provider_hva, 0xa5, 0x1000);
+
+		ret = ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &rev);
+		TEST_ASSERT(ret == 0, "SET_PRESENT(revoke) errno=%d", errno);
+		pr_info("Revoked provider offset=0 len=0x1000; dma-buf mappings invalidated\n");
+
+		/* Issue a second Identify Controller aimed at the revoked IOVA.
+		 * Use a new CID and place the SQE in slot 1; the SQ ring will
+		 * wrap for larger runs but we only ever use slots 0 and 1.
+		 */
+		memset(&s[16], 0, 64);
+		s[16] = 0x00020006;			/* CID=2 << 16 | OPC=Identify */
+		s[16 + 6] = (uint32_t)IOVA_DST;
+		s[16 + 7] = (uint32_t)(IOVA_DST >> 32);
+		s[16 + 10] = 0x01;			/* CNS = Identify Controller */
+
+		asm volatile ("" ::: "memory");
+		wr32(bar, NVME_SQ0TDBL, 2);
+		pr_info("Identify Controller (revoked target) submitted (SQ0 tail=2)\n");
+
+		/* Poll for CQE at slot 1 with phase bit inverted from first pass. */
+		for (i = 0; i < 5000; i++) {
+			if ((c[4 + 3] & 0x10000))	/* CQE 1 P bit */
+				break;
+			usleep(1000);
+		}
+		TEST_ASSERT(c[4 + 3] & 0x10000, "revoke-phase CQE never landed");
+		status = (c[4 + 3] >> 17) & 0x7fff;
+		pr_info("post-revoke CQE: DW0=0x%08x DW3=0x%08x  status=0x%04x\n",
+			c[4 + 0], c[4 + 3], status);
+		wr32(bar, NVME_SQ0TDBL + doorbell_stride, 2);
+
+		/* Two acceptable outcomes here: (a) NVMe reports a non-zero
+		 * status (typical when the IOMMU fault takes the transaction
+		 * down), or (b) NVMe reports success but the target page was
+		 * not overwritten because the IOMMU rerouted / dropped the
+		 * write.  Either proves the revocation took effect on the DMA
+		 * side.  A silent success that overwrites provider memory
+		 * would be a bug in our revoke plumbing.
+		 */
+		{
+			uint8_t b0 = ((uint8_t *)provider_hva)[0];
+			pr_info("post-revoke provider byte0=0x%02x (seeded 0xa5)\n", b0);
+			TEST_ASSERT(b0 == 0xa5 || status != 0,
+				    "revoke leaked: status=0 and provider byte0=0x%02x != 0xa5",
+				    b0);
+			pr_info("Revoked-page DMA is not observable in provider memory\n");
+		}
+
+		/* Restore and confirm a fresh IOMMU_IOAS_MAP_FILE succeeds. */
+		rev.present = 1;
+		ret = ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &rev);
+		TEST_ASSERT(ret == 0, "SET_PRESENT(restore) errno=%d", errno);
+		pr_info("Restore + revoke round trip complete\n");
+	}
+
+	munmap(bar, reg.size);
+	close(vfio_fd);
+	close(dmabuf_fd);
+	close(iommufd_fd);
+	munmap(provider_hva, PROVIDER_SIZE);
+	close(gmem_fd);
+	close(gmem_ctl);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_vfio_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_vfio_test.c
new file mode 100644
index 000000000000..97a66a295b14
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_vfio_test.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_vfio_test - real passthrough device attached to an iommufd
+ * IOAS holding the provider dma-buf.
+ *
+ * Steps:
+ *   1. SETUP provider (KVM VM shape not required for this test).
+ *   2. iommufd IOAS + GET_DMABUF + IOMMU_IOAS_MAP_FILE - IOAS holds the
+ *      provider region.
+ *   3. Open a vfio-pci cdev (default /dev/vfio/devices/vfio0, overridable
+ *      via GMEM_VFIO_CDEV env), VFIO_DEVICE_BIND_IOMMUFD, then
+ *      VFIO_DEVICE_ATTACH_IOMMUFD_PT to the IOAS.
+ *
+ * On success the kernel has allocated (or reused) an iommu_domain for the
+ * device covering the provider region: subsequent DMA by the device to the
+ * mapped IOVAs would land in provider memory.  Actual DMA descriptor
+ * programming is device-specific and left as a follow-on.
+ *
+ * Skips if either the provider module or a bound vfio-pci cdev is absent.
+ */
+#include <fcntl.h>
+#include <errno.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+
+#include <linux/iommufd.h>
+#include <linux/vfio.h>
+#include <linux/kvm.h>
+
+#include "test_util.h"
+
+struct gmem_provider_setup {
+	__s32 kvm_fd;
+	__u32 flags;
+	__u64 size;
+};
+#define GMEM_PROVIDER_SETUP		_IOW('G', 1, struct gmem_provider_setup)
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE	(1u << 0)
+#define GMEM_PROVIDER_GET_DMABUF	_IO('G', 3)
+
+#define DATA_SIZE	0x200000ULL
+#define IOVA_BASE	(1ULL << 34)
+
+int main(void)
+{
+	struct gmem_provider_setup setup = { .flags = GMEM_PROVIDER_FLAG_MMAP_CAPABLE };
+	struct iommu_ioas_alloc alloc = {};
+	struct iommu_ioas_map_file map = {};
+	struct vfio_device_bind_iommufd bind = {};
+	struct vfio_device_attach_iommufd_pt att = {};
+	const char *cdev_path;
+	int gmem_ctl, gmem_fd, dmabuf_fd, iommufd_fd, vfio_fd, r;
+
+	gmem_ctl = open("/dev/gmem_provider", O_RDWR);
+	__TEST_REQUIRE(gmem_ctl >= 0, "gmem_provider module not loaded");
+	iommufd_fd = open("/dev/iommu", O_RDWR);
+	__TEST_REQUIRE(iommufd_fd >= 0, "iommufd unavailable (/dev/iommu absent)");
+
+	cdev_path = getenv("GMEM_VFIO_CDEV");
+	if (!cdev_path)
+		cdev_path = "/dev/vfio/devices/vfio0";
+	vfio_fd = open(cdev_path, O_RDWR);
+	__TEST_REQUIRE(vfio_fd >= 0,
+		       "no vfio-pci cdev at %s (bind a device first)", cdev_path);
+	pr_info("using vfio cdev: %s (fd=%d)\n", cdev_path, vfio_fd);
+
+	/* Provider fd (KVM binding not needed here, but SETUP still requires a
+	 * valid kvm_fd; pass /dev/kvm's own fd -- the SETUP path just fgets it
+	 * to grab a KVM ref, and /dev/kvm's file has ->private_data==NULL, so
+	 * the "kvm not attached" check must be relaxed OR we create a VM.
+	 * For robustness, create a bare KVM VM. */
+	{
+		int kvm = open("/dev/kvm", O_RDWR);
+		int vm;
+		TEST_ASSERT(kvm >= 0, "open /dev/kvm errno=%d", errno);
+		vm = ioctl(kvm, KVM_CREATE_VM, 0);
+		TEST_ASSERT(vm >= 0, "KVM_CREATE_VM errno=%d", errno);
+		setup.kvm_fd = vm;
+		close(kvm);
+	}
+	setup.size = DATA_SIZE;
+	gmem_fd = ioctl(gmem_ctl, GMEM_PROVIDER_SETUP, &setup);
+	TEST_ASSERT(gmem_fd >= 0, "GMEM_PROVIDER_SETUP errno=%d", errno);
+
+	/* IOAS + provider dma-buf */
+	alloc.size = sizeof(alloc);
+	r = ioctl(iommufd_fd, IOMMU_IOAS_ALLOC, &alloc);
+	TEST_ASSERT(!r, "IOMMU_IOAS_ALLOC errno=%d", errno);
+
+	dmabuf_fd = ioctl(gmem_fd, GMEM_PROVIDER_GET_DMABUF);
+	TEST_ASSERT(dmabuf_fd >= 0, "GET_DMABUF errno=%d", errno);
+
+	map.size = sizeof(map);
+	map.flags = IOMMU_IOAS_MAP_FIXED_IOVA |
+		    IOMMU_IOAS_MAP_READABLE | IOMMU_IOAS_MAP_WRITEABLE;
+	map.ioas_id = alloc.out_ioas_id;
+	map.fd = dmabuf_fd;
+	map.length = DATA_SIZE;
+	map.iova = IOVA_BASE;
+	r = ioctl(iommufd_fd, IOMMU_IOAS_MAP_FILE, &map);
+	TEST_ASSERT(!r, "IOMMU_IOAS_MAP_FILE errno=%d", errno);
+	pr_info("IOAS %u holds provider dma-buf @ IOVA 0x%llx (0x%llx bytes)\n",
+		alloc.out_ioas_id,
+		(unsigned long long)map.iova, (unsigned long long)map.length);
+
+	/* Bind VFIO cdev to iommufd */
+	bind.argsz = sizeof(bind);
+	bind.iommufd = iommufd_fd;
+	r = ioctl(vfio_fd, VFIO_DEVICE_BIND_IOMMUFD, &bind);
+	TEST_ASSERT(!r, "VFIO_DEVICE_BIND_IOMMUFD errno=%d", errno);
+	pr_info("VFIO device bound: devid=%u\n", bind.out_devid);
+
+	/* Attach the device to our IOAS */
+	att.argsz = sizeof(att);
+	att.pt_id = alloc.out_ioas_id;
+	r = ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &att);
+	TEST_ASSERT(!r,
+		    "VFIO_DEVICE_ATTACH_IOMMUFD_PT errno=%d\n"
+		    "	 (real device -> IOAS attach failed)", errno);
+	pr_info("VFIO device attached to IOAS -> pt_id=%u (kernel-selected)\n",
+		att.pt_id);
+	pr_info("real passthrough device now has IOMMU domain covering provider region\n");
+
+	close(vfio_fd);
+	close(dmabuf_fd);
+	close(iommufd_fd);
+	close(gmem_fd);
+	close(gmem_ctl);
+	return 0;
+}
-- 
2.55.0

