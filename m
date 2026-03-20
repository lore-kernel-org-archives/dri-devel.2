Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8651098783
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F35BD10EAF7;
	Fri, 20 Mar 2026 13:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="eh6ftGeC";
	dkim-atps=neutral
Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch
 [79.135.106.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C767E10EAF5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1774012730; x=1774271930;
 bh=L+RYU5Awoi88xADCO5KONFOAwA1IRVD7DZ8uuZNypIc=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=eh6ftGeC5chEVxJBe+/3xQE/if7WjUSCeg/3mAmrN8gJJ5x+6y4dfRbL02tn6WmuL
 5NBI5+jfwhwwJBsE9CkQOI4mmdhmGxRjdUd4r5A+O6KaEDpAnB15tOgpC5wzY9NCMV
 ffMYRU/jR6NA/laCADImOfD0/5ex7hLQv0MgEUpondjp7m1JpCdip7FPsz6sr7ZEX2
 Qu88tQcmOUWfOrg9wqfS8JGZHEN9bsbXS+PebZPl7lVX7X20H5aNozWgrdGh5BS3VB
 PJAMAYcwHQTmE+EqTXPI2PmvR8H2OC28tkLHGFUfSZZcqB+61fmSBLABXt5xfwichM
 PeDFgTXOHKotw==
Date: Fri, 20 Mar 2026 13:18:44 +0000
To: Pengyu Luo <mitltlatltl@gmail.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 jeffrey.l.hugo@gmail.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
Message-ID: <ZPf83Rxo54mgr4un9o9CNu9rXp4-8cQ8jkYIfHZODIzbJXEMISRS2PZKYqDCijOAq1N2eq0Wnt-kS0ys9KV0uB5TawUQLNjNcSzfQeUWe10=@pm.me>
In-Reply-To: <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
References: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
 <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
 <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 98c4ebea40feaa728b7e8c1b654babb38ba4c093
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

On Friday, March 20th, 2026 at 8:20 AM, Pengyu Luo <mitltlatltl@gmail.com> =
wrote:

> On Fri, Mar 20, 2026 at 8:14=E2=80=AFPM Alexander Koskovich <akoskovich@p=
m.me> wrote:
> >
> > On Friday, March 20th, 2026 at 8:08 AM, Pengyu Luo <mitltlatltl@gmail.c=
om> wrote:
> >
> > > On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <akoskovi=
ch@pm.me> wrote:
> > > > >
> > > > > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <dmitry.=
baryshkov@oss.qualcomm.com> wrote:
> > > > >
> > > > > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich w=
rote:
> > > > > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich <=
akoskovich@pm.me> wrote:
> > > > > > >
> > > > > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <d=
mitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > >
> > > > > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Kosko=
vich wrote:
> > > > > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek=
 <jonathan@marek.ca> wrote:
> > > > > > > > > >
> > > > > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan =
Marek wrote:
> > > > > > > > > > > ...
> > > > > > > > > > > >>
> > > > > > > > > > > >> That's not how it works. INTF (which feeds DSI) is=
 after DSC compression.
> > > > > > > > > > > >>
> > > > > > > > > > > >> INTF timings are always in RGB888 (24-bit) units. =
Ignoring widebus details,
> > > > > > > > > > > >> the INTF timing should match what is programmed on=
 the DSI side (hdisplay,
> > > > > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > > > > >>
> > > > > > > > > > > >> (fwiw, the current "timing->width =3D ..." calcula=
tion here blames to me, but
> > > > > > > > > > > >> what I wrote originally was just "timing->width =
=3D timing->width / 3" with a
> > > > > > > > > > > >> comment about being incomplete.)
> > > > > > > > > > > >>
> > > > > > > > > > > > Okay. After reading the docs (sorry, it took a whil=
e).
> > > > > > > > > > > >
> > > > > > > > > > > > - When widebus is not enabled, the transfer is alwa=
ys 24 bit of
> > > > > > > > > > > >    compressed data. Thus if it is not in play, pclk=
 and timing->width
> > > > > > > > > > > >    should be scaled by source_pixel_depth / compres=
sion_ratio / 24. In
> > > > > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc)=
 / 24'.
> > > > > > > > > > > >
> > > > > > > > > > > >    For RGB101010 / 8bpp DSC this should result in t=
he PCLK being lowered
> > > > > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > > > > >
> > > > > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), th=
e transfer takes
> > > > > > > > > > > >    more than 24 bits. In this case the PCLK and tim=
ing->width should be
> > > > > > > > > > > >    scaled exactly by the DSC compression ratio, whi=
ch is
> > > > > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_c=
omponent).
> > > > > > > > > > > >
> > > > > > > > > > > > So, this piece of code needs to be adjusted to chec=
k for the widebus
> > > > > > > > > > > > being enabled or not.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The widebus adjustment on the MDP/INTF side is alread=
y in
> > > > > > > > > > > dpu_hw_intf_setup_timing_engine: the "data width" is =
divided by 2 for
> > > > > > > > > > > 48-bit widebus instead of 24-bit. there shouldn't be =
any other
> > > > > > > > > > > adjustment (downstream doesn't have any other adjustm=
ent).
> > > > > > > > > > >
> > > > > > > > > > > a relevant downstream comment: "In DATABUS-WIDEN mode=
, MDP always sends
> > > > > > > > > > > out 48-bit compressed data per pclk and on average, D=
SI consumes an
> > > > > > > > > > > amount of compressed data equivalent to the uncompres=
sed pixel depth per
> > > > > > > > > > > pclk."
> > > > > > > > > > >
> > > > > > > > > > > Based on that comment, this patch is correct, and the
> > > > > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_compo=
nent)' adjustment
> > > > > > > > > > > only applies to DSI.
> > > > > > > > > >
> > > > > > > > > > If I keep the INTF side at /24 and change the DSI side =
to:
> > > > > > > > > >
> > > > > > > > > > if (wide_bus)
> > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * =
drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > > > > else
> > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * =
drm_dsc_get_bpp_int(dsc), 24);
> > > > > > > > >
> > > > > > > > > Please check the actual fps (I'm usually using a vblank-s=
ynced GL, e.g.
> > > > > > > > > kmscube).
> > > > > > > > >
> > > > > > > > > At least this matches my expectations.
> > > > > > > >
> > > > > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS wi=
th 30. So I guess that's a no go
> > > > > > >
> > > > > > > Although it was using dsc->bits_per_component * 3 regardless =
before for
> > > > > > > dsi_adjust_pclk_for_compression so I guess that's what Jonath=
an was
> > > > > > > referring to earlier...
> > > > > >
> > > > > > Do you have any of the patches by Marijn or Pengyu?
> > > > > >
> > > > > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regres=
ses-again-v1-1-6a422141eeea@somainline.org/
> > > > > >
> > > > > > - https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1=
-mitltlatltl@gmail.com/
> > > > >
> > > > > Nope, I can test with them though if you'd like
> > > >
> > > > Tested the following 3 patches on top of this series:
> > > > drm/msm/dsi: fix hdisplay calculation when programming dsi register=
s
> > > > drm/msm/dsi: fix bits_per_pclk
> > > > drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> > > >
> > > > Getting constant FIFO errors with them applied:
> > > > [   64.851635] dsi_err_worker: status=3D4
> > > > [   64.851692] dsi_err_worker: status=3D4
> > > > [   64.851730] dsi_err_worker: status=3D4
> > > > [   64.851766] dsi_err_worker: status=3D4
> > > > [   64.851802] dsi_err_worker: status=3D4
> > > > [   64.851837] dsi_err_worker: status=3D4
> > > > [   64.851903] dsi_err_worker: status=3D4
> > > > [   64.851940] dsi_err_worker: status=3D4
> > > > [   64.851976] dsi_err_worker: status=3D4
> > > > [   64.852011] dsi_err_worker: status=3D4
> > >
> > > Personally, I use
> > > timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_int(ds=
c),
> > >                          dsc->bits_per_component * 3);
> > >
> > > DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.
> > >
> > > This works for 8-bit dst bpc with 10-bit src bpc.
> >
> > Did a quick test with that (plus the 3 changes listed above), still get=
ting the
> > FIFO errors and no display.
> >
> > Are you using RGB101010?
> >
>=20
> RGB101010(dst bpp) downstream, my panel supports RGB101010, and I can
> use RGB888 for it too.
> I am testing rgb101010.
> BTW, have you dumped registers? compared with downstream.
>=20
> I hardcode
> display_data_hctl =3D (0xbe << 16) | hsync_data_start_x;
> in dpu_hw_intf.c
> downstream uses 0xbe for data_width

Can you try this series with ac47870fd ("drm/msm/dsi: fix hdisplay calculat=
ion when programming dsi registers") reverted and with the following 2 chan=
ges?

https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040da5cc0=
77567363
https://github.com/AKoskovich/linux/commit/e334675c0caf47956a838e2eafda22fb=
689a967d


>=20
> Best wishes,
> Pengyu
> > >
> > > Best wishes,
> > > Pengyu
> > >
> >
> > Thanks,
> > Alex
>=20
> 
