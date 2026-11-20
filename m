Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C4606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F59710E685;
	Fri, 20 Nov 2026 08:49:54 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048C410E685
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 08:49:52 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-7d2db6408cfso426324137.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 00:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795164592; x=1795769392;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=slnLzkdmpwFbnxdOJOf8j6Mw1PiHOu2DMR+OPWGMV3g=;
 b=MwbbxsNYT5aJOwnwaIDINUr1HE23zebGeNhEqyP6zJEgG3epEpUFUR1efqMuZDiwNI
 VZwXmZ3B+aSUahCDXmImtCjAEPf0h+XOF17ap/JuZEqTmIP6kmJhiKJ3E6jjVL0VKjSg
 2QImCPHDl0DUKcuzS5541vtkTHgItuUb0yeebhbVCSafj40FvyJnCb+nWsrIPfjcpjny
 1e6VcjJ6SJODBWeVFpOsyJY9ROv2XxH3yJ7Xl/C9/o4dZXMVG7jlyaLuFJfoUHXz7yeF
 LQzHSdVDK5Pmw3Ke47xgS4qVRBHmBDv5Rf0TG5IRDuoMcH6cxagjbHdlNFyiXbU0S+f6
 RrUw==
X-Forwarded-Encrypted: i=1;
 AL+hErGNniHZLlNNUDwGsWIRlOpQTjufDw6llst4an+cDBL4wcH1mDs1lp2w5AfFqov9J+rLPq0hKrUsX+8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/kdMf2lWkkJHMPAwj2WJ4USkldqbB+Kl0CDQjvqyYjBli23IeS
 OUkx4QypMag9Uv0yUD9H4+oEkH+RxRDWw30VvhXfOKBATyXI3+6ZgoPz1e/Ckcce
X-Gm-Gg: AZFdTZcZ/+wKO2dYMXFjxsyxuKWSEqRkYKi5Y2vo967mAkZHVnyTYcksLVLhXXO8PH7
 Vrv/ydglhqCWTiBd3sUw6wdNsKoqFrMA1XQstlIM67hBq1kwlaL2B5K4nT5oM7Vp7G7tNMGN+8D
 d6ujENZnfIZoHDcPym1zSei8YorSZDB3Vx4ws8QNmiCpaOOoCapiLfzsvDyt1io0sNr2B+pazRH
 3DUs1rMwxM2880ph8MleAl+BOMHaXoiaI5ns9waGv/u7QnM7Ssw4sgzzg/GEyokwiRNRZHKlxDO
 WX3S2Opw12SNO7MDV2PxOjX3bzQxEPn0LMQxbNXkqhJvTsRbCuCT9rXhhKBwvGfRkjwnzK2W2Cu
 aEuoeApSYQaVe+VKulP7l9VQtaJ5/yG8Nevce2Rskox4tWLrTULpC79oT6x4Az1f+qyflYT/voK
 4zL1QXAtG7zQDzMtU1o+8MOLE2mmo0jE365bmiD9jpTPoNexJ/A5ew6HWxwh/4T5kwQ5QE5Kqmn
 oaVRQ2aSzA3KurMnmw096OVK//d+XK6j4vreMziEK2uX2ndh/Fp1Vv/z/bhhshlK5fVEk+xTHFA
 ARH5rthJuAt1tqYAKHF/VMFMvtibDiffZByFyWJTZDVfhu18Rcx6Ba1xQsRJuh777hHJYNJeMvD
 fYYTontFacC9S
X-Received: by 2002:a05:6102:3f16:b0:7a8:15b9:dd34 with SMTP id
 ada2fe7eead31-7d72b3728efmr1072217137.2.1795164591694; 
 Fri, 20 Nov 2026 00:49:51 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com.
 [209.85.222.43]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d6e7d784b3sm2322694137.2.2026.11.20.00.49.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 00:49:51 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-99e1babd683so308817241.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 00:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF2eGB1W14UVTdN2Yz6EitBm/wcxLLhdNKYFSoSTGxplAARsDI2zDbmpp3kgUYz28fb2AhAVtOOIWI=@lists.freedesktop.org
X-Received: by 2002:a05:6102:a49:b0:7c3:7286:c291 with SMTP id
 ada2fe7eead31-7d739587805mr971622137.19.1795164590827; Fri, 20 Nov 2026
 00:49:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
 <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
 <20261120094320.442d064b@kemnade.info>
In-Reply-To: <20261120094320.442d064b@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 09:49:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
X-Gm-Features: Aa3M54pnWIgbseGoLAFGMXWb1P8DBLFzk6LU-uNSdaE_BgKhwLT8uPsc_3uFT5k
Message-ID: <CAMuHMdWiCODz6RC9Q9-xMM5_k3grHztiLuR+-ikOZYoBawVvZg@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: ettore.chimenti@linaro.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Paul Walmsley <paul@pwsan.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andyshrk@163.com>, 
 Ulf Hansson <ulfh@kernel.org>, linux-clk@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
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

Hi Andreas,

On Fri, 20 Nov 2026 at 09:44, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Fri, 20 Nov 2026 08:49:05 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> > > On Thu, 19 Nov 2026 14:40:38 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > > > used for power management, so the latter show up as "deviceless" in the
> > > > consumer column of the clk_summary file in debugfs.
> > > >
> > > > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > > > the consumer device, too.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Compile-tested only.
> > > >
> > > > The first change is probably OK.  The second change may fail if anything
> > > > in the oh->od->pdev->dev chain is not available yet at this point.
> > >
> > > Test on OMAP3:
> >
> > Thanks for testing!
> >
> > > --- clk-old     2026-11-19 22:44:59.810807920 +0100
> > > +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> > > @@ -1,17 +1,17 @@
> > >                                   enable  prepare  protect                                duty  hardware                            connection
> > >     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
> > >  ---------------------------------------------------------------------------------------------------------------------------------------------
> > > - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> > > + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
> > >                                                                                                             deviceless                      no_connection_id

                                deviceless
mcbsp_clks
> >
> > Hmm, so the passed device is always NULL, and thus there is no point
> > in making the change.
> > Do you know if these come from the first or second change in my patch
> > (I guess the second)?
> >
> From the first change, The second piece is nowadys only used by the dm81*
> devices.

Interesting.  So that means all/some of the existing use of
&od->pdev->dev in _add_clkdev() is futile, as it may be NULL?

> I would prefer to have this tested on dm81* too.

Agreed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
