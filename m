Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB221090233
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C810610E086;
	Thu, 19 Mar 2026 14:40:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="iLHMnU5V";
	dkim-atps=neutral
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E0F10E900;
 Thu, 19 Mar 2026 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773931254; x=1774190454;
 bh=2ry14m7uPfswpHvhZSiuWQzbmbQ/crOXJDMqiWlZEZg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=iLHMnU5V0lCGv1dm4w9hsRcN0+zxQwdHU3QFBGjxAYwLsKbpRUd8YQcytc85zgwRJ
 L+gHYyDuDFYXml8X64fwWsZmvZKaS+lNjLYyAij8Xumg/9/QbFVSKqG63ub9dCMXWq
 Pr5pxfEY1iQhZ5rJTJejvniXjk2tkw1dSkb4OEPxtL+kb3PbrMeO1PFifOswtNmcxS
 XeJKlOyl/7sHKLVg7sSid5tqFkv88A+cTy/TIUHn/skbxRR53mwoTOCclCz1I/iXb6
 5vSh3TOTUsTNu7eh/WQ16ZZvn1p3BNHmgJuAdWEB4iOIAG0Hbj2uivAVUgUilT657L
 ycLOHvKHzEIZA==
Date: Thu, 19 Mar 2026 14:40:48 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
In-Reply-To: <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 6a9b462a04febf44f134204d15bf2f50d0035867
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

On Thursday, March 19th, 2026 at 10:13 AM, Neil Armstrong <neil.armstrong@l=
inaro.org> wrote:

> Hi,
>=20
> On 3/19/26 12:58, Alexander Koskovich wrote:
> > Using bits_per_component * 3 as the divisor for the compressed INTF
> > timing width produces constant FIFO errors for the BOE BF068MWM-TD0
> > panel due to bits_per_component being 10 which results in a divisor
> > of 30 instead of 24.
> >
> > Regardless of the compression ratio and pixel depth, 24 bits of
> > compressed data are transferred per pclk, so the divisor should
> > always be 24.
>=20
> Not true with widebus, specify why 24 and because DSI widebus is not impl=
emented yet.
>=20
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/dri=
vers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > index 0ba777bda253..5419ef0be137 100644
> > --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
> > @@ -122,19 +122,18 @@ static void drm_mode_to_intf_timing_params(
> >   =09}
> >
> >   =09/*
> > -=09 * for DSI, if compression is enabled, then divide the horizonal ac=
tive
> > -=09 * timing parameters by compression ratio. bits of 3 components(R/G=
/B)
> > -=09 * is compressed into bits of 1 pixel.
> > +=09 * For DSI, if DSC is enabled, 24 bits of compressed data are
> > +=09 * transferred per pclk regardless of the source pixel depth.
> >   =09 */
> >   =09if (phys_enc->hw_intf->cap->type !=3D INTF_DP && timing->compressi=
on_en) {
> >   =09=09struct drm_dsc_config *dsc =3D
> >   =09=09       dpu_encoder_get_dsc_config(phys_enc->parent);
> > +
> Drop this change
>=20
> >   =09=09/*
> >   =09=09 * TODO: replace drm_dsc_get_bpp_int with logic to handle
> >   =09=09 * fractional part if there is fraction
> >   =09=09 */
> > -=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) /
> > -=09=09=09=09(dsc->bits_per_component * 3);
> > +=09=09timing->width =3D timing->width * drm_dsc_get_bpp_int(dsc) / 24;
>=20
> It would be helpful to somehow show that 24 is 8 * 3, 8 being the byte wi=
dth and 3 the compression ratio.

Can you clarify what the 3 represents? My panel should have a 3.75:1 compre=
ssion
ratio (30/8) so the final divisor of 24 would be wrong for my panel if its =
the
compression ratio?

>=20
> >   =09=09timing->xres =3D timing->width;
> >   =09}
> >   }
> >
>=20
>=20
>=20

Thanks,
Alex
