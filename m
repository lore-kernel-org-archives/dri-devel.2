Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB7606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDh8MLXq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD8610F923;
	Tue,  3 Nov 2026 23:10:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CBA710F91B;
 Tue,  3 Nov 2026 23:10:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BA0D60A8D;
 Tue,  3 Nov 2026 23:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF81F000C1;
 Tue,  3 Nov 2026 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793747399;
 bh=8Si+XmxWzgr87kGWmlEvvlEAJS81hAS7l0CWmj13ZBM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BDh8MLXqA5DyjItX0wmtXDJhbBHNQPGTbdPzEbulucedGPXSTUODxFct/bUWWZlqL
 tJz/VEkEK1TXacKiV2WlQG9UNvRPJjUaLIcFqz7MUay1G4c5y5/7sPmWa/24lP2x0M
 LtbhLFtPbhb+y/9LD/Mpdapkjb8WSC6D/UPjWbEs9cxuG5HsYXIsyuEhvCorBgc9R1
 NjTUut73g3yhwxXlzdaVx6TvHp22ADo9OHofBXVgTmnUtEqg6wzg6ftVhYOzajLsji
 94NAPpfFd0QgDhATuth+gJNXQrcjPE9OU4vUmaGa86wYrenoyg6sQILQ70HfSQyV4V
 DIjWQGQkyYA1g==
Message-ID: <sashiko-outbox-196181@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/12] drm/nouveau: add connector luminance support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103-superm1-backlight-property-v11-9-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-9-00cce7b2ba22@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:09:59 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/nouveau: unclamped brightness in nv50_backlight_init() fails p=
robe
--

commit 1fa85caad592bf2bf4349656251ad8e42ff132c3
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/nouveau: add connector luminance support

This commit exposes Nouveau panel brightness through the atomic connector
LUMINANCE property when DRM_LUMINANCE is enabled and atomic modesetting is
active, while retaining the backlight class device fallback otherwise.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/dr=
m/nouveau/nouveau_backlight.c
> index da1ee24a2531d..2366901581077 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
> @@ -234,12 +234,15 @@ nv50_backlight_init(struct nouveau_backlight *bl,
>  		    const struct backlight_ops **ops)
>  {
>  	struct nouveau_drm *drm =3D nouveau_drm(nv_encoder->base.base.dev);
> +	int brightness;
> +
> +	brightness =3D nvif_outp_bl_get(&nv_encoder->outp);
> =20
>  	/*
>  	 * Note when this runs the connectors have not been probed yet,
>  	 * so nv_conn->base.status is not set yet.
>  	 */
> -	if (nvif_outp_bl_get(&nv_encoder->outp) < 0 ||
> +	if (brightness < 0 ||
>  	    drm_helper_probe_detect(&nv_conn->base, NULL, false) !=3D connector=
_status_connected)
>  		return -ENODEV;
> =20
> @@ -284,11 +287,25 @@ nv50_backlight_init(struct nouveau_backlight *bl,
> =20
>  	*ops =3D &nv50_bl_ops;
>  	props->max_brightness =3D 100;
> +	props->brightness =3D brightness;
>  	return 0;
>  }

[ ... ]

> @@ -349,26 +368,36 @@ nouveau_backlight_init(struct drm_connector *connec=
tor)
>  		goto fail_alloc;
>  	}
> =20
> -	if (!nouveau_get_backlight_name(backlight_name, bl)) {
> -		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight inte=
rface\n");
> -		goto fail_alloc;
> -	}
> -
>  	props.type =3D BACKLIGHT_RAW;
> -	bl->dev =3D backlight_device_register(backlight_name, connector->kdev,
> -					    nv_encoder, ops, &props);
> -	if (IS_ERR(bl->dev)) {
> -		if (bl->id >=3D 0)
> -			ida_free(&bl_ida, bl->id);
> -		ret =3D PTR_ERR(bl->dev);
> -		goto fail_alloc;
> +	if (nouveau_backlight_use_luminance(connector->dev)) {
> +		ret =3D drm_connector_attach_luminance_property(connector, 0, props.ma=
x_brightness,
> +							      props.brightness);
> +		if (ret)
> +			goto fail_alloc;

[Severity: High]
Can an unclamped initial brightness in nv50_backlight_init() cause
drm_connector_attach_luminance_property() to return -EINVAL and abort the
entire DRM device probe in nouveau_drm_device_init()?

In the nouveau_drm_device_init() -> nouveau_backlight_luminance_init() ->
nouveau_backlight_create() -> nv50_backlight_init() path, non-DPCD SOR
backlights set props->max_brightness =3D 100 and assign props->brightness =
=3D
brightness from nvif_outp_bl_get(&nv_encoder->outp) without clamping.

On NV50/G84/G94/MCP77, nv50_sor_bl_get() reads the 11-bit duty cycle field
and divides by a hardcoded div of 1025 without clamping (unlike
gt215_sor_bl_get()):

drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c:nv50_sor_bl_get() {
	u32 div =3D 1025;
	u32 val =3D nvkm_rd32(device, 0x61c084 + soff);
	val &=3D 0x000007ff;
	return ((val * 100) + (div / 2)) / div;
}

When the 11-bit register value is between 1031 and 2047, nv50_sor_bl_get()
returns 101..200. Similarly, for eDP DPCD panels already in
DP_EDP_BACKLIGHT_CONTROL_MODE_DPCD mode, drm_edp_backlight_init() ->
drm_edp_backlight_probe_state() reads the raw 8-bit or 16-bit
DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB registers into current_level without
clamping to bl->edp_info.max.

Previously, nv50_backlight_init() left props->brightness as 0 for non-DPCD
panels, and backlight_device_register() did not reject brightness >
max_brightness. With this change, drm_connector_attach_luminance_property()
checks:

	if (drm_WARN_ON(connector->dev, min > max || value < min || value > max))
		return -EINVAL;

Because nouveau_drm_device_init() treats any non-zero return from
nouveau_backlight_luminance_init() as fatal (jumping to fail_backlight),
should props.brightness be clamped to props.max_brightness before calling
drm_connector_attach_luminance_property()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-ba=
cklight-property-v11-0-00cce7b2ba22@kernel.org?part=3D9
