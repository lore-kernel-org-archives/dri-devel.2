Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F877C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6688D10EEDA;
	Wed,  9 Sep 2026 06:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZA+l7Emj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CADFC10EED3;
 Wed,  9 Sep 2026 06:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788935545; x=1820471545;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=/h5dVSsvfROejpBSrh4qJEooPtApHAkZjDTpJfrhuQY=;
 b=ZA+l7EmjqprglOrQWzB0i9sufXFof/FXgFyqNqZjLnsxHJEI6lq1+Qy4
 Rs+hTFpn3ypJFF5OJ183TOF2spXA+n6/8qcYXunXVTs+8VGZfBo/UVOm9
 VpARtbDKC4dYGPz9cxe/Uo52EXG+eNRv2PB41COekxCmN6mz7ZAB5lisJ
 DMQdLHUjCCkyU5nh8ihC5edPcmw7WFV6TNKGylB3mzz2CIEBJS64Ninlb
 QFNZqHr+za7k3kFR+a8QUeDG7zP9/gTXtzcqZg/siFwEwfH56GX1qkzBt
 QSHHIHJXw2l2VO2MzpYBjp0uB8vLya7MyqvZv4I3xPYz8QgmE97+qqXcx w==;
X-CSE-ConnectionGUID: 2JH5RXQ4TpCq+djf4dfUmQ==
X-CSE-MsgGUID: sFKN2jS/SkKBNuVhgiGThA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="88287201"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="88287201"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 23:32:23 -0700
X-CSE-ConnectionGUID: SDa6DcYJTIC/ahidQJuRXg==
X-CSE-MsgGUID: TO1bLLsmSXWOgVzeU5xgkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="269886196"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.20])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 23:32:20 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/intel: Add quirk to disable rc6 on some TUXEDO
 devices
In-Reply-To: <20260908200707.65516-2-wse@tuxedocomputers.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260908200707.65516-1-wse@tuxedocomputers.com>
 <20260908200707.65516-2-wse@tuxedocomputers.com>
Date: Wed, 09 Sep 2026 09:32:16 +0300
Message-ID: <7764d157c4bd6f832adeb7860baded67ae151901@intel.com>
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

On Tue, 08 Sep 2026, Werner Sembach <wse@tuxedocomputers.com> wrote:
> Some TUXEDO devices have random rare hard resets during video streaming.

Is there a gitlab issue for this?

> Disabling rc6 fixes this. Until the root cause is found this is a pragmatic
> workaround.

The way to do this is to add your own local struct pci_device_id array
somewhere, and use pci_match_id() or similar on it.

We're *not* going to change the high level device info or PCI ID
definitions for this.

Ugly stuff needs to be localized and hidden away.


BR,
Jani.


>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/i915/i915_pci.c | 11 +++++++++++
>  include/drm/intel/pciids.h      | 22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 2f03f95945f1b..a52b56bedcf4f 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -687,6 +687,16 @@ static const struct intel_device_info adl_p_info = {
>  	.dma_mask_size = 39,
>  };
>  
> +static const struct intel_device_info adl_p_tux_ibp8_quirk_info = {
> +	GEN12_FEATURES,
> +	PLATFORM(INTEL_ALDERLAKE_P),
> +	.platform_engine_mask =
> +		BIT(RCS0) | BIT(BCS0) | BIT(VECS0) | BIT(VCS0) | BIT(VCS2),
> +	.__runtime.ppgtt_size = 48,
> +	.dma_mask_size = 39,
> +	.has_rc6 = 0,
> +};
> +
>  #undef GEN
>  
>  #define XE_HP_PAGE_SIZES \
> @@ -863,6 +873,7 @@ static const struct pci_device_id pciidlist[] = {
>  	INTEL_DG1_IDS(INTEL_VGA_DEVICE, &dg1_info),
>  	INTEL_RPLS_IDS(INTEL_VGA_DEVICE, &adl_s_info),
>  	INTEL_RPLU_IDS(INTEL_VGA_DEVICE, &adl_p_info),
> +	INTEL_RPLP_TUX_IBP8_QUIRK_IDS(INTEL_VGA_DEVICE, &adl_p_tux_ibp8_quirk_info),
>  	INTEL_RPLP_IDS(INTEL_VGA_DEVICE, &adl_p_info),
>  	INTEL_DG2_IDS(INTEL_VGA_DEVICE, &dg2_info),
>  	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
> diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
> index 7a4a5658942d2..e4f74916a62c2 100644
> --- a/include/drm/intel/pciids.h
> +++ b/include/drm/intel/pciids.h
> @@ -712,6 +712,28 @@
>  	MACRO__(0xA7AC, ## __VA_ARGS__), \
>  	MACRO__(0xA7AD, ## __VA_ARGS__)
>  
> +#define INTEL_RPLP_TUX_IBP8_QUIRK_IDS(MACRO__, ...) \
> +	MACRO__##_SUB(0xA720, 0x1D05, 0x124A, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA720, 0x1D05, 0x124C, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA720, 0x1D05, 0x124E, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA720, 0x1D05, 0x130F, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124A, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124C, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A0, 0x1D05, 0x124E, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A0, 0x1D05, 0x130F, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124A, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124C, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A8, 0x1D05, 0x124E, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7A8, 0x1D05, 0x130F, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124A, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124C, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AA, 0x1D05, 0x124E, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AA, 0x1D05, 0x130F, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124A, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124C, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AB, 0x1D05, 0x124E, ## __VA_ARGS__), \
> +	MACRO__##_SUB(0xA7AB, 0x1D05, 0x130F, ## __VA_ARGS__)
> +
>  /* RPL-P */
>  #define INTEL_RPLP_IDS(MACRO__, ...) \
>  	MACRO__(0xA720, ## __VA_ARGS__), \

-- 
Jani Nikula, Intel
