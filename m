Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D700FFED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:49:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC5410E6F8;
	Tue, 17 Mar 2026 16:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SqHiFbui";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AADC10E707;
 Tue, 17 Mar 2026 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773766145; x=1805302145;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=R4pN2m/SXwG2LuZKBUc3UdmdEsgUYR+Mb/Dp5rDVQSA=;
 b=SqHiFbui6ZhlUWLSqQxsLCf7IXlFMC3ISwTLj6NFS1La4M7MqDk3CHaA
 ZIJ/d8+ewl916smi17c4MIEAutu/QC8y3/+h2D1dUTm5afKCnxhGfy/JS
 TB7d6hdI4M0epqXVVT9+cBQQxl8nmCagQPNK3bsA2ExkvhYubVMkxJ6mr
 AiOK2gvyZmrtSzhA/GKKnDj+HGMcDhWGTmXCIbWP+quLb79kjj22Lal0a
 toESt9tMxYmKeAA2xFANsMrzRbq1YaNt7UF5XbWV9adAB+9pQXv7aX/a6
 tQzUSc+dmqTOrjwKQKP66CdPew9zQ1CxjfLFvNJg1qiQqJsX7But8evAA A==;
X-CSE-ConnectionGUID: ADkgjLOaRYCVXHdaiuI9Qg==
X-CSE-MsgGUID: jHxC9y5KQkulPkzgmvhg+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92187519"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="92187519"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:49:05 -0700
X-CSE-ConnectionGUID: zU3ku3HMSyGa8jesRJiPnQ==
X-CSE-MsgGUID: 1c1akZSfRISyWMT92A6NMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="216652640"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:49:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:48:58 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 21/22] platform/x86/intel/pmc/ssram: Make PMT registration
 optional
In-Reply-To: <20260313015202.3660072-22-david.e.box@linux.intel.com>
Message-ID: <a91e9601-689f-f2b6-b90a-7abcc66a7ee4@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-22-david.e.box@linux.intel.com>
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

> The SSRAM telemetry driver extracts essential PMC device ID and power
> management base address information that intel_pmc_core depends on for core
> functionality. PMT registration failure should not prevent this critical
> data from being available, as it would break intel_pmc_core operation

Are you missing a "not" here? I find the entire sentence hard to 
understand.

> entirely.
> 
> Change the behavior to log a warning when PMT registration fails but
> continue with successful driver initialization, ensuring the primary
> telemetry data remains accessible to dependent drivers.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/ssram_telemetry.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index b937ebb2322f..12b7c1299c2f 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -106,6 +106,7 @@ pmc_ssram_telemetry_get_pmc_pci(struct pci_dev *pcidev, unsigned int pmc_idx, u3
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *tmp_ssram = NULL;
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *ssram = NULL;
>  	u64 ssram_base;
> +	int ret;
>  
>  	ssram_base = pci_resource_start(pcidev, 0);
>  	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> @@ -133,7 +134,11 @@ pmc_ssram_telemetry_get_pmc_pci(struct pci_dev *pcidev, unsigned int pmc_idx, u3
>  	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
>  
>  	/* Find and register and PMC telemetry entries */
> -	return pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
> +	ret = pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
> +	if (ret)
> +		dev_warn(&pcidev->dev, "could not register PMT\n");
> +
> +	return 0;
>  }
>  
>  static int pmc_ssram_telemetry_pci_init(struct pci_dev *pcidev)
> @@ -208,12 +213,12 @@ static int pmc_ssram_telemetry_acpi_init(struct pci_dev *pcidev,
>  
>  	ret = intel_vsec_register(&pcidev->dev, &info);
>  	if (ret)
> -		goto cleanup_acpi_disc;
> +		dev_warn(&pcidev->dev, "could not register PMT\n");
>  
>  	ret = pmc_ssram_telemetry_get_pmc_acpi(pcidev, index);
>  
> -cleanup_acpi_disc:
>  	kfree(acpi_disc);
> +
>  cleanup_acpi_buf:
>  	ACPI_FREE(buf.pointer);
>  
> 

-- 
 i.

