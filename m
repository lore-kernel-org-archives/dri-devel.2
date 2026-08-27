Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A2C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABD510F1DC;
	Thu, 27 Aug 2026 21:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KuOzBNwF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD5710E118;
 Thu, 27 Aug 2026 21:55:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C14E601EF;
 Thu, 27 Aug 2026 21:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7241F000E9;
 Thu, 27 Aug 2026 21:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787867717;
 bh=kiqsgwvcFj9SAcJpA4naMhVLx1Ac4CzihxLaw7GaD+Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KuOzBNwF8k7IaIMsAPXISACbXDgwsH5UxBcOXgh8mZDGTMjvla9IM6u8mQ1KA3gwe
 ruXjxHTpJrqCfwdpVFeUYPAIIrd805Ay9+GVYRU2JZTbfcQ7LUiRM+kIYBWc97tmlb
 eVeNX9/objuV/JRRfN7g9b/njo4X1RaSO51D/iQuRe9my/2ornjb4bnqHK9awCiHuA
 uQNBTBkHTMq0TGbPVzTL8XB0rMuLXnZy0h6lhp0lediTzVHvfTmFZHRaxFeAznuS1j
 yOYRNSPtGkzt9BMwZPxi6LOiEKm13WBvpsYep5yxeHYiiEemA1Ax5PvLufIKPCT8TP
 +bY+GI7/TQHuw==
Date: Thu, 27 Aug 2026 23:55:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Arvind Yadav <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 matthew.brost@intel.com, himal.prasad.ghimiray@intel.com, 
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: Re: [PATCH 02/13] drm/xe: Separate AER reset state from device wedging
Message-ID: <apCiNlVXlZnhxeNE@zenone.zhora.eu>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-3-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827101801.1247654-3-arvind.yadav@intel.com>
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

Hi Arvind,

> @@ -1062,7 +1062,7 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
>  	xe_gt_assert(gt, g2h_len || !num_g2h);
>  	lockdep_assert_held(&ct->lock);
>  
> -	if (xe_device_wedged(ct_to_xe(ct))) {
> +	if (xe_device_io_blocked(ct_to_xe(ct))) {
>  		ret = -ENOTRECOVERABLE;
>  		goto out;
>  	}

There is another place in this function where xe_device_wedged is
used. 

...

> @@ -20,14 +19,15 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
>  	struct xe_gt *gt;
>  	u8 id;
>  
> +

Please remove this blank line.

Thanks,
Andi

>  	/*
> -	 * Wedge the device to prevent userspace access but do not send the uevent.
> -	 * xe_device_wedged_fini() releases runtime pm if wedged flag is set, so acquire a runtime
> -	 * pm reference to avoid underflow.
> +	 * Block device access while PCI error recovery is in progress.
> +	 *
> +	 * The old runtime PM reference balanced xe_device_wedged_fini() while
