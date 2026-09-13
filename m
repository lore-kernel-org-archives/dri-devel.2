Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555DC88E6B
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:53:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B0210E9DD;
	Sun, 13 Sep 2026 20:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qjgPoFSE";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9269310E4DE
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:42:13 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-97e9af41731so237627241.3
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789332132; x=1789936932; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8ee+7gFBh2B/5NzYVSDcJVxrx4aUxOp66VqIfZZZWKk=;
 b=qjgPoFSEuInkFJ9thM152h8tWc2As3nroPFiDzc4Guodaox5XvFwP5cr6F1xbSmt8K
 FlD5tXvtw9scDQq1a6Bo6tAwCMl5eTs7OyoVhRpyTpv/qW/YzLvB1uRUrsZqjc3iwn5l
 Tz5VG3nUXIKLOjb9fizzuExlVoKSzufENdqLwf3JpfVqBvkMKxrIZs9sucy8E0nGcB8D
 HuofCyEdGtNz3WCotflRCX2uchdqE5HEUV5BbnyrDAS9El6qlhVGRSY+3xxcK9FfjjMo
 NisA7d4DRFUbIAHW+4gdYcYecWLWD6xXmsBu59IE5ZttmmC+p7hu9xIB2eSzUOwACshT
 Qfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789332132; x=1789936932;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8ee+7gFBh2B/5NzYVSDcJVxrx4aUxOp66VqIfZZZWKk=;
 b=AkSipnvOZXCHhhQUYLQBlCQLNx4o0B22FIDyichBNDTQgMHpr5Z55d1pU3BBUG5gJl
 +M1pMfSgLrKUPfXl6EDAdhQJN2zAbV9KKBBK18SGaWjVfayER7UHzR9xxqcSrHGmq9gB
 6qprF68aw22kwBu2YgHH+fulLeHEkPrGl55VHpzXmyyTY6Htc+/cfkQF4usbOkn90mFm
 1R3Qn/uBUogv5AXh1NHT0oQSilwMu9wE6Oe6j7kK7vVCMglKwm3J/M83yk8eIVMJcuGG
 CWyHA1B1jIgvd0V6Yb0GrZvRf3dxTyW9J67OT1/CMAy9LnyRP+RKs3Y7UlOS7axJ4YJi
 vjxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTQZbV9udn9OKZzhcqEcex3tQc1qYp269Opi0XWn9Ex2hxKc1RhiZwevKtN8vuCv+KB66Pmtw4eU4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsJMJRQ9VajXE6vIFxrgivsA0ksFsnX0bBl4aFrmldbmsUsC/Z
 NImzc2wsAqgnXVHALjS6STF4jAQF/MuNyxGFri35tDog0tZvWVlHOKx4
X-Gm-Gg: AYBFou2L1PMmiZw6WfUin0e3YAC9P/dh7p1uL6ilNR55FaEnEzvJTa6v2lyjmFpBzju
 QDvhse5xG2fCiMk49TCLOhwmwPo1uGNzETyTuzqhuNCsw54PQvAUOyAqDrVamxITwJSuuSX1G61
 M+Bnj7Dw7XvBosbhcwsXFIAIenuxD2SrLuPPYWAzKhedQ4gUGx3tnMiaQqW68hLb6T4rRk5z5bw
 bJLprqBb8uwDOHeedxC6ueGOZgfxMSzDBOo5QpcExMGWjCShmTzcEcu4AWMMlvtzL1FJpUIJfDN
 /Nirkh8tQ2yIw5Su/kVLUJYFeTZWpP+BYzfdCmrAdi1dZFlEfKJsOpnj7d2KjjzclDnSkvBhrBx
 hjG4CekI975PmSFS/qCcKZgYu2mu1Rd1RnOq7KIQMO6rmpQbNBVFH5PWY+iUXY9feJ3GrSkAyp2
 MbKRJKDSmRFA2FDI3+XdzWnZ2zDz4dvDU3FzKK2p1/z2Rstmw/rW5uleQW/APQhujgvIUrSC9DK
 Q==
X-Received: by 2002:a05:6102:330d:b0:783:f3bf:f9aa with SMTP id
 ada2fe7eead31-792ac9e510amr4898086137.8.1789332129863; 
 Sun, 13 Sep 2026 13:42:09 -0700 (PDT)
Received: from [192.168.0.10] ([189.60.169.129])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-982b9f41426sm9597329241.6.2026.09.13.13.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:42:09 -0700 (PDT)
Message-ID: <f8fbfb26a60bd664bb4c436acfa541b5e4976916.camel@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: panel: mipi-dbi-spi: add
 sitronix,st7789v-tft28
From: Frese <freseenzo@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Noralf =?ISO-8859-1?Q?Tr=F8nnes?=
 <noralf@tronnes.org>, Neil Armstrong	 <neil.armstrong@linaro.org>, Jessica
 Zhang <jesszhan0024@gmail.com>, 	devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-kernel@vger.kernel.org
Date: Sun, 13 Sep 2026 17:42:05 -0300
In-Reply-To: <20260913-easygoing-chubby-sidewinder-67beb9@quoll>
References: <20260911203342.76692-1-freseenzo@gmail.com>
 <20260913-easygoing-chubby-sidewinder-67beb9@quoll>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Hi Krzysztof,

Thanks for the review, this is one of my first kernel contributions,
so please bear with me.

This panel is a generic hobbyist module, wired via jumpers to a stock
Raspberry Pi 4B, not soldered onto any fixed product like
saef,sftc154b (Anbernic RG-Nano) or shineworld,lh133k (LXA boards).
Mainline has no Raspberry Pi overlay tree, so there's no in-tree
consumer to add. I noticed sainsmart18 currently has no in-tree
consumer either, though it was added as part of the original binding's
example, so I'm not sure that's a strong precedent. Would a
documentation example, or an out-of-tree overlay demonstrating the
tested wiring, be an acceptable alternative here?

Vendor prefix was already fixed in v2 (sitronix,st7789v-tft28) =E2=80=94
sorry the subject change broke Patchwork's series detection.

Thanks,
Enzo

On Sun, 2026-09-13 at 11:34 +0200, Krzysztof Kozlowski wrote:
> On Fri, Sep 11, 2026 at 05:33:42PM -0300, Enzo Frese wrote:
> > This is a generic 2.8" 240x320 RGB LCD panel with a MIPI DBI
> > compatible
> > SPI interface, based on the Sitronix ST7789V controller. It is
> > commonly
> > sold by various resellers without an identifiable original
> > manufacturer
> > name printed on the PCB.
> >=20
> > A basic mipi-dbi-cmd[1] script to get the display running looks
> > like
> > this:
> >=20
> > $ cat sitronix,st7789v-tft28.txt
> > command 0x11
> > delay 120
> > command 0x3a 0x55
> > command 0xb2 0x05 0x05 0x00 0x33 0x33
> > command 0xb7 0x75
> > command 0xc2 0x01 0xff
> > command 0xc3 0x13
> > command 0xc4 0x20
> > command 0xbb 0x22
> > command 0xc5 0x20
> > command 0xd0 0xa4 0xa1
> > command 0xe0 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x44 0x45 0x0f 0x17
> > 0x16 0x2b 0x33
> > command 0xe1 0xd0 0x05 0x0a 0x09 0x08 0x05 0x2e 0x43 0x45 0x0f 0x16
> > 0x16 0x2b 0x33
> > command 0x36 0x00
> > command 0x29
> > command 0x21
> >=20
> > $ mipi-dbi-cmd sitronix,st7789v-tft28.bin sitronix,st7789v-
> > tft28.txt
> >=20
> > Tested on a Raspberry Pi 4B using the panel-mipi-dbi driver.
> >=20
> > [1]: https://github.com/notro/panel-mipi-dbi
> >=20
> > Signed-off-by: Enzo Frese <freseenzo@gmail.com>
> > ---
> > =C2=A0.../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml=C2=
=A0=C2=A0=C2=A0 |
> > 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
>=20
> So v2 send in a few minutes, with different subject so Patchwork
> could
> not detect that it is v2, thus I spent time there.
>=20
> Same comments.
>=20
> Best regards,
> Krzysztof
