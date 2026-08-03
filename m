Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8826BC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774B510E5CF;
	Mon,  3 Aug 2026 16:35:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TLMm4TsS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22E910E5CF
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:35:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D7684325D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5A1F00A3E
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785774955;
 bh=FzYIensEehg4AqZ63zYidEpWKUCxiiUHEFuqj6KSwoQ=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=TLMm4TsSV3ywjoKPjQMCMskB5/3cN3u0ES2TuqR9lzQ40DCL4ct7oq+MAdRFTJIwb
 CixM+flP07q0hi1TOAcGGEf21lE2ImOvNUjHGgBJQ7F8JIV4mn3n5BWhDX9WQ0aElA
 ntjXgLqkub+fuDwJviyi4WJwonjbf1QFB0IWqi7NK74JFtQVGz0U/l0TUuTsZSUUKw
 J8pSXB4xID4reTlQfLYno68AtS0M8mfz20uDBQhJnJblL/QrdBgpqt3XhVIpzKZtWu
 LOe9wE1hZTluV7lXQ40sbhrDV8bQrUtaL1IyRcDFE2156SrQOM6+QG26ig6nThTcZV
 q3x9VoHsQUHUg==
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39c95395230so35125031fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:35:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoAehQSinHY4+H1uBdU83uMkZwgQu2YWIU+jAZnLWfY37gamqrwiK+S6NTrW2IjhA1uz7iPBJCLfF0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGIuPuHRGhURWxtxA2vpNS3w3jPhabimH0WoX/Zjl3TbzJ2MCm
 G5z4ea7+S4AUs2h4aJ5+KQY7GJVn8s7TIsKIApAPMdyvrf7LFHC6uJSUvgeVZ2t2k0aZKkYY52F
 Srqj0QXSUjHNPHSZWDi1xG2A6TAS+lFg=
X-Received: by 2002:a05:651c:a348:b0:39f:7feb:a07 with SMTP id
 38308e7fff4ca-39f863fde4cmr19415821fa.24.1785774953645; Mon, 03 Aug 2026
 09:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <c48ba85b9e4478d51afde4f36839fd1c1d363b23.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <c48ba85b9e4478d51afde4f36839fd1c1d363b23.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 00:35:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v67S+ZzKKg8uuMa2hwOV5Sd62vKCwUFFgZY6j5yAy6adfQ@mail.gmail.com>
X-Gm-Features: AUfX_mzh5MHTOP_BoCG6ZOvMRIrsBiiV2OmKYqiAQb1qTkbYX3vB0mzChVE8uZA
Message-ID: <CAGb2v67S+ZzKKg8uuMa2hwOV5Sd62vKCwUFFgZY6j5yAy6adfQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] drm/sun4i: vi scaler: Restore opaque alpha in video
 modes
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> The DE3 mixer initialization clears the entire mixer register space. This
> also clears VSU_GLOBAL_ALPHA, despite its hardware reset value being 0xff=
.
>
> The VI scaler uses Video Normal mode for subsampled YUV formats. In this
> mode, VSU_GLOBAL_ALPHA provides the scaler output alpha. Leaving the
> register at zero causes the scaler to produce fully transparent output.
>
> Set VSU_GLOBAL_ALPHA to 0xff whenever configuring a DE3 or newer VI
> scaler. The register is ignored in UI scaling mode.
>
> Fixes: c50519e6db4d ("drm/sun4i: Add basic support for DE3")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.c | 2 ++
>  drivers/gpu/drm/sun4i/sun8i_vi_scaler.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.c
> index d4412a62c2f0..a5cc99981006 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.c
> @@ -975,6 +975,8 @@ void sun8i_vi_scaler_setup(struct sun8i_layer *layer,
>
>                 regmap_write(layer->regs,
>                              SUN50I_SCALER_VSU_SCALE_MODE(base), val);
> +               regmap_write(layer->regs,
> +                            SUN50I_SCALER_VSU_GLB_ALPHA(base), 0xff);
>         }
>
>         regmap_write(layer->regs,
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h b/drivers/gpu/drm/su=
n4i/sun8i_vi_scaler.h
> index 245fe2f431c3..d89c0cbe188d 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_scaler.h
> @@ -36,6 +36,7 @@
>  #define SUN50I_SCALER_VSU_EDSCL_CTRL(base)             ((base) + 0x28)
>  #define SUN50I_SCALER_VSU_ANGLE_THR(base)              ((base) + 0x2c)
>  #define SUN8I_SCALER_VSU_OUTSIZE(base)         ((base) + 0x40)
> +#define SUN50I_SCALER_VSU_GLB_ALPHA(base)      ((base) + 0x44)
>  #define SUN8I_SCALER_VSU_YINSIZE(base)         ((base) + 0x80)
>  #define SUN8I_SCALER_VSU_YHSTEP(base)          ((base) + 0x88)
>  #define SUN8I_SCALER_VSU_YVSTEP(base)          ((base) + 0x8c)
> --
> 2.43.0
>
