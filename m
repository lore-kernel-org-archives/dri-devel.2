Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0833BC61DB6
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A7C10E980;
	Tue, 25 Aug 2026 09:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="O2Be2iUR";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC54A10E980
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 09:15:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so26828785e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787649324; x=1788254124;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KQG7I15zl1cZ8xoz0nJUhoyELZuli5z85AXKE7Cy0D4=;
 b=O2Be2iUREOgaUt1Sall3oDJfkjyB4Dk6UqQsX90GFvED/31LCXNMKlRnaS/9POlzzx
 8e5xWJU355SeIRCtFTaGD9WrRenWhm2K6IFWNlBURicM/HtA8dEAX76bSVRG5sRq1fuR
 EgsnBcpJE3Cx/MnTU37/CgjGsGr5TUdpg/1SG5uT8zCbdMT729O7AJWrBuqV74rzHZgQ
 /VsJAyPmdSWdzQWXpKlfTW8U2X47+BKG8rs6d7YEcbmNSCZnhJGMsxKJ2taUCaKaQBHu
 aPCbJ6r79kV9I093PXgT2Wy15qQoxeDo7yuuAw3D5NYCUkpJeT+fnQVllJKYI+KR3Wm+
 GCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787649324; x=1788254124;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KQG7I15zl1cZ8xoz0nJUhoyELZuli5z85AXKE7Cy0D4=;
 b=TlOvEo0Kb6RojkluRraapvflYDYQHNN+b2ViZt4RYfCRqerFuRllNSfaHWCjQRwT/z
 Ydt8OJ/hau4BaGUflaLl/fEgp0CQ8TpkFhe7CkimBZw/lwDTCVa4KILd4RXoUCOYjCwa
 DtHpnhKHXiqp29c4DsAMeNMou97QBrRUEnAXv5+9nbj/lGIrYfe5w2VbBCqoM11LNxl1
 AzTtExIsHPkENPOJb2lmwXA4xrgvccAaqoc5HbBDPpprelLR00R/BKERH6Rjs5xPRG0d
 SkexJ1s48fX1hhpNotRnCIuAUdv6ULXnsnb2EmJPVhxMZd6faGfqSU+jzN18BOO9I73Q
 DxFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorKMNIIOtddRVzsO+rn+6jXT4+t2nQLpDEtGF//BmHgrouf43HOSfJ9K5xTaW1j9+2tkQksi9fKq0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ko86WYYmgTnspjbuV5Rh0ar4rg+nLntpgaLhWnk3s/LzGOusAc
 0dCVxcQnC0IW/WPF7zG6QwUaI3ulGPLC/W3UVFzn1zdiMFhnnmWbT6mYXQ4eWqT5dlk=
X-Gm-Gg: AR+sD12teXAYXWPrXir6JQKV9c1E9ySVDYy6H5mBFgRavEPEy+tQtbLsJ0yBvDGLmcA
 QaNn4mxwlM2bLXy4aCirhPqiZw7qozRayIGaBzvE44C2Hmw/hXk5q0/s1CkhmlwBpQv3HTP2ZBO
 RO/7bXUBhJeFk2bF2cxKKzB9YhuuKVDUScGKPYX16c9c2KW2ZXNbvKLfwhpWMS/+mDxkGXb+UiQ
 Nf7XwX0T6PDutxeR9mqNxqZUBOKhh1FQwY3zBcpWAoRWCh/VHlLAaTxSTaMv72C4T3H6A9nqsz1
 uEDkSCUQ9hWmZeuahP/bplOgII+meE04TFI+YG0Jy4uhmm/d3f4Hfpj3gEce9faXiwn9E+dljrQ
 2QQgPcOq01ANy/gLL+BywigCKKOzarD/tkylboZLPEg8LOmKeT/zuW/Z0KIzh/w9YZKnZcIvT0M
 PHuh099igKzevFkBdpf+C8c38wzNrf+B7nRLSFM/PeLGPMP6IZsA/8znDkZsTsiH7GRwdNsQWGa
 9NZ7puJQ6EpaxkncbysiO2F23l4MrrRReNqoxyxM69Kb/j6Zto9BEb/jvNAQXdONbIbKj71Wzqa
 qIi5ZYe7dyV70bArNvZRttSQtw/01RB7VXG8BgWkbjiOjQ==
X-Received: by 2002:a05:600c:c493:b0:499:7aa7:eaa7 with SMTP id
 5b1f17b1804b1-499b845c184mr414028865e9.15.1787649324060; 
 Tue, 25 Aug 2026 02:15:24 -0700 (PDT)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d65c326esm20415775e9.10.2026.08.25.02.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 02:15:22 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:15:19 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Andrew Davis <afd@ti.com>
Cc: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: lp8864: Register a backlight device
Message-ID: <ao1dJ1Ce6qcp9USk@aspen.lan>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
 <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
 <aowP3K7sgXKnsonS@aspen.lan>
 <fcdc4b46-dab7-40fe-9b1e-c5c2e2ef8dd7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcdc4b46-dab7-40fe-9b1e-c5c2e2ef8dd7@ti.com>
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

On Mon, Aug 24, 2026 at 10:39:19AM -0500, Andrew Davis wrote:
> On 8/24/26 4:33 AM, Daniel Thompson wrote:
> > On Mon, Aug 17, 2026 at 07:08:15PM +0200, A. Sverdlin wrote:
> > > From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > >
> > > The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
> > > standard backlight class interface in addition to the LED class device,
> > > so it can be used by display/panel stacks that expect a backlight.
> > >
> > > Use the new devm_led_backlight_register() helper, which spawns a
> > > led-backlight device driven by our LED and tied to the I2C device
> > > lifetime. This keeps the driver a plain LED driver, requires no
> > > device-tree changes and remains backwards compatible with existing DTs.
> > > It is a no-op when the led-backlight support is not enabled.
> >
> > ... but when led-backlight support is enabled it will prohibit the use
> > of the LED sysfs interface.
> >
>
> The commit message states "in addition to" so both are registered still.
> The issue would be in the [1/2] patch if it disables the LED sysfs interface
> as this might be unexpected behavior to not keep both interfaces active.

Yes, led_bl disables the sysfs interface of any LED supplier(s). Note
that this is not changed by anything in the patch series ([1/2]
rearranges the code slghtlt but this has always been the case).


> > Having zero DT changes is a nice property but it seems rather fragile to
> > change the ABI the userspace must use to manipulate the LED based on
> > CONFIG_LED_BL.
> >
>
> If this was done in DT then it would also change the API userspace must
> use in a non-flexible way (DT is also considered a fixed ABI for a board).

Agreed, although it does allow an existing board not to change userspace
ABI based on a Kconfig option.


> > Is there no way to explictly configure which ABI should be used?
> >
>
> I wonder if there is a good way to have the actual use of one API cause
> the other to be disabled at runtime? So the first one used disables the
> other, but that does sound like a race.
>
> Maybe a mod config to disable the LED-BL path and keep the simple LED
> sysfs interface would be enough. Or maybe a sysfw entry so it could
> be set per-device if needed.

Mod config isn't "nice" although it might be a good enough solution for
what is probably a fairly niche issue if nothing better comes up.

I'd also note that a mod config would also allow the driver to error out
when CONFIG_LED_BL is not set (with a hint on the logs to either enable
LED_BL or set the config option) rather then the current "secret" ABI
change.


Daniel.
