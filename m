Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76394FED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D629510E5A2;
	Tue, 17 Mar 2026 15:57:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JzHDjWVp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 508BF10E5A2;
 Tue, 17 Mar 2026 15:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773763076; x=1805299076;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=jzv3WbOWM4EXwEr1DFeSpYcIFn58c2oRbaYFYaYwUFE=;
 b=JzHDjWVpJNZqfnEYo2v8df8WiSBxKaiIMiaYBJ9iEC3dhcVcbLG+kqCR
 m+L3Ba5gxSOex/LQV0ar9ohWHRU3P3cNey9ZRTB6CTX0hEo1r+MTXb/iq
 9EL+qRKcroOYrzf+nHiVLdWeQ/AlcmYwPXpa+wx+TWEfvL9d1MsKKnoeH
 pe5THhlJzYhLqP9ufGGqzFmvpZzUanNqs6Nc7Jbo3rFfHesmMNul53HnH
 hra34R6NCS7GJ+W/TCKC1w9QpxmQP3KEsdBE2LvETE0K+ufFHy3NBO9kV
 YBEP3HSj0ei5isMoVs8hSwbdUSLbZCTQ+L3/gwjBcfEUM+igcMvPBz2j3 w==;
X-CSE-ConnectionGUID: loMAlT++QJWadJSP6HfRag==
X-CSE-MsgGUID: /4A+JG3zTl+JukqAfr8DHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78406274"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="78406274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:57:30 -0700
X-CSE-ConnectionGUID: H/5bcrqvR5KCBna3eX/BrA==
X-CSE-MsgGUID: wH77/1SuT8yQ0qV75JcK1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="252789482"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:57:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:57:22 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 12/22] platform/x86/intel/pmt: Unify header fetch and
 add ACPI source
In-Reply-To: <20260313015202.3660072-13-david.e.box@linux.intel.com>
Message-ID: <149de8a3-88c0-2774-af52-346da96a5557@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-13-david.e.box@linux.intel.com>
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

> Allow the PMT class to read discovery headers from either PCI MMIO or
> ACPI-provided entries, depending on the discovery source. The new
> source-aware fetch helper retrieves the first two QWORDs for both paths
> while keeping the mapped discovery table available for users such as
> crashlog.
> 
> Split intel_pmt_populate_entry() into source-specific resolvers:
>   - pmt_resolve_access_pci(): handles both ACCESS_LOCAL and ACCESS_BARID
>     for PCI-backed devices and sets entry->pcidev. Same existing
>     functionality.
>   - pmt_resolve_access_acpi(): handles only ACCESS_BARID for ACPI-backed
>     devices, rejecting ACCESS_LOCAL which has no valid semantics without
>     a physical discovery resource.
> 
> This maintains existing PCI behavior and makes no functional changes
> for PCI devices.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c | 124 +++++++++++++++++++++++--
>  1 file changed, 115 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index f94f51178043..ddd9c4bf7323 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -205,9 +205,9 @@ struct class intel_pmt_class = {
>  };
>  EXPORT_SYMBOL_GPL(intel_pmt_class);
>  
> -static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
> -				    struct intel_vsec_device *ivdev,
> -				    int idx)
> +static int pmt_resolve_access_pci(struct intel_pmt_entry *entry,
> +				  struct intel_vsec_device *ivdev,
> +				  int idx)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(ivdev->dev);
>  	struct device *dev = &ivdev->auxdev.dev;
> @@ -287,6 +287,82 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  	}
>  
>  	entry->pcidev = pci_dev;
> +
> +	return 0;
> +}
> +
> +static int pmt_resolve_access_acpi(struct intel_pmt_entry *entry,
> +				   struct intel_vsec_device *ivdev)
> +{
> +	struct pci_dev *pci_dev = NULL;
> +	struct device *dev = &ivdev->auxdev.dev;
> +	struct intel_pmt_header *header = &entry->header;
> +	u8 bir;
> +
> +	if (dev_is_pci(ivdev->dev))
> +		pci_dev = to_pci_dev(ivdev->dev);
> +
> +	/*
> +	 * The base offset should always be 8 byte aligned.
> +	 *
> +	 * For non-local access types the lower 3 bits of base offset
> +	 * contains the index of the base address register where the
> +	 * telemetry can be found.
> +	 */
> +	bir = GET_BIR(header->base_offset);
> +
> +	switch (header->access_type) {
> +	case ACCESS_BARID:
> +		/* ACPI platform drivers use base_addr */
> +		if (ivdev->base_addr) {
> +			entry->base_addr = ivdev->base_addr +
> +					   GET_ADDRESS(header->base_offset);
> +			break;
> +		}
> +
> +		/* If base_addr is not provided, then this is an ACPI companion device */
> +		if (!pci_dev) {
> +			dev_err(dev,
> +				"ACCESS_BARID requires PCI BAR resources or base_addr\n");

IMO the extra line is not very useful here.

> +			return -EINVAL;
> +		}
> +
> +		entry->base_addr = pci_resource_start(pci_dev, bir) +
> +			GET_ADDRESS(header->base_offset);
> +		break;
> +	default:
> +		dev_err(dev, "Unsupported access type %d for ACPI based PMT\n",
> +			header->access_type);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
> +				    struct intel_vsec_device *ivdev,
> +				    int idx)
> +{
> +	struct intel_pmt_header *header = &entry->header;
> +	struct device *dev = &ivdev->auxdev.dev;
> +	int ret;
> +
> +	switch (ivdev->src) {
> +	case INTEL_VSEC_DISC_PCI:
> +		ret = pmt_resolve_access_pci(entry, ivdev, idx);
> +		break;
> +	case INTEL_VSEC_DISC_ACPI:
> +		ret = pmt_resolve_access_acpi(entry, ivdev);
> +		break;
> +	default:
> +		dev_err(dev, "Unknown discovery source: %d\n", ivdev->src);
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret)
> +		return ret;

Instead of deferring to after the switch/case, I'd prefer you handle the 
errors within the cases as it, while longer by a few lines, makes 
following the logic easier.

> +
>  	entry->guid = header->guid;
>  	entry->size = header->size;
>  	entry->cb = ivdev->priv_data;
> @@ -371,18 +447,48 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  	return ret;
>  }
>  
> +static int pmt_get_headers(struct intel_vsec_device *ivdev, int idx,
> +			   struct intel_pmt_entry *entry, u64 headers[2])
> +{
> +	struct device *dev = &ivdev->auxdev.dev;
> +
> +	switch (ivdev->src) {
> +	case INTEL_VSEC_DISC_PCI: {
> +		void __iomem *disc_table;
> +
> +		disc_table = devm_ioremap_resource(dev, &ivdev->resource[idx]);
> +		if (IS_ERR(disc_table))
> +			return PTR_ERR(disc_table);
> +
> +		memcpy_fromio(headers, disc_table, 2 * sizeof(u64));
> +
> +		/* Used by crashlog driver */
> +		entry->disc_table = disc_table;
> +
> +		return 0;
> +	}
> +	case INTEL_VSEC_DISC_ACPI:
> +		memcpy(headers, &ivdev->acpi_disc[idx][0], 2 * sizeof(u64));
> +
> +		return 0;
> +	default:
> +		dev_err(dev, "Unknown discovery source type: %d\n", ivdev->src);
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int pmt_read_header(struct intel_vsec_device *ivdev, int idx,
>  			   struct intel_pmt_entry *entry)
>  {
>  	struct intel_pmt_header *header = &entry->header;
> -	struct device *dev = &ivdev->auxdev.dev;
>  	u64 headers[2];
> +	int ret;
>  
> -	entry->disc_table = devm_ioremap_resource(dev, &ivdev->resource[idx]);
> -	if (IS_ERR(entry->disc_table))
> -		return PTR_ERR(entry->disc_table);
> -
> -	memcpy_fromio(headers, entry->disc_table, 2 * sizeof(u64));
> +	ret = pmt_get_headers(ivdev, idx, entry, headers);
> +	if (ret)
> +		return ret;
>  
>  	header->access_type = FIELD_GET(PMT_ACCESS_TYPE, headers[0]);
>  	header->telem_type = FIELD_GET(PMT_TELEM_TYPE, headers[0]);
> 

-- 
 i.

