Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52645C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FC010E5A3;
	Fri,  3 Jul 2026 08:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvTcsAc3";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2709E10E5A3
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 08:50:29 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-37e0fb87b75so419504a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 01:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068629; cv=none;
 d=google.com; s=arc-20260327;
 b=NxIP8yNl+wQe60wAunlzOas0Q88v0Fo4U2Ya5T7uL/isH3Pymtt/24uED1PnLvHuoD
 OaXx1IN5RSS8qYSbf3SNBJA4pNqmzTfFUiglDd5tFNKGQUVdaNsJDAA4sa4M4p+9J9UD
 KLHhiKN4ca/wU3jyOIz6LkKHEAYWvMBF0ZUWOrjRfAcr0PTrRgZhlWhrpr/scLGLvCvZ
 2G6++XJC5sr2eewOAGVWLfx27ZlPxtgCI9/ElieCzSDz/SkY+vEfT9i9IPO5NoiDckLg
 F1WpWu1H5s5DN/tt6xSnk0vr3sG1kMemhS34pdmjlmZaE93Mme0gnX3XGDzUy+Aj//Yz
 u1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
 fh=s09EW0am4ySlHybYqoIgYw0m9jQ0ntatIREyl+e67iw=;
 b=eV2AFTt77aVpoFwRFqEUqwAMGZ6nn5X1nNRWigl4A+2bXwfEDjF1VVfyI4p91fgMVM
 NQ7NzuWr83gy1mZIIZDUrR1WH/SpfzOs3K/AkcxF1RRDipud/a/SB61Rxwwndl61NIQ8
 GLpzCytyzTp1KsccL9AgyVyIySanBzSawgXwUoFvpdd3d3oWHybx5LZJpEAeMXqsoGPJ
 MN34TLKQqjSZ+5yoMpE/qhwUMI5ZI1FWaBzHpA4oCNJ9TleZNZ8KEQR3OZR5mL4PprMX
 kceBfv2+ZRT+ea3wMZpJ4qH96ms6sxI6WKbqkdckEGXDVCscLXcZhdqwKPaFjZCtGO+y
 Bfbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783068629; x=1783673429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
 b=cvTcsAc35WFX4F+gzxvd/zJ3Z5OFuTkO5c2vtM40Kgqa8LNhFjE3hLUladRTg7ZlWw
 T6zpGG1MUxY+EaZIk5fksKbU3jHwuD8XmdbyQrIgJ6TPha/aiBlQgzSCp/fGrQ4W93gv
 ffXTjY/mXtblIps0NtFw5OVfcIer3WHWkHNM8dz8nb0LXczoGiR2MOG48tFsOOLpFE5V
 FkYIKfBdlvt1jwhy9A0Kf5m2zMWwQeHWydkaKnlXi0rmtp8etzw6yy3sft51RaD5wXG5
 +wVF1syQgXG1Cmz37NmNbs1OV1sQup10gFZkN5LT7Vv8s1pnnRgY2NCQ8Rt6Tmz6dEm+
 dRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783068629; x=1783673429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIGfUZOnaS68j2TExBUBX6hHqwIcodMVFuEw4DTpCW0=;
 b=AQ9BBaRvxkvNeCEKWmoV4NYHjXYjAx7aA07eEu/QuHufvUY2BgzyBbsmprM7R+EeLM
 8nqWss7kfK5skibE4cfsyJp48ej07TRjSujJ91AiwmNfgFzBI5wFiu0acHFgrq+mhLta
 BqzM8dsgn973Ls48qjRprvR617Eik3bWvA8MU9IHjQRPyhSXT4Z1N1p1IY3gQXIallJy
 9OAONq2ofjeJssEjVRztvjRuAn5t4isUHR/Fp4Ho/XspHA8vLxx2pnwV3N/VssMmF1pg
 7QbD/cCx/kPkC7KmNFyPibofkTdbENv7cpQ3kRb4G0BSbvFiFCz7q8nLVLQQ4XmAGx6W
 APsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RozPdjCg4XU8LyFhXUH0kDvgy/mIimLZZGNdvClD4LAWFod/9YRk1LgAAIGD+7QMQBmRUBqVLZG4x8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCXRAtZy7cuCsIsCM0l0oQdFUzpP/4GpgAIrrKUVP9TfjTWrjU
 HBfFVE2fixDmpJJBhg9kOp84yeszJBgV/cKsYYoJTIIHUXpD0DAB5ldnMr9Xa5f+F+3pzd8UUq9
 MWbCWkXFDxMFhRJ+ZFXIupVCpafSiL7U=
X-Gm-Gg: AfdE7clFU0BMWhuqJFoR03sVcOdDXYDaJUF0EjKkFKQRsznGVFSbXg4iU6/NmCYOjZX
 3v78N1majq+aq+bSEH10XqA//a7bNFKuY2Gig0ojdsANuet/f4UOLgHj6B/DEi+oVAXrWi4MRxL
 hOLYNjyCZwrclE2Lt7EvqbbN7FYeKrU0v8nyK+J2FlLPUbdapQIvAaX63pcdvNRGaiAQd5Kh24o
 N6nbtUePZ65hcxhi24YbwEM0vEYjmDzjQPGCzsnKJmGqBcMRVZTVRdWxf3vwfs9MTrqdYSzvlmr
 KbGrRQ0M3Z18N+HtpmpWptbyRJ6ywg==
X-Received: by 2002:a17:90b:4ac7:b0:37f:9ce1:cdb2 with SMTP id
 98e67ed59e1d1-380aa212cd2mr10449000a91.32.1783068628598; Fri, 03 Jul 2026
 01:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260702161828.GB2108533@google.com>
In-Reply-To: <20260702161828.GB2108533@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 3 Jul 2026 11:50:17 +0300
X-Gm-Features: AVVi8CfxYzwSfzZ6fk5dLYRyOYewH3BnmAC08YjOJmTVCgpVqq5v1ruOm9aDpBE
Message-ID: <CAPVz0n1Pozgz8DBt5BrYSktVfE=D5E41oy+fMODGpx-L-qQ3YA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings,
 improve support
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D1=87=D1=82, 2 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 19:18 Lee J=
ones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, 17 Jun 2026, Svyatoslav Ryhel wrote:
>
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> >
> > ---
> > Changes in v2:
> >
> > schema
> > - maximum led sources for leds set to 4
> > - anyOf > oneOf in ALS
> > - improved ALS descriptions
> > - adjusted example
> > drivers
> > - dropped devm convertion of irq and mfd helpers
> > - all als configuration moved into lm3533_als_setup
> > - added regulator/consumer.h
> > - lm3533_bl_setup set before sysfs_create_group in backlight
> > - added check if LVLED is valid
> > - LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLE=
D5
>
> This set looks good to me now.
>
> Let me know when you have all of the Acks and I'll merge it via MFD.
>

Hello there!

Jonathan and Daniel added their Reviewed-by for IIO and backlight
subsystems, so I assume that should be all required.

Best regards,
Svyatoslav R.

> --
> Lee Jones
