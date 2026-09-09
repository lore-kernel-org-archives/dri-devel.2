Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48809C79FAA
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE0A10EEFB;
	Wed,  9 Sep 2026 06:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="syhmPmyh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B850110EEF9
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 06:47:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 971A3601FB;
 Wed,  9 Sep 2026 06:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC7F1F00A3A;
 Wed,  9 Sep 2026 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1788936423;
 bh=Z3KVIaddpfCo8To//cbSyOpxz2vaMHff+bwmPbywxBo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=syhmPmyhhf6g0BZmvYqPKfBPAWpZeyZ2icgrI0NTcachxc/q/dX2I5xqq1YV6g729
 q9hpXb4MuU//e8dS2YK7JSzX3ZMx7xoN3KGYXyqu1v5685rLmbw3MI9Ido0s4jME1Z
 zd/MLkIOUwhBhNCmBnbJq8afPK8pekdg/v8FEdxk=
Date: Wed, 9 Sep 2026 08:10:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Li Wang <liwang@kylinos.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: Re: [RFC PATCH] misc: fgds: enable GPU-NVMe direct I/O via POSIX and
 io_uring
Message-ID: <2026090913-landline-encroach-c544@gregkh>
References: <20260908131545.105987-1-liwang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908131545.105987-1-liwang@kylinos.cn>
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

On Tue, Sep 08, 2026 at 09:15:45PM +0800, Li Wang wrote:
> From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> 
> Inspired by the paper published in SC'25 [1], we implemented a character
> device named fgds that provides two ioctl interfaces:
> `REG_BUFFER/UNREG_BUFFER`. It enables applications to perform direct I/O
> between GPU memory and NVMe via POSIX and io_uring APIs. This is
> particularly useful for LLM workloads, such as model loading, KV cache
> offloading, and checkpointing. The fgds device corresponds one-to-one with
> the PCIe GPU on the machine. The usage is straightforward: an application
> simply opens the corresponding fgds device, calls ioctl on the returned fd
> with REG_BUFFER, taking the target GPU memory buffer address (represented
> as a dma-buf fd), and the buffer length as inputs, and then invokes mmap on
> the fgds device fd, using the return value of ioctl as the input. The mmap
> call returns a CPU virtual address (call it cpu_vaddr). Afterward,
> cpu_vaddr can be passed directly to pread/pwrite, or
> io_uring_prep_read/io_uring_prep_write to perform direct I/O between files
> on NVMe and GPU memory. A minimal working example can be found in [2].
> The underlying mechanism is that, with the support of fgds device,
> cpu_vaddr is made to point directly to the GPU memory buffer corresponding
> to the dma-buf fd. This solution is loosely coupled with the GPU vendor's
> driver; the GPU vendor only needs to support exporting the allocated GPU
> memory buffer through the standard Linux kernel dma-buf framework, which
> the vast majority of mainstream GPUs already support. This allows both
> applications and the fgds device to work seamlessly with GPUs from
> different vendors without any modifications. Furthermore, applications no
> longer need to call vendor-specific proprietary APIs (such as NVIDIA's
> cuFile API) or install vendor-specific kernel modules (such as NVIDIA's
> nvidia-fs.ko) for different GPU vendors. We have tested fgds on GPU cards
> from NVIDIA, AMD, and several other vendors, and it works well.
> 
> Besides the benefits in ease of use and compatibility, another key
> advantage of this solution is higher performance. [2] presents the
> performance comparison results between fgds and NVIDIA GDS. Because fgds
> eliminates the overhead of phony buffers incurred by NVIDIA GDS, it
> achieves significantly higher performance. For example, for reads, fgds
> outperforms GDS by 11% to 109%; for writes, fgds outperforms GDS by 10%
> to 71%.
> 
> To further accelerate the read and write operations of large files or
> massive data volumes—which are very common in LLM scenarios—we have
> implemented library functions `fgds_read` and `fgds_write`. Under the hood,
> these interfaces split large data into chunks and submit them
> asynchronously and in parallel via io_uring, thereby further boosting I/O
> performance, with read performance improved by up to 115% and write
> performance by up to 40%. In addition, we also provide the `fgds_register`
> library interface to encapsulate the `open`, `ioctl' and `mmap` operations.
> Readers who are interested can refer to [2].
> 
> In addition, we have added the LMCache backend, enabling vLLM to offload KV
> cache via LMCache using fgds, which accelerates inference performance. We
> also added PyTorch APIs, compatible with the PyTorch GDS API, to improve
> the performance of reading and writing checkpoints during LLM training.
> 
> We look forward to community feedback and are fully committed to iterating
> on this series to work towards upstreaming.

That's not really needed in a changelog text, it could be in the 0/X
patch :)

Anyway, you didn't cc: the io_uring list, why?

Also, as a first cut, please see the sashiko comments on this patch:
	https://sashiko.dev/#/patchset/20260908131545.105987-1-liwang@kylinos.cn



> 
> [1] https://dl.acm.org/doi/10.1145/3712285.3759862
> [2] https://github.com/Storage-and-OS-for-AI/fgds
> 
> Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  drivers/misc/Kconfig      |   9 +
>  drivers/misc/Makefile     |   1 +
>  drivers/misc/fgds.c       | 989 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fgds.h |  54 +++
>  4 files changed, 1053 insertions(+)
>  create mode 100644 drivers/misc/fgds.c
>  create mode 100644 include/uapi/linux/fgds.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 7364931dad3a..2f3a5a5fd0bf 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -568,6 +568,15 @@ config MCHP_LAN966X_PCI
>  	    - lan966x-miim (MDIO_MSCC_MIIM)
>  	    - lan966x-switch (LAN966X_SWITCH)
>  
> +config FGDS
> +	tristate "GPU-NVMe direct I/O control driver"
> +	depends on PCI && DMA_SHARED_BUFFER && ZONE_DEVICE
> +	help
> +	  Say Y here if you want to support GPU-NVME direct I/O
> +	  via POSIX/io_uring interfaces.
> +
> +	  If unsure, say N.

Module name is not listed here.

Nor why "fgds" is the name, that's going to be hard to remember, does it
stand for something?


> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e8d8d5d88c0d..04985abe1678 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -71,3 +71,4 @@ obj-y				+= keba/
>  obj-y				+= amd-sbi/
>  obj-$(CONFIG_MISC_RP1)		+= rp1/
>  obj-$(CONFIG_INTEL_SSEI)	+= issei/
> +obj-$(CONFIG_FGDS)		+= fgds.o
> diff --git a/drivers/misc/fgds.c b/drivers/misc/fgds.c
> new file mode 100644
> index 000000000000..3aa4945f701b
> --- /dev/null
> +++ b/drivers/misc/fgds.c
> @@ -0,0 +1,989 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fast GPU Direct Storage via dma-buf.
> + *
> + * Copyright (C) 2026 KylinSoft. Co., Ltd. All rights reserved.
> + *
> + * Maps GPU memory into user space to enable direct NVME-to-GPU DMA
> + * pread/pwrite syscalls. BAR pages are remapped into ZONE_DEVICE via
> + * devm_memremap_pages() and populated using dma-buf backing pages.
> + */
> +#define pr_fmt(fmt) "fgds: " fmt

You are a driver, always use dev_*() print functions, not pr_()
functions, as you will loose the device information.  For example:

> +/*
> + * BAR-based mapping requires device physical addresses. When using
> + * IOMMU, DMA addresses are IOVAs, which cannot be mapped directly.
> + */
> +static int fgds_check_gpu_iommu(struct pci_dev *pdev)
> +{
> +	struct iommu_domain *domain;
> +
> +	domain = iommu_get_domain_for_dev(&pdev->dev);
> +	if (domain && domain->type != IOMMU_DOMAIN_IDENTITY) {
> +		pr_warn("%s: reject attaching a translating IOMMU domain (requires iommu=pt or off\n",
> +			dev_name(&pdev->dev));

Should be dev_warn(), right?

But what can userspace do with that warning, did something just break?

> +	pr_info("loaded successfully: %u GPU(s) active\n", fgds_dev_count);

When drivers work, they are quiet, please remove this, and the other
pr_info() lines, as they seem to be left over from your debugging.

thanks,

greg k-h
