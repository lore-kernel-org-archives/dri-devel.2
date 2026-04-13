Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314B0F34C64
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0AB10E4C9;
	Mon, 13 Apr 2026 16:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hibv6rLZ";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E16A10E4C9
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 16:07:37 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so633524366b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776096453; x=1776701253;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVg6v8UdhW0a5USWX1wEGOFkdAoQk8fCecUBJXfL20Q=;
 b=Hibv6rLZHzPnHmZ+Rz27ph+0K4iYcEVGWpLFz4uqO6ih539XqjBj4Ww0RXl6+aglGT
 LpqwjC/81mFsbIqye93jmphGCbXuuPrPn1D/3AJ8fopLAKyYAqjQrUH3v8nV7q7ii3m+
 9JMHlyrP8K2MCnkwmXmYRNhq6tC+EH5i29kL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776096453; x=1776701253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iVg6v8UdhW0a5USWX1wEGOFkdAoQk8fCecUBJXfL20Q=;
 b=Ljo6RQR47eQ+P+JPNu8LpONUXE1HxX63joOkswwSkkf1cxgM5E5ON+/ejYXT3LuCBU
 FnVsTcsyQztwJ7LwN9ub9rUN5MRvQwCHdZdmY/AuTaiTZAmLWHpZB0Fq0ZmvDZ7k7FOr
 mPW7igRqBnr5UQwTIvkBT2twHcDGSC+wieiiKKCs7gS61xicayGeP18IXIzU4GidJtUM
 KpCF+OQAuKGJsBLbQ4eiOwcvnvmquNSu9+DVpOWCTinpTRJSvd/WXF6BYkFCBHY+sCLE
 ND14K/ASzc1IybWvE9KJwhzqKggxHH4+ofwxfJPnZFdLYzYwZYSCYYn4zG3Sc8SvkWIB
 +6ww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fgJ4LqlySgOXXKaQ+oEnEIMRInf9aKUAS2bF7IujdfIaSptmniQNnQEM7jFFokbPD3wVOVPJVj+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFqag5QY7JPb+uj/564Z+2OdScKMlaZWE/Q/HttodZLLO5HKCe
 j//0waqKLxYFCLRsY0SKw9kQrvknP8i7WGJiIN/l9o0ILAOVhzvC2zmLoOoyal2LWWPD7670YRS
 CN+xkRQ==
X-Gm-Gg: AeBDiesQyuM7hLUqy92BL1Oy3acSdeeJGi/IFsQER1er8F+Z+HR64Fu/MWQ0J4hJWnS
 bLblFLgBVlJWPP6xa7ym3IisozNgH9mOh7yHIZSp8g4PL9sBoPLfbeUxqUM2azQYAURz5ktCk5x
 EhSmyrdOSoUeDbRfhqhxez+o2jTcBlU0M3ZO94tkuTabHVwa+9ePlNsqzlWIxetNI5ph9Zd0BBb
 NYKQAnsCxMKHbDjeiqebb3R33eclj/hbCFWQ9uc5Q/RFrAepFxlu9I7HbjdnycSF1MNyFS1FEo+
 kM5FdH33Mzl+QRfZUe+jKZPk1hK2GH6QcHl/EWyJ31t/1M7UKuecwc/UnMfMIrLtiY/tGYINN1g
 +Xyi6iimYbPF2ams8ZQaGPv8DjxIBian3iMcWlZ18fg9/QMOC4eAOid+mQknncR2TXFCvU0dMS1
 SE5RKnL+Eimcf/i+D40p28W1EWT3wHVQ4Pw8yaSRFxiwh8LOA6+rMPz87KrOAm6OkXh6ztLAXSM
 eMK37t2Xxg=
X-Received: by 2002:a17:906:c105:b0:b9d:78c5:2ed with SMTP id
 a640c23a62f3a-b9d78c52649mr662779166b.38.1776096453246; 
 Mon, 13 Apr 2026 09:07:33 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9d6e5c56d3sm337483666b.32.2026.04.13.09.07.31
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 09:07:31 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso54133435e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 09:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/GC5uPHDJiruVaDC8qU85NH+8Q4idVLf7t43cQbkSOUe9TY8ASZVAQoM3engRpVXroClHqMUJcigM=@lists.freedesktop.org
X-Received: by 2002:a05:600c:4709:b0:488:ae6c:42c0 with SMTP id
 5b1f17b1804b1-488d67d2ab2mr163642845e9.7.1776096450922; Mon, 13 Apr 2026
 09:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260113091440.43735-1-avinal.xlvii@gmail.com>
 <20260113091440.43735-3-avinal.xlvii@gmail.com>
 <b7a8a27d-e61d-492b-a5e3-a0a21436045b@linaro.org>
In-Reply-To: <b7a8a27d-e61d-492b-a5e3-a0a21436045b@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 13 Apr 2026 09:07:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VMoMPR=A_S3mcAogut4J=FDZh1WyyJC3VxvRxgF9MR0Q@mail.gmail.com>
X-Gm-Features: AQROBzC7GhUj952PwdFl0-MlmNYDKE7xhs4lA6l_UrdjAl-GjDptBeYmjuAw0FA
Message-ID: <CAD=FV=VMoMPR=A_S3mcAogut4J=FDZh1WyyJC3VxvRxgF9MR0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Avinal Kumar <avinal.xlvii@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>, 
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

On Mon, Apr 13, 2026 at 1:07=E2=80=AFAM <neil.armstrong@linaro.org> wrote:
>
> On 1/13/26 10:14, Avinal Kumar wrote:
> > Changes the panasonic-vvx10f034n00 panel to multi
> > style functions for improved error handling.
> >
> > Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
> > ---
> >   .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 14 ++++++++++++-=
-
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/dri=
vers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> > index 3c3308fc55df..73c5827a15a4 100644
> > --- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> > +++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
> > @@ -44,14 +44,24 @@ static inline struct wuxga_nt_panel *to_wuxga_nt_pa=
nel(struct drm_panel *panel)
> >
> >   static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
> >   {
> > -     return mipi_dsi_turn_on_peripheral(wuxga_nt->dsi);
> > +     struct mipi_dsi_multi_context dsi_ctx =3D {
> > +             .dsi =3D wuxga_nt->dsi
> > +     };
> > +
> > +     mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> > +     return dsi_ctx.accum_err;
> >   }
> >  u
> >   static int wuxga_nt_panel_disable(struct drm_panel *panel)
> >   {
> >       struct wuxga_nt_panel *wuxga_nt =3D to_wuxga_nt_panel(panel);
> >
> > -     return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
> > +     struct mipi_dsi_multi_context dsi_ctx =3D {
> > +             .dsi =3D wuxga_nt->dsi
> > +     };

nit: get rid of the blank line between the two variable declarations.


> > +
> > +     mipi_dsi_shutdown_peripheral_multi(&dsi_ctx);
> > +     return dsi_ctx.accum_err;
> >   }
> >
> >   static int wuxga_nt_panel_unprepare(struct drm_panel *panel)
>
> So yeah we want to use multi functions but in this case I don't think it'=
s appropriate
> when a since dsi function is called in a callback.
>
> Dmitry ? Doug ?

It's a little weird, but I think the official stance is that we _do_
want to transition even when only a single DSI function is used, as
this patch does. I can spend some time trying to find the original
discussoins if need be, but as I recall:

* The "multi" functions do still have the advantage of giving you an
error printout. Previously the "disable" function here wouldn't have
printed an error. Speaking of which, we probably want a v2 of this
patch that gets rid of the (now extra) "failed to set panel on: %d\n"
error printout since we can now rely on the error printout in
mipi_dsi_turn_on_peripheral_multi().

* We talked about having a variant function with the error printout
but not the "multi" calling style, but I think we decided that it was
better to have fewer functions to worry about.


-Doug
