Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA631C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 19:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63D210E118;
	Wed, 12 Aug 2026 19:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jsthuy9V";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 264F510E118
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 19:48:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4994d67d260so1665e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786564081; cv=none;
 d=google.com; s=arc-20260327;
 b=ISacP2GPWQLRH93JBLIG2Fz3oju/MP2MVGLDf/DNvDGVaaHaPqHrMtgUBCMZDn4Pq0
 rUzwu01gsZSLci3sWi0gwh7hw2WbIeviFbPxL29PX6oO8qywQTDKo7j8egMLH29IA15r
 crJXoMh4m5c+MVlLwQynTjljbu8jQbqRjKjzqDN7SFUYbcPREmGoz2cWYxP/SaaaT+Ue
 4wUPBPi3EV61A7UgKLVbZg/OE34sP7j859kLslpzq0GaIU8okrjCJ2t0r1SSHL1Q1V7T
 cP6AOAqPng7I/vMElf0HO1atoD3WtKP+2SD90dV++Hsow55Daok0E0E4pb9w9qHylS16
 nO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1DVjTbKTXkhH1yUwpD/lgRqJn/mvRVunuCZAxUjSgDU=;
 fh=0yA7EcGqhy8Y/AmxUjxbSCcJbGlgWyOBwOrQDSqd4Io=;
 b=MAyZGqfihFkbGrKjRiuS8AEqN3Lo7rfAZVbl52Jcq4EnVb6g7hG48R9oi74vDq7fwH
 iksNE1fMyQNQ23eqwgZ7BjEPWcvMgzl6Uv/mGX88b8lYsdfM0N8+oxTtPqfNaCNawyCA
 sT6raI9PGs9O5bSkkqdiLamGIch2hvc7sU4J/V9LOC8bydjjp0qcGdZOjfT3smEq7QX4
 sXBxDjNBhZUvSWTU+Cz0Oe2Tu0HF7pVrho/9FP7EzU2TFoTVRAOc8liKh6xDO3YAHjQ0
 kpJ4blGYLsWgMZdXn/WQ4POvkBgURebKp1velolgKll2j3fMON0QXpEWUIJMD/xxQOwL
 G6YA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786564081; x=1787168881;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1DVjTbKTXkhH1yUwpD/lgRqJn/mvRVunuCZAxUjSgDU=;
 b=Jsthuy9VkJEMAqJiBD3T+jHefS9Z+Na76pvOHy5s08zegQgYlO/eGlY6R4KqdHVeBA
 rFbsMVzzCzqOUgr8HahNcq4b6plgLa9HvGI4X6t1U1xsy8Z1Q94fwBbF3uc+2Ka48Qh+
 T40lCVIcxnNFKZ0NPMWKzlsOfZ86u+F5vKJDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786564081; x=1787168881;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1DVjTbKTXkhH1yUwpD/lgRqJn/mvRVunuCZAxUjSgDU=;
 b=fAEIG0L1rhkjr81rbY+k4N1YxrZwASbrsqn7YznclgxcwFtfH6RszEJjiE6cgCsXbl
 7AqXbqhN0prax6MWMkPEIcaURagXlcHGjtZvhgVNp5g5TJQ63YvVwAG3XzpLZKggOTJI
 FuVslsfGUp5Ol7cc7J7osVdl1KfXrUeWnMiq/tFA6tTJd3psakF230hhVu3Fbm8Mut9v
 IgBbMERpROx1brqjwHjC8ORs4NVD0HjP4by3p/Qs6m6WABy4rcgKdRkAvJF26DPP+XM3
 BCU1S+cXstdiGg6JWHnGVqkPhgU9XoB7uCRODwXl1K3wUM7rE5JPG4zs9a4wn6K16Erp
 Mm+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXxbJZVkJWp2XnLDMn7gKb23CE+04VtiHu56+i3MIblcyzAykM3+1SaKRQMvCqmsfm3N3Gv3jQ8U0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQyFDEQcwxpH3y1pREbvGEpqeggE8RX+ohH1AYmGzf+XUHjPYn
 E2fgLED5ZH4tT+UnGAU7qKDEYqzq89FUjP1N5VoybRnNeXYJpvvOHAWlLO1O7V9Z5L7pOWCbJix
 EC4h4irCWfs0jpHpXbP9lyXWXDnNIoCjC9QrbqQt+
X-Gm-Gg: AR+sD10vDBVW7DCpTBxdwxOhEVH4xkIfJHOp+C148zcxuOa08d2jJioUqKiqwHZKvI+
 O2nFltnPgcY8Ld1ki4C3kU2LuxdVtz04VT9iuNVRHzK0i1bBR8OXjOINJWbxWrFVxHUox+h4jpj
 Zc5P+6fddmQwKZmHsPgVCEsHn9AhzDK2FAD8MMl+84A0Z6XeeuND7in8uyyG0ccvgGeTxl9/zo6
 jr1rIRQF+diJwh/8hh77K9HjuKBdqssV7Mv86Xy75/wFfnDbZl3YijGTK+0M2fm2ZTiKSoSiYJN
 bYHhahFhjLfwn/vYx34JljsAml052SldcYcZkrI0IyPZo6SkwgAgCzvUo/UBuBvl34Fx8WRQl1W
 QPEw=
X-Received: by 2002:a05:600c:a29f:b0:495:4069:b0de with SMTP id
 5b1f17b1804b1-49981fabe30mr92875e9.9.1786564080986; Wed, 12 Aug 2026 12:48:00
 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785838269.git.sean@starlabs.systems>
 <6f65c9869714188539f2890aef6cf30e7bd2edcb.1785838269.git.sean@starlabs.systems>
 <e0d2a22e-a0cd-4a71-82c4-b88abcc7456e@oss.qualcomm.com>
 <04db0ee0-a8d5-4f30-a494-5c7f8ac757c8@oss.qualcomm.com>
 <CABtds-35m_cfT=Vm4MZkJYRe=dOPAKR6HYO_fu3SnwkdVQE0nQ@mail.gmail.com>
 <64d82edc-87a0-47c7-8a17-f0d1c806a294@oss.qualcomm.com>
 <CAODwPW8B2-i4Ne-ZTVUM_H-EZwn2hoaC4joRhxNM=CREDd_aUg@mail.gmail.com>
 <c8e4a3d3-a96d-4fd1-85a6-881e68385c83@oss.qualcomm.com>
In-Reply-To: <c8e4a3d3-a96d-4fd1-85a6-881e68385c83@oss.qualcomm.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 12 Aug 2026 12:47:48 -0700
X-Gm-Features: AUfX_mxfmohhDd7NwZ5OlHrJ4eVefwPyRshu_429PA-DB0FUH4Xn3jxZI6eV4zY
Message-ID: <CAODwPW__tskkkqSREHFAf9iG17oYfG5Li-1kh0y8pX=z0W_31A@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] firmware: Rename google firmware directory to
 coreboot
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Julius Werner <jwerner@chromium.org>, Sean Rhodes <sean@starlabs.systems>, 
 chrome-platform@lists.linux.dev, Corentin Chary <corentin.chary@gmail.com>,
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
 Brian Norris <briannorris@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>,
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

> I do not consider marketing or pure "I do not like this name" as valid
> reasons, because this is developer string (or kernel/distro
> configurator) not end-user visible thing. And for us, the developers,
> this marketing does not matter.

I'm not sure I'd agree that naming doesn't matter for developers? The
style guide has an entire section about choosing good names for C
symbols, I don't think Kconfig symbols are fundamentally different in
that regard; they're still strings developers read to find and make
sense of things, and leaving something with the wrong name makes it
harder for the reading developer to find and understand it. (This
isn't about "marketing", btw, Google the company doesn't care whether
this driver is called GOOGLE or COREBOOT. I care as a kernel developer
that this driver has been mostly used for something else than what it
was originally labeled for for a long while and it's high time that we
correct that to avoid confusing people.)

> Anyway, defconfig change must be separate because it goes via different
> tree, unless this is non bisectable. Keeping it here initially confused
> me into thinking you are actually breaking use cases (which you are not).

Fair enough. So Sean, could you maybe split this out into this patch
which does everything (the renaming and adding of transitional
symbols) except for the arm64 defconfig change, and then the defconfig
change as a separate patch at the end of the series so that it can go
through a different tree?
