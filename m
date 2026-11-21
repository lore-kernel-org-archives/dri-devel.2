Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D65606A6AD
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iatXViQ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D1810E56E;
	Sat, 21 Nov 2026 01:43:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21D2210E56E;
 Sat, 21 Nov 2026 01:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795225426; x=1826761426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=kVaHlHjJcy4SxxTooYyyL0PT+SmvPoA8rf2OZQ5memc=;
 b=iatXViQ6PdJhPQf++R7Pm7kEaTW0+nxzVsxoWGAEWBxODGKf8bV8RKX9
 W05luELgog1ZlwR6z5iUCqEygzTrq5ddBbY82LpvvZpsyzr8YpDJUXkS5
 2aahLk3VewGyv3Ds1NJKbt0saK6udPOfLnDhOLRABOHPCAsV/SbVQkN+B
 CGeEcrk8Hu7IZMwM34qtzEObRQB29CZDvishemucokvaZFQGH0saO+eBr
 Cjeiz2FV8TdL52Ig353d5SBOy/42VAUdzkIXjlCum1us2iG8p/Hgqs1aN
 ggKQORIKTIxrj+OWPZivPm06ItQbU34ak/2+joyIyiyadZk1Gd2uZNEia Q==;
X-CSE-ConnectionGUID: GlszPraHSb+Ed/GXmu0NYQ==
X-CSE-MsgGUID: ZBySE8wzTT2D2JIR1zXyHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4102958"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4102958"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:43:45 -0800
X-CSE-ConnectionGUID: rkFiyE5jRiqbh/3pUBoOng==
X-CSE-MsgGUID: kPcxZkNjRWiGkVPhoX2IKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; d="scan'208";a="10825255"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.66])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2026 17:43:44 -0800
Date: Sat, 21 Nov 2026 03:43:40 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Yitian Shao <fighters390@qq.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jani.nikula@intel.com, sebastian.wick@redhat.com,
 uma.shankar@intel.com, suraj.kandpal@intel.com
Subject: Re: [PATCH v3 0/4] drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP
Message-ID: <awD3TIOlLBMHZvu6@intel.com>
References: <tencent_D31B4BA3A4E1F42313C008AFE786BB6D6F07@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_D31B4BA3A4E1F42313C008AFE786BB6D6F07@qq.com>
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Nov 21, 2026 at 08:54:05AM +0800, Yitian Shao wrote:
> This series makes HDR work on pre-ICL eDP panels that decode the metadata
> through the Intel AUX HDR interface instead of a gamut metadata DIP.
> 
> Patch 1 removes the LSPCON check from intel_dp_has_gamut_metadata_dip(),
> which made the helper answer the wrong question.
> 
> Patch 2 attaches HDR_OUTPUT_METADATA on eDP when the panel's TCON advertises
> PQ decoding, and skips the infoframe when no DIP is available.
> 
> Patch 3 is the pre-existing LSPCON issue pointed out during review: refuse
> HDR support when the port cannot transmit the gamut metadata DIP.
> 
> Patch 4 writes the content luminance over DPCD only when the SDP path is not
> in use, since the SDP takes precedence.

We still haven't solved the fastset issue, but I think we can mostly
sidestep it for now by always forcing a full modeset when the HDR
metadata changes.

Probably the most straightforward way to do that is by changing
intel_digital_connector_atomic_check() to flag connectors_changed=true
instead of mode_changed=true if the metadata changes on a connector
that uses the AUX HDR interface. A commit with connectors_change==true
will always result in a full modeset.

And I'm thinking that we do want that check to be just the
"are we using the HDR AUX interface" and nothing more. We should
not consider the SDP override stuff at all. That's because the HDR
AUX interface also sets up other stuff such as the 2084 decode and
segmented backlight. I believe this is in fact a pre-existing bug 
in the code; If the metadata changes between PQ and SDR but otherwise
remains in place we are currently failing to update the TCON.

Eventually we'll probably want a proper fastset support for this
stuff, but no need to rush it now IMO.

> 
> v3:
>  - Drop the LSPCON check from intel_dp_has_gamut_metadata_dip() and move it
>    to intel_dp_add_properties(), per Ville.
>  - Fold the checks into intel_dp_hdr_metadata_supported() instead of an
>    ever growing if-statement.
>  - Add the LSPCON DIP check as a separate patch, per Ville.
>  - Invert the content luminance condition: use DPCD when there is no SDP.
>  - Dropped the fastset concern from v2. The analysis was confirmed correct,
>    but HDR metadata fastset support is already broken and needs a separate
>    fix (possibly crtc_state->backlight_changed), so it does not belong here.
> 
> v2:
>  - Do not skip the infoframe on LSPCON (superseded by patch 1 and 2).
>  - Only attach the property when the Intel AUX HDR backlight interface is in
>    use, to avoid reading the untagged union.
> 
> Testing: CometLake-U (Gen9.5) laptop with a 3840x2160 10bpc eDP panel that
> advertises BT2020 + ST2084. With the equivalent change applied the connector
> exposes HDR_OUTPUT_METADATA, GNOME 50 offers the HDR switch, and the panel
> enters PQ/BT2020 mode. The TCON HDR backlight interface was already in use.
> v3 was compile-tested only; I have not re-run the runtime test.
> 
> Yitian Shao (4):
>   drm/i915/dp: Drop LSPCON check from intel_dp_has_gamut_metadata_dip()
>   drm/i915/dp: Attach HDR_OUTPUT_METADATA on eDP with TCON HDR support
>   drm/i915/display: Check gamut metadata DIP support in LSPCON HDR
>     detection
>   drm/i915/dp: Prefer SDP over DPCD for HDR content luminance
> 
>  drivers/gpu/drm/i915/display/intel_dp.c       | 32 ++++++++++++++++---
>  .../drm/i915/display/intel_dp_aux_backlight.c | 11 ++++++-
>  .../drm/i915/display/intel_dp_aux_backlight.h |  3 ++
>  drivers/gpu/drm/i915/display/intel_lspcon.c   |  5 +++
>  4 files changed, 46 insertions(+), 5 deletions(-)
> 
> -- 
> 2.53.0

-- 
Ville Syrjälä
Intel
