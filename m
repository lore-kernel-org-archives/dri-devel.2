Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6463C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C9C10E1E4;
	Wed,  9 Sep 2026 16:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jGKze1Tc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2EEE10E1E4
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 16:26:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 586A743883;
 Wed,  9 Sep 2026 16:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494C01F000FF;
 Wed,  9 Sep 2026 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788971162;
 bh=+2dYsB76vpFQ4MyuvIdp1GJYHNdmsFlba8+BCXgzTOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jGKze1TcyqYTs4U2dq+V4MXMmozQVGKA7AdkiEznKpEX/3w/BPsZXKzfn4wL3Itcj
 pvm6h9DigGrf6QMU9dM6zCF5KlCl0UXLbiB5zRIPQs1d1fWPE2QOgxf7qM4oZpp1eU
 fGBwghSZZjApYy1yw10GtKAjnZP9+py7Um5Z6J/ppelEUdwC4EU+DEnn557BX0esXX
 1QwaxoS1qKcdCeSQ6vkPgo/rf0HG8g/VUK333PJirOI2fdm7rSXB/vkDvhugDuUpjN
 xcLlyz7hvjqGdnIbeqrve6UCqm/4+hh5gr02SgGwFPCoG8+Zw97MB2L+lTiYKOCMMF
 USFXdUWLoXjNA==
Date: Wed, 9 Sep 2026 17:25:55 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <20260909162555.GJ2133376@google.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260702161828.GB2108533@google.com>
 <CAPVz0n2fRs=q-1dAEt2k1FJpQVK9+PMSY0BSMB7Rs3F2xDyFvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2fRs=q-1dAEt2k1FJpQVK9+PMSY0BSMB7Rs3F2xDyFvw@mail.gmail.com>
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

On Sun, 06 Sep 2026, Svyatoslav Ryhel wrote:

> чт, 2 лип. 2026 р. о 19:18 Lee Jones <lee@kernel.org> пише:
> >
> > On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
> >
> > > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > > setting mapping mode and LED sources based on device tree.
> > >
> > > ---
> > > Changes in v2:
> > >
> > > schema
> > > - maximum led sources for leds set to 4
> > > - anyOf > oneOf in ALS
> > > - improved ALS descriptions
> > > - adjusted example
> > > drivers
> > > - dropped devm convertion of irq and mfd helpers
> > > - all als configuration moved into lm3533_als_setup
> > > - added regulator/consumer.h
> > > - lm3533_bl_setup set before sysfs_create_group in backlight
> > > - added check if LVLED is valid
> > > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLED5
> >
> > This set looks good to me now.
> >
> > Let me know when you have all of the Acks and I'll merge it via MFD.
> >
> 
> Hello Lee! Is there any unresolved blockers for picking this patch set?

I can't see that clearly.  Please apply all of the trailers (you can
probably make this easier on yourself by using `b4`) and submit as a
[RESEND].

-- 
Lee Jones
