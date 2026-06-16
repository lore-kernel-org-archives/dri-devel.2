Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D69CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E421210E96E;
	Tue, 16 Jun 2026 09:16:21 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF72A10E96E
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 09:16:20 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-59be89d310aso3303583e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781601380; x=1782206180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6QcGlPDQFiHbxd4De/gInfn9HKdUcPfKNWsAjhcdk8=;
 b=cU0c6KRL0xJgrkzZY93qt1v7kpWnNphkNnkLgkUcthxVW01nUejg5WUwlZJbjlRLRB
 PgQXY5Xs0VaC2FzaW7sJaV0mTeytFNMYya4XX952xx5EJlyWp36FtZLzYyds6zQ/k0Vq
 ts4w9EDh/f5w28ujnNyo6GsjeRhEd6CpX1JyW4RAiGG7lTApC7qjgRz449VMe77UV+Dn
 tmy5WhWcXQyBF9nZfFylzFjgrgc/l0Szj/hYiuCQvBZooSuIrkosfsyiBlijUWuU3vZe
 m4jQK3iDoXQsUIkuDhBS0pWmGaZ3hjeGCefP3dG4jN2H+o0O989+EMjC4Th0BaoDO/2h
 PNBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bNdr0ruoKEt2KfBXzE8Pflm/Uj+aWzpLCJkxbWXesZIHLQQdDnnz6zl53AJmK7uPno02TviQJVqg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxifF6yBSZzDUSdlEwmfeWNEZRQ4Y2SRSUgemqWJ4WIdaH618yR
 wp/QCT6dw71t4msvik/u7wfbRKqXVBX1S7GblC07rtso3y/1aWk2S41nDpprzVtT
X-Gm-Gg: Acq92OGqrcZLrf5taeStkk+WgOnoYV4aghBiNfdJC+JiKVTVHT/jyk/Ljk20caJywBu
 vZTWAQ3Mxn6G5zzHqEUvKY+N4BBcrsxQtw7fGXfEF4MZlRvRs8DYY7LlTLkUS9Se+hMITgOLQC/
 RSWW8rmxHawYQtHLbUlE7n80jVptBfxrrIYC+dQZtsaeLLVxm86FrEMvGfamk15nj3saEoDscbI
 BfwVuBBa1kybacwrJGUmKHpJ6QvtZSFnmorpq5kxr/uDW/QMDQBuPEHnWIPprYsS/7ByBFQjfkB
 4J5ZBooJ4UlP6nxNuMUskiKBSa+g1U8w7h0VVEAhNN4wwaaWdOtmylkTLz5oXbTZmxk1OUPP28C
 cnenJO7REarmVrVTQUCLvs3WDmkF+8YZxtc11tqS2KpHT7RVPXF+QjNUrT9LMEkkO0RvK7/5+9J
 5dguiBeKnhmj9tQ273nRsLtPBTsfO0Q0z/VkCkRSdKYX4CJ8l0H1Uko5Jj2/E7JWrnEE408da/2
 mI=
X-Received: by 2002:a05:6122:2785:b0:575:9f5:ac57 with SMTP id
 71dfb90a1353d-5bbad920c51mr981026e0c.4.1781601379651; 
 Tue, 16 Jun 2026 02:16:19 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com.
 [209.85.221.169]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5bb8ff94a24sm5384005e0c.2.2026.06.16.02.16.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 02:16:19 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-59be89d310aso3303574e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 02:16:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/9s1lps4hl/v9s4IwTrf2CryGZEnr8Q2t1m6+Zxw8feosu5+VXwRYiAqBo7DWZD//nY/5xnI1b8rk=@lists.freedesktop.org
X-Received: by 2002:a05:6122:2390:b0:59a:7b23:16f5 with SMTP id
 71dfb90a1353d-5bbad8b1798mr1101874e0c.1.1781601379326; Tue, 16 Jun 2026
 02:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <aiq-GWegHjzdYJ2S@sirena.co.uk>
In-Reply-To: <aiq-GWegHjzdYJ2S@sirena.co.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jun 2026 11:16:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxP4obaZ=U6fudN3q_sFaAAYFuoq-L-dZ1GYgszw_ezg@mail.gmail.com>
X-Gm-Features: AVVi8CcR6hXTmkeMKxaguE45TU4JWmRqgQ7Cb_Qg-Nr7jquYVQsTuunb8azs3Jk
Message-ID: <CAMuHMdWxP4obaZ=U6fudN3q_sFaAAYFuoq-L-dZ1GYgszw_ezg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
To: Mark Brown <broonie@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>, 
 Jani Nikula <jani.nikula@intel.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>, 
 Melissa Wen <melissa.srw@gmail.com>, Melissa Wen <mwen@igalia.com>
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

Hi Mark,

On Thu, 11 Jun 2026 at 15:59, Mark Brown <broonie@kernel.org> wrote:
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/drm_atomic.c
>   include/drm/drm_colorop.h
>
> between commit:
>
>   94ff735296d371 ("drm/colorop: make lut(1/3)d_interpolation props correctly behave as mutable")
>
> from the drm-misc-fixes tree and commits:
>
>   5164f7e7ff8ec7 ("drm: Rename struct drm_atomic_state to drm_atomic_commit")
>   0c44d8dc6df988 ("drm/atomic: prefer drm_printf_indent() over inline \t")
>
> from the drm tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

You forgot to include the fix, but I can confirm the fix in linux-next
LGTM.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
