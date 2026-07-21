Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D10C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:35:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D67B10E265;
	Tue, 21 Jul 2026 22:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bQKTGcwJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B742210E265
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 22:35:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 39FE94064E;
 Tue, 21 Jul 2026 22:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96511F00A3A;
 Tue, 21 Jul 2026 22:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784673302;
 bh=402KK+z4po48VNQOSLhV7HM352cdPytedTmbk0qARns=;
 h=Date:From:To:Cc:Subject:In-Reply-To;
 b=bQKTGcwJLmOQKCGnaU51vXTVSla0Lnrgml3YNZC9hshEivO4cgDa5ts0i5ykWMfGB
 BuRNND8A8GRlLel+C3iB22l/sNSwbghRe4vesDOnr3KKpWVJMZ0LPHZibqdZ768a0D
 mPEd7SQ/aoc/v0X+lKnpVp77ongwReUvBL7hbEO56e7d3IMxk9hBcG4y2zN5CVnRI+
 2PpOjbq0a0eOOjxv6QwIQht6n/QuRE9LqcmGyH+EchrrcR0g4DUyTD5SN0/jVYrG19
 5ZhqKl/mjqxN1zlD8S+R8VJYcdx452fxgBwLsVs8H0wxdz1dLRoBIE8G83HbquwYne
 zCXFoNUofUqIw==
Date: Tue, 21 Jul 2026 17:35:00 -0500
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
 dri-devel@lists.freedesktop.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 9/9] pci: fix UAF when probe runs concurrent to dyn ID
 removal
Message-ID: <20260721223500.GA690676@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706-pci_id_fix-v3-9-2d48fc025acc@garyguo.net>
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

On Mon, Jul 06, 2026 at 03:11:21PM +0100, Gary Guo wrote:
> Dynamic IDs are only guaranteed to be valid when dynids.lock is held,
> as remove_id_store can free the node. Thus, make a copy in
> pci_match_device. Also, clarify that the id parameter is only valid during
> probe.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kernel.org/
> Fixes: 0994375e9614 ("PCI: add remove_id sysfs entry")
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  drivers/pci/pci-driver.c | 28 +++++++++++++++-------------
>  include/linux/pci.h      |  1 +
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 2e80ae150ff4..4851061babcb 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -179,6 +179,7 @@ static const struct pci_device_id pci_device_id_any = {
>   * pci_match_device - See if a device matches a driver's list of IDs
>   * @drv: the PCI driver to match against
>   * @dev: the PCI device structure to match against
> + * @id_copy: Place to store copy of pci_device_id for dynamic ID

s/Place/place/ (capitalize same as the others)

>   * Used by a driver to check whether a PCI device is in its list of
>   * supported devices or in the dynids list, which may have been augmented
> @@ -186,9 +187,9 @@ static const struct pci_device_id pci_device_id_any = {
>   * structure or %NULL if there is no match.
>   */
>  static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
> -						    struct pci_dev *dev)
> +						    struct pci_dev *dev,
> +						    struct pci_device_id *id_copy)
>  {
> -	struct pci_dynid *dynid;
>  	const struct pci_device_id *found_id = NULL;
>  	struct pci_device_id dev_id;
>  	int ret;
> @@ -200,17 +201,16 @@ static const struct pci_device_id *pci_match_device(struct pci_driver *drv,
>  
>  	dev_id = pci_id_from_device(dev);
>  	/* Look at the dynamic ids first, before the static ones */
> -	spin_lock(&drv->dynids.lock);
> -	list_for_each_entry(dynid, &drv->dynids.list, node) {
> -		if (pci_match_one_id(&dynid->id, &dev_id)) {
> -			found_id = &dynid->id;
> -			break;
> +	scoped_guard(spinlock, &drv->dynids.lock) {
> +		struct pci_dynid *dynid;
> +
> +		list_for_each_entry(dynid, &drv->dynids.list, node) {
> +			if (pci_match_one_id(&dynid->id, &dev_id)) {
> +				*id_copy = dynid->id;
> +				return id_copy;
> +			}
>  		}
>  	}
> -	spin_unlock(&drv->dynids.lock);
> -
> -	if (found_id)
> -		return found_id;
>  
>  	found_id = do_pci_match_id(drv->id_table, &dev_id, ret > 0);
>  	if (found_id)
> @@ -466,12 +466,13 @@ void pci_probe_flush_workqueue(void)
>  static int __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
>  {
>  	const struct pci_device_id *id;
> +	struct pci_device_id id_copy;
>  	int error = 0;
>  
>  	if (drv->probe) {
>  		error = -ENODEV;
>  
> -		id = pci_match_device(drv, pci_dev);
> +		id = pci_match_device(drv, pci_dev, &id_copy);
>  		if (id)
>  			error = pci_call_probe(drv, pci_dev, id);
>  	}
> @@ -1559,12 +1560,13 @@ static int pci_bus_match(struct device *dev, const struct device_driver *drv)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *pci_drv;
>  	const struct pci_device_id *found_id;
> +	struct pci_device_id id_copy;
>  
>  	if (pci_dev_binding_disallowed(pci_dev))
>  		return 0;
>  
>  	pci_drv = (struct pci_driver *)to_pci_driver(drv);
> -	found_id = pci_match_device(pci_drv, pci_dev);
> +	found_id = pci_match_device(pci_drv, pci_dev, &id_copy);
>  	if (found_id)
>  		return 1;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 64b308b6e61c..92c17c116de6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -979,6 +979,7 @@ struct module;
>   *		function returns zero when the driver chooses to
>   *		take "ownership" of the device or an error code
>   *		(negative number) otherwise.
> + *		The pci_device_id parameter is only valid during probe.

The probe function takes a pointer to a struct pci_device_id, so I
think the requirement is that the struct pci_device_id only *needs* to
be valid during .probe(), right, i.e., the PCI core probe path makes
its own copy of the ID and doesn't retain the pointer after .probe()
returns, right?

I assume the caller determines the struct pci_device_id lifetime, and
it could be forever.

Could say something like:

  The pci_device_id parameter only needs to be valid during probe.

Thanks for doing this work; it should fix a subtle but important
issue.

>   *		The probe function always gets called from process
>   *		context, so it can sleep.
>   * @remove:	The remove() function gets called whenever a device
> 
> -- 
> 2.54.0
> 
