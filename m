Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A0BC55ABF
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1EFD10E042;
	Wed,  5 Aug 2026 23:20:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sd3xfOix";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F43F10E042
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:20:19 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so2338857a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 16:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785972018; cv=none;
 d=google.com; s=arc-20260327;
 b=qb/cCDHX28Ta2YQbNI/ct8cR6CoDf4WQjTAeoz+z3tGanZA95sPay6wV78WLr4FpsR
 jsBtSiZur55U534JrXFlC2+BaAowWOMFQ0KQIzSLFG6iqqWKQn/rY379th3XZ15Oq2Lr
 WO9jiqcT2TTfL3aXVc5CbSBYryHoJ2JbtCvfPRfDfupTX2JmzLn1W/x4CqCJtWNdIVqp
 eskm+W0vOqJAGCUwgE2Lw96Fmw1WrH7+3Peuvp5eYz4zvyaXh3gqW7+86w36+HA+00dp
 F0uiHJFSurJkVHMisD/uvUSEKkPESQnkyTaXOcwL2wKS48arWf7wVfQrdyShJF7nr3+8
 XC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
 fh=hjqH4drSNfJnQyj2t4HXeWBXhTvX8OpIB6dHwveGT0E=;
 b=LoyiomtlUYD6165Wu4lSYFcgxopJ2O7hb5bWf/Bs0X/aFEZKaPJaQDodkqSejQuq6p
 soJmQl+bbHuSl0GBiFrzD+96YG3lDqcFsx0Y4fTnjwu+eWAYGdbNOnb2Pw49OQHya6dp
 wv9hCvxRZu8Z7+1YgXwFPmf/VcOM6MxjO+n6wz7r3d5vFzN3vjPx/mnMj4NR+7qBBuN5
 DvjElFKPXGBjkNWsVu/umSPUyEMg62+4oY5WZtOT+TbTUHKs/FMkEHgDL+lxZ1uB5bou
 JYIxLww80Z68ectEaJ3DEkEgLVXuNBX7clogrc+3sST3n+XRwDFJc1ubToEhnf3M1mdC
 kgSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785972018; x=1786576818; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
 b=Sd3xfOixYXeBM40er5BomuOwVAuhufrsMVYjgaw7mCECs5gtw7ZFZXn/UNeQuSpyYX
 xDxoQXMEdS9CPx33euaLcxJm7CZR0WR2ZbpOS4ndhBHNRmPX7smlk3535Doltb4LWSBJ
 /ZfZNCSgWgpUr+IZZ4O1Tsb6NX/e3fVKIGm0XpJiRF8VSPzod86rR+fgM+MVUBddhHX6
 ywZ4osDvtgVVpHS0kj4f+tMlcwzdOTB0aQ5lDWMrVTfYc64yKAZUh0AI5QDjA+dI2c5e
 6BHy+OBoEX/A6GcUKZ2K7fHyYJ11KKNxC6uHTQjdUYci3y4a+ZMzgmq1j/anp7VcQtVd
 DjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785972018; x=1786576818;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2BGPSf6QpIXJkxFb1vWvogj5MGQC0tI4OVE79dWp2GQ=;
 b=BVZoqB1BCixbuJ+gYcnRA29nKgzfjFVy7JHZcM4tHcKBGzU35LeWyx4Lw6H4hvfjL1
 Tg5Uh0yk8469bvpMUNzLEXYkCGKqr+RG/ulLALLiXSUlBOW8J0rjw3yXVTamoFxYU1LJ
 qLbCiGcVnnXzmzYlqoweMbip2yCcYRDd3sV7aFrEvUjoJZvzxrat0U5b2iJqxDy7ndWJ
 6CqvtAx7fquywgXcQ8A09MorFmKGf9rzKztlFg5so4oohu04PfvRLE00CSvGxCdKYYYK
 lBLA0bDLHzwvBqaqE8TqHrsI80kSWH0PV4CDezbzoQdVUij871wljsd8UgHYN8ReX5sW
 unHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJh3phSeWzwj7KGMlB2TI9q4CNVFkAsmUBeDyZI8H5HhUQRM1TiT3DN0sCwUqGBNWZ7dnQ/kDdoX4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygLvRBFYC3QJebA3DOodpdBoAXLQ5SnsNpQ4Ho5AQ5WHuBit7u
 IBSZFHph4k3yaGYml/zxP24PHq1D4bNpGhSLVZXON0ocV2/tmLgqovbhPAvX9d4Gd/0Irqz/ibS
 C64W/mh4YH3PakcSKmI52KxjPdLbZQFE=
X-Gm-Gg: AR+sD10tM89lJJERLW2D/6dx7AzbEoTpjlB70VJJxi4NJH5yp5s3SfXQuuDFBHsnUFy
 MXcB4sLnF6Yw+/iaWlc2Q6KoqVVvXg4tBc5mPX5A6Cdiv/gtuO4hqya8dzIpsG4r+Mm2jJsQfXT
 HK4XpAmORyelgjOw77j1UBnwredQmHA3a+pEuECrEH/3XLVJf1y2TZxvieD3EIwzl1RlgtE2Sfy
 QilHX65I9wNlkjVA/ew7bBNCHqvz9F0Lds7Wswahf7r4O1USbXRMCR+tmDmPits1LokkXMzVpxl
 D4lUdBxXvp/erkAKvkVK/4Jp2bkhpPwSTjvXW5Lnxb7M
X-Received: by 2002:a05:6402:2353:b0:6a0:fa22:c1b1 with SMTP id
 4fb4d7f45d1cf-6a14f14def6mr6034923a12.19.1785972017604; Wed, 05 Aug 2026
 16:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com>
 <178589017450.2494424.9339926059212534643.robh@kernel.org>
In-Reply-To: <178589017450.2494424.9339926059212534643.robh@kernel.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 6 Aug 2026 03:20:03 +0200
X-Gm-Features: AUfX_mzOCZNsmfcLq2dg0NuiT9kjwjgP0rCcSAmpyZFQYuYenYCm_iNS5xusMIQ
Message-ID: <CAEUXW=GWjTSoa6iRcA=AsP1xkKdud_rwYvgqXahmzHBYZDPYyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied
 boot logo
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-fbdev@vger.kernel.org, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Helge Deller <deller@gmx.de>
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

> Documentation/.../linux,boot-logo-clut224.example.dtb: /: 'compatible'
> is a required property
> Documentation/.../linux,boot-logo-clut224.example.dtb: /: 'model' is a
> required property

Fixed in v3: the example now declares compatible and model on the root
node, the way the simple-framebuffer example does.

> Documentation/.../linux,boot-logo-clut224.example.dtb: chosen: 'logo'
> does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'

This one cannot be fixed in the binding: chosen.yaml allows only
^framebuffer under /chosen, so any node this binding describes is
rejected wherever it appears. I have opened a pull request against
dt-schema adding '^logo$' alongside it:

  https://github.com/devicetree-org/dt-schema/pull/204

It mirrors how framebuffer is handled: the entry is just "true", with the
contents validated by this binding through the compatible string. The
pattern is anchored because the node carries no reg and so has no unit
address, and the binding pins the name with $nodename: const: logo. If the
naming changes as a result of your other question, the pull request follows
it; it is one line.

With that applied, a full 'make dt_binding_check' is clean for this
schema. Without it, the third error above stands, so this series depends
on that pull request.

I did not see any of the three locally because I had been running with
DT_SCHEMA_FILES set, which leaves root-node.yaml and chosen.yaml out of
the processed schema entirely. Your message says exactly that; I should
have read it before rather than after. Running it unset now.

> The base for the series is generally the latest rc1. A different
> dependency should be noted in *this* patch.

Noted. The base is Linus' master, currently v7.2-rc6, at Helge's request:
v1 went out based on a stable release and did not apply to any tree he
uses, so he asked for git head. v3 carries a base-commit: trailer from
git format-patch --base= so the exact commit is recorded in the series.
Happy to rebase onto rc1 if you would rather have that.

Max
