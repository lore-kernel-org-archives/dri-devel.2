Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA7DC531D0
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356DC10E0CD;
	Tue, 28 Jul 2026 01:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XSggnhYE";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFD810E0CD
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:38:51 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-39c94fccf3eso29207041fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785202729; cv=none;
 d=google.com; s=arc-20260327;
 b=rael9nlE/ETIEKHC0Vb4BgBXWZ2NRKd8tXt83VejvlZ3Pu4QGwlFxF7stH9OfXGHBE
 PNjuCsmK4vmY3ZUrBuIirmIYl6QyCWRbeqJt5bWLSwcLcpmvivcjKvq8p3NY9uleJamM
 kDADZDcgsCV1cFwrrYpRC3gXO4KLPFktWgij76AW2oCPF8rJlt1S+7pY9tNVVtAPXDY7
 LBirrnrQuK/A3vpGXz0iwzXW459WVsYdRjo6FGw5VpOXUTP9z7iTmIV9EPLS0vOLbRef
 rwevWuqkQd23SuUU61jxgtKpWhCRmIRnOLUx2zeLLy6uyBaDc2qXs8NcXV0mjVJXWcsb
 xAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KVEB4mA9yxfirsU2nUy6s7dY/kNOwXXUP6cJt8kVp5s=;
 fh=6Zn7wS1+rRUlWhJFstAK1rjk4bFiQIF4X3YOdEXCt5Q=;
 b=KtRp4RNwpA5k0yOGy6S5xL2H9f7/6PnzEyO6RQsdDxGikn2colBZxZYuXzeYWVlkOy
 CO999JboEnV15AWFMb2bv8Rf6rwbxaCPunsOXw9mL/UPKnoYt68dPozbKhPeJkKn0Wl9
 fV/yWky2tPi3/v8AL/MHjNCsctbOiIaQ+7EOZe6v1ETC/i3N/OlXPwKPeAeUjy4a51ys
 RcfiPfinbwzed08F9xBORgNBfZDfq4A2r5Upha+L3OuMsWXEXXwi3CyAOCeGxxudfmH/
 hL0nwFZxQHbmpYI9okY0oGK0M96OgQkDkLWherB9OZ4iPdeCqZGA7rdApHwgLO1zaAWz
 p1Pg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785202729; x=1785807529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KVEB4mA9yxfirsU2nUy6s7dY/kNOwXXUP6cJt8kVp5s=;
 b=XSggnhYEIDry/w10qBjrqLdz2RlalhyEJRB9Auz7LhNn83rvygu1xr2KjaeQC2O+xe
 PXThbC2zQZG0t2EqzvfIEIXaTc3FRLaJ9kauWFq1QuA4prjOIfOUxiTYjD2QGkIA6nbd
 PTqqLWGTfDfdofUbQymq1gIBZugHQbnb2Pb11Qh72M3KTfKt8H3LhoYBIOiZl+LB1cIO
 JoNHcyEwTRvr6Dgu1O03bUfSHX6XAynlStpgbWncjBVG9Q8eQ3yerKl+O19bb0y212qr
 kA0aZCRDGX9jtx7KU87SnB6jx4eAhEUc+LS0dFCzZqkyhgszAG75Gi5V5WdquspxoNCJ
 T8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785202729; x=1785807529;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KVEB4mA9yxfirsU2nUy6s7dY/kNOwXXUP6cJt8kVp5s=;
 b=UA/OxJ+/MLX9gYpGs6RirlNemBdQVfIA1h3pGDcUBpbva+5oUK+CtmnAxQ0RlbtExo
 rFeZO/1jj78tapju3AXxuiswemd8lKavPTBBLrkls3OJ0cW/lPEkFLZuFvwmYmdZFueD
 PwUEUBusmG2mBRWt10FaWYX89SeRteHVtml06Bohz0OBZTNwzKMjE1Ya9big+zbZnGkN
 76MU3NvafzIrEYuuizOQyvU6BkrKKo6H316hsQS5gRFy5gn8ititlLrgMbgyDtVWsgNl
 X1v60knkll2uw5CStwrahnivUT9EI5n03l6Lsg1BbMWiqhnfzMDn88Amhg2oxQAVsnaE
 Gp3A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnJ+iT73BR1xILezVMBnaoxL+0HWSkZBvLPlXIqlOSXw0rvJXWJOYB7GvQI2o1K/EbjSvI0TjjlHo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwSuOizOAM8Nn+Ht1Ps62eBuI994Cgm3nNZXGs8+Lno5Ok3wIm
 WmXa1tP65zirK2uxKR41heLwKo3hfBa7RWK95+zqqBn4cf4mjpgTFCxxSggkEji/EzsnMrhyjim
 ITLmsYmymONrzB9HSugIzG0Zbticz84I=
X-Gm-Gg: AR+sD12le2J9OI0p5Ui1HwIyWSv3QQCW0gu2pK8KMX0fF8cbjocNd5KfsBJ0IhXEvQL
 dcqM0rYMDAcxfS4/aqyjCje3JIwIVnDOr7kcMVIQ2mUSInV9r47UzcHEg2VgZPfGARz6LL4XMrA
 psEw8hNLCAILUI9UF6HsTy16yJhULzy0BsMAuE1tn6L00uuxP+BTcCjxrK2PtU3OYDjOsyUGcwS
 j/t1ncIZ++JPbipcZ9GkheWYoj7vPJPtn+bJcgbVdUiDfF2dyWFNrd9PAwIaOQK7n0kSblX0hGw
 KqaCsVBKXVK3rNt+b/x0g4XcYu5gDiGKcEyA+pFNRJ9Wf33iPS2vS+6RwA==
X-Received: by 2002:a05:6512:3dab:b0:5b0:136c:5ccd with SMTP id
 2adb3069b0e04-5b2d0216652mr51047e87.19.1785202729119; Mon, 27 Jul 2026
 18:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com>
In-Reply-To: <20260727-ch13726a-washout-v1-1-bf869ddfc5cf@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 27 Jul 2026 20:38:36 -0500
X-Gm-Features: AUfX_mwOQqPOVoHtSqg4yF4VgRvz8WZRSdWh_pqtLt_gp35iB-kHx35lLoEV0Yc
Message-ID: <CALHNRZ_EQyP6apD-0YboXEua5Hk1u2oVMo1M7vACK6vzMRp03g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: chipwealth-ch13726a: Fix washed out colors on
 120hz mode
To: webgeek1234@gmail.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon, Jul 27, 2026 at 7:44=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Aaron Kling <webgeek1234@gmail.com>
>
> The issue was determined to be two-fold:
>
> 1. The non-continuous clock dropping into LPM during blanks causes
>    voltage drift at 120hz enough to affect the gamma curve.
>
> 2. The agressive horizontal blanking width did not allow enough settle
>    time, further compounding the voltage drift.
>
> In addition to switching to continuous clock, burst mode is also enabled
> to further stabilize the blank intervals.
>
> Assisted-by: Gemini:2.5-Pro
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> For the initial submission, the washed out colors were expected to need
> to be fixed by a color profile. However, further investigation showed
> there was a problem with the timings.
> ---
>  drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/=
gpu/drm/panel/panel-chipwealth-ch13726a.c
> index 562dc573528dd..92f0c4f1587cb 100644
> --- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> +++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
> @@ -128,11 +128,11 @@ static int ch13726a_unprepare(struct drm_panel *pan=
el)
>  static const struct drm_display_mode thor_bottom_modes[] =3D {
>         {
>                 /* 120Hz */
> -               .clock =3D (1080 + 28 + 4 + 36) * (1240 + 16 + 4 + 8) * 1=
20 / 1000,
> +               .clock =3D (1080 + 60 + 8 + 60) * (1240 + 16 + 4 + 8) * 1=
20 / 1000,
>                 .hdisplay =3D 1080,
> -               .hsync_start =3D 1080 + 28,
> -               .hsync_end =3D 1080 + 28 + 4,
> -               .htotal =3D 1080 + 28 + 4 + 36,
> +               .hsync_start =3D 1080 + 60,
> +               .hsync_end =3D 1080 + 28 + 8,
> +               .htotal =3D 1080 + 28 + 4 + 60,
>                 .vdisplay =3D 1240,
>                 .vsync_start =3D 1240 + 16,
>                 .vsync_end =3D 1240 + 16 + 4,
> @@ -281,7 +281,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi=
)
>         dsi->lanes =3D 4;
>         dsi->format =3D MIPI_DSI_FMT_RGB888;
>         dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO |
> -                         MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +                         MIPI_DSI_MODE_VIDEO_BURST;
>
>         ctx->panel.prepare_prev_first =3D true;
>
>
> ---
> base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
> change-id: 20260727-ch13726a-washout-54ef8fa65be6
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>
The sashiko report that the timings in this change are inconsistent is
correct. Which caused the 120hz mode to be discarded entirely, so the
60hz mode was being used which has correct colors. Fixing the timings
to be consistent restores the 120hz mode, but still with incorrect
colors. So this patch should be abandoned while further investigations
continue. Sorry for the churn.

Aaron
