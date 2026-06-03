Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA46CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C2B810F9ED;
	Wed,  3 Jun 2026 08:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="Txj7Afy6";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A6410F9ED
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 08:15:20 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso466880666b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 01:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780474519; cv=none;
 d=google.com; s=arc-20240605;
 b=ilCO4heaKdapbGT1VMg6/zEOk18X2lY+SDYJnuauOIcTPwYKwTFg2Avnd4kqA5fvh0
 7StGNJ0lUYoYhK6SoefYY4LfgKiqHDDmjYDtdefJEwT5TQmCZ6d3qiT/Pb5N4j64mxWx
 JMw6Q0DTuuBMjs9Lp7iIXR2jiddHLrlIXYZvcPMOe6RhLQBWRSczgynOnCZel5vETAhL
 sOuKhNvS46Nf2u/G9kK8k9H+IIQTYOaEbhAOajFf/47UJfeMLEI2BBa2z6e0MXCGCfmC
 SC45DJide2LmdbBAUUhLc1Z9BJvXWe7KZCzp4BFNo63UEPCnZT7Fw/iXpwIaFA3e2tE8
 18Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gRjZpsNs43oaDIo6NFyqCqveQQyEyd7nLlm/j3z6ROA=;
 fh=MZ7lsUYvgMipsNkTbYDxSXNBPXAfIX9CBRpOZMpv7Dw=;
 b=US/u8MggXM9dccV1tEMjPs2zd60GdrR/jyRH7Jhpc8XTW1e+A+JxuvsxtO0D6Cf8A2
 ydMqIV7raieL/ZDUWNGq5gCYFWt044K23fg+WNaSyikI3cf8+0ar8c5abiI+pcrPm94b
 ak/b/7ETNoNiEu6F/2eih/6uGXc7lyQPDzPyOC1nUDKoKWdZTR+vcRx+MqyC3MkqC+Pj
 1ACgKoSGuXvIMx1k4kBKc8e6q/d5G5yFEMMHVxO36K6QH/kGZHUMA6jfPO4xS4DG+c51
 yQqGirOpz8M+E8vAkWRM6euXTuBBarzT6Q2Rh0YSC+I2xOSLBtlHSrwc59t8e+8r9XDr
 yY3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780474519; x=1781079319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRjZpsNs43oaDIo6NFyqCqveQQyEyd7nLlm/j3z6ROA=;
 b=Txj7Afy6P4RUlwMx5WNFhTk4+sTgQVy+nJ64MUC2TfXtIXTap4j22E5bSGDdD3lvuz
 qttydSFubYERO5JRi/3RTRNQfU+pV2tiAbiscTsZ0xdzX79nQvcjJr3Fan9ge/n/J0x8
 i8Rw2AfDLgHv1XhbbuCZzgoyHYYjIzSBj/Mrg0ZqMqb4Bi5vtIyG1Xv1XuUtPyDgK2Fa
 clz4UUwTJZ6qFc6ZHOPubR4HvKIqaC2NPVB7ZpfwiWAi8Vc5xVf6EaU/W3Jh0BlFXcF0
 9a7BjaG5uYg+R/m3jiTQK8XRuXvXsXKUt3m73kv4g/FRHNGY1tkP4jrIQgAsfL8LAxkU
 do9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780474519; x=1781079319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gRjZpsNs43oaDIo6NFyqCqveQQyEyd7nLlm/j3z6ROA=;
 b=Bx3rnfBU1Noe5VBh4eixoPwU9Ugy2GcHKKgXMTvImXOK0VLWaqFILH7jjOlE1f+PNo
 38gR8vTvHBp8edv56RFGpNLFo/+l/zW8cPv3say7kLZ+1cGkuu7O0u8fZYPbUVrIALQO
 pgHwHMXOhSa3yRh/zIzf1hjHHRMP6iVJu2LV5LCOdI+sYKKXvQZKs0o8h7kEVh0PhIoq
 Z9wSgNbGzG1CVbE15othT/Qihrp+CcLfJlPQH0ZPxJvbDPCtjPI6CYNnf3D20zxqNriy
 vrwDtSVrX0/bnlfFNvkljSm5+zLqQe1/FkAGDm3hmDif2qRxPiFOn9NgwFHdXwFLHZvq
 D81Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mCZli8gnmzZSQp+Tr926jCRWn/jhxfGCuHg2915CSoAZCrGu/60Xa4JThBPhaCsStBqA2ytG0ueQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxByBvGivOgph6BLW2FCGGOrxuZSv+ZV+4+WklL/RmC9BsWXejA
 xCvw/RH1I9mvotSwGpYNm7JYgyflxBv0zu0jYJlIh2a0yaOuqx8GlShRtIuGbJQ2bLYJ8Y6aijD
 NS2CltFvGzaOYURrOPUxs2V26Gl2+J7Mirw2Ap1bLrg==
X-Gm-Gg: Acq92OEtxAUXZYEWjBqV6ijTBkpBXbwwr9PtroDUaY0YIvSto7rUA0xspsKUhUd7xG2
 EbeKWUCidDo4nLgbV9gyRmG0QdMUVCnfmNhlNtCd2X831wXY3bK/5gaLcq5QsSnXDWzd+jMhhqt
 3r1aZIqEUK0NBSa4zXOTIUfPATmN2yB0Xl4GSvRKZop8135MSAIHmLRkvAavn15ekH6ycwah+hv
 Kj4FZh2ZkVlSUD8HAUPvJWD+zeA8JXRD7huPQNRkpUjwz3OmVFMAvx1o3D+X9hEVzCSAUQRE65Q
 blZcjtDsked6KsYfRz8=
X-Received: by 2002:a17:907:2888:b0:bee:77ae:331d with SMTP id
 a640c23a62f3a-bf0ab21598amr67736366b.40.1780474518495; Wed, 03 Jun 2026
 01:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
 <20260602-hdmi-overscan-v1-2-31f71b817c80@flipper.net>
 <20260603-glittering-vigilant-beluga-0c6bf6@houat>
In-Reply-To: <20260603-glittering-vigilant-beluga-0c6bf6@houat>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 3 Jun 2026 12:15:04 +0400
X-Gm-Features: AVHnY4JpnTW5Hb5wV2KDIa-xAcNMWSVw4PZh0S5vcLCYVB4NPlWeSB2i4m-eFk8
Message-ID: <CAKTNdwE5uAOc9V+L1J7_QJfW45D-K-vTnpHuktxD2=x9e_4jOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/rockchip: dw_hdmi_qp: expose "overscan" property
To: Maxime Ripard <mripard@kernel.org>
Cc: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

On Wed, Jun 3, 2026 at 11:55=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Tue, Jun 02, 2026 at 09:00:40PM +0400, Alexey Charkov wrote:
> > Expose the "overscan" connector property as recognized by KWin and the
> > likes to compensate for TV overscan cropping.
> >
> > The CRTC will use the margin values derived from this overscan percenta=
ge
> > in its post-composition scaler to add appropriate blank margins on all
> > sides of the output image so that the TV doesn't eat up visible content=
.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/g=
pu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > index f35484715c2d..fae44d11dbef 100644
> > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > @@ -137,10 +137,18 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct d=
rm_encoder *encoder,
> >                                        struct drm_connector_state *conn=
_state)
> >  {
> >       struct rockchip_hdmi_qp *hdmi =3D to_rockchip_hdmi_qp(encoder);
> > +     const struct drm_display_mode *adj_mode =3D &crtc_state->adjusted=
_mode;
> >       struct rockchip_crtc_state *s =3D to_rockchip_crtc_state(crtc_sta=
te);
> >       union phy_configure_opts phy_cfg =3D {};
> > +     unsigned int overscan;
> >       int ret;
> >
> > +     overscan =3D min(conn_state->tv.overscan, 100u);
> > +     s->tv_margins.left   =3D adj_mode->hdisplay * overscan / 200;
> > +     s->tv_margins.right  =3D s->tv_margins.left;
> > +     s->tv_margins.top    =3D adj_mode->vdisplay * overscan / 200;
> > +     s->tv_margins.bottom =3D s->tv_margins.top;
> > +
> >       if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &=
&
> >           s->output_bpc =3D=3D conn_state->hdmi.output_bpc)
> >               return 0;
> > @@ -603,6 +611,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device =
*dev, struct device *master,
> >               return dev_err_probe(hdmi->dev, PTR_ERR(connector),
> >                                    "Failed to init bridge connector\n")=
;
> >
> > +     ret =3D drm_mode_create_tv_properties_legacy(drm, 0, NULL);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret,
> > +                                  "Failed to create TV connector prope=
rties\n");
> > +
> > +     drm_object_attach_property(&connector->base,
> > +                                drm->mode_config.tv_overscan_property,=
 0);
> > +
>
> As the name suggests, it's a legacy property only ever used for TV. You
> should be using drm_mode_create_tv_margin_properties()

Hi Maxime, I tried that one before going for the current solution but
realized that the userspace tooling I care about (KWin in particular)
doesn't recognize those properties, but it does recognize "overscan".
Maybe there's a compat helper somewhere that I missed, which would
translate between the two?

It is for TVs. Turns out that having a proper right-sized digital
input interface doesn't prevent them from doing weird stuff with the
image data, i.e. overscanning and cropping it right where one would
expect to see the system tray and panel.

Best regards,
Alexey
