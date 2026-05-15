Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA53BCD4F25
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 14:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F0210E45A;
	Fri, 15 May 2026 14:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AhFaXR1A";
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15EA610E45A
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 14:15:37 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-479dc6d26e3so5520039b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778854536; x=1779459336; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X3Ba1jDpFlV6BYps4ROIqTWMi/TLCycbOgGvzvGmAoI=;
 b=AhFaXR1AsyA6aqW5tpjCpEnfDrpvyhyBEsIoRZQwRCDoDPZa358ch7Zxryz7k3oNCe
 J5qRocCQHLDMq6TSUL910dMOZ5p9ViLUF49Kw4xAGf0fNDso2KAPsm6II7NTL2qFxH+d
 fPyLXTrESFT1ZDBZnv7WaCd0KDNZVTSIw3wsw1ljfJWKHqNkr320mO8dDWoymmt6aBWB
 Hjhx7dPnV2Lpii8fx8qMZf3ANE6VzTQ9XrztfssST+ZHa4kzEyUjhxNYBywTmdmW+huK
 essOja3nXRYgonQvbw2aSSqrQeuhffy99RjwF1bCPrlwSaTjGM+2zP5wmmjr6hLpSWNo
 I+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854536; x=1779459336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3Ba1jDpFlV6BYps4ROIqTWMi/TLCycbOgGvzvGmAoI=;
 b=OOnVeJ0IlG+PLXkbZebheuXVm4zg9caavbuwM8OyDTsaw7wGfQbTXkDnoXxkCepuN4
 js5QJ/bA0DwKhkZJOmYKxXu10kbsjdm80vAtypNmtzSbWMk9sA2/ohRVjKSQPAww2j6Q
 TcT+AuEXyr890Z4UnzSTMoD/vuqlXhIf9BOVbNGMWLKmCGzNWEr08zpYtlSKdKBt9lDs
 v7qwjMAxo4GDdihYw1d0ZWyJ5ywmPV82/o7wmHJK6LLz5uiFS7YM+9xZ1YoZODy2hhsb
 LT2Hsgno0Ap328gVU6qqiuD7KNofAWC3q4Of0hVo2HeBOwdZnwRQzmC0XDAGlVZXjbQw
 yiNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UsIz8sy8kU2XKf5Osrv4C9xk5KSOzTUrOXj1eQQKBvArxFxFYo39higIv8XHxp0I/jS7SJ85z8Jw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0NwiIr8elObP04SpRIkPoiTtDE913xUDGkm39SCRNp95c3MI9
 hdGj3sGMOSx15e3rXV2y/8/yl3qfWtq7PFeQvr39gvdU3g3mY/0ELsW8
X-Gm-Gg: Acq92OGySOemeL4ZPeMZ1rp/B14DTeNbxzkdMZpxRsZVPbnfMvh3QBff4Q7MSfsGj1Q
 3dhCGmlmlJe4p++y3RDmknnWOUHCc1JVr1QlHJLt3EJ2qrkw+HcHNdkpJ9eEPXBBrkCvynbuUvY
 fjV1zpnN5ilDOtBXBSgIhviYvj3+Mrg5o5Ol1vqLA2WRs5V4uj14sBwrXbqoBqGDAle0lL0e6oL
 Y6yRSOvb+Gb6E58mwYVecas0mTPpGw5p5eJdSGyew5VfiggjNvZm0yfxa3OCVn+fmJvP8jB7KUm
 KmvZQO8KOQvgQy1pvUvAPKi/LtNecCy5JFIXUMmxWZ9snbnVQwBJjnFFHLtdcU8UFYK0t/n47Ac
 xj1fQk5wRyzUTX4k1WLdUGf1ed6TqZSgpMxWN+x+VJNkoR2PSuy0I2h6/fVYAc90tawabWzb8ba
 b++P4md5mbnXga7q7y7I/vXGnOozqqV9Qczn5VdOVvzjGl
X-Received: by 2002:a05:6808:1982:b0:467:2a6e:adb3 with SMTP id
 5614622812f47-482e5729bb3mr2592192b6e.23.1778854535958; 
 Fri, 15 May 2026 07:15:35 -0700 (PDT)
Received: from neuromancer.localdomain
 ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee38a5ecsm876341b6e.7.2026.05.15.07.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:15:35 -0700 (PDT)
Date: Fri, 15 May 2026 09:15:33 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chris Morgan <macromorgan@hotmail.com>,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 xsf@rock-chips.com, sre@kernel.org, simona@ffwll.ch,
 airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, jesszhan0024@gmail.com,
 neil.armstrong@linaro.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document
 sgm41542
Message-ID: <agcqhTCtrerKplSD@neuromancer.localdomain>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
 <20260427170914.5062-2-macroalpha82@gmail.com>
 <20260428-bulky-nebulous-reindeer-ed45ed@quoll>
 <PH0PR19MB997338F0B06B7B99AA0ED3C6C4A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <534f0795-0002-4c04-a83c-fa1b3ce68216@kernel.org>
 <PH0PR19MB99733813E0295B511539050BA9A5372@PH0PR19MB997338.namprd19.prod.outlook.com>
 <20260429-boisterous-cyber-hyena-ce870a@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-boisterous-cyber-hyena-ce870a@quoll>
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

On Wed, Apr 29, 2026 at 01:58:22PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Apr 28, 2026 at 02:54:53PM -0500, Chris Morgan wrote:
> > On Tue, Apr 28, 2026 at 05:09:49PM +0200, Krzysztof Kozlowski wrote:
> > > On 28/04/2026 16:09, Chris Morgan wrote:
> > > > On Tue, Apr 28, 2026 at 09:47:00AM +0200, Krzysztof Kozlowski wrote:
> > > >> On Mon, Apr 27, 2026 at 12:09:09PM -0500, Chris Morgan wrote:
> > > >>> From: Chris Morgan <macromorgan@hotmail.com>
> > > >>>
> > > >>> Document the SG Micro sgm41542 battery charger/boost converter.
> > > >>>
> > > >>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> > > >>> ---
> > > >>>  .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
> > > >>>  1 file changed, 99 insertions(+)
> > > >>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>>
> > > >>> diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>> new file mode 100644
> > > >>> index 000000000000..3e5041e5b551
> > > >>> --- /dev/null
> > > >>> +++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
> > > >>
> > > >> Filename must match compatible.
> > > > 
> > > > Acknowledged.
> > > > 
> > > >>
> > > >>> @@ -0,0 +1,99 @@
> > > >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > >>> +%YAML 1.2
> > > >>> +---
> > > >>> +$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
> > > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > >>> +
> > > >>> +title: SGM41542 Battery Charger
> > > >>> +
> > > >>> +description: |
> > > >>
> > > >> Do not need '|' unless you need to preserve formatting.
> > > >>
> > > > 
> > > > Will fix.
> > > > 
> > > >>> +  The SGMicro SGM41542 is a single cell battery charger/boost controller.
> > > >>> +
> > > >>> +maintainers:
> > > >>> +  - Chris Morgan <macromorgan@hotmail.com>
> > > >>> +  - Xu Shengfei <xsf@rock-chips.com>
> > > >>> +
> > > >>> +properties:
> > > >>> +  compatible:
> > > >>> +    const: sgmicro,sgm41542
> > > >>> +
> > > >>> +  input-current-limit-microamp:
> > > >>
> > > >> Missing vendor prefix.
> > > >>
> > > > 
> > > > This *appears* to be a standard value (perhaps not formally, but in use by
> > > > enough devices to suggest a defacto standard), which is why I did not use
> > > > the vendor prefix here. Do I need to add that for this one?
> > > 
> > > I know, I found these other properties but I think they were just coming
> > > from old schema.
> > > 
> > > If it is really a common property, then should be defined in a common
> > > schema and this did not happen.
> > 
> > Would now be a good time to add it to the power-supply.yaml document?
> > It looks like this value is used by about 10 other devices.
> 
> I have mixed feelings. Adding it there would mean that all schemas using
> unevaluatedProperties will get that property. That suggests they have
> such limiting ability in hardware or this ABI is implemented in some
> generic part of the kernel.
> 
> None of these are true, I think.
> 
> Maybe we need some documented guidance on usage of common schemas.
> 
> Best regards,
> Krzysztof

Would you recommend I just use the vendor prefix then here? Or add this
to power supply as an option? Or is there a 3rd option you would like
for me to pursue?

Thank you,
Chris

> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
