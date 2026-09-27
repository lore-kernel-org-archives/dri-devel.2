Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9573FC9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 13:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AA710E29C;
	Sun, 27 Sep 2026 13:37:09 +0000 (UTC)
Received: from mail-vs2-f13.google.com (mail-vs2-f13.google.com
 [74.125.227.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BB710E29C
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 13:37:08 +0000 (UTC)
Received: by mail-vs2-f13.google.com with SMTP id
 ada2fe7eead31-795a0ab5227so724906137.1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 06:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790516228; x=1791121028;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EvrrFDOEfw30xeCEywR2DrXxtTlrcUlKoMxF2l4mFYQ=;
 b=QFCAg0RchHou1I8mVZTR0cDFpYgqZgWtt0CPAmJAeGEda7BM94/bYW6bYKWZamW6B1
 /Zdbld60AjDqPZ5cg2KdzlINIhvIEaujFRtrCt3OnXhXlP+RUWowrtbv0edfKSY2kqya
 VXGcDMhVauBZ7ryHKHUVB3Oe6VWyRKREfJyNZfO1RoLmp5JZX88a8TF3nRuxLN8cWdUe
 rBOG8SOqPOsRVk1C2n34E23IzhAon9GHTN6AcqGt+FAPNrVzJ+b2WWkmRnPcwkF9OS1O
 4T8g/5eFwjVquOqQjKrj53G4ZVdO1nsrUDGRbaJt7Mau5OuE9e+2okcgxSRC/Uevjd5n
 tVmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNAy6YHcijvJZCwhrCIRASsrwKAbr7GGMPf4oZS8CMA9cUFk8pIr6a1drNZStPJXppwQQaKds2u0w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJV28kDColY42lcFgl3hSFtDTO+N3ERIlRVv65XxAdRD/r8qC/w
 bPdQpmonTkfMCRhyLzAToTHIxp4TRa0mO7gbeGZXxAclFSfVfzWKV8OoXfLkk/L3
X-Gm-Gg: AYBFou1ck/XNTe1jOnaXYSV2T017WjMG+pGTl4gbJIFgMq45Sf7htzOhbgV1Jsw+gC/
 J1vdF9lyrtJWugb9OvMbooMLzrQIB6aIZ3/IsHNjb4IRHO5iJlo68txs2wbVTG/6Sczyama+pCz
 ywCufZUZvLJwczsUp4dCtP3R/cXI6JjzWLq9xggGXbOFTvX84YL1/xV+lZRqyCNnzx4/BoIMjr2
 vOodxn+MXWmCWalvigvM44MvUPfKFm6RMYBBPRpkIi6OMpie4wrcLOuMekUx2eHN+da1UZ+52Jr
 tz4LSzmfmZ1vqckgilxQd6k/m+SafC0bw9cDfsZZqY/mx2bcITIZx9H584W1qMCsJRKE7FqymOz
 AFG4RJ1jdRVhLuDLuc+64Uo3OZDJLN7vrW7DSLJv7tF25wCmHM+e0Y00u1lrMrWXO2KDVVfY9Wb
 N+f3/Yl8ufAHpqfdzagzIO7sPdL2cCFW3CcNw7fGO5hiYH/Y5KBecq/d3t06xfvr5y5HCVOh6x4
 2h9lFPKTQgHqYiRM7KZGsTxOLE4yInfUHDJ
X-Received: by 2002:a05:6102:549e:b0:7a7:19aa:f0cf with SMTP id
 ada2fe7eead31-7af1eff6bccmr3628664137.28.1790516227604; 
 Sun, 27 Sep 2026 06:37:07 -0700 (PDT)
Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com.
 [74.125.227.43]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5cde615a356sm5221652e0c.14.2026.09.27.06.37.06
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 06:37:06 -0700 (PDT)
Received: by mail-vs2-f43.google.com with SMTP id
 71dfb90a1353d-5ce4d8751cbso311886e0c.0
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 06:37:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwqL1zDC4z877f9pJ+09Lq+AV5A3kFG75HW6zumSeF636SGWp5zPmn0FuZqA0BqrcvGqSb/q8Rfdgc=@lists.freedesktop.org
X-Received: by 2002:a05:6102:41a1:b0:7a7:19aa:f0d0 with SMTP id
 ada2fe7eead31-7af1eff6b23mr3197807137.29.1790516225994; Sun, 27 Sep 2026
 06:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260926062136.162108-1-deller@gmx.de>
In-Reply-To: <20260926062136.162108-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 27 Sep 2026 15:36:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVB0PCGQnbNRVDT6D2dDNM6034GnkNk1FS-vZfwzRdVZA@mail.gmail.com>
X-Gm-Features: AclHuK9ucjDUGnCQyC4VU3A8-llcICjZdwnLW26_tqxRQfUZez9PgO5NLvXPejM
Message-ID: <CAMuHMdVB0PCGQnbNRVDT6D2dDNM6034GnkNk1FS-vZfwzRdVZA@mail.gmail.com>
Subject: Re: [PATCH] fbdev: atafb: fix sparse warnings
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>, Miro Kropacek <miro.kropacek@gmail.com>
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

On Sat, 26 Sept 2026 at 08:23, Helge Deller <deller@gmx.de> wrote:
> Fix two sparse warnings:
> - atafb.c:1092: sparse: Using plain integer as NULL pointer
>
> Use NULL instead of 0 when assigning a pointer.
>
> - atafb.c:2824: sparse: switch with no cases
>
> FBCMD_GET_CURRENTPAR and and FBCMD_SET_CURRENTPAR seem to be
> historic defines, which are not any longer in the kernel, and
> as such the code isn't built any longer and may be dropped.
>
> Fixes: d463633d63e6 ("fbdev: atafb: Add support for SuperVidel's SuperBlitter")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609261313.kgFtkz2t-lkp@intel.com/
> Cc: Miro Kropacek <miro.kropacek@gmail.com>
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
