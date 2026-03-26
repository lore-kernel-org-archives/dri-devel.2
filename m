Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2153710A1E68
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8C310E2B6;
	Thu, 26 Mar 2026 11:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Ovm76Wwz";
	dkim-atps=neutral
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DE410E265
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:16:32 +0000 (UTC)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-38a2f196cbaso6447921fa.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774523790; cv=none;
 d=google.com; s=arc-20240605;
 b=fVgsRxkbwkO9F2aAWPkPUxvq2ZrLMDuXwLIEKg70TD7Jjd8cWVFq0QPqXknKm9JiLr
 rAzMF1UklR+hSDYbY3QkDh2QQFJHhws3sAdhdL68QgZkPeayX3DY6VAXf8NXNvT2tWdB
 pV8NIvFBpxDojL3Ru/BDgfPSs8m+VP7qudyFaUCPVZoXN7K5pKIkZvL+2T7hy7AgQTL0
 jwgOtjUGxQu0RK16WMNMQ3ergCSF90fmk+kT6J5lCJJMk7SGtz3IPUK9yAHGHCMldXun
 tsLD42EBjlXpCJrN48DRPTEl6RFpwBLdjtXkdlFW4gXqDXI0FrcGaZRyZ0n4zf/F8TwW
 dpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6rf/HnBT4sVRvVngZaBiBN8W+WY+3EMKSNCjcGGlMVE=;
 fh=djJfviAdE4VYVNaV4Q561gaSTJELYJJ0ZhcxOhhQzJ0=;
 b=LFvQRPdLpo+xntriOzBS5ZHu5CasTCZQ6KEQfi+DumYLmSN76FnSKQXdJpGWX0zKcz
 50t2ak47FR5wvR3FNDeyV4YCNHUKZcMdsIl+jZGL+aosbyjB9RKh3PnbAZy2zk6SbpXP
 sbdRB7kpOIG4U9nWeF0b3vSeJf065+BXC4QerdUc9QXwx4380vsqSYFAEgjwhQbFblu/
 89lw/V9uwmjoJACtjUaDsaxyeYNthl/EGedxW0UKtEPGmA4zw93LWFyR7yVuemzZTo27
 Wxz2DreT+JqrKXzIh4Y9fCwA55nlajRwmQYo0phdVlEHa4d3RZAXmJ/RCywdFWLEHz1r
 8OPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1774523790; x=1775128590;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6rf/HnBT4sVRvVngZaBiBN8W+WY+3EMKSNCjcGGlMVE=;
 b=Ovm76Wwz8lmOccgPVHFDPFFXp2LgeiL6Wa06PLQ/jpXJDyvUi1+l4KFIzw2l0hk7Tb
 cAJatZePUpbYSkuIESzO1dKA1POWe67brI9Fl65bMkgORFPkrvwuotlpxWk/5n3sBMlU
 oI03ru9EpBoX2IC7HKE/OEne8urdZI9SUln6xcLXQYEMvyqKehNBHxR6Zwu426xqS2pU
 IQXmX6tn9yeBBCyVGSWSTasD8HCtJSfXTIslEjyZ5sv2N0c9IbDa6OctNdBrgc6aZG8I
 xPZTfvHXjtg1ntRgavGmYHOynnBjd8ZipY5NuJQC0P6ZNk5+AmlUr1qB5Jkw35sswH2M
 +e5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774523790; x=1775128590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6rf/HnBT4sVRvVngZaBiBN8W+WY+3EMKSNCjcGGlMVE=;
 b=KC96Ewztz/qEFXDMAfIpf3C+gJRM7By3crqF7GwFpv06bL1LHcpulwjalNIzdkJ59l
 J8iqM1iJ2bpWm1Dpd3nuuLXLK/Df9QoNqYSwORT7Zi4F+e80QKKUEMrCHsSUW1pjk2nK
 nsUR5KSHAia0nBplj1g+0h7dWXiGzod+6D55QmGePzfrURbSk7buj0JWkwors9Bpt//s
 BmeznTlSizLutog9Or5+8KQPXMaTJii1jHlae3yAcxk2pgliB8M17+h59T9/CfHT36+2
 YyVaYmsz3bFj8umHQ0mNqNl9CKmEOr9rIb8ReIRpvug/YWKObqGjtqoxweYjo4Q+AKg5
 8Brw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUvZ5fHbtBILJWHkS/xEXi5ytq4OxqirFmaaRxyVfnGFnyRHDPWe3OZ9bMrNN+sMJ7+8tgVPmwT3o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKTfTndh6Nwk7N4Cl5Un5uA4X4oNSUj/Iy4ImH46veZPwmkN3r
 8AaxnfjfeHbB3H8ndbgS61R/VBOOHW+/RlkgiQNtnT4e1Xb77HhopBYbPfOeEtEGOTpZJKDDM1/
 AHwrPTsuxzsN3Oo5wrt3bfVEYdrVSotvzS5vC6ptUWA==
X-Gm-Gg: ATEYQzxtC1fJjUtJg7KotQULqSB57Fgw3KkR3pIzw+Ac235jbTGs74hu96Ha9yhQhT+
 CsXBvbfxr3ritEJVkrM6z5qSgcs020u6f0YvZPqR08++1JDCWkgA7l32tEe/5WjTyB3A7Y6xzXA
 kSmK7+ea6ZJv+oEhLNLfOsZKl54UFYckQZJNvH/50cYFlS3uNPDMjaEgJmkN22GJSvWJ8CtFBJ0
 cN7rJAF6ia4Wshqz19RhF9JxwD2W4UDAOQOyD6rqZ6LCSEH9NJJzV52TpDqE2+mOvuTG7n4xURI
 wEQEtebG7M9xthzAFZmFNl4z8QAYGaaL23ej7Qw=
X-Received: by 2002:a05:6512:b8b:b0:5a1:2fa5:b98f with SMTP id
 2adb3069b0e04-5a29b9959c1mr3477197e87.26.1774523790279; Thu, 26 Mar 2026
 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
 <20260324-color-format-v11-3-605559af4fb4@collabora.com>
 <CAPY8ntB9f_=f5kru=8w9BpTuqQR+93maGpT61EKU28Uay2vq8Q@mail.gmail.com>
 <acPmcMbUvzWMzC-Q@intel.com>
In-Reply-To: <acPmcMbUvzWMzC-Q@intel.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 26 Mar 2026 11:16:12 +0000
X-Gm-Features: AQROBzDGajsKgoOGqGR1Gk-yLiqzdDdCXpeNLW8nQJu3ooxAvN__EfhXfmKn6Bk
Message-ID: <CAPY8ntCRPgN_ayHMGXFv9OrJrdyakUcUT0rvgY5J=FvdCFb6eA@mail.gmail.com>
Subject: Re: [PATCH v11 03/22] drm: Add new general DRM property "color format"
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Werner Sembach <wse@tuxedocomputers.com>, Andri Yngvason <andri@yngvason.is>, 
 Marius Vlad <marius.vlad@collabora.com>
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

On Wed, 25 Mar 2026 at 13:43, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Wed, Mar 25, 2026 at 12:49:19PM +0000, Dave Stevenson wrote:
> > On Tue, 24 Mar 2026 at 16:02, Nicolas Frattaroli
> > <nicolas.frattaroli@collabora.com> wrote:
> > >
> > > Add a new general DRM property named "color format" which can be used=
 by
> > > userspace to request the display driver to output a particular color
> > > format.
> > >
> > > Possible options are:
> > >     - auto (setup by default, driver internally picks the color forma=
t)
> > >     - rgb
> > >     - ycbcr444
> > >     - ycbcr422
> > >     - ycbcr420
> > >
> > > Drivers should advertise from this list which formats they support.
> > > Together with this list and EDID data from the sink we should be able
> > > to relay a list of usable color formats to users to pick from.
> > >
> > > Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > Co-developed-by: Andri Yngvason <andri@yngvason.is>
> > > Signed-off-by: Andri Yngvason <andri@yngvason.is>
> > > Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c |   5 ++
> > >  drivers/gpu/drm/drm_atomic_uapi.c   |  11 ++++
> > >  drivers/gpu/drm/drm_connector.c     | 108 ++++++++++++++++++++++++++=
++++++++++
> > >  include/drm/drm_connector.h         | 104 ++++++++++++++++++++++++++=
++++++++
> > >  4 files changed, 228 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/dr=
m_atomic_helper.c
> > > index 26953ed6b53e..b7753454b777 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -737,6 +737,11 @@ drm_atomic_helper_check_modeset(struct drm_devic=
e *dev,
> > >                         if (old_connector_state->max_requested_bpc !=
=3D
> > >                             new_connector_state->max_requested_bpc)
> > >                                 new_crtc_state->connectors_changed =
=3D true;
> > > +
> > > +                       if (old_connector_state->color_format !=3D
> > > +                           new_connector_state->color_format)
> > > +                               new_crtc_state->connectors_changed =
=3D true;
> > > +
> > >                 }
> > >
> > >                 if (funcs->atomic_check)
> > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_=
atomic_uapi.c
> > > index 5bd5bf6661df..dee510c85e59 100644
> > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > @@ -935,6 +935,15 @@ static int drm_atomic_connector_set_property(str=
uct drm_connector *connector,
> > >                 state->privacy_screen_sw_state =3D val;
> > >         } else if (property =3D=3D connector->broadcast_rgb_property)=
 {
> > >                 state->hdmi.broadcast_rgb =3D val;
> > > +       } else if (property =3D=3D connector->color_format_property) =
{
> > > +               if (val > INT_MAX || !drm_connector_color_format_vali=
d(val)) {
> > > +                       drm_dbg_atomic(connector->dev,
> > > +                                      "[CONNECTOR:%d:%s] unknown col=
or format %llu\n",
> > > +                                      connector->base.id, connector-=
>name, val);
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > > +               state->color_format =3D val;
> > >         } else if (connector->funcs->atomic_set_property) {
> > >                 return connector->funcs->atomic_set_property(connecto=
r,
> > >                                 state, property, val);
> > > @@ -1020,6 +1029,8 @@ drm_atomic_connector_get_property(struct drm_co=
nnector *connector,
> > >                 *val =3D state->privacy_screen_sw_state;
> > >         } else if (property =3D=3D connector->broadcast_rgb_property)=
 {
> > >                 *val =3D state->hdmi.broadcast_rgb;
> > > +       } else if (property =3D=3D connector->color_format_property) =
{
> > > +               *val =3D state->color_format;
> > >         } else if (connector->funcs->atomic_get_property) {
> > >                 return connector->funcs->atomic_get_property(connecto=
r,
> > >                                 state, property, val);
> > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_co=
nnector.c
> > > index 47dc53c4a738..e848374dee0b 100644
> > > --- a/drivers/gpu/drm/drm_connector.c
> > > +++ b/drivers/gpu/drm/drm_connector.c
> > > @@ -1388,6 +1388,18 @@ static const u32 hdmi_colorspaces =3D
> > >         BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65) |
> > >         BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER);
> > >
> > > +static const u32 hdmi_colorformats =3D
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
> > > +
> > > +static const u32 dp_colorformats =3D
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
> > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
> > > +
> > >  /*
> > >   * As per DP 1.4a spec, 2.2.5.7.5 VSC SDP Payload for Pixel Encoding=
/Colorimetry
> > >   * Format Table 2-120
> > > @@ -2940,6 +2952,102 @@ int drm_connector_attach_colorspace_property(=
struct drm_connector *connector)
> > >  }
> > >  EXPORT_SYMBOL(drm_connector_attach_colorspace_property);
> > >
> > > +/**
> > > + * drm_connector_attach_color_format_property - create and attach co=
lor format property
> > > + * @connector: connector to create the color format property on
> > > + * @supported_color_formats: bitmask of bit-shifted &enum drm_output=
_color_format
> > > + *                           values the connector supports
> > > + *
> > > + * Called by a driver to create a color format property. The propert=
y is
> > > + * attached to the connector automatically on success.
> > > + *
> > > + * @supported_color_formats should only include color formats the co=
nnector
> > > + * type can actually support.
> > > + *
> > > + * Returns:
> > > + * 0 on success, negative errno on error
> > > + */
> > > +int drm_connector_attach_color_format_property(struct drm_connector =
*connector,
> > > +                                              unsigned long supporte=
d_color_formats)
> > > +{
> > > +       struct drm_device *dev =3D connector->dev;
> > > +       struct drm_prop_enum_list enum_list[DRM_CONNECTOR_COLOR_FORMA=
T_COUNT];
> > > +       unsigned int i =3D 0;
> > > +       unsigned long fmt;
> > > +
> > > +       if (connector->color_format_property)
> > > +               return 0;
> > > +
> > > +       if (!supported_color_formats) {
> > > +               drm_err(dev, "No supported color formats provided on =
[CONNECTOR:%d:%s]\n",
> > > +                       connector->base.id, connector->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (supported_color_formats & ~GENMASK(DRM_OUTPUT_COLOR_FORMA=
T_COUNT - 1, 0)) {
> > > +               drm_err(dev, "Unknown color formats provided on [CONN=
ECTOR:%d:%s]\n",
> > > +                       connector->base.id, connector->name);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       switch (connector->connector_type) {
> > > +       case DRM_MODE_CONNECTOR_HDMIA:
> > > +       case DRM_MODE_CONNECTOR_HDMIB:
> > > +               if (supported_color_formats & ~hdmi_colorformats) {
> > > +                       drm_err(dev, "Color formats not allowed for H=
DMI on [CONNECTOR:%d:%s]\n",
> > > +                               connector->base.id, connector->name);
> > > +                       return -EINVAL;
> > > +               }
> > > +               break;
> > > +       case DRM_MODE_CONNECTOR_DisplayPort:
> > > +       case DRM_MODE_CONNECTOR_eDP:
> > > +               if (supported_color_formats & ~dp_colorformats) {
> > > +                       drm_err(dev, "Color formats not allowed for D=
P on [CONNECTOR:%d:%s]\n",
> > > +                               connector->base.id, connector->name);
> > > +                       return -EINVAL;
> > > +               }
> > > +               break;
> > > +       }
> > > +
> > > +       enum_list[0].name =3D "AUTO";
> > > +       enum_list[0].type =3D DRM_CONNECTOR_COLOR_FORMAT_AUTO;
> > > +
> > > +       for_each_set_bit(fmt, &supported_color_formats, DRM_OUTPUT_CO=
LOR_FORMAT_COUNT) {
> > > +               switch (fmt) {
> > > +               case DRM_OUTPUT_COLOR_FORMAT_RGB444:
> > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COLOR_F=
ORMAT_RGB444;
> > > +                       break;
> > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
> > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COLOR_F=
ORMAT_YCBCR444;
> > > +                       break;
> > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
> > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COLOR_F=
ORMAT_YCBCR422;
> > > +                       break;
> > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
> > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COLOR_F=
ORMAT_YCBCR420;
> > > +                       break;
> > > +               default:
> > > +                       drm_warn(dev, "Unknown supported format %ld o=
n [CONNECTOR:%d:%s]\n",
> > > +                                fmt, connector->base.id, connector->=
name);
> > > +                       continue;
> > > +               }
> > > +               enum_list[i].name =3D drm_hdmi_connector_get_output_f=
ormat_name(fmt);
> > > +       }
> > > +
> > > +       connector->color_format_property =3D
> > > +               drm_property_create_enum(dev, DRM_MODE_PROP_ENUM, "co=
lor format",
> > > +                                        enum_list, i + 1);
> > > +
> > > +       if (!connector->color_format_property)
> > > +               return -ENOMEM;
> > > +
> > > +       drm_object_attach_property(&connector->base, connector->color=
_format_property,
> > > +                                  DRM_CONNECTOR_COLOR_FORMAT_AUTO);
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_connector_attach_color_format_property);
> > > +
> > >  /**
> > >   * drm_connector_atomic_hdr_metadata_equal - checks if the hdr metad=
ata changed
> > >   * @old_state: old connector state to compare
> > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.=
h
> > > index af8b92d2d5b7..bd549f912b76 100644
> > > --- a/include/drm/drm_connector.h
> > > +++ b/include/drm/drm_connector.h
> > > @@ -571,14 +571,102 @@ enum drm_colorspace {
> > >   *   YCbCr 4:2:2 output format (ie. with horizontal subsampling)
> > >   * @DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
> > >   *   YCbCr 4:2:0 output format (ie. with horizontal and vertical sub=
sampling)
> > > + * @DRM_OUTPUT_COLOR_FORMAT_COUNT:
> > > + *   Number of valid output color format values in this enum
> > >   */
> > >  enum drm_output_color_format {
> > >         DRM_OUTPUT_COLOR_FORMAT_RGB444 =3D 0,
> > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR444,
> > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR422,
> > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR420,
> > > +       DRM_OUTPUT_COLOR_FORMAT_COUNT,
> > >  };
> > >
> > > +/**
> > > + * enum drm_connector_color_format - Connector Color Format Request
> > > + *
> > > + * This enum, unlike &enum drm_output_color_format, is used to speci=
fy requests
> > > + * for a specific color format on a connector through the DRM "color=
 format"
> > > + * property. The difference is that it has an "AUTO" value to specif=
y that
> > > + * no specific choice has been made.
> > > + */
> > > +enum drm_connector_color_format {
> > > +       /**
> > > +        * @DRM_CONNECTOR_COLOR_FORMAT_AUTO: The driver or display pr=
otocol
> > > +        * helpers should pick a suitable color format. All implement=
ations of a
> > > +        * specific display protocol must behave the same way with "A=
UTO", but
> > > +        * different display protocols do not necessarily have the sa=
me "AUTO"
> > > +        * semantics.
> > > +        *
> > > +        * For HDMI, "AUTO" picks RGB, but falls back to YCbCr 4:2:0 =
if the
> > > +        * bandwidth required for full-scale RGB is not available, or=
 the mode
> > > +        * is YCbCr 4:2:0-only, as long as the mode and output both s=
upport
> > > +        * YCbCr 4:2:0.
> >
> > Is there a reason you propose dropping back to YCbCr 4:2:0 without
> > trying YCbCr 4:2:2 first? Minimising the subsampling is surely
> > beneficial, and vc4 for one can do 4:2:2 but not 4:2:0.
>
> On HDMI 4:2:2 is always 12bpc, so it doesn't save any bandwidth
> compared to 8bpc 4:4:4.

It does save bandwidth against 10 or 12bpc RGB 4:4:4.

Or is the implication that max_bpc =3D 12 and
DRM_CONNECTOR_COLOR_FORMAT_AUTO should drop bpc down to 8 and select
RGB in preference to selecting 4:2:2?

  Dave

> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
