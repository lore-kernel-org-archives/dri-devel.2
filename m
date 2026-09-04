Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB02DC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E0410E15C;
	Fri,  4 Sep 2026 09:36:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="L+qz96lB";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20BDD10E15C
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 09:36:44 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso122375966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 02:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788514602; cv=none;
 d=google.com; s=arc-20260327;
 b=NtOw6BVyVZVTcF/3+IVD8rtvK/3L+07FnKnOwxe05g83KEz6f7sQLy81leKA3vLMRX
 lqaQkPP9QcvuZkAii7Tqcz1vWjQ8enE8NA+r3oLsqg659fnGmpog2JELXBpz5lJs5NUw
 YCiumBmfEK5hO4fpqSy4gr1SvenaIoaI/NtG4srTJEVPuKQ4BQzWWYAlKl4amWcQJ+Pb
 ZkagU9uOP3cWxn2HiRDLd+deUBZZvIpoaeatIMIxql2Otap1imQc/peewn3Gn46o/s7c
 nCLG1WGC9iayr/suLbopc3CqKSNavfeYj6DlYaE2R7PUlTqUQQ6QX+FTj6wSOHNXd/Z3
 JEVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=foFTrG5K5GBINGP1ISszqyndvxgyaNt7XJ7LpKu6ReU=;
 fh=kskjI81FZcmGE7S6dHUDkG6d7ZMKLLfNiciWUW+RuK8=;
 b=flRt+9vdKHwpd8sJASQ7I1+YdNWRh5s+fxrH6U2GVPofatntBWqQ6IQwpXz9pJJEmO
 vNSo4nSDhG5cG0+j1AO0JosK+9eaPHuLok+qhkMnSsAStjhbrjuctub/brc3/ei5EBZ/
 5D6RBasmjqVRbiNjNtwtdHVo+FYKJ+4uIZWS3TVX8aq5B2lcjE4sS6Ut05/XxgKudEix
 hdO0WhRYJuHEOVddcIV1L88rnX1fBB74n2QjM74NI8SttiC7W5Xl0vFVZLtYYiPQ5L1z
 uOLhrgeBBVEm3tbrBgz7Yv24f8aDO7f0pqSvH7LuLh613Vf1mNLx79f2oZffH/PwO4Ji
 o3Yg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788514602; x=1789119402; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=foFTrG5K5GBINGP1ISszqyndvxgyaNt7XJ7LpKu6ReU=;
 b=L+qz96lBZ/VdXGmZLMQeUbeN0qVpiMJl2gKwOge/DLcKt/SCWEscpxyPghXOabfmhW
 jI/XCDlD0Aj4iNrepbmcEQvdp6LZbiPgjjp1wOmUzP4oYT9XBFMj3YiotK4SuA0rhBbW
 NCw/PgMelljqNKGSq4U8n2B2bHLDjif36YMvzMm5PsCitxooZWebrRcHS7JSwwsz6z3K
 bjxj9aP/VZRnJXHoQ6hRJkTuE24zpuoSB+4i0iVFXV4o/mvxAsw0YP6BNMle/17cLcKp
 reguMfDRI7cEX40YUH/4tA8LdSk9jXlqX285rzC1ZlOz55L7BLLJ6jAQ3JFEskpVRK4n
 93yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788514602; x=1789119402;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=foFTrG5K5GBINGP1ISszqyndvxgyaNt7XJ7LpKu6ReU=;
 b=eB3m2zD1jJ7H/wRdjYHP4Coa4mjFO+xe4PYw2q9xIvk0mXdKZAgFvTA5hT3PXrXJEQ
 QsicEu64FoKXQ9VgzEUdSS1Ou/NLCO5b5ebSeBg3bMTwH5DHLZYtYwAsWfUYxlTZzzfy
 2P2zoc79pWmKOguLg6D21t5ExS3vLav2XroAyra3IjscIwtiAl5bcoBksi64sbBLhyvp
 vfVay+YjneDgd5yl4eLewXaSz6GjuorFToC1rcbLSt9QI9vW7h2+mVaiY6Dl0NB/ESH2
 PnkSbEGp6oUu6tAM1E0icV0SEhfZ6PmNLH+WeKh5KT0NCElJa4wpNdU+wnAHNVxcbODP
 l2/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEaS0uuO5Od6Z2bVdU4JMaPms6MXKkfICvbIEVUs7PmrvU4CZvYYpqdJcqD6LpBKgD48o+f1PmaGk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lC6uCw2h2YaHyXvBBR1WvBEyFirLUu3Xd0mz8izQ8nlIFnLy1r
 oPMU7jyy0KDUq4535yv31+4IguObOsf20/WaOQNABbrGc/acei2M8U+dlLU/XWfd5luFN1QiZEv
 XENgwtd5pBZKAI9lFO3jRixHDat6Y9A4MV1U/ALryUA==
X-Gm-Gg: AYBFou2sC143Am1INpJVYDMRu9X0hoU8vDLyJY1Qvia1O+WDX9DrUFQomXZoSuQ9T/R
 MHdqCr5CbhxNh0eN1eHuILNSM5Mg8MqNx1UNDFkjIfCd0DE6SHJwKXyiy0d8ueW/i8OhL0Sp84u
 kwNe/6HNDjLxdp+5vg7ChHmw2tvfYLeD20ji32McGRkDwDjktK6Gg2sgsmxnNMHZa6xSPDph9rG
 ZH1H9zZrd2JXw5ltBjsXy0+EBN1z93h0BO7k1xKdqdQBD3gV5ePFHrRChvEo4+/1fLUk9QZ6rLo
 letQHn5/DcVHNjj/jiPhgT/9PRQ73mW2mn/dWrBfXYnoUVy0jHxE7Pw7qk9n4sIZHXi4xri9ucT
 u
X-Received: by 2002:a17:907:fd17:b0:c26:1648:a069 with SMTP id
 a640c23a62f3a-c261648b781mr97301566b.36.1788514602405; Fri, 04 Sep 2026
 02:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260901234351.190506-1-anarsoul@gmail.com>
 <CAKTNdwFqSBt4QVCuYJxTyEDsxkW96JbUirFNAgJYWVLHzGpk4A@mail.gmail.com>
 <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
In-Reply-To: <CA+E=qVcizyQZytw8M6DA72YGrRDDNx_cCvYj565zf9wjMWh8tg@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 4 Sep 2026 13:36:34 +0400
X-Gm-Features: AcwNN1WNG6-4w87ND0ZEi9BFf-EutUvUpsgbnymsPufvucLp1TkkKsdtlvZ3MeQ
Message-ID: <CAKTNdwFQvKtHQA0JD-GAq3bgr5Brq2NyLfccenkHcrKcjeptwg@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 1:59=E2=80=AFAM Vasily Khoruzhick <anarsoul@gmail.co=
m> wrote:
>
> On Wed, Sep 2, 2026 at 1:43=E2=80=AFAM Alexey Charkov <alchark@flipper.ne=
t> wrote:
> >
> > Hi Vasily,
>
> Hey Alexey,
>
> > > diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip=
/clk-rk3399.c
> > > index c2b243d7a5e2..db241d2df625 100644
> > > --- a/drivers/clk/rockchip/clk-rk3399.c
> > > +++ b/drivers/clk/rockchip/clk-rk3399.c
> > > @@ -98,6 +98,7 @@ static struct rockchip_pll_rate_table rk3399_pll_ra=
tes[] =3D {
> > >         RK3036_PLL_RATE( 148500000, 1, 99, 4, 4, 1, 0),
> > >         RK3036_PLL_RATE( 106500000, 1, 71, 4, 4, 1, 0),
> > >         RK3036_PLL_RATE(  96000000, 1, 64, 4, 4, 1, 0),
> > > +       RK3036_PLL_RATE(  85500000, 1, 57, 4, 4, 1, 0),
> >
> > There is already an entry for 1368000000, which is 16x your rate, and
> > the 16x divisor should fit comfortably into the downstream clock's
> > 8-bit divisor field. Do you really need a separate PLL rate? Have you
> > checked what the hardware arrives at with the unmodified PLL table -
> > e.g. via /sys/kernel/debug/clk/clk_summary?
>
> See arch/arm64/boot/dts/rockchip/rk3399-base.dtsi, hdmi ref clock is
> wired directly to VPLL, and dw_hdmi-rockchip calls clk_set_rate() with
> pixel clock for ref clock, see
> dw_hdmi_rockchip_encoder_atomic_mode_set(). So at least in the rk3399
> case VPLL is supposed to support the required pixel clock. Without the
> first patch 1366x768 mode with 85.5MHz pixel clock is just rejected.

I strongly suspect that the dtsi doesn't describe the real clock usage
here. The TRM for RK3399 doesn't show any "ref" clock for HDMI, and no
TRM-documented VPLL users look like anything that could connect
directly to the HDMI controller.

I believe something is hardcoding the divisor (or leaving it at the
power-on default) in the actual DCLK of a VOP which the HDMI
controller uses, instead of modelling it properly as a mux (frac/div)
feeding off VPLL via another mux - both perfectly representable in the
clock framework and already envisaged in the clock driver, making the
PLL table patching unnecessary.

Can you please try re-pointing the "ref" clock at DCLK_VOP0 (or 1,
depending on which one your HDMI controller uses)? Your clock summary
already shows that something is assigning its parent to DCLK_VOPx_DIV
and the latter's parent to PLL_VPLL, so rate changes the current
driver code does on VPLL propagate to the muxed and divided downstream
consumer as a side-effect rather than as an actual rate request.

Best regards,
Alexey
