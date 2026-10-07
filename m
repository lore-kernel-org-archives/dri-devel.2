Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D8CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ECC210E55E;
	Wed,  7 Oct 2026 12:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="Jh5wCmqd";
	dkim-atps=neutral
X-Greylist: delayed 365 seconds by postgrey-1.36 at gabe;
 Wed, 07 Oct 2026 12:08:47 UTC
Received: from mta0.migadu.com (out-152.mta0.migadu.com [91.218.175.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51F3910E55E
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:08:47 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=I3I2EGwEvdd1xzorZSyj7Ywj415M3xlCNnegKaql7J0=; 
 c=simple/simple; d=cknow-tech.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791374925; v=1; x=1791979725;
 b=Jh5wCmqd39m4d8kziPvZbpltj6dFGeORaGW1UYX5N9XqBt016RPOoWwKmD6uZiUAro9UoBnZ
 Xn67Ns5KplJce2QUE6Eg9PF7a76Bsyto/dBEhYoGuC++IbsInJEvsjPDCLFIZdjYLwvKUBrjn64
 Pz6McjKEYZRVV1bN45lKhnY+nXISGGC6UVdqQYrsy8zEgO/wncyanTkQDnVoitYSlRieYQUZTvM
 o8G40lYbwPDJ1STcFZpm2wjLzeG91CZ55gzvI2XNL4wMuTFJzeliNd0FnB5DCEVZpF2hfFZvaMG
 BQHUrYgHX+1it5CG7OgdBBIG1vP/N2QKFN5LSmm1JNLMA==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 0df9cfd24733c53d;
 Wed, 07 Oct 2026 12:02:40 +0000
X-Mizu-Trace-ID: 0df9cfd24733c53d
X-Migadu-Flow: FLOW_OUT
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 14:02:31 +0200
Message-Id: <DLYLA3WQNN3X.3FB9MO8ZWBQ5@cknow-tech.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Jason Gunthorpe"
 <jgg@nvidia.com>, "Rob Clark" <rob.clark@oss.qualcomm.com>, "Jianfeng Liu"
 <liujianfeng1994@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Vinod Koul"
 <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] dma-buf: add a warn-only mode to DMABUF_DEBUG
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
X-Mailer: aerc 0.22.0-31-g5c1c510d2b65
References: <20261005064133.7305-1-kmehltretter@gmail.com>
 <20261005064133.7305-3-kmehltretter@gmail.com>
In-Reply-To: <20261005064133.7305-3-kmehltretter@gmail.com>
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

Hi,

On Mon Oct 5, 2026 at 8:41 AM CEST, Karl Mehltretter wrote:
> DMABUF_DEBUG hands importers a copy of the exporter's sg_table without
> the struct pages. An importer that uses them then fails, often far from
> the cause and without a message that points at it. Where sg_dma_len()
> is sg->length, the copy cannot hide the length either.
>
> Add DMABUF_DEBUG_WARN. With it the copy keeps the CPU side of the
> exporter's table: page, offset and length of all orig_nents entries,
> and the exporter's nents and orig_nents. A table without a CPU side
> (orig_nents =3D=3D 0) stays that way. Every entry of the copy is marked
> with a new dma_flags bit, SG_DMA_DMABUF_DEBUG.
>
> sg_page(), sg_nents_for_len() and sg_split() test the bit and print a
> rate limited message with a stack trace. sg_page() is mostly reached
> through DMA and scatterlist helpers, so the trace is what names the
> importer. These CPU-side accesses can continue after the report instead
> of failing because the fields were cleared.
>
> The report is not a WARN(). It does not taint the kernel and does not
> trigger panic_on_warn.
>
> Reads of sg->offset and sg->length that do not go through these
> helpers are not seen. The option adds a test to every sg_page() and
> selects NEED_SG_DMA_FLAGS.
>
> Strict mode remains the default and continues to remove the CPU-side
> fields.

Thanks for this patch set!

I build a 7.3-rc6 based kernel with this patch set included.
And I (ofc) enabled DMABUF_DEBUG and DMABUF_DEBUG_WARN.

I then tested it on my NanoPC-T6 Plus (RK3588 SoC) connected to my 1080p
monitor and also on my NanoPC-T6 LTS (RK3588) connected to my 4K TV (which
is HDMI 2.0, not 2.1, capable).
On both devices I got an identical call trace.
I did get a new (identical) one every time I resized the video window,
ie going from windowed to full-screen and back again.

```sh
[ 1091.981354] rc rc3: two consecutive events of type space
[ 1104.670513] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/input1=
2
[ 1172.090231] devfreq fb000000.gpu: Couldn't update frequency transition i=
nformation.
[ 1189.403278] devfreq fb000000.gpu: Couldn't update frequency transition i=
nformation.
[ 1206.309295] input: EDIFIER e235 (AVRCP) as /devices/virtual/input/input1=
3
[ 1268.968696] DMA-BUF: importer used the CPU side of an exporter's sg_tabl=
e
[ 1268.968710] CPU: 6 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc6+u=
nreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
[ 1268.968715] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[ 1268.968717] Call trace:
[ 1268.968719]  show_stack+0x20/0x38 (C)
[ 1268.968726]  dump_stack_lvl+0x60/0x80
[ 1268.968730]  sg_dmabuf_cpu_access_warn.part.0+0x24/0x30
[ 1268.968734]  sg_dmabuf_cpu_access_warn+0x34/0x38
[ 1268.968739]  iommu_map_sg+0xc8/0x1e0
[ 1268.968745]  rockchip_gem_iommu_map+0x8c/0x128 [rockchipdrm]
[ 1268.968757]  rockchip_gem_prime_import_sg_table+0x58/0x160 [rockchipdrm]
[ 1268.968761]  drm_gem_prime_import_dev+0xa8/0x1d0 [drm]
[ 1268.968776]  drm_gem_prime_fd_to_handle+0x1a4/0x280 [drm]
[ 1268.968786]  drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]
[ 1268.968796]  drm_ioctl_kernel+0xc8/0x140 [drm]
[ 1268.968806]  drm_ioctl+0x254/0x558 [drm]
[ 1268.968816]  __arm64_sys_ioctl+0xac/0x118
[ 1268.968821]  invoke_syscall.constprop.0+0xac/0x110
[ 1268.968825]  el0_svc_common.constprop.0+0x40/0xf0
[ 1268.968829]  do_el0_svc+0x24/0x40
[ 1268.968832]  el0_svc+0x40/0x260
[ 1268.968836]  el0t_64_sync_handler+0xa0/0xe8
[ 1268.968838]  el0t_64_sync+0x198/0x1a0
[ 1290.531300] sg_dmabuf_cpu_access_warn: 36 callbacks suppressed
[ 1290.531310] DMA-BUF: importer used the CPU side of an exporter's sg_tabl=
e
[ 1290.531319] CPU: 5 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc6+u=
nreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
[ 1290.531323] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[ 1290.531325] Call trace:
[ 1290.531327]  show_stack+0x20/0x38 (C)
[ 1290.531335]  dump_stack_lvl+0x60/0x80
[ 1290.531338]  sg_dmabuf_cpu_access_warn.part.0+0x24/0x30
[ 1290.531342]  sg_dmabuf_cpu_access_warn+0x34/0x38
[ 1290.531347]  iommu_map_sg+0xc8/0x1e0
[ 1290.531352]  rockchip_gem_iommu_map+0x8c/0x128 [rockchipdrm]
[ 1290.531364]  rockchip_gem_prime_import_sg_table+0x58/0x160 [rockchipdrm]
[ 1290.531368]  drm_gem_prime_import_dev+0xa8/0x1d0 [drm]
[ 1290.531384]  drm_gem_prime_fd_to_handle+0x1a4/0x280 [drm]
[ 1290.531394]  drm_prime_fd_to_handle_ioctl+0x40/0x58 [drm]
[ 1290.531404]  drm_ioctl_kernel+0xc8/0x140 [drm]
[ 1290.531414]  drm_ioctl+0x254/0x558 [drm]
[ 1290.531424]  __arm64_sys_ioctl+0xac/0x118
[ 1290.531429]  invoke_syscall.constprop.0+0xac/0x110
[ 1290.531433]  el0_svc_common.constprop.0+0x40/0xf0
[ 1290.531437]  do_el0_svc+0x24/0x40
[ 1290.531439]  el0_svc+0x40/0x260
[ 1290.531444]  el0t_64_sync_handler+0xa0/0xe8
[ 1290.531446]  el0t_64_sync+0x198/0x1a0
[ 1294.197699] devfreq fb000000.gpu: Couldn't update frequency transition i=
nformation.
[ 1313.464098] sg_dmabuf_cpu_access_warn: 149 callbacks suppressed
[ 1313.464121] DMA-BUF: importer used the CPU side of an exporter's sg_tabl=
e
[ 1313.464144] CPU: 2 UID: 1000 PID: 29025 Comm: sway Not tainted 7.3-rc6+u=
nreleased-arm64-cknow #1 PREEMPTLAZY  Debian 7.3~rc6-3
[ 1313.464156] Hardware name: FriendlyElec NanoPC-T6 Plus (DT)
[ 1313.464163] Call trace:
[ 1313.464168]  show_stack+0x20/0x38 (C)
...
```

Full dmesg output is posted here:
https://paste.sr.ht/~diederik/3d0020b4f3b0e8547397c20d5c10387d88d32341

Hopefully this helps fixing the underlaying issue.

Cheers,
  Diederik

> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>
> Notes:
>     Tested on v7.3-rc4-70-gfe2ec83746e5 with GCC 15.2.0.
>    =20
>     Builds, without warnings:
>    =20
>     - x86_64 with DMABUF_DEBUG_WARN=3Dy, full build
>     - arm64 defconfig with DMABUF_DEBUG_WARN=3Dy: Image, and the msm and
>       rockchip DRM drivers
>     - ARM926 (SAM9X75) with DMABUF_DEBUG_WARN=3Dy and without
>       NEED_SG_DMA_LENGTH, full build
>     - ARM926 with DMABUF_DEBUG=3Dn and without NEED_SG_DMA_FLAGS, full bu=
ild.
>       dma-buf.o and lib/scatterlist.o disassemble as on the base commit,
>       except for __LINE__ constants.
>     - x86_64 with SG_SPLIT, W=3D1, the objects touched here: with
>       DMABUF_DEBUG_WARN=3Dy, with DMABUF_DEBUG=3Dy alone, and with
>       DMABUF_DEBUG=3Dn
>    =20
>     Runtime, both in QEMU with local device models, not on hardware.
>    =20
>     Zynq with an AXI ADC, IIO DMABUF capture into udmabuf buffers,
>     NEED_SG_DMA_LENGTH=3Dy. The IIO dmaengine buffer calls sg_nents_for_l=
en()
>     on the attachment's table. With DMABUF_DEBUG=3Dy alone the capture fa=
ils:
>    =20
>       DMABUF_ENQUEUE failed: Device or resource busy
>    =20
>     With DMABUF_DEBUG_WARN=3Dy all 16 blocks arrive with the right data, =
the
>     kernel is not tainted, and the log has one report:
>    =20
>       DMA-BUF: importer used the CPU side of an exporter's sg_table
>       CPU: 0 UID: 0 PID: 48 Comm: iio-dmabuf Not tainted 7.3.0-rc4+ #2 VO=
LUNTARY
>       Hardware name: Xilinx Zynq Platform
>       Call trace:
>        unwind_backtrace from show_stack+0x10/0x14
>        show_stack from dump_stack_lvl+0x54/0x68
>        dump_stack_lvl from sg_nents_for_len+0xd8/0xe4
>        sg_nents_for_len from iio_dmaengine_buffer_submit_block+0x4c/0x33c
>        iio_dmaengine_buffer_submit_block from iio_dma_buffer_submit_block=
.part.0+0x5c/0x104
>        iio_dma_buffer_submit_block.part.0 from iio_dma_buffer_enqueue_dma=
buf+0x68/0xa0
>        iio_dma_buffer_enqueue_dmabuf from iio_buffer_chrdev_ioctl+0x520/0=
x9a4
>        iio_buffer_chrdev_ioctl from sys_ioctl+0x460/0x914
>        sys_ioctl from ret_fast_syscall+0x0/0x4c
>    =20
>     x86_64 with intel-iommu, xHCI and a SUR40, capture into udmabuf
>     buffers. This kernel had a one-line test-only change in sur40 that
>     makes the vb2 queue use the USB controller's DMA device. There was no
>     report during boot. The capture gives one, from sg_page() in
>     iommu_dma_map_sg():
>    =20
>       DMA-BUF: importer used the CPU side of an exporter's sg_table
>       CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 7.3.0-rc4+ #5 PR=
EEMPT(lazy)
>       Workqueue: events_freezable input_dev_poller_work
>       Call Trace:
>        <TASK>
>        dump_stack_lvl+0x4d/0x70
>        iommu_dma_map_sg+0x4c0/0x1010
>        __dma_map_sg_attrs+0x254/0x3b0
>        dma_map_sg_attrs+0xe/0x20
>        usb_hcd_map_urb_for_dma+0x7e0/0x1620
>        usb_hcd_submit_urb+0x162/0x1af0
>        usb_sg_wait+0x17c/0x550
>        sur40_poll+0xb3e/0xff0
>        input_dev_poller_work+0x54/0x90
>        process_one_work+0x692/0xf90
>        [...]
>    =20
>     The capture did not finish in this setup. The guest stalled in
>     xhci_queue_bulk_tx() after the report, so this run only shows the
>     report.
>    =20
>     The SG_DMA_* defines move up in scatterlist.h because sg_page() needs
>     the new one.
>
>  drivers/dma-buf/Kconfig     | 23 +++++++++++++++++++
>  drivers/dma-buf/dma-buf.c   | 44 ++++++++++++++++++++++++++++++++++++-
>  include/linux/scatterlist.h | 26 +++++++++++++++++++---
>  lib/scatterlist.c           | 22 +++++++++++++++++++
>  lib/sg_split.c              |  2 ++
>  5 files changed, 113 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index e4f078a326a4..06177465091a 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -49,6 +49,29 @@ config DMABUF_DEBUG
>  	  exporters. Specifically it validates that importers do not peek at th=
e
>  	  underlying struct page when they import a buffer.
> =20
> +config DMABUF_DEBUG_WARN
> +	bool "Warn instead of hiding the pages from DMA-BUF importers"
> +	depends on DMABUF_DEBUG
> +	select NEED_SG_DMA_FLAGS
> +	help
> +	  DMABUF_DEBUG normally hands importers a copy of the exporter's
> +	  sg_table without the struct page pointers, so that an importer which
> +	  uses them fails early.
> +
> +	  With this option the copy keeps the pages, offsets and lengths and is
> +	  only marked. sg_page() and the helpers built on it, sg_nents_for_len(=
)
> +	  and sg_split() then print a rate limited message with a stack trace
> +	  when they are used on such a table. The access itself continues
> +	  instead of failing because the fields were cleared. The message is
> +	  not a WARN(): it does not taint the kernel or trigger panic_on_warn.
> +
> +	  Importers that read sg->offset or sg->length directly are not
> +	  noticed. The option adds a test to every sg_page() call. It selects
> +	  NEED_SG_DMA_FLAGS, which adds dma_flags and may increase the size of
> +	  struct scatterlist.
> +
> +	  If unsure, say N.
> +
>  config DMABUF_KUNIT_TEST
>  	tristate "KUnit tests for DMA-BUF" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index b3d311acb883..bd82b6b7f5ff 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -57,6 +57,7 @@
>  struct dma_buf_sg_table_wrapper {
>  	struct sg_table *original;
>  	struct sg_table wrapper;
> +	unsigned int alloc_nents;
>  };
> =20
>  static inline int is_dma_buf_file(struct file *);
> @@ -874,11 +875,42 @@ void dma_buf_put(struct dma_buf *dmabuf)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_put, "DMA_BUF");
> =20
> +#ifdef CONFIG_DMABUF_DEBUG_WARN
> +/*
> + * Warn mode: the importer also gets the CPU side of the exporter's tabl=
e,
> + * marked so that sg_page() and friends can report who uses it.
> + */
> +static void dma_buf_wrap_cpu_side(struct sg_table *to, struct sg_table *=
from)
> +{
> +	struct scatterlist *to_sg, *from_sg;
> +	int i;
> +
> +	for_each_sgtable_sg(to, to_sg, i)
> +		to_sg->dma_flags |=3D SG_DMA_DMABUF_DEBUG;
> +
> +	to_sg =3D to->sgl;
> +	for_each_sgtable_sg(from, from_sg, i) {
> +		sg_assign_page(to_sg, sg_page(from_sg));
> +		to_sg->offset =3D from_sg->offset;
> +		to_sg->length =3D from_sg->length;
> +		to_sg =3D sg_next(to_sg);
> +	}
> +
> +	to->nents =3D from->nents;
> +	to->orig_nents =3D from->orig_nents;
> +}
> +#else
> +static void dma_buf_wrap_cpu_side(struct sg_table *to, struct sg_table *=
from)
> +{
> +}
> +#endif
> +
>  static int dma_buf_wrap_sg_table(struct sg_table **sg_table)
>  {
>  	struct scatterlist *to_sg, *from_sg;
>  	struct sg_table *from =3D *sg_table;
>  	struct dma_buf_sg_table_wrapper *to;
> +	unsigned int nents =3D from->nents;
>  	int i, ret;
> =20
>  	if (!IS_ENABLED(CONFIG_DMABUF_DEBUG))
> @@ -888,14 +920,21 @@ static int dma_buf_wrap_sg_table(struct sg_table **=
sg_table)
>  	 * To catch abuse of the underlying struct page by importers copy the
>  	 * sg_table without copying the page_link and give only the copy back t=
o
>  	 * the importer.
> +	 *
> +	 * With DMABUF_DEBUG_WARN the copy keeps the CPU side, which can have
> +	 * more entries than the DMA side.
>  	 */
>  	to =3D kzalloc_obj(*to);
>  	if (!to)
>  		return -ENOMEM;
> =20
> -	ret =3D sg_alloc_table(&to->wrapper, from->nents, GFP_KERNEL);
> +	if (IS_ENABLED(CONFIG_DMABUF_DEBUG_WARN))
> +		nents =3D max(nents, from->orig_nents);
> +
> +	ret =3D sg_alloc_table(&to->wrapper, nents, GFP_KERNEL);
>  	if (ret)
>  		goto free_to;
> +	to->alloc_nents =3D nents;
> =20
>  	to_sg =3D to->wrapper.sgl;
>  	for_each_sgtable_dma_sg(from, from_sg, i) {
> @@ -910,6 +949,7 @@ static int dma_buf_wrap_sg_table(struct sg_table **sg=
_table)
>  #endif
>  		to_sg =3D sg_next(to_sg);
>  	}
> +	dma_buf_wrap_cpu_side(&to->wrapper, from);
> =20
>  	to->original =3D from;
>  	*sg_table =3D &to->wrapper;
> @@ -929,6 +969,8 @@ static void dma_buf_unwrap_sg_table(struct sg_table *=
*sg_table)
> =20
>  	copy =3D container_of(*sg_table, typeof(*copy), wrapper);
>  	*sg_table =3D copy->original;
> +	/* sg_free_table() needs the number of allocated entries */
> +	copy->wrapper.orig_nents =3D copy->alloc_nents;
>  	sg_free_table(&copy->wrapper);
>  	kfree(copy);
>  }
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index 6de1a2434299..5dc8c134ca4c 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -21,6 +21,13 @@ struct scatterlist {
>  #endif
>  };
> =20
> +/* Bits in dma_flags, see below. sg_page() needs SG_DMA_DMABUF_DEBUG. */
> +#ifdef CONFIG_NEED_SG_DMA_FLAGS
> +#define SG_DMA_BUS_ADDRESS	(1 << 0)
> +#define SG_DMA_SWIOTLB		(1 << 1)
> +#define SG_DMA_DMABUF_DEBUG	(1 << 2)
> +#endif
> +
>  /*
>   * These macros should be used after a dma_map_sg call has been done
>   * to get bus addresses of each of the SG entries and their lengths.
> @@ -188,11 +195,27 @@ static inline void sg_set_folio(struct scatterlist =
*sg, struct folio *folio,
>  	sg->length =3D len;
>  }
> =20
> +#ifdef CONFIG_DMABUF_DEBUG_WARN
> +void sg_dmabuf_cpu_access_warn(void);
> +
> +/* Report use of the CPU side of a table that a DMA-BUF importer was giv=
en */
> +static inline void sg_dmabuf_cpu_access_check(struct scatterlist *sg)
> +{
> +	if (unlikely(sg->dma_flags & SG_DMA_DMABUF_DEBUG))
> +		sg_dmabuf_cpu_access_warn();
> +}
> +#else
> +static inline void sg_dmabuf_cpu_access_check(struct scatterlist *sg)
> +{
> +}
> +#endif
> +
>  static inline struct page *sg_page(struct scatterlist *sg)
>  {
>  #ifdef CONFIG_DEBUG_SG
>  	BUG_ON(sg_is_chain(sg));
>  #endif
> +	sg_dmabuf_cpu_access_check(sg);
>  	return (struct page *)((sg)->page_link & ~SG_PAGE_LINK_MASK);
>  }
> =20
> @@ -303,9 +326,6 @@ static inline void sg_unmark_end(struct scatterlist *=
sg)
>   */
>  #ifdef CONFIG_NEED_SG_DMA_FLAGS
> =20
> -#define SG_DMA_BUS_ADDRESS	(1 << 0)
> -#define SG_DMA_SWIOTLB		(1 << 1)
> -
>  /**
>   * sg_dma_is_bus_address - Return whether a given segment was marked
>   *			   as a bus address
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 6ea40d2e6247..55a3697df881 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -12,6 +12,27 @@
>  #include <linux/bvec.h>
>  #include <linux/uio.h>
>  #include <linux/folio_queue.h>
> +#include <linux/printk.h>
> +#include <linux/ratelimit.h>
> +
> +#ifdef CONFIG_DMABUF_DEBUG_WARN
> +/*
> + * Not a WARN(): a wrong importer must not taint the kernel or trigger
> + * panic_on_warn. sg_page() is mostly reached through DMA or scatterlist
> + * helpers, so the stack trace is what identifies the importer.
> + */
> +void sg_dmabuf_cpu_access_warn(void)
> +{
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL, 1);
> +
> +	if (!__ratelimit(&rs))
> +		return;
> +
> +	pr_warn("DMA-BUF: importer used the CPU side of an exporter's sg_table\=
n");
> +	dump_stack_lvl(KERN_WARNING);
> +}
> +EXPORT_SYMBOL(sg_dmabuf_cpu_access_warn);
> +#endif
> =20
>  /**
>   * sg_nents - return total count of entries in scatterlist
> @@ -54,6 +75,7 @@ int sg_nents_for_len(struct scatterlist *sg, u64 len)
>  		return 0;
> =20
>  	for (nents =3D 0, total =3D 0; sg; sg =3D sg_next(sg)) {
> +		sg_dmabuf_cpu_access_check(sg);
>  		nents++;
>  		total +=3D sg->length;
>  		if (total >=3D len)
> diff --git a/lib/sg_split.c b/lib/sg_split.c
> index 24e8f5e48e63..cbbc7f9a206d 100644
> --- a/lib/sg_split.c
> +++ b/lib/sg_split.c
> @@ -33,6 +33,8 @@ static int sg_calculate_split(struct scatterlist *in, i=
nt nents, int nb_splits,
>  	}
> =20
>  	for_each_sg(in, sg, nents, i) {
> +		if (!mapped)
> +			sg_dmabuf_cpu_access_check(sg);
>  		sglen =3D mapped ? sg_dma_len(sg) : sg->length;
>  		if (skip > sglen) {
>  			skip -=3D sglen;


