Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DABFED9E4
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 15:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D79310E62D;
	Tue, 17 Mar 2026 15:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FinEDihE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EB1D10E6C4;
 Tue, 17 Mar 2026 15:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773762159; x=1805298159;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=iX6jD1U9gQtTUg8EF6Th7PnyhGEYgd3XdX2n0E4+RHw=;
 b=FinEDihEVU/nY7MChX1X/w1V26CyUZSy7YumRvRCwqQNhE9+SOi18qRi
 QchW2EQuQkIa1m5CVqUs/tOculam4M5UY4KmpbrKvhtcsWI/2fysbcuvO
 qERiYL33O0xittZxU4uPjhigQ5yDLWq9IRFkTNEeYtAMhryuB2OxQFSFh
 9Ma/AV/e9LzyRndBY5H4+FTIgTkGQEybCs6QG4s5MwKF9/w2E9Nr3Txp3
 2OC6l0WNLhZmtyBywbDd0LbfLi9N3d+90IQB2jojLr/xGZoRDBGqFw1GJ
 /Gt9Hf9wLvc6olIucvUeZzbnnihfolR1uOieXLhgKNbApiR/xUEz+TmWX A==;
X-CSE-ConnectionGUID: Y7qwPfxfR8G3/R0enkyG9Q==
X-CSE-MsgGUID: R98WAHvRTYeaIgTr1D2g7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74830741"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="74830741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:42:38 -0700
X-CSE-ConnectionGUID: mW/yk7ndQGKNkDUZD61GPw==
X-CSE-MsgGUID: IT8GJBksQWyz7A4Zk+2gJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="226989845"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.161])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 08:42:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:42:30 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
 irenic.rajneesh@gmail.com, srinivas.pandruvada@linux.intel.com, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 xi.pardee@linux.intel.com, Hans de Goede <hansg@kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 10/22] platform/x86/intel/pmt: Move header decode into
 common helper
In-Reply-To: <20260313015202.3660072-11-david.e.box@linux.intel.com>
Message-ID: <b429177a-178e-f72d-c591-4f1eaa9d8fea@linux.intel.com>
References: <20260313015202.3660072-1-david.e.box@linux.intel.com>
 <20260313015202.3660072-11-david.e.box@linux.intel.com>
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

> Unify PMT discovery table parsing by moving header decode logic into the
> class driver. A new helper, pmt_read_header(), now fills in the standard
> header fields from the discovery table, replacing the per-namespace
> pmt_header_decode callbacks in telemetry and crashlog.
> 
> This centralizes the discovery table bit-field definitions in class.h,
> removes duplicate decode code from telemetry and crashlog, and prepares the
> PMT class for additional discovery sources.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c     | 38 +++++++++++++++-------
>  drivers/platform/x86/intel/pmt/class.h     | 15 +++++++--
>  drivers/platform/x86/intel/pmt/crashlog.c  | 17 ----------
>  drivers/platform/x86/intel/pmt/telemetry.c | 26 ---------------
>  4 files changed, 40 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index 9b315334a69b..a4d6ffed2fed 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -8,6 +8,7 @@
>   * Author: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/kernel.h>
>  #include <linux/log2.h>
>  #include <linux/intel_vsec.h>
> @@ -368,26 +369,41 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
>  	return ret;
>  }
>  
> -int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespace *ns,
> -			 struct intel_vsec_device *intel_vsec_dev, int idx)
> +static int pmt_read_header(struct intel_vsec_device *ivdev, int idx,
> +			   struct intel_pmt_entry *entry)
>  {
> -	struct device *dev = &intel_vsec_dev->auxdev.dev;
> -	struct resource	*disc_res;
> -	int ret;
> +	struct intel_pmt_header *header = &entry->header;
> +	struct device *dev = &ivdev->auxdev.dev;
> +	u64 headers[2];
>  
> -	disc_res = &intel_vsec_dev->resource[idx];
> -
> -	entry->disc_table = devm_ioremap_resource(dev, disc_res);
> +	entry->disc_table = devm_ioremap_resource(dev, &ivdev->resource[idx]);
>  	if (IS_ERR(entry->disc_table))
>  		return PTR_ERR(entry->disc_table);
>  
> +	memcpy_fromio(headers, entry->disc_table, 2 * sizeof(u64));
> +
> +	header->access_type = FIELD_GET(PMT_ACCESS_TYPE, headers[0]);
> +	header->telem_type = FIELD_GET(PMT_TELEM_TYPE, headers[0]);
> +	/* Size is measured in DWORDS, but accessor returns bytes */
> +	header->size = PMT_GET_SIZE(FIELD_GET(PMT_SIZE, headers[0]));

IMO, the FIELD_GET() could be done within the macro as the macro itself 
is PMT SIZE specific.

Perhaps name it such that the name indicates unit as you currently end up 
using comments to explain that.

> +	header->guid = FIELD_GET(PMT_GUID32, headers[0]);
> +	header->base_offset = FIELD_GET(PMT_BASE_OFFSET, headers[1]);
> +
> +	return 0;
> +}
> +
> +int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespace *ns,
> +			 struct intel_vsec_device *intel_vsec_dev, int idx)
> +{
> +	int ret;
> +
>  	if (ns->pmt_pre_decode) {
>  		ret = ns->pmt_pre_decode(intel_vsec_dev, entry);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	ret = ns->pmt_header_decode(entry, dev);
> +	ret = pmt_read_header(intel_vsec_dev, idx, entry);
>  	if (ret)
>  		return ret;
>  
> @@ -397,11 +413,11 @@ int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespa
>  			return ret;
>  	}
>  
> -	ret = intel_pmt_populate_entry(entry, intel_vsec_dev, disc_res);
> +	ret = intel_pmt_populate_entry(entry, intel_vsec_dev, &intel_vsec_dev->resource[idx]);
>  	if (ret)
>  		return ret;
>  
> -	return intel_pmt_dev_register(entry, ns, dev);
> +	return intel_pmt_dev_register(entry, ns, &intel_vsec_dev->auxdev.dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(intel_pmt_dev_create, "INTEL_PMT");
>  
> diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
> index 8a0db0ef58c1..06f90c7ce6b3 100644
> --- a/drivers/platform/x86/intel/pmt/class.h
> +++ b/drivers/platform/x86/intel/pmt/class.h
> @@ -11,6 +11,19 @@
>  
>  #include "telemetry.h"
>  
> +/* PMT Discovery Table DWORD 1 */
> +#define PMT_ACCESS_TYPE		GENMASK_ULL(3, 0)
> +#define PMT_TELEM_TYPE		GENMASK_ULL(7, 4)
> +#define PMT_SIZE		GENMASK_ULL(27, 12)
> +#define PMT_GUID32		GENMASK_ULL(63, 32)
> +
> +/* PMT Discovery Table DWORD 2 */
> +#define PMT_BASE_OFFSET		GENMASK_ULL(31, 0)
> +#define PMT_TELE_ID		GENMASK_ULL(63, 32)
> +
> +/* Get size bytes from DWORDs */
> +#define PMT_GET_SIZE(v)		((v) << 2)

Use (v) * sizeof(u32) or something along those lines.

> +
>  /* PMT access types */
>  #define ACCESS_BARID		2
>  #define ACCESS_LOCAL		3
> @@ -61,8 +74,6 @@ struct intel_pmt_entry {
>  struct intel_pmt_namespace {
>  	const char *name;
>  	struct xarray *xa;
> -	int (*pmt_header_decode)(struct intel_pmt_entry *entry,
> -				 struct device *dev);
>  	int (*pmt_pre_decode)(struct intel_vsec_device *ivdev,
>  			      struct intel_pmt_entry *entry);
>  	int (*pmt_post_decode)(struct intel_vsec_device *ivdev,
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
> index f936daf99e4d..67795e2cb1ed 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -516,28 +516,11 @@ static int pmt_crashlog_pre_decode(struct intel_vsec_device *ivdev,
>  	return 0;
>  }
>  
> -static int pmt_crashlog_header_decode(struct intel_pmt_entry *entry,
> -				      struct device *dev)
> -{
> -	void __iomem *disc_table = entry->disc_table;
> -	struct intel_pmt_header *header = &entry->header;
> -
> -	header->access_type = GET_ACCESS(readl(disc_table));
> -	header->guid = readl(disc_table + GUID_OFFSET);
> -	header->base_offset = readl(disc_table + BASE_OFFSET);
> -
> -	/* Size is measured in DWORDS, but accessor returns bytes */
> -	header->size = GET_SIZE(readl(disc_table + SIZE_OFFSET));

The macros become unused after this but were not removed?

Overall, this change is nice consolidation. :-)

-- 
 i.

> -
> -	return 0;
> -}
> -
>  static DEFINE_XARRAY_ALLOC(crashlog_array);
>  static struct intel_pmt_namespace pmt_crashlog_ns = {
>  	.name = "crashlog",
>  	.xa = &crashlog_array,
>  	.pmt_pre_decode = pmt_crashlog_pre_decode,
> -	.pmt_header_decode = pmt_crashlog_header_decode,
>  };
>  
>  /*
> diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
> index d22f633638be..80773e3c3efa 100644
> --- a/drivers/platform/x86/intel/pmt/telemetry.c
> +++ b/drivers/platform/x86/intel/pmt/telemetry.c
> @@ -27,14 +27,6 @@
>  
>  #include "class.h"
>  
> -#define TELEM_SIZE_OFFSET	0x0
> -#define TELEM_GUID_OFFSET	0x4
> -#define TELEM_BASE_OFFSET	0x8
> -#define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
> -#define TELEM_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
> -/* size is in bytes */
> -#define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
> -
>  /* Used by client hardware to identify a fixed telemetry entry*/
>  #define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
>  
> @@ -69,23 +61,6 @@ static bool pmt_telem_region_overlaps(struct device *dev, u32 guid, u32 type)
>  	return false;
>  }
>  
> -static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
> -				   struct device *dev)
> -{
> -	void __iomem *disc_table = entry->disc_table;
> -	struct intel_pmt_header *header = &entry->header;
> -
> -	header->access_type = TELEM_ACCESS(readl(disc_table));
> -	header->guid = readl(disc_table + TELEM_GUID_OFFSET);
> -	header->base_offset = readl(disc_table + TELEM_BASE_OFFSET);
> -
> -	/* Size is measured in DWORDS, but accessor returns bytes */
> -	header->size = TELEM_SIZE(readl(disc_table));
> -	header->telem_type = TELEM_TYPE(readl(entry->disc_table));
> -
> -	return 0;
> -}
> -
>  static int pmt_telem_post_decode(struct intel_vsec_device *ivdev,
>  				 struct intel_pmt_entry *entry)
>  {
> @@ -135,7 +110,6 @@ static DEFINE_XARRAY_ALLOC(telem_array);
>  static struct intel_pmt_namespace pmt_telem_ns = {
>  	.name = "telem",
>  	.xa = &telem_array,
> -	.pmt_header_decode = pmt_telem_header_decode,
>  	.pmt_post_decode = pmt_telem_post_decode,
>  	.pmt_add_endpoint = pmt_telem_add_endpoint,
>  };
> 

