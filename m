Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C841C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 21:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D9310E012;
	Sun,  9 Aug 2026 21:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3x3g17w";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370E810E012
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 21:47:34 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a1b51723a9so1910455a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 09 Aug 2026 14:47:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786312052; cv=none;
 d=google.com; s=arc-20260327;
 b=kBrrjUiJbZxvC6iPYjSxiQNc/BWR+zSv56rD0Sa25YWLEPDB/oGJQef6ELI+Ma1Wxa
 jAvG7B4u5HcSUXw9AT45bm4PJRd938kyMfP8+o+QfTeJWaLwDmTFmGZCjg0ztEHzj46B
 77U8k756hbMeT4jDvds13p/HDqx3AedULYGHTkMIxeqXwws2h9OXs6PonCB9YIZlDkUA
 YLqIX+IyVkwuQBJ95uwRZ+XfNVfNr02pak3FyDL3sjui0Z80Ci+B0xDnYWITlRtHip3D
 24HBTMTjdOt8J9o0uFC+QYkOktMrWmSQERhk21tXYCXVHYa1wvRAW3W52i6A81J/GQkD
 x6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
 fh=qISWpDf+KmOpHiPZCN4UXEWLsNJ2Qw0v5QiH+N6gCAE=;
 b=tCQlfB+cK2Ejol/g1iejIPbqmm9yIzF3hG4nXmLBzmIcnzIIQRybAwm7jt98TSoN0R
 sHUoGX1mnBAzPrruI7JKorrX79RbWF2ZXgKwc8myB5RJO8xkGwtHi0MEk6qbDwP/rzPI
 +GRdZQDPlZl8ZbnsCRT+DmN20dzPM380CPNeoRtxMgx0W2JoFLPCOVzum409CHibxRgx
 5ajq42oyAQRrNkidt4oJrVSo7KRFIk4oHY4X0QZ0h4S3Toqt84+DyJcwNqJNP5JPvmP6
 oMoLpnLHTbMKdcFIbh0N91cKVYSTlc+jYWAsBrhEXHkYGPAxpC5tqiaeZ38lS0tPBMPW
 pZIg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786312052; x=1786916852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
 b=Y3x3g17wgTpda75QKWgw2r0+juQw3/K9qLx7jpmBnNDeOcHu3G2Rd0Poy5CYpltkE/
 KmrYvZI402QF5tubdIZErUFNY69WOJiFcw7T3joqo2pAv1Y25Vq6bKaN6a9s4Mb8HVr+
 U9OQoXQ7uU2JWemIORj02DiyKYBjb5wCUC+xieCkqSbFFr5MOqGm9cHknlCBqBWcX8Eq
 je9CgnU6tRbOsPQAUL9DxPRKFo2yApJqqX025orHPbS93rZ+zNQ9KfZG8I/a7Ylvmvx9
 v5TIxgWZLvbAb+d1KfuH/Qqhm5lspdB1KFUUdQGircU3HszYM22nl44iI6aoFysZCe+C
 UzSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786312052; x=1786916852;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kFa6zcCkY2hKTR0O+eW7i6R9ggV2gSRqn9c14SMG6lw=;
 b=PzWEceauClTyZo2W5THMbZlBmcKocPx+2P9w5DQfVxD4GrzUr6FrosXwr8WpV3Wq2v
 2o+e1caSBByEEhzHA7H99kKqw5tKu3qWcQJeL//hwf1ryWcG+FN4Mcc2hNJm6xo7HiO8
 xTEVvvj6ci5nQNH7XitJqGC+9iU7QstMJEDuhzyrHPDED1FjJOxKpZs+hBaATcJa2DVe
 HhQ7BXAVBJ2V9dTgaBK96A3M4beorLgcA1O0zKNBXaaLWWAwsKhKinJaeHLWoSI/33o5
 q6M9qIk2FBhPlG2nZfuqdeMlY8Ax3Gx5tQhHzHir6ysVE8EP0LJnms6PqUQ7Vzz/issk
 9LaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpR4ffik9Tauci6xwDVC1arfzLcprMqqD2D61Gzk8rTZdnaxtak3b8lxcJ5A8nIqVk1uPjkV2RRx9s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/21TU23UvlnfCXN6LyTlJhshxqvw+zLX0ewfy6inSTZpZJdpu
 DIDXhXYtVyJrGxGRE4rkj5lYBZWzExfHE1aK787Z36hJCrn5WzNbCdslXFb/4mKHZQ6kGj7UiD+
 VkozPZTO/JBtzJU1LzGQoTyxoBFkgzhg=
X-Gm-Gg: AR+sD12sFvaOWv5TVmc4q/SnHg8RnspHNGAPurmXPkxAIke1QXWt4URNTqCzTePlUDD
 EqUud5K4GuUqY1EjKw+iWg5wzTH0mdD/aOFt9OhdhbdEf5yn1FvnfnYSxO2ItE0xcnsTX6HiBOX
 rPS3NEiQjGe+A+VXrt0+Vv4M543hXfOFEvnCzgQxhI7Rloc3eOBHaD4QUIqWM1ApW62P6UEK3og
 DcLtRsfZaUYb/yz7zdVibKO6vcf/8zPeEa6Q24oGBgMJc1L1rRFbcOaainIOKQHSAAod9vFGuSK
 pJNXSZbW1Yrk+5Qc+m1nceO/afiKwrebbKdnS9uoqfZP
X-Received: by 2002:a05:6402:3215:b0:6a0:ffb0:273b with SMTP id
 4fb4d7f45d1cf-6a14f00169fmr20000239a12.0.1786312052321; Sun, 09 Aug 2026
 14:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-3-maximpedraza@gmail.com> <anb6ejVQMPqD7G3r@carbonx1>
In-Reply-To: <anb6ejVQMPqD7G3r@carbonx1>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Mon, 10 Aug 2026 01:47:16 +0200
X-Gm-Features: AUfX_mzKCodxQvroNt5kk61f8zcTHiHxpI_vZk2XUB7pEBxAz8egjMYfztdkV_Y
Message-ID: <CAEUXW=GPXiGaShnDp4X8UrK+2_cgd2NS3XPZyJCP4i83wOdGEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] video: logo: allow the boot logo to come from the
 device tree
To: Helge Deller <deller@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 devicetree@vger.kernel.org
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

El s=C3=A1b, 8 ago 2026 a las 11:44, Helge Deller (<deller@kernel.org>) esc=
ribi=C3=B3:
> This patch feels "stamped in" into the existing code.
> I do understand that it is by itself clean, but maybe merging it
> better with the existing code makes sense.

You were right. The placement is now a patch of its own at the front of the
series, with no device tree in it:

  struct fb_logo_placement {
s32 x, y; /* -1 centres on that axis */
s32 offset_x, offset_y;
  };

fb_center_logo is exactly {-1, -1}, so it stops being a second path, and th=
e
device tree patch only fills the same structure in.

It also turned up a bug. fb_prepare_logo() and fb_show_logo_line() each ope=
n
coded the same decision, and my patch had made them disagree: the reservati=
on
took the larger of the console position and the device tree one, the drawin=
g
took only the device tree one. Both call one function now.

> why so many fb_logo_dt_read() calls?

Down to one, in fb_prepare_logo(). fb_show_logo() is only reached through
logo_shown =3D=3D FBCON_LOGO_DRAW, which fbcon_prepare_logo() sets.

> I usually prefer if people use the IS_ENABLED(CONFIG_XXX) macro instead
> and put it at specific entry places

Done in both files, following your example.

Checked with CONFIG_OF=3Dn on x86_64: neither object is left with an unreso=
lved
of_* symbol, and the structure is dropped from .bss. That last part needed =
a
second IS_ENABLED() in an accessor that read it unguarded, or the compiler
could not prove the read dead. Also built a Cell config, where SPU_BASE mak=
es
CONFIG_FB_LOGO_EXTRA real, to a linked vmlinux.

logo.c was the other file with an #ifdef around it. The rest of the series =
is
the binding, the reserved memory parsing and the host tool, none of it
conditional, so there was nothing else to convert.

One thing the reread turned up: fb_logo_axis() added a coordinate and an
offset, both straight from the device tree, in int, and the binding bounded
neither. A large pair wrapped instead of landing against an edge. It is don=
e
in 64 bits now and both properties are bounded.

The series needs this, or dtbs_check rejects the node wherever it appears:

  https://github.com/devicetree-org/dt-schema/pull/204

Max
