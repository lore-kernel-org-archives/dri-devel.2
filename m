Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D493E109317A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 06:50:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1870710E471;
	Fri, 20 Mar 2026 06:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="PrvdRtLL";
	dkim-atps=neutral
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch
 [79.135.106.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C4D110E038
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1773989423; x=1774248623;
 bh=wxifmS0KDSTX4KALnSQrCzhw3DkVRHJHTqdLp44jAMI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=PrvdRtLLtHNSAJKKJOTIBV+XAQItI1tjlCvKf+oAudt0JhbX/PBQ0lhFg3Qi73SGC
 L2+ENarMhPsEAv+4+Jdhmot7mjIzkLfquDbsVw7qLqKcgCjFahJuqOlfQW1HqyLGXl
 AJc5vyIAUpb1LH84hlBOyCHLfpktCDudf/kVWRhRPDmrvYWtZk3jMbZQRL8xm0qKKg
 o59KGOt++8wGPGqX0YaXO+W6EdQ/gYsvgN1exoDvYgjKC6LQQOq05POll/DZ7+CT1g
 uaG3eQtg2B8K/48kUit481WW0HZJ2LkdAyjzzCgWeCc1PKjFzLUaGK4bH10LMCP2Mu
 RMlWF1YmcKDrA==
Date: Fri, 20 Mar 2026 06:50:16 +0000
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
Message-ID: <jv_kU6i1uCSu--2-KIWkgsC0NsVK1yE396Nv_fCFA5v9uR-zrMGhrBmKNnG_ztHPiKPqlcjWif3R-XF1bINB387ezJEKtXDY453253BM6fc=@pm.me>
In-Reply-To: <a7jukaag6juswudeeuskgzahzbixxn5oq4qjnxfny2oapinfnv@kmn7b33yxric>
References: <20260319-dsi-rgb101010-support-v3-0-85b99df2d090@pm.me>
 <20260319-dsi-rgb101010-support-v3-4-85b99df2d090@pm.me>
 <1360a31d-669e-48df-a1be-f0af4a253cd7@linaro.org>
 <3gLK4s97giqqXagfHKhfiIHbfbl2snwfOj9dcTNGPUYi10w9-1EdATqzz1LPCVTpz4bLFYOm8u_Fl8PfC7t5yabows4UCzRKVwjraEWW6hc=@pm.me>
 <3f8763af-aad2-4d92-90c8-cfd290212503@linaro.org>
 <7fb9dd9d-13f9-7bba-93d1-08f42dd6ee38@marek.ca>
 <oihbfczsj5cg7qfjjt6jvyodjnjbezyrv6f32vmg444g5bx6ow@r54epj7ilsyt>
 <da050aad-381d-ffb7-ec7d-8ed8a80d790a@marek.ca>
 <pVeuxasxaau60kEIgTW1W6DmFLuzLUGYvmYtTN_Cv0htPbokC6lMObfmql3lWkAxtO5Lp-aD2l0Uzt_xL8cGYVxBmDey-5-HA7968eocg8c=@pm.me>
 <a7jukaag6juswudeeuskgzahzbixxn5oq4qjnxfny2oapinfnv@kmn7b33yxric>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: a4c23ee66c2dcc9b5d4b280db9334bac96ba5d60
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

On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <dmitry.baryshkov@=
oss.qualcomm.com> wrote:

> On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovich wrote:
> > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <jonathan@marek=
.ca> wrote:
> >
> > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Marek wrote:
> > > ...
> > > >>
> > > >> That's not how it works. INTF (which feeds DSI) is after DSC compr=
ession.
> > > >>
> > > >> INTF timings are always in RGB888 (24-bit) units. Ignoring widebus=
 details,
> > > >> the INTF timing should match what is programmed on the DSI side (h=
display,
> > > >> which is calculated as bytes per line / 3).
> > > >>
> > > >> (fwiw, the current "timing->width =3D ..." calculation here blames=
 to me, but
> > > >> what I wrote originally was just "timing->width =3D timing->width =
/ 3" with a
> > > >> comment about being incomplete.)
> > > >>
> > > > Okay. After reading the docs (sorry, it took a while).
> > > >
> > > > - When widebus is not enabled, the transfer is always 24 bit of
> > > >    compressed data. Thus if it is not in play, pclk and timing->wid=
th
> > > >    should be scaled by source_pixel_depth / compression_ratio / 24.=
 In
> > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) / 24'.
> > > >
> > > >    For RGB101010 / 8bpp DSC this should result in the PCLK being lo=
wered
> > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > >
> > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the transfer takes
> > > >    more than 24 bits. In this case the PCLK and timing->width shoul=
d be
> > > >    scaled exactly by the DSC compression ratio, which is
> > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component).
> > > >
> > > > So, this piece of code needs to be adjusted to check for the widebu=
s
> > > > being enabled or not.
> > > >
> > >
> > > The widebus adjustment on the MDP/INTF side is already in
> > > dpu_hw_intf_setup_timing_engine: the "data width" is divided by 2 for
> > > 48-bit widebus instead of 24-bit. there shouldn't be any other
> > > adjustment (downstream doesn't have any other adjustment).
> > >
> > > a relevant downstream comment: "In DATABUS-WIDEN mode, MDP always sen=
ds
> > > out 48-bit compressed data per pclk and on average, DSI consumes an
> > > amount of compressed data equivalent to the uncompressed pixel depth =
per
> > > pclk."
> > >
> > > Based on that comment, this patch is correct, and the
> > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_component)' adjustmen=
t
> > > only applies to DSI.
> >
> > If I keep the INTF side at /24 and change the DSI side to:
> >
> > if (wide_bus)
> >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_=
int(dsc), dsc->bits_per_component * 3);
> > else
> >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_=
int(dsc), 24);
>=20
> Please check the actual fps (I'm usually using a vblank-synced GL, e.g.
> kmscube).
>=20
> At least this matches my expectations.

Hmmm with kmscube I am getting 120FPS with 24 and 100FPS with 30. So I gues=
s that's a no go

>=20
> >
> > This also works on my panel.
> >
> > Should I send this in a v4 for this series or just leave it for a seper=
ate
> > change as panel seems to work with /24 here anyways?
> >
> > > (note: newer downstream looks like it would divide
> > > by 3.75 here, which doesn't make sense. older downstream would divide=
 by
> > > 3 here. I guess downstream is broken now and video mode + 10-bit dsc
> > > doesn't get tested?)
> > >
> > > on DSI side, "uncompressed pixel depth" shouldn't matter either: DSI
> > > only sees the compressed data. But based on that comment, when widebu=
s
> > > is enabled, by setting DSI_VID_CFG0_DST_FORMAT(?) to 30bpp, then the =
DSI
> > > pclk is in 30-bit units instead of 24-bits. And with this series DSI
> > > side ends up with the right result if 30bpp format and widebus is ena=
bled.
> > >
> > >
> >
> > Thanks,
> > Alex
>=20
> --
> With best wishes
> Dmitry
> 
