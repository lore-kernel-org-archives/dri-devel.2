Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838E1C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC49410EBF3;
	Tue,  8 Sep 2026 13:29:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E3F10EBF3
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:29:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 77E254002A;
 Tue,  8 Sep 2026 13:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A80E1F00A3E;
 Tue,  8 Sep 2026 13:29:38 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX
 and io_uring
To: "Li Wang" <liwang@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260908131545.105987-1-liwang@kylinos.cn>
References: <20260908131545.105987-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:29:34 +0000
Message-Id: <20260908132938.3A80E1F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Missing CPU PTE teardown during dma-buf invalidation allows us=
er space to access freed or repurposed GPU memory.
- [High] The driver treats a DMA bus address as a CPU physical address, whi=
ch breaks on architectures with PCI host bridge offsets.
- [High] Unsafe devres allocation on a foreign PCI device leads to use-afte=
r-free and double-free vulnerabilities.
- [High] Bypassing the Linux device model prevents safe handling of GPU hot=
-unplug.
- [High] `dma_buf_map_attachment` and `dma_buf_unmap_attachment` are called=
 without holding the reservation lock.
- [High] VMA splitting causes incorrect physical offset calculation in `fgd=
s_vma_fault()`.
- [Medium] `fgds_whitelist` entries are permanently leaked if `fgds_init()`=
 fails.
- [Medium] Buffer is published to the xarray before copy_to_user succeeds, =
exposing failed registrations to concurrent mmap.
--

commit 0a5d42c3fc0ec8a9c04361a7495748d62b3671d0
Author: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: misc: fgds: enable GPU-NVMe direct I/O via POSIX and io_uring

This commit introduces a new character device (`fgds`) that maps GPU memory
into user space to enable direct NVMe-to-GPU DMA via standard POSIX and
io_uring interfaces. It operates by registering dma-buf ranges from the GPU
and exposing them via mmap, bypassing the need for proprietary vendor APIs.

Link: https://dl.acm.org/doi/10.1145/3712285.3759862
Link: https://github.com/Storage-and-OS-for-AI/fgds

> diff --git a/drivers/misc/fgds.c b/drivers/misc/fgds.c
> new file mode 100644
> index 0000000000000..3aa4945f701b2
> --- /dev/null
> +++ b/drivers/misc/fgds.c
> @@ -0,0 +1,989 @@

[ ... ]

> +static int fgds_devm_memremap(struct fgds_dev *gdev)
> +{
> +	struct dev_pagemap *pgmap;
> +	int ret;
> +	void *addr;
> +
> +	gdev->pgmap =3D devm_kzalloc(&gdev->pdev->dev, sizeof(struct dev_pagema=
p),
> +				   GFP_KERNEL);
> +	if (!gdev->pgmap)
> +		return -ENOMEM;
> +
> +	pgmap =3D gdev->pgmap;
> +	pgmap->range.start =3D gdev->bar_paddr;
> +	pgmap->range.end =3D gdev->bar_paddr + gdev->bar_size - 1;
> +	pgmap->nr_range =3D 1;
> +	pgmap->type =3D MEMORY_DEVICE_GENERIC;
> +
> +	addr =3D devm_memremap_pages(&gdev->pdev->dev, pgmap);

[Severity: High]
Are we attaching devres allocations to a device owned by another driver her=
e?

fgds is not the bound owner of this PCI device (the primary GPU driver is).
When the primary GPU driver unbinds or the device is hot-unplugged, the dri=
ver
core calls devres_release_all() on the device, which will forcefully free
gdev->pgmap and unmap the memory without fgds knowing.

This can leave fgds with dangling pointers while its character device remai=
ns
active, causing subsequent userspace accesses to hit unmapped memory.

[ ... ]

> +static void fgds_invalidate_mappings(struct dma_buf_attachment *attach)
> +{
> +	struct fgds_buffer *buf =3D attach->importer_priv;
> +
> +	pr_warn_ratelimited("dma-buf moved while mapped; re-register required\n=
");
> +	if (buf)
> +		WRITE_ONCE(buf->invalidated, true);
> +}

[Severity: Critical]
Does this callback need to synchronously unmap the CPU PTEs mapped into
userspace?

The driver registers as a dynamic dma-buf importer, which mandates that the
importer must synchronously tear down all hardware and CPU page tables
pointing to the buffer before returning from this callback.

Merely setting a boolean flag and warning leaves existing userspace PTEs
intact. This allows userspace to retain unrestricted read/write access to
the physical pages after the exporter has repurposed them.

[ ... ]

> +static void fgds_buffer_free(struct kref *kref)
> +{
> +	struct fgds_buffer *buf =3D container_of(kref, struct fgds_buffer, ref);
> +
> +	if (buf->sgt)
> +		dma_buf_unmap_attachment(buf->attach, buf->sgt,
> +					 DMA_BIDIRECTIONAL);

[Severity: High]
Is it safe to unmap the dynamic attachment without holding the dma_resv loc=
k?

The dma-buf API strictly requires dynamic importers to acquire the buffer's
reservation lock before mapping or unmapping the attachment. Calling this
directly without the lock violates the API contract and can cause race
conditions with concurrent buffer movements.

[ ... ]

> +static int fgds_fill_extents(struct fgds_buffer *buf)
> +{
[ ... ]
> +		/* Verify the segment falls within the BAR window
> +		 */
> +		if (check_add_overflow(addr, (dma_addr_t)len, &seg_end) ||
> +		    addr < gdev->bar_paddr ||
> +		    seg_end > gdev->bar_paddr + gdev->bar_size) {

[Severity: High]
Does this incorrectly compare a DMA bus address directly to a CPU physical
address?

sg_dma_address() returns a dma_addr_t representing a bus address or IOVA,
while gdev->bar_paddr is a phys_addr_t derived from pci_resource_start().

On architectures with PCI host bridge address translation, these address sp=
aces
can differ, which might cause valid memory extents to be erroneously reject=
ed.

[ ... ]

> +static int fgds_buffer_import_dmabuf(struct fgds_buffer *buf, s32 dmabuf=
_fd)
> +{
[ ... ]
> +	buf->sgt =3D dma_buf_map_attachment(buf->attach, DMA_BIDIRECTIONAL);

[Severity: High]
Should this mapping operation also be protected by the dma_resv lock?

Similar to the unmap path, calling dma_buf_map_attachment() on a dynamic
attachment requires the caller to hold the buffer's reservation lock.

[ ... ]

> +static vm_fault_t fgds_vma_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct fgds_buffer *buf =3D vma->vm_private_data;
> +	u64 offset;
> +	struct fgds_extent *ext;
> +	phys_addr_t phys;
> +	unsigned long pfn;
> +	struct page *page;
> +
> +	if (!buf || unlikely(READ_ONCE(buf->invalidated)))
> +		return VM_FAULT_SIGBUS;
> +
> +	offset =3D vmf->address - vma->vm_start;

[Severity: High]
Does this dynamic offset calculation break if the VMA is split?

If the VMA is split (for example, via a partial munmap of the beginning of
the mapping), the kernel adjusts vma->vm_start for the new split VMA.

A fault in the split VMA would result in an incorrectly small offset,
causing it to map the beginning of the GPU buffer instead of the correct
middle section. Using vmf->pgoff might securely track the offset instead.

[ ... ]

> +	ext =3D fgds_lookup_extent(buf, offset);
> +	if (!ext)
> +		return VM_FAULT_SIGBUS;
> +
> +	phys =3D ext->dma_addr + (offset - ext->vma_offset);
> +	pfn =3D phys >> PAGE_SHIFT;
> +
> +	if (unlikely(!pfn_valid(pfn)))
> +		return VM_FAULT_SIGBUS;
> +	page =3D pfn_to_page(pfn);

[Severity: High]
Can this compute a CPU PFN from a DMA bus address?

The driver appears to treat the bus address as a CPU physical address,
shifting it to calculate a PFN that is then passed to pfn_to_page().

Passing a bus PFN to a function expecting a CPU PFN could result in a
garbage struct page resolution, potentially mapping arbitrary kernel memory
into userspace.

[ ... ]

> +static void fgds_dev_release(struct device *dev)
> +{
> +	struct fgds_dev *gdev =3D container_of(dev, struct fgds_dev, device);
> +
> +	if (gdev->pgmap) {
> +		devm_memunmap_pages(&gdev->pdev->dev, gdev->pgmap);
> +		devm_kfree(&gdev->pdev->dev, gdev->pgmap);

[Severity: High]
Could this lead to a double-free if the GPU driver has already unbound?

Because gdev->pgmap was allocated as a devres resource attached to the
foreign PCI device, it might have already been freed by devres_release_all()
during an unbind event. Manually freeing it here might access already freed
memory.

[ ... ]

> +static int fgds_ioctl_reg_buffer(struct fgds_file_ctx *ctx,
> +				 struct fgds_ioctl_reg_buffer __user *argp)
> +{
[ ... ]
> +	mutex_lock(&ctx->lock);
> +	ret =3D xa_alloc(&ctx->buffers, &id, buf, xa_limit_32b, GFP_KERNEL);

[Severity: Medium]
Is the buffer exposed to concurrent mmaps before the user copy succeeds?

The buffer is published to ctx->buffers via xa_alloc() here.

[ ... ]

> +	arg.idx =3D buf->idx;
> +	if (copy_to_user(argp, &arg, sizeof(arg))) {

[Severity: Medium]
If copy_to_user() blocks and fails, is there a race window here?

During the unprotected window between xa_alloc() and xa_erase() in the error
path, a concurrent thread could guess the allocated index and invoke mmap()
successfully.

The ioctl would return -EFAULT, but the userspace process would be left with
a valid, active mapping of the failed buffer.

[ ... ]

> +static int __init fgds_init(void)
> +{
[ ... ]
> +	/* Scan PCI for GPUs: 3D controllers first, then VGA adapters. */
> +	while ((pdev =3D pci_get_class(PCI_CLASS_DISPLAY_3D << 8, pdev)) !=3D N=
ULL) {
> +		if (fgds_has_large_memory_bar(pdev) && fgds_should_bind(pdev))
> +			fgds_create_device(pdev);
> +	}

[Severity: High]
Does bypassing the Linux device model prevent safe handling of GPU
hot-unplug events?

Instead of registering a proper struct pci_driver, this manually iterates
over the PCI bus, which leaves fgds blind to hot-plug events.

If a physical GPU is removed, fgds retains its reference and leaves the
physical BAR address mapped in its character devices and userspace VMAs,
which can cause PCIe Master Aborts or security issues if a new device is
plugged into the same slot.

[ ... ]

> +	if (list_empty(&fgds_dev_list)) {
> +		pr_err("no GPU devices registered\n");
> +		ret =3D -ENODEV;
> +		goto err_destroy_class;
> +	}

[Severity: Medium]
Are the dynamically allocated fgds_whitelist entries leaked here?

If no matching GPUs are found, the code jumps to err_destroy_class.
The error cleanup path cleans up classes and char devices but doesn't
free the elements in fgds_whitelist. Since fgds_exit() is never called
on an init failure, these entries seem permanently leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908131545.1059=
87-1-liwang@kylinos.cn?part=3D1
