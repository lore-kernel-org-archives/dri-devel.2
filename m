Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9AFC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:36:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FBC10E239;
	Fri, 28 Aug 2026 11:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VwIo53V+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A1F710E239;
 Fri, 28 Aug 2026 11:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787917001; x=1819453001;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9YKdcLhe7UZeKAFGuCUob36BW0ql1LLsWaTM6OLyBX8=;
 b=VwIo53V+SSafkJp6mD9C5x2DF8kCR1AHKlLmgdeeAY6sdZ93/h9MNCf0
 J9bv+3pl5ajGFJT6Ykjts/gMmRrbcxsSTEYDsRqpEfwc2ITuhtbcfqc+6
 iA9mbb2ZRYPcJRNM7mPRXWaOOI1HxNqz4b6DhcIi6YGkI+N+6OuPNUyKh
 StGsL9V83Uda9YcMj6eFC85cqdsRb4cn0o2gLc+29N8u6lfGwnZchsVxc
 OoNFZNtL4iFVmzeSqXXXi7BCGhZxC5X7/bpbOf4FkhHHLRkb6KHhKvj01
 /7cCq9pWqiYAJDOxjGWOjUNUxpCPYQFLzMj5arX0JoR866rpOTqeR6zvh Q==;
X-CSE-ConnectionGUID: RrZ9qhcuQr+Gr34ibF3eXw==
X-CSE-MsgGUID: qCpxcwYTREmoLAepVKIz2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99090081"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="99090081"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 04:36:41 -0700
X-CSE-ConnectionGUID: ZQ5n4jfoTXGD3sIQBfq8jA==
X-CSE-MsgGUID: +VeUM9iLQ1qptEsnfM6oLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="266815115"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 04:36:40 -0700
Date: Fri, 28 Aug 2026 13:36:36 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com
Subject: Re: [PATCH 2/13] drm/xe: Separate AER reset state from device wedging
Message-ID: <apFyxAB1BYB0qtRh@black.igk.intel.com>
References: <20260827101801.1247654-3-arvind.yadav@intel.com>
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

Cc: Riana

On Thu, Aug 27, 2026 at 03:47:50PM +0530, Arvind Yadav wrote:
> PCI error recovery currently uses xe->wedged.flag to block driver
> access. This mixes a temporary AER reset with a permanent device wedge.
> 
> If the device wedges during AER recovery, the wedge is not seen as the
> first transition. The AER resume callback may then clear the flag and
> make the permanently wedged device appear usable again.
> 
> Keep the old device blocked while slot reset removes it, and block the
> new device until the AER resume callback.
> 
> The old AER path took a runtime PM reference to balance
> xe_device_wedged_fini(), which drops one when wedged.flag is set. AER no
> longer sets that flag, so keeping the Xe-owned reference would leak it.
> pcie_do_recovery() holds a PCI-core runtime PM reference across the
> error_detected, slot_reset and resume callbacks.

...

> +/*
> + * Return true when device access must be blocked either permanently because
> + * the device is wedged or temporarily while PCI error recovery is running.
> + *
> + * Do not use this helper for one-way wedged-device decisions such as DMA
> + * isolation, IRQ resume suppression or recovery-method reporting.
> + */
> +static inline bool xe_device_io_blocked(struct xe_device *xe)
> +{
> +	return xe_device_wedged(xe) || xe_device_is_in_reset(xe);
> +}

This is already documented below but still FYI:

The long term plan to reuse FLR flow[1] in AER path and move over from
'reset' states to temporary wedging.

Raag

[1] https://patchwork.freedesktop.org/series/162055/

> @@ -116,7 +116,6 @@ static pci_ers_result_t xe_pci_error_slot_reset(struct pci_dev *pdev)
>  	 * TODO: optimize by re-initializing only the hardware state and re-creating
>  	 * kernel BOs.
>  	 */
> -	xe_device_clear_in_reset(xe);
>  	pdev->driver->remove(pdev);
>  	devres_release_group(&pdev->dev, xe->devres_group);
