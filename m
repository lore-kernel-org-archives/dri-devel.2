Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77BEFED9ED
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1630D10E1BE;
	Tue, 17 Mar 2026 16:35:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hSCt9qat";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F229110E2CD;
 Tue, 17 Mar 2026 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773765333; x=1805301333;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=QE25jXnjq2dG7lY+6OblWOj6ph+3V1500U/5yrHAVBI=;
 b=hSCt9qatmBpLTl6ysfOZzk/K6qf+vxTM40raI8+1AdiKvfHcm9zOK5oh
 D04p6q4FVaQpj/NN6JJ8Nsj5AdPnm94zmcpnbNF/As8pnCkM24RavytBj
 hpzBL5EfhNP2wv7+BIAd6T2MIoK38/MB4DelQR6bLDx7OFFSMqG439e3w
 QloLiXZyPaDt81PTnKk761BWHZTREyZW/hWzTeZR5n5BJ6JU3uLUDAycc
 wIPdsRMDvPoBm3sEyMRoiujdWIQUQLBsw7R3Q9ccOUOrsdmyDgkDZzjsx
 1sWhStI1Ra+Dzu6RFKLUDcaW0/lDyT9LdPBqmIPTW7rw85kE4IZ5jZFs9 g==;
X-CSE-ConnectionGUID: eM9BEggkSE615SfDXaclJA==
X-CSE-MsgGUID: l7tJnY1oR8aabEXmAJJ6Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73982289"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="73982289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:35:32 -0700
X-CSE-ConnectionGUID: m6NipNXDTRSVdJvfxioV0A==
X-CSE-MsgGUID: O6eFQbPnQxerbBkNEMmANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="221382815"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:35:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:35:24 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 18/22] platform/x86/intel/pmc/ssram: Add PCI platform data
In-Reply-To: <20260313015202.3660072-19-david.e.box@linux.intel.com>
Message-ID: <c6f3eab2-14c0-6332-dff0-41ff422255c3@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-19-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 12 Mar 2026, David E. Box wrote:

> Add per-device platform data for SSRAM telemetry PCI IDs and route probe
> through a method selector driven by id->driver_data.
> 
> This is a preparatory refactor for follow-on discovery methods while
> preserving current behavior: all supported IDs continue to use the PCI
> initialization path.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  .../platform/x86/intel/pmc/ssram_telemetry.c  | 69 +++++++++++++++----
>  1 file changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index 75a80a74a069..7db98037c521 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -24,6 +24,18 @@
>  
>  DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_T))
>  
> +enum resource_method {
> +	RES_METHOD_PCI,
> +};
> +
> +struct ssram_type {
> +	enum resource_method method;
> +};
> +
> +static const struct ssram_type pci_main = {
> +	.method = RES_METHOD_PCI,
> +};
> +
>  static struct pmc_ssram_telemetry pmc_ssram_telems[3];
>  static bool device_probed;
>  
> @@ -81,7 +93,7 @@ pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void __iomem
>  }
>  
>  static int
> -pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 offset)
> +pmc_ssram_telemetry_get_pmc_pci(struct pci_dev *pcidev, unsigned int pmc_idx, u32 offset)
>  {
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *tmp_ssram = NULL;
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *ssram = NULL;
> @@ -116,6 +128,20 @@ pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 of
>  	return pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
>  }
>  
> +static int pmc_ssram_telemetry_pci_init(struct pci_dev *pcidev)
> +{
> +	int ret;
> +
> +	ret = pmc_ssram_telemetry_get_pmc_pci(pcidev, PMC_IDX_MAIN, 0);
> +	if (ret)
> +		return ret;
> +
> +	pmc_ssram_telemetry_get_pmc_pci(pcidev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
> +	pmc_ssram_telemetry_get_pmc_pci(pcidev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
> +
> +	return ret;
> +}
> +
>  /**
>   * pmc_ssram_telemetry_get_pmc_info() - Get a PMC devid and base_addr information
>   * @pmc_idx:               Index of the PMC
> @@ -158,8 +184,18 @@ EXPORT_SYMBOL_GPL(pmc_ssram_telemetry_get_pmc_info);
>  
>  static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
>  {
> +	const struct ssram_type *ssram_type;
> +	enum resource_method method;
>  	int ret;
>  
> +	ssram_type = (const struct ssram_type *)id->driver_data;
> +	if (!ssram_type) {
> +		dev_dbg(&pcidev->dev, "missing driver data\n");

Add #include.

> +		ret = -EINVAL;
> +		goto probe_finish;
> +	}
> +
> +	method = ssram_type->method;
>  
>  	ret = pcim_enable_device(pcidev);
>  	if (ret) {
> @@ -167,12 +203,10 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  		goto probe_finish;
>  	}
>  
> -	ret = pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_MAIN, 0);
> -	if (ret)
> -		goto probe_finish;
> -
> -	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_IOE, SSRAM_IOE_OFFSET);
> -	pmc_ssram_telemetry_get_pmc(pcidev, PMC_IDX_PCH, SSRAM_PCH_OFFSET);
> +	if (method == RES_METHOD_PCI)
> +		ret = pmc_ssram_telemetry_pci_init(pcidev);
> +	else
> +		ret = -EINVAL;
>  
>  probe_finish:
>  	/*
> @@ -185,13 +219,20 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  }
>  
>  static const struct pci_device_id pmc_ssram_telemetry_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDH) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDP) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_WCL_PCDN) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_MTL_SOCM),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCS),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_ARL_SOCM),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_LNL_SOCM),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDH),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_PTL_PCDP),
> +		.driver_data = (kernel_ulong_t)&pci_main },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PMC_DEVID_WCL_PCDN),
> +		.driver_data = (kernel_ulong_t)&pci_main },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(pci, pmc_ssram_telemetry_pci_ids);
> 

-- 
 i.

