Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0BECD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C4C10FF96;
	Fri, 29 May 2026 14:15:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="rDNAsOsC";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DC410E373
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:15:07 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so94452405e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1780064106; x=1780668906;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W47nz7+ZSiqC1F5GhlKMt1J1pKq4V8TQOQanS7X5yXA=;
 b=rDNAsOsCNtezYTg/ZAxG64NfWw4pdXAsvR67VwIy5fXKZ/dD64FealwyBYsxF0Tc2N
 YGeEhdF8PUD1JwEY7K6WdTBB/oqmeDakoyJCII/ysm1IghEzI7lTzP/FRmM0X1da0qv1
 mDgY26vSGxs1P/j0KgJ9WpcYsQOXO9BL2L2UgUHX4yi+Bossd9PURJAYmHMLQ/YfpeFZ
 7Ydad9kNzmoLtJIX8b2kaRQVRme6zaYvJ4cWoxsY0F5VKCQq1jXaT5Ea/304fHfvKCEE
 LnG/UzlREGQ1UalEkOYK/Z3l0DtgjDiwbSrFdFT3YLxl1lcReTGNOmyiX139NonJouVN
 stTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064106; x=1780668906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W47nz7+ZSiqC1F5GhlKMt1J1pKq4V8TQOQanS7X5yXA=;
 b=QG7iw0HI7Pbu2vUcIvt3uNdSIbZann9HqpvAKwEZ3Yu+MX+ZAqwVucpHssoRbqrVhp
 zY5a/JiIvCV88km3ezOYZU2H02E5wrmpPMRtmrMNQOrz9rC806toUgiE0Ybnh6X4xspR
 cJC92CJx9WBhiqOi5sP/LN3KrDaMPgibxOppSaHM9vnao/k3kWXhtm/1aDGCcudrfb/x
 AHHgiOF/zq9527sNkwkgHeqnDziZC14n4aOw29CI9FLfTr8hRqilr4Tax/Nsfa7Wl9gj
 D3bnrxwzNUiHR+tc6am38ewM2ePW1lA+9kMDxXM2RZzbLjKM6R0JLNb/4Z6ieNZVOoDI
 BPxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8j7V24uQuPXau9cCCrdRr7mMayV1kWuDvReDByCmAKTcu/4bKKOd9bLk/Qub+eKr1vB7yBXFv6zcE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJY2BXzzF0VHOVPqKdrvBQHtln51jVwlyTV6sOz1X1bDGRt0aW
 J1sqrbxcRl3ik1MPXlbv8iNOFZU7/MSMFAX4de9yYSI2GwYlXqWhJHf81IIAKS2wZhUCMI21SEv
 nHpVU
X-Gm-Gg: Acq92OGGpF9tDX0bSZonlXPgCoNFEJNgvw3MOjDBdryQ8Rgz1Vaa515BrwfSpCpGqvt
 80rQoDIgQdogncxqxj5hpWMmLyTb8YCujCChcFc9Gik5zXMQGvLlUbsRRPp7N9MvmsOtoW4PqPn
 J9rHp7SooInh3aMng/mQUQ2MsKFMArvWUNVckjfApD9V5V6Zm0j8jM6CkfDIn/0y5hlAUCZ1pZM
 CimU7r9yKj7CJkmEo5ZXo9+RMlkbUc7nUCG1/7VV9bP+8opIN3aTNk2Oj4C30HGSYBIpwfXYnUO
 kOO5XQwbl0g0aemdsxSVqoYs5dGHRt+uCA6KVPTKiay7plBr80Cial4mKDSfjGK7TF+bhxh/q+i
 W+DRbT+H6oHMfy6mI8A9u4yPW5PdNgnYRDBIxrH1kWLKvxJ4wnnbkUG0mGZOLfg/gH22x4Pqrnx
 Z0BTWajST77uW8VT8fc5GzocHvX8hBOkDjp3qYfA0UsDQjc20DBvQeSDoDiXpnYw72sTaKmg8AL
 DNYBHJ/wE/mX2Bv8AriSdTQlbNUXa91IlQzjwWyK0o6oKQ2hL/Zb7Te93WfchM3FgvTmMmwLv4n
 MisGRaRQa7cn6qIX4sw=
X-Received: by 2002:a05:600c:3b10:b0:490:5872:e641 with SMTP id
 5b1f17b1804b1-4909c0cfe40mr55505215e9.18.1780064105498; 
 Fri, 29 May 2026 07:15:05 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm43091805e9.8.2026.05.29.07.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:15:05 -0700 (PDT)
Date: Fri, 29 May 2026 15:15:03 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Daniel Thompson <danielt@kernel.org>, Lee Jones <lee@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
Message-ID: <ahmfZ0tdxbVfD_y4@aspen.lan>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
 <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
 <ahllT_HVTAJ5MbkS@aspen.lan>
 <e3c99fe3-9279-4dfa-af69-d9366ab06837@linaro.org>
 <ahlr5PnX5O0tEd6G@aspen.lan>
 <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4001cf6a-b7de-4933-96bc-c9b4ccb53e4d@linaro.org>
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

On Fri, May 29, 2026 at 02:50:43PM +0200, Neil Armstrong wrote:
> On 5/29/26 12:35, Daniel Thompson wrote:
> > On Fri, May 29, 2026 at 12:16:07PM +0200, Neil Armstrong wrote:
> > > On 5/29/26 12:07, Daniel Thompson wrote:
> > > > On Tue, May 19, 2026 at 10:43:38AM +0200, Neil Armstrong wrote:
> > > > > Document the Silergy SY7758 6-channel High Efficiency LED Driver
> > > > > used for backlight brightness control.
> > > > >
> > > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > > > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > > > ---
> > > > >    .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
> > > > >    1 file changed, 53 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..80e978d691c2
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
> > > > > @@ -0,0 +1,53 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Silergy SY7758 6-channel High Efficiency LED Driver
> > > > > +
> > > > > +maintainers:
> > > > > +  - Neil Armstrong <neil.armstrong@linaro.org>
> > > > > +
> > > > > +description:
> > > > > +  Silergy SY7758 is a high efficiency 6-channels LED backlight
> > > > > +  driver with I2C brightness control.
> > > > > +
> > > > > +allOf:
> > > > > +  - $ref: common.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: silergy,sy7758
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  vddio-supply: true
> > > > > +
> > > > > +  enable-gpios:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - vddio-supply
> > > >
> > > > Sorry for missing this in v2 but is vddio-supply really a required
> > > > property?
> > > >
> > > > It's unusual for supplies to be mandatory (and the it is not mandatory
> > > > in the driver implementation).
> > >
> > > This device is a little bit special, the VDDIO regulator is used to provide
> > > power for the I/O via the enable input, so basically the enable gpio power
> > > level is provided by VDDIO.
> >
> > I don't follow. The EN pin acts as both VDDIO and as an enable but it's
> > still effectively a power rail isn't it (albeit one with very low current
> > draw).
>
> Here's the datasheet description:
> ```
> Dual-purpose pin serving both as a chip enable and as a power supply
> reference for PWM, SDA, and SCL inputs.
> ```

Thanks for the quote. It's a big help (I've been working from a site
that makes me read a page at a time so I struggled to keep track of
things).

This says that the GPIO from the host is merely serving as a voltage
reference (for the an internal LDO regulator?). That means it is *not*
a power supply!

It sounds to me like the chip is designed to work with a host where
enable GPIO and I2C interface use the same I/O voltage. By having an
active-high enables the chip can *avoid* having a separate vddio pin.

However, in a design with no separate vddio pin then it would make no
sense to model a vddio-supply in the DT.


> The VDD input is directly provided by the panel, so Linux has no control
> of it so I haven't added it.

Power supplies are often added ad-hoc when the first board that includes
a regulator enable appears. On that basis omitting vdd-supply would be
relatively harmless if you don't need it but I wonder if you do, see below!


> > It looked to me like the correct way to model to two power rails
> > going into the chip is vdd-supply (main power supply) and vddio-supply
> > (EN/VDDIO) I don't understand why a single pin needs both a regulator
> > *and* a GPIO in the DT bindings?
>
> I don't have a the schematics of the board, but as I understood one gpio is
> actually enabling an regulator which provides power to the IC (vddio) and
> a second gpio will either drive the EN signal to GND or VDDIO to provide a
> clean rising edge on the EN pin.

This doesn't make sense since it is a single pin. It cannot be both a
power supply to the chip *and* a GPIO input. It's one or the other...
and from the above is sounds so me like GPIO).


> So it's not really 2 regulators, and having regulators means the enable
> signal can be shared and would have regulator characteristics which it hasn't.

Agreed. If the EN pin is merely use as an enable and voltage reference
then it are not two regulators.

However, it is also *not* vddio-supply and enable-gpios. We don't need
the board design to check this. The pinout diagram in the datasheet
should be sufficient!

If you have to activate vddio-supply for the backlight to work on the
board are you sure you don't just have a misnamed vdd-supply that needs
to be taken care of? That would make much more sense given the datasheet.


> > > This is the recommended way from the datasheet, and I assume it will be used
> > > like that on other platforms (if it exists...)
> > >
> > > This is why it's mandatory and enabled first before setting the enable pin.
> >
> > It's not mandatory for the C implementation. devm_regulator_get_enable()
> > will provide a dummy regulator if the property is omitted.
>
> So yeah if you prefer I'll re-spin with the vddio regulator as optional
> because between both, the VDDIO is the only which could be shared with
> other devices or always-on.

Based on the above, I'd be happy with an optional vdd-supply and an
enable-gpios.


Daniel.
