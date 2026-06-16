Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD7CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106A710E88E;
	Tue, 16 Jun 2026 08:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="G9n+55Eb";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF59B10E8AD
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:05:51 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2bf2d865383so28965ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781597151; x=1782201951;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dOsiBDHauJNUL/mHLBlXDW8Xe2gvOcwU/fMCh1N6uL8=;
 b=G9n+55EbQkE+aKYZ09FIgtPWeceJ5f/AJyeVid4HrkmbdTqyr7hiLJcgmeFz2RoKCC
 xBA7ise21QufBR8AOo8j+VZaESQQgOS5650nS6+wHwjELIw2jQrJDP1BT02t3noz57vj
 XACqn797Labmb08jbRiqnFVu6a/8CWfk/SYzEHTQKljNZbBnpxW7G7oqREfKqk37+PCf
 sX+5RiDi9epWg86x6V8jKDi+vbtxzS+OqACVW+1jXQRX2XZ/9AXxAfrmvUq5i6HRpC+o
 nrJ6IZQ5S6Vpn1E8M41G0EpQsBLZlC4gYdmDcqbcpibiJ+xVJtJcKZ2ag+qpoVMPOviY
 zDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781597151; x=1782201951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dOsiBDHauJNUL/mHLBlXDW8Xe2gvOcwU/fMCh1N6uL8=;
 b=fvvEjT0DkWLICBD0GWb4TAcdn8jlLC9r8wN3Er/762Hh9ZBD4hNfg2pm0kwAZ3ksnB
 T5OffYHKt0vybsSe+sxcMC3VJps35rRqXEudRcWSqYW3Wa3roJLNzdYP7SjxvuVnEGM3
 14Yhs4Y1MP939UC4Q5Pyz1axkHyKF73d7OWL//57zyPJd2fTbNBqoYcuVyq81ukgIQaO
 8rsStrz8hB1rTEmxUSo2LLRPARlFTsiHTcglLJyU6qap/ToU1O+W41RRJbw/6gFBbPXv
 diAmeKo0XEnT44Sd7S4deWYhJU1x5ZbTVcj9Ao4wu5fhS09d2S7uWedrFA4ys3el365I
 +OQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zp6tseFy6A9daxgJIcUR205vhPAjTozTgL03fYUK1H+MRskHRP/j+bOkiQCRGBiam0Z6O68QmgXo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2oywAl3crTFYWoVPnBnwCr67voAtIeDRnSBJCZmw7B3nteat0
 FP+wwLVIEaJO6KY4LWFz8lBbZUjBIjCmKK4D91glM7naZz8Yz92q3A6PrHr9nb+3TQ==
X-Gm-Gg: Acq92OFnFQzfIrdj3wmC4h6+iT2XB5ZhGqfcHSNYHK1YQIQs9MHwB3UOEJ9QO2rnl3I
 rokF3YxUoKclztJruMu2BcCoqXtwiTDUqEuKKfJjNd2Mvhmoze0dHv0KiQSNZAvaYXs1UbxguVr
 O5ybb5/ZMVxUM4N0Ux9LQYQEg1Ah5W2584GRFBF/T+2c3vC4OulsJEJidPVZNRO+gfSj8NLkOGh
 sHRyyDVraS+NptMt0hTo9OKdsCGC9iC92o63KmS1nYMdjn7NhkQgJrSAG2G3UWwzvf6RrMrZ5X+
 v0sNsIxzI1DCzLbftbW6jYhkmXkUjpcmPzRZDIk0XTbG+iHuZVpcrbHuDIecqYNY2N5dV4lro3x
 22tRze1LRsO9qJB4De0jTulErGsn5nuQ7q/t1qSNoStJW0I6TK9bKWDdfMk33wnaMhLwrwFoS/Q
 VVlgn4cUbN9+dxQzzNS8Rgf+pTvPks6lEPNfLzhewoQfmT8Lf7hKzStXFu/ryQ
X-Received: by 2002:a17:903:1b0e:b0:2bd:6dad:7cca with SMTP id
 d9443c01a7336-2c69a357a8cmr1809945ad.22.1781597150664; 
 Tue, 16 Jun 2026 01:05:50 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c016sm12271540b3a.8.2026.06.16.01.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:05:50 -0700 (PDT)
Date: Tue, 16 Jun 2026 08:05:42 +0000
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
Subject: Re: [PATCH v3 8/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <ajED1v846hZkyq9z@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-9-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-9-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:22PM +0100, Matt Evans wrote:
> Expand the VFIO DMABUF revocation state to three states:
> Not revoked, temporarily revoked, and permanently revoked.
> 
> The first two are for existing transient revocation, e.g. across a
> function reset, and the DMABUF is put into the last in response to a
> new VFIO feature VFIO_DEVICE_FEATURE_DMA_BUF.
> 
> VFIO_DEVICE_FEATURE_DMA_BUF passes a DMABUF by fd and requests that
> the DMABUF is permanently revoked.  On success, it's guaranteed that
> the buffer can never be imported/attached/mmap()ed in future, that
> dynamic imports have been cleanly detached, and that all mappings have
> been made inaccessible/PTEs zapped.
> 
> This is useful for lifecycle management, to reclaim VFIO PCI BAR
> ranges previously delegated to a subordinate client process: The
> driver process can ensure that the loaned resources are revoked when
> the client is deemed "done", and exported ranges can be safely re-used
> elsewhere.
> 
> Refactor the revocation code out of vfio_pci_dma_buf_move() to a
> function common to move and the new feature request path.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |   6 +-
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 169 ++++++++++++++++++++++-------
>  drivers/vfio/pci/vfio_pci_priv.h   |  19 +++-
>  include/uapi/linux/vfio.h          |  20 ++++
>  4 files changed, 173 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 508a5eca910a..064906b25467 100644

[...]

>  
> +/* Set the DMABUF's revocation status (OK or temporarily/permanently revoked) */
> +static void vfio_pci_dma_buf_set_status(struct vfio_pci_dma_buf *priv,
> +					enum vfio_pci_dma_buf_status new_status)
> +{
> +	bool was_revoked;
> +
> +	lockdep_assert_held_write(&priv->vdev->memory_lock);
> +
> +	if (priv->status == VFIO_PCI_DMABUF_PERM_REVOKED ||
> +	    priv->status == new_status) {
> +		return;
> +	}
> +
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
> +	was_revoked = (priv->status == VFIO_PCI_DMABUF_TEMP_REVOKED);
> +
> +	if (new_status != VFIO_PCI_DMABUF_OK) {
> +		priv->status = new_status; /* Temp or permanently revoked */
> +
> +		if (was_revoked) {
> +			/*
> +			 * TEMP_REVOKED is being upgraded to
> +			 * PERM_REVOKED.  The buffer is already gone,
> +			 * don't wait on it again.
> +			 */
> +			dma_resv_unlock(priv->dmabuf->resv);
> +			return;
> +		}
> +	}
> +
> +	dma_buf_invalidate_mappings(priv->dmabuf);

Nit: We seem to be calling this even if new_status == OK, while it works
as importers (like IOMMUFD and RDMA core) are immune to a double 
invalidate / revoke. I'm wondering if we could move this within the 
if (new_status != VFIO_PCI_DMABUF_OK) block? 

Since this is only needed to be called when we TEMP/PERM _REVOKE?

I'm just worried that this may overload the dma_buf_invalidate_mappings 
to be a state-change notification instead of a revoke / invalidate
notification.

> +	dma_resv_wait_timeout(priv->dmabuf->resv,
> +			      DMA_RESV_USAGE_BOOKKEEP, false,
> +			      MAX_SCHEDULE_TIMEOUT);
> +	dma_resv_unlock(priv->dmabuf->resv);
> +	if (new_status != VFIO_PCI_DMABUF_OK) {
> +		kref_put(&priv->kref, vfio_pci_dma_buf_done);
> +		wait_for_completion(&priv->comp);
> +		unmap_mapping_range(priv->dmabuf->file->f_mapping,
> +				    0, priv->size, 1);
> +		/*
> +		 * Re-arm the registered kref reference and the
> +		 * completion so the post-revoke state matches the
> +		 * post-creation state.	 An un-revoke followed by a
> +		 * new mapping needs the kref to be non-zero before
> +		 * kref_get(), and vfio_pci_dma_buf_cleanup()
> +		 * delegates its drain back through this revoke
> +		 * path on a possibly-already-revoked dma-buf.
> +		 */
> +		kref_init(&priv->kref);
> +		reinit_completion(&priv->comp);
> +	} else {
> +		dma_resv_lock(priv->dmabuf->resv, NULL);
> +		priv->status = VFIO_PCI_DMABUF_OK;
> +		dma_resv_unlock(priv->dmabuf->resv);
> +	}
> +}
> +

Otherwise, 
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
