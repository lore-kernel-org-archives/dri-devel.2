Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B478AC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC7810E087;
	Mon, 21 Sep 2026 10:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FZwH4CG1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0895710E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789987202; x=1821523202;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Ad6fpYFCwCgyEm0jJN8fMhX4f6iQUwkGcN+NiWPLSVk=;
 b=FZwH4CG1Hcg5uCLDjxDtv7t0/2HJUWmOQsqrTzTfBpV6MQQitUfccm/j
 bAub6R08JlAVRjd9O9WJTSyLQvW7llqJfIH9DToSn51IZGhqPecsShFlM
 Za0toVORGpUyHQ1cIjhzOGwH0tegRGdVuXYIMuLxe4oZe3RrCFC9ovZQN
 SIHVts5nBec/WgBQY4U8yeeoH6vzHDJFOEn4jvmKm+GchPgcLKk2qmCD/
 fw2m0Ka0E+bnQK0Ce1MC3nNLiPNUtQNk1afrzG30fx3daKqYEOZ7frl0B
 mqZRoa1n4HUg1ylTuzrBMEtyw7/dKIqVQ00YswPLOZ3r74lwADKgNSIbS w==;
X-CSE-ConnectionGUID: eP+FsLGDTROBMyPZnDkEAQ==
X-CSE-MsgGUID: Q+oLdcEGQ7uLqKkjicXNiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="995192"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="995192"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 03:40:02 -0700
X-CSE-ConnectionGUID: 8+XazXeCTmuTJA6Wr/tqcA==
X-CSE-MsgGUID: mZc7qbq5SBS9jMbwFfsXTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="269116455"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.180])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 03:40:00 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Hui Peng <benquike@gmail.com>, bhelgaas@google.com, airlied@redhat.com
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and
 clear removed pci_dev
In-Reply-To: <20260919222629.3798073-1-benquike@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260919222629.3798073-1-benquike@gmail.com>
Date: Mon, 21 Sep 2026 13:39:54 +0300
Message-ID: <21d4bbfe6facdf2f88b09b277bddfe0afff5e5a4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Sat, 19 Sep 2026, Hui Peng <benquike@gmail.com> wrote:
> Fix two issues in drivers/pci/vgaarb.c:

One change per patch, please.

>
> 1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
>    returns 0 on success and a negative errno on failure, so checking if
>    (!vga_tryget(...)) is inverted and skips unlocking on success.
> 2. In vga_arbiter_del_pci_device(), clear any open vga_arb_user_init
>    priv->target references pointing to the removed pci_dev so subsequent
>    writes or close() on /dev/vga_arbiter do not dereference a freed
>    pci_dev.
>
> Fixes: 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to drivers/pci")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index 3de05aee7859..4f13e542505a 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -818,11 +818,33 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
> +#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
> +
> +/* Each user has an array of these, tracking which cards have locks */
> +struct vga_arb_user_card {
> +	struct pci_dev *pdev;
> +	unsigned int mem_cnt;
> +	unsigned int io_cnt;
> +};
> +
> +struct vga_arb_private {
> +	struct list_head list;
> +	struct pci_dev *target;
> +	struct vga_arb_user_card cards[MAX_USER_CARDS];
> +	spinlock_t lock;
> +};
> +
> +static LIST_HEAD(vga_user_list);
> +static DEFINE_SPINLOCK(vga_user_lock);
> +
>  static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  {
>  	struct vga_device *vgadev;
> +	struct vga_arb_private *priv;
>  	unsigned long flags;
>  	bool ret = true;
> +	int i;
>  
>  	spin_lock_irqsave(&vga_lock, flags);
>  	vgadev = vgadev_find(pdev);
> @@ -845,6 +867,21 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
>  	wake_up_all(&vga_wait_queue);
>  bail:
>  	spin_unlock_irqrestore(&vga_lock, flags);
> +	if (ret) {
> +		spin_lock_irqsave(&vga_user_lock, flags);
> +		list_for_each_entry(priv, &vga_user_list, list) {
> +			if (priv->target == pdev)
> +				priv->target = PCI_INVALID_CARD;
> +			for (i = 0; i < MAX_USER_CARDS; i++) {
> +				if (priv->cards[i].pdev == pdev) {
> +					priv->cards[i].pdev = PCI_INVALID_CARD;
> +					priv->cards[i].io_cnt = 0;
> +					priv->cards[i].mem_cnt = 0;
> +				}
> +			}
> +		}
> +		spin_unlock_irqrestore(&vga_user_lock, flags);
> +	}
>  	kfree(vgadev);
>  	return ret;
>  }
> @@ -1025,27 +1062,6 @@ EXPORT_SYMBOL(vga_client_register);
>   * the arbiter.
>   */
>  
> -#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
> -#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
> -
> -/* Each user has an array of these, tracking which cards have locks */
> -struct vga_arb_user_card {
> -	struct pci_dev *pdev;
> -	unsigned int mem_cnt;
> -	unsigned int io_cnt;
> -};
> -
> -struct vga_arb_private {
> -	struct list_head list;
> -	struct pci_dev *target;
> -	struct vga_arb_user_card cards[MAX_USER_CARDS];
> -	spinlock_t lock;
> -};
> -
> -static LIST_HEAD(vga_user_list);
> -static DEFINE_SPINLOCK(vga_user_lock);
> -
> -
>  /*
>   * Take a string in the format: "PCI:domain:bus:dev.fn" and return the
>   * respective values. If the string is not in this format, return 0.
> @@ -1168,7 +1184,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		}
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1215,7 +1231,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		}
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1266,12 +1282,12 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		 */
>  
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
>  
> -		if (vga_tryget(pdev, io_state)) {
> +		if (vga_tryget(pdev, io_state) == 0) {
>  			/* Update the client's locks lists... */
>  			for (i = 0; i < MAX_USER_CARDS; i++) {
>  				if (priv->cards[i].pdev == pdev) {
> @@ -1335,7 +1351,8 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  		for (i = 0; i < MAX_USER_CARDS; i++) {
>  			if (priv->cards[i].pdev == pdev)
>  				break;
> -			if (priv->cards[i].pdev == NULL) {
> +			if (priv->cards[i].pdev == NULL ||
> +			    priv->cards[i].pdev == PCI_INVALID_CARD) {
>  				priv->cards[i].pdev = pdev;
>  				priv->cards[i].io_cnt = 0;
>  				priv->cards[i].mem_cnt = 0;
> @@ -1366,7 +1383,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
>  			goto done;
>  		}
>  		pdev = priv->target;
> -		if (priv->target == NULL) {
> +		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
>  			ret_val = -ENODEV;
>  			goto done;
>  		}
> @@ -1429,7 +1446,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
>  	list_del(&priv->list);
>  	for (i = 0; i < MAX_USER_CARDS; i++) {
>  		uc = &priv->cards[i];
> -		if (uc->pdev == NULL)
> +		if (uc->pdev == NULL || uc->pdev == PCI_INVALID_CARD)
>  			continue;
>  		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
>  			uc->io_cnt, uc->mem_cnt);

-- 
Jani Nikula, Intel
