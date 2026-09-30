Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75073CA5FCB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E517310E250;
	Wed, 30 Sep 2026 16:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SVbdFF8d";
	dkim-atps=neutral
Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com
 [74.125.224.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD64A10E250
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 16:10:26 +0000 (UTC)
Received: by mail-yx2-f38.google.com with SMTP id
 00721157ae682-8ac4deda6d5so10021897b3.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 09:10:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790784626; cv=none;
 d=google.com; s=arc-20260327;
 b=OGj9cFhbfLW8LBkKtrCAdVobEI4EGghisRk9zXn/qeGRTWQXZNbn5lg318GiGK8GGs
 H31pdXSiO4/3yPUbib38VJTqNEqqGlUcFZpYZ2SROqqU2f6j9RTxTfpCXebPO4ijBCya
 NVbGtEjKn8UgIUhXmv5jlkuOGrCLSOtVPX9d30Jb9FpUAkMW+/AEZqwokcCOxc25XQz7
 PNnSNFRjn8hNUcw86ym3E4SOGf1hAXnDMidzpJ8LFEn0+AcWPL7YzmvPmvA5yHTb2irx
 Z+XbECiG0YqKV/zB+/rCSLyTSDKupLrXxWU4muHBWQ9TeP67mJAA9bgTZDNdJ+uuFvgN
 KOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iRehZjrfjWyoiGL/7MRfV3/j/MJLZDIiqHOFJW1M59A=;
 fh=61697b8hCTcf1f0X3DX+ukn+Bn5aQV46m0iXpA76PuY=;
 b=mUbbhpYrh40eTDCHVAGqu8+R44fBBuPpy2Ulm+5Z9JQKW4t+bG3BUVEpgRBo/wowX0
 8yJ2eGCLQF0/G8zLZ+Z2tLoEwR95RkT52WMwo6/pKvjsRm02cSXx0wJHGWrO6InO2ban
 GLVGu3TkmS2t22UOQOYKapTd5hCkIozQaPAN5h7fzMTt2BnyPvl1T9eKpOxF6EpoHCcO
 T0ZrbUkpdH6268ex01CinMHTVD4x7uYhqaakLlkH0X4+0ZVtr9G1t0FXtywnjVJYzZXK
 WzShC6ISAo/V+Pm2YIwFnVSC63L0td6qJJ1+pRyPdSaCpVAbXENf1ql08Xz5xXrApj5X
 2fyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790784626; x=1791389426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iRehZjrfjWyoiGL/7MRfV3/j/MJLZDIiqHOFJW1M59A=;
 b=SVbdFF8dmlxh3BqOR9Z4cUuUkRsRR87SmqrBUYI1eDoPftjc4JK3/H+i7hXxqyPh9J
 qoysZAd/ZXUyHC0xgfFDZ/17JLIoFLOC2Nkj+aavVSnO455oHbB0ToWbIRqBgo2nwpPk
 G6sVoNc8C+uOuXxWnMC1/oCmSf3kYcA4GFsv3cSw+e0ZmDrI32ZseatGX9tlCSVgJwSZ
 8C3hj7FLaINnwTbnNUi5b2gxR57/Y0oFt4EQpZrw21B4tRhi1CPfD78O8Fm7JTpRKiTv
 Z5n2ROIuZP1+yXpj3t6d9Fx+3/sN7YDmEY3mXSIsLeaSDKUnYEciXRN6FiW7ra4TxENw
 tSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790784626; x=1791389426;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iRehZjrfjWyoiGL/7MRfV3/j/MJLZDIiqHOFJW1M59A=;
 b=aPhjCrj7ZxO7gEkrO5deMj6v6sEMqTVQhJXJaii7jFRe5mLqEB7DvzP8+Ko3PvQxDL
 SiCfilgpE2W9GVs9JqZAqUMSQiiOqXVAQKu+2WXa3HUcK61KQOnsPMJmNFgmi1jDwFUH
 nREDajmqRcMReb5k3NKB2ctUE1G31p+tPgnCNa9iN7weRLVwTwuRjCT11EYyQgQiHasj
 xskUMXaeceks/qqvj1Bzxxe2nAI2QRaKaU/YHdx8NzY1sw54w1IDYovgrFsBJTi2USCC
 4NUdyEa9OQtdJBQ7PEaIzswDd4MIAzBhuVquMt3ioqjzKOf3ihBR0OB0izAWM6zxGwWM
 Z2Ew==
X-Forwarded-Encrypted: i=1;
 AKwUvBywH89nI31pp5GQOoj4D9fdWLvrXdTYK7qKAfiRUOGnS5+AmWd7ZPIbka9vnLJVnlS2qPpsmnkSj58=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpRTXZ7OWKkpDtAERC5xy7LQs3+XnZvxtjJMCWvrm/8bMN2LtO
 O2FOAhk6wTIa2sg9n5yG3p9CygpCkLwDyFo6K0xbdLEMfBU64h4kqXy3Vq4DaieBk8aadwi3FoK
 Z/qbbwinn89B+T6MGkLU56lqcdEbLXVw/SJZ0mbuiyQ==
X-Gm-Gg: AYBFou2wCPR166WODYBgswcz8nD0oz1nJkha63XB1Lh7htORfrSsxbCTk8rQ+V/9xys
 jLtj8fqXYf8VXzTZDWLwUgfM8alRbFqs98ZuWKWCbfBmhwzLMwbqUiVwXoGcoB8Dm3AlMnmOWNX
 vT/qbh+P6z5DW9cz25QXXfgCBdUZxr5PDwn4umLxFJr/1ZEDMVS07kVPUOIQXp+ps/+6rzTFqP3
 6xg14SL+Ci56kbK6IDuxoFOLaBaE5UJ70a6xBS6B35983SxPHGQuwQLsbWxVNqZ4Pk234Q2KeFV
 N0eD36CLdVxZWwGrsbQk/8iv4MmSGNMB6/z8A0MB7oX99BWH6zJkTT+E9Bsu5wHB
X-Received: by 2002:a05:690c:89:b0:8a9:e801:231c with SMTP id
 00721157ae682-8ac9331841amr6405827b3.20.1790784625575; Wed, 30 Sep 2026
 09:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260727-sm8650-7-1-bonded-dsi-v5-0-c042266b9eeb@linaro.org>
 <20260727-sm8650-7-1-bonded-dsi-v5-4-c042266b9eeb@linaro.org>
 <jwlmzhhgpvbi47lt4biwn4razrvbf2rfi5uyyvfhjomzo7uqyh@ahf4ubqvegst>
In-Reply-To: <jwlmzhhgpvbi47lt4biwn4razrvbf2rfi5uyyvfhjomzo7uqyh@ahf4ubqvegst>
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 1 Oct 2026 00:10:13 +0800
X-Gm-Features: AclHuK-jey2UN0A8sWN4rkcybsqPqgekH6oh4yBkzdH-hTkcWanw8jO2ZFUX2MU
Message-ID: <CABymUCP7DMOqN9j2ZWEtDxWpZSbNWbrYzdJ57crsR03hys67mg@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drm/msm/dsi: Support dual panel use case with
 single CRTC
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
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

Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> =E4=BA=8E2026=E5=B9=B4=
9=E6=9C=8830=E6=97=A5=E5=91=A8=E4=B8=89 00:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 27, 2026 at 04:08:43PM +0800, Jun Nie wrote:
> > Support a hardware configuration where two independent DSI panels are
> > driven by a single, synchronous CRTC. This configuration uses a bonded
> > DSI link to provide a unified vblank for both displays.
> >
> > This allows application software to treat the two displays as a single,
> > wide framebuffer with a synchronized refresh cycle, simplifying renderi=
ng
> > logic for side-by-side panel arrangements.
> >
> > At the DSI host level, the frame width for each link must be that of an
> > individual panel. The driver therefore halves the CRTC's horizontal
> > resolution before configuring the DSI host and any DSC encoders, ensuri=
ng
> > each panel receives the correct half of the framebuffer.
>
> I guess, the flag from the previous patch should be coming from the DT
> node of the DSI host. The DSI should then get the mode from a single
> panel and then set the adjusted_mode for the CRTC (note sure how this
> will work for the compositors though).

The original information comes from the panel. Panel driver exposes
the flag to dsi host. Because the panel driver hides all dual physical
panels stuff and exposes a single panel to DRM framework, so it exposes
the doubled mode to DRM framework level too. This simplifies the
handling of 2 physical panels in DRM level and compositors level.
>
>
> Also please note that the are other possible configurations. For
> example, for some time I've had a setup using two Raspberry panels
> attached to two DSI hosts for exactly the same purpose (please check, I
> think Neil might still have it, or maybe somebody else from the team).
> Each channel is an I2C-controlled DSI-to-DPI bridge + a DPI panel. I
> understand that it's not your target, but it's something to keep in
> mind. I'd say, the bare minimum would be to resolve a second bridge (be
> it a full bridge or a panel bridge), possibly create a second bridge
> chain (remember, bridges don't support branching, so you are a bit on
> your own here) and at least manually call the callbacks. This would
> ensure that the second panel (or a second bridge) is properly controlled
> (and thus would get rid of the second reset GPIO from your patches).

I asked Neil but he has no idea on this. Per your description, you have 2
DRM connectors/bridges for 2 physical panels. I guess you have topology:
1 CRTC + 2*(encoder / connector / bridge). The handling of 2 physical
panels falls into DRM level, not inside panel driver as this patch set.
This 2 methodology does not conflict in theory. Do you see and conflict in
implementation?
>
> > The pic_width is used to calculated DSC parameter for DPU DSC controlle=
r
> >  together with panel's parameter. While panel driver that support dual
> > panel shall provide slice_width parameter of single panel. This patch
> > only impact DSC configuration, so crtc is not aware of it and not impac=
ted
> > by it.
> >
> > While the DSI panel driver should manage two panels togehter.
> > 1. During probe, the driver finds the sibling dsi host via device tree
> > phandle and register the 2nd panel to get another mipi_dsi_device.
> > 2. Set dual_panel flag on both mipi_dsi_device.
> > 3. Prepare DSC data per requirement from single panel.
> > 4. All DSI commands should be send on every DSI link.
>
> broadcasting of DSI commands is controlled by the DT flag.

Do you mean the property, qcom,sync-dual-dsi? It is QCOM specific
feature to send DSI commands twice in host driver. It can be done
in panel side as well. The bonus to do in panel side is that the
panel driver is more generic and can work with other SoC in theory.
And the DSI commands can be handled together with regulators
etc for 2 physical panels in a centric way. The panel driver is
more self-contained, minimizing dependency on the dsi host.

>
> > 5. Handle power supply for 2 panels in one shot, the same is true to
> >    brightness.
> > 6. From the CRTC's perspective, the two panels appear as one wide displ=
ay.
> >    The driver exposes a DRM mode where the horizontal timings (hdisplay=
,
> >    hsync_start, etc.) are doubled, while the vertical timings remain th=
ose
> >    of a single panel. Because 2 panels are expected to be mounted in
> >    left/right position.
> >
> > To maintain synchronization, both DSI links are configured to share a
> > single clock source, with the DSI1 controller using the clock provided
> > to DSI0 as below.
> >
> > &mdss_dsi1 {
> >    assigned-clocks =3D <&dispcc DISP_CC_MDSS_BYTE1_CLK_SRC>,
> >                    <&dispcc DISP_CC_MDSS_PCLK1_CLK_SRC>;
> >    assigned-clock-parents =3D <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
> > }
> >
> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/d=
si/dsi_host.c
> > index e39938fb0f502..a3c56c3dc7904 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -186,6 +186,7 @@ struct msm_dsi_host {
> >       bool registered;
> >       bool power_on;
> >       bool enabled;
> > +     bool is_dual_panel;
> >       int irq;
> >  };
> >
> > @@ -1024,7 +1025,10 @@ static void dsi_timing_setup(struct msm_dsi_host=
 *msm_host, bool is_bonded_dsi)
> >                       return;
> >               }
> >
> > -             dsc->pic_width =3D mode->hdisplay;
> > +             if (msm_host->is_dual_panel)
> > +                     dsc->pic_width =3D hdisplay;
> > +             else
> > +                     dsc->pic_width =3D mode->hdisplay;
> >               dsc->pic_height =3D mode->vdisplay;
> >               DBG("Mode %dx%d\n", dsc->pic_width, dsc->pic_height);
> >
> > @@ -1705,6 +1709,7 @@ static int dsi_host_attach(struct mipi_dsi_host *=
host,
> >       if (dsi->lanes > msm_host->num_data_lanes)
> >               return -EINVAL;
> >
> > +     msm_host->is_dual_panel =3D dsi->dual_panel;
> >       msm_host->channel =3D dsi->channel;
> >       msm_host->lanes =3D dsi->lanes;
> >       msm_host->format =3D dsi->format;
> > @@ -2600,6 +2605,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struc=
t mipi_dsi_host *host,
> >       if (!msm_host->dsc)
> >               return MODE_OK;
> >
> > +     if (msm_host->is_dual_panel)
> > +             pic_width =3D mode->hdisplay / 2;
> > +
> >       if (pic_width % dsc->slice_width) {
> >               pr_err("DSI: pic_width %d has to be multiple of slice %d\=
n",
> >                      pic_width, dsc->slice_width);
> >
> > --
> > 2.43.0
> >
>
> --
> With best wishes
> Dmitry
