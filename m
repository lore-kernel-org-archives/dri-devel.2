Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FECCC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C8EA10E059;
	Mon,  3 Aug 2026 17:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FTdXnF8G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B435410E06C
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BE4960A69
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70EC1F00AC4
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785776573;
 bh=1IenpiuM5JsmgqLGPzCFWXP8UT6+FeKulhYM9DPJHH0=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=FTdXnF8GFLny3L584AQMMgX2xFs2nxONoFzoXYXqVfCFkjBOgeX8Mr/iTQ9uusC3r
 Zgj3u3iA940U7/5dptUgEJR63P/Yb+TVqM0phvTk3cTLIEbBs8bljGub28r+RCUbwV
 EkLQsjUHId9GqE8Ku9EU/+GjtYNYBPmPynBYLHs6WTRfmevunezT+XRbZ3MebOQf4D
 A1opir9RT91tIzWOrZQK3fkhpuO0gNdIyUr0JBq/dYWEi3HFFM6TFM6/OwO4DVKTz3
 mLsIEks8ez6oRODt/3GYbQ7+hrOxNVzwB6uV85OQDVjhcYsXBLauovRXM7ewba5Wcz
 qmp169nCj/83Q==
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-39ee96f8047so25596031fa.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:02:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8XJq0WGTXcLnHecIiEmTloQvPfS9JjKGmhKA991ehn/7JToQc888nvrk6H6alI5L81Ut74bKL0Tg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwGCH+182nnyR569xfzmkrYImEnA9K+WGpqZr0ytEBazub1lOy
 5+W2U1f4kNZ4+Y7UV4IWW4PI4GH2g+f2vsLvxSQq+aIY+g0BqZc0GWFC45+4JvpBMY0P10AGhT0
 ycfsHx9lPly4c9vNNx6o7ihhWdswxFEg=
X-Received: by 2002:a05:651c:a110:10b0:39d:9eac:8ec with SMTP id
 38308e7fff4ca-39f863feedamr15152501fa.25.1785776572170; Mon, 03 Aug 2026
 10:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <b26a0d427d9dfae9c82e3ca90a67d24d8ece5a28.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <b26a0d427d9dfae9c82e3ca90a67d24d8ece5a28.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:02:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v66yVbzTSu6sb4ryuD-djcH+vaCtamuhtY=xnq93_ZvKog@mail.gmail.com>
X-Gm-Features: AUfX_mxnJXn_HowfQijlCXTBUd6N7zXjEPoDoAqA1n9Cl_6r3aRntgABVyXhcqU
Message-ID: <CAGb2v66yVbzTSu6sb4ryuD-djcH+vaCtamuhtY=xnq93_ZvKog@mail.gmail.com>
Subject: Re: [PATCH 08/13] drm/sun4i: crtc: Propagate layer initialization
 error
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
> sun4i_crtc_init() returns plain NULL when layer initialization fails,
> while all its other error paths return an error pointer. The only
> caller, sun4i_tcon_bind(), checks the result with IS_ERR() and happily
> continues with tcon->crtc set to NULL. sun4i_rgb_init() and
> sun4i_lvds_init() then dereference it in drm_crtc_mask(), which
> oopses.
>
> Return the error pointer instead.
>
> Fixes: dcd215801b02 ("drm/sun4i: Drop primary layer pointer from sun4i_dr=
v")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun4i_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/s=
un4i_crtc.c
> index c2f7f69baf75..3fa1f4fda0f0 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -208,7 +208,7 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device =
*drm,
>         planes =3D sunxi_engine_layers_init(drm, engine);
>         if (IS_ERR(planes)) {
>                 dev_err(drm->dev, "Couldn't create the planes\n");
> -               return NULL;
> +               return ERR_CAST(planes);
>         }
>
>         /* find primary and cursor planes for drm_crtc_init_with_planes *=
/
> --
> 2.43.0
>
>
