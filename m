Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E73C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E5C10EBCE;
	Tue, 22 Sep 2026 08:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="EKthcVyA";
	dkim-atps=neutral
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42AE610E1EC
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:06:31 +0000 (UTC)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469a33c9cso4239007b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790006791; x=1790611591;
 darn=lists.freedesktop.org; 
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UOTeQSx76a9v/ZV3YujOIEiYlAr7+SRsnm3/O5Z68jU=;
 b=EKthcVyAJG2wzPK20cOjp94WQUBWq5vhSYxx1BkerIaqBn3UyXX+Thw7cZMKpFfxrc
 1oXDfOmCsOOTQLgkYhWNlP1VrHO1Vfm+PdiX7XiAygRPcuHKKs4TyJPGIxXkVtYFVSa4
 2oenQL9gAz7zrjkA86EEYJslV0kWIk9kgLODtyRPWodi3VrJ3QzmalaT9S0cmztdLlyr
 DA1hEWJpkaOkxa6w96BvKEtBzPZFeBZSZDodwUfQfPunRBJPKK0vLZDg3Arax+WYNb1K
 lb+kDN6ZxcO9xRNANuupjSm7vZiux7JvejuW1u+YMTDSGhEiiKomNI2sL1cu5gVNo7ys
 KQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006791; x=1790611591;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UOTeQSx76a9v/ZV3YujOIEiYlAr7+SRsnm3/O5Z68jU=;
 b=QVyMUPJuoH1vuKn+Zuln8OlZsgmPFmxrcywxaIQf6HKbc549H68EtRRtRoKLAhY3P8
 fyumY2zVByQVkFxkEZnKzZYdJntoLXv71vpKxjYTw0i4Uw/lJr76iDCSH5jhZqiBi12F
 DbZBzmBG7dMlps+8/eOgv+/YMeDS51k6wxxNgTaYMVXZ6FnOBewjf/8TGiFu/e6QLWym
 gteaVWE0qaVQx/q9RYDtX3FQB60+2u6RLJubqCoBqIEIDXe2eNUdbvTdp5SZUeFfSOor
 kRE8pD5Yd3RuHxgr6rMSAWgj9qYWNYXb3g00enItc6mZURMnATpDkMCjoSzSzG+csN35
 Jo5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYBeB/G/UMHpZ8I03p/yETPT8xvlwOygddiGScJRlN8Vy4E6ayThClihJlkhO/yVryufoQ86fiYg4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nU8a/C0zaSgpDFoUPx9LdtaTM68JogdvaEQU2cFxmsL/IRiPdJ
 3Wl0HXnCyZy2UEqjlvZMR8ujMsVW6MTzyOdVlAPJoppcnkSxdPrFpqiYb8JZywF7VEs=
X-Gm-Gg: AYBFou1zhPDnIFPktOTm5IPrqiVBB/a6UbrOc1Ubb4A1214ltRdFNLiPlrcZpxnF+xX
 YACOZTDYKiSIU5Uvij6swmG8ASLJGxvhwZFkuvQh5v4qXV02y2o0yxgKphybn453qcw+hZCCHHq
 U2t2EiQeSdCBsGuquJf0rol89ux0KLRuEAmlRwBC5s2kuoyM6n+IKbQPb299e5+g8CyRNJFEkbU
 pNHLDTwo0pUKKPoUiv32t42BZ6tSesfdIitWUxcJ+39e1q9jHFY7QfKqzGvyOPQJf9djZ2+dBrw
 F0CKclf6ZsU/qemejS7Opk30+Qw4T+V8Ve7srYDD4xNePN4JqgimBZFARPrVQ7TwOY8xpJubgag
 ORZqmQrjs14eOtIgVjNs8d9vl6Ostmrcd89itZ4GVs85QkPzpqo0WxnO2Ki7oVvd87IXGF7NI+V
 YJEz1AIgM8fWqGq86OZchcx/VTUtPcHUj9d8nAH+KEhaJr+5fSZpWxJ55y9A0HyHLFlwA=
X-Received: by 2002:a05:6a00:ac8:b0:878:34d7:6a30 with SMTP id
 d2e1a72fcca58-87834d76f20mr8319100b3a.36.1790006791257; 
 Mon, 21 Sep 2026 09:06:31 -0700 (PDT)
Received: from localhost ([71.212.197.238])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-877a95f915csm3487490b3a.29.2026.09.21.09.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:06:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>, soc@lists.linux.dev
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Kemnade <andreas@kemnade.info>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul
 Walmsley <paul@pwsan.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Helge
 Deller <deller@gmx.de>, Tero Kristo <kristo@kernel.org>, Stephen Boyd
 <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, Aaro
 Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 06/14] ARM: omap2: remove omap24xx support
In-Reply-To: <20260914140821.1805449-7-arnd@kernel.org>
References: <20260914140821.1805449-1-arnd@kernel.org>
 <20260914140821.1805449-7-arnd@kernel.org>
Date: Mon, 21 Sep 2026 09:06:30 -0700
Message-ID: <7htsnid1x5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The omap24xx SoC platform was used in the Nokia N800 and N810 tablets
> released on 2007 and was among the first ARMv6 CPUs in products that
> made it into products.
>
> Unfortunately the early ARM1136r0 CPU cores had a number of quirks that
> caused a disproportionate amount of work to keep them compatible with
> later ARMv6K/v7/v8 implementations.
>
> Drop the support for this SoC in order to allow removing ARM1136r0.
>
> Cc: Andreas Kemnade <andreas@kemnade.info>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de> # omapfb
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Kevin Hilman <khilman@baylibre.com>
