Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E190CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C4A010E7CE;
	Wed, 27 May 2026 13:19:28 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEFB10E7CE
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 13:19:27 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-577500ac0e4so3710506e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887967; x=1780492767;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xf1qQW/A1NhAIluH/eTEZ9k/rUaYP7h9UU5do+wCVRw=;
 b=fyQHbDfjyKySjiHW9NAAprg50lI1U+BlqtgS32Od0MW75Iza9ANMJoWqRB5yp8fM/q
 8v2yrAYr3n02ZZXys4IWSTaWRcTGMFQBz6zHzYI85GRj94LLmtsKqDC813yl6pGKFMkW
 TAwywi4Ng5vW1Zu4OSGuRpMtWQIpAAl+WN9NQmMK24TuUDCeiC6kBcG2KfaUOYvephH0
 bPRPZ18U28gtyrhwz4wrTuu1vCYsalIsylZuF5hmDcoGYsyqb++1bjWaT8zGKxpXUZlO
 9hqIW/zjTMgKLBu519ramyfcaj0GageQQEiOPJyOfvyCerglLvyCRERAKBnFsJMYxhRC
 /2zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EmaAUUg/+1Jn0ouHmTlSnIPNwniTNVCoXrhDFkFCnhOIBYV3P7nmerNvn9XkCcG6qaL/FlcHv0JI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9gynq5PdObwT3eKkLtbXQXoQmUjAP+3uN1HsNYwz7FKJPOE6f
 rAcUubUsC/B6jPupMFIKqljMS/fYjawUKh12VXJoP1UYjzrPxlSeWIpXZu+5mw+Pitg=
X-Gm-Gg: Acq92OGDAWzW2ED3bpNAc2Ucj3yhvuo0FJRnaNlgzEmC3ELSVxhtHNwws90ADFYZBXY
 SLtsJGqLr4s03LUEgOOOUJDixU+ZndmDA8oz8zqfTyELQO1kmDCqk864iK7VWSzOwSj3SxRSZti
 jTPQqjZvVvs2MtAU5fITe79G5irFsYyXmeos1QKiXUm+AK+HjO6c3x111ACdVHh9R6gg7spgW4U
 B9dSqoMXqgatLr1PuVmeizZglZpeJbxdVKPoojKtpR1ZokRqXVm3ynBuJBf7dkxvQvfSj/cfLQW
 bheg1+ZhoQ2scd1EhgSL4BgN+yQC4kjNaf0uSi5p7eSOdAUE1bjgwkL/NRE3RojmatyhPSslufD
 No6pLcoAdlxG8L46a2Ybp+95SDlbzXWwY3ZYES8uaK5cNxXM53++k5e/scjrqAPnaMRaEtkjru1
 3i8IM42UKSQ6C7b0BLXOXYFsMzP1zV+4T1c0U7h9/wVVtAJS6T4wBmm0NESlPb4DMl
X-Received: by 2002:a05:6122:168b:b0:575:29ef:7e13 with SMTP id
 71dfb90a1353d-5865d70e96dmr10434893e0c.3.1779887966650; 
 Wed, 27 May 2026 06:19:26 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com.
 [209.85.221.173]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-58d6412d8cbsm11952270e0c.4.2026.05.27.06.19.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:19:25 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-5751e12c524so4072318e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 06:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+ATVhrZn9hz5C3ZBvc2qf6TSUb48j4C2q6ilOMtqMejSPor04d/mYK+6ct9VLT1oDb+lqC8v5kbHc=@lists.freedesktop.org
X-Received: by 2002:a05:6122:f07:b0:575:38d3:7c8a with SMTP id
 71dfb90a1353d-5865d70cb74mr13246575e0c.2.1779887965533; Wed, 27 May 2026
 06:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
 <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <72b515651ab8df2f464deb620fd7b24370d6fb1a.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 15:19:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCzFTmVh_5PSEW-ypoq6-aARO9E3OhK7SJiW7mM-DA3A@mail.gmail.com>
X-Gm-Features: AVHnY4LOsqJJ79rG73uUyFxUiXTE8CyABHxaadTKIcLNCLm8pGmOMdJ12-1AfsE
Message-ID: <CAMuHMdUCzFTmVh_5PSEW-ypoq6-aARO9E3OhK7SJiW7mM-DA3A@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] video: cirrusfb: Make use of struct
 zorro_device_id::driver_data_ptr
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, 
 "Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>
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

On Tue, 26 May 2026 at 16:18, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> Usage of .driver_data_ptr allows to drop several casts and so make the
> driver a bit more type safe.
>
> While touching the zorro_device_id array, drop an unneeded explicit zero
> in the list terminator.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
