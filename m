Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9BFFD707A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 20:12:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394C110E1E6;
	Tue, 17 Mar 2026 20:12:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XAu+xAe9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0E710E1E6;
 Tue, 17 Mar 2026 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773778345; x=1805314345;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=mNwI6kXdR7VYsy+ecKSqi20yTNSIaZRyQCCA0fH8/B4=;
 b=XAu+xAe9rro0GLE6OWQTnqtoei/yMCkZDj6ae12gD83MrrkzYEY3EwbP
 chquIy0y+kVAQo44bK/A0J+xHzhduDobNMoxH5WjFaBfggajIo/vZjs8H
 lU8Qh12k980i8/Yimri38Xv7QAk8Y/53dAPEZPUkcVsTqlliblvI3GGq4
 Q/G10XeOSutcdWRImoiw7Ww9aewYXHfFY8gU/7x7yMtakuIGKulLZTG6K
 QyZIDjFWfWboHuDVPQVhZXT+ISglwfQrLipOiZvskgby1vPMiHVuRpWis
 pwDek1KRvA1J1Y/jb7j3kwM5C6atURlWx4JNZypnwJep99gnx3U3l+JGZ w==;
X-CSE-ConnectionGUID: rnELAKLnTqenQplcs1u4cw==
X-CSE-MsgGUID: TIghaDztQ1Ghq8XFfCcI1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74523477"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="74523477"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 13:12:24 -0700
X-CSE-ConnectionGUID: ue86XasPSUmNTCDa3/yZ8A==
X-CSE-MsgGUID: 8sH83R47R2WRhYiJuQjxZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="222352497"
Received: from krybak-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.32])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 13:12:17 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Gui-Dong Han <hanguidong02@gmail.com>, gregkh@linuxfoundation.org,
 dakr@kernel.org, rafael@kernel.org, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch
Cc: gustavo.sousa@intel.com, demarchi@kernel.org, jouni.hogander@intel.com,
 luciano.coelho@intel.com, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, akaieurus@gmail.com, me@ziyao.cc, Gui-Dong
 Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 4/4] drm/i915/display: initialize string params to empty
 strings
In-Reply-To: <20260317191538.43535-1-hanguidong02@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260317185920.43387-1-hanguidong02@gmail.com>
 <20260317191538.43535-1-hanguidong02@gmail.com>
Date: Tue, 17 Mar 2026 22:12:13 +0200
Message-ID: <c14b399c9c6bf96f8c7d33615561b0d787ff175b@intel.com>
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

On Wed, 18 Mar 2026, Gui-Dong Han <hanguidong02@gmail.com> wrote:
> Passing NULL to debugfs_create_str() causes a NULL pointer dereference
> upon reading, and is no longer permitted. Change the default values of
> dmc_firmware_path and vbt_firmware to empty strings ("").
>
> Existing code that consumes these parameters already verifies both
> pointer validity and string length, so empty strings are handled
> correctly. Furthermore, heap allocation is not required here: these
> debugfs parameters are created with strictly read-only permissions
> (0400). As a result, the debugfs write operation is never invoked,
> meaning the static empty string will not be erroneously freed by
> kfree().
>
> Fixes: e9913f0bd2e1 ("drm/i915/display: move dmc_firmware_path to display params")
> Fixes: 29292bc6cc37 ("drm/i915/display: Move vbt_firmware module parameter under display")
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_display_params.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
> index b95ecf728daa..0a8cad98d480 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_params.h
> +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
> @@ -23,8 +23,8 @@ struct drm_printer;
>   *       debugfs file
>   */
>  #define INTEL_DISPLAY_PARAMS_FOR_EACH(param) \
> -	param(char *, dmc_firmware_path, NULL, 0400) \
> -	param(char *, vbt_firmware, NULL, 0400) \
> +	param(char *, dmc_firmware_path, "", 0400) \
> +	param(char *, vbt_firmware, "", 0400) \

Admittedly this is all very convoluted, but these NULL pointers (or
pointers to them) are never passed to debugfs_create_str().

BR,
Jani.


>  	param(int, lvds_channel_mode, 0, 0400) \
>  	param(int, panel_use_ssc, -1, 0600) \
>  	param(int, vbt_sdvo_panel_type, -1, 0400) \

-- 
Jani Nikula, Intel
