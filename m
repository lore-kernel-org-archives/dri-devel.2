Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AF606A320
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5367NdD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6BA10F11E;
	Mon, 26 Oct 2026 20:14:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4F510F120
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 20:14:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24735415DA;
 Mon, 26 Oct 2026 20:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EB21F01825;
 Mon, 26 Oct 2026 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793045659;
 bh=ueSkdDEiPmgQG7zb4RyC7y2axiBFPfc/Lp4D710xmX0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n5367NdDWFsPJtBph/r8cP59SwgTAV0Aic2D6CoAt49Z+uRV9O77oY9vQHzsYKDBE
 8LLpzlbG6dANaGJ/gtOvqjYj/h8AJ7BjBDoxizG35nPHNc5oVVlWpVGO66yGL+M1oW
 BjQ6Lyic2fp9OxbR/EHtzraemzW8mJq8bDo6/mj5qZTHohPHxcC83t31f/jqHsEwWU
 pzCl5z+fz6me4yvZYZQnrwcZ5vr4RgnJrIGY9IR3g10m75NesqfLe6VaWm8fbtY6OF
 /t/EvCVQa76wR6vJsRYgcUJJFhjm8rgqHT9p5vD3LkOXJD3vAuIuw7J0wocHdAsXrC
 R9vqqLxF2OChg==
Message-ID: <sashiko-outbox-185705@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/gud: move format init from gud_probe()
To: "Ruben Wauters" <rubenru09@aol.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026200739.18523-2-rubenru09@aol.com>
References: <20261026200739.18523-2-rubenru09.ref@aol.com>
 <20261026200739.18523-2-rubenru09@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 20:14:18 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/gud: unsigned num_formats in gud_probe() misses errors and cau=
ses OOB read
- [Medium] drm/gud: gud_get_max_buffer_size() sizes buffer using emulated X=
RGB8888
--

commit 19e6d0cc37d9a0a4a7292d2a1f0cf5690fddd459
Author: Ruben Wauters <rubenru09@aol.com>

drm/gud: move format init from gud_probe()

This commit refactors pixel format initialization out of gud_probe() into
dedicated helper functions gud_get_formats() and gud_get_max_buffer_size().

> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 680447f426f37..278cc9bf68d02 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -435,11 +435,123 @@ static void gud_free_buffers_and_mutex(void *data)
>  	mutex_destroy(&gdrm->ctrl_lock);
>  }
> =20
> -static int gud_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +static size_t gud_get_max_buffer_size(struct gud_device *gdrm, u32 *form=
ats, u32 num_formats)
> +{
> +	struct drm_device *drm =3D &gdrm->drm;
> +	size_t max_buffer_size =3D 0;
> +	size_t fmt_buf_size;
> +	int i;
> +
> +	for (i =3D 0; i < num_formats; i++) {
> +		const struct drm_format_info *info =3D drm_format_info(formats[i]);
> +
> +		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config.m=
ax_width) *
> +							 drm->mode_config.max_height;
> +		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> +	}
> +
> +	/* GUD_DRM_FORMAT_R1 and GUD_DRM_FORMAT_XRGB1111 are not in the formats=
 array. */
> +	/* Ensure there is enough space for them. */
> +	fmt_buf_size =3D drm_format_info_min_pitch(&gud_drm_format_r1, 0,
> +						 drm->mode_config.max_width) *
> +						 drm->mode_config.max_height;
> +	max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> +
> +	fmt_buf_size =3D drm_format_info_min_pitch(&gud_drm_format_xrgb1111, 0,
> +						 drm->mode_config.max_width) *
> +						 drm->mode_config.max_height;
> +	max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> +
> +	return max_buffer_size;
> +}

[Severity: Medium]
Does gud_get_max_buffer_size() end up computing max_buffer_size for a 32-bpp
format regardless of the formats supported by the device?

Previously in gud_probe(), max_buffer_size was calculated inside the loop o=
ver
formats_dev before the emulated DRM_FORMAT_XRGB8888 was appended to formats=
[],
because XRGB8888 framebuffers are converted down to
gdrm->xrgb8888_emulation_format in bulk_buf.

With this change, gud_get_formats() appends DRM_FORMAT_XRGB8888 to formats[]
before gud_get_max_buffer_size() is called:

	if (!xrgb8888_supported && xrgb8888_emulation_format) {
		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
	}

Since every valid format returned by gud_to_fourcc() is either already 32-b=
pp
(DRM_FORMAT_XRGB8888, DRM_FORMAT_ARGB8888) or sets xrgb8888_emulation_forma=
t,
formats[] always contains a 32-bpp format when passed to
gud_get_max_buffer_size(). As a result, when desc.max_buffer_size is not se=
t,
gdrm->bulk_buf and gdrm->compress_buf are sized for 4 bytes per pixel even =
on
devices that only support smaller wire formats (such as R1, XRGB1111, R8,
RGB332, or RGB565), and the subsequent max() checks for gud_drm_format_r1 a=
nd
gud_drm_format_xrgb1111 become no-ops.

[ ... ]

> +static int gud_probe(struct usb_interface *intf, const struct usb_device=
_id *id)
> +{
> +	unsigned int num_formats =3D 0;

[ ... ]

> @@ -510,81 +621,16 @@ static int gud_probe(struct usb_interface *intf, co=
nst struct usb_device_id *id)
>  	drm->mode_config.helper_private =3D &gud_mode_config_helpers;
> =20
>  	/* Format init */
> -	formats_dev =3D devm_kmalloc(dev, GUD_FORMATS_MAX_NUM, GFP_KERNEL);
>  	/* Add room for emulated XRGB8888 */
>  	formats =3D devm_kmalloc_array(dev, GUD_FORMATS_MAX_NUM + 1, sizeof(*fo=
rmats), GFP_KERNEL);
> -	if (!formats_dev || !formats)
> +	if (!formats)
>  		return -ENOMEM;
> =20
> -	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_FORMATS, 0, formats_dev, GUD_FORM=
ATS_MAX_NUM);

[ ... ]

> +	num_formats =3D gud_get_formats(gdrm, formats);
> +	if (num_formats <=3D 0)
> +		return num_formats;
> =20
> +	max_buffer_size =3D gud_get_max_buffer_size(gdrm, formats, num_formats);

[Severity: High]
Since num_formats is declared as unsigned int in gud_probe(), won't negative
error codes returned by gud_get_formats() (such as -ENOMEM, -EINVAL, or an
error from gud_usb_get()) wrap to a large positive value?

When gud_get_formats() fails, the check if (num_formats <=3D 0) evaluates to
false (and triggers a -Wtype-limits warning), causing gud_probe() to pass t=
he
wrapped unsigned value into gud_get_max_buffer_size() and read past the end=
 of
the formats[] array in the loop over num_formats. Should num_formats be a
signed int (or assigned via ret first)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026200739.1852=
3-2-rubenru09@aol.com?part=3D1
