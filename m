Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF03606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FVHeHKnj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69C410EB3B;
	Mon, 19 Oct 2026 22:22:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5AD10EB3B;
 Mon, 19 Oct 2026 22:22:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 414CD43FA1;
 Mon, 19 Oct 2026 22:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77481F000C5;
 Mon, 19 Oct 2026 22:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792448528;
 bh=Jvk59d9ewbiErKIPtDSsfuozYDEOraaR9TdxvyL2+sE=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=FVHeHKnjI258cSzmWvP3OsFQQH5RMmQAgntMEIENO6IVvGmDCaAQqLvh7Tbr3U/zd
 MH8VIeeVinVC+IdAPqKFxI1e7noUFKyxvakorknV873jydGDdFZnFzqYvKUKpfk8PH
 DHO6RP0VPLP9Bk2Dgxn7hnVYRDToQ/vf8iQcgip4MPBLkJoLkc5D/fbePdAeGq0RFi
 NpPSJoJ3MpMqEHtJpRzcLa4Ayv0FRobtKJXLsg1YdvZ/TvCqLrz17otNIahuWDhQaf
 tOJizlgKpw7dQ1pjPxqtJkSgBEHcivU+zZlg83d3sX+6x2439DYOEyISlYNdSkjzrL
 lxQJ+GsVwWuqw==
Date: Mon, 19 Oct 2026 17:22:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Oz Tiram <oz@shift-computing.de>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu: Fix VFCT bus number matching
 with soft filter"
Message-ID: <20261019222206.GA2276349@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8838ac4-ee24-486a-ab57-19d7c6a8901c@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 02:47:08PM -0500, Mario Limonciello wrote:
> +Bjorn
> +linux-pci
> 
> On 10/19/26 14:41, Alex Deucher wrote:
> > This reverts commit 11c141672045ffc0187aa604f2c0f597bc334fb2.
> > 
> > This was added to work around systems where the user specified
> > pci=realloc on the kernel command line.  The firmware specifies the
> > BDF to match, but those may not be the same with pci=realloc. This
> > causes mismatches when there are multiple cards of the same type in
> > the system and failure of the cards to initialize. pci=realloc is
> > not the most common case so let's revert for now to fix the regression.
> > We probably need to store the original BDF in the PCI subsystem so
> > we can use it match later if the BDF has changed.  This can be properly
> > reinstated once we have a general solution.
> > 
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5762
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Oz Tiram <oz@shift-computing.de>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> 
> I hate to trade one regression for another; but arguably pci=realloc is the
> less common than the case of two identical GPUs.
> 
> Bjorn,
> 
> You open to storing the original BDF in the device somewhere and letting
> drivers access it?

I mentioned in the other thread that saving the original bus number in
a struct pci_bus or similar might be practical?

> That's what I suggested here in response to the other way (let driver detect
> pci=realloc).
> 
> https://lore.kernel.org/linux-pci/4284d6d4-244d-4d49-bbdb-f1bda89fc1e8@amd.com/
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 45 +++---------------------
> >   1 file changed, 5 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > index f9315e0472fe9..6bbca70a4e2eb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> > @@ -428,45 +428,6 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
> >   }
> >   #ifdef CONFIG_ACPI
> > -/**
> > - * amdgpu_acpi_vfct_match() - Check if a VFCT entry matches the device
> > - * @adev: AMDGPU device
> > - * @vhdr: VFCT image header to check
> > - *
> > - * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> > - * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
> > - * resource conflicts), the runtime bus number may differ from the POST
> > - * value.  Match by device identity (vendor + device + function) and use
> > - * the bus number as a preference: exact bus match is preferred, but when
> > - * the bus numbers disagree we accept the entry if the device identity
> > - * matches.
> > - *
> > - * Returns: 0 on match, -ENODEV on no match
> > - */
> > -static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
> > -				  VFCT_IMAGE_HEADER *vhdr)
> > -{
> > -	/* Vendor and device IDs must always match */
> > -	if (vhdr->VendorID != adev->pdev->vendor ||
> > -	    vhdr->DeviceID != adev->pdev->device)
> > -		return -ENODEV;
> > -
> > -	if (vhdr->PCIDevice != PCI_SLOT(adev->pdev->devfn) ||
> > -	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
> > -		return -ENODEV;
> > -
> > -	/* Exact bus number match - preferred */
> > -	if (vhdr->PCIBus == adev->pdev->bus->number)
> > -		return 0;
> > -
> > -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> > -	dev_notice(adev->dev,
> > -		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> > -		   vhdr->PCIBus, adev->pdev->bus->number,
> > -		   adev->pdev->vendor, adev->pdev->device);
> > -	return 0;
> > -}
> > -
> >   static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> >   {
> >   	struct acpi_table_header *hdr;
> > @@ -503,7 +464,11 @@ static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> >   		}
> >   		if (vhdr->ImageLength &&
> > -		    !amdgpu_acpi_vfct_match(adev, vhdr)) {
> > +		    vhdr->PCIBus == adev->pdev->bus->number &&
> > +		    vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
> > +		    vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn) &&
> > +		    vhdr->VendorID == adev->pdev->vendor &&
> > +		    vhdr->DeviceID == adev->pdev->device) {
> >   			adev->bios = kmemdup(&vbios->VbiosContent,
> >   					     vhdr->ImageLength,
> >   					     GFP_KERNEL);
> 
