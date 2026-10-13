Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554FACC6B12
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE4510ED73;
	Tue, 13 Oct 2026 15:59:30 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD7810E8D0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:59:24 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7fccba9c675so6192564a34.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:59:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907164; cv=none;
 d=google.com; s=arc-20260327;
 b=eghtXVBesBpEivhD5vqMDWiPOTFglB7RLS5maRboON1LXs1sOkQoEsrTRyZ6b2Fyr4
 SU6CqXbgU//E56EriA8GkNkZos7zHHF2bqRnMLPle8A+j1Pp3rb4EfudQJOZkhYmG64A
 dLuwY3zw43zj4dHimoD+MNBB0yXHMq+1jusHtOIFJwTeJ5xRgn91r4J9jix3MbKFEyIV
 p1ZnaKAbfHEpsqDE9WAvI8K+OQRkBV/wNInENAfKj8ahkBVcdJqLGNpVHjwknmLcsUGZ
 qm3fMTnUujUrXes2pJrTldxbQfzoc2sK4+1FVuGMvvJnbZHrzGJr72HQCYtogAgWQT1a
 Pm+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=471AP+JUSNenBEdZwpiD4vRzIzL42+r3rsOryeaTPFo=;
 fh=WvQ8zvtqt4Z8v4f36ciW8wmRG8MQumEARagzU4GIjmc=;
 b=jzFrg4cw1nrNirOPNseiya56yAoDayWyaO8RI39PzjYhbJuM6ucLf4dDp30xqBmVL/
 0UO2h3kVTw6xF2RdJX14IAXhgR5aL7E+4CH978ySvRwigFqFQ6dxPUw74KhoMJRbkRh+
 QVXIOSj8zQ4GP6SakcBEh/BZOJwB6PJIQ1Eli3S8aSqbijPvfmw4PnHCq++ZcP14fdN6
 2dE73zFgGSIwR30NVOSG2Jx2QdX2pKUvg+L8t07yVsIQdb0VpnMVVjslJxxF5v2LRtY8
 KJEv15YKumEIgPxXsyoh4s114OZJMEika4WkjmL43alP1cJizPvJD6R/vKbMUuyD4EXY
 JEJg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1791907164; x=1792511964;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=471AP+JUSNenBEdZwpiD4vRzIzL42+r3rsOryeaTPFo=;
 b=MlN8x/FHuZaDozpm/ZujbuVor0jw/ICo8eqoewBwldYejsbHQ3PvlsY3hgVUtkL5DX
 I6gYeR/6+kmgbQsh73xQrdlsvqtinzJt4WuQUApYy7aY0FqOeqBg4b5B7prRPMDv6KTI
 o8Q1eHSsFiJMLTEMDqHGpbHa+i4+ARRUaEgXfBGDol0xWm3z7bG/K5ezOK9CjesDxM/u
 ypxzMQZSBvjWk9Jfg8mi+G61JsEDM20UHeTqoDP3LZZ6gnCF+tSwT3zrO2xWdUSVxTAg
 Yq01xX9RGFKhv4EDwGkIidv/KKUxyXjFVaSzHD7R+Z7P4snyM3kAbyPpHJ2cg6GrgxtE
 HBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907164; x=1792511964;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=471AP+JUSNenBEdZwpiD4vRzIzL42+r3rsOryeaTPFo=;
 b=12b1e1MMH+kelYu3sYgsfo3bQCPLm1TooE/4o7ENJX9Y5lo4uOQyIQMrxuNtXjCrNC
 IDM005Jz33L85mxjhvBvb/orM6HWLGzGHd5f+k8pAhIQEW3Mysc3fdqhGMGVq9p+exwa
 YM+ArHhNsQZ3Ps+xvwEeK2ZTlGtZ1FKalRZQzJAtn05H7Ccf9oI12CZcIxzT/iT5WlVZ
 qYXdko6PBqwyOYG7RhwNdWLW3YdZWLL5ZYmq0aVaNGImWCs4jvTU+OTLRw6TZxhyp9IC
 DhPlD48BhLfbbmwRZKlEv7MDxYudZO0BlXCEETKu2BqbPQQGMnMNE7OLvq7d4aBq0hm+
 e0hw==
X-Forwarded-Encrypted: i=1;
 AKwUvByq3hyWkiuGPHdH2Xmh6gkQF5I65yDPlIQGn4PxY0OtOPWqqn4jRpTpxu/j/Tjb/rkjBY1dYhFsVTM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJf/1xOQ/eyIF9bTFt9sGjLKo/l5/1hJBvIh6dA0u5bdBoRtNYM
 Oya7aBpvQqBU0s6kMA/kUNuJJltVPrs41FgnVR5OpPiAFzvOa+FhXKmtFKWP5aOPbMYUcQrr3rJ
 OuwGjG6i5mJKGQNPCeuJbf40O7I2SsnBK01Guyoenfw==
X-Gm-Gg: AYBFou1LTe+GisK7bcJR1kfeN0Gtr3ElMB2H85/kOGHmRAs7KUTKiidpjx+T2TBBYL0
 xIy1Rc/CGacNIrLfPwh6x9e7k0FSNZLoYtifpCn0OjCifUunImjDdJsVfCMpk62d88KryDYNGS9
 PH3/nXoLJmvpnqkvMoPpXDFhXsSLjIntuTc632wvDnnUlo8t8DeQt+/9VRsXkH31EDiALrFlVGU
 YZpfpoNUCVZbqQUSwyy++XIMyMpzHlHDx0OfErlMzxgIhY7WG4dTXGDehSxf/tT0SS0rFNdLYxT
 eXD71K2cMr1/Fwfs2bJML/yd/qJZmeJp6etJ8gYaYwdX2mKbuHG2ub05mBiGuM5FEHvvwXjlS8h
 HgeAM5Y/fvc25a1YSTfsMBIYy0V1TafZ2iO7uIht87A/I9hWUhfr3cVmXnQDQrN+Yk21DP5Yj
X-Received: by 2002:a05:6820:81c6:b0:6b6:5bf3:e22e with SMTP id
 006d021491bc7-6eee1a3dfe1mr7406315eaf.10.1791907163856; Tue, 13 Oct 2026
 08:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-vc4-common-scramb-v2-0-a41d15e131ad@collabora.com>
 <20261013-vc4-common-scramb-v2-2-a41d15e131ad@collabora.com>
 <682b6dc0-0b9f-4b2c-afd5-459e3f669130@collabora.com>
In-Reply-To: <682b6dc0-0b9f-4b2c-afd5-459e3f669130@collabora.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 13 Oct 2026 16:59:07 +0100
X-Gm-Features: AclHuK8hoDKY44EJ0rfjetH_v24c2VlTouopa1nFQCxRREJQjwG_yJTlNInvPgI
Message-ID: <CAPY8ntBFT_R1HbzzCvdvJ01SV8db0Cz7HcuRE7HaoyJ3-1FATQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] drm/vc4: hdmi: Bump BCM2835 max pixel clock to 165
 MHz
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel@collabora.com, 
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

Hi Cristian

On Tue, 13 Oct 2026 at 01:16, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:
>
> Hi Dave,
>
> On 10/13/26 1:37 AM, Cristian Ciocaltea wrote:
> > Historically, the HSM clock for BCM2835 was fixed at 163.7 MHz.  Since
> > the pixel clock had to be at least 1% below the HSM clock, it was cappe=
d
> > at 162 MHz.
> >
> > Since commit cd4cb49dc5bb ("drm/vc4: hdmi: Adjust HSM clock rate
> > depending on pixel rate"), the HSM clock rate is set to pixel clock *
> > 101 / 100.  For a 165 MHz pixel clock, this gives an HSM rate of 166.65
> > MHz, which, per Dave Stevenson, the hardware can handle without issues.
> >
> > Increase the max pixel clock to 165 MHz, which matches the maximum TMDS
> > character rate of HDMI 1.0 through 1.2.
>
> It seems this will cause CEC register corruption:
>
> https://sashiko.dev/#/patchset/20261013-vc4-common-scramb-v2-0-a41d15e131=
ad@collabora.com?part=3D2
>
> We can easily address this by clamping the CEC clock divider to its regis=
ter
> field width:
>
> -       clk_cnt =3D cec_rate / CEC_CLOCK_FREQ;
> +       clk_cnt =3D min_t(unsigned long, cec_rate / CEC_CLOCK_FREQ,
> +                       VC4_HDMI_CEC_DIV_CLK_CNT_MASK >>
> +                       VC4_HDMI_CEC_DIV_CLK_CNT_SHIFT);
>
> The consequence is that the CEC clock would run slightly faster than the =
nominal
> 40 kHz, i.e. (165000 =C3=97 101/100) / (2^12 - 1) =3D 40.6959 kHz.
>
> I think this is still within the CEC bit-timing tolerances and shouldn't =
cause
> any issues.  Could you please confirm?

My reading of the CEC spec agrees.

All the timings have tolerance of +/- 0.2ms on values up to 4.5ms, so
that would allow up to a 4.3% tolerance on frequency.
The error from clipping the clock divider is 1.74%, so fairly
comfortably within tolerance.

It's only video modes with clocks in the range 162-165MHz that will
have any inaccuracy, so pretty limited in scope anyway.

Working backwards, achieving a 40kHz output with the max divider works
out to be a 163.8MHz HSM clock, so that would appear to be why the
limit was introduced in the first place.

Thanks
  Dave

> Regards,
> Cristian
>
> >
> > Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_h=
dmi.c
> > index 8e4623ccc4f8..e61f1b694dbe 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> > @@ -1507,7 +1507,7 @@ static void vc4_hdmi_encoder_pre_crtc_configure(s=
truct drm_encoder *encoder,
> >        * users are able to use pixel clocks closer to HSM's, namely for
> >        * 1920x1200@60Hz. So it was decided to have leave a 1% margin be=
tween
> >        * both clocks. Which, for RPi0-3 implies a maximum pixel clock o=
f
> > -      * 162MHz.
> > +      * 165MHz.
> >        *
> >        * Additionally, the AXI clock needs to be at least 25% of
> >        * pixel clock, but HSM ends up being the limiting factor.
> > @@ -3363,7 +3363,7 @@ static const struct vc4_hdmi_variant bcm2835_vari=
ant =3D {
> >       .encoder_type           =3D VC4_ENCODER_TYPE_HDMI0,
> >       .debugfs_name           =3D "hdmi_regs",
> >       .card_name              =3D "vc4-hdmi",
> > -     .max_pixel_clock        =3D 162000000,
> > +     .max_pixel_clock        =3D HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ,
> >       .registers              =3D vc4_hdmi_fields,
> >       .num_registers          =3D ARRAY_SIZE(vc4_hdmi_fields),
> >
> >
