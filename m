Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AB606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=did3b4jP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47E6210E314;
	Thu,  5 Nov 2026 16:58:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CD210E314
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:58:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C74B940980;
 Thu,  5 Nov 2026 16:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DC31F000C1;
 Thu,  5 Nov 2026 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793897898;
 bh=cuKnzuiteLk30OgfS5kxRYjnJ05fMe/EJVg7Yr3q20A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=did3b4jPJDABIZxFjCD9yrq6TW3hJ4trQMjdOFVW0zyQ21co4J0P/OntL8kqCiKPp
 SPzxu670e8+LyxQLxJSFdSQ29LsPGni/2FApfX8rbL2Wr2nwXwCkXVZu0PHmqqhlEb
 V6KE/RKoxAd4EWoealKvez2hC9b8BfcoGdprwwHH+6Om2vbkuJtcRX0z1BGhJFxPv8
 p+unEGTCUwV3Z1WIJkVXVLM5fEnMbFXBtAkGqbiHW07w4y6ksFzIA0Q60jusj8iR5n
 QF8UKaKVQHnp89bIRKPpQO1fUmiSyqseRtiPVOBm4LfNEvD03HpaD4RDz1Ztujf8kJ
 ZcXHXPgsJH+Rg==
Message-ID: <sashiko-outbox-199561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/27] drm/connector: Add
 drm_display_info_is_vrr_capable
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-8-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-8-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:58:18 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/connector: false VRR capability in drm_display_info_is_vrr_c=
apable()
--

commit 2c6b233292887595c2334a70a795f9f766983787
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: Add drm_display_info_is_vrr_capable

This commit adds drm_display_info_is_vrr_capable() to check whether a sink
described by struct drm_display_info supports variable refresh rate signals.
It checks info->hdmi.vrr_cap.supported for HDMI sinks and
info->monitor_range.min_vfreq > 0 for other displays.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 65c14b6e47a6f..a44afba8c5ff2 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1378,6 +1378,25 @@ int drm_display_info_set_bus_formats(struct drm_di=
splay_info *info,
>  }
>  EXPORT_SYMBOL(drm_display_info_set_bus_formats);
> =20
> +/**
> + * drm_display_info_is_vrr_capable - Check whether sink is VRR capable
> + * @info: pointer to a &struct drm_display_info representing the sink
> + *
> + * Check whether the sink supports variable refresh rate signals.
> + *
> + * Returns:
> + * - true if variable refresh rate is supported by the sink
> + * - false otherwise
> + */
> +bool drm_display_info_is_vrr_capable(const struct drm_display_info *info)
> +{
> +	if (info->is_hdmi)
> +		return info->hdmi.vrr_cap.supported;
> +
> +	return info->monitor_range.min_vfreq > 0;
> +}

[Severity: Medium]
As reported by Sashiko on RFC [1], in drm_display_info_is_vrr_capable() in
drivers/gpu/drm/drm_connector.c, can returning info->monitor_range.min_vfre=
q > 0
for any sink where info->is_hdmi is false falsely report VRR support on
non-VRR displays?

In drivers/gpu/drm/drm_edid.c, drm_get_monitor_range() -> get_monitor_range=
()
populates info->monitor_range from any standard EDID 1.4+ continuous-freque=
ncy
(DRM_EDID_FEATURE_CONTINUOUS_FREQ) Display Range Limits descriptor (tag 0xF=
D)
with DRM_EDID_RANGE_LIMITS_ONLY_FLAG:

drivers/gpu/drm/drm_edid.c:get_monitor_range() {
	...
	monitor_range->min_vfreq =3D range->min_vfreq;
	monitor_range->max_vfreq =3D range->max_vfreq;
	...
}

Existing VRR checks in drivers/gpu/drm/i915/display/intel_vrr.c and
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c do not rely on
min_vfreq > 0 alone. Both check for DPCD MSA timing ignore support and requ=
ire
a valid range span larger than 10 Hz:

drivers/gpu/drm/i915/display/intel_vrr.c:intel_vrr_is_capable() {
	...
	if (!info->monitor_range.min_vfreq || !info->monitor_range.max_vfreq ||
	    info->monitor_range.min_vfreq > info->monitor_range.max_vfreq)
		return false;

	return info->monitor_range.max_vfreq - info->monitor_range.min_vfreq > 10;
}

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c:amdgpu_dm_updat=
e_freesync_caps() {
	...
	if (amdgpu_dm_connector->dc_link &&
	    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param=
 &&
	    amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
		freesync_capable =3D true;
	...
}

Without checking DPCD capabilities (which are not stored in struct
drm_display_info) or validating max_vfreq and max_vfreq - min_vfreq > 10, a
standard non-VRR monitor with a 50-60 Hz range descriptor, a malformed range
descriptor, or a DVI/non-VSDB sink attached to an HDMI connector (where
info->is_hdmi is false) will cause drm_display_info_is_vrr_capable() to ret=
urn
true. On HDMI encoders using this helper, that advertises vrr_capable as tr=
ue
even though HDMI VRR validation later rejects VRR commits with -EOPNOTSUPP.

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-9-2fcd7d011646@c=
ollabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D8
