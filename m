Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C94EC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A808A10F2C0;
	Fri, 31 Jul 2026 14:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bUYCfbjj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0160D10F2C0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFAA44144E;
 Fri, 31 Jul 2026 14:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA051F000E9;
 Fri, 31 Jul 2026 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785509181;
 bh=qG/OmpWCAQteab0hofCuuF8fPYpRZjFgEHkFgtcTxN4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bUYCfbjjz6CBkVZG6CjFk+v8OjANmC0l6/xMo4pQuhn0W0C7QeeyGdC699jnav8FU
 A8I5Z8tplWQ2MddCEvIcICFaQ4qkY22pKppG0X54bzUwWNgVyx14YKM9hiuc2QPngD
 6IQ9YJKLKvo2nnW6nlx9OcjRRZhYuHGmEPPqNpvwOYVxnsr43bqTfVIs8z7gOVFk4A
 aK8zmq2rJt1v4hUvTpeInkiLRbVw+XJASYUuZ4LHOfl33vLRmngB1njFhEhVymze89
 XRK9K2Bl5sevivTnJUYTlbM3YKFmhtpSomN5xjIFZ6B+cPG5+dTIrcTfgakHPg0D4/
 Wz7sLq56QUdKA==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpoV9-00000000XhR-0X8O;
 Fri, 31 Jul 2026 16:46:19 +0200
Date: Fri, 31 Jul 2026 16:46:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Message-ID: <amy1O7xaLlO_UOZv@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-6-clamor95@gmail.com>
 <akeHC-OA8tqM941f@hovoldconsulting.com>
 <CAPVz0n2DPia=nfvd3W-rHy91OvZNO6jdSczT7kyvH-G138KJyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2DPia=nfvd3W-rHy91OvZNO6jdSczT7kyvH-G138KJyg@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 04:31:08PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:55 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:22AM +0300, Svyatoslav Ryhel wrote:
> > > The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
> > > are used only in lm3533_als_setup(). Incorporate their code into
> > > lm3533_als_setup() directly to simplify driver readability.
> >
> > That's a debatable claim.
> >
> 
> Adding helpers to wrap custom regmap wrappers seems redundant twice.
> 
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
> > >  1 file changed, 16 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> > > index a9af8e2b965f..69bac1b202f1 100644
> > > --- a/drivers/iio/light/lm3533-als.c
> > > +++ b/drivers/iio/light/lm3533-als.c
> >
> > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > -                         const struct lm3533_als_platform_data *pdata)
> > > -{
> > > -     int ret;
> > > -
> > > -     ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > +                        pdata->r_select);
> > >       if (ret)
> > > -             return ret;
> > > -
> > > -     /* ALS input is always high impedance in PWM-mode. */
> > > -     if (!pdata->pwm_mode) {
> > > -             ret = lm3533_als_set_resistor(als, pdata->r_select);
> > > -             if (ret)
> > > -                     return ret;
> > > -     }
> > > +             return dev_err_probe(dev, ret, "failed to set resistor\n");
> > >       return 0;
> > >  }
> >
> > There's nothing hard to read about the above. To the contrary the logic
> > is more obvious this way.
> >
> > You also remove the high-impedance comment for no good reason.
> >
> 
> Removing one level of indentations without obscuring readability is
> always a good idea.

Again, no. You're obscuring the current logic which is perfectly fine as
is.

Johan
