Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C2ECD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 15:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D83B10E4C9;
	Tue, 26 May 2026 15:02:06 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB51510E4C9
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 15:02:05 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-bdbcc6c4500so859175766b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807724; x=1780412524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MLTPgXz6PTE+WNmbiors/d1TQS2Sqmrm+U6hNBea8hs=;
 b=ioSekV5Sh91BwihYrL8LhSQGc+n6iX0xkTgG6Zn7YeLfbifNix6ymlxsvWNWhiDYn7
 rlr6n0yVdVoSrhyeoRnMzk88EyFAS180WnFLaUjxTB1TyI8KfN4K/ExWytZQnFDvXu3z
 BDD4e+p3uliMblA0ceWiS2b5rRFRrMYwY9nUoU/eDdvEZGOetYHKXEK9FiCS5A4CS2mT
 qx9vn3MLwGb2WWIS+0nRXHD4LO6V2ReGS/MGaYy0pSak9x9W8lKTZDV2/a/Im1DL7siF
 cTNKWzxi3OjQD/Es87DWP5j3Vr+8VXaPAjGowwY4/VFTvF6r9IsNo2HcVnz6+gx/ehiR
 xvkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qzYbeMcRVjJjsTqEQ04JZM+8K4qn/YfW2zvh5xnYHR91vu1MDwFIRJYNlgfcSRUU3R+GscKscYOA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu7HFLwEx4yw03pvoTCyulgWG5oKfnJ3o8xJ/uSHThrVVA223P
 6raZswrsXnbE3pGrbhDZoo4Pct71PRwZHPTEzQN2X9DcXdrIi2Lv3bB59cmedsGjoBA=
X-Gm-Gg: Acq92OE1QizNEofBC0I0iBJJptn9rQvirGWjYRLlsxQkRfzLr5XOwCM9sJWOAW3rupt
 ZAjQojVaVCs36I08eU3N+pKU81QGrkdUUw8FpA144vAWqgvGU4KAUTKatDJ6rBnCBxceIa4+YNp
 hyRL+NApX5C0JkeiFbPh6n4GyF5kvWre7CXiRNRBvTgscLgd0YmBIGCnjBuQdtojsfx+Fc7gvb1
 tZKInBJbFQ86gugwSS83YITjDlWWSfzwfzP90wBXplCNM7sxtTVyQKWbbRWyiyiHIraVG+mzYir
 DqlCVHzyLwOvgehfH5vHitFdFsvSdVZjWCFrekWW4L6ctGl3brqecbF3Dts/PGg/CpP7MHnfFrZ
 V8MLB9wbao38vAuvdvE7GyyNYOd8YpOQUu7CXaQzMVWaULYeDgKuayUSeIktpFkyGgCRs2hn7gh
 e2UT7/9UiIvLFqX5MhAGC6NFhgoQXWzVtineN4JkT8gw0uo3r1LClQDKiS79zm
X-Received: by 2002:a17:907:9289:b0:bd5:1482:930a with SMTP id
 a640c23a62f3a-bdd272d1c46mr1132603766b.39.1779807722870; 
 Tue, 26 May 2026 08:02:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com.
 [209.85.208.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc66dfb2esm504191066b.59.2026.05.26.08.02.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 08:02:02 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-68852a4fc68so6024545a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8qRIb5vTU24KpXKxxrCld8QPohFV90uatZ6F9hr+bmRRK3rQfq9/jiPcRDdqgma3Q9mpfcN5c6OQ4=@lists.freedesktop.org
X-Received: by 2002:a05:6402:360a:b0:674:40c3:f047 with SMTP id
 4fb4d7f45d1cf-6889ca4520cmr9385916a12.12.1779807721391; Tue, 26 May 2026
 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1779803053.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2026 17:01:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
X-Gm-Features: AVHnY4KG1TJnpMipnk7rqdd9LGhhF-uK_MvXjYFynbh1jLKZ-eyBikYr9yO02y4
Message-ID: <CAMuHMdUVoNg-rSV_hDcvi6KCosmE=SMcxUj2Y8fkoJ=33zMSXw@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] zorro: Improve handling of pointers in
 zorro_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@kernel.org>, Max Staudt <max@enpas.org>,
 Andi Shyti <andi.shyti@kernel.org>, 
 Helge Deller <deller@gmx.de>, linux-ide@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
 netdev@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
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

Hi Uwe,

On Tue, 26 May 2026 at 16:17, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
> this series is about improving the handling of pointers in struct
> zorro_device_id's driver_data.
>
> While it's ok on all current Linux platforms to store a pointer in an
> unsigned long variable, it involves casting that loses type information.
> This can be nicely seen in patch #7 where after profiting from patch #6
> the compiler notices a missing const.
>
> Preparing for that change, all zorro_device_ids are converted to use
> named initializers, which is also a nice cleanup that could stand for
> itself, as it improves readability for humans. (That is necessary
> because an anonymous union can be initialized by name, but not using a
> list initializer.)
>
> My motivation for this series is the CHERI hardware extension. With that
> pointers are bigger than longs and thus you cannot store pointers in
> zorro_device_id::driver_data. So this series is also about getting
> support for CHERI into the mainline, but I hope the clean up effects
> mentioned above are justification enough to accept this series.

Thanks for your series!

> The dependencies in this series are as follows:
>
>  - Patch #5 depends on #1, #2

s/5/6/?

>  - Patches #7 and #8 depend on patch #6.
>
> So if the ata maintainers agreed to merge their patch #1 via scsi, and
> Geert agrees to patch #5 and that it's also merged via scsi, patches #1,

s/5/6/?

> #2, #6 and #7 can go in without further coordination.
>
> Patches #3, #4 and #5 are only about using the same initialization style
> for all zorro_device_id and can go in without coordination.
>
> Best regards
> Uwe
>
> Uwe Kleine-K=C3=B6nig (The Capable Hub) (8):
>   ata: pata_budda: Use named initializer for zorro_device_id
>   scsi: Use named initializer for zorro_device_id
>   net: Use named initializer for zorro_device_id arrays
>   i2c: icy: Use named initializer for zorro_device_id arrays
>   video: fm2fb: Use named initializer for zorro_device_id array
>   zorro: Simplify storing pointers in device id struct
>   scsi: zorro7xx: Make use of struct zorro_device_id::driver_data_ptr
>   video: cirrusfb: Make use of struct zorro_device_id::driver_data_ptr

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
