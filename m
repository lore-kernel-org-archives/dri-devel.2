Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6652ACD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD4E489316;
	Tue, 16 Jun 2026 19:09:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="o/+z229+";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38C0789316
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 19:09:26 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2c6b7bd4e8dso12175ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781636966; x=1782241766;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6SDrg2Xo/OAI2rZzS8e85po51TqWl/TutJV9Vm/kvs=;
 b=o/+z229+h8p79RiIs7IDI2mhGPTctfZ1jeFmqtVGrmvK7L6JpB1P0DltaagV/FWiCK
 lAaVj8qSUDRO2ud6whnHxLZKtlylC43qGxjbcOEmozJuOIfKevJ5hMCiwyhOdecMkjcV
 3OgZM6fTXcnmp0HWSXKQdZYc0yMBVPoieLpzwVHiJZpQZosfVHtDaRJmeAAuCQ6ncqpM
 eqq2Lnl2Lagl+qb3RoIWM2nIZeCMlxAeaL+IS5U1F+spAFs2uQ0Pe2T7EDwuiBLxaqIo
 eub/pOVMKU4F7AMVCrom6H2BGwBCrwQBWPSZuRIS1e4xFU5T6FLA573f96kufzkJ6ppn
 VvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636966; x=1782241766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6SDrg2Xo/OAI2rZzS8e85po51TqWl/TutJV9Vm/kvs=;
 b=To3f6jeZkfsmWufxAMyRGb821rxZ7uBigAXkUfcJI/Id1lwOBjKOcnNwwxCnXVDB0w
 /bdZJ8AOCwq2/5Y4pSGG1490LeNvixV8eJuQ5c46NbdxcYRdIjRkadtezGmJFcP00X0e
 hSDdn7twc7acUn3TxHFezWMC49Q2gjpaYLDPVD1oXifRpjA8rQtjWQdDV0KlrBWVAYZv
 znYtWX59ADn9qJscdBYDymJatZByRcqpJSblNnsbTyV0hkojYpDgghUCWV1gmsKb2qz8
 Sy+j/EA86OFj8gUFFDviFNgU4dZHIhlVRkvYWkJue8fcakW8DXiHRuEn2ldZ6CVi35L2
 sasw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Eyj4a/KjgvHHKj9PPX7vajAf9ZbQWic0qWscnlNOfh9x7sSFItxGcytmJECmZmeH9YaVFSPI/KWU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1th3aYN715OJtbTuLc9CCIodPRpxWGfzPsQsGeFZgFYyeEX15
 tVoQhpM6TmzV7/rnsKjlHBLgSY3X0HuTpc2gE5JGFS6sVtJHGAmDtJyUmk0hdts67Q==
X-Gm-Gg: AfdE7clKNVMav8FlnMWKqye+JlXpTJpRA6PSYE0m/D/LqmBCt8FrFSxfJGpqDlb4OjO
 8aPCbGx5sQeZN2mlHMBKvFwJolKMDgVqtIqZG3qruGROy1hFetB+lNq7ODP+tTKVP+pclQ5SCv9
 Fwe9m++vCr7Eyf6YZfDmSxCmMha/g2LJkwt5NUb1n9XHfl2zS+4+JliJuE9UIQseaxYmj2PJNa1
 PBDwY71v2IFlnm2xuH8kHpsL3K8n3XHJcdVVR6bAiMWNr0IEuIykIjJnK5yVmDIM/agHjoY3Nh+
 +z8lr9GwKY+V7EUuH/I88bPRq3m1m767FfUdwwfr9RWIrOc9aY/NCS02MVL+DjZw6NUmztYSHAl
 zPdR7fXmyqN0aruTtA2YZiYJlNsHFdR5YVDoRKJ090P+0sVMSDimKZkgKwGh99wKnIJkr+gKrj+
 zJdxs22ixbok6zWlA8ZmwyDR0jLgqvxto/znIctjKGGWcAFFFDyT4jmL8TaN7O
X-Received: by 2002:a17:903:19c5:b0:2c1:ee6e:4e4b with SMTP id
 d9443c01a7336-2c6bbb02f17mr305125ad.28.1781636965196; 
 Tue, 16 Jun 2026 12:09:25 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f7c5535sm141034955ad.18.2026.06.16.12.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:09:24 -0700 (PDT)
Date: Tue, 16 Jun 2026 19:09:16 +0000
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
Message-ID: <ajGfXNavEPOuU_4L@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-10-matt@ozlabs.org>
 <ajENiAQkzXjbxgRX@google.com>
 <c4a6e367-2f22-4cbf-afcb-674f82fdacd2@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a6e367-2f22-4cbf-afcb-674f82fdacd2@ozlabs.org>
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

On Tue, Jun 16, 2026 at 12:37:29PM +0100, Matt Evans wrote:
> Hi Praan,
> 
> On 16/06/2026 09:47, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 04:43:23PM +0100, Matt Evans wrote:
> >> A new VFIO feature, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR, is added to
> >> set CPU-facing memory type attributes for a DMABUF exported from
> >> vfio-pci.  These are used for subsequent mmap()s of the buffer.
> >>
> >> There are two attributes supported:
> >>  - The default, VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC
> >>  - VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC, which results in WC
> >>    PTEs for the DMABUF's BAR region.
> >>
> >> Signed-off-by: Matt Evans <matt@ozlabs.org>
> >> ---
> >>  drivers/vfio/pci/vfio_pci_core.c   |  2 ++
> >>  drivers/vfio/pci/vfio_pci_dmabuf.c | 57 +++++++++++++++++++++++++++++-
> >>  drivers/vfio/pci/vfio_pci_priv.h   | 14 ++++++++
> >>  include/uapi/linux/vfio.h          | 27 ++++++++++++++
> >>  4 files changed, 99 insertions(+), 1 deletion(-)
> >>
> > 

[...]

> >> +
> >> +	/* Verify DMABUF: see comments in vfio_pci_dma_buf_revoke() */
> >> +	priv = dmabuf->priv;
> >> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops ||
> >> +	    READ_ONCE(priv->vdev) != vdev) {
> >> +		ret = -ENODEV;
> >> +		goto out_put_buf;
> >> +	}
> >> +
> >> +	switch (db_attr.memattr) {
> >> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_NC:
> >> +	case VFIO_DEVICE_FEATURE_DMA_BUF_MEMATTR_WC:
> >> +		WRITE_ONCE(priv->memattr, db_attr.memattr);
> >> +		ret = 0;
> >> +		break;
> >> +
> >> +	default:
> >> +		ret = -ENOENT;
> > 
> > Nit: Looks like the agreement [1] was on -EOPNOTSUPP / -EINVAL but we 
> > took -ENOENT here and in the doc string? Was that intentional?
> > 
> > I tend to agree with Alex's suggestion here, we'd prefer one of those 
> > two (-EINVAL / -EOPNOTSUPP) since it clearly communicates to the user
> > that "You sent a wrong arg" or "We don't support this"
> > 
> 
> Yes, it was intentional.  This was noted in the v3 changelog entry in
> the cover letter:
> 
>  - Removed GET on vfio_pci_core_feature_dma_buf_memattr(), removed
>    unnecessary taking of memory_lock, fixed error return values.  In
>    particular, removes ENOTSUPP, and uses ENOENT to indicate an
>    unknown attribute enum value was passed to SET.  In the discussion
>    here,
>    https://lore.kernel.org/all/20260602131417.41366391@shazbot.org/
>    we'd agreed on EOPNOTSUPP before I realised that's already used
>    elsewhere.  ENOENT uniquely indicates an unknown attribute.
> 

Ahh okay. I missed the changelogs in the cover letter.

> EINVAL/EOPNOTSUPP would indeed be semantically perfect, but after
> posting my reply there I remembered they are already overloaded with a
> load of different meanings.
> 
> I think uniqueness is important here so that memattr issues (for example
> any future arch-specific porting issues) show up as an
> immediately-understandable error value.
> 
> > -ENOENT means no such file or directory [2] to the user. Users may not
> > be kernel engineers who'd wanna peek into the code and they may simply
> > look at the uAPI files which doesn't give them an answer as to what
> > went wrong.
> 
> But surely when they look at the uAPI header they will then see
> "*  ENOENT: The given memattr is not supported." and understand what
> went wrong.

Fair enough. Since its documented it clearly in the uAPI header.

Thanks,
Praan
