Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B20C79F99
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 06:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CB810E364;
	Sun,  6 Sep 2026 06:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="xtTgZ+73";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56CBE10E364
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 06:31:36 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so401161266b.1
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 23:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788676294; cv=none;
 d=google.com; s=arc-20260327;
 b=XC0eOCsmJcFQaeToQEKH4qgpjINctM83Q0Y5yET+EpWZ8lRmQpZT3UzJ7FIkDaDV3R
 MjVCTJqVuw1zR+ZlUVjqXNR9ETxWh6EB4FCiQC2RLITlEHzUzeLZsbz+QCpw4EZWMsi5
 znb11ccmzY244z34M6no6F2ac1N3ZoQ3JTBYmYqv/vdXou4QXGcnzoK7kWmLzxQP+TPr
 sc1Z++bZAcT6gB2XQ9tHhaRyG0yyTHk8TDFjYP9P51CD8mn6gYe4fvvi0JjaoK3p0fjf
 8fWqxYTkrirtllTz+4Xv/6YYGqIP9W8sjHJLSRQkU3rGRLXXSKXwqjX4Fr6nN821tPyr
 eKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CowhusBJtkVgTxM1sMewOhXaozR9ys1uAKwcRp0eiRc=;
 fh=v6y1fyyZP+ZnUQ9bGifn7F4kG75mvWcK+v87gM/awfU=;
 b=i63kCF/9IhB6uP8heGoKE2cNUsdPSPvnulODbvjAhEJh3TDhgT9wjxBzTPDtyxEGVb
 J+TwczkgeBIU85SppVsguisLytB3k7govW26PdW5m4scNzupjgym/2B92KsxfnE8a8R1
 b6lNaDgMRCpVfWZV5XaQE1x6i7te+pZWKIn+KfP0hKrP5VOeVu+nzBBeSAMyFtTq6cB2
 6+YbuZldX0lhnjAQBX7dZtiQb7ltfosj28BmZ+OfVpLo9FLyAQ1bSkIcRF3V0BbVrIpA
 jDw4eenzgkSG8WiofD5U4PiAltjS92QYZu6yWp6PlkSPAu0bmZlLf44byUMrjVGqmOF8
 CN/A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788676294; x=1789281094; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CowhusBJtkVgTxM1sMewOhXaozR9ys1uAKwcRp0eiRc=;
 b=xtTgZ+735Lg1mjzJ5H5Th0duho7fQrylA0CZ90+t6KYluRlV6ir+k6izlnJDjP3VQy
 eE2Z0mj2WZ8M7xXfKb05haVzFLpbVVlJH0GjDqo9OP9DrqSS+r4XE9v/PCByIrTOiMpk
 zlT/Tfm+l9JlT9Z9AvKZdCsz4TKirKanNeJPbxxTDZpkB+O4Vy++CQaMM0NpXFbXG/5u
 +Zsjj3rRR08/Ye41PrnNWyWNuy+GPpBePQ+4BdR9Kv+ufRJJEYmF/b4Q0kwggPNQDP2X
 nXGakYXVhVixm46SZhCxHr53cBjHjtYprehoiBmRcxbZ1XzOOdHAdZ8MfeJZk7y/1gIu
 qkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788676294; x=1789281094;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CowhusBJtkVgTxM1sMewOhXaozR9ys1uAKwcRp0eiRc=;
 b=IBW4/uH/rqtMkMvWPrqh1NPK7T8P7BelKaknMoryvEFwkTO6WKRCoPKWrAfy+5Tix7
 hP7oJceNzvmVZ9iqfR6s668cfvX5H2PcyPj4UcLvUz+YAj4pIpddxs3viDERb0JcK4Wr
 8g1zicLGNAIf8F1I4dnzz413rtLKS/tcmQzzQqIY5y1jOgIHLYpgywC8KVAuCOC2Btz+
 maaeNlazZsKWvoR7qhPllQmlh9Pq4djyzyXAryKY74vfphIjLKbjtlahsAGNTL9QhJBd
 ksPWfVrc5gCHU7QKrJV7byoSBHKRhuQjXfGTEIWbgOGdufFR00mnQvPeZlZqfOXtJmm0
 +2rw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq1wtO644ZVABieY3r2lgcoBsh20x/yhy3fjQcu9USohmFykcTepYN712bywLngl0RIX1W4WzVtGc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kj3y4ZnzpOjwIk/ZrzVGMxHnQqZwabfyJlgCgux4LW9g+PhgF9
 e+1+MBFmw995bP0wl87Q6jAOztT/E8Kuj8+f7umOxhwzMsxyTOGk/V5Tju7nMlHD73KCAd2waCU
 XqQIv1VU/9Cx3NitjKEGACTr1y+HGGZfirqEoyxD3PA==
X-Gm-Gg: AYBFou0J7S7sFA9Hx5XhsrZAi9MlWK3UZEAeHip+wxTd4jmy2R4fK4NnbN3mMpYQSEb
 7mZE+XLqJPYfFGvii3l7+uiLpu/UIsWgdvosPiBwGm0+kLe7V2cN22mCYua6nfPNvbk1W+9+rDF
 98drhhXcc70FkU694tbQiU0dUidbiYm+eBfwxeL5cy8tFqb8bUh91eHHEYZTC0iZTFIBPTnJaXN
 J4fKSvAGzETvZiPtUXq8pB3spMvVbgKkcNM7yrUrHFpiFQstcxQTj+kDzsevsHJ5gvzfV9qva8h
 P/ZiimDW3kV0dD5OI7Vyj6hK/cEU1oLe/tvApRjlCHl9WEFc6AeeXHofVeWI3Cnsj4LEXszx+Hr
 +ln8=
X-Received: by 2002:a17:907:c80d:b0:c25:f7dc:2d5 with SMTP id
 a640c23a62f3a-c25f7dc0956mr720225966b.22.1788676294144; Sat, 05 Sep 2026
 23:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
 <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
 <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
 <CA+E=qVcwtnU_Gg6_oFmWqMpCEF8vOvB_G+H-ihfbiAr0PpFUJw@mail.gmail.com>
In-Reply-To: <CA+E=qVcwtnU_Gg6_oFmWqMpCEF8vOvB_G+H-ihfbiAr0PpFUJw@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Sun, 6 Sep 2026 10:31:23 +0400
X-Gm-Features: AcwNN1WMMbAQ2CuZOa8tZDe3nBXerl1P7S6WAcKAg4su3ebkGU8XnfBv_73Boic
Message-ID: <CAKTNdwGTacFvn5BEN+iu0OBG2BUas7Vfj=YYF8OhAhNq-9kmyg@mail.gmail.com>
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
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, Sep 6, 2026 at 10:09=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.c=
om> wrote:
>
> On Fri, Sep 4, 2026 at 2:36=E2=80=AFAM Alexey Charkov <alchark@flipper.ne=
t> wrote:
>
> > > See arch/arm64/boot/dts/rockchip/rk3399-base.dtsi, hdmi ref clock is
> > > wired directly to VPLL, and dw_hdmi-rockchip calls clk_set_rate() wit=
h
> > > pixel clock for ref clock, see
> > > dw_hdmi_rockchip_encoder_atomic_mode_set(). So at least in the rk3399
> > > case VPLL is supposed to support the required pixel clock. Without th=
e
> > > first patch 1366x768 mode with 85.5MHz pixel clock is just rejected.
> >
> > I strongly suspect that the dtsi doesn't describe the real clock usage
> > here. The TRM for RK3399 doesn't show any "ref" clock for HDMI, and no
> > TRM-documented VPLL users look like anything that could connect
> > directly to the HDMI controller.
>
> See "1.1.11 HDMI Interface", it explicitly mentions 13.5=E2=80=93600MHz i=
nput
> reference clock

Which matches the pixel clock (dclk) range for HDMI 2.0, so nothing is
disproven yet

> > I believe something is hardcoding the divisor (or leaving it at the
> > power-on default) in the actual DCLK of a VOP which the HDMI
> > controller uses, instead of modelling it properly as a mux (frac/div)
> > feeding off VPLL via another mux - both perfectly representable in the
> > clock framework and already envisaged in the clock driver, making the
> > PLL table patching unnecessary.
> >
> > Can you please try re-pointing the "ref" clock at DCLK_VOP0 (or 1,
> > depending on which one your HDMI controller uses)? Your clock summary
> > already shows that something is assigning its parent to DCLK_VOPx_DIV
> > and the latter's parent to PLL_VPLL, so rate changes the current
> > driver code does on VPLL propagate to the muxed and divided downstream
> > consumer as a side-effect rather than as an actual rate request.
>
> I don't think it is a reasonable ask. Wrong clock for the HDMI encoder
> would just result in non-working HDMI output and no feasible way for
> me to debug what is wrong.

Hope you have a serial console or ssh connection to the board. If it
doesn't work you'll know soon enough.

What I'm pointing out is that the clock setup implied by the current
dtsi doesn't make much sense: VOP's dclk is driven off VPLL via a mux
and divisor. If the encoder's pixel clock is truly driven directly off
VPLL then Rockchip designed the muxes and dividers for nothing, as
they will always be no-ops. This doesn't square, so something must be
wrong, and I believe it's the dtsi.

I'll be happy to be proven wrong here.

Best regards,
Alexey
