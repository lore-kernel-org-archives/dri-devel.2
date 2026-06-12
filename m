Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F3CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E1C10F669;
	Fri, 12 Jun 2026 19:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="WjgC/D0k";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6D010F669
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 19:43:46 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf2d865383so235ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781293426; x=1781898226;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kmA9t8+wOUfRjPLThtQlARMdWkr4H2MHT+OyHJTFhU8=;
 b=WjgC/D0kfaW853mkmAaMADCtnc4xNOhsMO66aL8EBa9sP31tJhe5emENRSsHeP67J6
 WLITKYMr9O9xf/9tJmJc85Va+OMG6ui4P/yLlMv4zug3Abm56pCKSNN2aW8Xb+nVE0XI
 ffpKBhx/G1ERD63vtDb6GqLcOlFy12Ghd3Zgr5QqD41AwoQ41ph/nDykBfjkJR3zXhZ4
 LpYRZZKJ3ovZVxVvNGamByV4HUbG5UDYcwvkXP0sbYGXku55cs+f953zHsaWJhAs4w5s
 qogTuOKKnEPiK7zJEIf0akieeMl22nmg7nwdFJ85uUnsUoeZwJaKumTACzuwebcq+7X4
 Po1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781293426; x=1781898226;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmA9t8+wOUfRjPLThtQlARMdWkr4H2MHT+OyHJTFhU8=;
 b=gj6TxfpaGCL4QGStQP1clahRXk7TX0y+ArRoiH/tk7TE3euNRoRasBMEV0IKRIRwiE
 255fj3SuBKRPdQRNChF0eCEzIALvHaMdvAuYWBxh/EYDsInG+najNtI8kteNJPcTXkmv
 V0sCRdb1CeWzuOp8UblazocZRpVJC1xxaEdeVVOGvapizPWsppPp6SRlcECtHVUDGL52
 6fckcDVV4LixQxUvPiz2dNWX2+hMOl6S8UgH82ZSokNcPim/4U31TVYcrDmoGswk6EJi
 t8xnIjdY/LEvN7eJBtY+mDt4IcVvbf1c0/lnzpYH84zvChxk5gxc4aaudkCoTmjSgcuK
 TaTQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hGqTKyvH3uMIErur2+mhZSdU0QKtLkkGEiFj+Wz70uHfvG0PiIkrLD/Ptu1LaMtgyQiFAl8ZLpzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2XjIEtlswx+Y0ifIsXi4/Zv84JbQqJMYkJJqQYao/ohfltLvJ
 e5ZJGdNjfwAO0pLDqYbh+UqEdg0KhXYHeRGphFan+RSU5ydYlUZrycAs1Cln1aNn0A==
X-Gm-Gg: Acq92OE4VO1pjkOq+m4BOAIY2TQTAdxL4jajb3KxRN6lTo1N8HWk32TSz5P4zvCeOIE
 aZeg57O2NRAsYHD4cAgxODyH7Ko/9NBEpbTCjaGxSigkAdtXKJnZ5pHVQ46nmo5vB8JfDv8h1mb
 alq1bq54idWesHWvDr85QHhh+L4qNWJBK6ZrS+UIBDJ5slm8w04YFUY+HQtNIpLyTLG5OqO8dlx
 AqRkc6jWLFkLgj6Tj4styPH0/MKfG18YlFxYKcEKTT3JrgJnZoEwXAznp91Qog3kY5qxNT0qlXi
 YZRonHIzw5jid68Si6USNEXb2PlTwlJlodEaaYRU8tW45IW9+QbUyz2iNFpYBQeKpWjc4gaDf2L
 oT79ayJD/0SX142P+mhZUGQwi28QP9G1o/dvS2KUaN6ATQBhjcIlpaaYQ8QTq2JzaV+4Rsi+C1T
 LPBFc+vg8oMRkS80CBssL/Q0ObQfi3nfFehRMPeYzPhfV2Yy/gjm++0WUD+vGU
X-Received: by 2002:a17:903:37c8:b0:2b7:b03d:9dce with SMTP id
 d9443c01a7336-2c6650d52a7mr471235ad.18.1781293425288; 
 Fri, 12 Jun 2026 12:43:45 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86651aef27sm2802598a12.30.2026.06.12.12.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 12:43:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:43:36 +0000
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
Subject: Re: [PATCH v3 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Message-ID: <aixhaJoPQrNjhLwD@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-5-matt@ozlabs.org>
 <aiviYEi17tewEQg0@google.com>
 <42cf4ad9-f094-4f94-88e6-6d2cb6eb6437@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42cf4ad9-f094-4f94-88e6-6d2cb6eb6437@ozlabs.org>
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

On Fri, Jun 12, 2026 at 04:22:12PM +0100, Matt Evans wrote:
> Hi Pranjal,
> 
> On 12/06/2026 11:41, Pranjal Shrivastava wrote:
> > On Wed, Jun 10, 2026 at 04:43:18PM +0100, Matt Evans wrote:
> >> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> >> the BAR mapping, and make the VMA fault handler look up PFNs from the
> >> corresponding DMABUF.  This supports future code mmap()ing BAR
> >> DMABUFs, and iommufd work to support Type1 P2P.
> >>
> >> First, vfio_pci_core_mmap() uses the new
> >> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> >> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> >> callback is updated to understand revoked buffers, and uses the new
> >> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> >> fault address.
> >>
> >> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> >> zaps PTEs (used on the revocation and cleanup paths).
> >>
> >> CONFIG_VFIO_PCI_CORE now unconditionally depends on
> >> CONFIG_DMA_SHARED_BUFFER and CONFIG_PCI_P2PDMA_CORE.  The
> >> CONFIG_VFIO_PCI_DMABUF feature conditionally includes support for
> >> VFIO_DEVICE_FEATURE_DMA_BUF, depending on the availability of
> >> CONFIG_PCI_P2PDMA.
> >>
> >> Signed-off-by: Matt Evans <matt@ozlabs.org>
> >> ---
> >>  drivers/vfio/pci/Kconfig           |  5 +-
> >>  drivers/vfio/pci/Makefile          |  3 +-
> >>  drivers/vfio/pci/vfio_pci_core.c   | 75 +++++++++++++++++++-----------
> >>  drivers/vfio/pci/vfio_pci_dmabuf.c | 12 +++++
> >>  drivers/vfio/pci/vfio_pci_priv.h   | 11 +----
> >>  5 files changed, 67 insertions(+), 39 deletions(-)

Hi Matt,

[...]  
> >>  int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
> >>  				   struct vm_area_struct *vma,
> >> @@ -532,6 +538,10 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >>  	struct vfio_pci_dma_buf *tmp;
> >>  
> >>  	lockdep_assert_held_write(&vdev->memory_lock);
> >> +	/*
> >> +	 * Holding memory_lock ensures a racing VMA fault observes
> >> +	 * priv->revoked properly.
> >> +	 */
> > 
> > Nit: This comment should appear before the lockdep_assert_held_write()
> > Also, it is slightly verbose.. (not against it though).
> 
> Right, I'll move it.  Agree it's wordy but if anyone changes that I want
> them to "think faulthandler".
> 

That's fair I guess.

> >>  	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
> >>  		if (!get_file_active(&priv->dmabuf->file))
> >> @@ -549,6 +559,8 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >>  			if (revoked) {
> >>  				kref_put(&priv->kref, vfio_pci_dma_buf_done);
> >>  				wait_for_completion(&priv->comp);
> >> +				unmap_mapping_range(priv->dmabuf->file->f_mapping,
> >> +						    0, priv->size, 1);
> > 
> > Have we run this series with lockdep enabled?
> > I guess it'd be nice to check with lockdep once..
> 
> I've (generally) always run testing of this series with lockdep.  (No
> issues (anymore).)

That sounds good! Thanks for confirming! :)

Praan
