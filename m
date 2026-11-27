Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022F606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0Vxw2HZk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10479112AEB;
	Fri, 27 Nov 2026 13:21:19 +0000 (UTC)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566EE112AEE
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 13:21:13 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-386c336eab8so4523632eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:21:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795785673; cv=none;
 d=google.com; s=arc-20260327;
 b=OTa/oAEIvRruS4zpIDLw90iGSWwZVZzlhotL0v5GIqlzzQ02SyFsMKH6cavvBAGaW/
 2q7he1bRBSL2iqzUa8u7GDUAaVDB1GxrFQz5xeMyHfTNl4gWGdV8A61Dd0DEp3Ecy1WK
 Ati18dzMqdrjnW6CDFtK9EnlOFPm7DEmSfjX9092b/KmnmgRxy2hHAJCedEGgz9UzsrR
 t6RAfi0+X6HCif6M/4cL/t5cDiREKMpx7rygUv5pKVVKwQ6OEN9/Eus+ws/xpSTWt404
 It6sj0LcThkvJcrA+jb0VVYuIifqMvFtblaxOG3T/VM5dhQmygDXh7ChIXAJiIB0iwFN
 yupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vZvQHSZLsgr2GY03N9ewvKKm4RcNGFB1wwLAiy/rmRw=;
 fh=AL5N81L1xzlpDDdqiBMxgiI5+zM/pisFj+DhvVtBmlA=;
 b=R0o+ChCAb3u0cQmGcrUzBfIl1Y04UsaRbeOeNgwiVsxuUBLSKjERLxzE1XuiL5GSt6
 RntfbHZJD3Bbafp8sYtVMyoaHqSBqmacJtFg+ux10jUCjwEuz5el+GWn5M1mi7V8H85E
 EIrJxtKR5iplQ+ipoeZi2fIBy+AvGGM1JiaIBCy69uNmUnnlmDcZ7UZOc1TgQGaor1mS
 F2RDs5McIHeO2+uUFouOHy1gl9H5t5zcOQwsvdgJnBdAzFRgLH4B7e5KR01G/c3gQ0zA
 +zsBEjQZj9nqAGYBStIm/oVUnMXnp9z2bgp6U8PP36zU8S+Z2/4tPnGwK54tASLX8Fdl
 RNLg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795785673; x=1796390473; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vZvQHSZLsgr2GY03N9ewvKKm4RcNGFB1wwLAiy/rmRw=;
 b=0Vxw2HZklz40QVh/IMu4csMxpV4CySVr9Ipkq8gLP1gqkbWapHBkXI5ZwD8Bbq7Jas
 sbNVDPSY6RWP3tyTdIhWDgPlSTjUHPz+pXsgurlQR/MItY5u3Cmw4e506cr6tPIaeL5e
 jIQ41kp500v596SC5jddV3QN9ejcSN5sj0TgCu2jrOFrlVj6j53COxW9bD1mAUYtwMyA
 X9cu5TyxnuwWaz4w//WFDhauYkdfftKfkAoGvr5je0aG8rAG2apl9lqlYv7IkCYG65Em
 yNibpBY02gGos4BFfZNivCdh8mNCDMZKUqd5YbgHtoJxcaP7OEFVfQBq7VmDtGu9077y
 lUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795785673; x=1796390473;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vZvQHSZLsgr2GY03N9ewvKKm4RcNGFB1wwLAiy/rmRw=;
 b=jXQWkqgRHgFsgVPP4ea6bVRuF05Pu25XeKjLM503/QzHR1gsWKGsd699ta/0boDnBk
 8AhLmzwQ+ddP11PJXPnn40tH9szTc0VeoHuf/65xfchzg1p/OncVdiapa9HDvlnOiKXz
 PTztz6GnP1d7NdN5kJHmsOQUho72U7cP/xaf0pw62eTzEHrQbBuPyBNWw+RTxPquG387
 74fZpFQ418O+0a2IL7KFWdWOr6l40AbKPJygS8LOiZNiMXYvBfP92ZtC4yG1mhTKPwUm
 IKUzDMQBzfjU3JUuLIydPeQ9d6cru2qCe+ZvpiCuGqjIl4EpNM/0ecfQ+++R4LeZVLOg
 WMLA==
X-Forwarded-Encrypted: i=1;
 AL+hErHxm6AI2DXOxI8b8yoBmi+LwUb0g7lDUhJJwoB8LlWI98I4pPDME5mUeo8Qz44gOEe+NyXXppza2Nw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9IHK6zZl4FXq3Ou2qHrQdOhTfzbtgSAlcbswygoBjx7fisDVId
 qHAa5vr6FCrzzvM44LNIhHh32X1G+WYgPdTQHKvd+uOGDERt6sorh8FtHDikkcCH+Z3fs1pEwGu
 /BcdhuB+I16qpncJbNH8jBHBoMr6yy1M=
X-Gm-Gg: AZFdTZfRJYw2w0bMWppHZ1HoRaXXsASRw8oZp55e9A3s2KyLmmG7NfUXHEy8ckZG3QC
 gZ1MPHbTsmuSbAFpCiu9px5uPkbt0YQrmenA473haF57HJze2yUb3bDcT4Z9LaItW+D8uH0azlk
 B33YT4spstyPvFmVMeAHBBsZkwaPiq4022HKjIiTIdX2yrGIxL+CZ9h3fv1BWcI1yqUe8+a7uUd
 CDpc5YG9e3GaEm2qhivz1DdavYU0+ybJZj9tFi0787fxIAXpN02qVATHsjIvx19veTxfJ6KMy7X
 tSNfKl0xz97wzgTUsPHPUzCscxCQe9rapyM5lMKe3OSFUi6SZn6fCKu/XIKlIY6iHpIiN/ErBwL
 /qF+CZV+urohXu2/pp5U/vyIMle4rNSViryY3E7sd7QvWOESCn7+9RKqYSZnuOgkk7+4vtMXuBR
 bToNFaHYJcp9D42+Ve6I1/7Lt+eiofTg==
X-Received: by 2002:a05:693c:6395:20b0:375:6fed:8e71 with SMTP id
 5a478bee46e88-384b3986edamr24820513eec.7.1795785672262; Fri, 27 Nov 2026
 05:21:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122081820.53199-1-clamor95@gmail.com>
 <XPGRUNopQCaIq1yDhISpSg@nvidia.com>
 <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
 <QEeSnm4uTjq24quMQBzlfQ@nvidia.com>
In-Reply-To: <QEeSnm4uTjq24quMQBzlfQ@nvidia.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 27 Nov 2026 15:21:00 +0200
X-Gm-Features: Aa3M54q49lQTvJf3rTm0bm2TUGaSnY3ikhfCBwYj5e-cBK25rEq9w8C0KAb2mko
Message-ID: <CAPVz0n2xxEG5vR4X_dZeyQfN9TVSCBn+2uW1wY7Z+P3N8BhNqQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14:3=
5 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Friday, November 27, 2026 6:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
08:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > Parameterize configuration based on bus flags passed from the bridg=
e or
> > > > panel. The list of supported flags includes now pixel clock polarit=
y,
> > > > display enable (DE) polarity, and data alignment.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++++=
----
> > > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rg=
b.c
> > > > index d48d498068ac8..faecd6f94359f 100644
> > > > --- a/drivers/gpu/drm/tegra/rgb.c
> > > > +++ b/drivers/gpu/drm/tegra/rgb.c
> > > > @@ -5,6 +5,7 @@
> > > >   */
> > > >
> > > >  #include <linux/clk.h>
> > > > +#include <linux/media-bus-format.h>
> > > >  #include <linux/of.h>
> > > >
> > > >  #include <drm/drm_atomic_helper.h>
> > > > @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct drm=
_encoder *encoder,
> > > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > > >       struct drm_connector_state *conn_state;
> > > > +     struct drm_bridge_state *bridge_state;
> > > >       struct drm_crtc_state *crtc_state;
> > > >       struct drm_connector *connector;
> > > >       struct drm_display_mode *mode;
> > > > @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct d=
rm_encoder *encoder,
> > > >       crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_stat=
e->crtc);
> > > >       mode =3D &crtc_state->adjusted_mode;
> > > >
> > > > +     /* Get but flags from the bridge state. */
> > >
> > > s/but/bus/
> > >
> > > > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, outpu=
t->bridge);
> > > > +     if (bridge_state)
> > > > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > > > +     else
> > > > +             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > > > +                         DRM_BUS_FLAG_DE_HIGH |
> > > > +                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> > > > +
> > > >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enabl=
e));
> > > >
> > > >       value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS);
> > > >
> > > > -     /* configure H- and V-sync signal polarities */
> > > > +     /* configure H- and V-sync and pixel clock signal polarities =
*/
> > > >       value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(=
1));
> > > >
> > > >       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > > > @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct d=
rm_encoder *encoder,
> > > >       else
> > > >               value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> > > >
> > > > +     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> > > > +             value &=3D ~BIT(PIN_LSC0);
> > > > +     else
> > > > +             value |=3D BIT(PIN_LSC0);
> > >
> > > I think this is the wrong way around: SAMPLE_POSEDGE means that the
> > > pixel data is sampled on a rising edge. That is, it should be driven =
on
> > > the low edge so it's ready for sampling in time for the rising edge.
> > >
> > > LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly, 1)
> > > corresponds to a data transition on the falling edge, i.e. sampling o=
n
> > > the rising edge.
> > >
> > > Section 31.9.6 states this a bit more clearly: "an active low pixel
> > > clock means that the data changes on the falling edge of the clock, t=
o
> > > be latched on the rising edge".
> > >
> >
> > DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE =3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGE=
DGE
> >
> > Should I replace with DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE?
>
> No -- with the current code, let's say
> DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE is set. I.e. the panel tells us that
> it will be sampling pixel data on the positive (rising) edge.
>
> LSC0_OUTPUT_POLARITY will be set to 0. The TRM documents the value 0 as
> "active high", and "means that rising edge coincides with data
> transition". That is, the display controller will change the output pin
> state to color data on the rising edge. So the SoC pins will change
> state at the rising edge, and the panel will sample at the rising edge.
>
> But the pins will take some time to take their new values, so this might
> not work or could be unreliable depending on all kinds of timing
> factors. So if the panel is sampling as the rising edge, the SoC should
> be driving the pins at the falling edge, that way there is time for the
> pins to settle before the panel samples them.
>
> So the value written to LSC0_OUTPUT_POLARITY should be the opposite of
> what it's now. If that breaks the panel, either it's reporting the
> incorrect DRM_BUS_FLAG_PIXDATA_SAMPLE_* value or something else is
> incorrect.
>

This may/will cause regressions across multiple panels and devices.

> >
> > > > +
> > > >       tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(1)=
);
> > > >
> > > > -     /* XXX: parameterize? */
> > > > -     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
> > > > -             DISP_ORDER_RED_BLUE;
> > > > +     /* configure DE signal polarities */
> > > > +     value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARITY(=
3));
> > > > +
> > > > +     if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> > > > +             value |=3D BIT(PIN_LSPI);
> > > > +     else
> > > > +             value &=3D ~BIT(PIN_LSPI);
> > > > +
> > > > +     tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(3)=
);
> > > > +
> > > > +     /* configure DATA order and alignment */
> > > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > > +
> > > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > > +     else
> > > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> > >
> > > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check
> > > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/M=
SB
> > > bit ordering in a classical way, instead:
> > >
> > >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> > >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> > >               R[7:2], G[7:2], B[7:2]};
> > >
> > >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> > >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> > >
> > > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > > panels depending on the layout. So the correct value depends on how t=
he
> > > panel is wired to the SoC on the board. Hence, I think we should
> > > describe this with a new property in device tree under rgb/dbi or
> > > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > > document that this means the above kind of wiring - not all RGB888
> > > panels use it.
> > >
> >
> > Ugh, why is this so confusing...
> >
> > > > +
> > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTRO=
L);
> > > >
> > > >       tegra_dc_commit(rgb->dc);
> > > > --
> > > > 2.53.0
> > > >
>
>
>
>
