Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BC606A338
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gz77kTyU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DB110ECA6;
	Thu, 19 Nov 2026 16:53:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A2110ECA6;
 Thu, 19 Nov 2026 16:53:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A9EA6014B;
 Thu, 19 Nov 2026 16:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7EEA1F000C4;
 Thu, 19 Nov 2026 16:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795107223;
 bh=o5ro9sxBOzh3u1cTo2kPlByJv2MwyjzC2PC0yLmvz+0=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=Gz77kTyULd22WG+7E9JGS+7bco+ZRwUyrBbK8XV/6pVeRgCOLYLkRxGZ5f5tqtG6i
 IMe3V9yMjtdkoZWtKIXKdEHEfvp0vWHnNEUDPN7IATtQP+tUc2vIO0JNaqx4n+iq4J
 0g+wIZ4V3oYX6Y8joNThwzshVQGrJ+o6VJ9hyXMRhrveGpjl4rgj8sAtbgMMlogx7Z
 YcJAwwOw962JKiRbO9YReGkczcBzceCMj7FzlmJvDa6Dpn1J7/PRytOBKmo0Vocska
 i48u5z5SggFRqBmF9PqDtXFjdEVroBE7nrGDld4ABknnZLA5DoBhtdbZPaYQ2q+nbi
 WeVlPmNLgBHlQ==
Date: Thu, 19 Nov 2026 10:53:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Lijo Lazar <lijo.lazar@amd.com>,
 Reza Nikzad Chaleshori <rezanikzadch@gmail.com>
Subject: Re: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
Message-ID: <20261119165341.GA809730@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
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

[+cc Lijo, Reza]

On Thu, Nov 12, 2026 at 03:54:53PM -0600, Mario Limonciello wrote:
> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=realloc), after which the runtime
> number no longer reflects what firmware programmed.
> 
> Record the firmware secondary bus number on the bridge's struct pci_dev
> the first time pci_read_bridge_windows() reads the bridge's bus numbers,
> which happens before any renumbering. Devices behind the bridge can then
> retrieve the original bus number via their upstream bridge.
> 
> Only store the value if it is usable: ignore unconfigured (0) and 0xff
> secondaries. Use a separate "sampled" flag so that later rescans, which
> would read the renumbered runtime value, never overwrite the cached
> number, and a "valid" flag so users can tell whether anything was
> recorded.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/probe.c | 16 ++++++++++++++--
>  include/linux/pci.h |  4 ++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
>  static void pci_read_bridge_windows(struct pci_dev *bridge)
>  {
>  	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>  	u16 io;
>  	u32 pmem, tmp;
>  	struct resource res;
>  
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>  	res.flags = IORESOURCE_BUS;
> -	res.start = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary = FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate = FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start = secondary;
> +	res.end = subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled = true;
> +		if (secondary > 0 && secondary < 0xff) {

A bridge with secondary==subordinate==0xff (with a single bus 0xff
below the bridge) is actually valid, isn't it?

I guess we could check for a config read failure with
PCI_POSSIBLE_ERROR(buses), but that would open the can of worms about
what we should do with the *rest* of this function if it failed.

I'm not sure we need to check "secondary > 0" either; obviously a
bridge with secondary bus 0 is not valid, but if the idea is to match
firmware's idea of a bus number, it seems like we need to capture the
bridge configuration at FW/OS handoff.

IIUC, the sashiko review [1] suggests that neither fw_sec_bus_sampled
nor fw_sec_bus_valid is actually necessary.

[1] https://lore.kernel.org/all/sashiko-outbox-212033@kernel.org

> +			bridge->fw_sec_busnr = secondary;
> +			bridge->fw_sec_bus_valid = true;
> +		}
> +	}
>  	pci_info(bridge, "PCI bridge to %pR%s\n", &res,
>  		 bridge->transparent ? " (subtractive decode)" : "");
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..045157488b8e7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>  	struct pci_slot	*slot;		/* Physical slot this device is in */
>  
>  	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	unsigned char	fw_sec_busnr;
>  	unsigned short	vendor;
>  	unsigned short	device;
>  	unsigned short	subsystem_vendor;
> @@ -414,6 +416,8 @@ struct pci_dev {
>  	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>  	unsigned int	pinned:1;	/* Whether this dev is pinned */
>  	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
> +	unsigned int	fw_sec_bus_valid:1; /* Firmware secondary bus number usable */
> +	unsigned int	fw_sec_bus_sampled:1; /* Firmware secondary bus number captured */
>  	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>  	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> 
> -- 
> 2.43.0
> 
