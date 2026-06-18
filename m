Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397F2CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AB510F278;
	Thu, 18 Jun 2026 11:13:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HyAvz85d";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEAA510F278;
 Thu, 18 Jun 2026 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781781195; x=1813317195;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=SexmYc3raGJTTWWvAJwngK2R5oweGHq9hSkCaNk/t7E=;
 b=HyAvz85d22k+aBSE5NYV7FzvbZ49pIniecYB+DSrpp0AETGpfgTqbtHN
 EfH7+HivA1VSwmGkhJaheEtF6RhTwFnNdxXLdzNEGBSd8eW29aSsxz5xo
 rDQAkQkJOrkIqhGQD+1XbIN3grCbBW49lzDEc8ae6LszyflkLbZWjV2jS
 NtKbJF7zrmpABZ0pc6RKUsWqNGZN7vNvUtpW6m3YaSndwRcGRQmackEAE
 Mfav+sKw44BAMfFuIMcKU/XD4IuM0HF9fLdYKezn16tRtQprAejDk6/V1
 KcRvyH4IJvXFOKIEGD44NfKaQbCqEWjogJK8JCl9JIy6UwTCkyP3oJHMT Q==;
X-CSE-ConnectionGUID: eqp1gwOHQbWcM13RtNh4yA==
X-CSE-MsgGUID: y0kyAIttQlCXqgAtdJRASg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82510586"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82510586"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 04:13:15 -0700
X-CSE-ConnectionGUID: NodSaJeHQoWWY68QIbNlXA==
X-CSE-MsgGUID: iGItxHOSR8WwPGXbD7T0xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="253445719"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:13:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make_ruc2021@163.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, hansg@kernel.org, matthew.d.roper@intel.com,
 vivek.kasireddy@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
In-Reply-To: <20260618110446.518501-1-make_ruc2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260618110446.518501-1-make_ruc2021@163.com>
Date: Thu, 18 Jun 2026 14:13:08 +0300
Message-ID: <8f89e5af148cab8daca10ca4f7214e4e9207c29f@intel.com>
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

On Thu, 18 Jun 2026, Ma Ke <make_ruc2021@163.com> wrote:
> i2c_adapter_lookup() acquires a reference on the i2c adapter through
> i2c_acpi_find_adapter_by_handle() but not releases it.  Each
> invocation of this ACPI resource callback leaks one device reference,
> potentially leading to resource exhaustion over repeated driver
> load/unload cycles.
>
> Calling path: i2c_acpi_find_adapter_by_handle() -> bus_find_device()
> -> get_device.
>
> Found by code review.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Cc: stable@vger.kernel.org
> Fixes: 8cbf89db2941 ("drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block (v3)")
> ---
> Changes in v2:
> - Changed email to trigger CI, no code change.

Sorry, that won't do anything. Please just let us deal with it. :)

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> index fe12041e913c..2097c5d17cb7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *ares, void *data)
>  		return 1;
>  
>  	adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
> -	if (adapter)
> +	if (adapter) {
>  		intel_dsi->i2c_bus_num = adapter->nr;
> +		put_device(&adapter->dev);
> +	}
>  
>  	return 1;
>  }

-- 
Jani Nikula, Intel
