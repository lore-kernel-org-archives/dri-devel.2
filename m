Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E9DFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFF0A10E2AC;
	Mon, 27 Apr 2026 13:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IqEYWray";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0892F10E2AC
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 13:06:01 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso69340035e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777295159; x=1777899959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8iqGCzMLvZ/FUHTnqulEZ9CiBEz3wlFLR64nRtCLLQ=;
 b=IqEYWrayLlmrXXO3w0D32LNPBLdfAPsCb4zLbRjX7wxTKWyQYf1FpPpJGtTU/x3fRy
 /MRohnhvtqdpMF2DrEISSU+qMrZPPZRIDaP/J3WQV/ZKm7/8gzk9L6DO+l6Ywtw/aJpn
 XolXy1512dqc7hLBL3YnhnrimpGrm26d2zXvrivr+6EaeP8YeiNAHPQvT8TL84Dwn48L
 In9UbeMKSXkQxOcxz6Wy9zPUgkXRnoWrOCHfAUeC5wxZeu+b/AOjtEDZ1TZgyg5i1XKl
 5+i+2DivNhqVzeOP6s8m5wCELeLPMKwZz+OvJEF3wFs96lkE2yFXXzOj2qRNvz7RRmkL
 EjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777295159; x=1777899959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F8iqGCzMLvZ/FUHTnqulEZ9CiBEz3wlFLR64nRtCLLQ=;
 b=AgLMn2/4tXCM9mJiOcC6ttlQ92Wc/gj44EQGQgIcVZqwR6W3GC7sVYRU62E6UACgzR
 +KOzRtZ2J1RX0WrdgyjCTRkVJOxILNVvWqug09ugZryLxAyHwrp2v7ue8QVEqYJ2Hn9o
 8FNGk/tq7nU5yfVYavkJBbRzsHvw1FqwjKz68aeXnwScNjmxbUF5oOALHa0XKMA7ii/x
 O2NKTAinikS9/06PEj4iTAz3GY8KrKObo4+/uoy+gKsvM7fvmCqczUtDspoozESKYCQH
 TkWFulQo/0k92yUuj5LWRHKtjCDrgdn9MnfCu5XL7i56eeMd5BOh5ZZTbqK48epaQ63l
 tmfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gaysECxFoXQzsG783oea4wI2eTbUE39aoLDqOo96XKCpoceGAF33ufHjSuzbml9NDM2Ky+yCu+Is=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJFqx6yphVjld4uN8Ld53tP8zvv+p+ny+cpn2VMbF4fe3TMVW2
 QedMX5UAQkV+TE1JqQJ6qEwDyCGYs3MKl95c4VM800yUvpHBSVyXvP0U
X-Gm-Gg: AeBDiesxJtYnjh0C9+b9EcOlJudx09u5tHxcnZXx49G/UCqW2RF1JBdw5S54uanhtY3
 iSi4IwDPYMhaw5awUZd0zxiL8Ze5OnR4clhGNafc50V8bJIU1/9hreLmt/foPREVqTgRAACeZ6y
 6kLACyV6wkkf9XXS46FUmwmmzKg2LmtTCvBlD/4k0iaYGHChg12mSKsH8gFq59Gp97yoa9Qr0MN
 yD7cZPg6r/nrOoBp42kiO3SNPzLOVDzAf89/jPLO3a8NnDUNUy9tWkWzSZjcm5cGCJwa/oKAfIU
 QA3l5N9WslTKCNKnYcOgXTh/d0hA2WOOrbWfAVVgHZ1h9UPsN21oIG6+v2BoHmwlh1S4BcbY30J
 9e8TZ/yR41T8nocODYvOxw50XmfSb5vO9SWH0fgPjubhzBdBr5eODuYyL8MZGzQXPSjBjygQGpD
 t++ir4fr4c5ndve+ZLelLBmoVSOKJAFkDGCH5/YIhz5m4Y5v2+VpDVeqOO7LQ6z0Ckaj44pyc97
 0o=
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-488fb7930famr614025895e9.24.1777295159074; 
 Mon, 27 Apr 2026 06:05:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb75ab25sm247366475e9.11.2026.04.27.06.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 06:05:58 -0700 (PDT)
Date: Mon, 27 Apr 2026 14:05:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ai Chao <aichao@kylinos.cn>
Cc: deller@gmx.de, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux@armlinux.org.uk, dilinger@queued.net, adaplas@gmail.com,
 James.Bottomley@HansenPartnership.com, FlorianSchandinat@gmx.de,
 alchark@gmail.com, krzk@kernel.org, kees@kernel.org, rene@exactco.de,
 tzimmermann@suse.de, rongqianfeng@vivo.com, thorsten.blum@linux.dev,
 chelsyratnawat2001@gmail.com, soci@c64.rulez.org,
 gregkh@linuxfoundation.org, daniel@thingy.jp, linmq006@gmail.com,
 fourier.thomas@gmail.com, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-geode@lists.infradead.org,
 linux-parisc@vger.kernel.org
Subject: Re: [PATCH 03/35] fbdev: sisfb: Use safer strscpy() instead of
 strcpy()
Message-ID: <20260427140555.4d001050@pumpkin>
In-Reply-To: <20260427090910.1940231-1-aichao@kylinos.cn>
References: <20260427090910.1940231-1-aichao@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 27 Apr 2026 17:09:10 +0800
Ai Chao <aichao@kylinos.cn> wrote:

> Hello David and Helge
> ...
> > > > -            strcpy(ivideo->myid, "SiS 730");
> > > > +            strscpy(ivideo->myid, "SiS 730");    
> > > 
> > > The compiler knows at build time the length of myid, and the "SIS 730" string.
> > > Using strscpy() has no benefit here either. Contrary, the code generated
> > > because of using strscpy() is probably even larger.
> > > Don't replace such code with strscpy().  
> 
> > Both should get converted to a memcpy().  
> 
> > If you increase the literal to be too long I'm pretty sure you'll
> > get a compiler warning/error from strcpy().
> > OTOH strscpy() is more likely to truncate the string (I'd need to
> > check).  
> 
> > So leaving it as strcpy() is fine - and possibly even better.
> > The header files might get changed to error strcpy() unless the compiler
> > knows the source string has a constant length and the destination is
> > big enough - but that hasn't been done yet.  
> 
> struct sis_video_info {
>     char    myid[40];
> }
> I have rewritten the code: 
> strcpy(ivideo->myid, "SiS 730-0123456789abcdefghijklmnopqrstuvwxyz0123456789");
> Used gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04.3)
> There was no compiler warning or error. 
> The strcpy copies the entire string into myid(causing a buffer overflow),
> whereas strscpy only copies 40 characters into myid according to its size.

It depends on what is in string.h and the enabled warnings.
Testing on 'godbolt' gives an error with both gcc and clang without any
special compilation options.

The linux kernel build errors strcpy() at line 799 of fortify-string.h.
strscpy() doesn't (and really shouldn't) generate an error since it is
expected to truncate overlong strings.

Since you should (at least) test compile any patches before sending them
(even trivial ones) you ought to have things setup to have checked what
happens in a kernel build.
Ideally you should also run the code.

This really means that strcpy() is better than strscpy() for copying fixed
length strings into arrays.

	David

> 
> Thanks,
> Ai Chao
> 

