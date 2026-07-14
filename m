Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A1EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 00:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46A2010EB7A;
	Tue, 14 Jul 2026 00:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LymCYIB3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAD5710EA62
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 00:05:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F246160103;
 Tue, 14 Jul 2026 00:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881F01F000E9;
 Tue, 14 Jul 2026 00:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783987513;
 bh=4Xlaymp33SD+toK4+IRPHoM9l80gXDHNqv9W6m3SHeE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LymCYIB3CACtp1QwLC8XFrGDgmjnaQ2QGcainzzoawfHJ2rZqrHkM7m0MJ7TX1CKw
 b3gbu2jTMQfEMc/9HPkL7JjpH4Dw3rlho0iEsZYwXOl5eFd4S2rQ6uC6d22q/UKo4G
 GLqffEzo+eAwlAmd6mtVWijt67ans+8e4RbR95leMxgCSLnZDlqyQEJa9uN4aqOnld
 j1HJBmHja4xUYFxHJcY2cwNVU355BW/d5QqMT98QYi/t6nrlvr/+Vbb5RpAIxErqra
 xo6BPN0Q/JkTgMoGXATOW/rXdpthjMAi6qXa8ExM/2CvV4Gg84lxxBmsZZ6MlIjmTE
 f0chA4bd/Tiuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] drm: writeback: drop excess connector
 initialization functions
To: "John Harrison" <John.Harrison@Igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713235153.3862650-9-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
 <20260713235153.3862650-9-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 00:05:13 +0000
Message-Id: <20260714000513.881F01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The function `drm_writeback_connector_init_with_encoder()` is co=
mpletely unused dead code that should have been removed.
- [Low] Kernel-doc comments still reference the removed `drm_writeback_conn=
ector_init()` function.

Pre-existing issues:
- [High] Device-wide writeback properties are unconditionally destroyed whe=
n a single writeback connector fails initialization, leading to a Use-After=
-Free for already initialized writeback connectors.
--

--- Patch [8]: [PATCH v7 8/9] drm: writeback: drop excess connector initial=
ization functions ---
commit 7c0a676196b264733f17d7cfc56986c51e0d9fd8
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm: writeback: drop excess connector initialization functions

This patch removes the unused drm_writeback_connector_init() function and
the encoder field from struct drm_writeback_connector now that drivers have
been converted to drmm_writeback_connector_init().

> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeb=
ack.c
> index b4a002e6d043d..683da368e339a 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c

[ ... ]

> @@ -148,61 +148,6 @@ static int create_writeback_properties(struct drm_de=
vice *dev)
>  	return 0;
>  }
> =20
> -static const struct drm_encoder_funcs drm_writeback_encoder_funcs =3D {
> -	.destroy =3D drm_encoder_cleanup,
> -};

[ ... ]

> -int drm_writeback_connector_init(struct drm_device *dev,

[ ... ]

> -EXPORT_SYMBOL(drm_writeback_connector_init);
> -

[Severity: High]
This is a pre-existing issue, but I noticed something about how these
properties are cleaned up on error.

If a device supports multiple writeback connectors and the first one
successfully initializes but the second fails, the error path in
__drm_writeback_connector_init() calls delete_writeback_properties():

__drm_writeback_connector_init() {
    ...
failed_properties:
    delete_writeback_properties(dev);
    return ret;
}

This frees the shared device-level properties like
writeback_pixel_formats_property. If the driver probe continues regardless
of the error, can this cause a Use-After-Free when userspace accesses the
freed properties via the drm_mode_getconnector ioctl on the surviving
first connector?

>  static void delete_writeback_properties(struct drm_device *dev)
>  {
>  	if (dev->mode_config.writeback_pixel_formats_property) {
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index c380a7b8f55a3..879ca103320cc 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -24,17 +24,6 @@ struct drm_writeback_connector {
>  	 */
>  	struct drm_connector base;
> =20
> -	/**
> -	 * @encoder: Internal encoder used by the connector to fulfill
> -	 * the DRM framework requirements. The users of the

[ ... ]

> -	struct drm_encoder encoder;
> -
>  	/**
>  	 * @pixel_formats_blob_ptr:
>  	 *

[Severity: Low]
Since drm_writeback_connector_init() is removed by this patch, should the
kernel-doc comments referencing it also be updated to prevent dangling
references?

For example, the documentation block right here for pixel_formats_blob_ptr
states: "See also drm_writeback_connector_init()"

There are also similar references in include/drm/drm_mode_config.h for the
writeback_fb_id_property, writeback_pixel_formats_property, and
writeback_out_fence_ptr_property fields.

[ ... ]

> @@ -148,13 +137,6 @@ drm_connector_to_writeback(struct drm_connector *con=
nector)
>  	return container_of(connector, struct drm_writeback_connector, base);
>  }
> =20
> -int drm_writeback_connector_init(struct drm_device *dev,
> -				 struct drm_writeback_connector *wb_connector,
> -				 const struct drm_connector_funcs *con_funcs,
> -				 const struct drm_encoder_helper_funcs *enc_helper_funcs,
> -				 const u32 *formats, int n_formats,
> -				 u32 possible_crtcs);
> -
>  int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
>  				struct drm_writeback_connector *wb_connector,
>  				struct drm_encoder *enc,

[Severity: Medium]
The commit message mentions dropping excess connector initialization functi=
ons.
Since the final usage in drm/vc4 was converted to the drmm variant, is
drm_writeback_connector_init_with_encoder() now unused dead code that should
also be removed here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713235153.3862=
650-1-John.Harrison@Igalia.com?part=3D8
