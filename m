Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C7DC561E6
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB00810ED43;
	Wed,  5 Aug 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="AxFBzJQy";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F52A10E661
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 11:24:48 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-6626b5ace23so1429407d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 04:24:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785842687; cv=none;
 d=google.com; s=arc-20260327;
 b=bzhSgZMokKia8CZejINxvYKJFOmoQqGIdvflDEaj/xipYmEt8iukYgtU3i+TVwZ0l3
 zsR8pTMoopnsjkrcFXZFWjrkCDr7FZCYz/SsWLIOZF6byRuV9GZHB3IuHCnvxkTslV9R
 IIFgEyrZdFXbwSmtNMtObJy1ZJtruke5DrMB4Q6ej6S8B8iAZr5WWSsvAF7ErbE1buEj
 iTypSxhlknZ7RnJ08hxrN6BXI7ewZ+UxY+bKOFCnlvwe6hjUafTHw21vzIGLZb5ChK8C
 MLRarLZJUXhP70umStyqE3JTCTZxHK/rXLajn/cJf9IQe3IH9zp9FHbmer3xY/gPKtOz
 pxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uEVKlwbWy5DXWZajPw8ll3lGkPxZtANhBjPjY4Q6jfY=;
 fh=xxXKn1E7+XyotTBgkX8ARp5BZTbxXxuzYZwtoKtGP1c=;
 b=j+BDj+TLu7ufkzpGq8JLTmEzGGVcMYgZ/+w4vmlZGK+EKesTCQ/c4FK1R51NNy+TuT
 bNeq95SpkkgsWB0HQUj2t79rKPbEWKB6EPLyb7+QxSxoya6QpJqNNmtp0+G/3MEcnJMG
 JpcjUup+6bwLHxoT9DKdcii9THy3bnnqcIYowEGLyIZHjdMjPk4O2MGlplvc01/AhCr9
 ANhIb9d6F29obFB17e+VgYdwtcc+WlOuwxlzOYAdYjQvSU3z6q6KO6Nzjv9FHDnoih4V
 jyM8co7Edh6XuRqSm62rCTWCkEuTw9Z6sLLVC8aEayPIooTfZOswbKc0BgCAxWMoepGu
 KgCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785842687;
 x=1786447487; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uEVKlwbWy5DXWZajPw8ll3lGkPxZtANhBjPjY4Q6jfY=;
 b=AxFBzJQyJXEVez8XvrjuySmAKqzTlqE5lfI868aetN/ANbtyh1TGeGvIsPq+tSlslp
 XmxOsxZB9n6PHLEtYJ8EUK2TPnreXJfK3hmTNI1esg3ivNlHPCWGxL4elboveuphBnZe
 ci1+pM8CopmDepHY9o/Y2BENszcSInE5DnbLA9lGmDQJN3Nxgp3qQL5fuOyeIpdJ/UGh
 Q2qy1vY729zGPoaIZ6V+rE5v4Frge0FcZBAx3/deELlqOGy2SLVs6qGW1jkEhymkEViQ
 GOrVGCRvuIZRWHoBeKDEsi9hyIVvaBQl8dHtYUgUQG3D4fShGuKMtAnNh0oFdd0cH5qi
 0bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785842687; x=1786447487;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uEVKlwbWy5DXWZajPw8ll3lGkPxZtANhBjPjY4Q6jfY=;
 b=Wz03Fuw75w2J6YNG45kdrSmrAkqQHmRlpWzUjyz4D4xQtzkvxYPlcVDli9Qtj8ujA8
 L/MzRdSTl5baIXtiaZ49yooW0dwAO8sxciz6s0BGX4+haxfW6i9P0wMiHELd5kFmPAIR
 YNRrnxhkxYdWo8KmRk9GaFd3vta9OpVZwB7XHG72NckCUn4HnBBhW1ZNEX+yefUsFAgI
 8NjUh9uZpdsLIToCEvN9rw0NuH4RgeLafAH8piU1glt7mBK87LMVzsOpNa+Xy8EwmzYg
 IW5OpyayNla58IT03m76FhYmzzysdr36Kl8eY2wXoAoP2eLe/VO0KlguGiuxx7vuHUi0
 EONA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM+TYLWHwZp1bNd8zhJ9ZdXu54TkjpdFOI5Quv4DzoPR3Rtpo/Li0916Q5TwP6KAqGXfQrteNmX1s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5Xp+7eF/gQZRToaJL4Ibq29hF1Z4TGWS7ZXVwWr9l+Vjyu923
 eQXcQMNRKoEBHDxgCgrvMvUrMMdnfv0GEDKjWt6VpbjD3ugvd86cUT8y39ZWNY67ehGwGbYtiXD
 ubfxInlzSlcJD6X+j+U6Ied/RlcxTOkOitz2Q9YdO
X-Gm-Gg: AR+sD12oir2OYfHIIVLWpQiAOsYSR1cMLypJ8IQL4EEnBqBt5gZddNnUKLZkjFk5iZ8
 bwuwWJNWehG5ekgAMKju/j+HZnJ0/P+6Ro8SLwMY+dOVfLt4rEWFopezXRhb8hzeVAnOZ6DuTI3
 hJAvovueezJFGe3BmHwiBUiBIrHl4sa0jnpk4K6EsJ7KDKAMt8Jo2RTKvNZKyxQe3j2hxbBSNp7
 iPDuxhpcuNU+7h7w/wLUBj0KYZAtD30bVyh7yF7bmQwPsXz1kUIVCYGXnmbVnH0wWcKH3/apcty
 hkEm44WI5j502IL7Q3t3azI4NQXNDCzE92s+FXcfKYMCx4Mt1XK29FVTcW9Dz7mNPFoVxSHBvjc
 Yii0Y4BmhUN4=
X-Received: by 2002:a53:e809:0:b0:668:894e:4bf with SMTP id
 956f58d0204a3-66985b8b487mr2701317d50.13.1785842686824; Tue, 04 Aug 2026
 04:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785838269.git.sean@starlabs.systems>
 <6f65c9869714188539f2890aef6cf30e7bd2edcb.1785838269.git.sean@starlabs.systems>
 <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
 <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
In-Reply-To: <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 4 Aug 2026 12:24:35 +0100
X-Gm-Features: AUfX_mwh-6pbB3G3eHLoi8Syc4jiVFprtmWw6VDhCY8_98Qp6PgmXdAIR53yGtM
Message-ID: <CABtds-35m_cfT=Vm4MZkJYRe=dOPAKR6HYO_fu3SnwkdVQE0nQ@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: chrome-platform@lists.linux.dev, Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Chen-Yu Tsai <wenst@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, Julius Werner <jwerner@chromium.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, 
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, 
 dri-devel@lists.freedesktop.org, Oliver Lin <oliver@liuxiaozhen.dev>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

On Tue, 4 Aug 2026 at 12:05, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> On 04/08/2026 13:02, Krzysztof Kozlowski wrote:
> > On 04/08/2026 12:13, Sean Rhodes wrote:
> >> rename to drivers/firmware/coreboot/Kconfig
> >> index b78c644fa253..d273bd836245 100644
> >> --- a/drivers/firmware/google/Kconfig
> >> +++ b/drivers/firmware/coreboot/Kconfig
> >> @@ -1,13 +1,16 @@
> >>  # SPDX-License-Identifier: GPL-2.0-only
> >> -menuconfig GOOGLE_FIRMWARE
> >> -    bool "Google Firmware Drivers"
> >> +menuconfig COREBOOT_FIRMWARE
> >
> > As pointed out by defconfig change, which is supposed to be separate
> > commit, this will affect users of the kernel for no real gain.
> >
> > Do not change this.
>
> I am surprised that such change appeared at v10.
>
> Changelog is quite incomplete and I do not see any explanation for this.

Sorry, don't follow - so put the names back, or split it into its own patch?

>
> Best regards,
> Krzysztof
