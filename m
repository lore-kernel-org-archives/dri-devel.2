Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1DAC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 22:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3850B10F0D9;
	Thu, 30 Jul 2026 22:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="OJIpgDfj";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331C310F0D9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 22:55:34 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cacef7d299so22905ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1785452133; x=1786056933;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
 b=OJIpgDfjzGQQN1lQ+6QvMHjU1l0MFbIzRetgjRcR2rEWDVG5LQ7dPueFB2Z4vZobyh
 1grMX3yGWrot6TBzxi4o1/9ibXoWNemYB1RCcIlX1kKrK1CyRLNA9ikj6Bnt6j5frA7I
 A91RKvLTYTffi+6im/ZHcG9TAMvLSM+Y80v945cFHXAWzc/B6EUrfIz/zEokNByUdg1L
 P30NcfLTgltGss2rJTDepBr+yuvVnWYqSQESS8M+OLE7QEPsnFZxpIFaWPJ0ohL214Fo
 zLE6LWM8uNe1YRte/HBCYwE7oG05ho+0yfbm0huntajf0LSsDhefzBYW0W11hYXG1M4d
 ntMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785452133; x=1786056933;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JGa8csySGObADLk+2HBSpvepwrbFTkNknaylr539um4=;
 b=BULm6aUdcxuTnM2Juo+H2+pbdO1HMiB4HTTJrIcj9ZfDOe4q2+XLWsBy//dNabILd3
 j8ipg9bz1UaT+VaukICa/90JtkbiE6VpCqMZR0tGxEAw93B21kxX6XGwvp4R3utYZObz
 pSZVN/4pdvtyZAbTch1CGsMq8CRtdKChGyvnUnISidTRrQHCN6RroveJQDJn+R2E4WYk
 WvlZ34rwmRe1s+kZKGvxCWw/NGrddEXHrH+jq6VDEeF0M9/JjIMbqq9cWEb8tggaZKcx
 /Ye8Ir7aQpQ8jyko5JF3+9kJC6r1QdiOVtHM+rkdcjJBMqiEaRGZOB0Acbma1oDD27l+
 iNrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUJebFV3Q5Z14RteGmPT5wr4zv5XKI+cs41OScernE0Csz7MwQTzrPunkI++GjBNfKuTHq9SEYduI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwWYY9MxXPLtrNeAb3fQl9lsIR15Dns3yY7Ds1A6xuLFT6BO8O
 rLYVhBkK03YWuoJESu4QnqezOIe/afK6xs3FJkffZ47onW9VQyWxO4EBQEKRkx3vUg==
X-Gm-Gg: AR+sD11dGMizWCw7XpeHfIt2DpZOMD91+cHPCBU7Ew7zIB1RFLS3lAq06aoUBcPM9Wb
 wpVKURDg8whL/sUPJEfT3FnX0YTRZuSfXk7C/tXToXVliixoWN3AsmCuz4Y5AZ8PmJnPsjBlV6I
 PL+MeCepfC35la98IDKFIAteS6O2A0BxSON0OGA0Sr7LxMIoORSEp5cTM7sY/AQi+HtNRQq/FES
 lg9JlBhVrJOHTG8TPi98ZDFLCEOtUWIMaKAJmr1ElaNDz1b8U2Uu8cSoKp12M3LTQumcCnPolFM
 3r5Qp7axf98Ac7bmzrp9yjCMl8J0VngJIyL3RkTe1d7MAtFB/4fkHQvf3azC9yBF4NqqLtJRTBA
 Rm8+LpKV5Pg5W6OEnt+2lMznyFxbVDXQXJt8zsT9Dg7O6EvSL9wqvwNvtL/fD+XBduPbdoxiUl/
 xHstQ7J+B8IBUfy2UlnaLwwF4S8/wFcBa7hDqMHa9cCg054ceYrU3Rn74VTjmQqTIX40e1MlklS
 HR9AUzW9gGFGxT2yjDODAzTa2/n5lIdAv8sh18bjiZ4Fw==
X-Received: by 2002:a17:902:f541:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2d04113beb1mr4399455ad.4.1785452132956; 
 Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com.
 [34.124.168.21]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504d2ec2asm29148088eec.21.2026.07.30.15.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 15:55:32 -0700 (PDT)
Date: Thu, 30 Jul 2026 22:55:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Kevin Tian <kevin.tian@intel.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/9] vfio/pci: Add a helper to look up PFNs for DMABUFs
Message-ID: <amvWXNRtviKEuUoV@google.com>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-4-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715174737.15287-4-matt@ozlabs.org>
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

On Wed, Jul 15, 2026 at 06:47:26PM +0100, Matt Evans wrote:
> Add vfio_pci_dma_buf_find_pfn(), which a VMA fault handler can use to
> find a PFN.
> 
> This supports multi-range DMABUFs, which typically would be used to
> represent scattered spans but might even represent overlapping or
> aliasing spans of PFNs.
> 
> Because this is intended to be used in vfio_pci_core.c, we also need
> to expose the struct vfio_pci_dma_buf in the vfio_pci_priv.h header.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 153 ++++++++++++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_priv.h   |  20 ++++
>  2 files changed, 160 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index c16f460c01d6..7c047400dfd1 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -9,19 +9,6 @@
>  
>  MODULE_IMPORT_NS("DMA_BUF");
>  
> -struct vfio_pci_dma_buf {
> -	struct dma_buf *dmabuf;
> -	struct vfio_pci_core_device *vdev;
> -	struct list_head dmabufs_elm;
> -	size_t size;
> -	struct phys_vec *phys_vec;
> -	struct p2pdma_provider *provider;
> -	u32 nr_ranges;
> -	struct kref kref;
> -	struct completion comp;
> -	u8 revoked : 1;
> -};
> -
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
>  				   struct dma_buf_attachment *attachment)
>  {
> @@ -106,6 +93,146 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.release = vfio_pci_dma_buf_release,
>  };
>  
> +int vfio_pci_dma_buf_find_pfn(struct vfio_pci_dma_buf *priv,
> +			      struct vm_area_struct *vma,
> +			      unsigned long fault_addr,
> +			      unsigned int order,
> +			      unsigned long *out_pfn)
> +{
> +	/*
> +	 * Given a VMA (start, end, pgoffs) and a fault address,
> +	 * search the corresponding DMABUF's phys_vec[] to find the
> +	 * range representing the address's offset into the VMA, and
> +	 * its PFN.
> +	 *
> +	 * The phys_vec[] ranges represent contiguous spans of VAs
> +	 * upwards from the buffer offset 0; the actual PFNs might be
> +	 * in any order, overlap/alias, etc.  Calculate an offset of
> +	 * the desired page given VMA start/pgoff and address, then
> +	 * search upwards from 0 to find which span contains it.
> +	 *
> +	 * On success, a valid PFN for a page sized by 'order' is
> +	 * returned into out_pfn.
> +	 *
> +	 * Failure occurs if:
> +	 * - A hugepage would cross the edge of the VMA,
> +	 * - A hugepage isn't entirely contained within a range
> +	 *   (including where it straddles the boundary between
> +	 *   ranges),
> +	 * - We find a range, but the final PFN isn't aligned to the
> +	 *   requested order.
> +	 *
> +	 * Upon failure, -EAGAIN is returned and the caller is
> +	 * expected to try again with a smaller order, which will
> +	 * eventually succeed (order=0 will always work).
> +	 *
> +	 * It's suboptimal if DMABUFs are created with neighbouring
> +	 * ranges that are physically contiguous, since hugepages
> +	 * can't straddle range boundaries.  (The construction of the
> +	 * ranges should merge them in this case.)
> +	 *
> +	 * Finally, vma_pgoff_adjust is used with a DMABUF created for
> +	 * a VFIO BAR mmap: a BAR mapped with vm_pgoff > 0 creates a
> +	 * DMABUF such that byte 0 of the VMA corresponds to byte 0 of
> +	 * the DMABUF and byte 'vm_pgoff << PAGE_SHIFT' into the BAR.
> +	 * To avoid double-offsetting in this scenario, subtracting
> +	 * vma_pgoff_adjust from this (non-zero) vm_pgoff generates
> +	 * the effective offset.
> +	 */
> +
> +	const unsigned long pagesize = PAGE_SIZE << order;
> +	unsigned long vma_off = ((vma->vm_pgoff - priv->vma_pgoff_adjust) <<
> +				 PAGE_SHIFT) & VFIO_PCI_OFFSET_MASK;

Maybe I'm getting ahead of myself here.. but it seems like this
restricts us to only mapping DMABUFs at offsets < 1TB due to the 
VFIO_PCI_OFFSET_MASK (since we have HBMs on PCI devices now, hitting 1TB
may not be a very distant future).

While I understand this mask is needed to drop the BAR encoding in the
high bits. 

My worry is, if in the future a user were to export a massive
contiguous DMABUF (e.g., >1TB of aggregated HBM) and tried to mmap deep
into it (passing an offset >= 1TB), this bitwise AND would silently drop
the high bits, leading to silent data corruption.

I think we should explicitly reject such an mmap with -EINVAL like:

+const unsigned long pagesize = PAGE_SIZE << order;
+unsigned long vma_off = (vma->vm_pgoff - priv->vma_pgoff_adjust) << PAGE_SHIFT;

+/*
+ * Prevent silent wrap-around if the user mmaps a DMABUF at an
+ * offset greater than the VFIO index mask allows.
+ */
+if (unlikely(vma_off > VFIO_PCI_OFFSET_MASK))
+    return -EINVAL;

+vma_off &= VFIO_PCI_OFFSET_MASK;

> +	unsigned long rounded_page_addr = ALIGN_DOWN(fault_addr, pagesize);
> +	unsigned long rounded_page_end = rounded_page_addr + pagesize;
> +	unsigned long fault_offset;
> +	unsigned long fault_offset_end;
> +	unsigned long range_start_offset = 0;
> +	unsigned int i;
> +	int ret;
> +


Thanks,
Praan
