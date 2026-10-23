Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FA606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTBqXNHp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C802C112C99;
	Fri, 23 Oct 2026 17:47:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF7410E083;
 Fri, 23 Oct 2026 17:47:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D96564358F;
 Fri, 23 Oct 2026 17:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6891F031E2;
 Fri, 23 Oct 2026 17:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792777667;
 bh=EgRflrA0uulNksUz1cPaQajGrmLlAAPPSnG8n3RQbPE=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=UTBqXNHpl62gWrKfxC4rbwumWyTjDOXUu5DAbQNgeXX2iFRjuMSygMGZzBhTJFOoN
 TEzGMtV5t15xJKkp+vzda2GURHxE2+mmkwmK2GlxTRk4wGsRxbvwhpYBbiDBokw6tF
 1nlcAxY9GpN8cPSq+wShNzb2BuBt2PKvFILbU1iSt/3dVUCIoeCFoX5OVgMnAxGgNx
 LtZf5tHexjWT5sELxcKzclUsNficTrgVgT4oMuc7CflDNESrFoFWC1eySFM41WpceT
 enBQoEVpULFb6vcsEGzDqAnAZCkoZusrTX39ZGgUmw5647iCp4BQVDGhU3t6VmEVE6
 9f++YbV3WWF/A==
Date: Fri, 23 Oct 2026 12:47:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Message-ID: <20261023174746.GA2791886@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
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

On Tue, Oct 20, 2026 at 09:04:40AM -0500, Mario Limonciello wrote:
> Bridges that need bus reassignment are scanned in two passes. Save
> the firmware secondary bus number during the first pass, before the
> bridge is disabled, and carry it to the bus created in the second
> pass. Initialize pci_dev from this preserved bus number so drivers
> can match firmware records after PCI bus renumbering.
> 
> Handle pci_alloc_dev(NULL) as well; some in-tree callers use it to
> allocate a standalone pci_dev.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 9 +++++++++
>  include/linux/pci.h | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..4ece4b70cdc15 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->sysdata = bridge->sysdata;
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
> +	bus->initial_bus_number = bus->number;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>  		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> @@ -1232,6 +1233,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	/* Set up the primary, secondary and subordinate bus numbers */
>  	child->number = child->busn_res.start = busnr;
> +	child->initial_bus_number = busnr;
>  	child->primary = parent->busn_res.start;
>  	child->busn_res.end = 0xff;
>  
> @@ -1470,6 +1472,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, secondary);
>  			if (!child)
>  				goto out;
> +			child->initial_bus_number = secondary;
>  			child->primary = primary;
>  			pci_bus_insert_busn_res(child, secondary, subordinate);
>  			child->bridge_ctl = bctl;
> @@ -1491,6 +1494,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> +			if (!dev->initial_secondary_bus_number)
> +				dev->initial_secondary_bus_number = secondary;
>  			if (pcibios_assign_all_busses() || broken)
>  
>  				/*
> @@ -1526,6 +1531,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, next_busnr);
>  			if (!child)
>  				goto out;
> +			if (dev->initial_secondary_bus_number)
> +				child->initial_bus_number =
> +					dev->initial_secondary_bus_number;
>  			pci_bus_insert_busn_res(child, next_busnr,
>  						bus->busn_res.end);
>  		}
> @@ -2508,6 +2516,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  	INIT_LIST_HEAD(&dev->bus_list);
>  	dev->dev.type = &pci_dev_type;
>  	dev->bus = pci_bus_get(bus);
> +	dev->initial_bus_number = bus ? bus->initial_bus_number : 0;
>  	dev->driver_exclusive_resource = (struct resource) {
>  		.name = "PCI Exclusive",
>  		.start = 0,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..f6b377dcf7a14 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	u8		initial_bus_number;	/* Bus number when device was discovered */
> +	u8		initial_secondary_bus_number;	/* Bus number behind this bridge */

Why do we need this in the pci_dev?  Is there something about
pci_scan_bridge_extend() that means it has to be in pci_dev as well as
pci_bus?  Multiple copies means possible inconsistencies.

>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -724,6 +726,7 @@ struct pci_bus {
>  	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>  
>  	unsigned char	number;		/* Bus number */
> +	unsigned char	initial_bus_number;	/* Bus number before reassignment */

I think it should be stylistically similar to the existing
"pci_bus.number"; adding "initial" before or after is ok, but adding
both "initial" and "bus" makes them less connected.

Users would check "vhdr->PCIBus == rdev->pdev->bus->number_initial" or
similar.

>  	unsigned char	primary;	/* Number of primary bridge */
>  	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> 
> -- 
> 2.43.0
> 
