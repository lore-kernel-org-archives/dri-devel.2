Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F210C55196
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 19:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7904893ED;
	Mon,  3 Aug 2026 19:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d5iHLn7w";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B91E893ED
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 19:50:27 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-51c1372f84dso21830451cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785786626; x=1786391426;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vi+Ec0BYQ+7t+lU4qYjrIT9EenAj7FU6achVuOQCI30=;
 b=d5iHLn7wWDt8FfGDq8jeNmGqirU9FWmGQGyIiGu5W7Tdu74zUR+xFwuEbwh3Iq2yJr
 AWpJdD1nuPCKcRm+tMZ3ks4DIjUGU0IO3C38CvMEZ0NtinKMh4/4IWRzHa9bh7S0sS4/
 tolcYEqespY7kAkNSud3O7l3cDjrmqQ8sJX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785786626; x=1786391426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vi+Ec0BYQ+7t+lU4qYjrIT9EenAj7FU6achVuOQCI30=;
 b=tZa7H7zDI9lpeOJIQG/Ul7jRfH/lsFQu1ChRF8B/JEIbwz8uC9KQmnqHn0nmP/Y61C
 Tx9hoUaz/c/PLOD/614Hn+JYuc7OIgRPJy5cvyY+ihRywcgzH3dxL997KH/cveomjtvM
 NAWtWccDZY1sloWi4vq08o3QPfIaAiUTvn11hGfxDYdyrf3nrNAJ1mTIf7+S+CgYkBJ0
 LiIeYDM+/5DcTItoG4Gh6ZgzRwU1EHelDL4JyPUBvebyvRUMaY86eybMi6LTux+Uuxo+
 czE2umwQuu3ijspalU0WXQjgH569O15lhIwik4HF3fWIL+h3D7TDr97WVF/VZq/TnzEC
 2c1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptc9KX/vH0VGOWN819rd6cSjHfoILLgPVmRukHnMxJCg5e3301UnNBLT1WJAdJVaHrviSgWTDnaNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1vvZv+/mgfGFe1I11ujor1spRGgOSoOa+RIitzn/wxLFE4A/d
 rGQhQjOtDxzLtjVnfDu/WwaXeyU63gxY5iRVoADiSkwFKDhFUXXOQIeumWxc116EOb2e7y7ggrO
 55qc=
X-Gm-Gg: AR+sD10kmU0Is9Nbv88/yIbKeoaHfn3/8+5HwelBpGHtrOetXQwpbCr4Qb/0GRwQARr
 R31VrbC9x9kqsv0kD4hrDe3d8qlAZT9CwGj/pC2BqyUjNo5T4hEwINwA/mLB7JqMmxKSUbtWz2n
 lpgQb17klUjXqkhNjiood9joB4UtemdGuxFBqx4951E7U2/z35uYq5hUO/ca/ch0hp3bFVhe64w
 NUspL+osaOVR7qLdu5I/7hD6ujPwggdXwqk5ou3rNOvqjUs668IKMW6SDOu3CUaJqlWWKke/YUv
 HGbS/6kMps5GvDTiPNXCVM3HYG/P+9DX2a0F475rcSYCiZzJBc4cf89sN/flf9zDXmVVFaEUfDz
 CxZy6YO4DvEso2e3i54Fpa5p/8qJStEkC5rRtB6XJ1EizVmzhYi8yUqUDeCzLNWFIFo6xq+C+HA
 8JEw60mMWYJeaXFGpYb3BGQXfDluTV4oxZ1FpusVmghq/LSAeirAZHc7q0gGqsfCGedQxCJO9Nj
 MFCIMxsRFszj3YwYdo/X0iZCw0=
X-Received: by 2002:a05:622a:4cce:b0:51b:efbb:fbf with SMTP id
 d75a77b69052e-52b566b52e9mr254127531cf.18.1785786626121; 
 Mon, 03 Aug 2026 12:50:26 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com.
 [209.85.219.41]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52cd3f9bf89sm3684001cf.27.2026.08.03.12.50.24
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 12:50:24 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-8f1a8e914a9so28921236d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 12:50:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqYbxn/t7ZLfIYHdCC2dAXIh0sjhsTnOVe0TOw2wA8dDWO35NKSRedYPoN4fudLcYE6LqGP/rlky/E=@lists.freedesktop.org
X-Received: by 2002:a0c:f40d:0:b0:8e3:fa57:ecb4 with SMTP id
 6a1803df08f44-90849611bddmr265017806d6.16.1785786622718; Mon, 03 Aug 2026
 12:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-edp-v1-1-3e92dec1d56c@chromium.org>
In-Reply-To: <20260803-edp-v1-1-3e92dec1d56c@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 3 Aug 2026 12:50:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XeW806uSg5JM95qHrfKUKXpC_z9BUaDv61wu0KGFry5A@mail.gmail.com>
X-Gm-Features: AUfX_myZ3LMWfAhHTfQu-xqOf9fJ2BKoPdJKDaRz-IurZ8-adLWeA-WbUmIuJKM
Message-ID: <CAD=FV=XeW806uSg5JM95qHrfKUKXpC_z9BUaDv61wu0KGFry5A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add pre_unprepare delay
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>, 
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

Hi,

On Mon, Aug 3, 2026 at 2:47=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> In eDP power-off timing specifications, T10 defines the minimum delay
> required between the end of valid video data from the source and panel
> power-down (main VDD off).
>
> Currently, panel-edp only supports the 'disable' delay, which corresponds
> to T9 (backlight off to end of video data) and runs in panel_edp_disable(=
)
> while video data is still active. For panels that require a delay after
> video data has stopped before cutting power, this delay must occur in
> panel_edp_unprepare() before turning off power rails.
>
> Add a 'pre_unprepare' field to struct panel_delay to model T10-min, and
> delay for this duration in panel_edp_unprepare() before calling
> pm_runtime_put_sync_suspend().
>
> Additionally, adjust the timing entry for TM156VDXP25 to use
> delay_200_500_e80_pu100 (enable =3D 80ms, pre_unprepare =3D 100ms) to mat=
ch
> its panel specification, replacing the previous delay_200_500_e50_d100.
>
> Fixes: b9e2d5cdaab0 ("drm/panel-edp: Support NV140FHM-N5B and TM156VDXP25=
")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Change-Id: I3361bdf4d3289c773f0c2b77163e427b774797d5
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 98bdcf352701..f6624191f97c 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -144,6 +144,16 @@ struct panel_delay {
>          */
>         unsigned int disable;
>
> +       /**
> +        * @pre_unprepare: Time for the end of video data to power off.
> +        *
> +        * The time (in milliseconds) that it needs to have passed betwee=
n
> +        * the end of valid video data from source and start powering off=
.
> +        *
> +        * This is T10-min on eDP timing diagrams. It is not common to se=
t.
> +        */
> +       unsigned int pre_unprepare;
> +
>         /**
>          * @unprepare: Time to power down completely.
>          *
> @@ -413,8 +423,12 @@ static int panel_edp_suspend(struct device *dev)
>
>  static int panel_edp_unprepare(struct drm_panel *panel)
>  {
> +       struct panel_edp *p =3D to_panel_edp(panel);
>         int ret;
>
> +       if (p->desc->delay.pre_unprepare)
> +               msleep(p->desc->delay.pre_unprepare);
> +
>         ret =3D pm_runtime_put_sync_suspend(panel->dev);
>         if (ret < 0)
>                 return ret;
> @@ -1810,6 +1824,13 @@ static const struct panel_delay delay_80_500_e80_p=
2e200 =3D {
>         .prepare_to_enable =3D 200,
>  };
>
> +static const struct panel_delay delay_200_500_e80_pu100 =3D {
> +       .hpd_absent =3D 200,
> +       .unprepare =3D 500,
> +       .enable =3D 80,
> +       .pre_unprepare =3D 100,
> +};
> +
>  static const struct panel_delay delay_100_500_e200 =3D {
>         .hpd_absent =3D 100,
>         .unprepare =3D 500,
> @@ -2181,7 +2202,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, "T=
M140VDXP01-04"),
>         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100, "=
TL140VDMS03-01"),
> -       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100, "=
TM156VDXP25"),
> +       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100, =
"TM156VDXP25"),

Looks OK to me. Thank you for the thorough description.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Do you happen to know if any of the other TMA panels should also get
this updated timing?


My thought would be to land this in drm-misc-next instead of
drm-misc-fixes. Is that OK w/ you? I assume you just need a stable git
hash to pick and it's not urgent for you to get this in through stable
trees. Getting the updated timings is usually not massively
time-critical and having bake time / avoiding merge conflicts is
nice...

Assuming nothing else comes up, I'll try to land in the next few days.
Usually I don't delay at all for panel timings, but since this changes
an old panel I'll at least give it an extra day or two...

-Doug
