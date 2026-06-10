Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DBCD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D00B610EB20;
	Wed, 10 Jun 2026 18:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="U1rXZr9O";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0BB010EB20;
 Wed, 10 Jun 2026 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781117376; x=1812653376;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5WBATLKk2oqxbOl5yQKq2NNN+Wjl6kcXZgiX2Y0yX7Q=;
 b=U1rXZr9OjgMv7Q/7DBaiHGxfdLd1CBeepAOpzT7nbEngAVogn4iup2i9
 OXWoBysDFTEbo0SJqtXK5mPhuChkx0QuJ5sjI+6JMJKcz5bQiYdXUylRQ
 7swWkki+RuZaRS+tN6e5foO34bevHvZwBfpgSCploSwjOsyO0XQ5qIwI6
 XUdJZRuDW6VZ4Ggv6GrEnVwZXEohAhvqxXyOAbXWXF6013I9yLt8J/4/u
 ZVjTT4pZwJURzy5ERGFyDmBdrx36EpzC6KHGHUbqDJkOWzlxx6XH3RybJ
 3icGMaNkqUlpxVluI4Jzfu6tL9hOOcHtopPUPS/m8fUwc7Ek1GDuTQVU1 A==;
X-CSE-ConnectionGUID: 5nSUGi7ASMuUEMANS+2dJQ==
X-CSE-MsgGUID: eZzBQfDdStaFNawl991PIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85761967"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="85761967"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:49:35 -0700
X-CSE-ConnectionGUID: hDHbE2M3StiM3If5bLS5Vw==
X-CSE-MsgGUID: NWXagFByRmS2eQn5pwuP9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="246110691"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.62])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 11:49:32 -0700
Date: Wed, 10 Jun 2026 21:49:28 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Imre Deak <imre.deak@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH] drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs
Message-ID: <aimxuKxdSgta7wdo@intel.com>
References: <20260610174819.6258-1-alexander.kaplan@sms-medipool.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610174819.6258-1-alexander.kaplan@sms-medipool.de>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

On Wed, Jun 10, 2026 at 07:48:19PM +0200, Alexander Kaplan wrote:
> The PCON max FRL bandwidth field lives in byte 2 of the DFP Detailed
> Capability Info (DPCD 0x82 for the first DFP).
> The DP standard defines the meaning of descriptor bytes 1-3 strictly
> per DFP type, and for a DisplayPort type DFP all of them are
> reserved, with "read all 0s" semantics (DP v2.0, section 2.12.3,
> Table 2-183).
> The FRL bandwidth field is an HDMI DFP extension added by the VESA
> DP-to-HDMI PCON specification.
> drm_dp_get_pcon_max_frl_bw() however parses the byte without checking
> the DFP type, the branch presence or DETAILED_CAP_INFO_AVAILABLE.
> Without the latter the port descriptors are one byte wide and
> port_cap[2] is not even the right register.
> 
> All neighbouring helpers parsing the same descriptor are scoped by
> the DFP type already, see for instance drm_dp_downstream_max_bpc()
> reading the same byte and returning 0 for a DP type DFP.
> amdgpu's DC parses the field only for HDMI(/DP++) detailed types as
> well.
> 
> This is not theoretical.
> A Synaptics VMM7100 based USB-C to HDMI adapter with a macOS targeted
> firmware advertises a DisplayPort type DFP with the type byte
> replicated across the whole descriptor (08 08 08 08).
> i915 decodes that as "PCON limited to 18 Gbps FRL" and prunes every
> mode above ~750 MHz dotclock, including all the 4k@100/120 modes the
> sink EDID offers, while macOS drives 4k@120 through the same adapter
> just fine via DP DSC (and amdgpu's type-scoped parser would ignore
> the bogus field as well).
> 
> Only parse the field for an HDMI DFP behind a branch device that
> reports detailed cap info, matching the type-scoped field layout of
> the spec and the rest of the helpers.
> 
> Fixes: ce32a6239de6 ("drm/dp_helper: Add Helpers for FRL Link Training support for DP-HDMI2.1 PCON")
> Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
> ---
> This patch is part of a set of independent fixes for the USB-C to DP
> to HDMI 2.1 protocol converter (PCON) path, found and verified on an
> ASUS NUC 16 Pro (Panther Lake, xe) with Synaptics VMM7100 based
> adapters.
> Each part stands on its own and can be merged independently.
> The other parts:
> [1] https://lore.kernel.org/r/20260610174413.5881-1-alexander.kaplan@sms-medipool.de
> [2] https://lore.kernel.org/r/20260610174807.6231-1-alexander.kaplan@sms-medipool.de
>  drivers/gpu/drm/display/drm_dp_helper.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 9c31e14cc413..3328909c8db4 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3686,6 +3686,15 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>  	int bw;
>  	u8 buf;
>  
> +	if (!drm_dp_is_branch(dpcd))
> +		return 0;
> +

I'd also add a DPCD_REV check because none of this stuff exists for
DPCD v1.0. Granted, the DP_DETAILED_CAP_INFO_AVAILABLE bit should be
zero there (assuming any DPCD v1.0 devices even exists), but I'd
rather have the explicit check anyway so I don't have to think so
much when reading the code.

> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) == 0)
> +		return 0;
> +
> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) != DP_DS_PORT_TYPE_HDMI)
> +		return 0;
> +
>  	buf = port_cap[2];
>  	bw = buf & DP_PCON_MAX_FRL_BW;
>  
> -- 
> 2.54.0
> 

-- 
Ville Syrjälä
Intel
