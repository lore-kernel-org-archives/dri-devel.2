Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3165C5DF7E
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 07:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3FDC10EA27;
	Tue, 18 Aug 2026 07:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qgvapyc/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C89910E187;
 Tue, 18 Aug 2026 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787039940; x=1818575940;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=Hk0Zd1czJaTWm/hYSOrn7Jwx7VLlY4PtOOt4okU9jYc=;
 b=Qgvapyc/Yc+xJp33bENfqvGSOcNXYBzNSUMOEP0G7haJbH+kB7UI+5M+
 bYpRrCtap+quGOWW1wm3y92r5O9kLGieW+mmYEYxxHdI+t0D/eAPjVGZ3
 HmvrOk/OHqPYZt+lS5OhDXVcZRmwA9Tjwp7l1auZBtE2fdGCJCbgJfTWY
 8zZwi9V3dmFw260VPgKK1yIJsvSvT8X7d3MaqxcQshPPeauXD8KxElu2W
 m1BxDk5Y1vY50dROgXNQ52v1jZYPnfb6FaDInM/FCaZWDd5oZVDNRyrpl
 2GsuRwUO9b4IqmwuF/7Z4wJ6+ieyXa8a42G30dDW7Re3f+q4adakt9IG7 w==;
X-CSE-ConnectionGUID: cEDuUd5QRwyLCxQbya32bg==
X-CSE-MsgGUID: z193b88sSiOM2bwTx1qofw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="110310192"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="110310192"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 00:59:00 -0700
X-CSE-ConnectionGUID: 4bs/UuoqQbqEthPMS8Aq4A==
X-CSE-MsgGUID: ZCIanelLQdmz/7rRwltwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="263426881"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.243])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 00:58:57 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 intel-gfx@lists.freedesktop.org
Cc: =?utf-8?Q?Chang_Jiong=28=E5=B8=B8=E7=82=AF=29?= <xspeed1989@gmail.com>,
 stable@vger.kernel.org,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ville
 =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, =?utf-8?Q?Micha?=
 =?utf-8?Q?=C5=82?= Grzelak
 <michal.grzelak@intel.com>, "open list:INTEL DRM DISPLAY FOR XE AND I915
 DRIVERS" <intel-xe@lists.freedesktop.org>, "open list:DRM DRIVERS"
 <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/i915/cdclk: Don't force cd2x pipe select on Xe3
 in bxt_sanitize_cdclk()
In-Reply-To: <20260816062344.796615-1-xspeed1989@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <tencent_6CC00E822A788776C8F6E2D6B24C5FE4A909@qq.com>
 <20260816062344.796615-1-xspeed1989@gmail.com>
Date: Tue, 18 Aug 2026 10:58:54 +0300
Message-ID: <c4dead5d0527e305f44ddb943f95e9967ec1911f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Sun, 16 Aug 2026, Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.com>=
 wrote:
> Since commit 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
> without a full PLL re-enable") bxt_sanitize_cdclk() normalizes the
> CD2X pipe select field of the CDCLK_CTL readback to PIPE_NONE before
> comparing against the expected value.
>
> However bxt_cdclk_ctl() does not include the CD2X pipe select field
> at all on DISPLAY_VER() >=3D 30, so on Xe3 (PTL) the normalized
> readback (pipe field forced to the PIPE_NONE encoding, 0b111) can
> never match the expected value (pipe field 0). The comparison now
> fails on every boot and we always take the full CDCLK PLL
> disable+re-enable path with the BIOS framebuffer actively scanning
> out - exactly what this code was trying to avoid. On a Panther Lake
> laptop (Arc B390, 8086:b080, eDP 3120x2080@120) this causes
> "CPU pipe A FIFO underrun" during probe and persistent full-screen
> scanout corruption for the first KMS client (the SDDM greeter);
> the corruption lasts until the next full modeset.
>
> Only normalize the CD2X pipe select field on platforms where
> bxt_cdclk_ctl() actually programs it, mirroring its DISPLAY_VER()
> check.
>
> Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a=
 full PLL re-enable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chang Jiong(=E5=B8=B8=E7=82=AF) <xspeed1989@gmail.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8569
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8901

The first one has a patch from Ville that is identical to this one.

I'll try to kick CI to get this tested before merging.

> ---
> v2: No code changes. Resent with From matching Signed-off-by
>     (v1 was sent from 304750714@qq.com, which is not on the
>     Intel CI allowlist).
>
>  drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm=
/i915/display/intel_cdclk.c
> index 7bc9b956554b..0438f5ac78c0 100644
> --- a/drivers/gpu/drm/i915/display/intel_cdclk.c
> +++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
> @@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_displa=
y *display)
>  	 * dividers both syncing to an active pipe, or asynchronously
>  	 * (PIPE_NONE).
>  	 */
> -	cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> -	cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	if (DISPLAY_VER(display) < 30) {
> +		cdctl &=3D ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +		cdctl |=3D bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
> +	}
>=20=20
>  	if (cdctl !=3D expected) {
>  		if (DISPLAY_VER(display) < 20) {

--=20
Jani Nikula, Intel
