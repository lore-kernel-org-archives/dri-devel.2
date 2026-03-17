Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B35AFED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A3D10E6E8;
	Tue, 17 Mar 2026 16:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xe9ZHC51";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED26F10E284;
 Tue, 17 Mar 2026 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773765202; x=1805301202;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=ziy5mzwnyRLrRXp/Tjr5BpkzgywLOLfkvRWSrYbqX0s=;
 b=Xe9ZHC51nI23kb8vBSkrY4FlwmxBh+DKdHVRtaS4axFTmjFXo32r92rj
 BBnMhn71mdUluoxiqALP0z35xkBodfxXfuIPVdwREi+h3NGY4qKXyqgBl
 BSSl/dRZucbNZsLvtRK/l/ZIVL71pirWf91IX2pzQ9l4qDOIxPsKvCshP
 shhWA1D2RpruEGU41xn5n5y7pXl6Wizcb5q0M8Eic1TpjpoUxhLXWvDAG
 +DeUflyMYFPEWh0EjN+RqSt32l5Mhs+XHsIPBWBb1BQxj/YKahsDI75hp
 ASpBSf7wZtdNdD2F5nqmbdzPS2is49vI5uZrotLtGhIv33pdxdaKNTzDL g==;
X-CSE-ConnectionGUID: Z16T4X+fT0quf4Uav7ujPg==
X-CSE-MsgGUID: sRi5V9mVSeSRWD/Z+aM9zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="92374982"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="92374982"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:33:22 -0700
X-CSE-ConnectionGUID: IWj8sDHFRva0jhvgpjICjQ==
X-CSE-MsgGUID: WsZOqKpVTDOU8wiPsxxcOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="245338972"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:33:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:33:14 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 17/22] platform/x86/intel/pmc/ssram: Refactor
 DEVID/PWRMBASE extraction into helper
In-Reply-To: <20260313015202.3660072-18-david.e.box@linux.intel.com>
Message-ID: <0ef8cc6a-89be-d4aa-1479-ec20d6b11e1e@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-18-david.e.box@linux.intel.com>
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

> Move DEVID/PWRMBASE extraction into pmc_ssram_get_devid_pwrmbase().
> 
> This is a preparatory refactor to place functionality in a common helper
> for reuse by a subsequent patch, while keeping behavior unchanged in this
> step.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  .../platform/x86/intel/pmc/ssram_telemetry.c  | 31 ++++++++++++-------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index 9c3d7ba2fd52..75a80a74a069 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -27,6 +27,23 @@ DEFINE_FREE(pmc_ssram_telemetry_iounmap, void __iomem *, if (_T) iounmap(_T))
>  static struct pmc_ssram_telemetry pmc_ssram_telems[3];
>  static bool device_probed;
>  
> +static inline u64 get_base(void __iomem *addr, u32 offset)
> +{
> +	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);

A pre-existing problem: Header for GENMASK_ULL() is missing from this 
file.

I also would prefer having that field named with define but that too is a 
pre-existing thing.

-- 
 i.


> +}
> +
> +static void pmc_ssram_get_devid_pwrmbase(void __iomem *ssram, unsigned int pmc_idx)
> +{
> +	u64 pwrm_base;
> +	u16 devid;
> +
> +	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
> +	devid = readw(ssram + SSRAM_DEVID_OFFSET);
> +
> +	pmc_ssram_telems[pmc_idx].devid = devid;
> +	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
> +}
> +
>  static int
>  pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void __iomem *ssram)
>  {
> @@ -63,18 +80,12 @@ pmc_ssram_telemetry_add_pmt(struct pci_dev *pcidev, u64 ssram_base, void __iomem
>  	return intel_vsec_register(&pcidev->dev, &info);
>  }
>  
> -static inline u64 get_base(void __iomem *addr, u32 offset)
> -{
> -	return lo_hi_readq(addr + offset) & GENMASK_ULL(63, 3);
> -}
> -
>  static int
>  pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 offset)
>  {
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *tmp_ssram = NULL;
>  	void __iomem __free(pmc_ssram_telemetry_iounmap) *ssram = NULL;
> -	u64 ssram_base, pwrm_base;
> -	u16 devid;
> +	u64 ssram_base;
>  
>  	ssram_base = pci_resource_start(pcidev, 0);
>  	tmp_ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
> @@ -99,11 +110,7 @@ pmc_ssram_telemetry_get_pmc(struct pci_dev *pcidev, unsigned int pmc_idx, u32 of
>  		ssram = no_free_ptr(tmp_ssram);
>  	}
>  
> -	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
> -	devid = readw(ssram + SSRAM_DEVID_OFFSET);
> -
> -	pmc_ssram_telems[pmc_idx].devid = devid;
> -	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
> +	pmc_ssram_get_devid_pwrmbase(ssram, pmc_idx);
>  
>  	/* Find and register and PMC telemetry entries */
>  	return pmc_ssram_telemetry_add_pmt(pcidev, ssram_base, ssram);
> 
