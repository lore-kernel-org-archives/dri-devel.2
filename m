Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B62C5B56B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F20210E62A;
	Mon, 10 Aug 2026 06:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lt2gvkD0";
	dkim-atps=neutral
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A56210E037
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:22:02 +0000 (UTC)
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so162002a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786195322; x=1786800122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=li/c4+/312t4GgA151ifIixBtg8Isry/It3D3W9Em4A=;
 b=Lt2gvkD0FfMeSYvuEqGUslCkZBV4f42vBTbZtbkk1i1LpglTssAFwjt5CJtbrgmfSj
 31b7uV3N9KUjbBQGwoo983329VNTARRAcWx2UoR97oo0ub64pFOz9nLKD+1bITQz/6OG
 msWT6MO5Yn1dFXr7qOmT2noW9b/1T7eMHnG6u4uwfoWkPXmr1+uEuUXoAWXsVnBHuqN8
 LafrqQwRX7uVwsITQ39ecyyiIRyGmgd0mrs46YOg9gX7FIhw40AbdD89VQTZQFlVk9ma
 qkjNvsyE16XOzA2u4VCGsU7n5GOzrkRAlops37NZ3oJ6O3S2aNWhiY6OFJf6iiANd6Ab
 RU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786195322; x=1786800122;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=li/c4+/312t4GgA151ifIixBtg8Isry/It3D3W9Em4A=;
 b=Psn/mcY8WvZ64AIQzoSolVvyrdfWh9uT9dM4AM7AKCO6+qS+9O7Wuf1dEjN+J2ohf1
 MQ/LdcJja6Bwg0XcMjUZ9SE8RQxSr8XofjMifcRScObaDepufCypFoiD2voqmOGpy5IG
 f5HlISBEA7h60bcf71Dm7XtLRwqZtVUI9FGGJh2vE6L2KzLGwWC6PiiZnjtqFjUTX8pm
 VT+5th2lFr+STTEK+D+lkGdpPrTA9JWklw+oMc+ghFadnSBTrJ2RRsf4f5f0TUH6bSBi
 X4yy3KcCwVvSI/g04zRM8gAm0f8qeBx7MRjG6Mp4bjgroB83Eqw1+nIlwwEOQwTZAQNd
 LCZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4n+2BqKihMlZ/AhkF4ZBOVJtHX9s9kA97MghvErLtIG1qnURLexEnmVMx/3sS90Wi4ojDY1Rd+mM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2TmeydZCrMKwBqRSDEdrJrK2lwHhRvgxnk03rMT9dxomzaXI/
 CB/PWBx9Sm2NtkyOQZghwENcAa/y5SEO8Xqq5uLP3JA3HGLTABwRgyLv
X-Gm-Gg: AR+sD110jxWA2war6YIs9vsGNR2d0sMsgdvVb5gW2StQAWERIi9ObZBfE91xO6/ht4z
 ihMH3dTo33UtybnDGOmbzCv8GpF6zwW5UGNd0+0Syg0QDF7yyoSp5F8w0RvLgGFzzc9z9bllkBS
 mo/fOCaNgsy+Mv1/gyQTr3NI2LN9GulHtnRgeAGuzONQt3ybwz7+/JN+raZHoD6kxEddeyqAa4q
 4amRcYwGMBMQrTMr9QAHGNWuJms0rLZLPRhjy1Pt7V4YbDP9KNH7HV0Bu6nVoSeI/yTzRHx8Wwd
 XI55sbu1Bsdv7Ne+fLPWWiehKynKZrYRZ1H/sxUX6BaUtRR0dPi3ICHqCB2GEhV6XReUlajce2s
 zc0TCgcnjsPWYb2u/o8GiYHmdCIgcuQgV2lCKPs6L+ZilE6EjlMCu4LbZ2AO2cbg5MXRvcbasLH
 eYlNo51MVKSgdNSs3UqjN4SsKrRwlyMWPt+iYRoxE=
X-Received: by 2002:a17:90b:17c5:b0:37c:607b:2cd9 with SMTP id
 98e67ed59e1d1-3903b9f3ee3mr28104214a91.0.1786195321821; 
 Sat, 08 Aug 2026 06:22:01 -0700 (PDT)
Received: from localhost ([2403:2c80:17:1e::20db])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b343e662sm2307387a91.2.2026.08.08.06.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:22:01 -0700 (PDT)
Date: Sat, 08 Aug 2026 21:21:57 +0800
Message-ID: <c73cc405df108dd7c3c5da95a1f8cddc.codykang.hk@gmail.com>
From: Cody Kang <codykang.hk@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-clk@vger.kernel.org
Subject: Re: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline
In-Reply-To: <084a860a77f18aaafcda4b223eec4fdcd96e75c9.camel@pengutronix.de>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
 <084a860a77f18aaafcda4b223eec4fdcd96e75c9.camel@pengutronix.de>
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

Hi Philipp,

On Mon, 27 Jul 2026 09:35:38 +0200, Philipp Zabel wrote:
> On Sa, 2026-07-25 at 00:51 -0400, Cody Kang via B4 Relay wrote:
> > From: Cody Kang <codykang.hk@gmail.com>
> >
> > Add the atomic KMS implementation on top of the hardware backend: one
> > CRTC and one primary plane per DPU instance. atomic_check validates
> > the plane rectangle 1:1 against the mode and sizes the per-channel FBC
> > line buffer; atomic commit builds the cmdlist batches, maps the
> > framebuffer through the DMMU and arms the cfg-ready handshake, with
> > vblank events driven from the DPU interrupt.
> >
> > Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> > ---
> >  drivers/gpu/drm/spacemit/spacemit_crtc.c   | 815 +++++++++++++++++++++++++++++
> >  drivers/gpu/drm/spacemit/spacemit_planes.c | 376 +++++++++++++
> >  2 files changed, 1191 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> > new file mode 100644
> > index 000000000000..b75ff6320501
> > --- /dev/null
> > +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> > @@ -0,0 +1,815 @@
> [...]
> > +/*
> > + * The assert and deassert orders are not mirror images: the hardware wants
> > + * these.
> > + */
> > +static void dpu_reset_assert(struct device *dev, const char *name,
> > +			     struct reset_control *rstc)
> > +{
> > +	int ret = reset_control_assert(rstc);
> > +
> > +	if (ret)
> > +		dev_warn(dev, "failed to assert %s reset: %d\n", name, ret);
> > +}
> > +
> > +static void dpu_reset_deassert(struct device *dev, const char *name,
> > +			       struct reset_control *rstc)
> > +{
> > +	int ret = reset_control_deassert(rstc);
> > +
> > +	if (ret)
> > +		dev_warn(dev, "failed to deassert %s reset: %d\n", name, ret);
> > +}
> > +
> > +static int dpu_pm_suspend(struct device *dev)
> > +{
> > +	struct spacemit_drm_private *priv = dev_get_drvdata(dev);
> > +	struct spacemit_crtc *a_crtc = priv->a_crtc;
> > +
> > +	/*
> > +	 * Assert before gating: a reset asserted into an already-gated block
> > +	 * has no clock edges to propagate on and leaves the register file
> > +	 * untouched.
> > +	 */
> > +	dpu_reset_assert(dev, "lcd", a_crtc->lcd_reset);
> > +	dpu_reset_assert(dev, "esc", a_crtc->esc_reset);
> > +	dpu_reset_assert(dev, "mclk", a_crtc->mclk_reset);
>
> It looks like these three are mirrored, and could be handled by
> reset_control_bulk_assert/deassert().

Thanks for the review. Indeed, reset_control_bulk_deassert()
walking the array in reverse gives exactly the mirrored order the
hardware wants. Will fix in v2.

Cody
