Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB35C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 22:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB0910E96F;
	Mon, 17 Aug 2026 22:48:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDEeQ7ta";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F5910E96F
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 22:48:38 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c160420289bso529923066b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787006917; cv=none;
 d=google.com; s=arc-20260327;
 b=OWezyenIndumCR65r5YAKlIoDMZ7ISiBEy901aWEbrR0u43c2BKVVne44JZdsVUMXv
 6lw0UYTkdR96y9U/H8OQpxoaLvkpZY/vMln3knvVh7e9muoawkzDHh0xZaKGEe2cDPAH
 NFKSZ93sJsJd9ZxTmlDWPBMwhl11eOUI17Lhl2p68mcZV9wlZjFLh7gpDqMMetNz60QP
 wIHJZg1qNWiKZ0dIBSfHtcI3ADt2gByNmeWS5UDG+52JO819rVjWJETU/yDmflZVaX4w
 a6s2mvIA3gm7nd00P7MJYVNmXBPqm23PINlOMLJc6ZerRn6KT+N3Iqu7Sjo5IA2MHrR9
 Qipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
 fh=HiGIPVV6b2KgulXWrqBwFMNe1tt61WFthPqJkxv862A=;
 b=OYejTlfMxOWZX9Y4txGN3DTIGtcRmklMM1lC5oFb/wEuEls2LJPVlQdveg4qPIbWGs
 VELqLPd/gtUzniP07satL2Dpg8Ph+2MUDNrwzYaGz6wNDMAm2TQWGF4uNoh8oj+Zj7Qu
 WsOSnJcwtkO8hb05m31FgC0XQisq5OtRAORtZzl2x/rEe9Yrzdt3pYjrkGKba1rrJ9c4
 QcC4lafm0OoMbL+o6eDLqHrkdxFeAap+vp+ZuoIRhF6vFkeZuBQRiCmGf2gKTEkyx99r
 dgHnXGKzDA6j7KbWOgoDrHAeWR1crtwFcun2ek8WW6kwgqwOAKAj2doZgDSIuqkqa77N
 Uo7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787006917; x=1787611717; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
 b=MDEeQ7tagdMn/u4ZTMvTurVmjPwxSEb/NcS8CFw/Vk1mXx9yTs7+1tc5E9Mon5mse8
 wBrfw2Nia1BAVc3D356NZifOIagGsj+3K4mSmV7bDC/vrm84YHpGIuDrKmh+C6RxtCB4
 47qCDdy3GYknlOi7TQ+eIZkVn3Q4NpcT7RkWfnVXSBUo2uZndc7RyKOMqOifHnbQhzXR
 kcvz1Ml2xn+onI8FbqCb/JKHk66r4IwmTkXaYeTZhs844mIFIXYGuacH0MVnfI1FbGds
 SEQaimI+L8or4klyFxK1dslqexSZ9khqsn+/m5LEvVPK1rj/jmJ/rr/r3eWWjD4AhyiP
 PHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787006917; x=1787611717;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q8RULe1QAJd8R3K15o5RctOMaBUubC8V5OsER/7e59o=;
 b=HPV8j6ZFPzh+jVzL3gZ7NHHhneC72AcasNc09l1hm6VuxQWzzVqR8ScxgPUqHHLt+Q
 US84KjR56XIWYcD2htyE3rS7avQgfcS6e2MhWtoa4enbm55jFW0blZJSQDDCgDVA75UL
 sqGUKst6da/R1lBWgo5Er09MWviOOvvVcZBYFPcPXD/4E5p5LM8np60Ih04QDAvBrURi
 hTH3O5ePidYNLlR45BN9/gb+bPd6RXfswY2EYk76w639RLOacGk8g5Yr0yM3Ojn9CADd
 hcBdHnMCJYayAElGjum5K1jgnKUQGexHN87Rk7mUB3x6MLApJ7U5xAMxcZ35dhBGeVGh
 hanA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrPr1THDi3jeBTGGXbTlZ0CIumGzBINbQQhRmwySATIWGJteomqeEsVb2J/35+mp0Qv5VPBm2sXsoY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywJ0Zg/66d31GEWl2ROcqwE3TCGrNkyqomSiHXIoUfU6+/HMdB
 RGsrGGcRtP1bKSnXtp+ZknOpMDYqTK+Qz2beAOLQD/yd/V7ZtvlJZ1fraMsykBJm4zv31dxkDra
 zdShf3mkkBYkYqbzd1WVaGfKQSA8eOlg=
X-Gm-Gg: AR+sD10u8zDEXewM2mdf2OA4yUcXwzgoFgdVdmtGom2OzekTDEixx6IHL4IXfBpziyf
 ZNg6XXPi15uuSzzdWGniB8l5yFKAO27PI3Du4N6kePh5UlKTiQzGnhLJJ+o9+GTDxcOLedtqhV+
 wBir7PcFBpfZ6MIhxPow52KMErDhMPiKzKP2WTzpHpWpKS0pRBfUjsV+jesju1wOyvKis0nq2DW
 yvPg5f9SU/MqdoPd05qHsywFvEAPoF+jZVfnBPRl2N78RDjwP2WRBLtBdmKB8BZ2/yij/kXWrMI
 M94oBUiGYrcPyN/suRryevjHAr63YCF/MjHhPoTiHIxGedKoDY6Veafr
X-Received: by 2002:a17:906:ef0a:b0:c21:61a6:8825 with SMTP id
 a640c23a62f3a-c218880200dmr169252666b.22.1787006916867; Mon, 17 Aug 2026
 15:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
In-Reply-To: <20260814155325.GB516994@ravnborg.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Tue, 18 Aug 2026 00:48:21 +0200
X-Gm-Features: AcwNN1VaOzcnJmtGbApjtL8xLM_RPNeMVubTf0qJSVEHqCGDhHuSQ3SwYRF67bI
Message-ID: <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Francesco Valla <francesco@valla.it>
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

Hi Sam,

Thank you -- that's a useful pointer, and it settles the question of how
a splash should be drawn without fbcon: a DRM client at
drm_client_setup(), next to drm_log, not a drm_fb_helper hook.

Francesco's series is genuinely inspiring work, and it would be very
useful to me if it could take a CLUT224 image -- unfortunately it can't.
It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
paletted, which is what keeps it small: 17 KiB for 800x480 rather than
around a megabyte. So as it stands the format doesn't line up with what
we carry.

Reading it did make the distinction clearer to me, though. drm_splash
*draws* an image into a fresh buffer, which means a first modeset and the
blanking that comes with it. What our hardware leaves us with is a
framebuffer U-Boot has already drawn and a CRTC still scanning it out, so
for our case the natural thing is to *adopt* that state rather than
redraw it -- which is what hardware state readout does, with no redraw
and no flicker.

Where drm_splash is the right tool is the case with no state to adopt --
Falcon boot, where U-Boot proper never runs, or a handover where the
buffer doesn't survive. I'll follow Francesco's series for that.

Thanks again -- it helped me draw the line between the two.

Max
