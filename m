Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD8DCCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1476E10E2B3;
	Thu, 15 Oct 2026 19:48:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F19210E290;
 Thu, 15 Oct 2026 19:48:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A69D060A54;
 Thu, 15 Oct 2026 19:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F01F000C4;
 Thu, 15 Oct 2026 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792093710;
 bh=RUHDErUkUfx36mIq2sUsnA7sTYYP9ovek6NHhcLYr0A=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=aSgseOwyTIlj9XqEsmDIwF9MKkyri10qtLGdd4CM/aPrd2+rmcs9LUhXtrPzg08D/
 9TsQwS0hgzmSK/f4MArPkCMCTdlt5k9dD8Y5a40rwXPOl6R+ZvdUz0+/my2UWn8lMq
 413KmU9YWnSWlTSBbskyZigYRGIytpL1nCZe1LmeK8Vy/2ggST2KiKA2NWbnPo0E09
 tjZFjF73VZ9aJBjQ4rDVzMIQUpb+S3H103E7rTWUg0PfPxPK9/Xb1sVYgEgeEsSOOO
 34ADm71bjKDavZjd/GJ1py999iC6XJxHt0F8wf19yX+4f2DfkHMQ2NtsnrZoACeKCX
 Ja8pAgv8vgA7A==
Date: Thu, 15 Oct 2026 14:48:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, bhelgaas@google.com,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Gate VFCT bus fallback on pci=realloc
Message-ID: <20261015194828.GA1775177@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015124843.203905-1-mario.limonciello@amd.com>
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

[+cc Alex, Ilpo, Lukas, linux-acpi]

On Thu, Oct 15, 2026 at 07:48:42AM -0500, Mario Limonciello wrote:
> The soft filter system introduced by commit 11c141672045f ("drm/amdgpu:
> Fix VFCT bus number matching with soft filter") has a deficiency that
> it won't work when there are multiple GPUs of the exact same model.
> 
> As it was introduced specifically to help the case of pci=realloc, gate
> it to only run when that's in use.
> 
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 15 ++++++++-------
>  drivers/pci/setup-bus.c                  |  5 +++++
>  include/linux/pci.h                      |  1 +
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 08ed1eb695586..75af9a59671ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -384,12 +384,10 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>   * @vhdr: VFCT image header to check
>   *
>   * VFCT entries contain the PCI bus number as recorded during BIOS POST.
> - * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
> - * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> + * On systems where the user requested PCI resource reallocation, the
> + * runtime bus number may differ from the POST value. Match by device
> + * identity (vendor + device + function), but only treat the bus number as
> + * a preference when pci=realloc was explicitly requested.

This is a generic problem, isn't it?  

I think any table from firmware that has PCI bus numbers in it could
trip over issues like this.  Seems like we need a more generic
solution.

>   *
>   * Returns: 0 on match, -ENODEV on no match
>   */
> @@ -409,7 +407,10 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>  	if (vhdr->PCIBus == adev->pdev->bus->number)
>  		return 0;
>  
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> +	/* Allow bus renumbering only when the user requested pci=realloc. */
> +	if (!pci_realloc_enabled_by_user())
> +		return -ENODEV;
> +
>  	dev_notice(adev->dev,
>  		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
>  		   vhdr->PCIBus, adev->pdev->bus->number,
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed16ef7c26fa7..d9450585082c0 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1799,6 +1799,11 @@ static bool pci_realloc_enabled(enum enable_type enable)
>  	return enable >= user_enabled;
>  }
>  
> +bool pci_realloc_enabled_by_user(void)
> +{
> +	return pci_realloc_enable == user_enabled;
> +}

I don't like this.  I think the same bus renumbering can happen in the
"auto_enabled" case, and I don't think we set pci_realloc_enable in
that case.

But more generally, I think ultimately the PCI core should be able to
reassign bus numbers arbitrarily to accommodate hotplugs (given the
appropriate driver support to tolerate that, of course).

>  #if defined(CONFIG_PCI_IOV) && defined(CONFIG_PCI_REALLOC_ENABLE_AUTO)
>  static int iov_resources_unassigned(struct pci_dev *dev, void *data)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1ef..844734da9250f 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -610,6 +610,7 @@ static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
>  }
>  
>  struct pci_dev *pci_alloc_dev(struct pci_bus *bus);
> +bool pci_realloc_enabled_by_user(void);
>  
>  #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
>  #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> -- 
> 2.43.0
> 
