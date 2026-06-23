Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2899BCDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 11:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4DB10E542;
	Tue, 23 Jun 2026 11:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="fhwbIrLj";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2012B10E542
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 11:41:16 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-462cdb88d01so642529f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782214874; x=1782819674;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lOYI9zsM4oIZ1rh6HmaZ/ht7QHKafqKi5GGpopSOq5s=;
 b=fhwbIrLjGSAklgV9OoffLTj2JBbMv/W2bg9e+e2kOOG7vuL/H85fKWvCqOVIx5QmbS
 3Qa/XTu0NLb3skNgTh8qqsriJ0+u+UIXrkf0ZuxllnIiohtJQl3XhXdBaW8t0CGB+KS4
 a8Mj6yugss3hadVizYIdImTog1gwb8kB7vQGP11uICmMEgYvUgFBcpY45YIG1x7CGyhv
 RDzJmbEGc06KRR8olow9obM5CWj/H5JBYT245gsyxL7BXujxfHgxdqfmCwnPu5vrMaCd
 Ku+3zTpiXgYXjWzKcT7p9N8Q7P+eAjFSdvDg/MVhF6jGDWAmUcjoXSIyDJBacXIC5v9p
 Xc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782214874; x=1782819674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOYI9zsM4oIZ1rh6HmaZ/ht7QHKafqKi5GGpopSOq5s=;
 b=fMGMCCmhM5mW5Kg7ZSNBI4ZPRabGKqpyMYiuIZJy0fRtqPpd9FvKg6AJ7OYLkdv06u
 LosoXbIO2SqKDQ3oPuGctsmDbsGdciNa7hDlp+/iTDIvMBM8dWL9fqmlTB26MTbcGNLZ
 fXpI6wV64ST927wUTpTnBgnJhrOFQrpfEf+EYGPPrXvZseQXBK9iqS1+7kgisRyrp6iT
 r+gMl9qL20CBF7EFaL3O18ZfELwMoo8j99KRjlPIzVmiqs9FdzibVlIiP8RLCTkLZKy/
 D/68X1gm0bYTsQZH/WqpwOuCOAUXKywUiMWcN0wuDtHB7bO1L4jIskiM2hmg7BLm84m9
 qQJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvUqtqiLxuUBkTcRd99/yDiphhVDaeS2/mpYVEG7YfctIkZ1WUpWB1HdBMz1e+t4CR3fMnMFvusog=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+OgWRFOQZhOP/ui+FqXqOSYBujDmexoGuvdtY1yzK4ecZ1M/q
 hZFyQbrj9KBRGLvOhAFlaNKOLV67dgJ3ZZ/Aw3XD3o/JaW4JERiF51Xo9Z7iTh/pGbs=
X-Gm-Gg: AfdE7ck/oP5IHZjwBQB3rGBtvBsoQBvIoOP208ohlDR+WdISODoPKXPhNMYMaKe6hRw
 vYcj7fygI8Mqt2gXxEzmtF+nPMbEoHOwAJDC71ey+2G6urHATR2VZ3HdPY7Ow9Z0wJrvAWZIF22
 gtyUOWQEcNMcFh2On83S/vdTqloeGjNVUX/cIubT07if9vaM4vd0p/8mnCWhCruOdOXyJjDZB4v
 YctKVI07o34PZ3V8Nkfh9YAu9oDGF9o3rafalpttMk76ZrMVxM7x5XoNknmELzdzODwtkSaCtxB
 nwRPs32cdJKNXa71tm9tEEMQnlBVpdcO+Dd+SJo0veBuHIbYxErzGuStoCIAXLo7RY70r5yP65S
 R/gs6ZnKmqL6po5t0G8NT0vhuhkH8Mqiw4r8FgIiqteCmhUz8ltpKUadpRDZJf3AZttgFaHOABW
 h+S5h9ojDd6q7t/FSTuHabtQ7+cmfSCRFCpUBz1o1Rw2vvnUFzzoqYRrk5Yey7i+2FOb5pgGGWB
 cJzmkikMI3EALeey3UHatsT93rXXn5iJ8yeQfgrta2MXN7yd8PrLGD6sBKVdg+obnARZ1An7w==
X-Received: by 2002:a05:6000:38c:b0:45d:4c30:81a6 with SMTP id
 ffacd0b85a97d-46a7f0ac242mr5028245f8f.5.1782214874182; 
 Tue, 23 Jun 2026 04:41:14 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666678828dsm34329541f8f.19.2026.06.23.04.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 04:41:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:41:11 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "afd@ti.com" <afd@ti.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "pavel@kernel.org" <pavel@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "danielt@kernel.org" <danielt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "deller@gmx.de" <deller@gmx.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Message-ID: <ajpw1w150SXm8Gbi@aspen.lan>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
 <0b39450b-559b-43d4-a1e9-bb6684691cb5@ti.com>
 <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
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

On Tue, Jun 16, 2026 at 07:17:23AM +0000, Sverdlin, Alexander wrote:
> Hi Andrew!
> 
> On Mon, 2026-06-15 at 14:51 -0500, Andrew Davis wrote:
> > > Move the TI LP8864/LP8866 driver from drivers/leds/ to
> > > drivers/video/backlight/
> > 
> > Why move it? You can register a backlight device from any directory.
> 
> I'm personally fine with the driver residing in drivers/leds, it's
> just that currently there are no combined drivers there, the combined
> drivers providing both interfaces only live in video/backlight.
> 
> But if it's OK from the maintainers' perspective, it will be even
> more consistent regarding Kconfig symbol.
> 
> > > and convert it to register a backlight class
> > > device as its primary interface.
> > > 
> > 
> > What do you mean by "primary"? You should be able to register with
> > both frameworks and have the driver interop between as needed.
> 
> Well, I only meant the user's (or my own) perspective, sorry for confusion.
> 
> > > The motivation is a use case on a hot-pluggable segment of an I2C bus.
> > > The generic led-backlight driver (drivers/video/backlight/led_bl.c) is a
> > > platform driver and as such inherently non-hotpluggable.
> > 
> > That isn't strictly true, there is platform_device_{del,unregister}(), so
> > whatever your mechanism for removing the I2C device would be, the same
> > could be done to the led_bl device before then removing the I2C device.
> 
> led_bl is not really designed to act on dynamically instantiated devices,
> it's very much device-tree affine (of_count_phandle_with_args(), etc...)
> 
> > We don't want to have to move every LED driver that could possibly
> > be used as a backlight to the backlight framework, the led_bl.c
> > handles adapting LED->backlight as needed. So what you really need
> > here is to de-couple led_bl.c from DT so it can better handle dynamic
> > add/remove. Then this LED driver simply could register a "led-backlight"
> > platform driver to handle the backlight interface, and remove the
> > backlight device when it itself (the LED device) is removed.
> 
> The mechanism we have regarding hot plugging currently is just I2C bridge,
> which de-registers and registers the bridged bus. So no additional drivers
> are required, as long as I2C devices are self-contained and not glued with
> platform devices.
> 
> So bottom line is, I'd prefer to just add the backlight interface to the
> existing driver, no matter where it would live in the future.

Is there any reasion that LP8864/LP8866 is unique in appearing on a 
hotplugged I2C bus? In other words if support for dynamism is added
specifically to leds-lp8864.c rather than in led_bl.c then what will stop
the same dynamic tricks from being adde to other LED drivers?


Daniel.
