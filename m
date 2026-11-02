Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B922606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bMNgNqrd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA32110ED68;
	Mon,  2 Nov 2026 12:14:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A4110E61F;
 Mon,  2 Nov 2026 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793621679; x=1825157679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uPRIF83KVdNs9SclzuHRgjeihTQw1Qgbmzk9cUO1prk=;
 b=bMNgNqrdyN6mmPNVDbAOJhgZ4fEVZ11bKepx3YXLniWdIJRlrHQ5Q1Bx
 O7U1fKk/Hh73hRfkj736/W+1SszZBFO8iWNX3E0/wom0+/RWgoC7LKy5K
 ts7SEjsaSrDbSbGdc/ps/EdnRQO91KUWJBzWBltt1gxRI4tXtKlQKzUen
 GOHduxrWRlE6c7lQydtuks8mXucwbkibGSmChMnS1g7m8sGabuBLtkV22
 qN5/a1W4dCAx031PPkHxjztoaKoH69+MOr+qlGWVSgZo+W42R4KtgpYl8
 uMgWXjB6ym5hz/TBPFucLVARvFNOcqRDgOMmYX5YqUlGWx74tOlXfjI5T Q==;
X-CSE-ConnectionGUID: KUJJkloKTsyEoozokw048A==
X-CSE-MsgGUID: THtgTSQbR72eh53YfnW6Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2197590"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2197590"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:14:38 -0800
X-CSE-ConnectionGUID: 3W09fTi/TlCt8+3lDJHXrA==
X-CSE-MsgGUID: uytE/XsJQ+C3U/JeJWiblA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6201714"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.10])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 04:14:36 -0800
Date: Mon, 2 Nov 2026 14:14:33 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH 00/13] drm/dp, drm/i915: conversions from seq_file to
 drm_printer
Message-ID: <auh-qcn8xkDBX5sY@intel.com>
References: <cover.1793361738.git.jani.nikula@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793361738.git.jani.nikula@intel.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 02:03:03PM +0200, Jani Nikula wrote:
> I've had this in a branch since at least April, seems useful.
> 
> Jani Nikula (13):
>   drm/dp: pass struct drm_printer to drm_dp_downstream_debug()
>   drm/dp: prefer drm_printf_indent() over inline \t
>   drm/i915/debugfs: pass struct drm_printer to intel_plane_info()
>   drm/i915/debugfs: pass struct drm_printer to crtc_updates_info()
>   drm/i915/debugfs: convert crtc_updates_info() to use
>     drm_printf_indent()
>   drm/i915/debugfs: pass struct drm_printer to intel_scaler_info()
>   drm/i915/debugfs: pass struct drm_printer to intel_encoder_info()
>   drm/i915/debugfs: pass struct drm_printer to intel_crtc_info()
>   drm/i915/debugfs: pass struct drm_printer to
>     intel_{dp,dp_mst,hdmi}_crtc_info()
>   drm/i915/debugfs: pass struct drm_printer to intel_hdcp_info()
>   drm/i915/debugfs: refactor intel_seq_print_mode() into
>     intel_print_mode()
>   drm/i915/debugfs: pass struct drm_printer to intel_connector_info()
>   drm/i915/debugfs: prefer drm_printf_indent() over inline \t

Looked fine with --color-words

Series is
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
>  drivers/gpu/drm/display/drm_dp_helper.c       |  39 ++-
>  .../drm/i915/display/intel_display_debugfs.c  | 250 +++++++++---------
>  drivers/gpu/drm/i915/display/intel_hdcp.c     |  27 +-
>  drivers/gpu/drm/i915/display/intel_hdcp.h     |   4 +-
>  include/drm/display/drm_dp_helper.h           |   3 +-
>  5 files changed, 160 insertions(+), 163 deletions(-)
> 
> 
> base-commit: 29f9258a2788a1066c0910c480e65c80887f4d20
> -- 
> 2.47.3

-- 
Ville Syrjälä
Intel
