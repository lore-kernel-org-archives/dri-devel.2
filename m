Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EF606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DkaS8cVk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCD610E258;
	Fri, 30 Oct 2026 05:01:10 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F004710E258
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 05:01:03 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id
 46e09a7af769-82109f51565so157991a34.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 22:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793336463; cv=none;
 d=google.com; s=arc-20260327;
 b=WgG3yTiuiO7+1reqc++mNuvHUgNrNcR7YtvIdhdUlMEKq8A/dfjc0Uk2Ed+Vrok/8C
 u4osRT/iP1k8oKSj27MX6v5iH6jO3ZkzUo6TkKJfk/xng9T8xhAGlO+nYx5d+beakG2v
 1HYFg7ma5wxBvX0lS1bM+7LdawOim8DL1OZyt6Al3o7cpZ8x0oZE6UiiYhDsmlwOK/6w
 7QJ/quOlso1Nl1Ll2olrCvzjKsYnuC5Mh4wcAYA2PoECbHseivDvBHDjjCHUMX957+sE
 9lltI9HtQx6ZAqc0cdDlYQ2nHGXd9M6Z/lfBEJcVYFpkgf1yUpbNDwH6RO8zXZjIiswZ
 F9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jVHkdup9h6VAyVXa9WHVnyDXMjAy2tnvxXwmB5v5HJk=;
 fh=AcxL+9QJ6E8QRlcI419WrzZvP3+g+7wqfJS2wwfGjaQ=;
 b=SdP63pDcJLCSqr5ncq3yw3H38fbJa6ua0PluHWrt0pEUsZSBBeXjM+d5cb6LFHZLvn
 TDpR2b7KkTXkYg6xfVdqx5UALSm4W0Qi+4cxL0d+qveAshIWh/Hx71cpTuBhnFCQMTwa
 HzhgS31Bt2/OCE0Dr5c65audBUvKTlG1N6ZtQNtnLc+cIfCPE04Ho+ekP3zAdYfeJTGx
 jMWuohK/T9Q09K+A7BPQ7bCTGAOHksxZMoaF+7BVnVX8bilsJW1L4zas3n/IWUqrNHHc
 /byM0X+8VkvMPvM7q+zpJ3MgKg/fZVtfJ//RvmE26QFghpZYtQWaEbjQlOHCnEcd+Qxa
 N4qQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793336463; x=1793941263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jVHkdup9h6VAyVXa9WHVnyDXMjAy2tnvxXwmB5v5HJk=;
 b=DkaS8cVkXgv7dP39bdEqV74L/68hW9SlopieYoh6BgjjH8jcJ7W8/wYxyT+TB/0nLB
 YCDj0+wbb5Obs+d8p46jweX6/SbMbink1ri3wyk7IyWZkdJ9+3ksIaddD3HqWttw0ZSv
 7egu6fSkPMidoQqRfygCfky5Lnmh/QOKvijsPV2MJ3dQ9KzjKH0eRAeKb5IG4MBTj15F
 T201OklynDg6ztHkPYaKd0A8Z7FPuKaaAbJtsp0RBAtgxXoSTE9gKevQPKzfR7L3GHty
 TKzwwEyiG+nD3mxEfrFu8TzAI4S5Ozpf3ctzmtgOEWi99TDWxLYXkj/5Ic62dsQXWQte
 KNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793336463; x=1793941263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jVHkdup9h6VAyVXa9WHVnyDXMjAy2tnvxXwmB5v5HJk=;
 b=qxC2I0F+tCtoivw773hSjMRLt2NoH0UeWZUAALJdW2YE07aMXYCNl6LoP+6C780bxg
 10rGHijLfGPPAawtdfxHnUwjHGgigHrOrPss/SgycQ5o2SDma/O9DsZ0H7xYagYlYZ0T
 7lC6uVQiHmzs4ACBnvd1cZp5vth6qkx95x52Z3ZV1XzGK0iRNEmTjSB33tc1tnb+U+1B
 OfWhIA9D8rj9axnp/VcJWIagGauwQrquDrXjo+rbq1TyAEWF4r0DSxGmQLmr6Ni6sI9N
 OgUQq/k/U8w8Vp4cK4NrTjRGPVMh7vItCd+Pw99ENW/h2ScZ/RcBZHGjvcH15SEyOrt8
 zjgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0gspmBLcI7O/rffWc+VZISUsF32FLuuz7cutk8t7iZCBgPnO+Gy/j8IDCaMQ9ko5DGkEoVT1yfcc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLrSEM58fdYLL9bzz4CfBKr+akQRyjDmT4dha+7qUeTnh3VZIPa
 Hszpvt1QkTmxEn3QxHDZkJKn1mR8tTAtfYmtX/99IHjDv6PGxsipJFoj2ieOvm430+S6yN4iDJK
 CbvuVIW3vKIBO15EPC+mmrZziOpiMg8g=
X-Gm-Gg: AYBFou0YhHpZRqlMP4iwKo7yLP4KHr+VpkuZupqe8XLR7Qs01HFjrj5/IZbLuwftIm/
 Gk+cLdfvPgbb+TOtPe2aIFlNagHPDiG56tY3Py9+EFpSsEnFRfpLc/YNJsMxRh1T90y4SCPeq8L
 jjCgEi2WwwVm8ze+XD15QSQtgZy1RJa/LRoSUhc3I/BCyCFTsJgpaF+bQMxQIQ+ooRZ/vXrqWSu
 N+dzipHdoz3tENeSR9IYVUtU0QOeMUBdqnvhh3vmhiGVef7OfcILj0vSC+iGgxAGCnGxCHLV5tA
 kbmkHsTSDY6mOMhnjniVCrveRdhiLgtlU5TC4WOcxgu/eBWnlj8kyvLlK2+MGZ4cS8EDlLqLiCr
 /vwGSFGiDcsvv5p1AM89Czb/z+2LdDeoEZLI387DsVGXP3Urq5FjKp/wbm2Pa7fGIeswt+g==
X-Received: by 2002:a05:6808:c122:b0:55e:fa63:7001 with SMTP id
 5614622812f47-5640ddca9edmr954504b6e.36.1793336462734; Thu, 29 Oct 2026
 22:01:02 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
 <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
 <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
 <CA+E=qVcwtnU_Gg6_oFmWqMpCEF8vOvB_G+H-ihfbiAr0PpFUJw@mail.gmail.com>
 <CAKTNdwGTacFvn5BEN+iu0OBG2BUas7Vfj=YYF8OhAhNq-9kmyg@mail.gmail.com>
In-Reply-To: <CAKTNdwGTacFvn5BEN+iu0OBG2BUas7Vfj=YYF8OhAhNq-9kmyg@mail.gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 29 Oct 2026 22:00:36 -0700
X-Gm-Features: AclHuK91Kq4AK7MRfCEoN-bxDWWEQLSESXtbozHlwJea6SWMh0uWvQ7bm47NBQ0
Message-ID: <CA+E=qVf=oBf9a=nrN-F2gGGY60+Gfuj3NMvuW4pWAdbU6NKceA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: rockchip: rk3399: add 85.5 MHz rate to PLL rate
 table
To: Alexey Charkov <alchark@flipper.net>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Sep 5, 2026 at 11:31=E2=80=AFPM Alexey Charkov <alchark@flipper.net=
> wrote:
> > > I believe something is hardcoding the divisor (or leaving it at the
> > > power-on default) in the actual DCLK of a VOP which the HDMI
> > > controller uses, instead of modelling it properly as a mux (frac/div)
> > > feeding off VPLL via another mux - both perfectly representable in th=
e
> > > clock framework and already envisaged in the clock driver, making the
> > > PLL table patching unnecessary.
> > >
> > > Can you please try re-pointing the "ref" clock at DCLK_VOP0 (or 1,
> > > depending on which one your HDMI controller uses)? Your clock summary
> > > already shows that something is assigning its parent to DCLK_VOPx_DIV
> > > and the latter's parent to PLL_VPLL, so rate changes the current
> > > driver code does on VPLL propagate to the muxed and divided downstrea=
m
> > > consumer as a side-effect rather than as an actual rate request.
> >
> > I don't think it is a reasonable ask. Wrong clock for the HDMI encoder
> > would just result in non-working HDMI output and no feasible way for
> > me to debug what is wrong.
>
> Hope you have a serial console or ssh connection to the board. If it
> doesn't work you'll know soon enough.
>
> What I'm pointing out is that the clock setup implied by the current
> dtsi doesn't make much sense: VOP's dclk is driven off VPLL via a mux
> and divisor. If the encoder's pixel clock is truly driven directly off
> VPLL then Rockchip designed the muxes and dividers for nothing, as
> they will always be no-ops. This doesn't square, so something must be
> wrong, and I believe it's the dtsi.
>
> I'll be happy to be proven wrong here.

Hey Alexey,

Sorry for the long delay - NVMe in my laptop died and I had to wait
for a warranty replacement to arrive. I would have bought a new one if
the price wasn't ridiculous :)

The dtsi describes the hardware correctly. The HDMI PHY's reference
clock input (TRM Part 1, 1.1.11: "13.5-600MHz input reference clock")
is wired to VPLL with no mux or divider in between; it is not one of
the CRU clocks in the TRM's clock tree at all.

That's exactly what the commit that introduced the "vpll" clock says,
from Rockchip's own engineers, see 5e3bc6d1ab48 ("drm/rockchip:
dw_hdmi: introduce the VPLL clock setting")

This bug report itself is a solid proof of this wiring. With VPLL left
at 74.25 MHz and the VOP on GPLL/7 =3D 84.857 MHz, the monitor reported
the mode as 1195x768. 74.25/84.857 =3D 0.875, and 1366 * 0.875 =3D 1195.
The TMDS clock came from VPLL while the sync timing came from the VOP.
If the PHY were clocked from the dclk mux output, that mismatch could
not exist.

The mux and dividers are not for nothing: there is one VPLL and two
VOPs, and each VOP can also drive eDP, MIPI DSI and DP, whose PHYs
have their own PLLs. When VOPB drives HDMI from VPLL/1, VOPL has to
run from CPLL or GPLL through the divider, and the fractional divider
exists for DSI panels with odd pixel clocks. For HDMI the divider is
legitimately 1.

This is also why the PLL table patch is needed under any scheme: the
RK3399 PLL driver is table-only (rockchip_pll_determine_rate() snaps
to the nearest lower table entry), and the PHY reference has to be
85.5 MHz exactly because nothing between VPLL and the PHY can divide
it.

And the VOP patch doesn't hardcode a divisor. The VOP still makes a
real clk_set_rate() on its dclk at enable time. The bug was ordering:
mode_fixup() rounded the pixel clock through the dclk while VPLL was
still at its old rate, so the composite chose GPLL/7 and the encoder
then asked VPLL for 84.857 MHz, which the table snapped to 74.25 MHz.
With VPLL programmed first, the composite picks VPLL with divider 1
because it is the exact match.

Regards,
Vasily
