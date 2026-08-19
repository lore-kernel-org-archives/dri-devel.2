Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78409C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA82F10E17F;
	Wed, 19 Aug 2026 17:07:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kGfObCGW";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33EB10E17F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:07:17 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c160420289bso172117966b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787159236; cv=none;
 d=google.com; s=arc-20260327;
 b=hPPFzMPz8n2AC1/apnlbi1JmyznMz7GQqy5wbNa++/rbs7vp73kDEEXXTsGti3r7IZ
 ntxOtvHK+9dwj/ayRJTV/YjCVpC3ABtIDNCnv1wEEaXeRy1Y4UxbCKKVLRz3XeukBGD0
 nUXjgzFCcR7SVVTE9vmP2ba1BLSrqxkLBCkqxlmd4g+b57DEgdCe4Y7/qZMlsx2BUvGX
 sK6RC/8ac/7vSF6iZzyS/8I93om11D9epDVP/VMGbmy4j/HZEA8PLRVQNJOFoF2g33kO
 APqFm5ND5ed8lmf4b6B3QwIjeeXqcII1d6CDSmGbgxA0pRXLMtC+9d5NlULGAo9CIefB
 zytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
 fh=BOiIVY7q6Ifgs33E/Nra9uV27Naat2nchAQ5RrBwE7w=;
 b=pCekB1C78iUtuY8ih0robPYW2qCI+LONz9XxS++RrzT46okb2X7r62yBWD1vPVmncP
 9nPA6IqLahDqF9OnXXqd1RWPZmXoxuIWei4qlLSIhPgqZ6MJP9LMXI+S8X5PaM5zVswu
 8dOR6jtm0SCoHDKom6H+rYmW3rrIMi9Nn9bdnoM2ubZJFsNfr2DpkLKFkl1vzda+q/Zy
 QORVOa77XIQvxwiX0s1mW7OfwaypAkuQCXJ0YUxwbVdKe9oKlFqjMbmVSJNox1dJtY99
 UXvQJUwidRoqFAGAKchXCJDJhrlrNhIzcupvnnSYhAKRHgmYaFta/7Q5vgJh1/eMCkfn
 VGsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787159236; x=1787764036; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
 b=kGfObCGWnKjftL4OhQZafrHMnYr1J0zB9ZtsSUgI7hAJ8G/Q/y7V0/MKLS06ZzoaXX
 1B9q9+mhQLZoMuXTQWFNpjMXYZFsKvPpfF8KvFT1Ps5np7WoE4o3sP5YmFp0AvfqYebB
 Y8UWgLjka3Gq/FJr+zEO0hlksjCS72uiX5FFDJCi+AuxhZpMyiafL2I8HQgRz7tg/AN2
 9zj9rwPLnECEPCH/jxL2OjZVb2m56tGO9n5nLdgg+8r5lFQW/WMgjJ7D5F5kAvmPc8kw
 EF7NTaKecKH051gNpFDMWqrD7BV4xI9BIPgfPpO7keCBjG+y62nKVletRSVDNO8VwkoZ
 PTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787159236; x=1787764036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jKlJ/iR1cPNwjtIJybzvfRzDBetXP7ZIN/hUGlzWzgU=;
 b=BuJBTlguEsSXfdu+K74L/N1xkkS4A4uOuLiMSnmJL0e8nX5TZNw+QRaEyUqoJwxUnA
 L0Sjcd5OAJhNtxSZvECOdBGKr9EChJcwkkyFYwJLaLIcT6J6yWjSi81niPE1t1xtbZZ5
 EokISl3Dl5W1RcQ6sO2XiGoamZaFC+ocMiLiC15Y3v0g9YbAUlvbknQb+wdf+Bir2ACs
 BkiQ5eiH4ko96brubWQhMMkNxcJJG/tXl9Hr5lSURayfBO+HxoMyHT96+U97VaUIIsgx
 AEfB8edGKIyL5SXAaNHa2EBeZYhGmbbUc8PL6WOlKR1ecABK0BgwtOZu3NPuIN+QZUee
 gLwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq03DxHQBbRETuqXgGPpJnlix+lfLtNkDFE3ivs5Pgs88d8gpkQWA72nWtdim4couDEZbcSMCwPvr8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvXrcsYyjg9sFsq4uilB/6Zih+ydG7jG3SmQa2UumjFc4xYzXX
 MKOKytQKsV1EfA6PgFOlIAoyd4s+3MEM0fLQdlvSyjzYjgTwf/St2GZoiJhVk5bAWMHOB8OB7Ms
 T/4/SrmVSRnbZ/QFUEektz/ccGteNjgQ=
X-Gm-Gg: AR+sD13MxZibQCMrQS4E/d6rIOZ6Q8cpc+lf+ap87p/9f5QAyVQONfYW7/B8f0LK/hv
 Hto3H3dOZi4BqjIp/pqARf0YOWPOy8u2fPqks0BYmcrulpVltsat0qVVZv+NiLxAuJbkocDBx7a
 ERF9hREwximQGBIYwl/a0Yq1IvA3An7HHw6M5yL+hmpyUZM4j/LtVmKXYKcAWl7BWsTW6lmdL3n
 jR/Y8PNhghl453c5fxpUpbgzJsdbmYeniT/fjioZIdTd/jbK4UMhJ0eeMG9I9p0Dz5qKU5HgyaL
 lvPTgRXcciW9OouxQssk/k1nbii8CYQwBKwyZTPTKNcgqJaI1Hh2YQk5WmUKc9u8tmiL2hfXTc2
 BKZQARGZOMfYhAkLdVR40raqN3I4JfElR40nN1VQJpR1rK1qeZhQ6HYODqcKWijGP/sO9iFHoua
 DDQiPPC3tT6TK7k7IAx3N+uk5gv955qg==
X-Received: by 2002:a17:907:d26:b0:c16:84dc:9607 with SMTP id
 a640c23a62f3a-c242e242a7bmr386522966b.19.1787159235944; Wed, 19 Aug 2026
 10:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c.ref@yahoo.pl>
 <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
In-Reply-To: <20260819-fbtft-core-scnprintf-v1-1-842c0603634c@yahoo.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Aug 2026 20:06:39 +0300
X-Gm-Features: AcwNN1XtphdklIb1Xh2EgzEMsoGcQxR0A6TVYdMP1qLtFEyfNntG_muiTXDLy_c
Message-ID: <CAHp75VcGmmz6EZYjG871V+sYmJn=iGOFxj+D1oe4rtguWkipRw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: prefer scnprintf over sprintf in
 fbtft-core.c
To: Tomasz Unger <tomasz.unger@yahoo.pl>
Cc: Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Wed, Aug 19, 2026 at 7:45=E2=80=AFPM Tomasz Unger <tomasz.unger@yahoo.pl=
> wrote:
>
> Using sprintf has potential for buffer overflows if the formatted

sprintf()

> string exceeds the destination buffer size. Replace it with
> scnprintf, passing sizeof() of the fixed-size stack buffers

scnprintf()

> (text1[50] and text2[50]) so the write is always bounded.

> In practice an overflow is very unlikely here: text1 only needs
> room for a size_t value from an SPI TX buffer length, and text2
> formats three small integers (bus number, chip select, and
> frequency in MHz) that always come from real hardware ranges far
> below the theoretical worst case for their types. This is
> therefore a defense-in-depth hardening rather than a fix for an
> observed or easily triggered issue.

This paragraph is not for the commit message, rather for the comment.

...

>         if (par->txbuf.buf && par->txbuf.len >=3D 1024)
> -               sprintf(text1, ", %zu KiB buffer memory", par->txbuf.len =
>> 10);

The 64-bit number takes up to 20 decimal digits, the rest here is 20
and one for NUL terminator. 50 is more than enough.

> +               scnprintf(text1, sizeof(text1), ", %zu KiB buffer memory"=
, par->txbuf.len >> 10);
>         if (spi)
> -               sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->b=
us_num,

For this it might be worse, 3 32-bit integers that may take up to 10
decimal digits + sign, so 33 altogether and the rest is 13 and one for
NUL terminator, so still below 50 in the longest case.

> -                       spi_get_chipselect(spi, 0), spi->max_speed_hz / 1=
000000);
> +               scnprintf(text2, sizeof(text2), ", spi%d.%d at %d MHz", s=
pi->controller->bus_num,
> +                         spi_get_chipselect(spi, 0), spi->max_speed_hz /=
 1000000);

Taking the above (and if there are no compiler warnings currently
present) this change is an unneeded churn.

--=20
With Best Regards,
Andy Shevchenko
