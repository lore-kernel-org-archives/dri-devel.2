Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA6C5AE5D
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03C4B10E66F;
	Mon, 10 Aug 2026 06:38:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PI1vblHQ";
	dkim-atps=neutral
Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1B4110E43B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 14:29:29 +0000 (UTC)
Received: by mail-pz2-f0.google.com with SMTP id
 41be03b00d2f7-c96739a46acso246387a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786199369; x=1786804169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7CZYGhkXjoLPOZDdCP+ZBeQkJbqW9Nm3A99Ju9rkXbI=;
 b=PI1vblHQ1AGUyE941z+IJbAW3LiRWEsod1oRK2uIxN6ZCB3qKMEJPOm8HllF3Y80Z+
 vQ4h7gtdu60nM/YKkVHRg4osdnwqXL7yqiZvOubI07+QmmbOVMLibt2wyPlOwz8IDe95
 ZzH7kpW61Xea4HbOEvHqO9ACkzvIN01IOKQC7N5P/n014dzIRevMS4iftq0OZj08YXIN
 l9qhm6BVr6m/Mm5KbT6IzcnWNfkiRsVwGNsaVcAW8zzCveQsmGaKqkqOi2knDvsIOluZ
 Lk8jJudpcGAJrca5C+n3X7epRou5iABDPpNu1dRjnQ7diuH7HJsff6tGEYxc9pK79gHM
 Y96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786199369; x=1786804169;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7CZYGhkXjoLPOZDdCP+ZBeQkJbqW9Nm3A99Ju9rkXbI=;
 b=Hk4f/6SvzdFBW6eeaV4wYysGsiyFkLtG43U3I3PG0diyPy6YfQXNZO1JavBL+TIX7N
 ZF9QjrVHGSl4IxjLpCh0uk5Nuj++0rWJG1nUUfZxshVqiwJLwKSCY2EZWoHRmn4fWQxr
 0eu5n1VbhXnR2Km4GnsOODAbuEAvIkkiI8bF241LbMJBOBdZwON0uGR/S6U+sGzXNwUC
 z8fjCUAwpU2xxfY4sFIlUOmo51FkZhz0fdsDju/PDhsk7kmTtNeIsibryD+siDpGw1D2
 ZxkxlFaYA2VR1vUnuT541Vf+ATLO9C5uPZYMCMv5UtJcP3y/FqSJsgeELBntd8fabsTj
 gjEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPkRLvvxcFrlRwd6Ie433+6tBjSPmm5ltX+xIFuggkHmaKUhPNl5ZuA/EnlyhxNdQQYwO+r6t/Ddg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUQYhoSRN1fTPiQ3XROtDXAhaTY1OTFYpI5RwMSWbWMRmZXSbv
 KF05CR8yc2ll7do/KgnF4vZ17xeJSiLsPZbZ3yNigci2T+ZeUxtYMXNu
X-Gm-Gg: AR+sD13Ks8Gfv4ctozktEvZjRHhNmAbj7Euk3PmJLJnfMXj8MPbD7110So9CB3qONvF
 ov/2Nuo+HTIP+u+vXVtd0dQo+qjgaUA281LgWLzBL1GWYr8zYekahQ6FCP3IyYLnFcLv51jqcmn
 ero/DuEI4rB0WytITIvnKCgPFouuWKf5M4xrP97t6NM6KSpsMzQKtAjg0vdhaTJB8f8Ekv4p6Ay
 ge30neHJ5q99VDVaPl9JBTDYWGFA70eTAtQJjSZQiVVLDy/BFLnXwuOQSOE1Q9kk57uf0WM/xg7
 KFEMGq4p/tpVYJvWSqdQHOBBpIyt32HyDXaxFzGTkw3WAUDNPAFnb+I6QDvm/wgLcJp9PkLtKPf
 HT/xH7MrmOhm2KraHvndIOSk+wjHqP8YkSamolzdf4uP3ko3kMqGu9cRe/df2SZQMUnRRDfpWPV
 8HiHa9GZV2kqjTAdqYw1LUaLJ3zoEY2YhHQAr+KTk=
X-Received: by 2002:a05:6a00:278b:b0:848:7b92:8e74 with SMTP id
 d2e1a72fcca58-84f2e0dc994mr36524222b3a.39.1786199369200; 
 Sat, 08 Aug 2026 07:29:29 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a3cad9dsm2140077b3a.23.2026.08.08.07.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 07:29:28 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:29:25 +0800
Message-ID: <2b3c661bf7e1d437f81e4b7da13be25d.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Haylen Chu <heylenay@4d2.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY
 PLL pixel clocks on K3 APMU
In-Reply-To: <20260807230824.GA2220945-robh@kernel.org>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-4-6de34d80e86c@gmail.com>
 <20260807230824.GA2220945-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

Hi Rob,

On Fri, 07 Aug 2026 18:08:24 -0500, Rob Herring wrote:
> On Sat, Jul 25, 2026 at 12:51:13AM -0400, Cody Kang wrote:
> > The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
> > K3 syscon takes two clock inputs the other variants do not have.
> >
> > Gate them behind the K3 compatible instead of widening the shared clock
> > list, so a non-K3 syscon cannot silently accept clocks it has no mux for.
> >
> > Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> > ---
> >  .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  | 30 +++++++++++++++++++++-
> >  1 file changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> > index d3a7c93c3c54..b8fc6632a392 100644
> > --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> > +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> > @@ -31,14 +31,18 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > -    maxItems: 4
> > +    minItems: 4
> > +    maxItems: 6
> >
> >    clock-names:
> > +    minItems: 4
> >      items:
> >        - const: osc
> >        - const: vctcxo_1m
> >        - const: vctcxo_3m
> >        - const: vctcxo_24m
> > +      - const: edp0_pll_pxclk
> > +      - const: edp1_pll_pxclk
> >
> >    "#clock-cells":
> >      const: 1
> > @@ -95,6 +99,30 @@ allOf:
> >          - clocks
> >          - clock-names
> >          - "#clock-cells"
> > +  # Only the K3 APMU exposes the two eDP/DP PHY PLL pixel clocks as extra
> > +  # inputs (parents of its eDP pixel-clock muxes); every other variant has
> > +  # the four base oscillator inputs only.
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: spacemit,k3-syscon-apmu
> > +    then:
> > +      properties:
>
> > +        clocks:
> > +          minItems: 4
> > +          maxItems: 6
> > +        clock-names:
> > +          minItems: 4
> > +          maxItems: 6
> > +    else:
> > +      properties:
> > +        clocks:
> > +          minItems: 4
> > +          maxItems: 4
> > +        clock-names:
> > +          minItems: 4
> > +          maxItems: 4
>
> 4 is already the minimum, so it can be dropped on all of these.

Thanks for the review. Will drop them in v2.

Cody
