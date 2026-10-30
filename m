Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12788606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=OtVYgBfD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3DBB11267D;
	Fri, 30 Oct 2026 08:00:11 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C21112686
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:00:05 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c450ab1483cso59214266b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793347204; cv=none;
 d=google.com; s=arc-20260327;
 b=d4/OIILGQzOgFNvkOroY347DLoTascj1t7nDFKsBaLrv3R6oZ7w//b60re5WxurBxR
 dA4p1Voi2yL6Wdf3ZfLTYdiFPMBZhrgV0b5RvBqVgveYH2TI09+d07UOvhEdtt7qn4ab
 GYxcbPzIfE9/+NAvPGrV3IklaUrXUgcJEbCM1Ia8X122GVhnmYgne+iIVjuNJDBCTTib
 cI91vVN9JdHRcmTPnrEUYbVfEytRTt+VNDR8hmCSsuvvXldeXP3VDej1V+pc9R4Aor1A
 LTbu8YnaopKgtQHNO5PMgzte2Zz5DeKqanssl5WqN1TrKxoCrObGZFMIGPLeOiDMTS7k
 O4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q/eIx/IUOdi7y2UVsh8BBzkkFOgj24Cn4YadoL10m2E=;
 fh=8a6VOJw/eB22jbsCrSP/acKZnDekMflw4Kws8OAGS6Y=;
 b=sW6VMXDCl6KG9cPJzdjO9bWNKrhfJ6YWiYUIVPZ3C9lyzq/9J9ajx4q1eoZMyFsCSg
 lmVxpOY4tnd4hLYrJdGEzEDcPDn/ToGpO+9a0UivaodB3c1C2Od9JLC/Z2M78nap01WW
 WXanjblfO6ftWXP2DFq4CwL9VNlYUVrFYY2ImDBQNOR5uZ3aIr/Yodx/zgNgWCgazSUC
 c5ba0+S6sor7uvMAqlcPL5Ha5F2hE46LtjG7uLktrYifzi9ym9w9Zi0VY/0Vr6dLX3ag
 +A1/ffRaceb61qIqXTwK/ovRlnZApSz7cXG0JQ0KqNeZogCMkHNCg+30APCa6HHLsDcg
 LNmw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1793347204; x=1793952004; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q/eIx/IUOdi7y2UVsh8BBzkkFOgj24Cn4YadoL10m2E=;
 b=OtVYgBfDGc+mQGBTsXLu+P9I01+6lG0bRfeHs2Lpgcid1fKERbnooV40l1JtszREsc
 hi+zyLVS0PdkYjN8Xi+ex1K6aYIkC/QTQMxDjDcaG4o40E8swX+HnSYXGO0CSaXLHcqk
 Oyi02dGrCIPOuGUfai0LVwqTdGdRvSor5OxPMEFVFny4ETmTcFRxJEniY66kDhyK188y
 18Zaln2tAoM/OEU65uwjyeu9+j3jJhQHOvAtpqL9ysMEwOXxXRY/C5anuEuIbXM+WqT1
 p+AfVyf7O2LZ6Fejoxa0jm6K1G+xsazwwrwzjJzictuAIPR0F/Lt5XgHiShFq9UPIwsu
 MpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793347204; x=1793952004;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/eIx/IUOdi7y2UVsh8BBzkkFOgj24Cn4YadoL10m2E=;
 b=WUvWuD2JBPlQqqpCGZ4LsbbUmQM8J2UdCkfS29/BSvj5FcRsIlIhyW0Wy2F+FBlW7a
 yx57cF9lsESDqacPv5Sy0opyjPwVhl/QZ3D94JMlMDHiZNBnnYhen2QrkG3DRfIH3pIx
 js8o/po1f6Gv2T8OZSZQljF9MRwtlyYggxg4BHQNczf0oIB8bsIm13JYc6PKRjdIeFNK
 JwKuXQOy+YEiI+X/s/JCmh2yz4913WF3IKds0UkTRCKF5Aq8wAj7ggEGuV+iE2bl8AQb
 Sfy0/9iCnpUySZ4FV683RdcQCzDyQntoi2/+vTXdPce24qOsrUOEfCiMF3KVM8JAtMK1
 FAKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxF5fxHDNB5zyAaavTMCXO89y40Yu2KFO4vHPT7ntPKyp5TFl5zAXLk0exPJFrJO52opJU9vF15+5s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLl/MgmWAlShqRUhAlezNuGRWk+2pnPEm/oKl4e/lLSJAfroFbs
 /EMDFWkiq38hBhOO9KP8CIrMOiDpgmOen0nKAPE9+tfm9AuKv9l5TOWB/O+AWFeXlbV4fbCzxis
 idKooaR+MQLLc0NuLanZT1QK1Gy9Si7IP0p9KMHxqpA==
X-Gm-Gg: AYBFou2rhUA7E++fQimUUvaphBAtQldBb13ImIIIA15ApLre/BPjJN6PK3EG6Erhr8g
 +Fl7X4Ar9fZ9YnPR7w6KM+uyDi86b7xCJKPh9MBbDEj0IWHvV+kx03W3kN0XlrqRyxqHeXkk524
 cLuO4dlffmx/RMvdtIwnkVDoH5Qh+ofKoMKCEkdAqxjVIvTInDgRPza0Sur8reIWLrgE2BM4WvA
 Nf8499b1DdTXvSuGdA6P1YVfkqQHVOz+Ji9QGyMJ1742QJs0hNaqSnCJMwGIZnfP5lBM1oPfYj3
 tSV9PZXZDI8ZnZNzF3kgC/g+OEjjscUEk822X1hPzZBr5YDXKwmnGg+7V/MWkhmH0wA28MWcVRb
 8QC2ZHboaVANd/XT02EdKCeN8VT6hw0PEB5ScsaIVvqspTwG+xPJdLGgiJy5BgI8hOxUYwA==
X-Received: by 2002:a17:907:c23:b0:c49:cfcf:8d7f with SMTP id
 a640c23a62f3a-c4ca7ae8ad6mr121607566b.46.1793347203897; Fri, 30 Oct 2026
 01:00:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
 <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
 <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
 <CA+E=qVcwtnU_Gg6_oFmWqMpCEF8vOvB_G+H-ihfbiAr0PpFUJw@mail.gmail.com>
 <CAKTNdwGTacFvn5BEN+iu0OBG2BUas7Vfj=YYF8OhAhNq-9kmyg@mail.gmail.com>
 <CA+E=qVf=oBf9a=nrN-F2gGGY60+Gfuj3NMvuW4pWAdbU6NKceA@mail.gmail.com>
In-Reply-To: <CA+E=qVf=oBf9a=nrN-F2gGGY60+Gfuj3NMvuW4pWAdbU6NKceA@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 30 Oct 2026 11:59:55 +0400
X-Gm-Features: AclHuK80eGfXzrhDU1BJmzUNyq0YUUcHy3czLcESvjD2RbRa1URB1Gh73rfRLng
Message-ID: <CAKTNdwEiNjjX3DgBm5whH0HHvAfZQFgF4LhKf7PJ+1p7MJ=QJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: rockchip: rk3399: add 85.5 MHz rate to PLL rate
 table
To: Vasily Khoruzhick <anarsoul@gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vasily,

On Fri, Oct 30, 2026 at 9:01=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
>
> On Sat, Sep 5, 2026 at 11:31=E2=80=AFPM Alexey Charkov <alchark@flipper.n=
et> wrote:
> > > > I believe something is hardcoding the divisor (or leaving it at the
> > > > power-on default) in the actual DCLK of a VOP which the HDMI
> > > > controller uses, instead of modelling it properly as a mux (frac/di=
v)
> > > > feeding off VPLL via another mux - both perfectly representable in =
the
> > > > clock framework and already envisaged in the clock driver, making t=
he
> > > > PLL table patching unnecessary.
> > > >
> > > > Can you please try re-pointing the "ref" clock at DCLK_VOP0 (or 1,
> > > > depending on which one your HDMI controller uses)? Your clock summa=
ry
> > > > already shows that something is assigning its parent to DCLK_VOPx_D=
IV
> > > > and the latter's parent to PLL_VPLL, so rate changes the current
> > > > driver code does on VPLL propagate to the muxed and divided downstr=
eam
> > > > consumer as a side-effect rather than as an actual rate request.
> > >
> > > I don't think it is a reasonable ask. Wrong clock for the HDMI encode=
r
> > > would just result in non-working HDMI output and no feasible way for
> > > me to debug what is wrong.
> >
> > Hope you have a serial console or ssh connection to the board. If it
> > doesn't work you'll know soon enough.
> >
> > What I'm pointing out is that the clock setup implied by the current
> > dtsi doesn't make much sense: VOP's dclk is driven off VPLL via a mux
> > and divisor. If the encoder's pixel clock is truly driven directly off
> > VPLL then Rockchip designed the muxes and dividers for nothing, as
> > they will always be no-ops. This doesn't square, so something must be
> > wrong, and I believe it's the dtsi.
> >
> > I'll be happy to be proven wrong here.
>
> Hey Alexey,
>
> Sorry for the long delay - NVMe in my laptop died and I had to wait
> for a warranty replacement to arrive. I would have bought a new one if
> the price wasn't ridiculous :)
>
> The dtsi describes the hardware correctly. The HDMI PHY's reference
> clock input (TRM Part 1, 1.1.11: "13.5-600MHz input reference clock")
> is wired to VPLL with no mux or divider in between; it is not one of
> the CRU clocks in the TRM's clock tree at all.

The TRM unfortunately only says there is an input reference clock but
gives no detail on how it's wired.

> That's exactly what the commit that introduced the "vpll" clock says,
> from Rockchip's own engineers, see 5e3bc6d1ab48 ("drm/rockchip:
> dw_hdmi: introduce the VPLL clock setting")

That commit indeed mentions that there is no divider between the VPLL
and HDMI PHY. Looks like it's our only evidence, but I believe we
should trust the information in Mark Yao's commit message, given his
Rockchip sign-off line.

> This bug report itself is a solid proof of this wiring. With VPLL left
> at 74.25 MHz and the VOP on GPLL/7 =3D 84.857 MHz, the monitor reported
> the mode as 1195x768. 74.25/84.857 =3D 0.875, and 1366 * 0.875 =3D 1195.
> The TMDS clock came from VPLL while the sync timing came from the VOP.
> If the PHY were clocked from the dclk mux output, that mismatch could
> not exist.

Fair enough.

> The mux and dividers are not for nothing: there is one VPLL and two
> VOPs, and each VOP can also drive eDP, MIPI DSI and DP, whose PHYs
> have their own PLLs. When VOPB drives HDMI from VPLL/1, VOPL has to
> run from CPLL or GPLL through the divider, and the fractional divider
> exists for DSI panels with odd pixel clocks. For HDMI the divider is
> legitimately 1.
>
> This is also why the PLL table patch is needed under any scheme: the
> RK3399 PLL driver is table-only (rockchip_pll_determine_rate() snaps
> to the nearest lower table entry), and the PHY reference has to be
> 85.5 MHz exactly because nothing between VPLL and the PHY can divide
> it.
>
> And the VOP patch doesn't hardcode a divisor. The VOP still makes a
> real clk_set_rate() on its dclk at enable time. The bug was ordering:
> mode_fixup() rounded the pixel clock through the dclk while VPLL was
> still at its old rate, so the composite chose GPLL/7 and the encoder
> then asked VPLL for 84.857 MHz, which the table snapped to 74.25 MHz.
> With VPLL programmed first, the composite picks VPLL with divider 1
> because it is the exact match.

Ack. Thanks a lot for double-checking all of these - it's great to
have your explanations recorded on the mailing list for posterity!

Back to the patch itself. The new rate you're defining is consistent
with the existing entry for RK3036_PLL_RATE(1368000000, 1, 57, 1, 1,
1, 0), and the parameters are within spec (VCO rate of 1368000000
falls within the documented range of 800 MHz to 3.2 GHz). Feel free to
include my:

Reviewed-by: Alexey Charkov <alchark@flipper.net>

On the existing 1368000000 entry, I'm pretty sure it would produce
less jitter as RK3036_PLL_RATE(1368000000, 1, 114, 2, 1, 1, 0), by the
virtue of FVCO=3D2736MHz falling into the higher end of the allowed
band. This won't apply to your 85.5MHz rate though, because the
required divisors won't fit in two 3-bit registers.

Best regards,
Alexey
