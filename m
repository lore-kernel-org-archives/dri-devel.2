Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBA5C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A9F10F34C;
	Thu, 16 Jul 2026 15:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JdpBWijR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F1B310F34C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:33:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E72D60A5E;
 Thu, 16 Jul 2026 15:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B772C1F000E9;
 Thu, 16 Jul 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784216033;
 bh=ngb6bIAdXn8ygB+1BwodyPZ4MoSQbdldi0uaWZpeO7c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JdpBWijRGj0pELaN6593r5Vq3Dspl6Il2jeoPZQDVmh74spLOierYrVSKeXp67pF0
 G+2GShSsgzyVfu9EiKUr5kwWibTqPfZ6FQRsIoVP0gjfz0M+HNJHvcdCVJszUFugFR
 tn0Q6B4EeOoC341l7QSs+zVZZH88b5eTomPleBQaUPWxXf7lLvQyahfhm9g3PAsjzb
 gFC+jLxr0UHMjtO+KcAJeSv3VVemjscqazmKpcTjpY4qDK80qWjGNXg/YrXYAHbwwj
 SZqoK+th99vjLxc2G4wbgsQ1Z4yF5fSXneRATncrieglx0WLeB5sZnEDo4bzGTeTjr
 0N3sA71SMUrTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/11] iommufd: Look up private-interconnect phys
 via exporter symbols
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <23bae967aa2bf38b7696c5cbcdf003cf43e98358.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <23bae967aa2bf38b7696c5cbcdf003cf43e98358.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:33:52 +0000
Message-Id: <20260716153352.B772C1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Mapping guest_memfd CPU RAM as uncached MMIO creates memory attrib=
ute aliasing, breaking bisection.
--

--- Patch [5]: [RFC PATCH 05/11] iommufd: Look up private-interconnect phys=
 via exporter symbols ---
commit a4bfbccbc028813d0ddd8502c6dc498ce23a16cb
Author: David Woodhouse <dwmw@amazon.co.uk>

iommufd: Look up private-interconnect phys via exporter symbols

This commit widens the dma-buf phys-map dispatch in iommufd to support
additional exporters by looking up a well-known symbol convention. It
initially tries a sample gmem provider before falling back to VFIO PCI.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 03c8379bbc347..2d4ea41460fdc 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c

[ ... ]

> @@ -1470,6 +1470,26 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_at=
tachment *attachment,
>  	if (rc !=3D -EOPNOTSUPP)
>  		return rc;
> =20
> +	/*
> +	 * Prototype: try the sample gmem provider's dma-buf exporter.  This
> +	 * mirrors the vfio-pci private-interconnect hook, and (like it) is
> +	 * meant to be replaced by a formal negotiated exporter op returning
> +	 * phys for iommufd.
> +	 */
> +	{
> +		extern int gmem_provider_dma_buf_iommufd_map(
> +			struct dma_buf_attachment *, struct phys_vec *);
> +		typeof(&gmem_provider_dma_buf_iommufd_map) gfn;
> +
> +		gfn =3D symbol_get(gmem_provider_dma_buf_iommufd_map);
> +		if (gfn) {
> +			rc =3D gfn(attachment, phys);
> +			symbol_put(gmem_provider_dma_buf_iommufd_map);
> +			if (rc !=3D -EOPNOTSUPP)
> +				return rc;

[Severity: High]
Will mapping guest_memfd CPU RAM as uncached MMIO cause memory attribute
aliasing issues here?

When gmem_provider_dma_buf_iommufd_map returns a physical address for RAM,
pfn_reader_fill_dmabuf() will hardcode it as BATCH_MMIO:

drivers/iommu/iommufd/pages.c:pfn_reader_fill_dmabuf() {
    ...
    batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
                      last_index - start_index + 1, BATCH_MMIO);
    ...
}

This causes batch_to_domain() to forcefully strip IOMMU_CACHE and apply
IOMMU_MMIO:

drivers/iommu/iommufd/pages.c:batch_to_domain() {
    ...
    if (batch->kind =3D=3D BATCH_MMIO) {
        iommu_prot &=3D ~IOMMU_CACHE;
        iommu_prot |=3D IOMMU_MMIO;
    }
    ...
}

On architectures like ARM64, this memory attribute aliasing between the
CPU (cacheable) and the IOMMU (uncached) can lead to a loss of coherency,
data corruption, or fatal SErrors.

Since the memory type plumbing is deferred to a later patch, could this
intermediate state introduce a bisection breakage if the sample provider
is utilized?

> +		}
> +	}
> +
>  	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
>  		return -EOPNOTSUPP;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D5
