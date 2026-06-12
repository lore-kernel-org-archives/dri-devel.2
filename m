Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DBCD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA9A10F67D;
	Fri, 12 Jun 2026 18:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n2efuH84";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0F810F666
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:39:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4152A407EF;
 Fri, 12 Jun 2026 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4EE1F000E9;
 Fri, 12 Jun 2026 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781289586;
 bh=ZArZBaKKFiZlPiUp+LHSS2hiX1yWfDWAC9LuhEn735o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n2efuH84u3UqaYAE1B2+lTueGuKPUUBQa2rL+rug5AkqO8BsYuv8o0wxX4XKa+SpM
 bW4+v3mTtECr+fquN/Fy5LU7+4JVaOcpWCy1uChaZO/QcPVzIzVGtFmp/T95zuu/G0
 TumGUDvXfqn9UGuunfSlyzUOZV1ciMlwYV6u6OLg155lgapLOrXH2+jMTOFLwo6FNk
 0WfERXci8Aj4uWIXYF+Z7x6TUI6A0BYzWVAlc7ZkHmHwA+1RjetLgjtl+SREFlzn1H
 L3s+zh5aVnPxylnI/0AkLdmVC5WiHZBXL5beNQfDnvVeuwHrCXqTGk3EenRvrSBjoi
 9w45Irh5VmnQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] drm/komeda: use drmm_writeback_connector_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-wb-drop-encoder-v6-4-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-4-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:39:45 +0000
Message-Id: <20260612183945.EA4EE1F000E9@smtp.kernel.org>
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
- [High] Calling kfree() on a pointer allocated by drmm_kzalloc() will caus=
e a kernel panic or slab corruption.
- [Medium] The dynamically allocated `formats` array is leaked if `drmm_pla=
in_encoder_alloc()` fails.
--

commit 05d31d945f92ca6cf7a26ad265d8715c134b9631
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/komeda: use drmm_writeback_connector_init()

This commit converts the writeback connector and its encoder initialization
to use DRM managed equivalents.

> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c

[ ... ]

> @@ -143,13 +137,15 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
>  	struct komeda_wb_connector *kwb_conn;
>  	struct drm_writeback_connector *wb_conn;
>  	struct drm_display_info *info;
> +	struct drm_encoder *encoder;
> +
>  	u32 *formats, n_formats =3D 0;
>  	int err;
> =20
>  	if (!kcrtc->master->wb_layer)
>  		return 0;
> =20
> -	kwb_conn =3D kzalloc_obj(*kwb_conn);
> +	kwb_conn =3D drmm_kzalloc(&kms->base, sizeof(*kwb_conn), GFP_KERNEL);
>  	if (!kwb_conn)
>  		return -ENOMEM;
> =20
> @@ -165,11 +161,19 @@ static int komeda_wb_connector_add(struct komeda_km=
s_dev *kms,
>  		return -ENOMEM;
>  	}

[Severity: High]
Does this error path in komeda_wb_connector_add() call kfree() on a DRM
managed allocation?

The kwb_conn pointer is now allocated via drmm_kzalloc(), which manages
memory via the DRM device lifecycle and returns a pointer pointing inside a
slab object (after the drmres tracking header).

The error path just above this context shows:

	if (!formats) {
		kfree(kwb_conn);
		return -ENOMEM;
	}

Calling kfree() on this managed pointer will pass an offset pointer to the
slab allocator, which can result in an invalid free that triggers a kernel
panic. DRM-managed memory must not be manually freed with kfree().

> -	err =3D drm_writeback_connector_init(&kms->base, wb_conn,
> -					   &komeda_wb_connector_funcs,
> -					   &komeda_wb_encoder_helper_funcs,
> -					   formats, n_formats,
> -					   BIT(drm_crtc_index(&kcrtc->base)));
> +	encoder =3D drmm_plain_encoder_alloc(&kms->base, NULL,
> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (IS_ERR(encoder))
> +		return PTR_ERR(encoder);

[Severity: Medium]
Does this error path leak the formats array in komeda_wb_connector_add()?

The formats array was dynamically allocated earlier, but returning directly
here skips calling komeda_put_fourcc_list(formats), leaking the memory.

> +
> +	drm_encoder_helper_add(encoder, &komeda_wb_encoder_helper_funcs);
> +
> +	encoder->possible_crtcs =3D drm_crtc_mask(&kcrtc->base);
> +
> +	err =3D drmm_writeback_connector_init(&kms->base, wb_conn,
> +					    &komeda_wb_connector_funcs,
> +					    encoder,
> +					    formats, n_formats);
>  	komeda_put_fourcc_list(formats);
>  	if (err) {
>  		kfree(kwb_conn);

[Severity: High]
Can this kfree() corrupt memory in komeda_wb_connector_add()?

Similar to the previous error path, kwb_conn is now allocated with
drmm_kzalloc(), and manually calling kfree() on a DRM managed pointer
can lead to a kernel panic.

>  		return err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D4
