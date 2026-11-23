Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2C60A261D
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA75A10E625;
	Mon, 23 Nov 2026 07:52:27 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00F0410E625
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:52:26 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-9906034086cso660644241.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 23:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795420345; x=1796025145;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gPjBrUC4IIvbAeHFoPzSJVURfLd/Eu+uv7trnU32st0=;
 b=HGZFBPDPNATW31ho75BRuie0APr7WypVlxJNT5KdhHZnjwxRODmrJLnnbALEPxRbz8
 l7M6ZoZhwiH1KSKQnP2UoENkjRVbIw6hQsKoUcTErQbyUz5/tQGcIf8CBaYIb+4SKjvX
 ZHFqP/ovHjB/f97TInaQr+PiM+QEbDAS4N/M7RtLHcLtPJ2flInWlyV9PxUNuEqPCu0e
 q3cVcYAIcx7RMbUzEE87LtCv4rYRUPQjfTQdgBeXDOAFVjfz/Lma9ftN33RUm0Yw7YQX
 sdMjjSeuHETUeeWxoBS520x5RVaEuFe8z7YaZNz+LfanBJ0tCEQmPq4mJUjMtQyiz6mi
 kjJw==
X-Forwarded-Encrypted: i=1;
 AL+hErGogHOxcJgWfOCA33JhTlYg3KuzwhBQRXwzGXftlIP+owHgJjMZUHl3E06hwtmxdVs8+k6KqNA3TZQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+vYnMGj3OQqvnc7mvWcr6owv8amg1hmnwptKIiR4+MBiw7rce
 q883RMOV8wF8xGm5eYCZtHAURlpTDe57E6snzL07KrnOeiR8BEBrLh8+uifvMh8/
X-Gm-Gg: AZFdTZeUSXr1EgrYV8O3RGkmwJPEo2QBUTwhNiABCoKHLwk0iMWtXOjaKqUrnfAfUNh
 7k0uuZ3We9YPLtW7fIROkFhrm6dg8AKnvYzoqR4IkfgKLDSSNqM2aM7OHLpYa6VfRf4D794YQDc
 TVnrA+//i4QvyA+qSZTqiphU4vZRRXQmmXnIPyyo8artnx+Fim+6dA7Mf9ORMi7hlw1vXLubyVd
 7mo0PDahOsyBaaunj/EhND0B1V92MMD3isunqguxJhxyaS3dcaf/QRPfcxVGUn8odRoY96KXdNP
 CzbR5SHt24U5epKOicUFn+uqFFecpQU6B4mYBeMK94LcZUsi6HvlRP2GLb3u6yLVqwyvdQCBrBR
 ehHmd5mZISQmPq34j0TFPIVRf0qkB+1MpVkP+K2F3+WeNh3kJeaFObm8dRF7yZ0fISJ2pjIvHE5
 wXIoCukkh0iX0NTam6eIvOAF/dvbmv9kHiUCh8DEPvx5LkR/KjBlhcTNCVxY8teKQJwjokPRDBT
 ESVXft2Xg8gzQ5lRtu1KxGf/R3SJSIqlFo2OUTGJnLWvkKhYsso0axidxUGOobdfzvlyphkEP5E
 K7TYHZa15XiWRkr8vXEI93QOQwXAAvPhJiYClHxbMFhqUELpsfh/f/ne/My3g4qqBi0=
X-Received: by 2002:a05:6102:dd1:b0:7d2:75bf:2fd6 with SMTP id
 ada2fe7eead31-7d739727b3amr3521594137.18.1795420345413; 
 Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99e6dec57ddsm10508851241.1.2026.11.22.23.52.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 23:52:25 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-7d2dbe5c4b0so1069075137.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 23:52:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF1i4FQmHYruuy0zdVPUl16ZBzijKEv21WIociYWRtA1um+VZxcyQy8FLjMwG81R5jPYIIVstbQnyc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:c4b:b0:7cc:174b:f7bc with SMTP id
 ada2fe7eead31-7d7397267a8mr4285980137.15.1795420344893; Sun, 22 Nov 2026
 23:52:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120175413.176249-1-deller@gmx.de>
In-Reply-To: <20261120175413.176249-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Nov 2026 08:52:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
X-Gm-Features: Aa3M54qOyxN021oFFusiAroXY34uRuwIJkT2Rviou6jBcd7wAahwXo5xPECEOBY
Message-ID: <CAMuHMdWyrdpVKvs=8Q+B-Syo1ZdAJvfJXFv0qiNtR9z4VnwnBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fbdev: radeonfb: reject a zero pixclock in
 radeonfb_check_var()
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jianqiang Zou <jq.zou@outlook.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Helge, Jianqiang,

On Fri, 20 Nov 2026 at 18:54, Helge Deller <deller@gmx.de> wrote:
> From: Jianqiang Zou <jq.zou@outlook.com>
>
> radeonfb_set_par() derives the dot clock from the user supplied
> struct fb_var_screeninfo:
>
>         dotClock = 1000000000 / pixClock;
>
> where pixClock is copied from mode->pixclock.  A zero pixclock
> bypasses the existing validation and makes the kernel divide by zero
> in radeonfb_set_par().
>
> The driver does have a check for this: fb_validate_mode() returns
> -EINVAL when pixclock is 0, but radeon_match_mode() only calls it when
> the output has no scaler and an EDID-derived mode database is
> available:
>
>         if (has_rmx == 0 && rinfo->mon1_modedb)
>                 if (fb_validate_mode(...))
>                         return -EINVAL;
>
> mon1_modedb is only filled in when an EDID is read, so when no
> EDID-derived mode database is available the validation is skipped and
> the invalid mode reaches radeonfb_set_par().
>
> Reject a zero pixclock in radeonfb_check_var() before matching the
> mode.  fb_set_var() calls it on the FBIOPUT_VSCREENINFO path before
> ->fb_set_par(), so the invalid value is rejected before the mode is
> applied.  This is the same check other fbdev drivers use (i740fb,
> arkfb, s3fb).
>
> Reproduced on Linux 7.3.0 using a custom QEMU PCI stub device with
> vendor/device ID 1002:5955; no physical Radeon hardware was used.  A
> single FBIOPUT_VSCREENINFO with pixclock = 0 is enough to trigger the
> divide error.
>
> Signed-off-by: Jianqiang Zou <jq.zou@outlook.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch, which is now commit b3f1631d362539cf ("fbdev:
radeonfb: reject a zero pixclock in radeonfb_check_var()") in v7.4-rc4.


> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -836,6 +836,9 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
>          int nom, den;
>         unsigned int pitch;
>
> +       if (!var->pixclock)
> +               return -EINVAL;
> +

This violates fbdev API rounding rules:
  1. If a value doesn't fit, it must be rounded up by the driver,
  2. If a value is too large, -EINVAL must be returned.

>         if (radeon_match_mode(rinfo, &v, var))
>                 return -EINVAL;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
