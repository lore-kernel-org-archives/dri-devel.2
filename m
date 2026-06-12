Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED601CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C9710E2F5;
	Fri, 12 Jun 2026 14:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ty4h82a5";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B8110E2F5
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 14:06:24 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so119895ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781273184; x=1781877984;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7gWNes2hHFmdqgzisSBTrBhiO7t0Lprwi8AqbjigE24=;
 b=ty4h82a5oh9U/SdsvRKcrptjaSTVeYrKj30CNbGU1Lv7VfOYqjf7hz4FEKz9WPSonu
 /4PZeJ1DPn1L61o8mF3LdM5+jsqe7ccyG4DNQzP2rCpq4fXBaSMWpgr5wUG1JMQYj+UP
 9vVlPyh1hEFff9ooGa0VhrBPb/GTIRlIWFdUhJvukWnSM4WQY9WZkNE0+LapOGQTBcwZ
 wISe1DveLPbqeQsBqmEUzs+IFqZNqCq52Fu9ZTUy6/DTcSSCCLIfhIuMEjo2NPyFhxTB
 4KrfcGWpaQkU9lQYVbolZBHZml9Y8hDfq3nzzoI4WD3zcwG3b5ccl/KTtJUzkMVmyWc1
 xNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273184; x=1781877984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gWNes2hHFmdqgzisSBTrBhiO7t0Lprwi8AqbjigE24=;
 b=RnDxs1+4cVFfzciG9unUnmca3RwMOzQRF4bIce3iqAeXTqkr1rMIbwBfuVf7Q27nPX
 Gs7DP4xwQ0BMUmoiyMY2p8W7uwADB5dqvfp1Lq/yQOhTrXvM756OYTGvevSdtrt1wJjW
 NanP3C9QFx7ra/gEVgl8ia+KjeeXCERTOSq24DimHAJMdZ+QsH/nW2Y6lwy7obtFHA3b
 Ufrw6bdzA9f7rXlsuJRJVBRmDZrBw404Q9aiE770IgWd4wspyL1gH5FSOf1JWtA4GQEy
 qUkqAJoiHNyIO5zMG/G7saJD2UZaQVdOZAulUieWIGTxZ1kLwl0z8xuIA0BN0F56nUUb
 aD7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bScy5WbAsk/hsf88Qs1CFm8bhNRoD0lMbCXwTPrymwBPY/rwd7ZcrwNYNRv/n/hvvUCBfjiwKuaI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxefUg01LHLGlf6WMLl7aLzwXrmeRX9ys+fxHjmX+zXaFTOOgqS
 4M3ZEeyE44jVz0vBMnY9iN7FOlm7tfDlwpgfeqzETVUC+gTyE0bK7DJnHc5NhUNAsg==
X-Gm-Gg: Acq92OGbr2+cw5ImmXUGfFmvcNPc6ex1iwhJUDl9lY8WjmKtlOXnmWQ/L0ee0UdjoaO
 99ORMQpVyysp6HHw9yz85dbT1Pb9IsJp2CFoeHgIdJ4djRx7yvLT7bknkh5XkAHjB/8tjkf/mgM
 mQFfu8RnNoJA6kaGcbobVBoQ0q9y++lwXaeQZEMMirUPIr5E8LuNsxt17bzJzlio40+GbNImyT9
 9xjFq+7h6TBsx72D/mM/df9KkP4/6GH2BXQZa+TkKBjASWOZLdCptIOmzhh20devean47yezUh2
 AiTfMQNg1SyNJ4KDQUBrbEoajyajckNKf+SqZtbU/4muIe207DkwKJmi/fDi/n04ekM/IWCel6X
 AbpJa+wgzZnopEvHMD0BA5LuNw/cYsERilERMYn7f825O5JqsIKGGgaM2YppL5u5kUKItCaN7f+
 tERbWNVlgCaxzzGgtT4t4aOuGdkYaTjnILmtkJWUz7FsAtWKI7pQhVniYbrSLigVbY/nrMZc8=
X-Received: by 2002:a17:903:46c6:b0:2bd:6dad:3df9 with SMTP id
 d9443c01a7336-2c405f85829mr1700165ad.23.1781273183096; 
 Fri, 12 Jun 2026 07:06:23 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37a25ecd5dcsm2325236a91.9.2026.06.12.07.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:06:22 -0700 (PDT)
Date: Fri, 12 Jun 2026 14:06:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Matt Evans <matt@ozlabs.org>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Kevin Tian <kevin.tian@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 5/9] vfio/pci: Provide a user-facing name for BAR
 mappings
Message-ID: <aiwSVk4n9mCQEln2@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-6-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-6-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:19PM +0100, Matt Evans wrote:
> Since converting BAR mmap()s to using DMABUFs, we lose the original
> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
> 
> This applies only to BAR mappings via the VFIO device fd, as
> explicitly-exported DMABUFs are named by userspace via the
> DMA_BUF_SET_NAME ioctl.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 2fd3629789bf..8f7f1b909b94 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -4,6 +4,7 @@
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/pci-p2pdma.h>
>  #include <linux/dma-resv.h>
> +#include <uapi/linux/dma-buf.h>
>  
>  #include "vfio_pci_priv.h"
>  
> @@ -470,6 +471,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  {
>  	struct vfio_pci_dma_buf *priv;
>  	unsigned long vma_pgoff = vma->vm_pgoff & (VFIO_PCI_OFFSET_MASK >> PAGE_SHIFT);
> +	char *bufname;
>  	int ret;
>  
>  	priv = kzalloc_obj(*priv);
> @@ -482,6 +484,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  		goto err_free_priv;
>  	}
>  
> +	bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
> +	if (!bufname) {
> +		ret = -ENOMEM;
> +		goto err_free_phys;
> +	}
> +
> +	/*
> +	 * Maximum size of the friendly debug name is
> +	 * vfio1234567890:ffff:ff:3f.7/5 = 30, which fits within
> +	 * DMA_BUF_NAME_LEN.
> +	 */
> +	snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
> +		 dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
> +

Nit: Could we instead use:

	bufname = kasprintf(GFP_KERNEL, "%s:%s/%x",
	                    dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
	if (!bufname)
	    ret = -ENOMEM;
	    [...]

>  	/*
>  	 * The DMABUF begins from the mmap()'s BAR offset, i.e. the
>  	 * start of the VMA corresponds to byte 0 of the DMABUF and
> @@ -500,7 +516,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	priv->provider = pcim_p2pdma_provider(vdev->pdev, res_index);
>  	if (!priv->provider) {
>  		ret = -EINVAL;
> -		goto err_free_phys;
> +		goto err_free_name;
>  	}
>  
>  	priv->phys_vec[0].paddr = phys_start + ((u64)vma_pgoff << PAGE_SHIFT);
> @@ -508,7 +524,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  
>  	ret = vfio_pci_dmabuf_export(vdev, priv, O_CLOEXEC | O_RDWR);
>  	if (ret)
> -		goto err_free_phys;
> +		goto err_free_name;
>  
>  	/*
>  	 * Ownership of the DMABUF file transfers to the VMA so that
> @@ -523,8 +539,15 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>  	vma->vm_file = priv->dmabuf->file;
>  	vma->vm_private_data = priv;
>  
> +	spin_lock(&priv->dmabuf->name_lock);
> +	kfree(priv->dmabuf->name);
> +	priv->dmabuf->name = bufname;
> +	spin_unlock(&priv->dmabuf->name_lock);
> +
>  	return 0;
>  
> +err_free_name:
> +	kfree(bufname);
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:

Apart from that,

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
