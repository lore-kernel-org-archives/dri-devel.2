Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FEB1093182
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 07:48:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DD710E4EC;
	Fri, 20 Mar 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="A5oPqFkt";
	dkim-atps=neutral
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B85710E00D;
 Fri, 20 Mar 2026 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773992876; x=1774252076;
 bh=/ZmLRfVsJAQyzr+0FYDWPnjIHYhTuLVijg0WABRKrKg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=A5oPqFktPVY1vpSaTwZ7fva7ArxaG8ScCz38ggxXxYf9PJ0XBEBWolcWQ2nSBV/oK
 sKYfCX2wtZBeAV9WR9GJTdCfRkCl+4T5UrxrjUPiFmS84aQjQK8uZvmTOE3fG3woil
 UmEoDmFyBAdG9RTNf8LvMxI4z3yRziqw6FwuCtoJJwgaIFBNKa+4LhreWYAA1sPI2g
 wE/CF3wvxZiJHWyx1j41VGb1nAavC637b649tidHyAb43c2iPVezU3QNxuDv83au1u
 vjIKx57nWz00uM1CKSw02yB9ByqGETI/aa4btfK6rVgy2jDIEIXx7FnPwgYNZ9If30
 vGjg6TVozjq3g==
Date: Fri, 20 Mar 2026 07:47:51 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: Jonathan Marek <jonathan@marek.ca>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Message-ID: <LbtagEimreS2mF7RubKMs6Tv0gw7HnkqlhleCglof53bICr7FUqEgwta1rQ6ysgUHF6_BsA9Us2TPGO6m40POMVZ-vKyV4KN8D-S_Hrs-pc=@pm.me>
In-Reply-To: <7o6ddv23aft3eerc7xz7r5rawe24d6vl3qp33ewnqllv5xkfrf@n3dosrwbvlhf>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
 <pVeuxasxaau60kEIgTW1W6DmFLuzLUGYvmYtTN_Cv0htPbokC6lMObfmql3lWkAxtO5Lp-aD2l0Uzt_xL8cGYVxBmDey-5-HA7968eocg8c=@pm.me>
 <a7jukaag6juswudeeuskgzahzbixxn5oq4qjnxfny2oapinfnv@kmn7b33yxric>
 <jv_kU6i1uCSu--2-KIWkgsC0NsVK1yE396Nv_fCFA5v9uR-zrMGhrBmKNnG_ztHPiKPqlcjWif3R-XF1bINB387ezJEKtXDY453253BM6fc=@pm.me>
 <nVcYZQOh7dB65LsiaXejmQP-Cmp-eSxp7fvDiTwS2P5WJc03m4CwXtUP_2w-D2dflxo9rwKPI68FxnfswATouZxK8QhF256JJf3F7BkbmY0=@pm.me>
 <7o6ddv23aft3eerc7xz7r5rawe24d6vl3qp33ewnqllv5xkfrf@n3dosrwbvlhf>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 130e397a9ba129a1af335ef6dffa25084b24a8c9
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


On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <dmitry.baryshkov@=
oss.qualcomm.com> wrote:

> On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich wrote:
> > On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich <akoskovich=
@pm.me> wrote:
> >
> > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <dmitry.bary=
shkov@oss.qualcomm.com> wrote:
> > >
> > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovich wrote=
:
> > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <jonathan=
@marek.ca> wrote:
> > > > >
> > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrot=
e:
> > > > > > ...
> > > > > > >>
> > > > > > >> That's not how it works. INTF (which feeds DSI) is after DSC=
 compression.
> > > > > > >>
> > > > > > >> INTF timings are always in RGB888 (24-bit) units. Ignoring w=
idebus details,
> > > > > > >> the INTF timing should match what is programmed on the DSI s=
ide (hdisplay,
> > > > > > >> which is calculated as bytes per line / 3).
> > > > > > >>
> > > > > > >> (fwiw, the current "timing->width =3D ..." calculation here =
blames to me, but
> > > > > > >> what I wrote originally was just "timing->width =3D timing->=
width / 3" with a
> > > > > > >> comment about being incomplete.)
> > > > > > >>
> > > > > > > Okay. After reading the docs (sorry, it took a while).
> > > > > > >
> > > > > > > - When widebus is not enabled, the transfer is always 24 bit =
of
> > > > > > >    compressed data. Thus if it is not in play, pclk and timin=
g->width
> > > > > > >    should be scaled by source_pixel_depth / compression_ratio=
 / 24. In
> > > > > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > > > > > >
> > > > > > >    For RGB101010 / 8bpp DSC this should result in the PCLK be=
ing lowered
> > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > >
> > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer=
 takes
> > > > > > >    more than 24 bits. In this case the PCLK and timing->width=
 should be
> > > > > > >    scaled exactly by the DSC compression ratio, which is
> > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > > > > > >
> > > > > > > So, this piece of code needs to be adjusted to check for the =
widebus
> > > > > > > being enabled or not.
> > > > > > >
> > > > > >
> > > > > > The widebus adjustment on the MDP/INTF side is already in
> > > > > > dpu_hw_intf_setup_timing_engine: the "data width" is divided by=
 2 for
> > > > > > 48-bit widebus instead of 24-bit. there shouldn't be any other
> > > > > > adjustment (downstream doesn't have any other adjustment).
> > > > > >
> > > > > > a relevant downstream comment: "In DATABUS-WIDEN mode, MDP alwa=
ys sends
> > > > > > out 48-bit compressed data per pclk and on average, DSI consume=
s an
> > > > > > amount of compressed data equivalent to the uncompressed pixel =
depth per
> > > > > > pclk."
> > > > > >
> > > > > > Based on that comment, this patch is correct, and the
> > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adj=
ustment
> > > > > > only applies to DSI.
> > > > >
> > > > > If I keep the INTF side at /24 and change the DSI side to:
> > > > >
> > > > > if (wide_bus)
> > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_ge=
t_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > else
> > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_ge=
t_bpp_int(dsc), 24);
> > > >
> > > > Please check the actual fps (I'm usually using a vblank-synced GL, =
e.g.
> > > > kmscube).
> > > >
> > > > At least this matches my expectations.
> > >
> > > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS with 30. So =
I guess that's a no go
> >
> > Although it was using dsc->bits_per_component * 3 regardless before for
> > dsi_adjust_pclk_for_compression so I guess that's what Jonathan was
> > referring to earlier...
>=20
> Do you have any of the patches by Marijn or Pengyu?
>=20
> - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regresses-again-=
v1-1-6a422141eeea@somainline.org/
>=20
> - https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlatl=
tl@gmail.com/

Nope, I can test with them though if you'd like

>=20
> --
> With best wishes
> Dmitry
> 
