Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8CCD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F3210E9D5;
	Fri, 12 Jun 2026 09:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="sExaVeKu";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4210D10F3B5
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:20:10 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2bf2d865383so61475ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781256010; x=1781860810;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zvPmlCR2+M8z2It1PyWjRPyBRhJXBH/RxmRhWYVyMeM=;
 b=sExaVeKun8VHdqelA/9YQnoOM/Iv1WeQE5EBM2MChFQEi5OyYopEBeEjfiqRCo54pg
 ylVzrNCtZ3McNBaXTDnqp0vJQnM9MbdtTU0V2b4PDOj+MTxc9kM0LXjUl+qq/FBtq3Wu
 BAnRisYTtQSJ0B/XVkkK5Ntg5EA4LL7oU6n/1FYBvljo71Z+OkTzVK7gIYL85nGHcEoe
 ISDuigW7ZlBFoDXxDBwsg0nIEWwgKAps0N83mMUkuh9LNcCTgm/HUm9lWN7Y4+2UnG9J
 D4Cl1gcL72WxaKxHP2LzZAABHuxd2xNjUP3xt1JzPNhiC3aXS+n2gnd0GyRMQwuuw0T2
 prgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781256010; x=1781860810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvPmlCR2+M8z2It1PyWjRPyBRhJXBH/RxmRhWYVyMeM=;
 b=KhQN0d8LKrvHOCdv2WDXIj3B4CAwZZ8MTboOPjYdTvLywXf/+wI+bv3VR1xlra4MZ2
 RlcWn+bPb9dpT99NBYyjZy0sBuNScrlLi9zls1ahxIbfi0YNknGZEIg4PzGix3n1qzG0
 mHQf9nQXIc+saz1h3JBbkkOJhhH6vR24VrN0xjBvDTc+h+TGOsW8/rWhXk6FuCZGelTb
 ty9r9GCI12AXH8lpScjjOCHCpBsUjjQB5peSSn9sVFu4jNwXnHInSzi0w/6hx5tdK32Y
 eDXwyuLQLgZUj1WmnbSNjs/R4XvCeWvIpoxPxXqtbzBPnGNF7EXXUQD82kJq2Bv7S+SJ
 L2AQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8pRtQtB2avgIiNKa1Gtvtv8oemIs2WWrSAN5ps69jRQitrExf1bD+DRPK8aNRl1j51srn6PaR42Ro=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvH6Dv5QNJvpQRxhkw1pOL07lTxARlDmI4Ci8EvPdJNVuZblW7
 /VxBM2u+qk5E+VjqU80xTw/s3sVsXH5h0gWmKCIY+I5/wXVv3R8vzANqHOuHNwZrOQ==
X-Gm-Gg: Acq92OEa729JxNB123YZxJvhOP9rGT8DcRnF7VOTz/n+LlV94oFj0GuWIg3oWw9pwV6
 O4d3VqlBOJp3/GLTdN/uDlA9fgoAsN+La25PqE/mioGITi8H8/toG+bVplfvlzVlVs/my6hqlz3
 vsQ+0pDKOn4B81Nm+eOfP51Y+XreYZiS5MPFBTYNqDnJAijjD70kf/HmqDmFP6ZrCaGFVVLjmMc
 KR497QQjWtuqPN91HCe/V3sC9t8WqxfLd4944aGvALMl7nJBAm3TwV8Z86xLGLhKCLmlR6CK4dl
 GWqOAnc0mIv1C1j5aN+GhIm4j+EbTmYlrwYO0tk7B/Enxbw7fco1CMcgH/hTCXiVYAeM6UZJvVh
 zvUqkm9VTcWrM3L0DzRzU7zkO9v6uQB1ZEvdKbpiELaMHzXmuxcozZkD1IseTqWVOb+k2tPMhsz
 hTflC7KU2wZVed/oE5nFjeg/tr7m948jQUf3SukbuEbQT57DxUxTfdsXCEupBz+XOM47xcjps=
X-Received: by 2002:a17:902:e811:b0:2bf:139c:dcf3 with SMTP id
 d9443c01a7336-2c405c8817fmr1345405ad.19.1781256009183; 
 Fri, 12 Jun 2026 02:20:09 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434afd17f5sm1476657b3a.39.2026.06.12.02.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:20:08 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:20:01 +0000
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
Subject: Re: [PATCH v3 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Message-ID: <aivPQcSlolwptnB6@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-4-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-4-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:17PM +0100, Matt Evans wrote:
> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> commit by VFIO's ordinary mmap() path.
> 
> This function transfers ownership of the VFIO device fd to the
> DMABUF, which fput()s when it's released.
> 
> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> this new VFIO_BAR mmap().
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 142 +++++++++++++++++++++++------
>  drivers/vfio/pci/vfio_pci_priv.h   |   5 +
>  2 files changed, 117 insertions(+), 30 deletions(-)
>

[...]

> +
> +	/*
> +	 * Ownership of the DMABUF file transfers to the VMA so that
> +	 * other users can locate the DMABUF via a VA.  Ownership of
> +	 * the original VFIO device file being mmap()ed transfers to
> +	 * priv, and is put when the DMABUF is released.  This
> +	 * intentionally does not use get_file()/vma_set_file()
> +	 * because the references are already held, and ownership
> +	 * moves.
> +	 */
> +	priv->vfile = vma->vm_file;
> +	vma->vm_file = priv->dmabuf->file;
> +	vma->vm_private_data = priv;

I appreciate this comment. Thanks for being clear!

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
