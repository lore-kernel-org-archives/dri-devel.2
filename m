Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79853C4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5DF410EAC0;
	Tue, 21 Jul 2026 16:55:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzHA4Zdl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDBC10EABC
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 16:55:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6444A4364E;
 Tue, 21 Jul 2026 16:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3B21F00A3E;
 Tue, 21 Jul 2026 16:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784652904;
 bh=xaP4iJo/L1ERHadu0eJ50XoMx0i04MAli12ha4zzyvo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jzHA4ZdlgOfJ2zsiMX8FAkjm0+lNykyvLHSc8ZpHekQtOWip6KrpS7w75U0CPpnS8
 z+aW29oILZsfYvZbIsr8/ZKri2tZeq2VMmBcBHvxznpfpIyQo5WULBa+n9CrMf97Dy
 uUYYss9TyU97qbTmZ3FhhDppKXXSQOq4lpn609ro2jHPdEuo4znDgNuS7aQjecvl2D
 J2ZAea0vlftMaRnicUCzR171hmoXgcVcHMztNC8bkLNCVNTn/BR6v6WTc0koyILzLw
 ikMvroKvsc301fvl6RL0zTrFYt7ppR1avy7AK10bbT2f5uJifH+FGDqPN48rs6NAl2
 P+Cfh6of9ZfiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/amd/display: Clean up FreeSync capability
 detection
To: "Alex Huang" <Alex.Huang2@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721164430.2121326-4-Alex.Huang2@amd.com>
References: <20260721164430.2121326-1-Alex.Huang2@amd.com>
 <20260721164430.2121326-4-Alex.Huang2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:55:03 +0000
Message-Id: <20260721165504.1D3B21F00A3E@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing fallback to EDID monitor range when an AMD VSDB is present=
 but does not advertise FreeSync support.
- [Low] Using integer literal 0 to initialize a boolean variable.
--

--- Patch [3]: [PATCH 3/4] drm/amd/display: Clean up FreeSync capability de=
tection ---
commit f8ae668c998c7d60648194bc1a8a582d9e952ad8
Author: Alex Huang <Alex.Huang2@amd.com>

drm/amd/display: Clean up FreeSync capability detection

This commit extracts duplicate FreeSync capability detection code into
common code, pulling VSDB data once and falling back to monitor ranges
when needed.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -13707,7 +13707,7 @@ static int get_amd_vsdb(struct amdgpu_dm_connecto=
r *aconnector,
>  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  				    const struct drm_edid *drm_edid, bool do_mccs)
>  {
> -	int i =3D 0;
> +	bool has_vsdb =3D 0;

[Severity: Low]
This isn't a bug, but is it better to initialize this boolean variable
with 'false' instead of '0'?

[ ... ]

> +	if (has_vsdb) {
> +		amdgpu_dm_connector->vsdb_info =3D vsdb_info;
> +		amdgpu_dm_connector->vsdb_info.amd_vsdb_version =3D vsdb_info.amd_vsdb=
_version;
> +
> +		/* copy refresh rate info as long as VSDB advertises FreeSync */
> +		if (vsdb_info.freesync_supported) {
> +			amdgpu_dm_connector->min_vfreq =3D vsdb_info.min_refresh_rate_hz;
> +			amdgpu_dm_connector->max_vfreq =3D vsdb_info.max_refresh_rate_hz;
> +
> +			connector->display_info.monitor_range.min_vfreq =3D
> +				vsdb_info.min_refresh_rate_hz;
> +			connector->display_info.monitor_range.max_vfreq =3D
> +				vsdb_info.max_refresh_rate_hz;
>  		}
> +	} else {
> +		/* fall back to the base EDID range when there is no VSDB */
> +		amdgpu_dm_connector->min_vfreq =3D connector->display_info.monitor_ran=
ge.min_vfreq;
> +		amdgpu_dm_connector->max_vfreq =3D connector->display_info.monitor_ran=
ge.max_vfreq;
> +	}

[Severity: High]
What happens if a monitor has an AMD VSDB (has_vsdb is true) but does not
advertise FreeSync support (vsdb_info.freesync_supported is false)?

In this scenario, it looks like the code skips assigning the VSDB refresh
rates but also skips the else block that falls back to the EDID monitor
range. Will amdgpu_dm_connector->min_vfreq and max_vfreq be left
unmodified, potentially retaining stale values from a previously connected
monitor?

[ ... ]

> +	if (sink->sink_signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT ||
> +	    sink->sink_signal =3D=3D SIGNAL_TYPE_EDP) {
> +		if (amdgpu_dm_connector->dc_link &&
> +		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_p=
aram &&
> +		    amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > =
10)
> +			freesync_capable =3D true;

[Severity: High]
If min_vfreq and max_vfreq retain stale values, could this arithmetic check
evaluate to true and erroneously enable FreeSync?

For example, when hotplugging an eDP panel that has a VSDB for Replay mode
but no FreeSync, it seems freesync_capable might be incorrectly set to true
based on the previous display's refresh rates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721164430.2121=
326-1-Alex.Huang2@amd.com?part=3D3
