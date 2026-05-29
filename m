Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AAACD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E049F10E366;
	Fri, 29 May 2026 10:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Gq0vcIUj";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DFF10E366
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:46:18 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49068493267so38545665e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780051577; x=1780656377;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
 b=Gq0vcIUjNvElyju0+lmQtwFmes1hNTvk3nq4XbadVaKO+vlPO/G+6u6CuieRA3Mli/
 n83R6i9VOra6CciW0/a43WCGIKw5hdiOVejxJhiNWTfvf1dZZ54iYCMLftRH4st5gn2w
 TGqTCOMuVyz204cRgX2Hvzg9PBkczs7AHyHk9/rwTh1LQ7Td9d5DpVOGVgtqSeuXinUx
 jNjry76hYltPpr4DsX60tNZwXZXHFAFUtYoxCXkzHx1EmWvhXiyqftov6MIqJfYK8i4G
 pXJubf3kme6ceZB2wsfdXITQIc5wqYrtMdTapWx9xRC6gpT6SQDDlaWQ55tZgfRVLr5U
 LwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780051577; x=1780656377;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REK62I331lUwouEMVLLpq3kmjZ7SBSD27YX0AVRlIss=;
 b=Zn39F/NSCbm4px4laPHKbeOxCbmJZQcFHvRbFk/9PapSFlX6THRo6WKq3gFJUwEru2
 vaYoeUR/Ii6UxjdbfX3GcBwjIYJnHapI/Qs6tdQS2KjSp9Lz3yh39JbDt5mUoD3Fi26V
 5FOfUsVym09h4ONb4UcY10e1pK1sQILRgFJQQtdEII5QFVlUWcOqDK24hyQrxWK0dq04
 lQ3rXDX7il/M/LZGl+OAqpoLMNRc5ftb/WmD+8w2Z/8cXlCwsbIrCCHaiMn7kexiLD7E
 uxO6jxUW8aL4HmfbyVhQrJDIl6M5sZAurc2uex0kKUXElWc6AnPzDJm6IaNrVI/vIth8
 kERw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y/QssM8BqKRo/DBgstLpRFVXEl++qV3fSZ2OQxDnZiXs6jM0ODDxvpDF6kaF7XHhPE5i0+oKq5mI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnG7zFbXO4xjaoMgQLhV6Vc6X9CmhaJbuKS7LWnW4sK3F7wETE
 uHRm7+xstNVNqL2cl4AdXyvgTfYXsJR9NfWsOj61IaePqezTxfqQhqw7ixCeSwx/VJY=
X-Gm-Gg: Acq92OG9oUX5XbeKiAVkw9UlkRajqhbjxhLJRvmi1dGAUWAPprXPICuHeyKBTLVnEyN
 L79Yc+L3Q8Bt/0ruKKomg37nHPnSVSbhDmbjhZxwpftpgCVkul6eTuBtvlMbiM9NDVKhNiJxeW4
 3luX/WlYrfeHoja+zcroEnAh+0SJWrfLDZ4API+rhhjvDWhHhtNugzglCdX2/26gzlaHxKpFwmR
 X3WZD0FkbUuieaC4BJ7Ue329+QZ+1ARlVzewLLZX6rF4Mx6CC9JLTPa4l2uM71HWZnAKM+WWFsl
 XLZiOVhYn4tFeutWHd5v5oyJUB4E5cOU+OhU954qf80hNf6EfOKpiJ7918mbKRx0eeUyH2gNgaG
 PFPIUE2Tfii6pGucn5QWFvjLJ3IYb2SXs7w3xEImzWOxyZf2YVPqRev5GhjS+8YzQcArmPKAdaB
 EknboVEHEZwRP41kReGqurOz2DyIyyBZluY9pqDF6SgON3DIm8tBFfOFyHZbabKzdZsJOko6FjL
 LjuRBGoofni9bUDrYaiqHdWSCsFTHPCjvI8o5sMM7tXu+6Uxmh/Q1gKZUdhO1I5oZjo6C56lY6X
 i5uFEdGfO427tek3HvhUh78CmaKdxA==
X-Received: by 2002:a05:600c:574d:b0:490:778:4fe8 with SMTP id
 5b1f17b1804b1-4909c0ba8c9mr28839315e9.25.1780051575110; 
 Fri, 29 May 2026 03:46:15 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm41024205e9.1.2026.05.29.03.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:46:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:46:12 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <ahludIZPMUlPDTG_@aspen.lan>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
 <ahlhinOh3NxB7FY_@aspen.lan>
 <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n3C8D+amSRkF=Koj6Niu6u8uz4LbMoRYEX32_ECm5-tSQ@mail.gmail.com>
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

On Fri, May 29, 2026 at 01:07:50PM +0300, Svyatoslav Ryhel wrote:
> пт, 29 трав. 2026 р. о 12:51 Daniel Thompson <daniel@riscstar.com> пише:
> >
> > On Thu, May 28, 2026 at 04:51:18PM +0300, Svyatoslav Ryhel wrote:
> > > Document the LM3533 - a complete power source for backlight, keypad and
> > > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > > converter provides the power for two series LED strings display backlight
> > > and keypad functions.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++++
> > >  .../bindings/leds/ti,lm3533-leds.yaml         |  66 +++++++
> > >  .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++++++++++
> > >  3 files changed, 304 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
> > >  create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > new file mode 100644
> > > index 000000000000..866b0fb8ed04
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
> > > @@ -0,0 +1,68 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/leds/backlight/ti,lm3533-backlight.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI LM3533 high voltage series LED strings
> > > +
> > > +description:
> > > +  This is part of the TI LM3533 MFD device. It represents two high voltage series
> > > +  LED strings for display backlight controlled by the TI LM3533.
> > > +
> > > +maintainers:
> > > +  - Svyatoslav Ryhel <clamor95@gmail.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/leds/backlight/common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,lm3533-backlight
> > > +
> > > +  reg:
> > > +    description: Control bank selection (0 = bank A, 1 = bank B).
> > > +    maximum: 1
> > >    <snip>
> > > +  ti,pwm-config-mask:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: |
> > > +      Control Bank PWM Configuration Register mask that allows to configure
> > > +      PWM input in Zones 0-4
> > > +      BIT(0) - PWM Input is enabled
> > > +      BIT(1) - PWM Input is enabled in Zone 0
> > > +      BIT(2) - PWM Input is enabled in Zone 1
> > > +      BIT(3) - PWM Input is enabled in Zone 2
> > > +      BIT(4) - PWM Input is enabled in Zone 3
> > > +      BIT(5) - PWM Input is enabled in Zone 4
> >
> > This is optional and the drive implements a default (zero) that is not
> > documented here.
> >
> > Is zero a sane default from a DT binding point of view?
> >
>
> Yes, if property is missing then PWM input is disabled which is
> equivalent to setting all bits to 0.

So the default should be documented in the bindings?


Daniel.
