Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00364C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366A889AAE;
	Wed, 12 Aug 2026 12:15:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M8yTDeHW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E79D10E3BC
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 12:15:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C5C4F60DB6;
 Wed, 12 Aug 2026 12:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D451F00A3A;
 Wed, 12 Aug 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786536945;
 bh=m/lTjthowLY5myN4clGgpfitq6Wa5xz4eSQd6Fu/Ldc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=M8yTDeHWu1YFX0IDtQAcTjaqf2VVVGfSd9iIDMnPgvgB0ZWKZufzqkUdbfbWgKJy8
 UkLrNT72w/F9PEGYZir5TKN4C4VFL4udfm5ondDRT111hmYYP1scyG0NheKOvP8rMy
 25RDLAB4yABmnvGQ/HTEOLLp2+gKEHlt/DiJZ31tGpwg0ycRhc9TSnqhzFGU1nCEEu
 S69bB6uscEykIU4xIW4fxuVAGxnxfVGRhjavGLlSXWRF6rmDZsBy0CXBsiNDgB8Nwp
 EKRz75ewgtj+KTg0QmPpJeC8JSCdGXQzHHV1i4pqOKnWNhPWWA/Pmx6LirQN21s0dT
 AJZq0o+9Z/Mnw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de, 
 Julian Braha <julianbraha@gmail.com>
Cc: rdunlap@infradead.org, duje@dujemihanovic.xyz, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arnd@arndb.de
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
References: <20260719024902.151710-1-julianbraha@gmail.com>
Subject: Re: (subset) [PATCH] backlight: ktd2801: fix unmet dependency on
 GPIOLIB
Message-Id: <178653694321.1389451.7114353733646459636.b4-ty@b4>
Date: Wed, 12 Aug 2026 13:15:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
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

On Sun, 19 Jul 2026 03:49:02 +0100, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
> 
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
> 
> [...]

Applied, thanks!

[1/1] backlight: ktd2801: fix unmet dependency on GPIOLIB
      commit: 5859fa79c7d85d0c242a9a1ffb40bab9732d4ef1

--
Lee Jones [李琼斯]

