Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A35010A62DD
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B55210E9D5;
	Thu, 26 Mar 2026 13:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="VWIz5Dqu";
	dkim-atps=neutral
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com
 [209.85.128.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E9E10E8D4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:39:23 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-79a3ba1653fso9869827b3.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532362; cv=none;
 d=google.com; s=arc-20240605;
 b=SQn6MbYu2WeRD4N+tnVjJP5H6qFbnGrBMgoUyEH0EfiZTcgYCkFX2j9YHV3s0aYwFP
 lCClVnnMgFwEEdrr4BaH3qNateQkOzZxyojJhfZZP8OtainLg60CH3Y8kk84+072OZuz
 oV+Hj3Y16lSpIsmrP+Wjh2OSixW/CWo4dhncTn1Mso263H3DJXzke7WFFokuTCzpeciA
 a/l+eZsBmgoSlYrHJmpfr2DucbkgHPzWcUUc38AKQP6fxAopYsZ9mgmD4teb5Z/LgiDw
 DLY4FZKrwbvGap8OI4M1TRh1JwLLNgtO+H3S2Di9hQz4q/MVq5vSiX5oA/LVXB+wVfnY
 GSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IWnlq3YY7P2VGUr2BUkZ+fGGbSx856WYxcxWvnN8cGU=;
 fh=BhIjPUTMBOmZNzH/3I+vAXUeTfz3WUjiI6HYPVjf3u4=;
 b=ch0QvGzmt/JFABPcoxNbIpP/nHUMpXWAtcEDOTlV+v5XzlSwGUeFjD1F6c/yR3kizl
 q03znt3NjOgz2PIJx4Yc7CRh5hcWI48Ix7y5VCpgFIoDtBzmb2boXTLH/tuXWJk/SOz7
 daCGwi5zNwha6f/+3xjLexAM7/dN/VsHhKZPRZYygN7Uxs11SPCKUGi7hKpHub9UkXMP
 rmSYxhp3Pufjgy77ElRQssfjrS6ta3lCHoYCtr46WLu+PRvtcDTMYJ34ZnV8+DrvWwjX
 qVA1lV6HwXVrRNQjE/NneG6m8wt6gU+LyAa6FkUEdxbQfHFso32ormmFcJ5tXAq2dbTq
 KbPQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1774532362; x=1775137162;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWnlq3YY7P2VGUr2BUkZ+fGGbSx856WYxcxWvnN8cGU=;
 b=VWIz5DquPpxhvNQuBRF/KNB4nghz+Cev85IkmYO5/WFT7MLWzCMNSumzaCHCTtCfUw
 x7jIul9/nTLfi6aqhhg1XB+q+Zge8+AKQhK3Jsm1x1kNNnP2rFPQhGnM6mtoalkwXTFV
 qbFkJDUI4DtNKa6kGER0ibAl1s7z0YIlAnvPdGkqRsif/TWyROieIlORnS/uIPpr05O0
 6obJjLScx89MG3L6b167FfnIutyc6daJYSzsNlkrbka2/CtdSYAa7glspCf4NvGujwaM
 V5AtNZSJuCDLuhGI6kEjNTxcfP4VuRnRVN09JIlkOtSL+ITShRlaN1er1Cljs8PJdJrR
 fV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532362; x=1775137162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IWnlq3YY7P2VGUr2BUkZ+fGGbSx856WYxcxWvnN8cGU=;
 b=AAAtaWvRNP/iaNEgulseLR5QPLAXgXlHvu91+Y1+amI8nQqoJw4qeuVoemj7SWSsKX
 H76Lt+cz5ZQ4oCDf76+cIAHmw/dT+tmei8X/Adw7nFLlr7r+W3oRtKFyWxVo32pMqRjJ
 E2NNh1Ni7aKKB00SLSXeFSsfGZHC6tqTrQtOdwAVFElT/4wytioe1iB4ly0lKDwRpw20
 xh4cOqVsWg3QIjD3ikdOrz2SldWctLwLL+/H+0kxLpAiZa6AkP9dUV12fkbvb3BYXVom
 T/YQA9eVFU1K5xRrssoC5Z59EuMLEdBziFI/boz5qzINshYRCH/9Jn9hWVCe0akE4iX/
 AcXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW4fI0a/I2y6gyxshVS1AaksHoAkjfS7ZnT2lDXGssiA3+qKY8Y6MbKqCuWXd3AhfBiD2l5zYbwvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8i8D6moDWqNyaUAi52S+du2hNr6CnG8T841C7LKd2PYFqy5WZ
 dmmbv9ajVmhdEdXyOpBaO05meh8AQ/d89nb9fE8nJa/vmCbdrOntdTBItriQMSWScRkBurNUktU
 HPlAOCS1XlpMVsXBicNr0r0zvPEORLl9m/jwP/Ics2Q==
X-Gm-Gg: ATEYQzwTFBUIb3bl3Auo7wkg0CCJhYeb5sXS6NsJNUoSrJmxs5ajPMGomUMKlI+LYpl
 VpOr0IbbFUE7g8KQFrJxLlk8jzGIp4owk+EkHju3e6xU2ZaABHtYXvcePz76aouet3obggv5oMZ
 b+0kTMJ7D25Q++Q8ata5I8WnWcW7qCgZ1R5p0MLvobyLGyAn4dS7vGNKvmigNdRzfw54532uBLQ
 5ePLleKw+xHW7zg0TiPIf3TCz3/SR/n0eHbCspqQ5x9/SF9oFV3MbGJiA82mez55tg1w4zd/VwX
 7fBsfYqmZWvhjUPszmS12S9o19+5/ZiN+VjosgU=
X-Received: by 2002:a05:690c:6086:b0:799:1d0a:aca8 with SMTP id
 00721157ae682-79acf391fcamr83445117b3.19.1774532361939; Thu, 26 Mar 2026
 06:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260324-color-format-v11-0-605559af4fb4@collabora.com>
 <20260324-color-format-v11-3-605559af4fb4@collabora.com>
 <CAPY8ntB9f_=f5kru=8w9BpTuqQR+93maGpT61EKU28Uay2vq8Q@mail.gmail.com>
 <acPmcMbUvzWMzC-Q@intel.com>
 <CAPY8ntCRPgN_ayHMGXFv9OrJrdyakUcUT0rvgY5J=FvdCFb6eA@mail.gmail.com>
 <acUi6NEPJ0p48a3U@intel.com>
In-Reply-To: <acUi6NEPJ0p48a3U@intel.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 26 Mar 2026 13:39:04 +0000
X-Gm-Features: AQROBzC-fzB7pltEtFba3kfrVDmyhycx0P3xOtZmVXy7A1SvRy2ZJPGwTUQXf-A
Message-ID: <CAPY8ntDZ30NWmYaptMQzOuXPoi8wzEObzAL=oqhxuq8jSvv2mQ@mail.gmail.com>
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

On Thu, 26 Mar 2026 at 12:13, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 11:16:12AM +0000, Dave Stevenson wrote:
> > On Wed, 25 Mar 2026 at 13:43, Ville Syrj=C3=A4l=C3=A4
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 12:49:19PM +0000, Dave Stevenson wrote:
> > > > On Tue, 24 Mar 2026 at 16:02, Nicolas Frattaroli
> > > > <nicolas.frattaroli@collabora.com> wrote:
> > > > >
> > > > > Add a new general DRM property named "color format" which can be =
used by
> > > > > userspace to request the display driver to output a particular co=
lor
> > > > > format.
> > > > >
> > > > > Possible options are:
> > > > >     - auto (setup by default, driver internally picks the color f=
ormat)
> > > > >     - rgb
> > > > >     - ycbcr444
> > > > >     - ycbcr422
> > > > >     - ycbcr420
> > > > >
> > > > > Drivers should advertise from this list which formats they suppor=
t.
> > > > > Together with this list and EDID data from the sink we should be =
able
> > > > > to relay a list of usable color formats to users to pick from.
> > > > >
> > > > > Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> > > > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > > > Co-developed-by: Andri Yngvason <andri@yngvason.is>
> > > > > Signed-off-by: Andri Yngvason <andri@yngvason.is>
> > > > > Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> > > > > Reviewed-by: Maxime Ripard <mripard@kernel.org>
> > > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.c=
om>
> > > > > ---
> > > > >  drivers/gpu/drm/drm_atomic_helper.c |   5 ++
> > > > >  drivers/gpu/drm/drm_atomic_uapi.c   |  11 ++++
> > > > >  drivers/gpu/drm/drm_connector.c     | 108 ++++++++++++++++++++++=
++++++++++++++
> > > > >  include/drm/drm_connector.h         | 104 ++++++++++++++++++++++=
++++++++++++
> > > > >  4 files changed, 228 insertions(+)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/dr=
m/drm_atomic_helper.c
> > > > > index 26953ed6b53e..b7753454b777 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > > > @@ -737,6 +737,11 @@ drm_atomic_helper_check_modeset(struct drm_d=
evice *dev,
> > > > >                         if (old_connector_state->max_requested_bp=
c !=3D
> > > > >                             new_connector_state->max_requested_bp=
c)
> > > > >                                 new_crtc_state->connectors_change=
d =3D true;
> > > > > +
> > > > > +                       if (old_connector_state->color_format !=
=3D
> > > > > +                           new_connector_state->color_format)
> > > > > +                               new_crtc_state->connectors_change=
d =3D true;
> > > > > +
> > > > >                 }
> > > > >
> > > > >                 if (funcs->atomic_check)
> > > > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/=
drm_atomic_uapi.c
> > > > > index 5bd5bf6661df..dee510c85e59 100644
> > > > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > > > @@ -935,6 +935,15 @@ static int drm_atomic_connector_set_property=
(struct drm_connector *connector,
> > > > >                 state->privacy_screen_sw_state =3D val;
> > > > >         } else if (property =3D=3D connector->broadcast_rgb_prope=
rty) {
> > > > >                 state->hdmi.broadcast_rgb =3D val;
> > > > > +       } else if (property =3D=3D connector->color_format_proper=
ty) {
> > > > > +               if (val > INT_MAX || !drm_connector_color_format_=
valid(val)) {
> > > > > +                       drm_dbg_atomic(connector->dev,
> > > > > +                                      "[CONNECTOR:%d:%s] unknown=
 color format %llu\n",
> > > > > +                                      connector->base.id, connec=
tor->name, val);
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > > > +
> > > > > +               state->color_format =3D val;
> > > > >         } else if (connector->funcs->atomic_set_property) {
> > > > >                 return connector->funcs->atomic_set_property(conn=
ector,
> > > > >                                 state, property, val);
> > > > > @@ -1020,6 +1029,8 @@ drm_atomic_connector_get_property(struct dr=
m_connector *connector,
> > > > >                 *val =3D state->privacy_screen_sw_state;
> > > > >         } else if (property =3D=3D connector->broadcast_rgb_prope=
rty) {
> > > > >                 *val =3D state->hdmi.broadcast_rgb;
> > > > > +       } else if (property =3D=3D connector->color_format_proper=
ty) {
> > > > > +               *val =3D state->color_format;
> > > > >         } else if (connector->funcs->atomic_get_property) {
> > > > >                 return connector->funcs->atomic_get_property(conn=
ector,
> > > > >                                 state, property, val);
> > > > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/dr=
m_connector.c
> > > > > index 47dc53c4a738..e848374dee0b 100644
> > > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > > @@ -1388,6 +1388,18 @@ static const u32 hdmi_colorspaces =3D
> > > > >         BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65) |
> > > > >         BIT(DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER);
> > > > >
> > > > > +static const u32 hdmi_colorformats =3D
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
> > > > > +
> > > > > +static const u32 dp_colorformats =3D
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
> > > > > +       BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
> > > > > +
> > > > >  /*
> > > > >   * As per DP 1.4a spec, 2.2.5.7.5 VSC SDP Payload for Pixel Enco=
ding/Colorimetry
> > > > >   * Format Table 2-120
> > > > > @@ -2940,6 +2952,102 @@ int drm_connector_attach_colorspace_prope=
rty(struct drm_connector *connector)
> > > > >  }
> > > > >  EXPORT_SYMBOL(drm_connector_attach_colorspace_property);
> > > > >
> > > > > +/**
> > > > > + * drm_connector_attach_color_format_property - create and attac=
h color format property
> > > > > + * @connector: connector to create the color format property on
> > > > > + * @supported_color_formats: bitmask of bit-shifted &enum drm_ou=
tput_color_format
> > > > > + *                           values the connector supports
> > > > > + *
> > > > > + * Called by a driver to create a color format property. The pro=
perty is
> > > > > + * attached to the connector automatically on success.
> > > > > + *
> > > > > + * @supported_color_formats should only include color formats th=
e connector
> > > > > + * type can actually support.
> > > > > + *
> > > > > + * Returns:
> > > > > + * 0 on success, negative errno on error
> > > > > + */
> > > > > +int drm_connector_attach_color_format_property(struct drm_connec=
tor *connector,
> > > > > +                                              unsigned long supp=
orted_color_formats)
> > > > > +{
> > > > > +       struct drm_device *dev =3D connector->dev;
> > > > > +       struct drm_prop_enum_list enum_list[DRM_CONNECTOR_COLOR_F=
ORMAT_COUNT];
> > > > > +       unsigned int i =3D 0;
> > > > > +       unsigned long fmt;
> > > > > +
> > > > > +       if (connector->color_format_property)
> > > > > +               return 0;
> > > > > +
> > > > > +       if (!supported_color_formats) {
> > > > > +               drm_err(dev, "No supported color formats provided=
 on [CONNECTOR:%d:%s]\n",
> > > > > +                       connector->base.id, connector->name);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       if (supported_color_formats & ~GENMASK(DRM_OUTPUT_COLOR_F=
ORMAT_COUNT - 1, 0)) {
> > > > > +               drm_err(dev, "Unknown color formats provided on [=
CONNECTOR:%d:%s]\n",
> > > > > +                       connector->base.id, connector->name);
> > > > > +               return -EINVAL;
> > > > > +       }
> > > > > +
> > > > > +       switch (connector->connector_type) {
> > > > > +       case DRM_MODE_CONNECTOR_HDMIA:
> > > > > +       case DRM_MODE_CONNECTOR_HDMIB:
> > > > > +               if (supported_color_formats & ~hdmi_colorformats)=
 {
> > > > > +                       drm_err(dev, "Color formats not allowed f=
or HDMI on [CONNECTOR:%d:%s]\n",
> > > > > +                               connector->base.id, connector->na=
me);
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > > > +               break;
> > > > > +       case DRM_MODE_CONNECTOR_DisplayPort:
> > > > > +       case DRM_MODE_CONNECTOR_eDP:
> > > > > +               if (supported_color_formats & ~dp_colorformats) {
> > > > > +                       drm_err(dev, "Color formats not allowed f=
or DP on [CONNECTOR:%d:%s]\n",
> > > > > +                               connector->base.id, connector->na=
me);
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       enum_list[0].name =3D "AUTO";
> > > > > +       enum_list[0].type =3D DRM_CONNECTOR_COLOR_FORMAT_AUTO;
> > > > > +
> > > > > +       for_each_set_bit(fmt, &supported_color_formats, DRM_OUTPU=
T_COLOR_FORMAT_COUNT) {
> > > > > +               switch (fmt) {
> > > > > +               case DRM_OUTPUT_COLOR_FORMAT_RGB444:
> > > > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COL=
OR_FORMAT_RGB444;
> > > > > +                       break;
> > > > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
> > > > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COL=
OR_FORMAT_YCBCR444;
> > > > > +                       break;
> > > > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
> > > > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COL=
OR_FORMAT_YCBCR422;
> > > > > +                       break;
> > > > > +               case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
> > > > > +                       enum_list[++i].type =3D DRM_CONNECTOR_COL=
OR_FORMAT_YCBCR420;
> > > > > +                       break;
> > > > > +               default:
> > > > > +                       drm_warn(dev, "Unknown supported format %=
ld on [CONNECTOR:%d:%s]\n",
> > > > > +                                fmt, connector->base.id, connect=
or->name);
> > > > > +                       continue;
> > > > > +               }
> > > > > +               enum_list[i].name =3D drm_hdmi_connector_get_outp=
ut_format_name(fmt);
> > > > > +       }
> > > > > +
> > > > > +       connector->color_format_property =3D
> > > > > +               drm_property_create_enum(dev, DRM_MODE_PROP_ENUM,=
 "color format",
> > > > > +                                        enum_list, i + 1);
> > > > > +
> > > > > +       if (!connector->color_format_property)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       drm_object_attach_property(&connector->base, connector->c=
olor_format_property,
> > > > > +                                  DRM_CONNECTOR_COLOR_FORMAT_AUT=
O);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_connector_attach_color_format_property);
> > > > > +
> > > > >  /**
> > > > >   * drm_connector_atomic_hdr_metadata_equal - checks if the hdr m=
etadata changed
> > > > >   * @old_state: old connector state to compare
> > > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connec=
tor.h
> > > > > index af8b92d2d5b7..bd549f912b76 100644
> > > > > --- a/include/drm/drm_connector.h
> > > > > +++ b/include/drm/drm_connector.h
> > > > > @@ -571,14 +571,102 @@ enum drm_colorspace {
> > > > >   *   YCbCr 4:2:2 output format (ie. with horizontal subsampling)
> > > > >   * @DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
> > > > >   *   YCbCr 4:2:0 output format (ie. with horizontal and vertical=
 subsampling)
> > > > > + * @DRM_OUTPUT_COLOR_FORMAT_COUNT:
> > > > > + *   Number of valid output color format values in this enum
> > > > >   */
> > > > >  enum drm_output_color_format {
> > > > >         DRM_OUTPUT_COLOR_FORMAT_RGB444 =3D 0,
> > > > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR444,
> > > > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR422,
> > > > >         DRM_OUTPUT_COLOR_FORMAT_YCBCR420,
> > > > > +       DRM_OUTPUT_COLOR_FORMAT_COUNT,
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * enum drm_connector_color_format - Connector Color Format Requ=
est
> > > > > + *
> > > > > + * This enum, unlike &enum drm_output_color_format, is used to s=
pecify requests
> > > > > + * for a specific color format on a connector through the DRM "c=
olor format"
> > > > > + * property. The difference is that it has an "AUTO" value to sp=
ecify that
> > > > > + * no specific choice has been made.
> > > > > + */
> > > > > +enum drm_connector_color_format {
> > > > > +       /**
> > > > > +        * @DRM_CONNECTOR_COLOR_FORMAT_AUTO: The driver or displa=
y protocol
> > > > > +        * helpers should pick a suitable color format. All imple=
mentations of a
> > > > > +        * specific display protocol must behave the same way wit=
h "AUTO", but
> > > > > +        * different display protocols do not necessarily have th=
e same "AUTO"
> > > > > +        * semantics.
> > > > > +        *
> > > > > +        * For HDMI, "AUTO" picks RGB, but falls back to YCbCr 4:=
2:0 if the
> > > > > +        * bandwidth required for full-scale RGB is not available=
, or the mode
> > > > > +        * is YCbCr 4:2:0-only, as long as the mode and output bo=
th support
> > > > > +        * YCbCr 4:2:0.
> > > >
> > > > Is there a reason you propose dropping back to YCbCr 4:2:0 without
> > > > trying YCbCr 4:2:2 first? Minimising the subsampling is surely
> > > > beneficial, and vc4 for one can do 4:2:2 but not 4:2:0.
> > >
> > > On HDMI 4:2:2 is always 12bpc, so it doesn't save any bandwidth
> > > compared to 8bpc 4:4:4.
> >
> > It does save bandwidth against 10 or 12bpc RGB 4:4:4.
> >
> > Or is the implication that max_bpc =3D 12 and
> > DRM_CONNECTOR_COLOR_FORMAT_AUTO should drop bpc down to 8 and select
> > RGB in preference to selecting 4:2:2?
>
> Yeah, YCbCr has all kinds of extra complications compared to RGB, so
> the policy is to use RGB if possible, and only fall back to YCbCr as a
> last resort. And in that case 4:2:0 is the only thing that can help.

So a media player wanting to do 12bpc HDR playback at 4k60 over HDMI
2.0 ends up with 8bpc RGB regardless. That sucks.
I guess at least an override is being added so userspace can take control.

I'd missed that vc4 had its behaviour changed with the
drm_hdmi_state_helper update :-(

  Dave
