Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93C3CCF2E4
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A45E10E4BE;
	Mon, 19 Oct 2026 12:23:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3325C10E4BE;
 Mon, 19 Oct 2026 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792412590; x=1823948590;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hX0usdJlny0mRPRRhLuXQ15ezGuOx5nnPLttdzi6Azo=;
 b=e4ipJF98RMNr6c2zoZOVALDkrI82SnatjBTTc3N2alp61NDIecTuLUxd
 SeyZywH4vViwVE8KIsVF8VIdBrhyalAW4HYs7Nfe3T7D09f+xvxhLFmXF
 qf386YKWCtzms/BttOM+C+5NgUIufo3LIpgHko9YrABEkQCkDJ0dfRjzv
 bOdXZq22ZdRPLu9blDrpBXUZ/CvxXMNQzUPDX8VMspjCEM5AuPWjDSg1X
 7qAPwyGx7fB341vCJ2XSbv3K6QNDVgAAmyU3AAGQL6YkJoB4TX97WAfDW
 B7Sb/18PO66A48UaTco/Xhvzl1J+FkqLba8QUKaykVJqsbs/nRLxNUr5Y g==;
X-CSE-ConnectionGUID: Z8R5Mm71SGSeaiJj2gr1Qg==
X-CSE-MsgGUID: mCMVtyscQyqsiFgilrgEOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1104510"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1104510"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:21:10 -0700
X-CSE-ConnectionGUID: W1+em7UEToifIriZV9UvLg==
X-CSE-MsgGUID: 94XJzdSUST+6BSjb6qP4JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2497077"
Received: from alekseim-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.34])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:21:09 -0700
Date: Mon, 19 Oct 2026 15:21:05 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Adrien ASESIO <aasesio@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC] drm/i915: HDMI 3D frame packing on LSPCON (DP-to-HDMI) ports
Message-ID: <atYLMcNWzELnmQFd@intel.com>
References: <CAK1iddKB9hhhBGPnu6nNg-nn-Tg-GC-31nvEEHKB9qvkMesxLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK1iddKB9hhhBGPnu6nNg-nn-Tg-GC-31nvEEHKB9qvkMesxLA@mail.gmail.com>
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

On Fri, Oct 16, 2026 at 04:05:16PM -0400, Adrien ASESIO wrote:
> Hi,
> 
> I would like to ask whether stereo 3D output on i915 ports that drive
> an HDMI sink
> through an LSPCON (DP branch device in PCON mode, MegaChips MCDP28x0
> or Parade PS175)
> is something that could be supported, and what you would want a patch
> to look like.

TBH I was hoping we could just kill off the entire stereo 3d thing
because it makes dealing with modes annoying. But I guess we can't do
that if people are actually using it :/

> 
> Background: the HDMI 2.0 port of many Intel boards from Skylake to
> Coffee Lake (Intel
> NUC7/NUC8 among them) is an LSPCON, so i915 registers it as a
> DisplayPort connector.
> stereo_allowed is only set in intel_hdmi_init_connector(), never for DP, so
> drm_helper_probe_single_connector_modes() prunes every 3D mode the
> EDID advertises,
> and lspcon_set_infoframes() only writes the AVI infoframe (and the
> DRM/HDR packet),
> so there is no path for the HDMI Vendor-Specific InfoFrame that
> carries 3D_Structure.
> Intel's support article 000030190 documented S3D as unsupported on
> LSPCON designs.
> 
> Observation: on a NUC8i7BEH (i7-8559U, Coffee Lake; i915_display_info
> reports the
> branch device as "Type: HDMI, ID: MC2800, HW 2.2, SW 1.73") with
> kernel 6.1.74, whose
> code paths are unchanged in this respect on current master, I programmed the
> frame-packing raster of CTA VIC 32 as a plain progressive mode from userspace:
> 
>     1920x2205 @ 24 Hz, clock 148500, htotal 2750, vtotal 2250, +hsync +vsync
> 
> The sink (Panasonic TX-P..VT65 plasma, HDMI 1.4a, behind an Onkyo AVR)
> switched into
> frame-packed 3D by itself and displayed both eyes correctly; page
> flips were delivered
> at 41.667 ms (sd 0.01 ms) for minutes. So the LSPCON passes the
> doubled raster, and at
> least this TV detects frame packing from the timing without the VSIF
> (or the LSPCON
> generates one; I cannot tell without an HDMI analyser). Kodi now does
> exactly this on
> that machine (patch under review on the maintainer's 3D branch, [1]),
> decoding 3D
> Blu-ray MVC with FFmpeg's pending H.264 MVC series [2].
> 
> Questions:
> 
> 1. Would a patch that sets connector->stereo_allowed for DP connectors
> with an HDMI
>    branch device (intel_dp->has_hdmi_sink / lspcon.active) be
> acceptable, knowing that
>    the VSIF cannot be sent? The modes would only appear for sinks
> whose EDID advertises
>    3D, and only to clients that set DRM_CLIENT_CAP_STEREO_3D. The risk
> I see is clients
>    that set the cap but do not understand
> DRM_MODE_FLAG_3D_FRAME_PACKING picking a
>    2205-line mode by accident.
> 
> 2. Is there any documentation of an infoframe interface on the
> MegaChips or Parade
>    LSPCONs beyond the AVI registers i915 knows
> (LSPCON_MCA_AVI_IF_WRITE_OFFSET 0x5C0,
>    LSPCON_PARADE_AVI_IF_WRITE_OFFSET 0x516)? MegaChips' product page claims
>    "stereoscopic 3D forwarding" for the MCDP2800.

There are no docs :(


On DP the VSC SDP can signal various stereo 3D modes (including
"Stacked Frame" which I think is what you want) whereas the MSA
can only signal the frame/field sequential modes.

Technically all DPCD 1.2+ sinks should support the VSC SDP, but
I don't think that really guarantees that a PCON would then
convert the VSC SDP to its infoframe counterpart.

I guess one way to verify whether it's really working would be to
just send the VSC SDP with the stereo 3D knobs in various
positions and see if the TV will respond accordingly.

> 
> 3. If neither is wanted in the kernel, is "userspace programs the
> doubled raster as a
>    2D mode" an approach you consider legitimate, so that compositors
> and players can
>    do what I did above?
> 
> The amdgpu side is getting HDMI 1.4 3D output through Adrian
> Betschart's series on
> amd-gfx (2026-09), which restricts stereo_allowed to native HDMI
> connectors for the
> same reason.
> 
> Test tool (libdrm; lists stereo modes with the client cap, sets a
> frame-packing or
> forced raster, measures flip pacing): https://github.com/SilverGhostBS/fp3d-test
> 
> [1] https://github.com/popcornmix/xbmc/pull/35
> [2] https://code.ffmpeg.org/FFmpeg/FFmpeg/pulls/24303
> 
> Thanks,
> Adrien Asesio

-- 
Ville Syrjälä
Intel
