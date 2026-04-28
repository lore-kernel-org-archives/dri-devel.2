Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1540CFF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F87210EA57;
	Tue, 28 Apr 2026 07:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Hh4tSedt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C217D10EA56;
 Tue, 28 Apr 2026 07:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777362814; x=1808898814;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=2HU+bYGOaOHV4bZ+H1s+Tmr9rRQ2uPY8JrdazvpN124=;
 b=Hh4tSedthi2rwhEQD4FXtuFOW9+ugj82V1xnkHLl61L3tQd9eHRH6Jd3
 sdKhW4+ycI6TVevhPebIFhPMXZMHCbYvFm9Appe/jSmdlY6C+8mNR//Xg
 jgtTUYjxGJFQlWeYT4fvc1/xVgyBCH8Sw9lER4TqJuLGCupL/oavhjqbP
 mBoNcgDrmwop+kaBG4M1gZvdmZC68tuQjrnRtebRhWWtfHlu85+pdM7Yu
 l8Ep7hH/mSwFb5a7NMesankdRUAr2DlzNDu9HyZJRnGhGmsd1lIddehQ5
 pG1tgE2I0di3DrCa+yOBUf04wIIwOj7+JiF3LWAB+foE7PzVgak7f23qH Q==;
X-CSE-ConnectionGUID: mMe9MYwCQvGnZyTTW9Df/w==
X-CSE-MsgGUID: O/X6aVjkRpyvJEXBKftsGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77967975"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="77967975"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:53:34 -0700
X-CSE-ConnectionGUID: ag4TNEdmS7a4jffy5xO3Qw==
X-CSE-MsgGUID: QEHt1kUQQDS8Qu2MqfbzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="237838007"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:53:30 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Zhenyu Wang
 <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/i915/gvt: Avoid
 -Wflex-array-member-not-at-end warning
In-Reply-To: <ae_4GkBsNl_0SYTm@kspp>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <ae_4GkBsNl_0SYTm@kspp>
Date: Tue, 28 Apr 2026 10:53:28 +0300
Message-ID: <4d5f5949b34f7bba00ed570ad2098074aa0c05f5@intel.com>
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

On Mon, 27 Apr 2026, "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
>
> Use the TRAILING_OVERLAP() helper to fix the following warning:
>
> drivers/gpu/drm/i915/gvt/opregion.c:126:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
>
> Lastly, the static_assert() ensures the alignment between the FAM and
> struct efp_child_device_config child0; is not inadvertently changed,
> and it's intentionally placed inmediately after the related structure
> (that is, no blank line in between).
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/gpu/drm/i915/gvt/opregion.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
> index d6e76ba31d60..efe457c02788 100644
> --- a/drivers/gpu/drm/i915/gvt/opregion.c
> +++ b/drivers/gpu/drm/i915/gvt/opregion.c
> @@ -122,17 +122,21 @@ struct vbt {
>  	struct bdb_data_header general_features_header;
>  	struct bdb_general_features general_features;
>  
> -	struct bdb_data_header general_definitions_header;
> -	struct bdb_general_definitions general_definitions;
> -
> -	struct efp_child_device_config child0;
> -	struct efp_child_device_config child1;
> -	struct efp_child_device_config child2;
> -	struct efp_child_device_config child3;
> -
>  	struct bdb_data_header driver_features_header;
>  	struct bdb_driver_features driver_features;
> +
> +	struct bdb_data_header general_definitions_header;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct bdb_general_definitions, general_definitions, devices,
> +		struct efp_child_device_config child0;
> +		struct efp_child_device_config child1;
> +		struct efp_child_device_config child2;
> +		struct efp_child_device_config child3;
> +	);

So this impacts the generation of a binary blob, parsed by the client OS
driver. In theory, the order of the BDB blocks shouldn't matter, but who
knows.

Anyway, I'm more worried about inadvertent padding potentially being
introduced. struct vbt should have __packed attribute, which is missing,
but I also think the union and the struct within TRAILING_OVERLAP()
should also have __packed.

Like, if struct efp_child_device_config gets extended by one byte,
what's going to happen with padding? It's __packed on its own, but IIUC
that doesn't automatically apply to the enclosing structs or unions.

>  };
> +static_assert(offsetof(struct vbt, general_definitions.devices) ==
> +	      offsetof(struct vbt, child0));

Perhaps also assert child1 offset is child0 offset + sizeof(struct
efp_child_device_config)? That should cover the padding, right?

BR,
Jani.

>  
>  static void virt_vbt_generation(struct vbt *v)
>  {

-- 
Jani Nikula, Intel
