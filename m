Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0A8CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:29:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110E210EFA7;
	Tue, 29 Sep 2026 16:29:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b/kKIIdb";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE1C10EFA7
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 16:29:54 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2af3701927so666204566b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790699393; x=1791304193;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=benznCTRx/IEcE/MVflwkxYVhHzqfo0H2S1mbmL87+g=;
 b=b/kKIIdbLk2GrcA7aYuB054RU6in8UfDTd6pmG8nyAztNKgBmz0l9ZcamR2FtFOwqw
 aqBr6HR4ckMI9P0GEBdeGMDPX8+vvHYfQtqKxzRBm/LLAYLAHZkWkcp4xSecLbwmyfPv
 cD/VOngYfcx5LBoPNzNhiOCtzwmOoHQyNfEbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699393; x=1791304193;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=benznCTRx/IEcE/MVflwkxYVhHzqfo0H2S1mbmL87+g=;
 b=a/7iGs191zDMmiyCJYMoV5B31vwibNr5HP7QKpkfsl5y9r2nP6k+gOGTuEd+vSYW2P
 KIGA0CN+uDvB8sC4ASzy8Q9J7JvUjw4Br2xOXgUqPZbyd40ZAZKLXjVAmRIGWdCFnYnR
 gJPtcyO/FsZh3wENrbsFsjN9GISc+/Y88ivDhp8g2OgLt68K951k7v0lbLq7bqjp0/zU
 piG/Pn/yYdSPAWXwd38tuyY+b3bSusvwyl7y52UMjd5xYECKd6rG3EBoooUTL5gSqNXh
 BeoIMNyFK9ld5Li1Jop2zG3T3yfSHdMB2ZoG/9udB8oztBxbD7AQmGOYjcSkqxK6iznq
 hL8Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByq1fH3pYG1pgApKv2qIaeJDJQ78PH8haB6Y36lUraQAFsbnhqAmcDm/nTJ/kImp31HFO0ptrZLA5E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lUJIBrxbGC/tq7egp2FDGUbwV8gzG19E9GhZ8xjv4x6Ig9hkUA
 A3AyxgZFP6+e0nDickigwWBrm/Ew7p68pCb4r+cGObzX9O8fAdl2w/jKA8LrN3/ffwQO4Q6M6Zx
 SLBi9SnER
X-Gm-Gg: AYBFou3Hh2AyOmFgDTol93LGKfRlQ5gy9HwaL+mpGgJrabBu4wFl6Bswu3D5uyVr5nL
 OXgKMU/bwnstfyBgJIbuKNrfkv6QjGX9/GPZCpWZv/Vz7XF/tZld8oUBb2ZctPhI8tHd/Ajh13j
 +gKOoCCQuTITaA/+LlqPIaHkrz5TuLuDzflZJDeEeQkKw7K1Wo+C89j7AZz3gqICNcFr0Nz2wfb
 EpcO9P/emxzOYNGZTdVZ3TsKv+qClh8NCKOd8wlWvgOuiXW3GQsPGBrbCEpgDnq8HnlQQIS+Dfk
 TE44Ylx87TiW7aF5F/U2I3NKTDWIGbbVANPTogKJV6AgxkFnnGvCqq8NuyiwVh4f4VHiLF6LdwI
 7qaxQAnsn4FAnx1LcnscqdDIaKePE2B89MCe3Mqf5EduUsOjq0kb/SRVid+PWbIeK6kxwfmG6y9
 CzLyeRBpALxITxf9dWdEofA/8DnQi47dES4VtqlwNWdWHCsQbN1lTnXon0HQALa5w1TV/m/TMeM
 KjARbf7bhEOVc/tnKZGtGLdvDVeVxeLCwNkfaAz33fXRqPWEA==
X-Received: by 2002:a17:906:d54b:b0:c2d:df42:753b with SMTP id
 a640c23a62f3a-c2e1589535dmr4714266b.29.1790699392891; 
 Tue, 29 Sep 2026 09:29:52 -0700 (PDT)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com.
 [74.125.225.141]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e1352e84csm4727266b.58.2026.09.29.09.29.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 09:29:50 -0700 (PDT)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so24328735e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwDvQ3eLafOVfHaiJznCEwMaF2aAOgND2iCueTE2Jey/NH9qVTtrPu/s99epqFtSlg0ZmlnGYtx+/M=@lists.freedesktop.org
X-Received: by 2002:a05:600c:1f95:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-49fe66f1aa8mr296606315e9.19.1790699389340; Tue, 29 Sep 2026
 09:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260929080143.559685-1-hungen3108@gmail.com>
In-Reply-To: <20260929080143.559685-1-hungen3108@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 29 Sep 2026 09:29:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UU+NS0T-Ga8i12QKTNCYOu8kar_6=NsH0=4FVUFyKB7A@mail.gmail.com>
X-Gm-Features: AclHuK_CMHHACYWLbkCTUj8Wg_n6T0qMeI89YsR3gxxruJZion0bIfNfLPongVU
Message-ID: <CAD=FV=UU+NS0T-Ga8i12QKTNCYOu8kar_6=NsH0=4FVUFyKB7A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi()
 functions
To: Hsieh Hung-En <hungen3108@gmail.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch
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

Hi,

On Tue, Sep 29, 2026 at 1:02=E2=80=AFAM Hsieh Hung-En <hungen3108@gmail.com=
> wrote:
>
> Replace the deprecated mipi_dsi_dcs_exit_sleep_mode() and
> mipi_dsi_dcs_enter_sleep_mode() calls in the enable and disable callbacks
> with their _multi variants, as suggested in Documentation/gpu/todo.rst.
>
> The callbacks retain the same return values. The new helpers additionally
> log an error if the command fails.
>
> Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
> ---
>
> Notes:
>     Compile-tested on arm64 with W=3D1; not tested on hardware.
>
>  drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

_multi doesn't buy us much here, but this is still something we want
to do so we can (eventually) remove the old functions. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll be at a conference next week and will probably wait until I get
back before applying, just in case there are problems. So unless
someone else applies in the meantime (or other issues come up), I'll
try to land in ~2 weeks.


> diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/d=
rm/panel/panel-ronbo-rb070d30.c
> index c3fbc459c..ebe6352db 100644
> --- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> +++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
> @@ -75,15 +75,19 @@ static int rb070d30_panel_unprepare(struct drm_panel =
*panel)
>  static int rb070d30_panel_enable(struct drm_panel *panel)
>  {
>         struct rb070d30_panel *ctx =3D panel_to_rb070d30_panel(panel);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
>
> -       return mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +       return dsi_ctx.accum_err;
>  }
>
>  static int rb070d30_panel_disable(struct drm_panel *panel)
>  {
>         struct rb070d30_panel *ctx =3D panel_to_rb070d30_panel(panel);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi };
>
> -       return mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       return dsi_ctx.accum_err;
>  }

nit: not new for your change, but it's probably better if
rb070d30_panel_disable() ignores the error here and always returns 0.
We often ignore errors in disable(), especially when unprepare() will
power the panel off anyway. If you wanted to send a followup patch
fixing that, it would be nice. ;-)

-Doug
