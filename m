Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32450CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBD910F677;
	Fri, 12 Jun 2026 18:49:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GoOS6S6Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2683F10EB04
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:49:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7927B601E4;
 Fri, 12 Jun 2026 18:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028551F000E9;
 Fri, 12 Jun 2026 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781290190;
 bh=wOaxXn+HT58YdNxz5JV3ky5LLNiPsp5SDlYCc3xHsfY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GoOS6S6ZFsxW3qvjqhgt/DQ2va6b8ZujTGu4hYMxBicr9JfKJRtm8HWdQ3boqitVC
 d76AgTNrZ5W1MbY54KNNx4Qdc+jZiwBfkv8CczbiC/nTdWH7Y95ymocq4p9NhsxJVB
 UhAIiJz3/i3BBw4QHISlZBT6hWNcX9jKUhZJT+a7GR/zlBuwW3Sq/O4hHtfolx0EM5
 2Mc99khDzKtrMSKd8uBv7aC7oEU8Pio8KHZngQSgiCxf1gnau2xKGTaZT/t04CYzzC
 84RcBWtYewtiAqoOCouaBdVR7r0LYbfSARB3GIc4MprVSM8toclMK9BugMMJh91UVB
 DpTE7cKZmDaOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 9/9] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-wb-drop-encoder-v6-9-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-9-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:49:49 +0000
Message-Id: <20260612184950.028551F000E9@smtp.kernel.org>
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

New issues:
- [Low] The kernel-doc comment for `drm_writeback_connector_init` has misma=
tched parameter ordering compared to the newly adapted function signature.

Pre-existing issues:
- [Critical] Failure to initialize a subsequent writeback connector destroy=
s global properties attached to already initialized writeback connectors, c=
ausing a Use-After-Free.
--

commit 04d131d999200c125f2670f5258a856880015f21
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm: writeback: rename drm_writeback_connector_init_with_encoder()
   =20
Rename drm_writeback_connector_init_with_encoder() to
drm_writeback_connector_init() and adapt its interface to follow
drmm_writeback_connector_init().

> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeb=
ack.c
> index 9fc15168c34f6..68fdac745f42f 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -235,7 +235,7 @@ static int __drm_writeback_connector_init(struct drm_=
device *dev,
>  }

[Severity: Critical]
This isn't a bug introduced by this patch, but does the error path in
__drm_writeback_connector_init() improperly destroy global properties?

When __drm_writeback_connector_init() fails, it jumps to the
failed_properties label:

failed_properties:
	delete_writeback_properties(dev);
	return ret;

Then delete_writeback_properties() destroys the properties attached to the
device:

	if (dev->mode_config.writeback_pixel_formats_property) {
		drm_property_destroy(dev, dev->mode_config.writeback_pixel_formats_proper=
ty);
		dev->mode_config.writeback_pixel_formats_property =3D NULL;
	}

If a driver attempts to initialize a second writeback connector and it fail=
s,
won't this unconditionally free the global property objects that are still
attached to the first successfully initialized connector, causing a
use-after-free when those dangling pointers are later accessed?

> =20
>  /**
> - * drm_writeback_connector_init_with_encoder - Initialize a writeback co=
nnector with
> + * drm_writeback_connector_init - Initialize a writeback connector with
>   * a custom encoder

[ ... ]

> @@ -263,11 +263,11 @@ static int __drm_writeback_connector_init(struct dr=
m_device *dev,
>   *
>   * Returns: 0 on success, or a negative error code
>   */
> -int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> -					      struct drm_writeback_connector *wb_connector,
> -					      struct drm_encoder *enc,
> -					      const struct drm_connector_funcs *con_funcs,
> -					      const u32 *formats, int n_formats)
> +int drm_writeback_connector_init(struct drm_device *dev,
> +				 struct drm_writeback_connector *wb_connector,
> +				 const struct drm_connector_funcs *con_funcs,
> +				 struct drm_encoder *enc,
> +				 const u32 *formats, int n_formats)

[Severity: Low]
Since the parameter order of con_funcs and enc has been swapped in the
signature, does the kernel-doc comment above this function need to be
updated?

The kernel-doc still lists @enc before @con_funcs, which creates a mismatch
between the documentation and the new function signature.

>  {
>  	struct drm_connector *connector =3D &wb_connector->base;
>  	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D9
