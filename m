Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF3EC79FA1
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CFE210E021;
	Mon,  7 Sep 2026 15:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HGaw0MoX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B4310E021;
 Mon,  7 Sep 2026 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788795597; x=1820331597;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=IPBkhQVHqxj0IfXD4Tzxx9fiJ4xFnHA/DZoHDEQrQYU=;
 b=HGaw0MoXTQMICJJs2fdyV0SDW6j3rpqoditoAkVPKUGvzvLh4a6+Namu
 go+ga4nQg+ip80hnrrUrSV/xxD7Yw2UM+gBDh1T65zOgwBXxcyAJPx0as
 Mo29ZFrt6lbPvwaAxaXZ91c9Qg07cs8U+RY7t15JiOg3/ZcLwF/jy4NoL
 dDHxM+/PxSkEwTFjyAemShM0a+gF6d4X/HczCifcuXtob8ZCv2DHxSeT4
 i+4TqwM4w+V+Q1fm8bl4lSOOCauA2aPh/TAHT1NdYY6gsgbkcjPCSj3Wz
 yxlRSvK+L1S55B3S2xvY/SsA6JAL9FDaLyKotVCSPpLYmKS6drUQbTFpM Q==;
X-CSE-ConnectionGUID: JZK5BQywQ0ii8ifQHrI0EQ==
X-CSE-MsgGUID: I40r38hOSW23nexeBtTblA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99858674"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="99858674"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 08:39:57 -0700
X-CSE-ConnectionGUID: JAB5ITPsSXSuPV3/WL147A==
X-CSE-MsgGUID: iQtiMoMfQ8eKammQ1m0YiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; d="scan'208";a="276018594"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 08:39:53 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Albert Esteve <aesteve@redhat.com>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Ripard
 <mripard@kernel.org>, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH 3/3] drm/amd/display: drop INLINE_IFN_KUNIT
In-Reply-To: <20260907-visibility-unification-v1-3-6a962e5b3351@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260907-visibility-unification-v1-0-6a962e5b3351@redhat.com>
 <20260907-visibility-unification-v1-3-6a962e5b3351@redhat.com>
Date: Mon, 07 Sep 2026 18:39:50 +0300
Message-ID: <6f3ee86ab60ed16348dc0ac252ba27596829dc19@intel.com>
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

On Mon, 07 Sep 2026, Albert Esteve <aesteve@redhat.com> wrote:
> This helper was originally static inline. INLINE_IFN_KUNIT only added
> inline for KUnit builds, which dropped that hint from production.
>
> There is no equivalent in kunit/visibility.h, and tests do not need
> one: they call the exported symbol from another translation unit.
> Use an unconditional inline with VISIBLE_IF_KUNIT instead so
> production stays static inline.

FWIW, using inline in a .c file is pointless in most cases, and the
compiler usually does the right thing. It might inline at a better
granularity than the manual one. (You could see what difference having
the inline makes, if any.)

BR,
Jani.


>
> kernel-doc already strips inline, so the dedicated xform can go too.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dm_helpers.h             | 7 -------
>  tools/lib/python/kdoc/xforms_lists.py                   | 1 -
>  3 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index e3f4ee6e8380..eea7e7dcfa30 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -173,7 +173,7 @@ void amdgpu_dm_init_color_mod(void)
>  }
>  EXPORT_SYMBOL_IF_KUNIT(amdgpu_dm_init_color_mod);
>  
> -VISIBLE_IF_KUNIT INLINE_IFN_KUNIT
> +VISIBLE_IF_KUNIT inline
>  struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
>  {
>  	struct fixed31_32 val;
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> index 6d7cdab1006f..cabcbc2599e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
> @@ -194,13 +194,6 @@ void dm_helpers_mccs_vcp_set(
>  		struct dc_link *link,
>  		struct dc_sink *sink);
>  
> -#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
> -#define INLINE_IFN_KUNIT inline
> -
> -#else
> -#define INLINE_IFN_KUNIT
> -#endif
> -
>  bool dm_helpers_submit_i2c_over_aux(
>  	struct ddc_service *ddc,
>  	uint32_t address,
> diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
> index b49b81da74d9..cab4a49e4fc4 100644
> --- a/tools/lib/python/kdoc/xforms_lists.py
> +++ b/tools/lib/python/kdoc/xforms_lists.py
> @@ -105,7 +105,6 @@ class CTransforms:
>          (CMatch("__attribute_const__"), ""),
>          (CMatch("__attribute__"), ""),
>          (CMatch("VISIBLE_IF_KUNIT"), ""),
> -        (CMatch("INLINE_IFN_KUNIT"), ""),
>  
>          #
>          # HACK: this is similar to process_export() hack. It is meant to

-- 
Jani Nikula, Intel
