Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7A606A32F
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnrwKGO3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB14D10F00B;
	Thu, 19 Nov 2026 16:54:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6756610E88E;
 Thu, 19 Nov 2026 16:53:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC0B56014B;
 Thu, 19 Nov 2026 16:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650691F000C5;
 Thu, 19 Nov 2026 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795107229;
 bh=jlYRN4IDAwWpF0znirb6L6eZ+ybQKX349IWRr+H23P8=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=BnrwKGO35kcG0dSILYcHGYt7cjZRRVlycOBQwAgy+/mOVWG56TQoJGIWKBiUsrSDH
 8O7cMwwfDjS08pQftM7RP4WY5h6/AKLna7wdjpNEKlxwHxeDcjxvzImzmmKx/7rEOb
 DUFpJMT0Zc+qA7BbMTBs/yy2kVi6wIe3Td8iGPundMq88cWpY3YX9CfJw6TlEO3QVO
 reD0U1hdMD7NpCp0Lrdu4QDSwhL97RxyR6zTxuegGI1/HWspHvORaX76Ba83Od5yAW
 dkgPZJzAM0ljWWS+0srvPCmMZ4+4R5exy1zQRHwqx/DvwPAxQH2yYlZejmTS86hay/
 nsfd9xefzzpoA==
Date: Thu, 19 Nov 2026 10:53:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Subject: Re: [PATCH v7 2/3] drm/amdgpu: Match VFCT using initial PCI bus number
Message-ID: <20261119165348.GA811401@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-vfct-regression-v7-2-69b1e0cf45c2@amd.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[+cc Lijo]

On Thu, Nov 12, 2026 at 03:54:54PM -0600, Mario Limonciello wrote:
> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
> 
> Reported-by: Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/20261014080523.186533-1-rezanikzadch@gmail.com/
> Fixes: 11c141672045f ("drm/amdgpu: Fix VFCT bus number matching with soft filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 08ed1eb695586..0ee4c6462c4d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -386,16 +386,17 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>   * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>   * On systems where the kernel renumbers PCI buses (e.g. pci=realloc or
>   * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> + * value.  Match using the bus number captured when the device was
> + * discovered, before any bus renumbering.
>   *
>   * Returns: 0 on match, -ENODEV on no match
>   */
>  static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>  				  VFCT_IMAGE_HEADER *vhdr)
>  {
> +	struct pci_dev *bridge = adev->pdev->bus->self;

pci_upstream_bridge() does this and handles the case where pdev is an
SR-IOV VF (that case probably never applies here, but we can still
avoid that assumption).

> +	unsigned char initial_bus;
> +
>  	/* Vendor and device IDs must always match */
>  	if (vhdr->VendorID != adev->pdev->vendor ||
>  	    vhdr->DeviceID != adev->pdev->device)
> @@ -405,16 +406,12 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_device *adev,
>  	    vhdr->PCIFunction != PCI_FUNC(adev->pdev->devfn))
>  		return -ENODEV;
>  
> -	/* Exact bus number match - preferred */
> -	if (vhdr->PCIBus == adev->pdev->bus->number)
> -		return 0;
> +	if (bridge && bridge->fw_sec_bus_valid)
> +		initial_bus = bridge->fw_sec_busnr;
> +	else
> +		initial_bus = adev->pdev->bus->number;

Why can't we use bridge->fw_sec_busnr unconditionally?  The bus number
at FW/OS handoff is the only bus number firmware could possibly know
about.

It seems like this should just be:

  if (vhdr->PCIBus == bridge->fw_sec_busnr &&
      vhdr->PCIDevice == PCI_SLOT(adev->pdev->devfn) &&
      vhdr->PCIFunction == PCI_FUNC(adev->pdev->devfn))
          return 0;        /* match */

  return -ENODEV;  /* no match */

It seems like the bus/device/function match should be solid by itself,
so I don't know why you need to check Vendor/Device IDs (but I don't
object if you do).

Maybe this boolean style is typical in DRM, and it does match the
strcmp() style, but it seems weird to me to write

  if (!amdgpu_acpi_vfct_match(...))
    /* do the matching case */

> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> -	dev_notice(adev->dev,
> -		   "VFCT bus number mismatch: table %u != runtime %u, matching by device identity (vendor 0x%04x device 0x%04x)\n",
> -		   vhdr->PCIBus, adev->pdev->bus->number,
> -		   adev->pdev->vendor, adev->pdev->device);
> -	return 0;
> +	return vhdr->PCIBus == initial_bus ? 0 : -ENODEV;
>  }
>  
>  static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)
> 
> -- 
> 2.43.0
> 
