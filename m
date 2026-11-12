Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B94C606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0HYexEU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C561A10E453;
	Thu, 12 Nov 2026 04:42:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1866C10EA5A;
 Thu, 12 Nov 2026 04:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794458519; x=1825994519;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=to9WP0yYAsg2FwMUJoPAJl9KXn//Llym/25xqUG9m3o=;
 b=j0HYexEUv97gtHZ64HDRAPDkdXQSrCwRqokDMo4PofFUgp0aGVabSlR5
 FpHoBadUy7O2D3nY9+lMQo1ZDdydZjKs0BcTj5lB1Roe5Xgs1F64/3YDS
 yLosYWMo7SUad6SxxMCgoq9INuA1fWfIxkEjDt1sfNYlIsgOU2l+BrHMY
 fc1Z1qFPhRWld1yFH/oYJjmXk9ab+jqrB+Ysb2AExkPWZvhwsMaDKq9qJ
 rX0aPbqRaHFC9CYZDh8LADPMQArxF3PeRPvDrr7XKtUXG+BZq33cy30Uo
 XVFzHsBjPstV2oRL82QurujZsRR61qLMuXfm8enXEA//KFeQGj5uip2QA g==;
X-CSE-ConnectionGUID: +9s4O1T6SRervPfbLOWBiQ==
X-CSE-MsgGUID: FVcy2mHZSOOA0i+RWjNwBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3112113"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3112113"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 20:41:58 -0800
X-CSE-ConnectionGUID: +omkRXtHQhGqp8nFWjl2Wg==
X-CSE-MsgGUID: PkOyTieZTVC7Yy4/j9hDKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10451688"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2026 20:41:51 -0800
Date: Thu, 12 Nov 2026 05:41:48 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Hans de Goede <hansg@kernel.org>,
 Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH 2/7] drm/i915: Include <asm/cpu_device_id.h>
 unconditionally
Message-ID: <avVDjIW5jd4rHw11@black.igk.intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-3-pavel.e.popov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111234821.4814-3-pavel.e.popov@intel.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cc: Andy

On Wed, Nov 11, 2026 at 04:48:15PM -0700, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>. The CPU
> match table still needs CONFIG_X86 for the INTEL_* model defines.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>

> ---
> Depends on <asm-generic/cpu_device_id.h> from [1]; please apply after
> it is in mainline.
> 
> [1] https://lore.kernel.org/r/20261111234439.4098-1-pavel.e.popov@intel.com
> 
>  drivers/gpu/drm/i915/intel_cpu_info.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_cpu_info.c b/drivers/gpu/drm/i915/intel_cpu_info.c
> index e52d0ac713a..a6b46cc841a 100644
> --- a/drivers/gpu/drm/i915/intel_cpu_info.c
> +++ b/drivers/gpu/drm/i915/intel_cpu_info.c
> @@ -6,12 +6,11 @@
>   * intel_device_info.h by having a separate file.
>   */
>  
> +#include <asm/cpu_device_id.h>
> +
>  #include "intel_cpu_info.h"
>  
>  #ifdef CONFIG_X86
> -#include <asm/cpu_device_id.h>
> -#include <asm/intel-family.h>
> -
>  static const struct x86_cpu_id g8_cpu_ids[] = {
>  	X86_MATCH_VFM(INTEL_ALDERLAKE,		NULL),
>  	X86_MATCH_VFM(INTEL_ALDERLAKE_L,	NULL),
> -- 
> 2.54.0
> 
