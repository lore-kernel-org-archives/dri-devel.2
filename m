Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC5ACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:34:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A1E10E6D3;
	Mon, 22 Jun 2026 13:34:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DUe6dKfN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B63C10E6EF
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:34:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34801601F3;
 Mon, 22 Jun 2026 13:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21D1F000E9;
 Mon, 22 Jun 2026 13:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782135296;
 bh=jFfbuT4hoKJvJRQ2979HoM2gb7hdpsM93u48Vo8fLTw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DUe6dKfNOaiYlM5TIITau4gHbzUkW1c2OeVJC6PbyAIdd+WOR/mFhcgSKK9rO4KUN
 +4hQqqe1vMJNL3y3vLXZL0u6WdhP3c2C7HRELJHmEPIL5EYvTAalefxS3I1wDmKCX/
 wlgbAeuwX7uknMdkMBa0ZT/sueUMOKlPCRkBcHIVakozeilp20pqecpsWYdR+YIPaQ
 5ZqVFPJaKCosNL6gjNSrL3Vo4QBeD5c7uMdgoVJpYqctDKXdwjTg0QN+Rek7zEhmnL
 x+4RsxBJKOzz/6xTZVJNAYWj3LY6m4qfqtyj3V2E1Indh2j1NGg4Ei9iPW6FM4kvP3
 Pv/E05xSbEnfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] drm/sysfb: simpledrm: Read panel orientation
 from DT node
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622132433.722823-7-tzimmermann@suse.de>
References: <20260622132433.722823-1-tzimmermann@suse.de>
 <20260622132433.722823-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 13:34:56 +0000
Message-Id: <20260622133456.BA21D1F000E9@smtp.kernel.org>
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
- [High] Blindly applying physical panel rotation to a logical framebuffer =
can cause double rotation if the firmware already applied hardware rotation.
- [Low] The patch duplicates the existing `of_drm_get_panel_orientation()` =
helper and introduces noisy debug logging for normal conditions.
--

commit a3e8de9befee02f75cbf1e8ca7ff150f4438c5f5
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/sysfb: simpledrm: Read panel orientation from DT node

A DeviceTree panel node can specify the panel's rotation in steps
of 90 degrees. Set the DRM connector orientation from the field.
Do nothing if the field is missing or invalid.

> diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/si=
mpledrm.c
> index a04f0c852ea48..b585d17ca8177 100644
> --- a/drivers/gpu/drm/sysfb/simpledrm.c
> +++ b/drivers/gpu/drm/sysfb/simpledrm.c
> @@ -221,6 +221,33 @@ simplefb_get_panel_height_mm_of(struct drm_device *d=
ev, struct device_node *of_p
>  	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
>  }
> =20
> +static enum drm_panel_orientation
> +simplefb_get_panel_orientation_of(struct drm_device *dev, struct device_=
node *of_panel_node)
> +{
> +	int ret;
> +	u32 rotation;
> +
> +	ret =3D of_property_read_u32(of_panel_node, "rotation", &rotation);
> +	if (ret) {
> +		drm_dbg(dev, "simplefb: cannot parse panel rotation: error %d\n", ret);

[Severity: Low]
Is it intentional to log a debug message here when the property is missing?

Since most device tree panel nodes do not include a rotation property,
of_property_read_u32() will return -EINVAL and spam the DRM debug logs with
"cannot parse panel rotation: error -22" on almost every boot when debug
logging is enabled.

Also, does this function reimplement the parsing logic from
of_drm_get_panel_orientation() which explicitly treats missing properties
silently?

> +		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
> +	}
> +
> +	switch (rotation) {
> +	case 0:
> +		return DRM_MODE_PANEL_ORIENTATION_NORMAL;

[ ... ]

> @@ -689,6 +717,7 @@ static struct simpledrm_device *simpledrm_device_crea=
te(struct drm_driver *drv,
>  		if (panel_node) {
>  			width_mm =3D simplefb_get_panel_width_mm_of(dev, panel_node);
>  			height_mm =3D simplefb_get_panel_height_mm_of(dev, panel_node);
> +			orientation =3D simplefb_get_panel_orientation_of(dev, panel_node);

[Severity: High]
Does unconditionally applying the physical panel rotation to the logical
framebuffer risk double rotation?

The simpledrm driver operates on a logical framebuffer pre-configured by the
firmware. If the firmware has already configured the display controller to
perform hardware rotation (e.g., exposing a 1920x1080 memory buffer for a
physically 1080x1920 panel mounted sideways), the simplefb node describes
an already-upright logical framebuffer.

If simpledrm blindly applies the physical rotation from the panel node to t=
he
DRM connector, userspace compositors might apply a software rotation on top
of the firmware's hardware rotation, causing the final image to be rendered
sideways or distorted.

Is there a way to verify if the firmware already applied hardware rotation
before mapping physical panel properties here?

>  			of_node_put(panel_node);
>  		}
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622132433.7228=
23-1-tzimmermann@suse.de?part=3D6
