Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9973FC79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 946E110EA56;
	Tue,  8 Sep 2026 07:08:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZNbB1xR";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E559910E79F
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:15:09 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab1ba47so31521d50.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 04:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788779708; cv=none;
 d=google.com; s=arc-20260327;
 b=WlqQVRO/mzuVgOd6j/ST2ZpkqIhydSnEb/0+ZhS9tbXDp8JEegobAcMywEHlGjisb9
 ZaIMVOID8f/wW0NGIV6QuBqs+sTD00971v99Kwm1VwtyBvDKBQyKSlOIT2dqGoz/KqY+
 5kj3FZRiIAY1dDXK7FEVZGl9DxU24MIP/0S4jNOq1542Rw9VYpMme0Kh8sAx6A1JOZJt
 MfJHL0AU/UN2Q7eOLhBrDk5+2buUElrmck6g4hf5zjboes7cOqq68EOQuRiHBYsjghQ6
 SdxJEdHhfEx50WyLK2jFPFHkwi+fjQ94CopFcQ8jJoXSb3gS8+ulDik7YBIjEnIWovdc
 PB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
 fh=oNtzNWK0i909gPvI/6httceXSsdfLeDSCG89KzRJofU=;
 b=d4Mg4ZQWi/No8Cw48e9HFqPRUHKarchwe5n3RzvJHeygYqv8lDzL8IILUUkxKFDzSv
 MK+KX+45GwGKi7Yt3XLPHl4pYZzd34XjEaYnFu+52coLi6xbDoo2qNLmyKgoCyEVLGeu
 P5RZciK/c+IKqvuhb9C0KnUO9Ykh9Fo6jOHLtrnhc7qfHRK/z/QPjCpp3E8OXDQm1vGM
 d9c9bjfO2qlgEhVn1kkA3+Uh8wnkjWo46uhB0LS62kfr3bWmbsks0EhXIRdrYI4eH8wN
 lDasMU+f5YZt8tOBKsdJ4GQCyb13WINKcY3gSjezf3k2XuDvVtH9aVabgan7yBGLr4Fz
 Ccbg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788779708; x=1789384508; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
 b=JZNbB1xRArcg2xQpErQ1cVZj77pety96r9eOwzxd6L1zjEjdX7Ksf4VwtrW5Q9ZzKS
 tnbcRI2DkfWEzNhPS3eRVn6ebSELlWQJ8T3FpWCLtHeGdmnblezoY6XuzwtF0BxCbDrl
 IJS6F7Sn1VwGAT49L3J75qoShK9D1L3RG4DbG32OUuTjuqx1bmEHyTb2T4+ZshLJ0tEJ
 5Jyaw9AIwYnokCS+cYrt3xzOypa9kzE/TUAqYYlYPRQTcka2/dSVRfYwsX2VW1ECyHgl
 kNYQCxaSIuwclM+G73mypafJwz6piDUUIhuKyoBKLjMLLaUt69Qmoabe8bhu7y4yK16A
 kYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779708; x=1789384508;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vlJQsDKMlYIU6leKSgzhne93Y2lNrrKfMYXmCpI2T70=;
 b=i+zjU1A4f6Yw6QBYepOwO0FQEz9Qn+dlriUNFIT0SQfdId3tBiQkf5WWb6PA06OfYE
 DVBYLl0/cC4hupFMiIVkBVYwZd+YJ4Sso+RkWBvdoMeIvcvTLSmq4FvtHfUhF4yrlrsA
 9Mn2vXaiF2IZb852HZqgrgCHYzMs1tlf+CZYpmcimXPcnUseumLRcvNqJTp2e2az4K5e
 t5IS0O8/GSpjb13PO7ur5WjppqoiW0rK4Dn5VQgq1ICtD9+zuputSNoEqzgt4EAiTL/X
 ZMkoGyNMQ26bwYMvcKfnb1l2jyQ/Y3zYAAJJzCfGbuTVJhHEXNgiKNwP3+siBQif296u
 ZP7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQnyrfL8qjpv4gE28km1PgbNiGDfW4cFR3jJnbSMKsqTbbk1Ffoz3d3fvCjDV5ylUBkNmjR5kTedU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ktixF0hWnzCyO5x85PTAdeuXcpkdXO4ieFx0xP8MABMG6TjrIs
 go5HyDEHxEkpKrF91v5P5hxe4qSs4oJiJCHfxPCpdSDC9NnwoojO6MFuJERd/jG8D00OeIfI10Y
 4KgNAMpizFwc/MI1kX9LbYdUn8pgJTDk=
X-Gm-Gg: AYBFou2JWvhU9HI4wNuoGuxF5gMQuK9InTM/MIw8S5H3USaAU8AIJCADxG0v6OmVckI
 NtYRSvETyNGeVlt9mR6v5uOUAot3P4J1t0v8D5AEsOOZKS7Yfod5fZ85HA92BhJg9dxBhMkZ+d1
 rrPx7PoTDGqA2awvbG8isrpWP7a7yhCiKrZs6vzI6MUKbb0LJnqAH07Zvs2HMDmK2jyQ0NgGLof
 yjh508xiNvEK1xQEXX1BDC7s23xBkKTyZERLtLbb/mJ47GP/ppGFTKN4eJUohzEfp0hdk1Xv7rf
 0UkHdhy4gV6NVmbolo0xAf2GOrRoWuULvgE0pzU1kauDxhRq3kbyG1MkjRy/Ylw0ZZMZ8Z8gVqo
 XATnhltHTOUvEmh+QJqpR7SsRC+7DrEhEcK3qrGQJf5DxmmbbMu06e+S/m3hxQUSNy4lT1Yfq82
 pUhQcpv9++6dFVKKS4bmB9FJR7BO9wRWlxKhRBFFI1eEQ=
X-Received: by 2002:a05:690e:4403:b0:66f:c1bc:404f with SMTP id
 956f58d0204a3-670f4bbf268mr32396d50.48.1788779708527; Mon, 07 Sep 2026
 04:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260827093948.2825531-1-lilinmao@kylinos.cn>
 <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
In-Reply-To: <e4a2ba2e-c533-04d8-0795-e3d43caf47b9@gmail.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Mon, 7 Sep 2026 21:14:51 +1000
X-Gm-Features: AcwNN1V5COwUc4nP7hlmxy1WTzJmRl85tss2dbdH15pC0LiCKmy15_QroF5u0Bs
Message-ID: <CAN5rfbSh9ZoUkReAqv9rHYowqKcZFa-Svy6LP-MHvqfBVhjdBQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: Restrict SuperBlitter to supported formats
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Linmao Li <lilinmao@kylinos.cn>, deller@gmx.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

Hi Linmao, hi Michael,

On Sun, 6 Sept 2026 at 11:49, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Hi Linmao,
>
> thanks for your patch!
>
> Am 27.08.2026 um 21:39 schrieb Linmao Li:
> > The SuperBlitter operations derive an integer byte count per pixel.  The
> > accelerated fill path handles only one-, two- and four-byte pixels.
> > However, the operations are currently installed for every external
> > framebuffer in SuperVidel RAM, including planar 1/2/4/8-bpp and 24-bpp
> > truecolor modes accepted by the external video parser.
> >
> > For 1/2/4-bpp modes, the byte count becomes zero, so accelerated copies do
> > nothing and fills fall through to 32-bit stores.  Planar 8-bpp uses an
> > incompatible memory layout.  For 24-bpp modes, fills also use 32-bit stores
> > despite advancing addresses by three bytes per pixel.  These cases can
> > corrupt the framebuffer beyond the requested rectangle.
>
> I believe 24 bpp mode can be rescued using something like this (entirely
> untested):
>
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -2463,6 +2463,11 @@ static void svblit_fillrect(struct fb_info *info,
>          case 2:
>                  memset16((u16 *)line, pix, rect->width);
>                  break;
> +       case 3:
> +               memset(line, pix, ((rect->width * bytespp) % 4));
> +               line += ((rect->width * bytespp) % 4);
> +               memset32((u32 *)line, pix, (rect->width * bytespp) / 4);
> +               break;
>          default:
>                  memset32((u32 *)line, pix, rect->width);
>                  break;
>
> Can't test this on hardware, and would need Miro to confirm it works as
> intended.

Linmao's patch: I ran it on a Falcon with SuperVidel at
1920x1080x32bpp, all good.

Michael's 24bpp fill: I cannot test it because the SuperVidel has no
24bpp video mode. It was planned but never implemented. Its mode
register offers 1/2/4/8-bit bitplane, 8-bit chunky, 16-bit highcolor
and 32-bit truecolor (24-bit RGB plus an alpha byte), with the
remaining code reserved - and TOS offers no 24bpp mode to set.

Unless I overlooked something, the fill also looks wrong on paper: the
first line is filled with a repeated byte and then with repeated
32-bit words of the same value, which cannot reproduce a 3-byte pixel
pattern unless all three bytes are equal.

On the fbset question: no, the pixel format, depth and geometry of an
external framebuffer cannot be changed at runtime here. fbset -depth
16 and fbset -xres 1024 -yres 768 both return success and change
nothing, because ext_decode_var() only validates against the values
from the boot argument, ext_encode_var() re-derives every field from
the external_* globals and ext_set_par() is empty. Only a reboot with
a different atafb:external: argument changes the mode.

-- 
http://mikro.atari.org
