Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DD5C44511
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D767F10E3AD;
	Thu, 16 Jul 2026 15:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="evns715z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699FF10E61B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:54:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 09CD540DB9;
 Thu, 16 Jul 2026 15:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E961F000E9;
 Thu, 16 Jul 2026 15:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784217246;
 bh=2ARGlddhlq6oOWMKmHU+qGHk6wvboO59UD0OjBYEhFY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=evns715z+HjckQtjK3KvZAzKH73Vhj1EMH5vopg+gT0ZoDRQ9UVaBw5Xyoou4W7vn
 Mrt4LchDhG2hq5Qn8JGchy+G3a92Y8MnqGkL4TbUxip/ave3RmFSZcnlducqYgQKJ+
 zNaxnq6xessVv1RXsRDc+LNuPdS2uhDMTk0xO+6emKaE1eHX0eO6YwUec9M1FEmB4i
 yo3l6oyuBJxoDFZLsFZ87pUFiJkA9njNaSOs4kOKC8H1U8xL+oET1uMZrsbhCw8i2L
 bInTVFVuo/7dggWYDz9AAW0+73AlYXMHac1NSi8y23Qa56bjpgMCCRo8eu3NVcH95v
 tuOzsqzcsHlOg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/11] samples/kvm, selftests/kvm: Allow the
 gmem_provider NVMe DMA test on arm64
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <a8a919d0b2884e4169a6951ba11152b3c8b1d07d.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <a8a919d0b2884e4169a6951ba11152b3c8b1d07d.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:54:06 +0000
Message-Id: <20260716155406.A9E961F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] The gmem_provider sample module blindly trusts the `setup.kvm_=
fd` file descriptor, leading to type confusion and local privilege escalati=
on.
- [High] A data race on the `info->kvm` pointer between `gmem_bind` and `gm=
em_fd_ioctl` allows a concurrent binding to drop the VM reference while it =
is actively being used, leading to a Use-After-Free.
- [Medium] The NVMe DMA selftest hardcodes the Amazon PCI Vendor ID (0x1d0f=
), causing it to fail on non-Amazon NVMe devices.
- [Medium] The selftest implicitly assumes a 4KB system page size, causing =
IOMMU mapping failures on architectures with larger page sizes.
- [Medium] The selftest bypasses architecture-specific I/O accessors and om=
its mandatory memory barriers, causing data races on weakly-ordered archite=
ctures.
- [Medium] The selftest performs raw, native-endian memory accesses on stri=
ctly little-endian PCI configuration space and NVMe registers, causing corr=
uption on big-endian architectures.
--

--- Patch [11]: [RFC PATCH 11/11] samples/kvm, selftests/kvm: Allow the gme=
m_provider NVMe DMA test on arm64 ---
commit fc0ebbb277714921db32af720eb2c5783d061ea0
Author: David Woodhouse <dwmw@amazon.co.uk>

samples/kvm, selftests/kvm: Allow the gmem_provider NVMe DMA test on arm64

The sample provider and the NVMe DMA selftest have no x86 specifics.
Drop the X86_64 gate on the sample's Kconfig (arm64 also has
KVM_GUEST_MEMFD; the SEV RMP reset is already guarded by
CONFIG_AMD_MEM_ENCRYPT) and move the NVMe DMA selftest from
TEST_GEN_PROGS_x86 to TEST_GEN_PROGS_COMMON so it also builds on
architectures with an IOMMU (arm64 SMMU-v3, ...).

> diff --git a/samples/Kconfig b/samples/Kconfig
> index 3482659638b5b..d26a03dea0728 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -328,7 +328,7 @@ source "samples/damon/Kconfig"
> =20
>  config SAMPLE_KVM_GMEM_PROVIDER
>  	tristate "Build sample guest_memfd provider -- loadable module only"
> -	depends on KVM_GUEST_MEMFD && X86_64 && m
> +	depends on KVM_GUEST_MEMFD && (X86_64 || ARM64) && m

[Severity: Critical]
Is it safe to blindly trust the kvm_fd here?

In gmem_ctl_ioctl(), the user-provided setup.kvm_fd is resolved and used
like this:

samples/kvm/gmem_provider.c:gmem_ctl_ioctl() {
    ...
	kvm_file =3D fget(setup.kvm_fd);
	if (!kvm_file)
		return -EBADF;
	kvm =3D kvm_file->private_data;
	if (!kvm) {
		fput(kvm_file);
		return -EINVAL;
	}
	kvm_get_kvm(kvm);
    ...
}

If a user passes an arbitrary file descriptor, it could lead to type confus=
ion
since we don't verify the file's operations before extracting private_data =
and
performing an out-of-bounds refcount_inc(&kvm->users_count).

[Severity: High]
Can gmem_fd_ioctl() safely use info->kvm without synchronization?

In gmem_fd_ioctl(), info->kvm is used without holding a lock:

samples/kvm/gmem_provider.c:gmem_fd_ioctl() {
    ...
		if (info->kvm)
			kvm_gmem_invalidate_range(info->kvm,
				info->base_gfn + start_index - info->pgoff,
				info->base_gfn + end_index - info->pgoff);
    ...
}

Concurrently, gmem_bind() can swap info->kvm and drop the underlying
reference:

samples/kvm/gmem_provider.c:gmem_bind() {
    ...
	if (info->kvm !=3D kvm) {
		kvm_get_kvm(kvm);
		if (info->kvm)
			kvm_put_kvm(info->kvm);
		info->kvm =3D kvm;
	}
    ...
}

Could this concurrent binding drop the VM reference to zero while it is bei=
ng
accessed by the ioctl, leading to a use-after-free?

[ ... ]

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 7f46843e7428f..12004a487c326 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -58,6 +58,7 @@ TEST_PROGS_x86 +=3D x86/nx_huge_pages_test.sh
>  # Compiled test targets valid on all architectures with libkvm support
>  TEST_GEN_PROGS_COMMON =3D demand_paging_test
>  TEST_GEN_PROGS_COMMON +=3D dirty_log_test
> +TEST_GEN_PROGS_COMMON +=3D gmem_provider_nvme_dma_test

[Severity: Medium]
Will this regression cause the test to fail on host hardware that doesn't u=
se
an Amazon NVMe device?

The test hardcodes the Amazon PCI Vendor ID:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:main() {
    ...
		TEST_ASSERT(vid =3D=3D 0x1d0f,
			    "unexpected VID 0x%04x in provider region -- Identify DMA landed els=
ewhere?\n"
    ...
}

Should the expected VID be read dynamically from offset 0x00 instead?

[Severity: Medium]
Does the implicit 4KB system page size assumption introduce a regression on
architectures that commonly use larger page sizes, such as arm64?

The test uses hardcoded 4KB offsets and lengths for IOMMU mapping:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:main() {
    ...
	TEST_ASSERT(!ioas_map_user(iommufd_fd, alloc.out_ioas_id, sq_buf, IOVA_SQ,=
 0x1000),
		    "IOAS_MAP(sq) errno=3D%d", errno);
	TEST_ASSERT(!ioas_map_user(iommufd_fd, alloc.out_ioas_id, cq_buf, IOVA_CQ,=
 0x1000),
		    "IOAS_MAP(cq) errno=3D%d", errno);
    ...
}

Since iommufd requires mapping lengths and IOVAs to be aligned to the system
page size, won't this fail on kernels running with 16KB or 64KB page sizes?

[Severity: Medium]
Can a data race occur on weakly-ordered architectures without memory barrie=
rs?

The custom MMIO accessors use plain volatile writes:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:wr32() {
    ...
static void     wr32(void *b, uint32_t o, uint32_t v) { *(volatile uint32_t=
 *)((char *)b + o) =3D v; }
    ...
}

When ringing the doorbell:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:main() {
    ...
	/* Ring SQ0 tail doorbell. */
	wr32(bar, NVME_SQ0TDBL, 1);
    ...
}

Without an explicit memory barrier, is the CPU free to reorder the MMIO wri=
te
to the doorbell ahead of the normal RAM writes to the Submission Queue Entr=
y?

[Severity: Medium]
Does this code corrupt device state on big-endian architectures?

Since the test is now built for all architectures, it will run on big-endian
systems. However, the test uses native-endian assignments to interact with
little-endian PCI configuration space and NVMe registers:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:main() {
    ...
	TEST_ASSERT(pread(vfio_fd, &pci_cmd, 2, cfg_off + 0x04) =3D=3D 2, "cfg CMD=
 read");
	pci_cmd |=3D 0x0006;
	TEST_ASSERT(pwrite(vfio_fd, &pci_cmd, 2, cfg_off + 0x04) =3D=3D 2, "cfg CM=
D write");
    ...
}

And for the NVMe SQE:

tools/testing/selftests/kvm/gmem_provider_nvme_dma_test.c:main() {
    ...
		s[0]  =3D 0x00010006;	/* CID=3D1 << 16 | OPC=3DIdentify */
    ...
}

Will these direct native-endian accesses produce byte-swapped data on
big-endian CPUs and cause the test to fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D11
