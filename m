Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABDE1098784
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB5510EABD;
	Fri, 20 Mar 2026 13:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M2wJTv/m";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCFE510EABB
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 13:31:52 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-56cd71a7630so505174e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 06:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774013512; cv=none;
 d=google.com; s=arc-20240605;
 b=M6lY8d0SaLUwqvK3w5vtjEl5fJGUU+NgNm8SSSv85wF+GtbEBRohyFeaKuzMAxlYSi
 NHhktoMP9HI7gttM0IoVmXjw49j71mHUveiailb7VYqq+4mVdg1tWquA8YEMvPom6yaQ
 NMFSkxqpHCCsrKbD0nlL6E5x7kZet/QkQMjBsINGu6gBE1yj+hGnim/m/+UkS+u86cMB
 9OgepL+oIHKKUyS4G9aPogaGukMPkDmxdvdXo7vkc30Udi3fzHSaGr6xrljlcxNyFsfI
 +QCwhXj6oZmSltGEuOMcYpRvdpRGu7xe263ew2vfaizL4HN62oJ34H4bQ5sp+o5wgMyp
 N4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l5XYD1rfkrqsOlwTq8uo+xjetaVgh9Rk44sFsp4gv6k=;
 fh=zoU5kWR9e71zgLcTzwfKETWuTlkJzyv4GE/G44y+smQ=;
 b=SddTdMQRgFDbLEHsK/I52+E4R2UrcaSt7xgoglV8+1oodqTKj3+whgm6jEMVh1n+d2
 qMokuQsfA50o0O00CRgAcLEgokQflL0FW47fDyV5DQyDH37+ToHcBnz6M5w6OGDZQ9qW
 rhNwZLyYuW6h0ignZHRzHXZ0/qHsrdXG8Yka+jbN6NFLQFXIHTFZBye9+NNF5WCEBUOB
 lq2JliaGmRh0hk6gnfVwrUTVb1qP/OxzkhCmrO4FcyK0GeGD0eVmNQJOd4atofnqrrR5
 jABSoOt5RBuQJ6fR3G8pLhQ727tHG/HtGNxZzPdU3533vl7HT2anI3ma+dlbaSJGO1fA
 u9ZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774013512; x=1774618312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l5XYD1rfkrqsOlwTq8uo+xjetaVgh9Rk44sFsp4gv6k=;
 b=M2wJTv/mdmRXRTxUh8B7kBx6dba1KA2wg6ko3ydVigpSDuQHEPbiJDnpnXOPbe6/JN
 v2OsSuZTjCyYKh0LDlyH6HftOGHb7KOoJWK4untBwgn7vefNOrGs4Mx5ERNAixyK6VOV
 q0HAkNawFcndOSOSS2yZwmxmuIOoc47EYBroDJQtctCrSOzi02HkZXzvebsO8ffqNTw4
 QbxNn3FRtTz6f5SyBxnQ3bpBOmM+1VzdZR5IOjhf4ml4ReMGDCDBmCPgpyVGkusSPF2w
 d15NcCNlssnYF60lHE3DSTmUhfTCTDkTw3dpo+qZLbskVx9aspd2VnnoeBFiyjxFh3Aw
 VUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774013512; x=1774618312;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l5XYD1rfkrqsOlwTq8uo+xjetaVgh9Rk44sFsp4gv6k=;
 b=V7/XL2V9xvFrzEk/AhTZqtMkF1ybpDKEOWXnNRSxW46xrqHvjXugIuWxbMEjMYLJqv
 N9oe+GrjE5wX+UPyAEq0f5pLh0EeAHrFaPoMTJdACreWWRYX+UEwI4VpSgxBeR2803CD
 /pdcdhLpTQpyJVjRh+vkqN3eeQYos4ZAcjtTwnPFeo7iCBTp9gigISRHQJkGDiHEEmnm
 fUv9Ab9ANgLrrazh2/Bcx0keYIWRKMNitm952Gggai9x5EmVp0BmCQAvgY6rfH1SRzfZ
 Vbi1I5++SnzXl+GpYT+g+wgqPkBcZtJcp4fB/MtoUrwLn2qFf8jf2iLwNEtuI8j0EriX
 g9jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJGCJBBq7oxOd8VtnBhQF6yuNi66QXuCre6SDTSjIUyARrLuPq4FyyXVeV7w7s0JztPluFkcdroCs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoOjlqBtU26zLOarb8iykfLela0T2iYSyXCL8OKFIRK2/W+9Rj
 IQYQuwWdbBvls1otXyZ9FHuSvp194JoSSF0RRtxw/V0x4pco0MSUB9goN0m7fO8UBom099XP9ot
 Z0EUw2t4/Sf3tvGbTAIwcUh/tcUPsLxrZnB/nPtpyng==
X-Gm-Gg: ATEYQzzFPswuNGsZi/BmhWgR4JnfB77JxppFbQPIrOZSYltMRri/wyJjcmKMST1oDsD
 8pyePkyAvXPrk8gmqXOm5/s/USqQF1Qy1mBSFq+rTU/LGA/a34qSeAV9aV2SVoCYTt0IHnyTHdo
 ibMDfGc1eA/UlbkYPjysjBPCsNOJtyBdaWjx0Tj2PjJl9hZjaAwCMZ2ZTYM7CRumIOJu763tQBH
 AoInxljosZ/r2IcyYYMRFbPdUP3v35Ijc39c5xnUodq4/Y2E/tRiqMjsHPuYDdbBTv5uoicnnX9
 v8T6v3t8
X-Received: by 2002:a05:6122:4d09:b0:56c:d757:a045 with SMTP id
 71dfb90a1353d-56cde41dea4mr1391119e0c.9.1774013511359; Fri, 20 Mar 2026
 06:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2e8h6oinKxN1ndcvHCSc+=bFLXVVDZVAVF0cQHoiaMvEwhPQ@mail.gmail.com>
 <X2fV9mpVHV6Qk8-ImS7vxqDQXFt4K85jPKJWnxVono324hHaRh7x13f2HYM4CKNK-UDqrmP8Jz79-oVklw8vLBfaxPbVuQq4FBfblu27R9s=@pm.me>
 <CAH2e8h5tns-sXZ3-cvBmeAgbkNT1sG0kxNeaUGZnHoFEYh-Tjg@mail.gmail.com>
 <ZPf83Rxo54mgr4un9o9CNu9rXp4-8cQ8jkYIfHZODIzbJXEMISRS2PZKYqDCijOAq1N2eq0Wnt-kS0ys9KV0uB5TawUQLNjNcSzfQeUWe10=@pm.me>
In-Reply-To: <ZPf83Rxo54mgr4un9o9CNu9rXp4-8cQ8jkYIfHZODIzbJXEMISRS2PZKYqDCijOAq1N2eq0Wnt-kS0ys9KV0uB5TawUQLNjNcSzfQeUWe10=@pm.me>
From: Pengyu Luo <mitltlatltl@gmail.com>
Date: Fri, 20 Mar 2026 21:31:24 +0800
X-Gm-Features: AaiRm50FQA6qBvWaTh0P4u9bJSdyWB5-1HjvYZpdxWyonMUiKmvZ4PO1Ll5yoTI
Message-ID: <CAH2e8h6wvab7tvZRUt0xS=SA5+hnKopQKCayT0JEgWL9_e3uTQ@mail.gmail.com>
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

On Fri, Mar 20, 2026 at 9:18=E2=80=AFPM Alexander Koskovich <akoskovich@pm.=
me> wrote:
>
> On Friday, March 20th, 2026 at 8:20 AM, Pengyu Luo <mitltlatltl@gmail.com=
> wrote:
>
> > On Fri, Mar 20, 2026 at 8:14=E2=80=AFPM Alexander Koskovich <akoskovich=
@pm.me> wrote:
> > >
> > > On Friday, March 20th, 2026 at 8:08 AM, Pengyu Luo <mitltlatltl@gmail=
.com> wrote:
> > >
> > > > On Fri, Mar 20, 2026 at 4:17=E2=80=AFPM Alexander Koskovich <akosko=
vich@pm.me> wrote:
> > > > > >
> > > > > > On Friday, March 20th, 2026 at 3:36 AM, Dmitry Baryshkov <dmitr=
y.baryshkov@oss.qualcomm.com> wrote:
> > > > > >
> > > > > > > On Fri, Mar 20, 2026 at 07:02:54AM +0000, Alexander Koskovich=
 wrote:
> > > > > > > > On Friday, March 20th, 2026 at 2:50 AM, Alexander Koskovich=
 <akoskovich@pm.me> wrote:
> > > > > > > >
> > > > > > > > > On Friday, March 20th, 2026 at 2:38 AM, Dmitry Baryshkov =
<dmitry.baryshkov@oss.qualcomm.com> wrote:
> > > > > > > > >
> > > > > > > > > > On Fri, Mar 20, 2026 at 04:46:02AM +0000, Alexander Kos=
kovich wrote:
> > > > > > > > > > > On Friday, March 20th, 2026 at 12:25 AM, Jonathan Mar=
ek <jonathan@marek.ca> wrote:
> > > > > > > > > > >
> > > > > > > > > > > > On 3/19/26 9:45 PM, Dmitry Baryshkov wrote:
> > > > > > > > > > > > > On Thu, Mar 19, 2026 at 01:23:03PM -0400, Jonatha=
n Marek wrote:
> > > > > > > > > > > > ...
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> That's not how it works. INTF (which feeds DSI) =
is after DSC compression.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> INTF timings are always in RGB888 (24-bit) units=
. Ignoring widebus details,
> > > > > > > > > > > > >> the INTF timing should match what is programmed =
on the DSI side (hdisplay,
> > > > > > > > > > > > >> which is calculated as bytes per line / 3).
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> (fwiw, the current "timing->width =3D ..." calcu=
lation here blames to me, but
> > > > > > > > > > > > >> what I wrote originally was just "timing->width =
=3D timing->width / 3" with a
> > > > > > > > > > > > >> comment about being incomplete.)
> > > > > > > > > > > > >>
> > > > > > > > > > > > > Okay. After reading the docs (sorry, it took a wh=
ile).
> > > > > > > > > > > > >
> > > > > > > > > > > > > - When widebus is not enabled, the transfer is al=
ways 24 bit of
> > > > > > > > > > > > >    compressed data. Thus if it is not in play, pc=
lk and timing->width
> > > > > > > > > > > > >    should be scaled by source_pixel_depth / compr=
ession_ratio / 24. In
> > > > > > > > > > > > >    case of the code it is 'drm_dsc_get_bpp_int(ds=
c) / 24'.
> > > > > > > > > > > > >
> > > > > > > > > > > > >    For RGB101010 / 8bpp DSC this should result in=
 the PCLK being lowered
> > > > > > > > > > > > >    by the factor of 3 (=3D 24 / (30 / 3.75))
> > > > > > > > > > > > >
> > > > > > > > > > > > > - When widebus is in play (MDSS 6.x+, DSI 2.4+), =
the transfer takes
> > > > > > > > > > > > >    more than 24 bits. In this case the PCLK and t=
iming->width should be
> > > > > > > > > > > > >    scaled exactly by the DSC compression ratio, w=
hich is
> > > > > > > > > > > > >    'drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per=
_component).
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, this piece of code needs to be adjusted to ch=
eck for the widebus
> > > > > > > > > > > > > being enabled or not.
> > > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > The widebus adjustment on the MDP/INTF side is alre=
ady in
> > > > > > > > > > > > dpu_hw_intf_setup_timing_engine: the "data width" i=
s divided by 2 for
> > > > > > > > > > > > 48-bit widebus instead of 24-bit. there shouldn't b=
e any other
> > > > > > > > > > > > adjustment (downstream doesn't have any other adjus=
tment).
> > > > > > > > > > > >
> > > > > > > > > > > > a relevant downstream comment: "In DATABUS-WIDEN mo=
de, MDP always sends
> > > > > > > > > > > > out 48-bit compressed data per pclk and on average,=
 DSI consumes an
> > > > > > > > > > > > amount of compressed data equivalent to the uncompr=
essed pixel depth per
> > > > > > > > > > > > pclk."
> > > > > > > > > > > >
> > > > > > > > > > > > Based on that comment, this patch is correct, and t=
he
> > > > > > > > > > > > ''drm_dsc_get_bpp_int(dsc) / (3 * dsc->bits_per_com=
ponent)' adjustment
> > > > > > > > > > > > only applies to DSI.
> > > > > > > > > > >
> > > > > > > > > > > If I keep the INTF side at /24 and change the DSI sid=
e to:
> > > > > > > > > > >
> > > > > > > > > > > if (wide_bus)
> > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay =
* drm_dsc_get_bpp_int(dsc), dsc->bits_per_component * 3);
> > > > > > > > > > > else
> > > > > > > > > > >         new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay =
* drm_dsc_get_bpp_int(dsc), 24);
> > > > > > > > > >
> > > > > > > > > > Please check the actual fps (I'm usually using a vblank=
-synced GL, e.g.
> > > > > > > > > > kmscube).
> > > > > > > > > >
> > > > > > > > > > At least this matches my expectations.
> > > > > > > > >
> > > > > > > > > Hmmm with kmscube I am getting 120FPS with 24 and 100FPS =
with 30. So I guess that's a no go
> > > > > > > >
> > > > > > > > Although it was using dsc->bits_per_component * 3 regardles=
s before for
> > > > > > > > dsi_adjust_pclk_for_compression so I guess that's what Jona=
than was
> > > > > > > > referring to earlier...
> > > > > > >
> > > > > > > Do you have any of the patches by Marijn or Pengyu?
> > > > > > >
> > > > > > > - https://lore.kernel.org/linux-arm-msm/20260311-dsi-dsc-regr=
esses-again-v1-1-6a422141eeea@somainline.org/
> > > > > > >
> > > > > > > - https://lore.kernel.org/linux-arm-msm/20260307111250.105772=
-1-mitltlatltl@gmail.com/
> > > > > >
> > > > > > Nope, I can test with them though if you'd like
> > > > >
> > > > > Tested the following 3 patches on top of this series:
> > > > > drm/msm/dsi: fix hdisplay calculation when programming dsi regist=
ers
> > > > > drm/msm/dsi: fix bits_per_pclk
> > > > > drm/msm/dsi: fix hdisplay calculation for CMD mode panel
> > > > >
> > > > > Getting constant FIFO errors with them applied:
> > > > > [   64.851635] dsi_err_worker: status=3D4
> > > > > [   64.851692] dsi_err_worker: status=3D4
> > > > > [   64.851730] dsi_err_worker: status=3D4
> > > > > [   64.851766] dsi_err_worker: status=3D4
> > > > > [   64.851802] dsi_err_worker: status=3D4
> > > > > [   64.851837] dsi_err_worker: status=3D4
> > > > > [   64.851903] dsi_err_worker: status=3D4
> > > > > [   64.851940] dsi_err_worker: status=3D4
> > > > > [   64.851976] dsi_err_worker: status=3D4
> > > > > [   64.852011] dsi_err_worker: status=3D4
> > > >
> > > > Personally, I use
> > > > timing->width =3D DIV_ROUND_UP(timing->width * drm_dsc_get_bpp_int(=
dsc),
> > > >                          dsc->bits_per_component * 3);
> > > >
> > > > DIV_ROUND_UP is magic for me. If not, I got status=3D4 too.
> > > >
> > > > This works for 8-bit dst bpc with 10-bit src bpc.
> > >
> > > Did a quick test with that (plus the 3 changes listed above), still g=
etting the
> > > FIFO errors and no display.
> > >
> > > Are you using RGB101010?
> > >
> >
> > RGB101010(dst bpp) downstream, my panel supports RGB101010, and I can
> > use RGB888 for it too.
> > I am testing rgb101010.
> > BTW, have you dumped registers? compared with downstream.
> >
> > I hardcode
> > display_data_hctl =3D (0xbe << 16) | hsync_data_start_x;
> > in dpu_hw_intf.c
> > downstream uses 0xbe for data_width
>
> Can you try this series with ac47870fd ("drm/msm/dsi: fix hdisplay calcul=
ation when programming dsi registers") reverted and with the following 2 ch=
anges?
>
> https://github.com/AKoskovich/linux/commit/af24b0e2ee212153953dfee040da5c=
c077567363
> https://github.com/AKoskovich/linux/commit/e334675c0caf47956a838e2eafda22=
fb689a967d
>

I don't mind testing it, but some parameters are obviously wrong for me.

int new_hdisplay =3D DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc)=
,
            dsc->bits_per_component * 3);

This gives the correct clkrate with fixes([1]).

fixed ac47870fd([2]) will give me the right hdisplay register value
@0xae94024 (I compared with downstream)

[1]: https://gitlab.freedesktop.org/drm/msm/-/commit/e4eb11b34d6c84f398d8f0=
8d7cb4d6c38e739dd2
[2]: https://lore.kernel.org/linux-arm-msm/20260307111250.105772-1-mitltlat=
ltl@gmail.com/

BTW, I can only do 8-bit dst and 10-bit src test, 10-bit dst and
10-bit src gave me

Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_mode_set: set mode:
"1904x3040": 120 915552 1904 2180 2212 2244 3040 3066 3070 3400 0x48
 0x0
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_pre_enable: id=3D0
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: id=3D0
Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
Mar 20 20:46:00 qcom kernel: msm_dsi_host_reset_phy:
Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D108120=
000
Mar 20 20:46:00 qcom kernel: dsi_calc_pclk: pclk=3D172992000, bclk=3D108120=
000
Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Set clk rates:
pclk=3D172992000, byteclk=3D108120000
Mar 20 20:46:00 qcom kernel: dsi_link_clk_set_rate_6g: Failed to set
rate pixel clk, -22
Mar 20 20:46:00 qcom kernel: msm_dsi_host_power_on: failed to enable
link clocks. ret=3D-22
Mar 20 20:46:00 qcom kernel: dsi_mgr_bridge_power_on: power on host 0
failed, -22
Mar 20 20:46:00 qcom kernel: msm_dsi ae94000.dsi: Power on failed: -22
Mar 20 20:46:00 qcom kernel: bias enabled
Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: sending dcs
data ff 20 failed: -22
Mar 20 20:46:00 qcom kernel: panel-nt36536 ae94000.dsi.0: Failed to
initialize panel: -22
Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc33 in=
tf2
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf2
enabling mode:
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf2
split_role 2, halve horizontal 952 1122
1090 1106 0
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf2
fmt_fourcc 0x34324752
Mar 20 20:46:00 qcom kernel:
[drm:programmable_fetch_get_num_lines:202] enc33 intf2 prog fetch is
not needed, large vbp+vsw
Mar 20 20:46:00 qcom kernel:
[drm:programmable_fetch_get_num_lines:217] enc33 intf2 v_front_porch
26 v_back_porch 330 vsync_pulse_wi
dth 4
Mar 20 20:46:00 qcom kernel:
[drm:programmable_fetch_get_num_lines:221] enc33 intf2 wc_lines 24
needed_vfp_lines 4294966986 actual_v
fp_lines 0
Mar 20 20:46:00 qcom kernel: [drm:programmable_fetch_config:261] enc33
intf2 vfp_fetch_lines 0 vfp_fetch_start_vsync_counter 0
Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:507]
enc33 intf2 update pending flush ctl 0 intf 3
Mar 20 20:46:00 qcom kernel: [drm:dpu_encoder_phys_vid_enable:471] enc33 in=
tf1
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:292] enc33 intf1
enabling mode:
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:304] enc33 intf1
split_role 1, halve horizontal 952 1122
1090 1106 0
Mar 20 20:46:00 qcom kernel:
[drm:dpu_encoder_phys_vid_setup_timing_engine:315] enc33 intf1
fmt_fourcc 0x34324752


Best wishes,
Pengyu

>
> >
> > Best wishes,
> > Pengyu
> > > >
> > > > Best wishes,
> > > > Pengyu
> > > >
> > >
> > > Thanks,
> > > Alex
> >
> >
