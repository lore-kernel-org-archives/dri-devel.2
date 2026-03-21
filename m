Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00871093175
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 05:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E6510E266;
	Sat, 21 Mar 2026 05:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AIXlUumQ";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C04D410E266
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 05:19:59 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5673804da95so945943e0c.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 22:19:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774070398; cv=none;
 d=google.com; s=arc-20240605;
 b=UZZdS6z+SnEE/0JXeiFqeqhJLgy2J8MBFs0BNm5RKHgVPRx6qESyvHuzBJv57V7zLY
 yutb4vpwMlOF00ErKjqNtwYvR62gcGQT/Hn8X8xFD9mRwnyG7DCdnDh0ap4+lQ4TC82h
 2hSrTUsnxeKHIea7w+SwEvSvE/H6Bezk2W7n7qIPpcDEbJO2B4X5suHnqgPgBCOIu13I
 gjWdz0xMnz79rahQcDWMy0U8mK4m84nDIB6pY8I7NFjCrRveJMuVo+SeoRR7Mq6vcSeY
 D9ZBwuMHdj4DrfY2qTPP26I1/Qdzbcu3KLHbbLI3jYTB+ecgb9bcdr/eaWKr1qeigX66
 w1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LnFDGG/qO8xQBCsXITOmY6HdAR3OjQn9h41sAssDEU4=;
 fh=XeQYzppOYmIYPYT9Ul/ho82GyyMBdaUfgc7oFizgxoM=;
 b=dAJe/EYahu2vVa0Si+u2nXEXW60cAGk7gOELqGWe8KBzet+9aqIG0FWTgiUMsOxzES
 cS2cPGPPm7RI7bt+VCbyT/Lu7mGKICqpN5JTqbDrJc3sw3v9rd76mY0R5hWWza/AWhpK
 KI0ngnIiUDDm0BEBddyfUU17+Pa32oM3NWRpnbQwWMmvAvDxoaLOnrgzZg7+PuNJ4Iz+
 O4tTd2Suoff/Qbx4abLLhu3VN/uv8/jygiTu9HXsv2Z3nYqlt6mtjs14zRavdget0Ly8
 C1PngKItPpP74bPH/rfpxi1w0UqptR8+OzAqGfH1EzAgJAEru/7ZLPVgl5JIiHnjrVIe
 5xyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774070398; x=1774675198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnFDGG/qO8xQBCsXITOmY6HdAR3OjQn9h41sAssDEU4=;
 b=AIXlUumQIOpYqzt9oikpuTQmvjShdP/1t/ik5SufCxT/kEKO9KQ1zYIXfIlOKnvM2a
 9S90bfGAxKXz/uYkdvK338bXd6NJDP4UvPxYMV10rqcYlDnDOb0Yub00O2QrDPwqLyrm
 qR9GO+xackEqnhJAbNHNNqiag/8YsbHopLIu1zoypCGguTVbOIz72PQyxsjvSzK1MTd7
 5/E6J4t6fxb5owNe3jcKnw6Q4LauYyhHUplsTO2JqX1w8BFGT40EPztt+u4frdMqtIpU
 x2Rs3UvznJgFWOUb/015UX5cH/n/RVj1kxnxiNeddvhV79FDsz3alApxl6GUNl51brDT
 rZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774070398; x=1774675198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LnFDGG/qO8xQBCsXITOmY6HdAR3OjQn9h41sAssDEU4=;
 b=OluYjUs3T5znopcufLOQLdDWPbw38bsHJmC4lL/vPaZRPJ8HDP7seiIGYhMvgpFKHR
 ZYzah4SFX0ScyPna7CW2kivlWrcLmMcPouCcfpoLbkwiMkVGobUe+CAtwK8ShLUUIMQl
 DtDacCggm5CeL7fb+OCW2vb6SJKMbVCTdua20RChipNGJusrp3YqNabxYuAU3jm+rh45
 R6QjKRZtXhgPwy/u/IEcdefMWYoahljQe3RAJ5EtRtCGfbQy/EVM3Ie0+wb+hcG6vcuu
 rHti6SVYHBL14/esesi9N4ZtBBbqCEA50CA/lMy7MJOErVYv73SD4I0ZU4knrpDzm1Kv
 4Sgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqBifL3t0zljTxOJsA6Q5pKBSJ6a5I6kRe3jCWTjkxjwIQo8QDFYMR8X0b8awXyKwqViS4DH2/Rho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3PXDhHr1HGqmrrILuVGdbxqmOs+pn095kDdExSJUWOKUqyvoE
 SiVG+ucdD74UoU1Vp3AdpiYZIzMIOypRoKjXipQSqy0ilNfqTCkvflV21X97+4+DDY07gIiX//K
 uIF+ZH3oIZFLlTlNBejjbFoHWusS8mXU=
X-Gm-Gg: ATEYQzzQZu8RnrAHshqga5xhONIR79s/KiUoxh08awwlnsy9J+MoUyMNNlB894T2HqN
 lzCvf6E3E7MEYbekzXfLCnAcnMDqmInByS1JzH28gnT7gjluIQJjguJ6Rim6bQbgxvzIZYQ3/yg
 seKzDIc068QM4lfLFcLosWxsAlTgjxeurIsyCRmaVCYrV6mmEcdDkfpjvKb2QxcqwkfmpNuTH9q
 qeXx/ptzS2iF4R4U1z2UvSPgsniWper4A+kw75TRa6MAaaYCHau/P4DOd2jS2iHvTV8Gf5Jpqkb
 5Idk/DR2JcVEtZQ=
X-Received: by 2002:a05:6122:6991:b0:56c:d401:4aff with SMTP id
 71dfb90a1353d-56cde1d346amr2343537e0c.0.1774070398385; Fri, 20 Mar 2026
 22:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
 <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
 <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
 <ZPf83Rxo54mgr4un9o9CNu9rXp4-8cQ8jkYIfHZODIzbJXEMISRS2PZKYqDCijOAq1N2eq0Wnt-kS0ys9KV0uB5TawUQLNjNcSzfQeUWe10=@pm.me>
 <CAH2e8h6wvab7tvZRUt0xS=SA5+hnKopQKCayT0JEgWL9_e3uTQ@mail.gmail.com>
 <z5Q2MMTkjlFG1ye2Vv0uZrEyVqazEnPeBWDmYwlvpZKK1m5tRSfP94gZNEUbec9qKSiaUQpzyqveE8ehad3JkL69HRKnHMSKJUhOm7mP1nE=@pm.me>
In-Reply-To: <z5Q2MMTkjlFG1ye2Vv0uZrEyVqazEnPeBWDmYwlvpZKK1m5tRSfP94gZNEUbec9qKSiaUQpzyqveE8ehad3JkL69HRKnHMSKJUhOm7mP1nE=@pm.me>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Sat, 21 Mar 2026 13:19:30 +0800
X-Gm-Features: AaiRm509pDsaLob8VR2rUbuqVPa4XMCfftiC0fPCVru4BUfq5hnC8J6WJxEZoeg
Message-ID: <CAH2e8h7RJA5w2XnJ6inr_a3w-3YMmtjzXErGNCr0Z-qELNz-fQ@mail.gmail.com>
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

On Sat, Mar 21, 2026 at 3:13=E2=80=AFAM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
>
> On Friday, March 20th, 2026 at 9:36 AM, Pengyu Luo <mitltlatltl@gmail.com=
> wrote:
>
> > On Fri, Mar 20, 2026 at 9:18=E2=80=AFPM Alexander Koskovich <akoskovich=
@pm.me> wrote:
> > >
> > > On Friday, March 20th, 2026 at 8:20 AM, Pengyu Luo <mitltlatltl@gmail=
.com> wrote:
> > >
> > > > On Fri, Mar 20, 2026 at 8:14=E2=80=AFPM Alexander Koskovich <akosko=
vich@pm.me> wrote:
> > > > >
> > > > > On Friday, March 20th, 2026 at 8:08 AM, Pengyu Luo <mitltlatltl@g=
mail.com> wrote:
> > > > >
> > > > > > On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <ak=
oskovich@pm.me> wrote:
> > > > > > > >
> > > > > > > > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <d=
mitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > >
> > > > > > > > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Kosko=
vich wrote:
> > > > > > > > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Kosko=
vich <akoskovich@pm.me> wrote:
> > > > > > > > > >
> > > > > > > > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Barysh=
kov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander=
 Koskovich wrote:
> > > > > > > > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan=
 Marek <jonathan@marek.ca> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jon=
athan Marek wrote:
> > > > > > > > > > > > > > ...
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> That's not how it works. INTF (which feeds D=
SI) is after DSC compression.
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> INTF timings are always in RGB888 (24-bit) u=
nits. Ignoring widebus details,
> > > > > > > > > > > > > > >> the INTF timing should match what is program=
med on the DSI side (hdisplay,
> > > > > > > > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> (fwiw, the current "timing->width =3D ..." c=
alculation here blames to me, but
> > > > > > > > > > > > > > >> what I wrote originally was just "timing->wi=
dth =3D timing->width / 3" with a
> > > > > > > > > > > > > > >> comment about being incomplete.)
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > > Okay. After reading the docs (sorry, it took =
a while).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - When widebus is not enabled, the transfer i=
s always 24 bit of
> > > > > > > > > > > > > > >    compressed data. Thus if it is not in play=
, pclk and timing->width
> > > > > > > > > > > > > > >    should be scaled by source_pixel_depth / c=
ompression_ratio / 24. In
> > > > > > > > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_in=
t(dsc) / 24'.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > >    For RGB101010 / 8bpp DSC this should resul=
t in the PCLK being lowered
> > > > > > > > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4=
+), the transfer takes
> > > > > > > > > > > > > > >    more than 24 bits. In this case the PCLK a=
nd timing->width should be
> > > > > > > > > > > > > > >    scaled exactly by the DSC compression rati=
o, which is
> > > > > > > > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits=
_per_component).
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > So, this piece of code needs to be adjusted t=
o check for the widebus
> > > > > > > > > > > > > > > being enabled or not.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > The widebus adjustment on the MDP/INTF side is =
already in
> > > > > > > > > > > > > > dpu_hw_intf_setup_timing_engine: the "data widt=
h" is divided by 2 for
> > > > > > > > > > > > > > 48-bit widebus instead of 24-bit. there shouldn=
't be any other
> > > > > > > > > > > > > > adjustment (downstream doesn't have any other a=
djustment).
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > a relevant downstream comment: "In DATABUS-WIDE=
N mode, MDP always sends
> > > > > > > > > > > > > > out 48-bit compressed data per pclk and on aver=
age, DSI consumes an
> > > > > > > > > > > > > > amount of compressed data equivalent to the unc=
ompressed pixel depth per
> > > > > > > > > > > > > > pclk."
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Based on that comment, this patch is correct, a=
nd the
> > > > > > > > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per=
_component)' adjustment
> > > > > > > > > > > > > > only applies to DSI.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If I keep the INTF side at /24 and change the DSI=
 side to:
> > > > > > > > > > > > >
> > > > > > > > > > > > > if (wide_bus)
> > > > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisp=
lay * drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > > > > > > > else
> > > > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisp=
lay * drm_dsc_get_bpp_int(dsc), 24);
> > > > > > > > > > > >
> > > > > > > > > > > > Please check the actual fps (I'm usually using a vb=
lank-synced GL, e.g.
> > > > > > > > > > > > kmscube).
> > > > > > > > > > > >
> > > > > > > > > > > > At least this matches my expectations.
> > > > > > > > > > >
> > > > > > > > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100=
FPS with 30. So I guess that's a no go
> > > > > > > > > >
> > > > > > > > > > Although it was using dsc->bits_per_component * 3 regar=
dless before for
> > > > > > > > > > dsi_adjust_pclk_for_compression so I guess that's what =
Jonathan was
> > > > > > > > > > referring to earlier...
> > > > > > > > >
> > > > > > > > > Do you have any of the patches by Marijn or Pengyu?
> > > > > > > > >
> > > > > > > > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-=
regresses-again-v1-1-6a422141eeea@somainline.org/
> > > > > > > > >
> > > > > > > > > - https://lore.kernel.org/linux-arm-msm/20260307111250.10=
5772-1-mitltlatltl@gmail.com/
> > > > > > > >
> > > > > > > > Nope, I can test with them though if you'd like
> > > > > > >
> > > > > > > Tested the following 3 patches on top of this series:
> > > > > > > drm/msm/dsi: fix hdisplay calculation when programming dsi re=
gisters
> > > > > > > drm/msm/dsi: fix bits_per_pclk
> > > > > > > drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> > > > > > >
> > > > > > > Getting constant FIFO errors with them applied:
> > > > > > > [   64.851635] dsi_err_worker: status=3D4
> > > > > > > [   64.851692] dsi_err_worker: status=3D4
> > > > > > > [   64.851730] dsi_err_worker: status=3D4
> > > > > > > [   64.851766] dsi_err_worker: status=3D4
> > > > > > > [   64.851802] dsi_err_worker: status=3D4
> > > > > > > [   64.851837] dsi_err_worker: status=3D4
> > > > > > > [   64.851903] dsi_err_worker: status=3D4
> > > > > > > [   64.851940] dsi_err_worker: status=3D4
> > > > > > > [   64.851976] dsi_err_worker: status=3D4
> > > > > > > [   64.852011] dsi_err_worker: status=3D4
> > > > > >
> > > > > > Personally, I use
> > > > > > timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_=
int(dsc),
> > > > > >                          dsc->bits_per_component * 3);
> > > > > >
> > > > > > DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.
> > > > > >
> > > > > > This works for 8-bit dst bpc with 10-bit src bpc.
> > > > >
> > > > > Did a quick test with that (plus the 3 changes listed above), sti=
ll getting the
> > > > > FIFO errors and no display.
> > > > >
> > > > > Are you using RGB101010?
> > > > >
> > > >
> > > > RGB101010(dst bpp) downstream, my panel supports RGB101010, and I c=
an
> > > > use RGB888 for it too.
> > > > I am testing rgb101010.
> > > > BTW, have you dumped registers? compared with downstream.
> > > >
> > > > I hardcode
> > > > display_data_hctl =3D (0xbe << 16) | hsync_data_start_x;
> > > > in dpu_hw_intf.c
> > > > downstream uses 0xbe for data_width
> > >
> > > Can you try this series with ac47870fd ("drm/msm/dsi: fix hdisplay ca=
lculation when programming dsi registers") reverted and with the following =
2 changes?
> > >
> > > https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040=
da5cc077567363
> > > https://github.com/AKoskovich/linux/commit/e334675c0caf47956a838e2eaf=
da22fb689a967d
> > >
> >
> > I don't mind testing it, but some parameters are obviously wrong for me=
.
>
> Did some additional testing, reverted the change in dpu_encoder_phys_vid.=
c and
> picked only "drm/msm/dsi: fix hdisplay calculation when programming dsi
> registers". This results in the FIFO errors. But then when I mirror data_=
width
> calculation I see downstream, display then works.
>

Yes, that would work. I recently hardcoded data_width(not dig it yet),
after I fixed
clock issues(mentioned in the last email) last night, 10b input w/
output works well now.
But the clock issues may not confuse you. My panel is 2 * 952*3040
with C-PHY native
10b, pclk goes unusual, the ratio(35/16) only shows in 10b in with10b out m=
ode.

 dsi0_phy_pll_out_dsiclk             2       2        0        378420000
     disp_cc_mdss_pclk1_clk_src       1       1        0        172992000
 dsi0_phy_pll_out_byteclk            2       2        0        108120000
     disp_cc_mdss_byte1_clk_src       2       2        0        108120000

> Can you try with just this (ignore other change I suggested):
> https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040da5c=
c077567363
>
> That should make the display_data_hctl calculation correct so you don't n=
eed to
> hardcode (I think)
>

Awesome! I will later. I hope this will fix the data_width issue finally.

Best wishes,
Pengyu

> >
> > int new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(=
dsc),
> >             dsc->bits_per_component * 3);
> >
> > This gives the correct clkrate with fixes([1]).
> >
> > fixed ac47870fd([2]) will give me the right hdisplay register value
> > @0xae94024 (I compared with downstream)
> >
> > [1]: https://gitlab.freedesktop.org/drm/msm/-/commit/e4eb11b34d6c84f398=
d8f08d7cb4d6c38e739dd2
> > [2]: https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitl=
tlatltl@gmail.com/
> >
> > BTW, I can only do 8-bit dst and 10-bit src test, 10-bit dst and
> > 10-bit src gave me
> >
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_mode_set: set mode:
> > "1904x3040": 120 915552 1904 2180 2212 2244 3040 3066 3070 3400 0x48
> >  0x0
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_pre_enable: id=3D0
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: id=3D0
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
> > Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D10=
8120000
> > Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D10=
8120000
> > Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Set clk rates:
> > pclk=3D172992000, byteclk=3D108120000
> > Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Failed to set
> > rate pixel clk, -22
> > Mar 20 20:46:00 qcom kernel: msm_dsi_host_power_on: failed to enable
> > link clocks. ret=3D-22
> > Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: power on host 0
> > failed, -22
> > Mar 20 20:46:00 qcom kernel: msm_dsi ae94000.dsi: Power on failed: -22
> > Mar 20 20:46:00 qcom kernel: bias enabled
> > Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: sending dcs
> > data ff 20 failed: -22
> > Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: Failed to
> > initialize panel: -22
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc3=
3 intf2
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf2
> > enabling mode:
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf2
> > split_role 2, halve horizontal 952 1122
> > 1090 1106 0
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf2
> > fmt_fourcc 0x34324752
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:202] enc33 intf2 prog fetch is
> > not needed, large vbp+vsw
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:217] enc33 intf2 v_front_porch
> > 26 v_back_porch 330 vsync_pulse_wi
> > dth 4
> > Mar 20 20:46:00 qcom kernel:
> > [drm:programmable_fetch_get_num_lines:221] enc33 intf2 wc_lines 24
> > needed_vfp_lines 4294966986 actual_v
> > fp_lines 0
> > Mar 20 20:46:00 qcom kernel: [drm:programmable_fetch_config:261] enc33
> > intf2 vfp_fetch_lines 0 vfp_fetch_start_vsync_counter 0
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:507]
> > enc33 intf2 update pending flush ctl 0 intf 3
> > Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc3=
3 intf1
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf1
> > enabling mode:
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf1
> > split_role 1, halve horizontal 952 1122
> > 1090 1106 0
> > Mar 20 20:46:00 qcom kernel:
> > [drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf1
> > fmt_fourcc 0x34324752
> >
> >
> > Best wishes,
> > Pengyu
> >
> > >
> > > >
> > > > Best wishes,
> > > > Pengyu
> > > > > >
> > > > > > Best wishes,
> > > > > > Pengyu
> > > > > >
> > > > >
> > > > > Thanks,
> > > > > Alex
> > > >
> > > >
> >
> >
