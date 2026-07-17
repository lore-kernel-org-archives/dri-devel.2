Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5020C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2602A10E474;
	Fri, 17 Jul 2026 15:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RgCwYOJ1";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472BF10E474
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:22:41 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5c11f9015d8so1121141e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784301760; x=1784906560;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a28753WcgegEYJFy065d8dQeBpvP5gHkenWNb8iKN30=;
 b=RgCwYOJ1PGIW1GNZ8lA5B9vRWmMCpJhVj0SBVK66EJxowTIfQxQZy3kPwRp9z7LgF5
 AQ/hKF7P+Dlu/EcB3/krAN0IKfrNqV7HdoG5qYCsZsa4pARSwcStO6Cjv417KRtTPiW8
 r7WNqRH94mhQSHUf6YTelDmQWExO3TOEpV4N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784301760; x=1784906560;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a28753WcgegEYJFy065d8dQeBpvP5gHkenWNb8iKN30=;
 b=q7GpmBMCBcDv9seU5uzOe6/JWxkzrjlqRutPhSjHRRVdLcCL13PaxHrpIa/aPBwrwu
 U5N7Hh2Dsbartjic9abIDB+H3uDjbwneaD6D57PlOqfu0N2qVTdBhLWUwHzRbcXOjWkJ
 H3vIWLIE+CEYCMbqr9c4dhdU6/lpNdyfBF8K+y2Zb4mQLsH32MKB2lHNgpTdpV4Z1sPP
 kJt6MzX1ORFNv44TL10KmYj93P/4B10+RUWs1G7snradX8snroPpv4LNBMK/DfKGJpfj
 lxOkShTQeF4d4OEh2i4YOervHAYcBBnugRKzp/JJMaVVbI5WBX56XZKfXADSuAQ7vI2o
 GV4g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAjsqT+RQn7EjtjgZ30j9hfe41hDoNxiiiZNVyOWHMJQ0bAiGKnIeRl7ixoiY8yRvG5ZhiDEP7img=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJC9NXI7QsGGmJAABE++kwYOQwekDygF186Dk1vsA7gPfWrBN6
 06PerclzBZyYWpCq613Z99M0cbgE1r3nspkI7yVwM6AHDCu96FPb1OosX+MoWoEyc85hk+tHCfu
 BHNQ=
X-Gm-Gg: AfdE7cmjf/0YVKVaaPd67pvexEDvzcCbrqPaiF47rRXz6hgzlK6V2O7+UWj/4H0QDjy
 cx7oa3XMk2WQnNThEQNXbTShQPTKz2N2wbyIQPC0N5vbL8Mm85ZwXBy1IL2SEa9cmXEuPEG/dZT
 OgwDFqRk8VQdtufC2MZJrTSUJe1X3+vMDiGUMBch/IZFerGxVfJM2cUSwJGBIIxuffiYEt18ms1
 SgHwoZJ+mvujNHap40CqY2IQr/7+OaPPrRRJlko3XnU0macSyJKxcY8OODuuk4g5I2HBTxjFajV
 uNf/mY5iiBMGizEKU+jtALCBg3Q+7YO7ceZK8q7mS0Ec0tDOggTVXJpFpHLTY01tof6pxY+nOU2
 BoULcblvySW0QcrYEJ4TXx/gQrE5hEceiyTdEb+gww/j/zNj2pVbGPpI1GILAVGWIMWuL8SxFPg
 xoGUgLPA1eQtymjheYrDtW0lijcH9oSeSst01DH2tAn4xY
X-Received: by 2002:a05:6123:2e7:b0:5c1:1965:6243 with SMTP id
 71dfb90a1353d-5c1bf9379d8mr465920e0c.13.1784301759860; 
 Fri, 17 Jul 2026 08:22:39 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com.
 [209.85.221.179]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1eecca4f7sm811832e0c.3.2026.07.17.08.22.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 08:22:38 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bfd4795097so1480424e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 08:22:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+Rqkm6rBqY8CG1r1L6UNkFJA2wb/A2oBj5n8ixjwBMpiiDblKXYizg2ibvFE1P6lLpSaOcIxfVUcNqA=@lists.freedesktop.org
X-Received: by 2002:a05:6122:1822:b0:5c1:781:7122 with SMTP id
 71dfb90a1353d-5c1b64e8f86mr470005e0c.3.1784301757640; Fri, 17 Jul 2026
 08:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <allWpYxgHfpKughy@michalis-linux>
 <CAD=FV=Wez4s5gUPXN=DuHvHAk4esBMGfh4Rj=ww72UK7VUbOzw@mail.gmail.com>
 <aloAAaC1FuDqT8Rd@michalis-linux>
In-Reply-To: <aloAAaC1FuDqT8Rd@michalis-linux>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 08:22:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X6FwYMKfCRaGrJtnVpuk1V0OsTg4MdMVNpikt2UVzFNQ@mail.gmail.com>
X-Gm-Features: AUfX_mwEPh-VCFFUvNOfjb3MXM8YUOa4GHuNrEouu3mhJpBfiW-ZoeHeXe1Wowo
Message-ID: <CAD=FV=X6FwYMKfCRaGrJtnVpuk1V0OsTg4MdMVNpikt2UVzFNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: ilitek-ili9805: Use _multi variants
To: Michail Tatas <michail.tatas@gmail.com>
Cc: michael@amarulasolutions.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, jesszhan0024@gmail.com, 
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

On Fri, Jul 17, 2026 at 3:12=E2=80=AFAM Michail Tatas <michail.tatas@gmail.=
com> wrote:
>
> On Thu, Jul 16, 2026 at 04:31:53PM -0700, Doug Anderson wrote:
>
> Hello Doug, thanks a lot for the review!
>
> > Hi,
> >
> > On Thu, Jul 16, 2026 at 3:09=E2=80=AFPM Michail Tatas <michail.tatas@gm=
ail.com> wrote:
> > >
> > > @@ -159,36 +159,23 @@ static int ili9805_power_off(struct ili9805 *ct=
x)
> > >
> > >  static int ili9805_activate(struct ili9805 *ctx)
> > >  {
> > > -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> > > -       struct device *dev =3D &dsi->dev;
> > > -       int i, ret;
> > > +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D ctx->dsi=
 };
> > > +       int i;
> > >
> > >         for (i =3D 0; i < ctx->desc->init_length; i++) {
> > >                 const struct ili9805_instr *instr =3D &ctx->desc->ini=
t[i];
> > >
> > > -               ret =3D mipi_dsi_dcs_write_buffer(ctx->dsi, instr->da=
ta, instr->len);
> > > -               if (ret < 0)
> > > -                       return ret;
> > > +               mipi_dsi_dcs_write_buffer_multi(&dsi_ctx, instr->data=
, instr->len);
> > >
> > >                 if (instr->delay > 0)
> > > -                       msleep(instr->delay);
> > > -       }
> >
> > What you've done is an improvement, but it's not all the way there.
> > Specifically, we'd really want to get rid of the whole "struct
> > ili9805_instr" type and instead each panel should have an init
> > function. The "struct ili9805_desc" should have a pointer to the init
> > function instead of a pointer to the init data.
>
> I am more than happy to do these changes as well. My only concern is
> that I do not have hardware to test the panel. Are compiling and static
> analysis sufficient tests for these changes ?

That is inevitable with these cleanups. We're doing our best with
static analysis and code review. If someone comes along later and
finds that something broke, we'll fix it.

-Doug
