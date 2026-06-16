Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34725CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8BE10E917;
	Tue, 16 Jun 2026 08:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="gD9tHv/L";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD3DD10E917
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:47:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so41235ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781599633; x=1782204433;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aaTfOOhj7DmWaDCSdXoWZe8eYeEqWjLH4eK4JZJxdgM=;
 b=gD9tHv/LgYYZIUIEdCI8D/WmUFQWdcVyWmoJv+j/+8O+tqSh77z6sFp+87bHYN2Sys
 Hlz3pmH388tPE4rq0ApuSlavj675RcZhRbTRhggOGlQ1NrF1bQcE/AnJqIf+LCyG8TA/
 D34OmKh7gmGYylwrOv75MMjnMN1Gcr0p+CpcxeeyEP+LJ0LbUovuR3g8P1HSCczp7O8C
 L9MH1ByKTtn1ppIshwUXfGft8pY/QN86bWSrsNKqzv8zDEWqye9Jb0Q45ZpDhal0Geok
 L74uTWqYCLKJkRdutovZ0UWuMD+lxniVFZa3ReTD2UNpiVDrJftdBh99aWm/SUafHkPt
 zdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599633; x=1782204433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaTfOOhj7DmWaDCSdXoWZe8eYeEqWjLH4eK4JZJxdgM=;
 b=L0aqThhem9dY5YJhMJh4/qzm7djVGBhqcAxfd3jRxoGDnwL48xhVDhcisHVd8WzqXj
 gXH3UWtFqSaFINLL1ABK/46hqbP1AHV+wNeNPKJ1H5zPjCqFYRCyLGk9Yjz8kwO+jGjj
 QNAedcgoCT5ZLNGMzYcwC5ewmMn5/yOdUxEdwMri/vPlCpK1Pf8GCO4zFDmLal7sbnbz
 UhGeZhSEHh3ehi2Y7OxfPialRkYXO2g0QGE2fBgXLj+pry3UKjTE6pHn3dGHI3s0Rvtq
 IVxbl8rkSFdfFccOerz6LwukJY6Yub6biSyWWiP9wc8zUMxiI1L+FretLXucroUvcuZt
 iOfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RbusWRSITcTzqNhH/M7vpYfovkWWBfYz4A8qL/5vdQRwzDh/vEKCPKBaED+x10LGsKMy3a1yykrg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyMsQIS3HR7qG2sZQegOXglpp7Vl55zRiYvQ5G86iXZMq2y989
 lDQ+8nTXTHvFi2URTTfoZTtBL7C3weLhhiOZmApFDO4Q9UjAKw4kF7QoCgpsx8Qm2w==
X-Gm-Gg: Acq92OEnaxtPWymXpRIqYdNQ7FdscxIRcbEe7NuoG/tb7t0jEX8iawvbEkOJCGWcJw4
 j/PNGYnBCJEmB2nXnGpZU5hreJVvyM8QTssh4gTMqunq7ctKU4P71Q6quc4t/rt5pc6+tG1zGV2
 VLS/qpRBDUyr27EuBb1CgLw8pEdAu26xW+lbBfECF8buEd5cxJo1qj5OCPdcEBciRT08BrRbv25
 xKE6JEQkw/SGrpsrIWes6Jxs30gL65zXgre+pwbNOXPr7HqOYvP76T89hrGTRHQqBV6Zw7LoKef
 NHn0c2Oo3lIyvgmvmOprHaH6YmdqRdf8StdXCZpeHZHyKkGzQLeFH93pY7I/IRN/ty5sCRcUt/F
 0FDHc3cRvbJUPbef7iDXaDSFizjQNx62myLbZu1edr+DgaaLV1P38Qv2SC1SmoCVqhtLYlXlka8
 RLdA/Ko++rtiYgGa2pLisMfnIU1kQ2q2p/KWhgSwK9XGd3rCZX04NbxblSKl/j
X-Received: by 2002:a17:903:3c4d:b0:2c1:ee6e:4e4c with SMTP id
 d9443c01a7336-2c69c30f5a8mr1709625ad.29.1781599632758; 
 Tue, 16 Jun 2026 01:47:12 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fbb50bfsm125397885ad.33.2026.06.16.01.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:47:12 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:47:04 +0000
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
Subject: Re: [PATCH v3 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Message-ID: <ajENiAQkzXjbxgRX@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-10-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-10-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:23PM +0100, Matt Evans wrote:
> A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
> set CPU-facing memory type attributes for a DMABUF exported from
> vfio-pci.  These are used for subsequent mmap()s of the buffer.
> 
> There are two attributes supported:
>  - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC
>  - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
>    PTEs for the DMABUF's BAR region.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  2 ++
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 57 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 14 ++++++++
>  include/uapi/linux/vfio.h          | 27 ++++++++++++++
>  4 files changed, 99 insertions(+), 1 deletion(-)
> 

> +int vfio_pci_core_feature_dma_buf_memattr(
> +	struct vfio_pci_core_device *vdev, u32 flags,
> +	struct vfio_device_feature_dma_buf_memattr __user *arg,
> +	size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_memattr db_attr;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!vdev->pci_ops || !vdev->pci_ops->get_dmabuf_phys)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz,
> +				 VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(db_attr));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&db_attr, arg, sizeof(db_attr)))
> +		return -EFAULT;
> +
> +	dmabuf = dma_buf_get(db_attr.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
> +	priv = dmabuf->priv;
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
> +	    READ_ONCE(priv->vdev) != vdev) {
> +		ret = -ENODEV;
> +		goto out_put_buf;
> +	}
> +
> +	switch (db_attr.memattr) {
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
> +		WRITE_ONCE(priv->memattr, db_attr.memattr);
> +		ret = 0;
> +		break;
> +
> +	default:
> +		ret = -ENOENT;

Nit: Looks like the agreement [1] was on -EOPNOTSUPP / -EINVAL but we 
took -ENOENT here and in the doc string? Was that intentional?

I tend to agree with Alex's suggestion here, we'd prefer one of those 
two (-EINVAL / -EOPNOTSUPP) since it clearly communicates to the user
that "You sent a wrong arg" or "We don't support this"

-ENOENT means no such file or directory [2] to the user. Users may not
be kernel engineers who'd wanna peek into the code and they may simply
look at the uAPI files which doesn't give them an answer as to what went
wrong.

> +	}
> +
>  out_put_buf:
>  	dma_buf_put(dmabuf);
>  

Apart from that, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

[1] https://lore.kernel.org/all/20260602131417.41366391@shazbot.org/
[2] https://elixir.bootlin.com/linux/v7.1-rc6/source/include/uapi/asm-generic/errno-base.h#L6
