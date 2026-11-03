Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2DB606A328
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WV+DHZ8K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1BC10F8ED;
	Tue,  3 Nov 2026 23:02:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E3F710F8ED;
 Tue,  3 Nov 2026 23:02:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9FA3F60AAB;
 Tue,  3 Nov 2026 23:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E51F000C1;
 Tue,  3 Nov 2026 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793746961;
 bh=9Gu+yG5vQBM8xz99V5rQ9V/Lb5gWgEtZbgyRylRtvO4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WV+DHZ8KrexYH61j0gS6v1AfXVxtrYwWsxrUwe4r5kzsKh6upavRSbs/CE6CUE79H
 +0p9lnTaEhBMDJZinBcTXVuBAAHLEFc/1xR4ZQ5sZRpv7YPDlf+5D5R1vvsOuWleZs
 G6mqX9aEV3Ipo31jeqyyc5Y7ge86B+HC0+m0VeZ2rLpq9bfhxoe2Yr+EuhYqtizvyz
 bKe6mcMzSdSSQg1uiV6CJgWaLpZqYhrdJTwi1Z4PCp0z2i60ZjTH8iXW3p/2n34ajT
 /hLlWcjQlrlfVWXdP4mKrGj03nyNURtcaEUR2DNT9x1YjFZkEjdOxSYoekynjis9aG
 ezFH8U8rkuEUQ==
Message-ID: <sashiko-outbox-196172@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 11/12] drm/bridge: add PS8622 connector luminance
 support
To: =?utf-8?b?TWFyaW8gTGltb25jaWVsbG8gKEFNRCk=?= <superm1@kernel.org>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
 <20261103-superm1-backlight-property-v11-11-00cce7b2ba22@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:02:40 +0000
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
- [Medium] drm/bridge: ps8622: clobbered brightness in ps8622_backlight_upd=
ate()
--

commit a81389f64f9ebf64ed6660717e83f2f04182a30d
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/bridge: add PS8622 connector luminance support

This commit exposes PS8622 brightness control through bridge luminance
operations when DRM_LUMINANCE is enabled, while continuing to register the
backlight class device otherwise.

> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bri=
dge/parade-ps8622.c
> index 3a2ec482037df..c88bd7a97d4a4 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c

[ ... ]

> @@ -268,7 +270,7 @@ static int ps8622_send_config(struct ps8622_bridge *p=
s8622)
>  		goto error;
> =20
> =20
> -	if (ps8622->bl) {
> +	if (ps8622->internal_pwm) {
>  		/* DPCD720, internal PWM */
>  		err =3D ps8622_set(cl, 0x01, 0xa5, 0xa0);
>  		if (err)
> @@ -276,7 +278,7 @@ static int ps8622_send_config(struct ps8622_bridge *p=
s8622)
> =20
>  		/* FFh for 100% brightness, 0h for 0% brightness */
>  		err =3D ps8622_set(cl, 0x01, 0xa7,
> -				ps8622->bl->props.brightness);
> +				ps8622->brightness);
>  		if (err)
>  			goto error;
>  	} else {
> @@ -324,6 +326,8 @@ static int ps8622_backlight_update(struct backlight_d=
evice *bl)
>  	struct ps8622_bridge *ps8622 =3D dev_get_drvdata(&bl->dev);
>  	int ret, brightness =3D backlight_get_brightness(bl);
> =20
> +	ps8622->brightness =3D brightness;
> +
>  	if (!ps8622->enabled)
>  		return -EINVAL;

[Severity: Medium]
Can updating ps8622->brightness from backlight_get_brightness(bl) before
checking ps8622->enabled clobber the cached brightness with 0 when the
backlight is blanked while the bridge is disabled?

Previously, ps8622_send_config() programmed ps8622->bl->props.brightness,
which preserves the requested brightness level across blanking. Now it
programs ps8622->brightness, which is updated in ps8622_backlight_update()
from backlight_get_brightness(bl):

static inline int backlight_get_brightness(const struct backlight_device *b=
d)
{
	if (backlight_is_blank(bd))
		return 0;
	else
		return bd->props.brightness;
}

If userspace writes BACKLIGHT_POWER_OFF to bl_power while ps8622->enabled is
false, bl_power_store() in drivers/video/backlight/backlight.c temporarily
sets bd->props.power and calls backlight_update_status(bd) ->
ps8622_backlight_update(bl), which overwrites ps8622->brightness with 0 and
returns -EINVAL:

	if (bd->props.power !=3D power) {
		old_power =3D bd->props.power;
		bd->props.power =3D power;
		rc =3D backlight_update_status(bd);
		if (rc)
			bd->props.power =3D old_power;

Because ps8622_backlight_update() returns -EINVAL, bl_power_store() rolls
bd->props.power back to BACKLIGHT_POWER_ON, leaving the backlight device
unblanked at its non-zero bd->props.brightness while ps8622->brightness has
been overwritten with 0.

Similarly, during fbdev blanking or backlight_suspend(), if the bridge is
disabled first (setting ps8622->enabled =3D false in ps8622_post_disable())=
 and
the backlight notifier or suspend callback subsequently invokes
ps8622_backlight_update(bl), ps8622->brightness is overwritten with 0 while
disabled. On the next ps8622_pre_enable() -> ps8622_send_config(), the panel
backlight will be programmed to 0 instead of the configured brightness.

Would it make sense to avoid overwriting ps8622->brightness when returning
-EINVAL, or to keep using bl->props.brightness when restoring the initial
backlight level in ps8622_send_config()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-superm1-ba=
cklight-property-v11-0-00cce7b2ba22@kernel.org?part=3D11
