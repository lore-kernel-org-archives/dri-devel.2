Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27072C55175
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8371710E474;
	Sun,  2 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+V2y7OH";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1467B10E217
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 22:02:12 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so3950177a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 15:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785621730; cv=none;
 d=google.com; s=arc-20260327;
 b=I1Wf+PnifP5+3V+8wc42BoxK+oUni6GwBTkca82t8HQGnQ2GAQYQKMJImQQyWLdBjR
 g0BLkrNFYy6Fw9rBxJrcgHbT2M26LX4SnyDdtP5xqEzZ97CT6/bgEqgRLt2txN9tvAqU
 4LzaN3BdKSpG7lkwuVx3/fMBUKmkokbqj4Y+ZcEs3CfnohB4L3g4sKqVGu5Bfw+TMNqa
 aCj4NEclfFYfffn/85NebNNo7Fowiov2P89rQ2Sl54jriqW+4Zn9naGG31VipiH8qfTF
 OtReDuxrAjNSZN48GlIJM8FpfBVMeJu3M4Z/iN0BlW8osGvb5X50bkGjCAbT1JmHzQz3
 W5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
 fh=hmYgGozDdHIQMwFVBAkfXNmg/yqEySt9mmcz5wLMQOE=;
 b=gkCag6Gg6F/ukFbSfxjdG7vpsVaBxo7jCJzNBN+0Y4TrA+58DNoGRiOYpo9NOQT9FR
 reP8TiVwhE9Qx0nkLvk3Ct+Z6yiKMN4raMNc3Ls+RgG/VUtX5x6cksdfGbcesKtuiW4S
 wCUYmjPCeVtKW9JtThUWNgQchXP0nBqpQFOD8VcVCIdNXv4h2V9V5Wcl/QWY3rzLbwjy
 HaVLRJlHhBAFPwrIP5+PH2zwOqfkTWRFkqrlrwfIFsEn58P6IpC7ZojrBrBLioFMBaPf
 3WSQD819HI6ss5i2ZAeXGDreX68vtkobOXzQgP8HZMjoJApOLdGPQM1Apm6A1F8WWi1d
 D0jA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785621730; x=1786226530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
 b=P+V2y7OH2iSXa7iqa67yB5Es9CfKoGLOHiEANMfGiSxyvFrPmebH7nsKRnhTbn+HTw
 6gM2xdIHKcsUly6hZ7bdMJ9piSXn5oeNMv+MxZfYwjf/6bkGHDOkCxvQx6/ygfsI9YXR
 VhL8A6F+5DLn2d2CX7XNSCj7QbGo84YdH/c3xZnOFIxHECAVLV8gv2MxqVnulSwWc/Oe
 C8r1ice1zFA4v1DLZc9a2Cg2gHn4weJ0h22Buhjwv8ivbuExBd+pfKmdT0bg6gMc+/Qp
 E/nDw6C/x/EdJusyOMvOVgB6JDikpwcvRsC+Thm0F0fIi4y2/Ef/xQKw+EzjpK0o6Du8
 +3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785621730; x=1786226530;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mRPnZZvS2qFMF4MYzT26qlGn6HblvmPRKe4fqm9r0Zk=;
 b=lE/Qdr0NH4i1YtQF+xHbNtl9OTquW53YquYLNOTepaykqbpfEDhjg9M2Vz0HeAu1FK
 egHGMIezK8mmoQA5u1ZLqqgEQjiZNpZ7txPrQ6x487uuTHtiXx95166/U4ZnEUJGQNe+
 SrEMVf/tx4yXCMCxbDXezMBrXxVhBYXjVZk0ncvmyQf6Aax9l6s93jV/CMmDA1uYLMHH
 IY5omPDPxZSvb3iusS4ElN11DYwSlDIVRbEc5B2p2Pn9cbCf2avLdbl3aObQQ6ABOaXA
 ScgCYimWhVhKGVfAIgoxLxlnjjN736KhCjDnAf3ODb+OjDaFLiQfR3p7l/tPu6GaPkIx
 OGGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RooVLoGruOg8vxWHdS8dv/w/GHas5texLeg09gV/sy2d4sbFcXkXpWOsQVarzcFMrlhbguKx3bOJkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrXcPEM0QXQaJxU+N5ZBXSLIlnNcOfzUQhp+D8Ay8Rl78svY/g
 NpaTER30bowaQtR3+4rf/xxLTECS/SdABd9blyGeX7YcrgqMbTwpyICTYiAy7LSJDQK9wEwLps6
 TyOe51ExRwhbLbsNomHRRM42iH186dc0=
X-Gm-Gg: AR+sD11qxe7DYBI25l51wFahgwTWhjJJ6I6hk1zgZTjJuh+khFinsWuc6XIuvNv1ws5
 eXXD2CrdyZdazNgLCOTJ5z3rlPzSHdjc1zl7kC4CZDYkqHSy7koWzoqZyzbAy+DIpUrb0ypU9AF
 t79LvjKnudHN2jjOi93kYhKeTm07iCpzqM5m5ujNB6K0hZ1d+Qt5e5scfAst+dsM+JtliVt1oJa
 9Ir/MvSFXP/XnUEJBPQUwxXvD8jbOeSpse76hoKuqDil9Ls0ZFMdRXU9qqZz+8xvXIISVuQ0bDk
 1WJztUZRupzDBMWu3/T8XMIWh2BSSTMm0wpCn8Q9Q34=
X-Received: by 2002:a05:6402:a0c5:b0:6a0:a560:f6d with SMTP id
 4fb4d7f45d1cf-6a0a7c5ef88mr3046152a12.6.1785621730054; Sat, 01 Aug 2026
 15:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
In-Reply-To: <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Sun, 2 Aug 2026 00:01:58 +0200
X-Gm-Features: AUfX_mwycUF1fY8pRphTmL8dbgwqxDow6kFrZA_PElLtzrxC-GpVrweyge4UTDw
Message-ID: <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Helge Deller <deller@gmx.de>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

Uwe Kleine-K=C3=B6nig wrote:
> My 0.02=E2=82=AC: Usually you want to use the display using drm and not f=
b once
> the machine is fully booted. If you're using fb during boot to display a
> logo, it's hardly possible to switch to drm later in the boot process
> without flicker.
>
> So my recommendation for your usecase is to not use the kernel boot logo
> stuff, but something like https://github.com/pengutronix/platsch.

Thanks for the pointer, I did not know platsch and it looks like a good
fit for the problem it solves. It does not solve mine, though, and I
think the reason is worth spelling out, because it is not about how the
image gets drawn but about when.

These are industrial units, and the requirement is time to first pixel
after power is applied. If the panel stays dark for more than a moment
the unit reads as dead, and that is a support call. Anything running in
userspace is by construction later than the kernel: it needs the kernel
booted, the rootfs mounted and init far enough along to exec it. I can
measure the exact difference on our hardware if that is useful for the
discussion.

We do already paint a BMP from U-Boot, which is as early as we can
possibly be. The problem is the gap that follows: once the display
driver probes, the panel is cleared, and nothing puts anything back
until userspace is running. Moving the logo further out into userspace
widens that gap rather than closing it. The kernel boot logo is what
fills it, and that is the whole reason this series exists.

For completeness, since it is the usual answer to the U-Boot handover
problem: a simple-framebuffer node plus simpledrm does keep the
bootloader image on screen. It moves the gap rather than removing it,
though, because the real driver still has to take over at some point,
and it makes the logo a property of the bootloader instead of the board
description. The two are complementary rather than alternatives:
simpledrm covers up to the driver handover, the boot logo covers from
there.

> If you're using fb during boot to display a logo, it's hardly possible
> to switch to drm later in the boot process without flicker.

You are right in the general case, but I should be precise about what
happens here, because there is no fbdev to DRM switch on this hardware.
The display driver is tilcdc, which is a DRM driver; the logo ends up in
the fbdev emulation that drm_fb_helper provides, so DRM is scanning out
from the first pixel. Userspace then takes DRM over directly. The
transition that remains is the same one any solution has when the
application starts.

> Max, is this a viable option for your usecase?

Not for the reason above, no. Let me also be explicit about something
the cover letter only mentions in passing, because it is directly
relevant to Uwe's point and I would rather raise it myself.

This series does not draw anything anywhere new. It only teaches the
existing fbdev logo code where the image may come from: a device tree
node instead of a built-in PPM. With CONFIG_FRAMEBUFFER_CONSOLE the
drawing is still done by fbcon, exactly as it is today.

The piece that matters for a product with no text console is a separate
two patch series I have deliberately not posted yet. It exports a
fb_draw_logo() helper from fbdev and calls it from drm_fb_helper when
fbcon is not built in. I am aware that is pushing against the direction
fbdev dependencies are being removed from DRM, which is precisely why I
kept it out of this series: I did not want that discussion to decide the
fate of the binding.

So the honest summary of where I stand: if the device tree part is
acceptable I will post the drawing part separately to dri-devel and let
it be judged on its own merits. If the conclusion there is that DRM
should grow its own way to put an image on screen before userspace
exists, rather than reaching into fbdev, I would rather help build that
than carry a hook downstream forever. What I cannot do is wait for
userspace.

Thanks both for looking at this,
Max
