Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6020CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348BE10E39B;
	Thu, 14 May 2026 08:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="O6+3Gks6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DF9910E382;
 Thu, 14 May 2026 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778747765; x=1810283765;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aJLLTyRMLEAGSJa7N0aHnU6a9CRNGaFQ7l1XGulOEa4=;
 b=O6+3Gks69mFPzbh1XWDOC05TyHny8PpD60nBN0bMoevUkTOzLMhmFxJD
 TZxCPN/odXjUSNv9LPp4D90pjgEn71KLXdvNwR+vcl9VXoaf2VsIs1R+W
 fNs2gZSHCXeb07ST2sJeOrhDcJavnK7jEI5VknMsz80TWspqwGGa7n3E0
 32Gsrhuj4dm0bKQFwHSTSzFJ0RV5VMJVkXRkcfz7g1WThO/9z4yugQc6k
 S/X1bqzNeLBM2AcNgxti/ymB3qDAiMoSQpkH0qwF3I6eQme14k2mSLJOi
 XrugHR+DdkXJpHrjMvB45o/meZTzOGlMF4jRc8GWFtA5e+gAVsIWBnznb g==;
X-CSE-ConnectionGUID: Rl+VuhZyROCjZkKuH9Exxg==
X-CSE-MsgGUID: H0gBha3ZSVKzCNmHleWzGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90379242"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90379242"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:36:04 -0700
X-CSE-ConnectionGUID: bERuLJ/xTyCupiYBrlJ2gA==
X-CSE-MsgGUID: JTftsTYiRXKYXs1vaTgskg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242323042"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:36:01 -0700
Date: Thu, 14 May 2026 10:35:57 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 5/5] drm/xe: Suppress Surprise Link Down on
 non-hotplug device
Message-ID: <agWJbWQXA9XJnool@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132614.1793083-12-mallesh.koujalagi@intel.com>
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

On Tue, May 12, 2026 at 06:56:20PM +0530, Mallesh Koujalagi wrote:
> If the slot is not hotplug capable, pcie_suppress_surprise_link_down()
> masks the Surprise Link Down bit (PCI_ERR_UNC_SURPDN) in the USP's AER
> Uncorrectable Error Mask register before punit_error_handler()
> triggers the cold reset.

Can you please elaborate on the "why" part? Is this something Intel
specific?

> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
>  drivers/gpu/drm/xe/xe_ras.c | 51 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 604470565bf3..67b4f25370c9 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -224,8 +224,59 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_device *
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
>  
> +#ifdef CONFIG_PCIEAER
> +static bool pcie_slot_is_hotplug_capable(struct pci_dev *usp)

Shouldn't all of it be part of xe_pci_error.c?

> +{
> +	struct pci_dev *root_port = pci_upstream_bridge(usp);
> +	u32 sltcap;
> +
> +	if (!root_port)
> +		return false;
> +
> +	if (pcie_capability_read_dword(root_port, PCI_EXP_SLTCAP, &sltcap))
> +		return false;
> +
> +	return (sltcap & (PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP)) ==
> +		(PCI_EXP_SLTCAP_HPC | PCI_EXP_SLTCAP_PCP);
> +}
> +
> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
> +{
> +	u32 aer_uncorr_mask;
> +	u16 aer_cap;
> +
> +	aer_cap = usp->aer_cap;
> +	if (!aer_cap)
> +		return;
> +
> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
> +	dev_dbg(&usp->dev, "Non-hotplug slot: Surprise Link Down masked for cold reset\n");

So is it required for all devices that want to use cold-reset method
generically? If yes, shouldn't this be part of recovery script or atleast
documented somewhere?

Raag

> +}
> +#endif /* CONFIG_PCIEAER */
> +
>  static void punit_error_handler(struct xe_device *xe)
>  {
> +#ifdef CONFIG_PCIEAER
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct pci_dev *vsp, *usp;
> +
> +	/*
> +	 * Device Hierarchy:
> +	 *
> +	 * Root Port --> Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit
> +	 *
> +	 * Cold reset power-cycles the slot, dropping the PCIe link. On a non-hotplug
> +	 * slot this triggers a spurious Surprise Link Down AER event on the USP.
> +	 * Suppress it if the slot is not hotplug capable.
> +	 */
> +	vsp = pci_upstream_bridge(pdev);
> +	usp = vsp ? pci_upstream_bridge(vsp) : NULL;
> +
> +	if (usp && !pcie_slot_is_hotplug_capable(usp))
> +		pcie_suppress_surprise_link_down(usp);
> +#endif
>  	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>  	xe_device_declare_wedged(xe);
>  }
> -- 
> 2.34.1
> 
