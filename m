Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A6921075279
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6849F10E918;
	Thu, 19 Mar 2026 08:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="FsvMUTa9";
	dkim-atps=neutral
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch
 [79.135.106.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8E310E91B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773910136; x=1774169336;
 bh=xQkPUw1mSmsM6MIztEk9nnAmAVj7xnLqQCcm6uV1Xvw=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FsvMUTa9yVtuGdpHx1g11rU4jqfX6YatvalUWhnYVe/5+H2jMtFOGY2vsLcTH/UU/
 jaq4HPsj1fnAh0XAc38Aozm7g+bNovJO1KSAftK4Fa7sRzzEuQ+u4jJwhUm8L+0kvn
 D1U3IlFnBe6PoMPgU3372fDRQfddxEXGKuFknNT184w+LoMiQ8uZzc6PiyHb/NK/8N
 lIHR90E2KbtC2xPDEn/6+L8dubtyyK+qJdK5B1Hef67usZbGvDbn17tobpLrS3mOdJ
 zRF3UCdjtKwu+vftuYmlWfwnVVdwd+SDOgOcBXE90ut8n2MDbgBBDK55JCokSOvu50
 tfE18H5bbyqDA==
Date: Thu, 19 Mar 2026 08:48:49 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v2 3/3] drm/msm/dpu: fix video mode DSC INTF timing width
 for non 8 bit panels
Message-ID: <_varXMigTiaLa1CVxsqWY0wJNnR8xZGw5lAS8MmyxrVAjHPK1Mu-H-heiIMxB9SdcJoEhjUDUtUo8dZvTi_GsQwYKsuGnc1tsFlSDqoKfA0=@pm.me>
In-Reply-To: <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-3-698b7612eaeb@pm.me>
 <c9d14a74-8e59-43bb-827b-577c8f675c8f@linaro.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 3c9530b4d1d1d19f77d6923b49521aa7090290b3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Thursday, March 19th, 2026 at 4:35 AM, Neil Armstrong <neil.armstrong@li=
naro.org> wrote:

> On 3/19/26 05:00, Alexander Koskovich wrote:
> > Using bits_per_component * 3 as the divisor for the compressed INTF
> > timing width produces constant FIFO errors for panels such as the BOE
> > BF068MWM-TD0 which is a 10 bit panel.
> >
> > The downstream driver calculates the compressed timing width by
> > dividing the total compressed bytes per line by 3 which does not depend
> > on bits_per_component. Switch the divisor to 24 to match downstream.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 12 +++++++----=
-
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/dri=
vers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index 0ba777bda253..9b046a0e77aa 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -122,19 +122,21 @@ static void drm_mode_to_intf_timing_params(
> >   =09}
> >
> >   =09/*
> > -=09 * for DSI, if compression is enabled, then divide the horizonal ac=
tive
> > -=09 * timing parameters by compression ratio. bits of 3 components(R/G=
/B)
> > -=09 * is compressed into bits of 1 pixel.
> > +=09 * For DSI, if DSC is enabled, use a fixed divisor of 24 rather tha=
n
> > +=09 * bits_per_component * 3 when calculating the compressed timing wi=
dth.
> > +=09 *
> > +=09 * This matches the downstream driver and is required for panels wi=
th
> > +=09 * bits_per_component !=3D 8.
> >   =09 */
> >   =09if (phys_enc->hw_intf->cap->type !=3D INTF_DP && timing->compressi=
on_en) {
> >   =09=09struct drm_dsc_config *dsc =3D
> >   =09=09       dpu_encoder_get_dsc_config(phys_enc->parent);
> > +
> >   =09=09/*
> >   =09=09 * TODO: replace drm_dsc_get_bpp_int with logic to handle
> >   =09=09 * fractional part if there is fraction
> >   =09=09 */
> > -=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) /
> > -=09=09=09=09(dsc->bits_per_component * 3);
> > +=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>=20
>=20
>=20
> @bits_per_component: Bits per component to code (8/10/12) <=3D how the DS=
C pixels are encoded in the stream
> @bits_per_pixel: Target bits per pixel with 4 fractional bits, bits_per_p=
ixel << 4 <=3D the target display pixels
>=20
> - bits_per_component is the transport width
> - bits_per_pixel is the display width
> - 3 is the DSC compression ratio
>=20
> So for a RGB101010 DSC display bits_per_pixel should be 10 << 4
>=20
> But here you say bits_per_component should be 8 ? can you share the downs=
tream config of your panel ?

This is what is defined downstream for this panel, they're using 8:
https://github.com/NothingOSS/android_kernel_msm-6.1_nothing_sm7635/blob/sm=
7635/b/mr/vendor/qcom/proprietary/display-devicetree/display/dsi-panel-rm69=
220-dsc-fhd-plus-120hz-vid-boe.dtsi

>=20
> Are you sure about the bits_per_component & bits_per_pixel values you set=
 in the dsc parameters ?

I'm pretty sure they're correct, here's the panel driver I have atm:
https://github.com/AKoskovich/linux/blob/asteroids-6.19.y/drivers/gpu/drm/p=
anel/panel-boe-bf068mwm-td0.c

>=20
> Neil
>=20
>=20
> >   =09=09timing->xres =3D timing->width;
> >   =09}
> >   }
> >
>=20
>=20

Thanks,
Alex
