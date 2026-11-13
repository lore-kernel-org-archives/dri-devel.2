Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3157606A331
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kVy3Le0q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 357E810ECC4;
	Fri, 13 Nov 2026 21:34:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B1E10ECBF;
 Fri, 13 Nov 2026 21:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794605653; x=1826141653;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5H18aAry4/GXJ6hd2/WDeC5xY+R/z+QH0pzgy9iRGOQ=;
 b=kVy3Le0qh2EnrkBBmHiVtyIxrqVoNnkk+N3X68mUvHqQAdjH1TgoEeu4
 YezJ6Je3WUz4UTzDkJlEItV+T9g7xjmRvRy0p4zAPFXA58LjXy++h97wp
 c1NKsKoxDt+P4KfbUjs10cT0NlClEMmuGfl5solZxem/2E0uMWEgWjyeq
 fTs+eYj2rSpo8UJdNuNTEFC2yUHdLmqSeg2s92ftTlDy+X9CbOYErUFmM
 RvHfpTs7QrrKeb6Hi5L2oUUN3YigiE/IPBPdUkNvSxK6blmkhCpITAPXk
 gMnpM1D0jBhZp5/adF1341hufASYfnkKgCJBMB8MudlN5bTLm4zvXrLsO Q==;
X-CSE-ConnectionGUID: 8MdI+39/Qlqw4wc4eC+kRw==
X-CSE-MsgGUID: Xf10U74QRn6CpjHeL7FbOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3410652"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3410652"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 13:34:13 -0800
X-CSE-ConnectionGUID: 5uaN0zGOSKClUoi4WnQggg==
X-CSE-MsgGUID: v1L1tUjtRSSjwXDnysT+fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8829869"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com)
 ([10.245.244.254])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 13:34:06 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
 by kekkonen.fi.intel.com (Postfix) with SMTP id 5F3FB11F7E7;
 Fri, 13 Nov 2026 23:34:07 +0200 (EET)
Date: Fri, 13 Nov 2026 23:34:07 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 "David S . Miller" <davem@davemloft.net>, x86@kernel.org,
 linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] ACPI: mipi-disco-img: Include <asm/cpu_device_id.h>
 unconditionally
Message-ID: <aveCT1hwhMcJ_Efm@kekkonen.localdomain>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-2-pavel.e.popov@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111234821.4814-2-pavel.e.popov@intel.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 04:48:14PM -0700, Pavel Popov wrote:
> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
> 
> <asm/intel-family.h> is included by <asm/cpu_device_id.h>. The CPU
> match table still needs CONFIG_X86 for the INTEL_* model defines.
> 
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
