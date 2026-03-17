Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81D3FED9EB
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BE5410E2EC;
	Tue, 17 Mar 2026 16:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QBCP/xWd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4555410E2E0;
 Tue, 17 Mar 2026 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773765638; x=1805301638;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=ErDoNqmdfvI8zEo6cscTenfa54srxtznU3JSlSnTm+g=;
 b=QBCP/xWdEiFOR7zaNnGrHysFlJ6fTdEZPHxEHR/DegDMv2LVOlzozalc
 Y0H5g9Y5IUdWLoTvLQB2cMvDboc5ob9hKXlVQYIARUNI2b3OJsO5zoA7l
 DXZEwBULxiiPwJfyOrD8U3gmRDlfxA/bvMj2+kG9QTnXvXeN/nZK5uhLK
 pnNLSM1txI6E9AzIdrf9iI2klStJ1HTzR8YQoHioBFO2u46sFEgrWHGbH
 5B8s146xoF2ExegbhSBW6tL6xk3uWro5gspwthxz6JX7o7CC/ea+nlepO
 7GhpViLyXuj3qK2CyOe2LQKO6pUkZNYizdQNtI63RKejJ0dXa/PyU4FDk Q==;
X-CSE-ConnectionGUID: Q5fiJDvfQLqOnlwwencjAA==
X-CSE-MsgGUID: 2OUsy/AtTvqzGntVSEDZDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85882364"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="85882364"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:40:38 -0700
X-CSE-ConnectionGUID: DmM292vxQDaDRmHOoodWLA==
X-CSE-MsgGUID: YMttSmMAS6SvndZFtYU/hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="217997087"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 09:40:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 18:40:30 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 19/22] platform/x86/intel/pmc/ssram: Refactor memory
 barrier for reentrant probe
In-Reply-To: <20260313015202.3660072-20-david.e.box@linux.intel.com>
Message-ID: <73d77db4-d7bf-d62c-8245-e16aaec777b1@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-20-david.e.box@linux.intel.com>
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

> From: Xi Pardee <xi.pardee@linux.intel.com>
> 
> Switch the readiness synchronization from a global device_probed flag to
> per-index devid publication.

It would be nice if you could expand the synchronization explanation a 
bit. It's mostly in the comments below but it wouldn't hurt to add it here 
as well.

> This is required because a subsequent patch
> makes probe reentrant, so a single global flag can no longer reliably
> signal completion.
> 
> Signed-off-by: Xi Pardee <xi.pardee@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  .../platform/x86/intel/pmc/ssram_telemetry.c  | 34 ++++++++-----------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/ssram_telemetry.c b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> index 7db98037c521..246efdcf6950 100644
> --- a/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> +++ b/drivers/platform/x86/intel/pmc/ssram_telemetry.c
> @@ -37,7 +37,6 @@ static const struct ssram_type pci_main = {
>  };
>  
>  static struct pmc_ssram_telemetry pmc_ssram_telems[3];
> -static bool device_probed;
>  
>  static inline u64 get_base(void __iomem *addr, u32 offset)
>  {
> @@ -52,8 +51,13 @@ static void pmc_ssram_get_devid_pwrmbase(void __iomem *ssram, unsigned int pmc_i
>  	pwrm_base = get_base(ssram, SSRAM_PWRM_OFFSET);
>  	devid = readw(ssram + SSRAM_DEVID_OFFSET);
>  
> -	pmc_ssram_telems[pmc_idx].devid = devid;
>  	pmc_ssram_telems[pmc_idx].base_addr = pwrm_base;
> +	/*
> +	 * Memory barrier is used to ensure the correct write order between base_addr
> +	 * and devid.
> +	 */
> +	smp_wmb();
> +	pmc_ssram_telems[pmc_idx].devid = devid;
>  }
>  
>  static int
> @@ -151,32 +155,28 @@ static int pmc_ssram_telemetry_pci_init(struct pci_dev *pcidev)
>   * * 0           - Success
>   * * -EAGAIN     - Probe function has not finished yet. Try again.
>   * * -EINVAL     - Invalid pmc_idx
> - * * -ENODEV     - PMC device is not available
>   */
>  int pmc_ssram_telemetry_get_pmc_info(unsigned int pmc_idx,
>  				     struct pmc_ssram_telemetry *pmc_ssram_telemetry)
>  {
> +	if (pmc_idx >= MAX_NUM_PMC)
> +		return -EINVAL;
> +
>  	/*
>  	 * PMCs are discovered in probe function. If this function is called before
> -	 * probe function complete, the result would be invalid. Use device_probed
> -	 * variable to avoid this case. Return -EAGAIN to inform the consumer to call
> +	 * probe function complete, the result would be invalid. Use devid to avoid
> +	 * this case. Return -EAGAIN to inform the consumer to call
>  	 * again later.
>  	 */
> -	if (!device_probed)
> +	if (!pmc_ssram_telems[pmc_idx].devid)
>  		return -EAGAIN;
>  
> +	pmc_ssram_telemetry->devid = pmc_ssram_telems[pmc_idx].devid;
>  	/*
>  	 * Memory barrier is used to ensure the correct read order between
> -	 * device_probed variable and PMC info.
> +	 * devid variable and base_addr.
>  	 */
>  	smp_rmb();
> -	if (pmc_idx >= MAX_NUM_PMC)
> -		return -EINVAL;
> -
> -	if (!pmc_ssram_telems[pmc_idx].devid)
> -		return -ENODEV;
> -
> -	pmc_ssram_telemetry->devid = pmc_ssram_telems[pmc_idx].devid;
>  	pmc_ssram_telemetry->base_addr = pmc_ssram_telems[pmc_idx].base_addr;
>  	return 0;
>  }
> @@ -209,12 +209,6 @@ static int pmc_ssram_telemetry_probe(struct pci_dev *pcidev, const struct pci_de
>  		ret = -EINVAL;
>  
>  probe_finish:

This label becomes pointless after the removal and the gotoers should just 
return directly.

> -	/*
> -	 * Memory barrier is used to ensure the correct write order between PMC info
> -	 * and device_probed variable.
> -	 */
> -	smp_wmb();
> -	device_probed = true;
>  	return ret;

-- 
 i.

