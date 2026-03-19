Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A161075283
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDDD10E923;
	Thu, 19 Mar 2026 09:25:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="f6g4aQyj";
	dkim-atps=neutral
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch
 [185.70.43.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF1210E923
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773912314; x=1774171514;
 bh=1WJ0SXstxMz3JRJWYQZyv5yCYZe13YrJMFbVRqUBtuI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=f6g4aQyjsbyon0TVKTK6hRFU7/YzyFKxyRRqyCChYFJ9XeZixlXm8eSn4eLetRLaZ
 wCirfkFmHsxz+lVUZw8jneWIh9bQNkMLHtaIn3U+qZASEENXy54kd+wiqnvBsAvWdG
 EI1sh4H7fX/fskcyjbx1Xo1gdvmyNl+QhGTY5DE7rMlySVzYJAwo+VZfBkPk7mGj+M
 AMO6HlYERLDcDazD4owO0fjojX099rxSiKwshX0qlD6WWJTZWjbUwRZLldAoU+gh8b
 +36FahD1zK677U0A1mhtE5tax0ucggNcZ9q6Q92+KoVhBstuKsuFrgfmcphBiMk7W1
 fedcTGbcBisyQ==
Date: Thu, 19 Mar 2026 09:25:08 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
Subject: Re: [PATCH v2 2/3] drm/msm/dsi: Add support for RGB101010 pixel format
Message-ID: <pGJabrbuMx_tCkcjrvUESbgwgvwGXDQYJ3czHFEWSDDVv8ugukIWOchF7uV8D1Ns1WI4O9OKDBeKdOW4I83uD7ZfwX58k0EpxHwVVgcnSIU=@pm.me>
In-Reply-To: <5b79ccbd-5c75-454b-8b3f-812a6c59157b@oss.qualcomm.com>
References: <20260318-dsi-rgb101010-support-v2-0-698b7612eaeb@pm.me>
 <20260318-dsi-rgb101010-support-v2-2-698b7612eaeb@pm.me>
 <5b79ccbd-5c75-454b-8b3f-812a6c59157b@oss.qualcomm.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: cf393307f1ff1ef280b98573057ef3190670fbf1
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

On Thursday, March 19th, 2026 at 5:10 AM, Konrad Dybcio <konrad.dybcio@oss.=
qualcomm.com> wrote:

> On 3/19/26 5:00 AM, Alexander Koskovich wrote:
> > Add video and command mode destination format mappings for RGB101010,
> > and extend the VID_CFG0 DST_FORMAT bitfield to 3 bits to accommodate
> > the new format value.
> >
> > Make sure this is guarded behind MSM_DSI_6G_VER >=3D V2.1.0 as anything
> > older does not support this.
> >
> > Required for 10 bit panels such as the BOE BF068MWM-TD0.
> >
> > Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
> > ---
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.c             | 8 ++++++++
> >  drivers/gpu/drm/msm/dsi/dsi_cfg.h             | 1 +
> >  drivers/gpu/drm/msm/dsi/dsi_host.c            | 9 +++++++++
> >  drivers/gpu/drm/msm/registers/display/dsi.xml | 5 ++++-
> >  4 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/ds=
i/dsi_cfg.c
> > index bd3c51c350e7..6a7ea2183a3b 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> > @@ -133,6 +133,7 @@ static const struct msm_dsi_config msm8998_dsi_cfg =
=3D {
> >  =09.io_start =3D {
> >  =09=09{ 0xc994000, 0xc996000 },
> >  =09},
> > +=09.has_rgb30 =3D true,
>=20
> I wrote a patch to determine this at runtime, and only after I was done, =
I
> noticed that we can already achieve this:
>=20
> bool msm_dsi_host_is_wide_bus_enabled(struct mipi_dsi_host *host)
> {
> =09struct msm_dsi_host *msm_host =3D to_msm_dsi_host(host);
>=20
> =09return msm_host->dsc &&
> =09=09(msm_host->cfg_hnd->major =3D=3D MSM_DSI_VER_MAJOR_6G &&
> =09=09 msm_host->cfg_hnd->minor >=3D MSM_DSI_6G_VER_MINOR_V2_5_0);
> }
>=20
> let's perhaps extract this to a msm_dsi_host_version_is_gt(u32 major, u32=
 minor)
> or similar

That's what I was looking into initially, but V2_2_0 (0x20000000) is numeri=
cally less than V2_1_0 (0x20010000) so didn't think I could do that.

Do you know if msm8998 is correct? Downstream says it is 2.0 not 2.2.=20

>=20
> and your assumption about >=3Dv2.1 is corroborated by a doc I have
>=20
> Konrad
>=20

Thanks,
Alex
