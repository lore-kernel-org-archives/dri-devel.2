Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18E606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZMR5EAXP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDEA10E29D;
	Wed, 25 Nov 2026 09:55:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEB710E29D;
 Wed, 25 Nov 2026 09:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795600535; x=1827136535;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=n+z4ONkDth3LAMEpm3e1qLmoHlYrXg9wa2r9okZZh3M=;
 b=ZMR5EAXPFB8qQklQa0gym0zNcLlhmJtBgjMHjlF6R0dnGh2wHhrTQgme
 XTAJ9P6d2Y2s2kglxdxDt961dErPMaTqJb1HL2XY8OxazoeADAPWglaQw
 /iwUynbaqyJ17snzRqKRh1Pp2+YwHe/P5d/L935IpdJTrAa+WtZ1A4DsC
 wjZiU+68CYrT3ea54YMLootpilQfuNrsBeLCDRyqRxWKv6ykEa12/cEOE
 C+raeZ2uLgTK1roiUA/ieb5Z6p/FsNmok/+R2gcCsJ9nhuJ/5PbzkwPSb
 jISQleFPcavWm7wMlyGSfxhhR7rPht4H3MEc0AnB/1JjescZTTxfA1qKK w==;
X-CSE-ConnectionGUID: TDV3r4ISQWq+SE2UpqXPBg==
X-CSE-MsgGUID: 1cYKbYIjQu+gKCF+6TX2dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4475756"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4475756"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 01:55:18 -0800
X-CSE-ConnectionGUID: dqoO2yQ/SWa5u+soZJRBYQ==
X-CSE-MsgGUID: WiHWsMkXTsKMCFw9iN6Yow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; d="scan'208";a="11615793"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.244.52])
 ([10.245.244.52])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 01:55:16 -0800
Message-ID: <a4789efe-4abc-4b5f-a590-3d0d4dd27b7a@intel.com>
Date: Wed, 25 Nov 2026 09:55:14 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Destroy the ttm_tt in ttm_bo_move_null() when
 it's no longer needed
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <nat@pixelcluster.dev>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20261124190954.47690-1-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 24/11/2026 19:09, Thomas Hellström wrote:
> The xe kmd uses ttm_bo_move_null() when moving an unpopulated bo to
> VRAM. In that case the bo may still carry a ttm_tt that was created
> for its deferred placement, and it is left dangling on a bo whose new
> resource doesn't use a ttm_tt.
> 
> Make ttm_bo_move_null() destroy the bo's ttm_tt when @new_mem is NULL
> or its memory type manager doesn't use a ttm_tt.
> 
> ttm_bo_tt_destroy() is internal to TTM and not exported. Rather than
> exporting it, move ttm_bo_move_null() out to ttm_bo_util.c and
> export that instead.
> 
> Patch and commit message was drafted using an LLM.
> 
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
> Cc: Natalie Vock <nat@pixelcluster.dev>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

