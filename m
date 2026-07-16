Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFCFC44516
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4047710E387;
	Thu, 16 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="GWWAGDdz";
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0B610E37F
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Rxe7PyHaM1ooGwVaze/mU65uBu7vzB49ogLEOOZ0Qjs=; b=GWWAGDdzGZkQM9w9SGSjh6W6zH
 jfqy2hmBfFKd6pD4FqgH5RDBFXtDYsVJaicJ3UwvPKCEwd6nx2sGAScYSmw5+mdqE1YA2vknzBecV
 +lNhtiMs+7CElz84UkWiwfldEejKC+wcyk+1OzekGw3Md/HE+eA2qgez9FsibnboraMy1/VnyjUwJ
 YhpdLJV/uCEMD+yyFAgRL2yaUy/bqcQipqkAaELuqFy9mYOd/3XgmBDEl9ycGunvsdZQSgWVy+bdI
 ISOpzVAA/zqybVLJKvty3BvWJNVhxsVmMrG9p+bLzaYtP/21Nfdnq6ZmlNgT9Wl+QHtY5qaP6JRKi
 yEnLV0FQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wkNpj-00000002l0e-3VpO; Thu, 16 Jul 2026 15:17:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red
 Hat Linux)) id 1wkNpj-000000012tM-2ZQu;
 Thu, 16 Jul 2026 16:17:07 +0100
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
Subject: [RFC PATCH 09/11] selftests/kvm: gmem_provider KVM-only tests
Date: Thu, 16 Jul 2026 10:31:29 +0100
Message-ID: <7022c98bc66214bf02334d648ec0fd4d296c6c14.1784194290.git.dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
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

Three selftests that exercise the guest_memfd provider ABI purely from
the KVM side (no iommufd, no assigned devices):

  gmem_provider_test
    SEV-SNP launch + re-bind against a page-less provider region.
    Loads a 16 MiB guest at physical addr= from the module parameters,
    runs SNP_LAUNCH_START -> SNP_LAUNCH_UPDATE -> SNP_LAUNCH_FINISH ->
    KVM_CREATE_VCPU, tears the VM down, and re-binds the same provider
    fd to a fresh SNP VM.  Proves the LU-survivable path (fd persists,
    KVM refs transfer, RMP transitions clean).

  gmem_provider_hugepage_test
    Non-CoCo (SW_PROTECTED_VM) guest whose slot is backed by a
    mmap-capable provider fd.  Verifies via KVM_GET_STATS that the NPT
    for a 1 GiB, 1G-aligned slot contains at least one 1 GiB and one
    2 MiB mapping.  Exercises kvm_gmem_max_mapping_level and the
    mmap-capable = gmem-only path.

  gmem_provider_revoke_test
    GMEM_PROVIDER_SET_PRESENT round trip.  Reads a page from the guest
    (populates NPT), revokes the range, re-enters the guest to observe
    the fault (memory attribute goes absent, vcpu_run fails EFAULT),
    restores and re-enters, confirms the guest reads the original
    value.  Exercises the provider-driven kvm_gmem_provider_invalidate
    helper end-to-end.

All three assume the sample provider is loaded with an addr=/len=
page-less region; hugepage and revoke additionally require the fd to
be set up with GMEM_PROVIDER_FLAG_MMAP_CAPABLE.

Signed-off-by: David Woodhouse (Kiro) <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   3 +
 .../kvm/x86/gmem_provider_hugepage_test.c     | 130 ++++++++++++
 .../kvm/x86/gmem_provider_revoke_test.c       | 134 ++++++++++++
 .../selftests/kvm/x86/gmem_provider_test.c    | 195 ++++++++++++++++++
 4 files changed, 462 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_hugepage_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/gmem_provider_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d28a057fa6c2..e6e9ac9da45a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -161,6 +161,9 @@ TEST_GEN_PROGS_x86 += rseq_test
 TEST_GEN_PROGS_x86 += steal_time
 TEST_GEN_PROGS_x86 += system_counter_offset_test
 TEST_GEN_PROGS_x86 += pre_fault_memory_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_hugepage_test
+TEST_GEN_PROGS_x86 += x86/gmem_provider_revoke_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_hugepage_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_hugepage_test.c
new file mode 100644
index 000000000000..fbbef9761e64
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_hugepage_test.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_hugepage_test - verify KVM installs 2M and 1G NPT/EPT mappings
+ * for a non-confidential guest backed entirely by the samples/kvm gmem_provider
+ * in its gmem-only (mmap) mode.
+ *
+ * The test opens the provider with GMEM_PROVIDER_FLAG_MMAP_CAPABLE at SETUP time.
+ * Load the module with a >=1G, 1G-aligned page-less range:
+ *   insmod gmem_provider.ko addr=0x5D40000000 len=0x42000000
+ *
+ * The provider fd is mmap-capable, so its slot is gmem-only: all guest faults
+ * route to the provider (no private attributes needed) and the mapping level
+ * comes from the provider's max_order. The slot's userspace_addr is a
+ * 1G-aligned mmap of the provider, so the lpage HVA-alignment check passes and
+ * 1G is permitted. Skips if the module or SW_PROTECTED VM support is absent.
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
+#include <linux/sizes.h>
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
+#define GMEM_PROVIDER_SETUP _IOW('G', 1, struct gmem_provider_setup)
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE (1u << 0)
+
+#define DATA_SLOT	10
+#define DATA_GPA	(1ULL << 32)		/* 4G: 1G-aligned */
+#define DATA_SIZE	((uint64_t)SZ_1G + SZ_2M)
+
+static void guest_code(void)
+{
+	*(volatile uint64_t *)DATA_GPA = 0xdead;		/* -> 1G mapping */
+	*(volatile uint64_t *)(DATA_GPA + SZ_1G) = 0xbeef;	/* -> 2M mapping */
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
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int gmem_ctl, gmem_fd, r;
+	void *resv, *hva;
+	uint64_t p4k, p2m, p1g;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	gmem_ctl = open("/dev/gmem_provider", O_RDWR);
+	__TEST_REQUIRE(gmem_ctl >= 0,
+		       "gmem_provider module not loaded (/dev/gmem_provider absent)");
+
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
+
+	setup.kvm_fd = vm->fd;
+	setup.size = DATA_SIZE;
+	gmem_fd = ioctl(gmem_ctl, GMEM_PROVIDER_SETUP, &setup);
+	TEST_ASSERT(gmem_fd >= 0, "GMEM_PROVIDER_SETUP failed, errno %d", errno);
+
+	/*
+	 * Map the provider at a 1G-aligned host VA so the slot's userspace_addr
+	 * is 1G-congruent with the (1G-aligned) GPA and KVM permits 1G lpages.
+	 * A non-mmap-capable provider (the coco path) would fail this mmap.
+	 */
+	resv = mmap(NULL, DATA_SIZE + SZ_1G, PROT_NONE,
+		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+	TEST_ASSERT(resv != MAP_FAILED, "reserve VA failed, errno %d", errno);
+	hva = (void *)(((uintptr_t)resv + SZ_1G - 1) & ~((uintptr_t)SZ_1G - 1));
+	hva = mmap(hva, DATA_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_FIXED, gmem_fd, 0);
+	TEST_ASSERT(hva != MAP_FAILED,
+		    "mmap(provider) failed, errno %d", errno);
+
+	/* gmem-only slot: the provider is the whole backing; host uses @hva. */
+	r = __vm_set_user_memory_region2(vm, DATA_SLOT, KVM_MEM_GUEST_MEMFD,
+					 DATA_GPA, DATA_SIZE, hva, gmem_fd, 0);
+	TEST_ASSERT(!r, "KVM_SET_USER_MEMORY_REGION2 failed: %d errno %d", r, errno);
+
+	/* Map only the two pages the guest touches into its page tables. */
+	virt_map(vm, DATA_GPA, DATA_GPA, 1);
+	virt_map(vm, DATA_GPA + SZ_1G, DATA_GPA + SZ_1G, 1);
+
+	vcpu_run(vcpu);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected exit: %s",
+			  exit_reason_str(vcpu->run->exit_reason));
+	}
+
+	p4k = vm_get_stat(vm, pages_4k);
+	p2m = vm_get_stat(vm, pages_2m);
+	p1g = vm_get_stat(vm, pages_1g);
+	pr_info("gmem-only provider NPT mappings: 4K=%lu 2M=%lu 1G=%lu\n",
+		p4k, p2m, p1g);
+	/* Informational: the host mapping and guest share the same memory. */
+	pr_info("host reads at DATA_GPA via mmap: 0x%llx\n",
+		(unsigned long long)*(volatile uint64_t *)hva);
+
+	TEST_ASSERT(p1g > 0, "expected at least one 1G NPT mapping, got 0");
+	TEST_ASSERT(p2m > 0, "expected at least one 2M NPT mapping, got 0");
+
+	kvm_vm_free(vm);
+	munmap(hva, DATA_SIZE);
+	close(gmem_fd);
+	close(gmem_ctl);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c
new file mode 100644
index 000000000000..7e711ea52674
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_revoke_test.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_revoke_test - exercise provider-driven page revocation.
+ *
+ * Flips a provider-backed page between present and absent via an ioctl on the
+ * provider fd and checks the provider->KVM path: revoking zaps the guest's NPT
+ * (so the guest re-faults into an absent get_pfn and cannot read the page),
+ * restoring lets the next fault re-map it. This is the mechanism a memory
+ * overcommit manager would use to reclaim a page from a running guest.
+ *
+ * The test opens the provider with GMEM_PROVIDER_FLAG_MMAP_CAPABLE at SETUP time (gmem-only). Load the module with a
+ * backing region of at least DATA_SIZE, e.g.:
+ *   insmod gmem_provider.ko addr=0x5D40000000 len=0x1000000
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
+struct gmem_provider_present {
+	__u64 offset;
+	__u64 len;
+	__u32 present;
+	__u32 pad;
+};
+#define GMEM_PROVIDER_SETUP		_IOW('G', 1, struct gmem_provider_setup)
+#define GMEM_PROVIDER_FLAG_MMAP_CAPABLE	(1u << 0)
+#define GMEM_PROVIDER_SET_PRESENT	_IOW('G', 2, struct gmem_provider_present)
+
+#define DATA_SLOT	10
+#define DATA_GPA	(1ULL << 32)
+#define DATA_SIZE	0x200000ULL		/* 2 MiB region */
+#define MAGIC		0x1234abcdULL
+
+static void guest_code(void)
+{
+	*(volatile uint64_t *)DATA_GPA = MAGIC;
+	for (;;)
+		GUEST_SYNC(*(volatile uint64_t *)DATA_GPA);
+}
+
+int main(void)
+{
+	struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+	struct gmem_provider_setup setup = { .flags = GMEM_PROVIDER_FLAG_MMAP_CAPABLE };
+	struct gmem_provider_present req;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int gmem_ctl, gmem_fd, r;
+	void *hva;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
+
+	gmem_ctl = open("/dev/gmem_provider", O_RDWR);
+	__TEST_REQUIRE(gmem_ctl >= 0,
+		       "gmem_provider module not loaded (/dev/gmem_provider absent)");
+
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
+
+	setup.kvm_fd = vm->fd;
+	setup.size = DATA_SIZE;
+	gmem_fd = ioctl(gmem_ctl, GMEM_PROVIDER_SETUP, &setup);
+	TEST_ASSERT(gmem_fd >= 0, "GMEM_PROVIDER_SETUP failed, errno %d", errno);
+
+	hva = mmap(NULL, DATA_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, gmem_fd, 0);
+	TEST_ASSERT(hva != MAP_FAILED,
+		    "mmap(provider) failed, errno %d", errno);
+
+	r = __vm_set_user_memory_region2(vm, DATA_SLOT, KVM_MEM_GUEST_MEMFD,
+					 DATA_GPA, DATA_SIZE, hva, gmem_fd, 0);
+	TEST_ASSERT(!r, "KVM_SET_USER_MEMORY_REGION2 failed: %d errno %d", r, errno);
+	virt_map(vm, DATA_GPA, DATA_GPA, 1);
+
+	/* 1) Present: guest writes MAGIC and reads it back. */
+	vcpu_run(vcpu);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_SYNC, "expected UCALL_SYNC");
+	TEST_ASSERT(uc.args[1] == MAGIC, "guest read 0x%lx, want MAGIC",
+		    (unsigned long)uc.args[1]);
+	pr_info("present: guest read 0x%llx\n", MAGIC);
+
+	/* 2) Revoke: mark absent and zap the guest NPT (provider->KVM). */
+	req = (struct gmem_provider_present){ .offset = 0, .len = 4096, .present = 0 };
+	r = ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &req);
+	TEST_ASSERT(!r, "revoke ioctl failed, errno %d", errno);
+
+	/* 3) Guest re-reads -> re-fault into absent get_pfn -> must NOT see MAGIC. */
+	r = _vcpu_run(vcpu);
+	if (r) {
+		pr_info("revoked: vcpu_run failed (errno %d) -- guest faulted, as expected\n",
+			errno);
+	} else {
+		TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT,
+			    "revoked: expected fault or KVM_EXIT_MEMORY_FAULT, got %u (%s)",
+			    vcpu->run->exit_reason,
+			    exit_reason_str(vcpu->run->exit_reason));
+		pr_info("revoked: KVM_EXIT_MEMORY_FAULT as expected\n");
+	}
+
+	/* 4) Restore: mark present again. */
+	req.present = 1;
+	r = ioctl(gmem_fd, GMEM_PROVIDER_SET_PRESENT, &req);
+	TEST_ASSERT(!r, "restore ioctl failed, errno %d", errno);
+
+	/* 5) Re-enter: the fault re-maps via get_pfn, guest reads MAGIC again. */
+	vcpu_run(vcpu);
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_SYNC, "expected UCALL_SYNC after restore");
+	TEST_ASSERT(uc.args[1] == MAGIC, "after restore guest read 0x%lx, want MAGIC",
+		    (unsigned long)uc.args[1]);
+	pr_info("restored: guest read 0x%llx again -- revoke/restore path works\n", MAGIC);
+
+	kvm_vm_free(vm);
+	munmap(hva, DATA_SIZE);
+	close(gmem_fd);
+	close(gmem_ctl);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/gmem_provider_test.c b/tools/testing/selftests/kvm/x86/gmem_provider_test.c
new file mode 100644
index 000000000000..d7caa11616df
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/gmem_provider_test.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * gmem_provider_test - exercise the samples/kvm gmem_provider module through a
+ * full SEV-SNP guest launch, then re-bind the same provider fd to a second VM
+ * (the live-update path).
+ *
+ * The provider module must be loaded first, in either mode:
+ *   insmod gmem_provider.ko addr=0x5D40000000 len=0x1000000   # page-less
+ *   insmod gmem_provider.ko                                   # CMA fallback
+ *
+ * The test skips (KSFT_SKIP) if /dev/gmem_provider or SNP support is absent.
+ *
+ * Note: with the current kvm_gmem_populate() ABI the launch source is an
+ * ordinary anonymous buffer (pinned via get_user_pages_fast); the provider's
+ * populate() copies it into the backing.  No /dev/mem mapping is needed.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <stdint.h>
+#include <linux/kvm.h>
+#include <asm/kvm.h>
+
+/* Mirrors samples/kvm/gmem_provider.h */
+struct gmem_provider_setup {
+	int32_t kvm_fd;
+	uint32_t pad;
+	uint64_t size;
+};
+#define GMEM_PROVIDER_SETUP _IOW('G', 1, struct gmem_provider_setup)
+
+#define KSFT_PASS 0
+#define KSFT_FAIL 1
+#define KSFT_SKIP 4
+
+#define GUEST_MEM_SIZE	(16UL * 1024 * 1024)
+#define PAGE_SIZE_4K	4096UL
+
+static int sev_ioctl(int vm_fd, int sev_fd, int cmd, void *data)
+{
+	struct kvm_sev_cmd sev_cmd = {
+		.id = cmd,
+		.data = (uint64_t)(unsigned long)data,
+		.sev_fd = sev_fd,
+	};
+	return ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &sev_cmd);
+}
+
+static int launch_snp_vm(int kvm_fd, int gmem_fd, void *src, int vm_num)
+{
+	int vm_fd, vcpu_fd, sev_fd, ret;
+
+	printf("[VM%d] KVM_CREATE_VM (SNP)\n", vm_num);
+	vm_fd = ioctl(kvm_fd, KVM_CREATE_VM, KVM_X86_SNP_VM);
+	if (vm_fd < 0) { perror("KVM_CREATE_VM"); return -1; }
+
+	sev_fd = open("/dev/sev", O_RDWR);
+	if (sev_fd < 0) { perror("open /dev/sev"); close(vm_fd); return -1; }
+
+	struct kvm_sev_init init = { 0 };
+	ret = sev_ioctl(vm_fd, sev_fd, KVM_SEV_INIT2, &init);
+	if (ret) { perror("KVM_SEV_INIT2"); goto out; }
+
+	struct kvm_userspace_memory_region2 region = {
+		.slot = 0,
+		.flags = KVM_MEM_GUEST_MEMFD,
+		.guest_phys_addr = 0,
+		.memory_size = GUEST_MEM_SIZE,
+		.userspace_addr = (uint64_t)(unsigned long)src,
+		.guest_memfd = gmem_fd,
+		.guest_memfd_offset = 0,
+	};
+	ret = ioctl(vm_fd, KVM_SET_USER_MEMORY_REGION2, &region);
+	if (ret) { perror("KVM_SET_USER_MEMORY_REGION2"); goto out; }
+
+	struct kvm_memory_attributes attrs = {
+		.address = 0,
+		.size = GUEST_MEM_SIZE,
+		.attributes = KVM_MEMORY_ATTRIBUTE_PRIVATE,
+	};
+	ret = ioctl(vm_fd, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
+	if (ret) { perror("KVM_SET_MEMORY_ATTRIBUTES"); goto out; }
+
+	struct kvm_sev_snp_launch_start start = { .policy = 0x30000 };
+	ret = sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_START, &start);
+	if (ret) { perror("SNP_LAUNCH_START"); goto out; }
+
+	printf("[VM%d] SNP_LAUNCH_UPDATE (code + zero, %luMB)\n",
+	       vm_num, GUEST_MEM_SIZE >> 20);
+	struct kvm_sev_snp_launch_update update = {
+		.gfn_start = 0,
+		.uaddr = (uint64_t)(unsigned long)src,
+		.len = PAGE_SIZE_4K,
+		.type = KVM_SEV_SNP_PAGE_TYPE_NORMAL,
+	};
+	ret = sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_UPDATE, &update);
+	if (ret) { perror("SNP_LAUNCH_UPDATE code"); goto out; }
+
+	struct kvm_sev_snp_launch_update update_zero = {
+		.gfn_start = 1,
+		.uaddr = (uint64_t)(unsigned long)(src + PAGE_SIZE_4K),
+		.len = GUEST_MEM_SIZE - PAGE_SIZE_4K,
+		.type = KVM_SEV_SNP_PAGE_TYPE_ZERO,
+	};
+	ret = sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_UPDATE, &update_zero);
+	if (ret) { perror("SNP_LAUNCH_UPDATE zero"); goto out; }
+
+	struct kvm_sev_snp_launch_finish finish = { 0 };
+	ret = sev_ioctl(vm_fd, sev_fd, KVM_SEV_SNP_LAUNCH_FINISH, &finish);
+	if (ret) { perror("SNP_LAUNCH_FINISH"); goto out; }
+
+	vcpu_fd = ioctl(vm_fd, KVM_CREATE_VCPU, 0);
+	if (vcpu_fd < 0) { perror("KVM_CREATE_VCPU"); ret = -1; goto out; }
+
+	printf("[VM%d] *** launch succeeded ***\n", vm_num);
+	close(vcpu_fd);
+	ret = 0;
+out:
+	close(sev_fd);
+	close(vm_fd);
+	return ret;
+}
+
+int main(void)
+{
+	int kvm_fd, gmem_ctl_fd, gmem_fd, tmp_vm;
+	void *src;
+
+	setbuf(stdout, NULL);
+
+	kvm_fd = open("/dev/kvm", O_RDWR);
+	if (kvm_fd < 0) {
+		printf("SKIP: cannot open /dev/kvm (%s)\n", strerror(errno));
+		return KSFT_SKIP;
+	}
+
+	gmem_ctl_fd = open("/dev/gmem_provider", O_RDWR);
+	if (gmem_ctl_fd < 0) {
+		printf("SKIP: /dev/gmem_provider not present -- load gmem_provider.ko (%s)\n",
+		       strerror(errno));
+		return KSFT_SKIP;
+	}
+
+	/* Provider setup needs a VM fd; ownership transfers to each VM on bind. */
+	tmp_vm = ioctl(kvm_fd, KVM_CREATE_VM, KVM_X86_SNP_VM);
+	if (tmp_vm < 0) {
+		printf("SKIP: cannot create SNP VM -- host not SNP-capable? (%s)\n",
+		       strerror(errno));
+		return KSFT_SKIP;
+	}
+
+	struct gmem_provider_setup setup = {
+		.kvm_fd = tmp_vm,
+		.size = GUEST_MEM_SIZE,
+	};
+	gmem_fd = ioctl(gmem_ctl_fd, GMEM_PROVIDER_SETUP, &setup);
+	if (gmem_fd < 0) {
+		perror("GMEM_PROVIDER_SETUP");
+		return KSFT_FAIL;
+	}
+	close(tmp_vm);
+	printf("provider gmem_fd = %d (persists across VMs)\n", gmem_fd);
+
+	/* Launch source: ordinary anonymous memory holding a HLT at gfn 0. */
+	src = mmap(NULL, GUEST_MEM_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (src == MAP_FAILED) { perror("mmap src"); return KSFT_FAIL; }
+	memset(src, 0, GUEST_MEM_SIZE);
+	((uint8_t *)src)[0] = 0xf4; /* HLT */
+
+	if (launch_snp_vm(kvm_fd, gmem_fd, src, 1) != 0) {
+		printf("FAIL: VM1 launch failed\n");
+		return KSFT_FAIL;
+	}
+
+	usleep(100000);
+
+	/* Re-bind the SAME provider fd to a fresh VM (live-update path). */
+	if (launch_snp_vm(kvm_fd, gmem_fd, src, 2) != 0) {
+		printf("FAIL: VM2 re-bind launch failed\n");
+		return KSFT_FAIL;
+	}
+
+	printf("PASS: page-less/provider-backed SNP launch + re-bind succeeded\n");
+	munmap(src, GUEST_MEM_SIZE);
+	close(gmem_fd);
+	close(gmem_ctl_fd);
+	close(kvm_fd);
+	return KSFT_PASS;
+}
-- 
2.54.0

