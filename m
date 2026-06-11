Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE25CD98C7
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 08:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F80610ED47;
	Thu, 11 Jun 2026 08:10:47 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F8C10ED47
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 08:10:45 +0000 (UTC)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-963b248ef0fso3535818241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781165444; x=1781770244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIoi3XPcNIb2wKg/vVIZMhNixDSLEl80pAhTezj3BuE=;
 b=S+wLORHPprhMiCIDH2dyd8a2UaslbAhGDnNp3wWbx+HbpartZSVUwBrVRnCYaJPvln
 eiGckBVoqYiLO6j1B4nTCE/Zgl1qlQrR/Bpye788Z9pxGqoGHr6FW0XNAKyjiB0MOSQ+
 nTglz11dC9efaZquG47/GYqQClIQRSQMfkzjf7x3LCjX/XRV4RvghJjBcPqmgLFvWGNh
 GcRjDaofYp3X3MKGBUljHqIl2HmGW+LZQQahY47tG0DMoJWAOUB240yhRIsu0GonMWmt
 gd2fLK6MV6yiOcraU5ebbeDlQ6f62Nwxrw6/OtfjGaWZCKLSASkJstTeNLOpiBGvDfPF
 1o0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8gJWCa7Vacg2ykppVwQrd12uL2oNHFPY85pGf/9JaHR83LF3yNoAv82kM+a+QO7yo+I5OsZetja8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHmhg4MYuDzDp8Ir11yxYiBehBvYYh1Jplk7DVfltJ8prTqkgP
 uXi8nShyqxxyglyuL7EV/2ct+PpmF4wDV/HPxa8SfP9em/RtAXONas57wZH0zsQ4EBs=
X-Gm-Gg: Acq92OEbRkjqyubL9l4eEqhOxOPwjVKpj8qfDwFmSsyhKhq6NlA+qnNEvILxtNMND2L
 Seylp4uv2hcsVffb3C8pvh1tIdxhaPqxc0Ck6jOxAhavWylg51z22opm7MO7pGsUDwS2BvQVcBf
 6AlS/W/EyuARJ8t4hB9rsOA9HDrQqDTpFpPztzWqOncgGBuBYmnBdbh+Sc5YEjnwOluYiyFLG+F
 o+Za377ILJDwrhPmmcwywNeW+d83MZjvPZ+UuxvytFsMFmIOhIY4IXRlC03+GufIEpytn5YVCcg
 uWbmdAH5b9mhk12GNLzJaxKGus7ely6is3CzuF3Rlg250u7ppj8abjNspR1e4l9TMY4QDgCAB2H
 YcCtNz8ze+KJTrQCKjHf/wr806LFrAT9mP+KoqsZRedd47ctMW94mTl9/SlQXEbty04xqoDuAU6
 Ltr15DYPpW3eijUDTf+DJPJbyQJIHxvD49invt/EfRSy55gsKVF2d+Pz3nb2i34OWPFKDzqMw=
X-Received: by 2002:a05:6102:4496:b0:6d9:a879:8e39 with SMTP id
 ada2fe7eead31-71d5c473f23mr542222137.14.1781165444309; 
 Thu, 11 Jun 2026 01:10:44 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-71d926849ddsm477901137.7.2026.06.11.01.10.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 01:10:44 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-6ca94e539f9so4501221137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 01:10:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9qDUyqO1GboF+QnS91CKL/8Zji5+MvqL3Fq/r3VFw3bV4pySKVrMH/U7prSiafoipilV8QvUWpL9U=@lists.freedesktop.org
X-Received: by 2002:a05:6102:a50:b0:631:26f6:7021 with SMTP id
 ada2fe7eead31-71d5d08c7e6mr549819137.26.1781165443791; Thu, 11 Jun 2026
 01:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260610025014.5913-1-islituo@gmail.com>
In-Reply-To: <20260610025014.5913-1-islituo@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Jun 2026 10:10:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
X-Gm-Features: AVVi8CdVNKXrG0x1HHGz_rLBLe8j66H4QINxyVuJFwMPwOBF3fyFXz7IkA4-6yQ
Message-ID: <CAMuHMdW_+WE2uUyqAEhSqT7F4pWseO6Gygbw3tCo7LpAJB2C4Q@mail.gmail.com>
Subject: Re: [PATCH v2] fbdev:modedb: fix a possible UAF in fb_find_mode()
To: Tuo Li <islituo@gmail.com>, deller@gmx.de
Cc: simona@ffwll.ch, tzimmermann@suse.de, kees@kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Hi Tuo, Helge,

On Wed, 10 Jun 2026 at 04:50, Tuo Li <islituo@gmail.com> wrote:
> If mode_option is NULL, it is assigned from mode_option_buf:
>
>   if (!mode_option) {
>     fb_get_options(NULL, &mode_option_buf);
>     mode_option = mode_option_buf;
>   }
>
> Later, name is assigned from mode_option:
>
>   const char *name = mode_option;
>
> However, mode_option_buf is freed before name is no longer used:
>
>   kfree(mode_option_buf);
>
> while name is still accessed by:
>
>   if ((name_matches(db[i], name, namelen) ||
>
> Since name aliases mode_option_buf, this may result in a
> use-after-free.
>
> Fix this by extending the lifetime of mode_option_buf until the end of the
> function and using scope-based resource management for cleanup.
>
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
> v2:
> * Use scope-based resource management instead of manual kfree() calls.
>   Thanks to Helge Deller for the helpful advice.

Thanks for your patch, which is now commit 85b6256469cebdac ("fbdev:
modedb: fix a possible UAF in fb_find_mode()") in fbdev/for-next, and has:

    Cc: stable@vger.kernel.org # v6.5+

I believe it needs:
Fixes: 089d924d03d5c17b ("fbdev: Read video= option with
fb_get_option() in modedb")

and that commit entered v6.4-rc1, i.e. not v6.5?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
