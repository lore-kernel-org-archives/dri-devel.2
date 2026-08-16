Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD5CC5DF66
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C70B10E195;
	Sun, 16 Aug 2026 09:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IwMAkixC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C15010E278
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 09:00:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AED044332C;
 Sun, 16 Aug 2026 09:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D5B1F000E9;
 Sun, 16 Aug 2026 09:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786870840;
 bh=7EBAAmsRKuxArLWW43/WVOwXnZRf9NBEcl9SgaW6408=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IwMAkixCIH1e3Fg0MQ+choOKBHvi/iJcC/ZrIv/y/yvWgONW8330Jfsylr2mGt0F9
 HhjPUoZ0LyERo6FYr35ITXIEweY4pdhLrF+akC6AcjXh85/3CIHzvhm2B2YVm/frNp
 GcBVMcovnkd896bnjcmgp+LHDCIAAKrcyrhpdsfDMxOyF1J1SX4hF8kkXHFyebWffy
 cd2I8H4HFBiWNHxKzlW8QyJu8cGPCbW3M8LfksOgORP9NWEG14ui4uKXq7mZT1MSu+
 HpH1/2ydPf5W8Z+pB6f0YNw4lg7Nl7rtQ/GJaXDkZZgIeUir/J7nDWoAEIUpfEMDbb
 FmHRTdUb2WD5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/gud: NUL-terminate TV mode names read from the device
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260816085234.22053-1-kartikey406@gmail.com>
References: <20260816085234.22053-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 09:00:39 +0000
Message-Id: <20260816090040.68D5B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A malicious or misconfigured USB device can cause a NULL pointer d=
ereference and kernel panic in `drm_object_attach_property` by returning `G=
UD_PROPERTY_TV_MODE` after any other non-margin TV property (such as `GUD_P=
ROPERTY_TV_BRIGHTNESS` or `GUD_PROPERTY_TV_HUE`).
--

--- Patch [1]: [PATCH] drm/gud: NUL-terminate TV mode names read from the d=
evice ---
commit 789868bcbf6cc6ddf0d3b74feab3a22914863ec8
Author: Deepanshu Kartikey <kartikey406@gmail.com>

drm/gud: NUL-terminate TV mode names read from the device

This commit fixes a potential out-of-bounds read by explicitly NUL-terminat=
ing
TV mode names read from the USB device. This ensures strlen() won't run past
the end of the allocation when passed to drm_mode_create_tv_properties_lega=
cy().

Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
Reported-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D916c888ba5f1a54c9526
Tested-by: syzbot+916c888ba5f1a54c9526@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ea0cca58b7c89..5c0065c876a77 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -396,8 +396,13 @@ static int gud_connector_add_tv_mode(struct gud_devi=
ce *gdrm, struct drm_connect
>  	}
> =20
>  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> -	for (i =3D 0; i < num_modes; i++)
> -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +	for (i =3D 0; i < num_modes; i++) {
> +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +
> +		/* The device is not trusted to NUL-terminate the name */
> +		mode[GUD_CONNECTOR_TV_MODE_NAME_LEN - 1] =3D '\0';
> +		modes[i] =3D mode;
> +	}
> =20
>  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_modes,=
 modes);

[Severity: High]
This is a pre-existing issue, but could a malicious or misconfigured USB de=
vice
cause a NULL pointer dereference and kernel panic by returning
GUD_PROPERTY_TV_MODE after another non-margin TV property?

In gud_connector_add_properties(), properties from the USB device are proce=
ssed
sequentially. If a property like GUD_PROPERTY_TV_BRIGHTNESS is processed fi=
rst,
drm_mode_create_tv_properties_legacy() creates the baseline TV properties b=
ut
leaves legacy_tv_mode_property as NULL since num_modes is 0.

If GUD_PROPERTY_TV_MODE is processed next, it calls gud_connector_add_tv_mo=
de()
which then calls drm_mode_create_tv_properties_legacy() here:

drivers/gpu/drm/drm_connector.c:drm_mode_create_tv_properties_legacy() {
    ...
	if (dev->mode_config.tv_select_subconnector_property)
		return 0;
    ...
}

This early return prevents dev->mode_config.legacy_tv_mode_property from
being created.

Then in gud_connector_add_properties(), gud_connector_property_lookup()
will return NULL for legacy_tv_mode_property:

drivers/gpu/drm/gud/gud_connector.c:gud_connector_add_properties() {
    ...
		property =3D gud_connector_property_lookup(connector, prop);
		if (drm_WARN_ON(drm, IS_ERR(property)))
			continue;
    ...
}

Since IS_ERR() ignores NULL, the NULL property pointer bypasses this check =
and
is passed to drm_object_attach_property(), which unconditionally dereferenc=
es
it:

drivers/gpu/drm/drm_mode_object.c:drm_object_attach_property() {
    ...
	struct drm_device *dev =3D property->dev;
    ...
}

Could this lead to a local denial of service?

>  free:
>  	kfree(buf);
>  	if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816085234.2205=
3-1-kartikey406@gmail.com?part=3D1
