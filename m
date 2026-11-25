Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C60606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uxaHFpyM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 138A110FDB2;
	Wed, 25 Nov 2026 16:32:55 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B3810E956
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:32:48 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so51075075e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795624367; x=1796229167; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fjeXOElCViRQmgZvgDDdONv2Uyhg+At7B3MV4y/CS3E=;
 b=uxaHFpyM03oBI7sCK+pfw+9ShLZbwQ2ugX+XL8CVaG96uvKuT210XM3uVbtwV+0i/D
 fIppWSyimKuYT0dnfHql/u6Ytj0p/MuMbRq3FdeS325c3A0nO0Ks2a6ubKA4kXF/NMv5
 C5iwWpvFFSAsrlsOtriGLY9tDLT4CRXO1uZaQJmLRBBIqvvqiry+Gq/nTHtw9Ye5mUKz
 O5UwEgYxL63LHqIHvnLbPfpAYhw0IU+aVHU3zRHxrj0ddZpkG4p3IYrOpP5kngYKxQmq
 uEve6vKJDDTjBwtY1CD/c7m98QJ3WyR+mdXczIiATInPCpEDDR5xjLmdVCtkqv/rJjKt
 WzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624367; x=1796229167;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fjeXOElCViRQmgZvgDDdONv2Uyhg+At7B3MV4y/CS3E=;
 b=WXtQzb07PaOYdgUvIlrWCAkT1edN3F3ho3Lu+aDJm8xMxTr+drkvQmV639z8IJSft0
 CQBy/ku3ofEGBCAQi931RGNfGN4za+BeU0P24+RB1d/mkXZSrGuikgRIctJFLkPzTrOM
 +9vNTV9kGeYrXs3s3oN2uglFl8EFRD30kXPD0OsDqFPbfEP3b+dD58a4olTnnyx3p4g5
 En9cPJoJJRp/redyfe7miTl0JwlNNk6EGufjEuX4dfQZtjbyYVRtINJZX0YBUTYvrAwW
 K7rGd2IsfCaYxFuGb1fKkH8xFPb/X1MbSMiF8WUM3xPlxwoMeOPgf5OsKH3vW4GSCCHc
 MKMA==
X-Forwarded-Encrypted: i=1;
 AL+hErGiH9cbScYki/630bm36u0yIAg6RjQl1Z9henB5I5NA/tGNc+hicnvTkhfBgckhzSJsd/0vphUJJEE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Z0515jBa/qhlmU7w6RlO7N0/jkdrIBncnsyn1f9kjOONiagVl
 zxw5xKSf9kHkckOeJ5x2s3LW0Y5H/mzF5pRtUGD3hp5smlk3/1UDkPbO
X-Gm-Gg: AZFdTZdwXlTuFNxirBFUEMo0U5NAuixvbKj8qnK8UMtwcw8ax7nHIig29fsCKGpB6QI
 KHzM0d8sQFPceWcbsqgZ3KbPGGD+s84xMG1Llnp17scSU0MJukKiEw91f0whDlv9p3Za0Ijh7vf
 8JzIeo7+0TMbAurJOVb3VEGdNmtv/scXDmEhPC7yfCJJuF2md7b9Mrqm3lPUduot3UVovsJW2Mv
 4tO5dlBMAKuFc4WMtUZgJG8QMpOFBVQxswpkbsYTvab+/ggRcRKuvn7l1V/9muZBo/wTZLhnzPj
 y+/46WMEMeVSzIAuA+zLYTc4eDsAVfJ+QoUZ7JMi1ZBSIa0iOPsNgLJ/i5E5c3Vt4ElisePAiEA
 in2XZ7HBwIVPH9ITxGBwRVq4EjSrd3/7XQJ3M8FjmGuPPATZAhf6srDacf34Ci3h90uCjTmT6G0
 yedef9MLK7oZhDReMxupUBGYPVpu/AcbfQJEKJWb3SIbd7AiA49L9syZwjqfdGHh16ic/elxBoZ
 btNXr7I7Ak5wPVw7nSyXkvBCS5sTuL8NlkpOo0mUzATGPzK+HBS8mYtRAuhqjevjuI/Gj57mKna
 F/4zj2UujoPDHee3MJkzepRr+xUVSETGCuEDmjySfq/0g0aNO2ySTstG7xxZapQXNsMk5OAKPRa
 pb1Cd2fUZGG6gvs2Caqh2iFyXsRWJ6898XGXkvaOKE5nMBDtq0ZgLVbd+6YKwvLEYn2w29TShEy
 GUtk6+dIaezTCitioFEdBy+QtepKwYmpNTVg+O5znMAgYbUY/+MZj31uas1GW3WFtmnp0CHbPiz
 FBVUw9RpUynT8QwQJncZw85uc3QJe+5BXQJhysFYrx9wqm+YyD0ziZvx8KLNkPsTvzaOifPdreb
 zHfFd+nT
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id
 5b1f17b1804b1-4bb8881b9d7mr381679255e9.19.1795624366963; 
 Wed, 25 Nov 2026 08:32:46 -0800 (PST)
Received: from jernej-laptop.localnet (77-38-7-250.dynamic.telemach.net.
 [77.38.7.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm560493135e9.8.2026.11.25.08.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:32:46 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Chen-Yu Tsai <wenst@chromium.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-sunxi@lists.linux.dev,
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH RFT v3 3/5] drm/sun4i: layers: Fix VI buffer address for
 clipped offsets
Date: Wed, 25 Nov 2026 17:32:45 +0100
Message-ID: <sBipOLw6T_aZ1e-H2zFl3g@gmail.com>
In-Reply-To: <20261124074041.115251-4-wenst@chromium.org>
References: <20261124074041.115251-1-wenst@chromium.org>
 <20261124074041.115251-4-wenst@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dne torek, 24. november 2026 ob 08:39:31 Srednjeevropski standardni =C4=8Da=
s je Chen-Yu Tsai napisal(a):
> Commit 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to
> get display memory") dropped the code to calculate the framebuffer's DMA
> address in favor of drm_fb_dma_get_gem_addr().
>=20
> This turned out to be wrong in a couple ways. The hardware is programmed
> with clipped dimensions, so it needs the buffer address to start at the
> clipped boundary. Moving to the helper negated the clipping. Also, when
> clipping on the left, the buffer address needs to start at the first
> pixel in the sub-sampling group even for the luma plane. The hardware
> handles the interpolation internally.
>=20
> Switch to the new drm_fb_dma_get_gem_clipped_addr(), which provides the
> buffer address starting at the clipped boundary. Calculate the intra-group
> offset and adjust the luma plane buffer address so that it points to the
> start of the sub-sampling group.
>=20
> Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to=
 get display memory")
> Cc: <stable@vger.kernel.org> # v7.1+, needs drm_fb_dma_get_gem_clipped_ad=
dr()
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> This is an alternative to Jernej's original revert:
> https://lore.kernel.org/all/3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785=
772659.git.jernej.skrabec@gmail.com/
> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c |  2 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index f9c7f28f9fa2..67cce1b0e70f 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -130,7 +130,7 @@ static void sun8i_ui_layer_update_buffer(struct sun8i=
_layer *layer,
>  	ch_base =3D sun8i_channel_base(layer);
> =20
>  	/* Get the start of the displayed memory */
> -	dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, 0);
> +	dma_addr =3D drm_fb_dma_get_gem_clipped_addr(fb, state, 0);
> =20
>  	/* Set the line width */
>  	DRM_DEBUG_DRIVER("Layer line width: %d bytes\n", fb->pitches[0]);
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 4d3fc03f9877..b6796416d550 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -205,7 +205,21 @@ static void sun8i_vi_layer_update_buffer(struct sun8=
i_layer *layer,
> =20
>  	for (i =3D 0; i < format->num_planes; i++) {
>  		/* Get the start of the displayed memory */
> -		dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
> +		dma_addr =3D drm_fb_dma_get_gem_clipped_addr(fb, state, i);
> +
> +		/*
> +		 * The mixer can handle odd offsets into sub-sampled YUV
> +		 * planes, but needs the address of the first pixel in each
> +		 * sub-sampled block. Adjust the luma buffer address backwards.
> +		 */
> +		if (i =3D=3D 0) {
> +			u32 x_diff, y_diff;
> +
> +			x_diff =3D (state->src.x1 >> 16) & (format->hsub - 1);
> +			y_diff =3D (state->src.y1 >> 16) & (format->vsub - 1);
> +			dma_addr -=3D y_diff * fb->pitches[i];
> +			dma_addr -=3D x_diff * format->cpp[i];
> +		}


This could be done differently.

Before for loop (done only once):
src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);

Inside for loop:
gem =3D drm_fb_dma_get_gem_obj(fb, i);
dma_addr =3D gem->dma_addr + drm_framebuffer_get_block_offset(fb, i, src_x,=
 src_y);

But it works in any case, so:
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> =20
>  		/* Set the line width */
>  		DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
>=20




