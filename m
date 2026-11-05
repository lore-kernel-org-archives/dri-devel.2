Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0C606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DrhsHiv7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED2810E963;
	Thu,  5 Nov 2026 17:08:36 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8DCC10E960
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:08:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34AB1600E4;
 Thu,  5 Nov 2026 17:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D0C1F00A15;
 Thu,  5 Nov 2026 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793898508;
 bh=XONHmjXTxGC+0bTqoBQSxY2DRdFqjWOexxwkJrp1bIs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DrhsHiv7itiyvdpy2g0W3AQ6HziYW7v95WTxbDeFUGbKBhvcVcjwpwcKMsx7iLDkZ
 r9536LhqNpTVT8EkSvKddGqDvPfSc1GexWtxRKIF9xzo9M+w8qcFEYk0zYv4S1qw/j
 JXYdXJxikzC0iU+OqQ+c4g29CHFPWzSvCBXWPT7viICW6g4SdyeE0ORB1O6uxZGS6g
 fn5or/kpQVMMMgLxTEm7ZAfkdllw7mEpJhpApb+7dDjiQ99TknIeDkr85WeZCH9hVy
 jo3SMhk/KTmSMf9BlBQRjRgx3GbALPBtM+k5G/YCeZy48yKZEFnyBGyxVjjxh3P7vG
 PRX0lP8Z0XF/Q==
Message-ID: <sashiko-outbox-199577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/27] drm/connector: Add vrr_display_{min,max}
 connector properties
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-10-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-10-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:08:28 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] drm/hdmi: handle vrr_max =3D=3D 0 in drm_connector_hdmi_update_v=
rr_limits()
- [Medium] drm/hdmi: stale VRR limits on unplug in drm_connector_hdmi_updat=
e_vrr_limits()
- [Medium] drm/hdmi: unclamped cnmvrr max_hz in drm_connector_hdmi_update_v=
rr_limits()
--

commit 8141ba1132150753b66c1d4aef2157bc2d78d4cb
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: Add vrr_display_{min,max} connector properties

This commit adds the immutable vrr_display_min and vrr_display_max connector
properties to expose the minimum and maximum integer refresh rates supported
with VRR in the current mode. It also introduces helpers to attach these
properties and update their values for HDMI connectors.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/=
display/drm_hdmi_helper.c
> index f85cce3d62547..8f325d5e496d1 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> @@ -730,3 +730,58 @@ int drm_connector_hdmi_sync_scdc(struct drm_connecto=
r *connector, bool plugged,
>  	return ret;
>  }
>  EXPORT_SYMBOL(drm_connector_hdmi_sync_scdc);
> +
> +/**
> + * drm_connector_hdmi_update_vrr_limits - update VRR display limit prope=
rties
> + * @conn: pointer to the &struct drm_connector to set the properties on
> + * @mode: pointer to the &struct drm_display_mode to consider while upda=
ting
> + *
> + * Update the "vrr_display_min" and "vrr_display_max" properties on @con=
n based
> + * on its HDMI sink info and the current mode. Does not consider any dis=
play
> + * protocol other than HDMI.
> + *
> + * Will set both min and max to 0 if max happens to end up below min, wh=
ich can
> + * happen with CNMVRR=3D=3D0 and a lower refresh rate @mode.
> + *
> + * Return: %0 on success, negative errno otherwise
> + */
> +int drm_connector_hdmi_update_vrr_limits(struct drm_connector *conn,
> +					 const struct drm_display_mode *mode)
> +{
> +	struct drm_mode_object *obj =3D &conn->base;
> +	const struct drm_display_info *info;
> +	u16 min_hz, max_hz;
> +
> +	if (!conn->vrr_display_min_property || !conn->vrr_display_max_property)
> +		return -ENOENT;
> +
> +	info =3D &conn->display_info;
> +
> +	if (!info->is_hdmi)
> +		return -EINVAL;
> +
> +	if (conn->status !=3D connector_status_connected ||
> +	    !info->hdmi.vrr_cap.supported) {
> +		drm_object_property_set_value(obj, conn->vrr_display_min_property, 0);
> +		drm_object_property_set_value(obj, conn->vrr_display_max_property, 0);
> +
> +		return 0;
> +	}

[Severity: Medium]
When an HDMI VRR display is unplugged or replaced with a non-HDMI sink (such
as DVI), drm_edid_connector_update() calls drm_reset_display_info():

drivers/gpu/drm/drm_edid.c:drm_reset_display_info() {
	...
	info->is_hdmi =3D false;
	info->has_audio =3D false;
	info->has_hdmi_infoframe =3D false;
	info->rgb_quant_range_selectable =3D false;
	memset(&info->hdmi, 0, sizeof(info->hdmi));
	...
}

Because drm_connector_hdmi_update_vrr_limits() checks !info->is_hdmi and
returns -EINVAL before checking conn->status !=3D connector_status_connecte=
d,
won't calling this helper after an unplug or sink swap fail to reset
vrr_display_min_property and vrr_display_max_property to 0, leaving stale
non-zero limits exposed to userspace?

> +
> +	min_hz =3D info->hdmi.vrr_cap.vrr_min;
> +
> +	if (info->hdmi.vrr_cap.cnmvrr)
> +		max_hz =3D info->hdmi.vrr_cap.vrr_max;

[Severity: Medium]
Should max_hz still be clamped to drm_mode_vrefresh(mode) when
info->hdmi.vrr_cap.cnmvrr is set?

In HDMI 2.1, negative M_VRR (cnmvrr) only allows shortening Vfront by at mo=
st
ceil(Vfront_base / 4) lines in constant-rate CinemaVRR mode for fractional
pull-up (such as 59.94 Hz to 60 Hz), and cannot increase a lower-rate mode
(such as 60 Hz or 24 Hz) up to vrr_max (such as 120 Hz) at that mode's pixel
clock.

In addition, hdmi_validate_vrr() in
drivers/gpu/drm/display/drm_hdmi_state_helper.c unconditionally caps the
maximum refresh rate to mode_refresh regardless of cnmvrr:

	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
		max_vfreq_n =3D mode_refresh;
	...
	vrr_state->base_vtotal =3D max(vrr_state->base_vtotal, mode->crtc_vtotal);

Leaving max_hz unclamped when cnmvrr is true advertises a vrr_display_max
above mode_refresh that hdmi_validate_vrr() will reject, and also causes
modes with drm_mode_vrefresh(mode) <=3D min_hz (for example, a 24 Hz mode o=
n a
48-120 Hz display) to bypass the max_hz <=3D min_hz check below instead of
reporting 0.

> +	else
> +		max_hz =3D min(drm_mode_vrefresh(mode), info->hdmi.vrr_cap.vrr_max);
> +
> +	/* VRR is impossible in the current mode */
> +	if (max_hz <=3D min_hz)
> +		min_hz =3D max_hz =3D 0;

[Severity: Medium]
What happens here when a VRR-capable HDMI 2.1 sink leaves vrr_max as 0 in i=
ts
EDID HF-VSDB to indicate that the upper VRR bound is the video mode's base
refresh rate?

In drivers/gpu/drm/drm_edid.c, drm_parse_hdmi_gaming_info() treats
vrr_max =3D=3D 0 as valid when VRR is supported:

	vrr->vrr_min =3D db[9] & DRM_EDID_VRR_MIN_MASK;
	vrr->supported =3D (vrr->vrr_min > 0 && vrr->vrr_min <=3D 48);

	if (cea_db_payload_len(db) < 10)
		return;

	vrr->vrr_max =3D (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
	vrr->supported &=3D (vrr->vrr_max =3D=3D 0 || vrr->vrr_max >=3D 100);

And hdmi_validate_vrr() in drivers/gpu/drm/display/drm_hdmi_state_helper.c
handles a 0 maximum by falling back to mode_refresh:

	if (!max_vfreq_n || max_vfreq_n > mode_refresh)
		max_vfreq_n =3D mode_refresh;

In drm_connector_hdmi_update_vrr_limits(), however, if
info->hdmi.vrr_cap.vrr_max is 0, both branches of the if/else evaluate
max_hz to 0, which then triggers max_hz <=3D min_hz and sets both
vrr_display_min_property and vrr_display_max_property to 0. Should a vrr_max
of 0 fall back to drm_mode_vrefresh(mode) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D10
