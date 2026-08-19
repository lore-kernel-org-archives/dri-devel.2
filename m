Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC925C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082C110E256;
	Wed, 19 Aug 2026 18:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXuDuVOA";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1896410E256
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 18:21:08 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c214321dc32so248671966b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787163666; x=1787768466; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hThuAHpiuNPzFZaRiSmIoF888oHhxzPaNMpB0afArQ8=;
 b=iXuDuVOAkz7Kmgo8fut0eOEuHSQV/oz/wAlcwIohCJ7j7m0XEgcQk+S+RMLhOLir70
 XuVeJm8LUX6dR+KO+iJiy5TeSZeOHtHeVUAyu4uVkZhxx4AJqGOIGMSxmglXEN319Zp/
 8MVd7FWE5eEqSei+lA06CE02ncSrZ/ywWqrxlZTlcVVpywQJE9Io4yGDtnrCP89jv9qi
 YuKlfdGsgB82cy5OjtD483F+2nuC6+XMdvjOv5akUZVDcUkq9pdnCcexQhGUx0x07bWi
 dbmfhr76YNhBcePIGrZIbKFb6oypcPk2Tj6Sg817yZuK7lWCBnSScMDKVjey4M5bqgEE
 Draw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787163666; x=1787768466;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hThuAHpiuNPzFZaRiSmIoF888oHhxzPaNMpB0afArQ8=;
 b=ZJE3Z+CROQLFMtaF4i0Lv0F9RvZiPmyJ82/HbMWyawL3ywLFWbOXOyyqWb3YVIUqIP
 MAizC0h69DdnaviARIVGwUlvjLU08oB+Zi4DIl7xulvzF9bdjtkBpsv37CTGfKs5ssnU
 ndwHWb4gpdyjXdTYpjGWqizL63tmQzR4Ec65rIG+aXvCOXqTaGUbBAOP3XxaTBa5WucU
 qG0oUuuqw6kCBG7E101Y37trTMHECMWD6ejEWmHTpskLT+IfKJK5TwjpUjGlSxYt/Jix
 dsZHeW4tWtJh9jmKIaEJdsBH0ifUkMd7nFP4Yn/NUxh7VY2O09OnU3NqwzC2cm49lfhi
 aPSQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyiuN2IoSHs0BvzdX6mX0+9CEfEil29Z7NUdCIuoqbbERKfJptJxC17l/Udqm6SSlszvUTywEcZUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa9iE6xTqLi6eJeCfmLLQ8L4zoLqi+/tUInRBWe7tpp5lpu2Dn
 +LvTwIIru3Cgdk6L58y9rRm18/ABRnUffRJh36UnTpdKKYgC7vS5N4uP
X-Gm-Gg: AR+sD10d4uMXvL3I0tN4PPiFeXUnaGwjmMuN4Mo+QdQLo1nCgoPAtqCToy2Iy/d+WHP
 hO1aWMEjUU3dhOR4K54gCcDcGY4gAFk38jrU9ksExGt2r++KBChasjuKJPBhDBrEFCurOjgGHAi
 DbiO0orsVedqWQLP6ONhlzl2ZvUP/mBZGZpIYOx7HST5MFk42ojaPbxqZ/6fBXDgPSszMcSfm0e
 ep+pekJ4oQW+b9bCDr4VGpxlGEWOfTGrq1ZYaysHRT7jW/EWKTqjCFmuoCmF8zSuLKR00fdHBAk
 19M3NRfsAQecK98IV02rr1mWUhP5Fwd6uPnAvIIoL7h5HgnkTOk7i2xHvJq9cyriONRDuDu19pn
 gI7jwxLpcZ4onhLxhNUgXh00AHJWm5aFPmesGuT13/OQdqJ90ah2eNW28gEzKZ9H9TO4NO59Qw9
 mT/e7xp1cp7/36JnUqdPrLRL1IflSc9snRO+/6Bbd25KlRC2ZiujfgbDGAx7UH4nnVDTk=
X-Received: by 2002:a17:907:d649:b0:c20:1c9c:b36f with SMTP id
 a640c23a62f3a-c23f937aa93mr417904166b.8.1787163666346; 
 Wed, 19 Aug 2026 11:21:06 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c243c5a0780sm112050366b.31.2026.08.19.11.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 11:21:05 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:21:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tomasz Unger <tomasz.unger@yahoo.pl>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in
 fbtft-core.c
Message-ID: <aoX0DiIcLG4Cxvwk@stanley.mountain>
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
 <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
 <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>
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

On Wed, Aug 19, 2026 at 08:06:39PM +0300, Andy Shevchenko wrote:
> > (text1[50] and text2[50]) so the write is always bounded.
> 
> > In practice an overflow is very unlikely here: text1 only needs
> > room for a size_t value from an SPI TX buffer length, and text2
> > formats three small integers (bus number, chip select, and
> > frequency in MHz) that always come from real hardware ranges far
> > below the theoretical worst case for their types. This is
> > therefore a defense-in-depth hardening rather than a fix for an
> > observed or easily triggered issue.
> 
> This paragraph is not for the commit message, rather for the comment.
> 

The paragraph describes the expected impact of the patch and it
belongs in the commit message.  My problem is with it is that it's
1) Wrong because it says unlikely instead of impossible. And 2) goes
into too much unnecessary detail. We don't need to know where the
values come from since even the worst case for the type could fit.

regards,
dan carpenter

