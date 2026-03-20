Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2042108B914
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0384110EAF8;
	Fri, 20 Mar 2026 12:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqyTjvHT";
	dkim-atps=neutral
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347B410EAE7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:18:53 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id
 ada2fe7eead31-60278aaa9ddso128765137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 05:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774009132; cv=none;
 d=google.com; s=arc-20240605;
 b=gyG8L1djrZZt1JBckpFvIf7dYrAqyhQVs3gpLVU2Az33JQ9s/f+1P94NqWfNzpqa2v
 uobTzU+WQOQDIsvbPskVBYiNowENjuWnVWOvaAZ2bs/UVeoxASUNSwgqnpq19GoxyB8a
 sv6sKdudt23t3gAy8/p4m9hT0SsfOQMsFuI5SCHBDCLy8fmLzJg8J4YyZX2A2WFhWBad
 CpgtfKJKAi1ma79HD/Pnv1Dof8UJjWTUIwgGNjtPeU2k4EsPCUaLTwiJYZ4plVc3CrEh
 07gBWMVTl1PNLgFIQeX30r4EBclbtws/CIchljYnf5b6C6K5i0JQGuVATxn80JQQAEqB
 erWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9M1XBpPJACJ8r0qgNMAcAJHeDA994mwU5uq6wMMh5Ng=;
 fh=86Nil398GoSVYAlXqsce3VY+yAhpFSJA80WlUyOCsiU=;
 b=Go19+AydGm0kgu+D7aAsWT/99/vt+66uWNy+I09SPp8B2d+Si6PNAV0U1lvQn0T7s0
 js9TVoP8zjiX/g1JLvSJ9A/baRx3B1lXeQU2UBOMxKcYsGSUQORHYdzduMWKCudOeCqH
 CWyfCNSXAL6AF8jMAMIlHDcs14LYjNFOm4/fNXCpJu9o40K55tna4cDGiA5J1jTZKjMs
 F43k1zHHd+ffIN9wy7fNx3WBOLj29YK+KIOg18nmMU3OfB24R+tgD3rBRUAvwjpbTEVe
 iINpnPjFIBIx98tfU+fjoGlKJzcvTznEU3/BaEueYCel+bRhIMqlkAhmYEAJid+38CqP
 tT3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774009132; x=1774613932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9M1XBpPJACJ8r0qgNMAcAJHeDA994mwU5uq6wMMh5Ng=;
 b=nqyTjvHTO2gZDev4HzPCX1Z6I3K3UHgUTKd7pL4aPwfCCpAFtppwf350K20N44VtGY
 l2hxxrwAjdKrRGGBvvlAXPotTEdc2PwtF/j9fTogpyHz7xqV1RJG3n85kgP56r5kxewb
 wAmgtPPlFLDH1OEpI7tq4MqoUdvIdTaS8vHJheS4HAh9cUJDNM3J5HqNAISW8ZWP6r51
 fUUrAccSZUzF8F1Lor56hhlQbUq+WEH45EIkwR0Nme9ODaRx4Rz1gkoW1WKxPdBUklra
 PDzNONvOFkzLSdrcLvdxaKMMnNB3Tzvjf8OqLYD4IFZBf0y0s1K0ynH0yuvU7Rv9+kgZ
 3Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774009132; x=1774613932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9M1XBpPJACJ8r0qgNMAcAJHeDA994mwU5uq6wMMh5Ng=;
 b=mWWGeJ3gTcIBQcx1TAQoB7wG6EQ1Is2enjIWhCU7+pvwN4m4NPmEnA1HCUsOpP1zUE
 X5JF6lCZPQMMmoHtf7q1hJaJAxVf9Jyx0m5W0GkLb+8yZsknRyr6GTNZEAoorltwnKr0
 MqTHiB5IF77xHMNSoEoubtSv4hAv/rKbfTXZ5ddoowooURzSVcQw3t/0NcQWqW6rFE6A
 SF09RIicBX227NQn0NdIiiI5VrZSuGyXeK2F42wEyHeWxlJPsTezv3p52ZiPSXpdMcHY
 RMpYJa+N42Cz8vsO1+0fDee3vDIRzYJPOTtFaHcsA8ASsT4TSKl/f71lzt6fpNJ0Cdw8
 Jqug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Fr7Vcrk1Z+RWXr0EKUxtp49/CQuviq7CqnTCRGYiTBqDjrh1G5yegHdY49i38YMxD6YpxELGnHg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPuphTW6k/EXdhOjtTX/KKgn6+R3IodGRnx2HD3CEaRgZLcXJQ
 ysVbmmWJPme6Ka+mfIyhp5Qi6E5VITcxWsxHacIG2RutrX2I/tq3WXCJ6W+0cXXiVIswTPV6PJb
 bbosScznCqkTWPVNBKIzVVDTY9Dbt/ek=
X-Gm-Gg: ATEYQzwU+SmThOJlbMl2fhQxefP5RTXUb0BWFOSaAmRZclWht0T6lbhHvxP3kUudo8E
 HcMJ8w93alCVmT4wSWZWfQBtKcM28gXNcDY9s1WRyp1H+7dZax3Qrv9Mjk72iPozDsoIdE+N6vi
 8NktR2847WWMUikoA2DLX+ZKnKo+DVUfigfg73UqvgYqOnJascH8dJku3x+5kbxEYW9BIeCMFXT
 +PY3Vfc9BY7AFu/OpolooVYmE2rjQOzLVKq/JxV1J8b8kNzy4V6bpOiVxdV8xg7GuyTI9Q0UwgR
 JJd/9Mkn4DmDqlgNdns=
X-Received: by 2002:a05:6102:3e1b:b0:602:8ccb:c993 with SMTP id
 ada2fe7eead31-602aeca3685mr1117017137.24.1774009131910; Fri, 20 Mar 2026
 05:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
 <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
In-Reply-To: <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 20:18:25 +0800
X-Gm-Features: AaiRm53LTU8wDCJYrqqJ0gCya3PGyhV0RKl3jbpxe7hECfpaOd_OZ97fvpacJVc
Message-ID: <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/msm/dpu: fix video mode DSC INTF timing width
 calculation
To: Alexander Koskovich <akoskovich@pm.me>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, jeffrey.l.hugo@gmail.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, Jonathan Marek <jonathan@marek.ca>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <lumag@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>
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

On Fri, Mar 20, 2026 at 8:14=E2=80=AFPM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
> On Friday, March 20th, 2026 at 8:08 AM, Pengyu Luo <mitltlatltl@gmail.com=
> wrote:
>
> > On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <akoskovich=
@pm.me> wrote:
> > > >
> > > > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <dmitry.ba=
ryshkov@oss.qualcomm.com> wrote:
> > > >
> > > > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich wro=
te:
> > > > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich <ak=
oskovich@pm.me> wrote:
> > > > > >
> > > > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov <dmi=
try.baryshkov@oss.qualcomm.com> wrote:
> > > > > > >
> > > > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Koskovi=
ch wrote:
> > > > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Marek <=
jonathan@marek.ca> wrote:
> > > > > > > > >
> > > > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonathan Ma=
rek wrote:
> > > > > > > > > > ...
> > > > > > > > > > >>
> > > > > > > > > > >> That's not how it works. INTF (which feeds DSI) is a=
fter DSC compression.
> > > > > > > > > > >>
> > > > > > > > > > >> INTF timings are always in RGB888 (24-bit) units. Ig=
noring widebus details,
> > > > > > > > > > >> the INTF timing should match what is programmed on t=
he DSI side (hdisplay,
> > > > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > > > >>
> > > > > > > > > > >> (fwiw, the current "timing->width =3D ..." calculati=
on here blames to me, but
> > > > > > > > > > >> what I wrote originally was just "timing->width =3D =
timing->width / 3" with a
> > > > > > > > > > >> comment about being incomplete.)
> > > > > > > > > > >>
> > > > > > > > > > > Okay. After reading the docs (sorry, it took a while)=
.
> > > > > > > > > > >
> > > > > > > > > > > - When widebus is not enabled, the transfer is always=
 24 bit of
> > > > > > > > > > >    compressed data. Thus if it is not in play, pclk a=
nd timing->width
> > > > > > > > > > >    should be scaled by source_pixel_depth / compressi=
on_ratio / 24. In
> > > > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_int(dsc) /=
 24'.
> > > > > > > > > > >
> > > > > > > > > > >    For RGB101010 / 8bpp DSC this should result in the=
 PCLK being lowered
> > > > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > > > >
> > > > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), the =
transfer takes
> > > > > > > > > > >    more than 24 bits. In this case the PCLK and timin=
g->width should be
> > > > > > > > > > >    scaled exactly by the DSC compression ratio, which=
 is
> > > > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_com=
ponent).
> > > > > > > > > > >
> > > > > > > > > > > So, this piece of code needs to be adjusted to check =
for the widebus
> > > > > > > > > > > being enabled or not.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The widebus adjustment on the MDP/INTF side is already =
in
> > > > > > > > > > dpu_hw_intf_setup_timing_engine: the "data width" is di=
vided by 2 for
> > > > > > > > > > 48-bit widebus instead of 24-bit. there shouldn't be an=
y other
> > > > > > > > > > adjustment (downstream doesn't have any other adjustmen=
t).
> > > > > > > > > >
> > > > > > > > > > a relevant downstream comment: "In DATABUS-WIDEN mode, =
MDP always sends
> > > > > > > > > > out 48-bit compressed data per pclk and on average, DSI=
 consumes an
> > > > > > > > > > amount of compressed data equivalent to the uncompresse=
d pixel depth per
> > > > > > > > > > pclk."
> > > > > > > > > >
> > > > > > > > > > Based on that comment, this patch is correct, and the
> > > > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_compone=
nt)' adjustment
> > > > > > > > > > only applies to DSI.
> > > > > > > > >
> > > > > > > > > If I keep the INTF side at /24 and change the DSI side to=
:
> > > > > > > > >
> > > > > > > > > if (wide_bus)
> > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * dr=
m_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > > > else
> > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * dr=
m_dsc_get_bpp_int(dsc), 24);
> > > > > > > >
> > > > > > > > Please check the actual fps (I'm usually using a vblank-syn=
ced GL, e.g.
> > > > > > > > kmscube).
> > > > > > > >
> > > > > > > > At least this matches my expectations.
> > > > > > >
> > > > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS with=
 30. So I guess that's a no go
> > > > > >
> > > > > > Although it was using dsc->bits_per_component * 3 regardless be=
fore for
> > > > > > dsi_adjust_pclk_for_compression so I guess that's what Jonathan=
 was
> > > > > > referring to earlier...
> > > > >
> > > > > Do you have any of the patches by Marijn or Pengyu?
> > > > >
> > > > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regresse=
s-again-v1-1-6a422141eeea@somainline.org/
> > > > >
> > > > > - https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-m=
itltlatltl@gmail.com/
> > > >
> > > > Nope, I can test with them though if you'd like
> > >
> > > Tested the following 3 patches on top of this series:
> > > drm/msm/dsi: fix hdisplay calculation when programming dsi registers
> > > drm/msm/dsi: fix bits_per_pclk
> > > drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> > >
> > > Getting constant FIFO errors with them applied:
> > > [   64.851635] dsi_err_worker: status=3D4
> > > [   64.851692] dsi_err_worker: status=3D4
> > > [   64.851730] dsi_err_worker: status=3D4
> > > [   64.851766] dsi_err_worker: status=3D4
> > > [   64.851802] dsi_err_worker: status=3D4
> > > [   64.851837] dsi_err_worker: status=3D4
> > > [   64.851903] dsi_err_worker: status=3D4
> > > [   64.851940] dsi_err_worker: status=3D4
> > > [   64.851976] dsi_err_worker: status=3D4
> > > [   64.852011] dsi_err_worker: status=3D4
> >
> > Personally, I use
> > timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_int(dsc)=
,
> >                          dsc->bits_per_component * 3);
> >
> > DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.
> >
> > This works for 8-bit dst bpc with 10-bit src bpc.
>
> Did a quick test with that (plus the 3 changes listed above), still getti=
ng the
> FIFO errors and no display.
>
> Are you using RGB101010?
>

RGB101010(dst bpp) downstream, my panel supports RGB101010, and I can
use RGB888 for it too.
I am testing rgb101010.
BTW, have you dumped registers? compared with downstream.

I hardcode
display_data_hctl =3D (0xbe << 16) | hsync_data_start_x;
in dpu_hw_intf.c
downstream uses 0xbe for data_width

Best wishes,
Pengyu
> >
> > Best wishes,
> > Pengyu
> >
>
> Thanks,
> Alex
