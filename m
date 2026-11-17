Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEA606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uVV/Y3Ow
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B92D10F53D;
	Tue, 17 Nov 2026 16:35:49 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D4910F626
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:35:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso581185e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794933342; x=1795538142; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XOOROMKIPXr3CQSNIxjA9uq5C/f3wnb7r92RzJgi0oU=;
 b=uVV/Y3OwmsI5C/LweBhA6/s94lowqznfolphA8KDzedwrcwWp7cMNrvdjKrESbiXjC
 XHZgf4hde0xvi/3HPCC4uHXn0v9wnvfyGMDMuw+PUvy2XS51aaeT3duzjrc2w91LiiqG
 IeMjZatHHf7GNPO0obNDM3l/VW66XcqwIhFA59hNi/B+Hl8KTDXBzUUH+GcUbiE5Kaa5
 msjqX+77oRh3PVahO1DmrQt3Ln6f+IejnGt5+2HsV8gND58yDhUYLZGz/cUKfDT3J+kf
 kCU/sthvxit0r8wy/sN0yCTAuDbAnWaisidACzHBz7VzZrHqcfcuucOed4rc7yWD8fvb
 ukQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794933342; x=1795538142;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOOROMKIPXr3CQSNIxjA9uq5C/f3wnb7r92RzJgi0oU=;
 b=0KiwHN8OPUIza5bagyu9QSGesyyxLoIF20KoDjmqnAAFaBV1zd+D/jmoIl1rUMWFVI
 0270lw3BrczxA6mGWSBnKPZdV5513xCwXdFtb4zaO9aGdRlmY0j7/JbnQuSt/0yAVU1o
 BgCfhlLT2Kg213YeK7tBPmvto2ovsnH7OIwVwFK9UG7+BOCqX3UxSxxqbdhqXkBb+n4e
 H7u8z+AjvzdIK3JksjjUAOlsoKBz7C+TE/heJs0PqdzF8oU7/503/SQOZJ/FybRt9Os8
 VFr6lGVBvXNjt4SpNnNjX4HGghsdwg4Sw9vCCus09ylVg1HVcyvkzmRNXjUWWKbdZGQW
 HbAA==
X-Forwarded-Encrypted: i=1;
 AL+hErGXU+RNinggj015llYUn1kdmR5ZUC5KQPlHjKfBVhLwuL2Dqxp4BPmDqOj1ZGXUed2hQQgnkwY6STk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9MVMieJ8T5oZJV3qJnubUxXLJJqOOcvRmsfrk+viJMABOvBUHI
 52SUFip6z3i/OqDujpynckRwN9Z8Y4thIPZ1RBZLGmfL4sk9YezGdCbf
X-Gm-Gg: AYBFou0a1VxEvS4HoWDcm0xZSEaEtqIkpHm8pK0X0xGO73K3XOz+31/EDXm9WzQpIRE
 JmnTa0gDLWKZdQotJICgUyF++nf99bpZN9wA9SlvrCYgTFN9wd1Q8BYLtPbBjJb9rdxKjgBhpaV
 r23zwAXUrTqjRpelIFMJTJ9FL03F1UN9Z2I86oCJHzAdwXoRaCK8Lw3VJb+nzL5XH83CmuXGCmT
 P41tYuZQd3EzlxOM4+1QAaVBoZGJU3H38UqFwThulJMl2WMpdVnj+8qCzXPhPzrpK5CkM/+NdsN
 bP+CWl3TpsuCvg3S3Z9pWTccs4EoZ+TSXSnlk2H/h0V1ktHDFCQLiKOHvojrbro4LZ2sHxKtHP+
 wg9yGNB+l40FyYfajv51TFcRjuXWRzX8LeCJebW1AipVZ20YYM8FxQLLbqMuNGZvXSOX5EGVLl/
 J/xlmf6EhUtLW3lxFqmUTsAJ5YgSObB2CmvefLPr/85a9FNK6kDen5KOdjWXvtPGgBGlGLiG022
 5bv/cPYSdb39ydMwhBC5M6y1STf6Cra56KWt/HRCwljZDbcUyWZWd6mKG98sp44CDdjjsYv6EJN
 nliRUTwPN+gsr52VD7Zly0cp/ny6H6Pm5rE3nnDFXU+8ZG7sr/hWb+hyBtDM0MNpTWJZ6t4DMpW
 JjxPPqOkEt0Gw/DdTg0woiOFImYQqntD99U7W60XzbgHAGbpBT7PwNby3tIu3Y4AYuZJW18TlNn
 DOhuRYXsn3alQg0GyNZpVV/STeUswmJNa6pYHQAKydSosOjhn4mpRKHLkNpZn3ddNkgTb3MTg61
 agPy7eoWXw94qStJbLibN8goUv+V/Rp5ykI7PAGufL2uvGem+zSEG3h/ss=
X-Received: by 2002:a05:600c:620a:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb69912526mr176343095e9.22.1794933342249; 
 Tue, 17 Nov 2026 08:35:42 -0800 (PST)
Received: from jernej-laptop.localnet (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm28919970f8f.12.2026.11.17.08.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 08:35:41 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, linux-sunxi@lists.linux.dev
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Samuel Holland <samuel@sholland.org>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yang Siyuan <hsyysy@163.com>
Subject: Re: [PATCH RESEND] drm/sun4i: report coverage pixel blending for
 alpha-capable planes
Date: Tue, 17 Nov 2026 17:35:40 +0100
Message-ID: <VyjYt3XHQ3e42-zx5UUDfg@gmail.com>
In-Reply-To: <20261117091932.12063-1-hsyysy@163.com>
References: <20261117091932.12063-1-hsyysy@163.com>
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

Dne torek, 17. november 2026 ob 10:19:32 Srednjeevropski standardni =C4=8Da=
s je Yang Siyuan napisal(a):
> Linux 7.3 added validate_blend_mode_for_alpha_formats(), which warns once
> per plane that exposes a pixel format with an alpha channel but has no
> blend mode property:
>=20
>   sun4i-drm display-engine: [drm] [PLANE:35:plane-0] pixel format with
>   alpha exposed but blend mode not setup. Please fix.
>=20
> The mixer blends a layer using its own alpha channel: ALPHA_MODE is set
> to PIXEL when plane alpha is opaque and to COMBINED otherwise, while
> BLEND_PREMULTIPLY keeps its reset value. That is straight alpha, i.e. the
> DRM "coverage" blending equation.
>=20
> Advertise exactly DRM_MODE_BLEND_COVERAGE on every layer that can expose
> an alpha format (UI always, VI on DE3 and later). This matches the
> existing register programming, keeps userspace behaviour unchanged and
> satisfies the new validation. Premultiplied blending would require
> driving BLEND_PREMULTIPLY and is left as a follow-up.

The subject says drm/sun4i, but the DE1 backend planes (sun4i_layer.c)
also expose ARGB8888/ARGB4444/ARGB1555 without a blend mode property, so
A10/A20/A31/A33 still trigger the warning. Either handle them in a separate
patch or say in the commit message that this one only covers the DE2+
mixer.

>=20
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format wi=
th alpha exposed")

This is incorrect. That patch only added general check. Drop the tag.

> Signed-off-by: Yang Siyuan <hsyysy@163.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 13 +++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 14 ++++++++++++++
>  2 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_ui_layer.c
> index 7d894e1eb..ef059ac47 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -283,6 +283,19 @@ struct sun8i_layer *sun8i_ui_layer_init_one(struct d=
rm_device *drm,
>  		return ERR_PTR(ret);
>  	}
> =20
> +	/*
> +	 * The mixer blends the layer using its own alpha channel with the
> +	 * pixels not premultiplied (BLEND_PREMULTIPLY keeps its reset value),
> +	 * which is the DRM "coverage" equation. Report it so that the blend
> +	 * mode validation in drm_mode_config_validate() is satisfied.
> +	 */

Above comment doesn't add much value.

> +	ret =3D drm_plane_create_blend_mode_property(&layer->plane,
> +						   BIT(DRM_MODE_BLEND_COVERAGE));
> +	if (ret) {
> +		dev_err(drm->dev, "Couldn't add blend mode property\n");
> +		return ERR_PTR(ret);
> +	}
> +
>  	ret =3D drm_plane_create_zpos_property(&layer->plane, index,
>  					     0, plane_cnt - 1);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 92dd5a97f..b6771576b 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -470,6 +470,20 @@ struct sun8i_layer *sun8i_vi_layer_init_one(struct d=
rm_device *drm,
>  		}
>  	}
> =20
> +	/*
> +	 * Only DE3 and later expose pixel formats with an alpha channel, and
> +	 * the mixer blends them with straight alpha (coverage), same as the UI
> +	 * layer.
> +	 */

And neither this.

Best regards,
Jernej

> +	if (layer->cfg->de_type >=3D SUN8I_MIXER_DE3) {
> +		ret =3D drm_plane_create_blend_mode_property(&layer->plane,
> +							   BIT(DRM_MODE_BLEND_COVERAGE));
> +		if (ret) {
> +			dev_err(drm->dev, "Couldn't add blend mode property\n");
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
>  	ret =3D drm_plane_create_zpos_property(&layer->plane, index,
>  					     0, plane_cnt - 1);
>  	if (ret) {
> base-commit: 091b06388b117fefdcb63336ac09956a4914b961
>=20




