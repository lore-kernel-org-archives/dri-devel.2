Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7540DC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412C510E109;
	Thu,  3 Sep 2026 22:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zdc9nPnx";
	dkim-atps=neutral
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com
 [209.85.160.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C456010E109
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 22:19:41 +0000 (UTC)
Received: by mail-oa1-f49.google.com with SMTP id
 586e51a60fabf-46aef6e48fbso224261fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 15:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788473981; cv=none;
 d=google.com; s=arc-20260327;
 b=Be4lHLgsiNdND9P7HS17fLNPM5NZ0WLrCZYfNedzdkT8PP+xoIvhi7ulryCOWaNpBb
 5OTlsYWZ9BMBvD303/dvSdxOH5YrpICZAaAFotVQJ6QZ+x/i0+W16AG8h9mW7ntPPDC3
 KFMNFPRaPob6cw/qKhECHBNAeLbBk6IDI4fLleTwrReO+8qwSzgbvqhUzEi+009vEbO7
 zAObiBydxGQuuCNluEHy6pwxmZ/f1N+3SfduthM/7d8mcMmTq+X33xlP9L/rRNERlDOQ
 I638ijRXGjefldy01abslqznpphU9Spr6Av9qetKsMmhOUsNNHN/DP2hYGzb09m3O0Pp
 3gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cmks0OsbIu97NwE9xXK4Lv/LDxGFAge7gqd+ChMCoGc=;
 fh=LgKd8Pg0It3wt3pnFhxQl4LQvRMwPoG20CUJpnnHQsk=;
 b=nQDsLU2fP3pMPlN7C1MI1I8SeddeSaXIAAxj5HnG0sU3/F+Wzs3SOmh7FwlNyubNav
 WlVt1ECtzUctxkidtyWiFInjMKVN2aGrzUaFBgIIircZq5Exf7X6FYPTHrzafzkCN6kg
 XVDCdiwIfNyL0qHJnBSlpn7wbQx/sJOKZ8ofGM/WnzEN3DAYPP6a1G2pW0hKvbUphawJ
 di0fi0sT/z6/RoKiHVSmD4UksB/T+pkE4UODt+N88ore1GxDO89adWuEFid8/t/sXsRo
 CF+OkNcO/Ly/6IG1dpyyNK++9t3xRE+7SMcPBc7cuR6NqbGHSP7u4525Bt/IohS2W79V
 hL7A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788473981; x=1789078781; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cmks0OsbIu97NwE9xXK4Lv/LDxGFAge7gqd+ChMCoGc=;
 b=Zdc9nPnxsURymoZlQJtzAZvBzT3xDYIv5SQjQF80djplksJyQkCI7CX7bmFpJKo9Tk
 9qBJn6cj6FWdvJ90oyezVUp1j5tBkIC5MG2wcog4nV0Sx/w8p6Ri67jrFiLCCQ5iXPyJ
 PS6X+0g0PvA29eSKFFmhLLhcymFQbkSzM3m/ozGLI2zKyaIrusDEIJ7OuvVQ+fuVEBlh
 5kS/UmqclzCm8a6W4T5FN7o1tCbBNOQOBXXZdmkQeRBYdHSowU2UA4dmLbp+4d8L0a4+
 Eg3k4m77UDP5xMFQHBENAwVxM5xD5oub0EnhYO7ip/kJ6RYSNxP0IKNBOIZ7qdXXI/iT
 69RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788473981; x=1789078781;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cmks0OsbIu97NwE9xXK4Lv/LDxGFAge7gqd+ChMCoGc=;
 b=fw/lqLEZZSGKLC+4yqqZYqKSyg0l/VKrr6HQ5OYGZA9hNNqJkJkfavCd9E8y2b04vG
 QqMzsuBjBxQjR1dsIsaBBYMFhm+7M0pKIO24jjsxUHDdalq2VFIeseVkft3Lr0t0hggh
 U9VmagvqKMjgBGJF4vQShyOU6s036yJiQ4LKbiihQRJk5ACnWB1eSKHm33TzPKeLsKIk
 MNgWdviq7OaxZhZPxdAqvO471yh9ivf8oI7wYdLKZM6rkYTOosz0PHWv7RGPj1GNXYxR
 rEVAja/Ji8WgKd3lA+C2cONrB9LRIgftrtzNmXLJyc60oNcumhtmTgGjTez3Hwc3AEj4
 rCFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzroMzWM2DwMmQGtZC38uWjv7wv6w7lVq4CnKFeODfuCu+KrxQ4SMldaVWCT4ddTKZQR/lV6//3OoM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lf7VcFJy1Ly3+fhqJrSN1jeCNDoJQGi0B7s71ayq3IPhR4PHY9
 VcH4Xjz6WVQO6nW4og8SjupaxaOQFWCUGGlCaME9/TC8i9MRcN0pVHXB0xw/X88gvrIKKNzJoGV
 AB5d011n7u3q9QRaDWy5W23DYlKo0KPU=
X-Gm-Gg: AYBFou2oTMrwzYrY30l5AFAZAksqijc/kFomqezNn01km0x1ceDoyW7SfcZ7QDi2MPi
 OjzsXZOYCWD1prk/DmmxPjQIvy/ZcvGacOCgP16WzJsSsWO9KnX2vmWTvtgdFC93DS71ih/1RYu
 wxL5jeLi2eIG9vzri/WVsQ7CwsTmlfnGs5DuPpZQkhnyKUlxxUBiFFLKSUseg/hwbXLyE74kL49
 n3Nq+alL21q1iH7XaBnS74nTfjZILR17NpAE6H2ezvF8pbKwHr2jsTCrvIIz1F54z2wzavJWcSJ
 USjY7UolR9bEXNyv2Es5VnweQECuJbM9l/lsChedT9o=
X-Received: by 2002:a05:6870:3349:b0:45e:6cd1:9a3f with SMTP id
 586e51a60fabf-4754ece1b35mr2311301fac.0.1788473980595; Thu, 03 Sep 2026
 15:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <20260901234351.190506-2-anarsoul@gmail.com>
 <02c265f6-0898-4f11-9954-df7d99d082a0@rock-chips.com>
In-Reply-To: <02c265f6-0898-4f11-9954-df7d99d082a0@rock-chips.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 3 Sep 2026 15:19:13 -0700
X-Gm-Features: AcwNN1WMy61DcYd4_qYjAudu0evy49LX87olXAJLUiEt3DrGMFQ7X5yXTct3_8w
Message-ID: <CA+E=qVeqOahu7v4ser0zxxUU6Fr4dGAVA9m_mgHgu70ChYv9Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/rockchip: vop: don't round the pixel clock when
 the encoder owns the PLL
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="0000000000004dc8c0065a9b8ce3"
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

--0000000000004dc8c0065a9b8ce3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:50=E2=80=AFPM Chaoyi Chen <chaoyi.chen@rock-chips.=
com> wrote:
>
> Hello Vasily,

Hi Chaoyi,

> On 9/2/2026 7:42 AM, Vasily Khoruzhick wrote:
> > On RK3399 the HDMI reference clock is VPLL, a dedicated PLL that is a
> > parent of the VOP dclk. dw_hdmi_rockchip_mode_valid() accepts a mode
> > only if VPLL can produce its pixel clock, and encoder mode_set() then
> > programs VPLL to that rate. However vop_crtc_mode_fixup() ran first,
> > in the check phase, and rounded adjusted_mode->clock through
> > clk_round_rate() on the dclk. At that point VPLL still sits at its
> > previous rate, so the dclk composite picks whichever of VPLL/CPLL/GPLL
> > gets closest at its *current* rate and stores that inexact value.
> >
>
> Why did vop_crtc_mode_fixup() run first? Within drm_atomic_helper_check_m=
odeset(),
> mode_valid() is executed before mode_fixup().

Sorry, ambiguous wording on my part - "first" meant before the
encoder's mode_set() programs the VPLL, not before mode_valid(). The
order is as you say, and that's exactly the problem: mode_valid()
rounds the pixel clock on the ref clock (the VPLL itself), whose rate
table can produce 85.5 MHz, so the mode is accepted. mode_fixup()
however rounds on the dclk composite - a different clock - which
evaluates its mux parents at their current rates. During check the
VPLL still runs at the previous mode's rate, so GPLL/7 =3D 84.857 MHz
wins and gets stored in adjusted_mode->clock. mode_set() then programs
the VPLL to that corrupted value in the commit phase. I can reword the
commit message to make this clearer.

> > For 1366x768 (85.5 MHz) this yields GPLL/7 =3D 84.857 MHz. mode_set()
> > then requests 84.857 MHz from VPLL, which the PLL rate table snaps
> > down to 74.25 MHz, and the VOP ends up on GPLL/7. The panel receives a
> > timing 0.75% slow, which some monitors misdetect (e.g. as 1195x768)
> > and display distorted. Only modes whose clock happens to be an exact
> > GPLL or CPLL fraction (74.25, 148.5, 297 MHz, ...) were unaffected.
> >
>
> Did you designate VPLL as the parent clock of the VOP dclk in the DTS?

No, and it isn't needed: in the commit phase the encoder's
atomic_mode_set() sets the VPLL to exactly the pixel clock before
vop_crtc_atomic_enable() sets the dclk (mode-set runs before enables
in the atomic helpers), so by then the dclk composite finds vpll/1 as
an exact match and the mux selects VPLL by itself. Verified via
clk_summary on the patched kernel: vpll =3D 85500000 feeding dclk_vop0 =3D
85500000. Pinning the parent in DT also wouldn't have fixed the bug -
without CLK_SET_RATE_PARENT the check-phase clk_round_rate() against
the still-stale VPLL would return the same wrong value.

See clk_summary for broken and working cases attached.

> > @@ -327,6 +327,12 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_e=
ncoder *encoder,
> >
> >       s->output_type =3D DRM_MODE_CONNECTOR_HDMIA;
> >       s->bus_format =3D bus_format;
> > +     /*
> > +      * The reference clock (e.g. VPLL on RK3399) is a parent of the V=
OP
> > +      * dclk, and mode_set() programs it to the pixel clock, which
> > +      * mode_valid() already guaranteed it can produce.
> > +      */
> > +     s->dclk_exact =3D !!hdmi->ref_clk;
> >
>
> What about RK3328? It uses hdmi->hdmiphy_clk.

RK3328 clock ownership is the inverse of RK3399's. hdmiphy_clk is only
ever consulted (in mode_valid()); the encoder's mode_set() programs
just ref_clk, which is NULL on RK3328, so the encoder never sets the
PHY PLL - the promise dclk_exact expresses ("the encoder will program
this rate itself at mode_set time") wouldn't be true there.

> >  static bool vop_dsp_lut_is_enabled(struct vop *vop)
> > @@ -1558,6 +1554,19 @@ static int vop_crtc_atomic_check(struct drm_crtc=
 *crtc,
> >       s =3D to_rockchip_crtc_state(crtc_state);
> >       s->enable_afbc =3D afbc_planes > 0;
> >
> > +     /*
> > +      * Round the pixel clock to what the dclk can really produce, unl=
ess
> > +      * the encoder will program a dedicated dclk parent PLL to exactl=
y
> > +      * this rate at mode_set time. In that case the clock tree seen h=
ere
> > +      * (with that PLL still at its old rate) would pick a worse, inex=
act
> > +      * source and bake that rate into adjusted_mode, defeating the PL=
L.
> > +      *
> > +      * Same condition the atomic helpers use for the mode_fixup callb=
ack.
> > +      */
> > +     if ((crtc_state->mode_changed || crtc_state->connectors_changed) =
&&
> > +         !s->dclk_exact)
> > +             vop_crtc_adjust_clock(vop, &crtc_state->adjusted_mode);
> > +
> >       return 0;
> >  }
> >
>
> What about other display interfaces? For example, the .mode_fixup
> corresponding to cdn-dp will not be called.

The rounding still runs for cdn-dp and all other interfaces: it moved
into vop_crtc_atomic_check(), which is a CRTC callback and is invoked
by drm_atomic_helper_check() regardless of the attached encoder - same
as the old CRTC-level .mode_fixup was.

Regards,
Vasily

--0000000000004dc8c0065a9b8ce3
Content-Type: application/gzip; name="clk_summary_1366x768_broken.gz"
Content-Disposition: attachment; filename="clk_summary_1366x768_broken.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mtm2q4y10>
X-Attachment-Id: f_mtm2q4y10

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
--0000000000004dc8c0065a9b8ce3
Content-Type: application/gzip; name="clk_summary_1366x768_working.gz"
Content-Disposition: attachment; filename="clk_summary_1366x768_working.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mtm2q4z61>
X-Attachment-Id: f_mtm2q4z61

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
WQg0jECfexbn/wN3/7UIj+UBAA==
--0000000000004dc8c0065a9b8ce3--
