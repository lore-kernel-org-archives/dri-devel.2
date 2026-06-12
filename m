Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350DECD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A17C10EB68;
	Fri, 12 Jun 2026 20:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="s2VXyKrq";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C4610EB68
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:35:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2bf22c18ad3so25365ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 13:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781296513; x=1781901313;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ddJRP/HCOdDtAL2h34nFkdEDW/TddVVb74Su299sjvc=;
 b=s2VXyKrq5ZItQ19HfCASvlSh0MmjFwdXGucBzFJoYcwmYDlrkIazfgFXnY95FoPNX4
 2bHHoP17zCiBYVCjylx4tXc44BAQJfCNTgamrLJQlhEMInrlly8ZNhsZiIcIeT8paDTf
 cb5GZW3+DOScELrmFigtqH0CkaiJTt2viObmrie2zgkK/m22P7RErzXpajx60B6zHD6b
 nbEIN2/nvnBpEs5Tn9LzWNNdK+2bRMV3RY0Q/49kH1Tnj+sNIxHpYKzPjD9a+yQ5o39/
 fFTaTWkLtvgvfKb6CO0L/JUCriYnEw413sAFtyoMf72ngrGb7yHNhnp1rXDNF4GT61NC
 nqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781296513; x=1781901313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ddJRP/HCOdDtAL2h34nFkdEDW/TddVVb74Su299sjvc=;
 b=R63HFHCVZKN+TYewVbWMmbi4VQTwgUGHBLmjCimf0ZrxRGUfiOecY5MrWJ0sxmUEC0
 tRXSXYM+qpBoUSkknt+V8KlDSoRUoFxpDA8Q6KYp/1/b5Y+rJQ+U1RAaDCn1f7Vfbmz5
 Azqt1wC4RYlYeQTJo/V01y/buErznSW7ZRCJlaQAejOqy9MhuwIAL0l1cRu5CJajCGe4
 xy2oFNk3SKELOrI2Q4nYhzYXT44Mioaa2K3wSXvJcMB+aIJwD0V1myEccSSlXNOacZjw
 leJvlZBGVkN4pGoCCEEmaPNwdcfJRCPlxzjKN+U5ScFIIkboZjOHjKs+ns5T6G4mfNyt
 OxTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8akEcm4Fgq5d7dByDRPxTa5j6RWV/o+hi4wUCIAJGepOE5jesOF+6a282JII0iS7zTsp5SP64UVkg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg023VjaWUhcLJbm7Dis99TzoxI09tEUMj4QAsZQaZ8wBEmyFV
 PuXr6n2E1Chj+LuuuXfYqzXEJd3MBjJlOWAXk2vLy7jvxUsBAjvYtb5JqnJYDCDtjw==
X-Gm-Gg: Acq92OHpyUcnLXqPLIVq/eMzCB5PIT3WAuagy1/NNvzzg/warKPa33/WVgTAz/SlH6M
 6ipqF8oUS51j4VSEM2VVg43kipKRzqrcpne4u+NrNC95vcGJSi+/OSUVrO/vupnSx8gpyAuqf6W
 UjYMx4+rj3HK+lyCiPdWqFADxoT5NVnbzIlGoCzLVeMbEU/E2epDsEAvYC9hz3eg698HioYpbGx
 J2J3qegQ1bXJdH6UtR5a1DafZglqXhfIKyyuH+GDqcO8wljHSciw0Y7+mBZDXHUqPo4H8lHN1IC
 hbJwq8PR344EtJu0Rm7aLkzXqulkON50lDAmCXcvsbpZvr72AqnaC7p4nYODQ4OidSL4KVmLrVA
 cbKvRcXAn1qkJ46+Kz5j+8vNRCdk8lpDoxTAOO5AFY0BfoApIsaZStNCEZew0XyM/63g3guxIeN
 RxZRfTNknoWwwQ2xnkQWEia4/h2VvGzWxIxyZkfo1elg+2cl5uc0v2T5HboNok
X-Received: by 2002:a17:902:e743:b0:2c1:ee6e:4e4d with SMTP id
 d9443c01a7336-2c665142269mr504685ad.30.1781296511981; 
 Fri, 12 Jun 2026 13:35:11 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com.
 [34.142.255.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f1f0f19sm28160925ad.10.2026.06.12.13.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:35:11 -0700 (PDT)
Date: Fri, 12 Jun 2026 20:35:03 +0000
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
Subject: Re: [PATCH v3 7/9] vfio/pci: Support mmap() of a VFIO DMABUF
Message-ID: <aixtd_7gDhf2kisJ@google.com>
References: <20260610154327.37758-1-matt@ozlabs.org>
 <20260610154327.37758-8-matt@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610154327.37758-8-matt@ozlabs.org>
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

On Wed, Jun 10, 2026 at 04:43:21PM +0100, Matt Evans wrote:

Hi Matt,

[...]

> +	 *
> +	 * With the goal of taking vdev->memory_lock in a world where
> +	 * vdev might not still exist:
> +	 *
> +	 * 1. Take the resv lock on the DMABUF:
> +	 *  - If racing cleanup got in first, the buffer is revoked;
> +	 *    stop/exit if so.
> +	 *  - If we got in first, the buffer is not revoked so vdev is
> +	 *    non-NULL, accessible, and cleanup _has not yet put the
> +	 *    VFIO device registration_.  So, the device refcount must
> +	 *    be >0.
> +	 *
> +	 * 2. Take vfio_device registration (refcount guaranteed >0
> +	 *    hereafter).
> +	 *
> +	 * 3. Unlock the DMABUF's resv lock:
> +	 *  - A racing cleanup can now complete.
> +	 *  - But, the device refcount >0, meaning the vfio_device
> +	 *    (and vfio_pcie_core device vdev) have not yet been
> +	 *    freed.  vdev is accessible, even if the DMABUF has been
> +	 *    revoked or cleanup has happened, because
> +	 *    vfio_unregister_group_dev() can't complete.
> +	 *
> +	 * 4. Take the vdev->memory_lock
> +	 *  - Either the DMABUF is usable, or has been cleaned up.
> +	 *    Whichever, it can no longer change under us.
> +	 *  - Test the DMABUF revocation status again: if it was
> +	 *    revoked between 1 and 4 return a SIGBUS. Otherwise,
> +	 *    return a PFN.
> +	 *  - It's not necessary to also take the resv lock, because
> +	 *    the status/vdev can't change while memory_lock is held.
> +	 *
> +	 * 5. Unlock, done.
>  	 */
> +
> +	dma_resv_lock(priv->dmabuf->resv, NULL);
> +
> +	if (priv->revoked) {
> +		pr_debug_ratelimited("%s VA 0x%lx, pgoff 0x%lx: DMABUF revoked/cleaned up\n",
> +				     __func__, vmf->address, vma->vm_pgoff);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	/* If the buffer isn't revoked, vdev is valid */
>  	vdev = priv->vdev;
>  
> +	if (!vfio_device_try_get_registration(&vdev->vdev)) {
> +		/*
> +		 * If vdev != NULL (above), the registration should
> +		 * already be >0 and so this try_get should never
> +		 * fail.
> +		 */
> +		dev_warn(&vdev->pdev->dev, "%s: Unexpected registration failure\n",
> +			 __func__);
> +		dma_resv_unlock(priv->dmabuf->resv);
> +		return VM_FAULT_SIGBUS;
> +	}
> +	dma_resv_unlock(priv->dmabuf->resv);
> +


>  	scoped_guard(rwsem_read, &vdev->memory_lock) {
> +		/* Revocation status must be re-read, under memory_lock */
>  		if (!priv->revoked) {
>  			int pres = vfio_pci_dma_buf_find_pfn(priv, vma,
>  							     vmf->address,

Wait, I noticed that the is_aligned_for_order() check from mainline was 
removed here. Was that intentional? 

For hugepage faults (order > 0), we must ensure the PFN and address are
properly aligned before calling vfio_pci_vmf_insert_pfn().

In the current upstream code, we have:
  if (is_aligned_for_order(vma, addr, pfn, order))

Should we restore that check here?

> @@ -1766,6 +1827,7 @@ static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
>  			    __func__, order, pfn, vmf->address,
>  			    vma->vm_pgoff, (unsigned int)ret);
>  
> +	vfio_device_put_registration(&vdev->vdev);
>  	return ret;
>  }
>  
> @@ -1774,7 +1836,7 @@ static vm_fault_t vfio_pci_mmap_page_fault(struct vm_fault *vmf)
>  	return vfio_pci_mmap_huge_fault(vmf, 0);
>  }
>  
> -static const struct vm_operations_struct vfio_pci_mmap_ops = {
> +const struct vm_operations_struct vfio_pci_mmap_ops = {
>  	.fault = vfio_pci_mmap_page_fault,

Nit: Instead of making this global, should we add a helper? E.g.:

void vfio_pci_set_vma_ops(struct vm_area_struct *vma)
{
     vma->vm_ops = &vfio_pci_mmap_ops;
}

[...]

> +
> +static int vfio_pci_dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	/*
> +	 * If we observe that the buffer is revoked now then refuse
> +	 * the mmap().  This is a belt-and-braces early failure to
> +	 * ease debugging a revoked buffer being used.  Userspace
> +	 * might also race an mmap() against an explicit revocation,
> +	 * or an action doing a temporary revoke; race scenarios are
> +	 * still safe because the fault handler ultimately prevents
> +	 * access to a revoked buffer if it isn't caught here.
> +	 */
> +	if (READ_ONCE(priv->revoked))
> +		return -ENODEV;
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * dma_buf_mmap_internal() has asserted that the VMA is
> +	 * contained within the DMABUF size before calling this.
> +	 */
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> +
> +	/* See comments in vfio_pci_core_mmap() re VM_ALLOW_ANY_UNCACHED. */
> +	vm_flags_set(vma, VM_ALLOW_ANY_UNCACHED | VM_IO | VM_PFNMAP |
> +		     VM_DONTEXPAND | VM_DONTDUMP);
> +	vma->vm_private_data = priv;
> +	vma->vm_ops = &vfio_pci_mmap_ops;
> +
> +	return 0;
> +}
>  #endif /* CONFIG_VFIO_PCI_DMABUF */
>  

Thanks,
Praan
