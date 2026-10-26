Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAD1606A321
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2xd7ec1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F2B810E0AC;
	Mon, 26 Oct 2026 21:07:49 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 387E710E070
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:07:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36528601EF;
 Mon, 26 Oct 2026 21:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA11F01825;
 Mon, 26 Oct 2026 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793048860;
 bh=0UX+WA/cEO+1hQ+4i1VHjo/m5l13QbP0jF851sFJvS4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g2xd7ec1HBsaYDxnZdRAGk0CNcPVx8Szm+Z06puYNhYDYkhCla6nhMcikzrVHNVb2
 lZ5DO65pJASaYhn9pYSVij3joIQW2QVK5WbkRyLh1T+GouMP5yRLqHHqRuS3gZVh+y
 UjaTZhWXtImwYA6P3TuPPiVQMFuaUoqgx1yF1cFL4LQ56VKNEnOgePNa5G1sIca2Vu
 2XUMIbGnf/jBpnRaUpoRB9Da5n93/yu8kGUxHIuO9t+nbRUToRYVxmN5XT4O3yhM+O
 nKFC7yYUk1mC0v4JgbKG+onvplMEH3wgNFe0/bNCghgSdKSnrYWCdQhfKmX+KNryJz
 IZFuxIowvf3Gw==
Message-ID: <sashiko-outbox-185743@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/gud: move format init from gud_probe()
To: "Ruben Wauters" <rubenru09@aol.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026210116.10082-1-rubenru09@aol.com>
References: <20261026210116.10082-1-rubenru09.ref@aol.com>
 <20261026210116.10082-1-rubenru09@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 21:07:40 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/gud: zero max_buffer_size in gud_get_max_buffer_size() for R1/=
XRGB1111
--

commit 9571a61953c7bcaa943faf581ba726cb4c44a2b4
Author: Ruben Wauters <rubenru09@aol.com>

drm/gud: move format init from gud_probe()

This patch factors pixel format initialization and maximum buffer size
calculation out of gud_probe() into helper functions gud_get_formats() and
gud_get_max_buffer_size().

> diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
> index 680447f426f37..36adf2e2b6a2e 100644
> --- a/drivers/gpu/drm/gud/gud_drv.c
> +++ b/drivers/gpu/drm/gud/gud_drv.c
> @@ -435,11 +435,115 @@ static void gud_free_buffers_and_mutex(void *data)
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
> +		/* Skip over emulated XRGB8888 */
> +		if (formats[i] =3D=3D DRM_FORMAT_XRGB8888 && gdrm->xrgb8888_emulation_=
format)
> +			continue;
> +
> +		fmt_buf_size =3D drm_format_info_min_pitch(info, 0, drm->mode_config.m=
ax_width) *
> +							 drm->mode_config.max_height;
> +		max_buffer_size =3D max(max_buffer_size, fmt_buf_size);
> +	}
> +
> +	return max_buffer_size;
> +}

[Severity: High]
Could skipping emulated DRM_FORMAT_XRGB8888 in gud_get_max_buffer_size()
cause max_buffer_size to be calculated as 0 when a device only supports
internal formats (GUD_DRM_FORMAT_R1 or GUD_DRM_FORMAT_XRGB1111)?

In gud_get_formats(), GUD_DRM_FORMAT_R1 and GUD_DRM_FORMAT_XRGB1111 set
xrgb8888_emulation_format to &gud_drm_format_r1 or &gud_drm_format_xrgb1111,
and are then skipped before being added to formats[]:

	if (format =3D=3D GUD_DRM_FORMAT_R1 || format =3D=3D GUD_DRM_FORMAT_XRGB11=
11)
		continue; /* Internal not for userspace */

	formats[num_formats++] =3D format;

If the device only advertises GUD_PIXEL_FORMAT_R1 and/or
GUD_PIXEL_FORMAT_XRGB1111, num_formats remains 0 after the loop and
gud_get_formats() appends DRM_FORMAT_XRGB8888 as the sole entry in
formats[]:

	if (!xrgb8888_supported && xrgb8888_emulation_format) {
		gdrm->xrgb8888_emulation_format =3D xrgb8888_emulation_format;
		formats[num_formats++] =3D DRM_FORMAT_XRGB8888;
	}

Previously, gud_probe() computed fmt_buf_size inside the formats_dev loop
before skipping R1 and XRGB1111, so their buffer sizes were accounted for.

With this change, gud_get_max_buffer_size() skips the only entry in
formats[] and returns 0. When the optional desc.max_buffer_size descriptor
field is 0, gud_probe() sets gdrm->bulk_len =3D 0 and calls
gud_alloc_bulk_buffer():

gud_probe()
  gud_alloc_bulk_buffer()
    vmalloc_32(gdrm->bulk_len)

Passing 0 to vmalloc_32() triggers WARN_ON_ONCE(!size) and returns NULL,
causing gud_probe() to fail with -ENOMEM.

Should gud_get_max_buffer_size() substitute gdrm->xrgb8888_emulation_format
for info when formats[i] =3D=3D DRM_FORMAT_XRGB8888 and
gdrm->xrgb8888_emulation_format is set, instead of skipping it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026210116.1008=
2-1-rubenru09@aol.com?part=3D1
