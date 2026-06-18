Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511EDCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9695310E118;
	Thu, 18 Jun 2026 13:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Dy5F9Qc2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57BD10F2E5;
 Thu, 18 Jun 2026 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781789100; x=1813325100;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kHCk/5ki+SIvwikN84H7hGnfod1CiftPP8kvPK+XFbk=;
 b=Dy5F9Qc2E9oo66gR2I3GbNGr6sfuzOyloUQP/owm0agLe6hbVavgqVCf
 JKEwqMAdXTjYKw2ZU+qzEjWwpsEpeNW6HgdcKhDuAmTdLFDS+MfzLnl2z
 nB5TxLbsir/2EreM+L1IJy/p+sYcceCuloND5CknfnPa1q5JIHFhzpuyq
 OCrDG8qhPmbxFY5fC64vhWJYJwU8gS1XFuH3aWQy/gGINKoBoX8q+6Zcm
 DPYFBvge5wfRMt6a4aB7E1OLZqmiXHcktvWS5k6kbaUGJ0EUICYuKhren
 UWGQt5lSnB2sbJyosRcNRgvS6h0EOTlGFbIoSgJOd7lWtZdf295nP7Q7b Q==;
X-CSE-ConnectionGUID: K5cdbSE2TvSccnReBUnzPA==
X-CSE-MsgGUID: Djf+sA42SfOIe7NSTbauBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82390271"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82390271"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 06:24:59 -0700
X-CSE-ConnectionGUID: b+Uuwr1XQfqH4B335YQRWw==
X-CSE-MsgGUID: 65s54ZkmTd+rwi/SySd9TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="245440928"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 06:24:56 -0700
Date: Thu, 18 Jun 2026 15:24:53 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
Message-ID: <ajPxpevzpsUemOaL@black.igk.intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
 <20260612080722.26726-13-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612080722.26726-13-mallesh.koujalagi@intel.com>
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

On Fri, Jun 12, 2026 at 01:37:28PM +0530, Mallesh Koujalagi wrote:
> PUNIT errors can only be recovered using a power-cycle. Xe KMD
> sends a uevent to notify userspace to trigger a power cycle.
> On platforms where link drop caused by powering the device off and
> back on is reported by hardware as a Surprise Link Down (SLD), which
> AER then escalates as an Uncorrectable Fatal Error. That error fires
> before the device finishes coming back up and defeats the
> very recovery we are attempting.
> 
> To keep the expected, recovery-induced link drop from being raised as
> a fatal AER event, mask the Surprise Link Down bit
> (PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
> Mask register before punit_error_handler() requests the cold reset.
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v6:
> - Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
> - Check Slot Implemented bit before reading Slot Capabilities, per
>   PCIe spec. (Riana)
> - Add debug log.
> 
> v7:
> - Handle surprise link down event properly. (Aravind/Riana)
> - Update commit message. (Riana)
> - Correct log message.
> 
> v8:
> - Use find_usp_dev() in punit_error_handler() function.
> ---
>  drivers/gpu/drm/xe/xe_ras.c | 65 ++++++++++++++++++++++++++++---------
>  1 file changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 93a56a0269f1..15c2fa0d323a 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -209,8 +209,57 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
>  
> +static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
> +{
> +	struct pci_dev *vsp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
> +	 */
> +	vsp = pci_upstream_bridge(pdev);
> +	if (!vsp)
> +		return NULL;
> +
> +	return pci_upstream_bridge(vsp);
> +}

Unneeded churn, please make sure the function is already at the top in
the original series.

> +#ifdef CONFIG_PCIEAER
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u32 aer_uncorr_mask;
> +	u16 aer_cap;
> +
> +	aer_cap = usp->aer_cap;
> +	if (!aer_cap) {
> +		dev_dbg(&usp->dev,
> +			"AER capability not present\n");
> +		return;
> +	}
> +
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");

What about when we come back on after successful recovery? Do we need to
unmask it?

Raag

> +}
> +#endif /* CONFIG_PCIEAER */
> +
>  static void punit_error_handler(struct xe_device *xe)
>  {
> +#ifdef CONFIG_PCIEAER
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *usp;
> +
> +	/*
> +	 * Cold reset power-cycles the slot, dropping the PCIe link. The
> +	 * slot triggers a spurious Surprise Link Down AER event on the USP.
> +	 */
> +	usp = find_usp_dev(pdev);
> +
> +	if (usp)
> +		pcie_suppress_surprise_link_down(usp);
> +#endif
>  	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>  	xe_device_declare_wedged(xe);
>  }
> @@ -503,22 +552,6 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>  	return XE_RAS_RECOVERY_ACTION_RESET;
>  }
>  
> -static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
> -{
> -	struct pci_dev *vsp;
> -
> -	/*
> -	 * Device Hierarchy:
> -	 *
> -	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
> -	 */
> -	vsp = pci_upstream_bridge(pdev);
> -	if (!vsp)
> -		return NULL;
> -
> -	return pci_upstream_bridge(vsp);
> -}
> -
>  static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
>  {
>  	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> -- 
> 2.34.1
> 
