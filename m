Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67DF1CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCF410EB49;
	Tue, 23 Jun 2026 13:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="LRCvdwhs";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A490810EB49
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:18:02 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso80156995e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782220681; x=1782825481;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xQjsOKmDv4bAeAAg8kHxPjywYyxr88XeXI1w7+vf02M=;
 b=LRCvdwhsdBuYwUEzVcbuJ8OqcaO2Jq1UGB1T23ore/Cwh1vzzliZmkYD5grbMCtO8q
 abEphaUbwRYQ5tGyXS1nv1JonaR6IORvcwV34VisDgI3p1HhfCc0O/0hR22vwplZoAmi
 gqBoqV6zN5G1V31GSEt9xjhgT+Vs/G5j83Uqc1Wpy98koFLFdqlnj0ieyRjJPImjEzma
 r1ai9cKJmFlnc2LcV9sJSNJAS+wcl1ppBpKH9ggSD1wBvniytMLi399G/8hq4b4MGrQu
 svjbp4B7nY1VK0QwzlewAM1373wT3fP6hgoBz5bIV4lpatyrRN8XPQ67vdWjVvRY1VTy
 jXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782220681; x=1782825481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQjsOKmDv4bAeAAg8kHxPjywYyxr88XeXI1w7+vf02M=;
 b=DPmxJ6GR9I8HpVBL43cRGLIbHkW9YH3Fs+0T/ELMsu0e6Dxs1JyTTpfCtz6lGLmXuP
 NY1JkAxE+1l47yNgwSUvTl0WloHEFO/h8lAp/PDqy6XBMwROuyru1BKnaE4E1a1VwSuw
 OUgnjBdTNLfUghY5JH7RGE5hEe/rHKhW7Tt5p8D5CJdgqrapekZdaLT8l+4F3rVin+c7
 cau58DBC8AD34WJ3fU2Fe2AhnVjYAPMDNJdJ6tcee/KoqGMo8OrmdbsVyXuiXq/3C988
 cLkv70Pxl22RcRCRL2mkGtjWbt3NSe1kAEdYFC4sI3RIOuCCzTQsK77xlrRW79r9rgtJ
 dqoQ==
X-Gm-Message-State: AOJu0YwZM0DxCatXggumjiCYFcxkgGTANXyvd+2ycspc5HmIg1UyPnfI
 S7G/A8MkzO7lvZg1xZTmaRWIxsTLAHI3kIbP7lkbyDDCyU1bHBKEWjwD0EH3kcd+H0k=
X-Gm-Gg: AfdE7cmV4gTTxKOozfDSRKzaSq6kxmyNRATO4t1IvDft74UWxLl+rY6lfPM1KsjEB6p
 6rKoukd9V045QzUueIUPQoZkrdkr87g6kTMiaw/ObSwRvsVOWKwU+aY/961ylnPq4QPPfqbAKbQ
 GheAr+tqHq7yI75CviDGujibAgSGSurnb3vmABy0cOSRHG8sREDPmnIsKLJMZN3M7GuqxlXGY1b
 wppGEh17G6sKRn/8pWFwf31PTdxLIADZaIhpbdpVT3VHWltDIOTqg5lbTm79vpb1ioacsEub1IT
 SBb452T/M0QacYTe5zWYRY2hmZDe5LHqEjX11l7WP6GbFubCK6ddHkGcC+EhKwk37QU/F5NekID
 5iTH4h5CIbH8eO/6iW6M6PS9JuMWbHay3R+VsuavUGJsS22OQ1NpVVZcu14oSWvTkTViuCbwNWD
 yspLEQXSvcHOgLBjfpk9tUoeUvE1n/KtMA25KdPm4J4lxYZklxzGia/wYqZ+2TUbuCAZqhCZdCe
 FqWNMApt5uRtNkQmYZ9o+sWYKt2hN11X87CNp/JM7mZuTZOpd9uWafSl4btcJBT7anhhfGflg==
X-Received: by 2002:a05:600c:1548:b0:492:39b6:5a30 with SMTP id
 5b1f17b1804b1-4925b38f01bmr37906055e9.35.1782220676494; 
 Tue, 23 Jun 2026 06:17:56 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c5de7sm35009927f8f.15.2026.06.23.06.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 06:17:55 -0700 (PDT)
Date: Tue, 23 Jun 2026 14:17:54 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "danielt@kernel.org" <danielt@kernel.org>,
 "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] backlight: lp8864: Convert from LED to backlight
 class driver
Message-ID: <ajqHgqKsh4CpMm1I@aspen.lan>
References: <20260615120353.3409035-1-alexander.sverdlin@siemens.com>
 <20260615120353.3409035-4-alexander.sverdlin@siemens.com>
 <0b39450b-559b-43d4-a1e9-bb6684691cb5@ti.com>
 <acb13aca040ab72b9e53abee3a5c8733ebc5b8dd.camel@siemens.com>
 <ajpw1w150SXm8Gbi@aspen.lan>
 <aa34231591d2e5f848bdd74524abb4fe85123444.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa34231591d2e5f848bdd74524abb4fe85123444.camel@siemens.com>
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

On Tue, Jun 23, 2026 at 11:59:16AM +0000, Sverdlin, Alexander wrote:
> Hi Daniel,
> 
> On Tue, 2026-06-23 at 12:41 +0100, Daniel Thompson wrote:
> > > The mechanism we have regarding hot plugging currently is just I2C bridge,
> > > which de-registers and registers the bridged bus. So no additional drivers
> > > are required, as long as I2C devices are self-contained and not glued with
> > > platform devices.
> > > 
> > > So bottom line is, I'd prefer to just add the backlight interface to the
> > > existing driver, no matter where it would live in the future.
> > 
> > Is there any reasion that LP8864/LP8866 is unique in appearing on a 
> > hotplugged I2C bus? In other words if support for dynamism is added
> > specifically to leds-lp8864.c rather than in led_bl.c then what will stop
> > the same dynamic tricks from being adde to other LED drivers?
> 
> LP8864 is not special in this regard, not different from adp8860_bl.c,
> adp8870_bl.c or lm3639_bl.c, which would work in my application.

The most recent of these drivers adopted LED support in 2012 whilst
led_bl.c was introduced in 2020.


> So I just wanted to add currently missing backlight_device_register() to
> LP8864, but there were no such dual-API drivers under drivers/leds/ that's
> wht I started with moving LP8864 driver into drivers/video/backlight/.
> 
> led_bl.c however could only be hot-pluggable either if one actively
> creates/destroys platform device somewhere in the code programmatically
> or uses DT overlays.
> 
> Just adding backlight API to LP8864 would be much more idiomatic, I'd
> say.

Maybe.

I think I might consider the drivers above to be historical anomalies
rather than idiomatic examples.


Daniel.


