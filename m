Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CE606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=By9twM0k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2348992E;
	Tue, 27 Oct 2026 22:41:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6533810F869;
 Tue, 27 Oct 2026 22:41:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEC9B415FF;
 Tue, 27 Oct 2026 22:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F4B1F01825;
 Tue, 27 Oct 2026 22:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793140891;
 bh=36BYKCF164tXZn3FsLSkOB63KBQCKvHjKoR2T7jC1As=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=By9twM0khKiyjXxV0Yx0gmrjtdC4XEQPzMwUDl+Una0jfLlAUEm4jYcbm08BVHjQY
 PMAyhJ6MSrn6qWfGAs7OSIniRe1vJyzSMUnCSK4+sS5ogCsGxex4xW2wCncWk1TDyg
 m8erVmAzhMyDwbkh79AxfmDf5nW9diszeWU8Y4rFPEYVAWXRmn+b+1GTscQ6BDSEJR
 Gzpcv6o3EfAnCPBJuhgsgdwENi2BnGngjQBdQgaHjZJhtdY1fiQjW9aW60lQO+G8TN
 XVp3gfycemxjRqdGKuh6aNkpOLLXvGqAdyxszYvU7NO4z5Qv6nzzzD8iqeLTTu6HPG
 gTBIGzJ+M/neQ==
Date: Tue, 27 Oct 2026 17:41:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>
Subject: Re: [PATCH v4 1/3] PCI: Preserve the initial bus number in pci_bus
Message-ID: <20261027224130.GA511803@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-vfct-regression-v4-1-0e7190e39c2c@amd.com>
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

[+cc Lijo]

On Tue, Oct 27, 2026 at 11:22:25AM -0500, Mario Limonciello wrote:
> Bridge scans are split into two passes when bus numbers need reassigning.
> Save the firmware secondary bus number on the bridge in pass 0, before it
> is disabled. Use it to initialize number_initial when the child bus is
> created in pass 1, before bus registration callbacks run.
> 
> Keep the saved secondary number on the bridge so a later rescan does not
> replace the child's initial number with its reassigned runtime number.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 6 ++++++
>  include/linux/pci.h | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..3c03ac22223d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1012,6 +1012,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	bus->sysdata = bridge->sysdata;
>  	bus->ops = bridge->ops;
>  	bus->number = bus->busn_res.start = bridge->busnr;
> +	bus->number_initial = bus->number;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
>  	if (bridge->domain_nr == PCI_DOMAIN_NR_NOT_SET)
>  		bus->domain_nr = pci_bus_find_domain_nr(bus, parent);
> @@ -1232,6 +1233,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	/* Set up the primary, secondary and subordinate bus numbers */
>  	child->number = child->busn_res.start = busnr;
> +	child->number_initial = bridge && bridge->bridge_secondary_busnr ?
> +		bridge->bridge_secondary_busnr : busnr;
>  	child->primary = parent->busn_res.start;
>  	child->busn_res.end = 0xff;
>  
> @@ -1418,6 +1421,8 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  
>  	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>  		secondary, subordinate, pass);
> +	if (!pass && !dev->bridge_secondary_busnr)
> +		dev->bridge_secondary_busnr = secondary;

I think I was mistaken to suggest that pci_bus was the right place to
store this.

It seems like we definitely need something in the pci_dev because we
may clear the initial bus numbers in the first pass, so we need to
stash the secondary bus number somewhere until the second pass
allocates the pci_bus and we can save it here.

Since we have to have it in the pci_dev, I suspect maybe it would be
enough to have it *only* there.  Maybe it could be set in
pci_read_bridge_windows(), and drivers could find it via
pdev->bus->self?

>  	if (!primary && (primary != bus->number) && secondary && subordinate) {
>  		pci_warn(dev, "Primary bus is hard wired to 0\n");
> @@ -1470,6 +1475,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			child = pci_add_new_bus(bus, dev, secondary);
>  			if (!child)
>  				goto out;
> +			child->number_initial = secondary;
>  			child->primary = primary;
>  			pci_bus_insert_busn_res(child, secondary, subordinate);
>  			child->bridge_ctl = bctl;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..c607818a98a87 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	u8		bridge_secondary_busnr;

I think you're right to use "secondary" here so we don't perpetuate
the "subordinate" misuse.  Maybe also include "initial" and make it
"unsigned char" so it's the same as pci_bus.number?

>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -724,6 +726,7 @@ struct pci_bus {
>  	struct proc_dir_entry *procdir;	/* Directory entry in /proc/bus/pci */
>  
>  	unsigned char	number;		/* Bus number */
> +	unsigned char	number_initial;	/* Bus number before reassignment */
>  	unsigned char	primary;	/* Number of primary bridge */
>  	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
>  	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
> 
> -- 
> 2.43.0
> 
