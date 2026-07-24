Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74452C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7B410E096;
	Fri, 24 Jul 2026 22:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MsxDWnfO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AFC10E096
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7978C41453;
 Fri, 24 Jul 2026 22:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB9F1F00A3D;
 Fri, 24 Jul 2026 22:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784932180;
 bh=6fL3VBsWrx8P26caK1wKalSHupqVUBAmzw8o73q9YrQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=MsxDWnfOFwk6CHZFptbTiXY/ZFlQsCqb6Zd2SpiyhXuCSyQRELxu3DvwMJGHHZjfT
 KYANa0dFConrSiJ5hG0dO8xKi8gXYzZpLPOICk+H4ehxw3lQxsijray7LOKB8U51zN
 T5g+VTRJiVTCDyG0cnygubYSYCMmXrCMDXmzetUogkRheS8AakB5Mx4J0r/0PQVVgT
 pLbPyicwL6jmLgQ3HadCTXPAL1QpjHTvA54ZFPjcWrODDCK1oenqgQYG8cLnLr5L2M
 U2iQtqwefKSPYtFNr5ilxeyhPTsezoaA9jjC9+fVbfXZcGydzc5hvEaDo25mG/2mk2
 cJPofqnpi6X9w==
Date: Fri, 24 Jul 2026 17:29:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Zhenzhong Duan <zhenzhong.duan@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, GOTO Masanori <gotom@debian.or.jp>,
 YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Vaibhav Gupta <vaibhavgupta40@gmail.com>,
 Jens Taprogge <jens.taprogge@taprogge.org>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@redhat.com>, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
 industrypack-devel@lists.sourceforge.net, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 7/9] PCI: Make pci_match_one_device() match on ID
 instead of device
Message-ID: <20260724222939.GA1065077@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-pci_id_fix-v4-7-3580726844e1@garyguo.net>
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

On Thu, Jul 23, 2026 at 11:00:46PM +0100, Gary Guo wrote:
> PCI dynamic ID needs to match IDs against a new ID to see if it already
> exists. Existing APIs can only match IDs against devices, causing the
> dynamic ID insertion code to create a temporary device only for matching
> purpose. Rename pci_match_one_device() to pci_match_one_id() so it can be
> used for this purpose instead; add a pci_id_from_device() helper to make it
> easy to convert users.

s/causing the ... code to create/so the ... code creates/
s/purpose/purposes/

> Similarly, convert pci_match_id() to do_pci_match_id(). But keep the
> existing API because there are many users.
> 
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

What's the merge strategy?  If these all need to be merged together,
feel free to include the PCI patches whereever you merge the series.

> ---
>  drivers/pci/pci-driver.c | 38 ++++++++++++++++++++++++++++----------
>  drivers/pci/pci.h        | 43 +++++++++++++++++++++++++++++++------------
>  drivers/pci/search.c     |  8 +++++---
>  3 files changed, 64 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1..c9424edb4548 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -90,6 +90,27 @@ static void pci_free_dynids(struct pci_driver *drv)
>  	spin_unlock(&drv->dynids.lock);
>  }
>  
> +/**
> + * do_pci_match_id - See if a PCI ID matches a given pci_id table
> + * @ids: array of PCI device ID structures to search in
> + * @dev_id: the actual PCI device ID structure to match against.
> + *
> + * Return: the matching pci_device_id structure or %NULL if there is no match.
> + */
> +static const struct pci_device_id *
> +do_pci_match_id(const struct pci_device_id *ids,
> +		const struct pci_device_id *dev_id)
> +{
> +	if (ids) {
> +		while (ids->vendor || ids->subvendor || ids->class_mask) {
> +			if (pci_match_one_id(ids, dev_id))
> +				return ids;
> +			ids++;
> +		}
> +	}
> +	return NULL;
> +}
> +
>  /**
>   * pci_match_id - See if a PCI device matches a given pci_id table
>   * @ids: array of PCI device ID structures to search in
> @@ -105,14 +126,9 @@ static void pci_free_dynids(struct pci_driver *drv)
>  const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>  					 struct pci_dev *dev)
>  {
> -	if (ids) {
> -		while (ids->vendor || ids->subvendor || ids->class_mask) {
> -			if (pci_match_one_device(ids, dev))
> -				return ids;
> -			ids++;
> -		}
> -	}
> -	return NULL;
> +	struct pci_device_id dev_id = pci_id_from_device(dev);
> +
> +	return do_pci_match_id(ids, &dev_id);
>  }
>  EXPORT_SYMBOL(pci_match_id);
>  
> @@ -138,6 +154,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  {
>  	struct pci_dynid *dynid;
>  	const struct pci_device_id *found_id = NULL, *ids;
> +	struct pci_device_id dev_id;
>  	int ret;
>  
>  	/* When driver_override is set, only bind to the matching driver */
> @@ -145,10 +162,11 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  	if (ret == 0)
>  		return NULL;
>  
> +	dev_id = pci_id_from_device(dev);
>  	/* Look at the dynamic ids first, before the static ones */
>  	spin_lock(&drv->dynids.lock);
>  	list_for_each_entry(dynid, &drv->dynids.list, node) {
> -		if (pci_match_one_device(&dynid->id, dev)) {
> +		if (pci_match_one_id(&dynid->id, &dev_id)) {
>  			found_id = &dynid->id;
>  			break;
>  		}
> @@ -158,7 +176,7 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  	if (found_id)
>  		return found_id;
>  
> -	for (ids = drv->id_table; (found_id = pci_match_id(ids, dev));
> +	for (ids = drv->id_table; (found_id = do_pci_match_id(ids, &dev_id));
>  	     ids = found_id + 1) {
>  		/*
>  		 * The match table is split based on driver_override.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 93731242d314..71cda71f3bc9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -443,21 +443,40 @@ static inline int pci_setup_cardbus(char *str) { return -ENOENT; }
>  #endif /* CONFIG_CARDBUS */
>  
>  /**
> - * pci_match_one_device - Tell if a PCI device structure has a matching
> - *			  PCI device id structure
> - * @id: single PCI device id structure to match
> - * @dev: the PCI device structure to match against
> + * pci_id_from_device - Obtain a pci_device_id from a PCI device
> + * @dev: the PCI device
>   *
> - * Returns the matching pci_device_id structure or %NULL if there is no match.
> + * Return: a pci_device_id filled.
> + */
> +static inline struct pci_device_id pci_id_from_device(const struct pci_dev *dev)
> +{
> +	return (struct pci_device_id) {
> +		.vendor = dev->vendor,
> +		.device = dev->device,
> +		.subvendor = dev->subsystem_vendor,
> +		.subdevice = dev->subsystem_device,
> +		.class = dev->class,
> +	};
> +}
> +
> +/**
> + * pci_match_one_id - Tell if a PCI device ID matches a needle PCI device ID
> + * @id: single PCI device id structure to match against (needle)
> + * @dev_id: the actual ID from the PCI device
> + *
> + * ID can be retrieved from device using pci_id_from_device().
> + *
> + * Return: the matching pci_device_id structure or %NULL if there is no match.
>   */
>  static inline const struct pci_device_id *
> -pci_match_one_device(const struct pci_device_id *id, const struct pci_dev *dev)
> -{
> -	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
> -	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
> -	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
> -	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
> -	    !((id->class ^ dev->class) & id->class_mask))
> +pci_match_one_id(const struct pci_device_id *id,
> +		 const struct pci_device_id *dev_id)
> +{
> +	if ((id->vendor == PCI_ANY_ID || id->vendor == dev_id->vendor) &&
> +	    (id->device == PCI_ANY_ID || id->device == dev_id->device) &&
> +	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev_id->subvendor) &&
> +	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev_id->subdevice) &&
> +	    !((id->class ^ dev_id->class) & id->class_mask))
>  		return id;
>  	return NULL;
>  }
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index e3d3177fce54..34f8de551d58 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -245,8 +245,10 @@ static int match_pci_dev_by_id(struct device *dev, const void *data)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	const struct pci_device_id *id = data;
> +	struct pci_device_id dev_id;
>  
> -	if (pci_match_one_device(id, pdev))
> +	dev_id = pci_id_from_device(pdev);
> +	if (pci_match_one_id(id, &dev_id))
>  		return 1;
>  	return 0;
>  }
> @@ -416,9 +418,9 @@ EXPORT_SYMBOL(pci_get_class);
>   * @class: search for a PCI device with this base class code
>   * @from: Previous PCI device found in search, or %NULL for new search.
>   *
> - * Iterates through the list of known PCI devices. If a PCI device is found
> + * Iterate through the list of known PCI devices. If a PCI device is found
>   * with a matching base class code, the reference count to the device is
> - * incremented. See pci_match_one_device() to figure out how does this works.
> + * incremented. See pci_match_one_id() to figure out how this works.
>   * A new search is initiated by passing %NULL as the @from argument.
>   * Otherwise if @from is not %NULL, searches continue from next device on the
>   * global list. The reference count for @from is always decremented if it is
> 
> -- 
> 2.54.0
> 
