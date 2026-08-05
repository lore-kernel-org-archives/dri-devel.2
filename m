Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19886C56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1513910EE04;
	Wed,  5 Aug 2026 11:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WVVD9QRZ";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E27D10EDFE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 11:11:19 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-902fc790cd5so5127686d6.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 04:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785928278; x=1786533078;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+p2kSkacYugIlbntWaga4JcJ0qDuRGEXcFIj/Rb20Ns=;
 b=WVVD9QRZJStyAo37oU93mGyUr+hYfmRPznnSIiByMR7sj/oPYvfHeVfNAm96IRNWIO
 pg/PB7DHztN/rRUcCe6nmqHHkcfSW5hT0Vng6+Ckbw+DQ/WdaqEE0VzxOzPFk+3DOg4b
 Xhg42VCDZty2kqCwAI/o6cv2w5R1y6IPAPF+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785928278; x=1786533078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+p2kSkacYugIlbntWaga4JcJ0qDuRGEXcFIj/Rb20Ns=;
 b=kCvFAJoeT7kwAtY+cK8LtlHqabrvWWMQHQhMt2ayuPdFVZtL4FnQJkgGbCpYiV2EiS
 e0nb77wgx9/QGVrA51ARhTmGO3bz8vWodJ08c4KA15RGtX2T8nAzMrvm8sSPlRNsVqTd
 bMAWjZhKcGOadTiwyWL5X52dzgYhw3OQ8JvB6r6APmrNXu15pAhHIIbYrTn8mv8E8wGM
 SM9S3d/2L6E5tozlHeN8Uo0t7huej7NDprxodZPJ/VZB5EP/ACUZJdB2RJM06eXzV7yf
 UJhBM4JLhW6MV6YzxCvaiQ2IFpXkFGgYrq0k6pkIb5T+TgnyRkj79xug8kH+KDbCzInK
 iVUw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+3fGxX9hiX4d7BVp3eJi3rjIm1nOZVeXBMbpw2xFHRhrl/gD0KsE1EbLDT/o2GixNoTVCrFIEplg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRMPeTsiK1N3rOvYGLYcF4Lr/YT0w0dEampt9IlebpogtcKaKq
 wHOtYQmm93/eY4MIggL+AvF44PLl5IxDPEWtb1cz1lElk1Iv8BLcBjWURdounYXS07JnDHG1rjp
 Znis=
X-Gm-Gg: AR+sD13oFzjSPeblBZBuztqOjOWUnAsGHhKmgpbSTJKmChXusCth8KUxh60/eTOjANW
 1yGIHX+cbJG0U17+ji5oqrjCA3nToZU2sqMnavVuvcqDCNH9I9VmbBkrThetr3zMYCVDy8SnsbK
 hPuQ30iP2buHpTM3HVNtt6cTD5NKfMbfrAiHC9KUNPBAEDLz6Oi6Ic9LHWvhyW/vULW/3QxSVAD
 VKexFhjLl59MhWZv20m2wMrmBZiDcp4kEvjNwwXV+Y8Zo6uayR03xPrr0QIiYUO7XAc2+5/Blcb
 y9HLvbS0Zo9xPd7KNF3mmiNdUdVVAqhKP5lu+jZgti5nd7wUV4el1cG0UgXG1QzbVD02UgZJ8Tf
 Z45wnMEvHzbjYlXuzCdFC7n76JZRY+jHt4UvdqxfgyclQNDE3cexSFSPyVcBEmnJgxunxccN2SR
 voGLaiFJl5pi2lgtqBszYv/+VLZ85jNGFD8vstxyU/iZ63r5xRkl6Q/w3scJ01ws/qxMu17amjJ
 N6gFjubMV0B2F3tjlNKaNStAx/KUAt9PQ==
X-Received: by 2002:a05:622a:5516:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-52ce61f0209mr64448161cf.42.1785928277607; 
 Wed, 05 Aug 2026 04:11:17 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com.
 [209.85.160.174]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9087ff9de0csm23012386d6.1.2026.08.05.04.11.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 04:11:14 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-51c01c79467so282271cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 04:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpeHFzvR4/fLgjJogX/VV9JzxiSHmeTpGOIdgBrddTevLDqUbLuMr0X20+n4zy2aqk8qDNhcMLe0cY=@lists.freedesktop.org
X-Received: by 2002:a05:622a:858c:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-52ce9918299mr13800341cf.13.1785928272915; Wed, 05 Aug 2026
 04:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-edp-v1-1-3e92dec1d56c@chromium.org>
 <CAD=FV=XeW806uSg5JM95qHrfKUKXpC_z9BUaDv61wu0KGFry5A@mail.gmail.com>
In-Reply-To: <CAD=FV=XeW806uSg5JM95qHrfKUKXpC_z9BUaDv61wu0KGFry5A@mail.gmail.com>
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 5 Aug 2026 19:10:36 +0800
X-Gmail-Original-Message-ID: <CAHc4DNLeDaa5gXjiJtmH_0gyCLVk+=MhziL60Uy4eh6-u9QWew@mail.gmail.com>
X-Gm-Features: AUfX_mwmxW9vzhZhHnUfwfodrdvjUiWDrb2M4dbUrQUBRTcA87Cq3Q6rWsDw7Xc
Message-ID: <CAHc4DNLeDaa5gXjiJtmH_0gyCLVk+=MhziL60Uy4eh6-u9QWew@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add pre_unprepare delay
To: Doug Anderson <dianders@chromium.org>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
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

On Tue, Aug 4, 2026 at 3:50=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Aug 3, 2026 at 2:47=E2=80=AFAM Hsin-Te Yuan <yuanhsinte@chromium.=
org> wrote:
> >
> > In eDP power-off timing specifications, T10 defines the minimum delay
> > required between the end of valid video data from the source and panel
> > power-down (main VDD off).
> >
> > Currently, panel-edp only supports the 'disable' delay, which correspon=
ds
> > to T9 (backlight off to end of video data) and runs in panel_edp_disabl=
e()
> > while video data is still active. For panels that require a delay after
> > video data has stopped before cutting power, this delay must occur in
> > panel_edp_unprepare() before turning off power rails.
> >
> > Add a 'pre_unprepare' field to struct panel_delay to model T10-min, and
> > delay for this duration in panel_edp_unprepare() before calling
> > pm_runtime_put_sync_suspend().
> >
> > Additionally, adjust the timing entry for TM156VDXP25 to use
> > delay_200_500_e80_pu100 (enable =3D 80ms, pre_unprepare =3D 100ms) to m=
atch
> > its panel specification, replacing the previous delay_200_500_e50_d100.
> >
> > Fixes: b9e2d5cdaab0 ("drm/panel-edp: Support NV140FHM-N5B and TM156VDXP=
25")
> > Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> > ---
> > Change-Id: I3361bdf4d3289c773f0c2b77163e427b774797d5
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 98bdcf352701..f6624191f97c 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -144,6 +144,16 @@ struct panel_delay {
> >          */
> >         unsigned int disable;
> >
> > +       /**
> > +        * @pre_unprepare: Time for the end of video data to power off.
> > +        *
> > +        * The time (in milliseconds) that it needs to have passed betw=
een
> > +        * the end of valid video data from source and start powering o=
ff.
> > +        *
> > +        * This is T10-min on eDP timing diagrams. It is not common to =
set.
> > +        */
> > +       unsigned int pre_unprepare;
> > +
> >         /**
> >          * @unprepare: Time to power down completely.
> >          *
> > @@ -413,8 +423,12 @@ static int panel_edp_suspend(struct device *dev)
> >
> >  static int panel_edp_unprepare(struct drm_panel *panel)
> >  {
> > +       struct panel_edp *p =3D to_panel_edp(panel);
> >         int ret;
> >
> > +       if (p->desc->delay.pre_unprepare)
> > +               msleep(p->desc->delay.pre_unprepare);
> > +
> >         ret =3D pm_runtime_put_sync_suspend(panel->dev);
> >         if (ret < 0)
> >                 return ret;
> > @@ -1810,6 +1824,13 @@ static const struct panel_delay delay_80_500_e80=
_p2e200 =3D {
> >         .prepare_to_enable =3D 200,
> >  };
> >
> > +static const struct panel_delay delay_200_500_e80_pu100 =3D {
> > +       .hpd_absent =3D 200,
> > +       .unprepare =3D 500,
> > +       .enable =3D 80,
> > +       .pre_unprepare =3D 100,
> > +};
> > +
> >  static const struct panel_delay delay_100_500_e200 =3D {
> >         .hpd_absent =3D 100,
> >         .unprepare =3D 500,
> > @@ -2181,7 +2202,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
> >
> >         EDP_PANEL_ENTRY('T', 'M', 'A', 0x0811, &delay_200_500_e80_d50, =
"TM140VDXP01-04"),
> >         EDP_PANEL_ENTRY('T', 'M', 'A', 0x2094, &delay_200_500_e50_d100,=
 "TL140VDMS03-01"),
> > -       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e50_d100,=
 "TM156VDXP25"),
> > +       EDP_PANEL_ENTRY('T', 'M', 'A', 0x2139, &delay_200_500_e80_pu100=
, "TM156VDXP25"),
>
> Looks OK to me. Thank you for the thorough description.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> Do you happen to know if any of the other TMA panels should also get
> this updated timing?
>
No, this is the only one the ODM reported so far.
>
> My thought would be to land this in drm-misc-next instead of
> drm-misc-fixes. Is that OK w/ you? I assume you just need a stable git
> hash to pick and it's not urgent for you to get this in through stable
> trees. Getting the updated timings is usually not massively
> time-critical and having bake time / avoiding merge conflicts is
> nice...
Yes, I'm fine with that. Actually the original commit is still in drm-misc-=
next,
so I guess this can't be landed in drm-misc-fixes.
>
> Assuming nothing else comes up, I'll try to land in the next few days.
> Usually I don't delay at all for panel timings, but since this changes
> an old panel I'll at least give it an extra day or two...
>
> -Doug

Regards,
Hsin-Te
