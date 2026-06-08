Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FD0CD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD1A10EFBE;
	Mon,  8 Jun 2026 08:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItdgbKmP";
	dkim-atps=neutral
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com
 [209.85.219.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701F510ECCD
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 04:51:03 +0000 (UTC)
Received: by mail-qv1-f65.google.com with SMTP id
 6a1803df08f44-8ce3876a50cso40230486d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780894262; cv=none;
 d=google.com; s=arc-20240605;
 b=Tg6QVQCyidDo6uutKafRnVegTYFwlWkDmztXAP90sPIc2TzdUPSVa7TriHc1hqwoMu
 OFH57bMhHNtgfhmqenVZ/KYpqn7JZ1PvijYcqqf5E6hmOBIsLIpTroRm7M96Ck2Atq/9
 I/vjNCr4QAGZ4mTpiAPh6fTBSrFDVy1y1e0zCCDL1dOd4cQ4VC+NsBRWl8PB+ojMsFs/
 jIAT6opTLOXwUKwQGlqI+/r3KQDXLAWLItMwueUsY6R9DzgwZt9LkVY5OiEH8mapwyyP
 QhC1OG4gl22WO9TJ/rF+xfeifR81keE7XYL1Vsyvz7UCfFVQnirfH997xJ/GKkdbd0tg
 HEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
 fh=ScPY2I5uFfsmcuRfDm7M+P6Ci5vQPP4Z/s5GhDvkmD0=;
 b=QpF8EKsfOIBslDSB6PBnxuyUsmP0VmNotZZID2mkkm7BHuOKIuqLQBekNaKyrORDGA
 LnLuUIDfzgboiVMgidUjwFnXIVzxiG0TxlAlXsoPO00bC2MEnKIDsTdvjJN2lIUPDlVD
 d37vSNSAJuVS33l2dI0MZ6fiZEfCWlz77uRxGAZ7j8jVNpSoXX1T47cpIAJ2Gk42MVAT
 rkwGvCChU4ZhCTHd+c5qi0PBtsI4ITjwElSCRrFRMM5btmbbF25OY5psPirfWX6xRrDm
 W6OMvx0lCuxMF0i8g8j30j/D9LtH4Xjka6A3Ujs5OeGnWwL6QsdL1OnPG0r0tqgBGadb
 CjGg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780894262; x=1781499062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
 b=ItdgbKmPQYgmrRGmnNe5j40d+sF1PM+K3VWcnoC36G6udwxWSXsunnSavIS9nkfVHd
 Lm9oSx1RG/Js42pZ2tG5NKBhoK2EIz5QqF6QD2ntUP2K/7dKZ3ROQzUDsnI7VeuTt9Yi
 GrG79afVfn91rlSLRzy/Z2uU8iNKfu2P/K3r2YtSmDIMTMOEOTgis69kMUzSvQW4ep8j
 O6cDZ6PuMB2vNG81Wpnz5pKBv/uKGzBwdgyoXEUCelCGXt13lXEATl+JEd3Aqd7YOpBB
 HbrjTaDhS/041016wuBP0e8th/h3ta9STnWIlKw90wMON18fvFfk8z00xH7fK7esS9b0
 BXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780894262; x=1781499062;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruLdARqDCni48cQOkidWdNO1xRKIushOB4xhN0tsI6Q=;
 b=XArc+aqUDK8H7RewKw70FN//XPTMLSCdzZFkrGRhjZQXVEnEaHjjBOqcKsW5HQ8jHs
 ZOY5pZM5j97FjeN1430ktIKRXO7/Md9zdr7/8NgcJ/yUKaHUGmaxYHZopP8Yc3Hfrmov
 7imAGU1JWd8r51S5guhpi1YnKBsmp7CpTkN/3IDO2a8+N4QUoWs57Uc8qrF2sRKuN3+e
 OMrwP5OawNYV/tRxSaLj2JsT/8PQvWmnzn1n4tDIPg0fsZ/vZRVXQUpSSBbfQcUevtBG
 kwhIdfC51OB6kk8NBQX5RTVXleaCFaEX4VzDG04bgLPW1DxifWqRIX3kRM5d7BqwFPMg
 eELw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IOqM06MJ1HPztEiqN85zstOsshS3HwYV3472SdM5eyzLKteSilVEcNZ0xQ0Rl6NQjbdoVjtYM9wQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9VMO/fzjTUg472Kdtt+BMWYCEOMFpg6ttjsuOfrJxIzNmpAKx
 fxx+dB635kUi2zi1j0jb42LQTLqSg4Uel0K5zYTVWdMrQCQYu3GwKLWrvkt36WNJQlYo+bM7RPb
 xnqYYjsxQR1ztR4tlmklvI4JkjmFCM9M=
X-Gm-Gg: Acq92OE82ftJEdiP0kH6DVEX/LlUwHYraL3oaAQC/Nmihm+AA4Cd4mv3RDtSpKjeewg
 7js62+SdC4NKIfma1HC9z3bhKWlldWkrY+EWzZhJL8HIlYOdcIxPXRdk04ZN/r4W5ttdHPiB+BF
 18vINUwW4HUQK74Qg88SpW/a+CD5VuKhmI38Nw/U90lrSjOD+qRPutOPFv6dVkkIq8wGIlrG1RU
 KXiQBxcgxd5eGR/hDvLLnIPWM5yMQRQQrl6HgGbCwJad1IEZfiMbuXDlZXeYKW3pcPT9wT8BSNo
 LfCXgmF8miUG8iQpTbhmI0yheC49kQ+oogMVMAz4EtetfCo3MZlsnXbqQUKOpwGYvIncbiyWFrg
 l+iY=
X-Received: by 2002:ad4:424d:0:b0:8ca:25d3:bf41 with SMTP id
 6a1803df08f44-8cee5fb6f45mr156665376d6.8.1780894262219; Sun, 07 Jun 2026
 21:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260607210203.229613-1-deller@gmx.de>
In-Reply-To: <20260607210203.229613-1-deller@gmx.de>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sun, 7 Jun 2026 21:50:51 -0700
X-Gm-Features: AVVi8CfzWmWWxt3SB7pXX23oNZUjMnDgx_nKjpLYDIPyHFfppWEBqDIhw4T6cu4
Message-ID: <CADkSEUjJErZyBQtGDpdbt4iTx6hHZhizRJV1mRONrHjV0W1WUg@mail.gmail.com>
Subject: Re: [PATCH] lib/fonts: Avoid unncessary 64-bit math in font code
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

On Sun, Jun 7, 2026 at 2:02=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
> The text display code used in the Risc PC kernel image decompression
> code uses arch/arm/boot/compressed/font.c, which includes
> lib/fonts/font_acorn_8x8.c, which further includes <linux/font.h>.
>
> Since commit 97df8960240a ("lib/fonts: Provide helpers for calculating
> glyph pitch and size") <linux/font.h> contains inline functions that
> require __do_div64, which is not linked into the ARM kernel
> decompressor. This makes Risc PC zImages fail to build.
>
> There is no need to use 64-bit division code here, so resolve this issue
> by using plain standard addition and shift maths.

Hi, Helge,

I can confirm that this patch fixes the issue. Thank you for your
thorough investigation.

Ethan
