Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618F2606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEA4710E262;
	Fri, 20 Nov 2026 07:49:19 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDE510E262
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:49:18 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5ea969fafeeso184344e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160957; x=1795765757;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xKnU/TldM314xEN7UqLDGvv/eDTZSOGz68aX0N6/qi4=;
 b=gbyv1RLlCCAv/FEKyeQR2iggR0q06aDG57Sp5RPRNN4TpO5PpVdIx2wpy3iBgI/g4l
 EYSyTbggaGrGXmbcLlWqUnHSgEKS9K10ULYeL3BWQr/9F6wnZVsdYejs0ZUe2J19KJSg
 CgjibkB5rey56pBT74r6KvmuYl6ANhw3+iu08VelxZv0IEFlKtHnJLY6swr37hVTh36l
 tjyznHVHyqiUix6yL7fljIpuvTzpUiLVRWfILfZHs65JaclRkTplrUwouJqGQGESJEsz
 eo7mocSJQ3+l8si4MgrCBlf/gq0Zk6jVzQzG0VUibUPeNBISQak+Xrq07qTEKkaNKBD4
 7gjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE9wCQvZv7ZOQOpgfHKkrPYwgBJNFyeLhrYm7llOY4SqgAbIbexq77J+KM98d55K+xiZYiE+9sitLs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z96KD9dq6TjkyqzGa2BCcYrxC5O65PeX9bd7bLziA/38yiz3hgB
 FrRkujeMrmUYJd9IE4JkYDfWM4jGnP/N/oTxZjPPExWBvsb0JELYv0OBq0mgKqsA
X-Gm-Gg: AZFdTZfOXJJ9ZQRhGSFqQbRrpndDn5Bi3vPoNBSjI0TfJGP3SgO4JlplhKMgedCv8tX
 6wNBPPHJ4TzVI3NPDdNSNFxfhqHE/5lDGdjjeKSvlzmLGduY5KOCUCjFucGQMBUiPcK0dcFpIp+
 lDGi21K70nEhF+rab/7DExLzIXh/a14CdHOKNFRRLJXChxsGdXYPjwYRBTwrW2ckuBRu7c1A7lY
 jX19n8GeJ88PO8WbNYDoZ9rJ0zvu0Vwu2q1debB6EXvHbMgYePc+ZF1gFxcwCTjeIpZ1rSOG3gp
 N5XSNeW8qEw3QjUqA7UUFJdDfW4Yjyg2eOOyFFSNt42CLSgoKsS9fzt4cGlBJ4UAPY2na2XrOnq
 M7BymyX1NBLnb/ISSILIa9CC9buV9fpXAz5NsqlkD3hte5N1pubU8ehAG0O2dLP0i9/s5OB6XZS
 kZLo9xs+Rr4S0J1DAxTcYcigyW3oQipBbjIiQ+D6p8HYevlgAgx0qzjQ505+hpOgKYPYzTTkGcO
 dJMf1BcXJ5XR7JMGqNWPvVdNV1HmD/fFuiC/g1LXZu8pYg+eRwPNC+8mqHpdJ20k3IpUjqjnnHc
 Fl8yXyG5fUljK6nqZDgR0evr05K3TffJGGCpaZHPi0GayI6iefhSnjw8To6IQWc2y3M=
X-Received: by 2002:a05:6123:a8:b0:5ec:3e18:a912 with SMTP id
 71dfb90a1353d-5ee8af230a5mr944550e0c.14.1795160957177; 
 Thu, 19 Nov 2026 23:49:17 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ee8b5a91bdsm1867233e0c.9.2026.11.19.23.49.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 23:49:16 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-77bf892b496so213251137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGi+oNhgrT/CipPRjn7bdoJQR+mU9pi1dSjy/EdoCc4bGX/iDfxQOBv0N5PfWVfVuW+uhbx/sy1YzY=@lists.freedesktop.org
X-Received: by 2002:a05:6102:6c4:b0:7b3:8f0a:f76c with SMTP id
 ada2fe7eead31-7d7393caab1mr683612137.13.1795160956421; Thu, 19 Nov 2026
 23:49:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1795094688.git.geert+renesas@glider.be>
 <683b5b189409e5ee04100044fb615b01cb877f3d.1795094688.git.geert+renesas@glider.be>
 <20261119225017.15a7b5cc@kemnade.info>
In-Reply-To: <20261119225017.15a7b5cc@kemnade.info>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 08:49:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
X-Gm-Features: Aa3M54rfGlA3UrmhLbFF7B0m1MfxoFvw1pyboKcP24dUngkkG_fWLkpDdrOnbn8
Message-ID: <CAMuHMdVbgGV_6yjOip4xT3YhBgaOveHzSRbw9e_cHen9NRZqmw@mail.gmail.com>
Subject: Re: [PATCH 5/6] [RFT] ARM: OMAP2+: Convert to
 dev_clk_get_from_provider()
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Paul Walmsley <paul@pwsan.com>,
 Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-clk@vger.kernel.org, 
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

On Thu, 19 Nov 2026 at 22:50, Andreas Kemnade <andreas@kemnade.info> wrote:
> On Thu, 19 Nov 2026 14:40:38 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > OMAP2+ clock handling uses of_clk_get_from_provider() to obtain clocks
> > used for power management, so the latter show up as "deviceless" in the
> > consumer column of the clk_summary file in debugfs.
> >
> > Fix this by using dev_clk_get_from_provider() instead, letting us pass
> > the consumer device, too.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Compile-tested only.
> >
> > The first change is probably OK.  The second change may fail if anything
> > in the oh->od->pdev->dev chain is not available yet at this point.
>
> Test on OMAP3:

Thanks for testing!

> --- clk-old     2026-11-19 22:44:59.810807920 +0100
> +++ clk-new     2026-11-19 22:26:52.862531880 +0100
> @@ -1,17 +1,17 @@
>                                   enable  prepare  protect                                duty  hardware                            connection
>     clock                          count    count    count        rate   accuracy phase  cycle    enable   consumer                         id
>  ---------------------------------------------------------------------------------------------------------------------------------------------
> - oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + oscillator                          0       0        0        26000000    0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> - secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + secure_32k_fck                      0       1        0        32768       0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
> -    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      of_clk_get_from_provider
> +    wdt1_fck                         0       0        0        32768       0          0     50000      Y      deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
>      gpt12_fck                        0       1        0        32768       0          0     50000      Y      48304000.timer                  fck
>                                                                                                                48304000.target-module          fck
> -                                                                                                              deviceless                      of_clk_get_from_provider
> +                                                                                                              deviceless                      dev_clk_get_from_provider
>                                                                                                                deviceless                      no_connection_id
> - dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      of_clk_get_from_provider
> + dummy_ck                            0       0        0        0           0          0     50000      Y   deviceless                      dev_clk_get_from_provider
>                                                                                                             deviceless                      no_connection_id
>   mcbsp_clks                          0       5        0        0           0          0     50000      Y   deviceless                      mcbsp_clks
>                                                                                                             deviceless                      mcbsp_clks

Hmm, so the passed device is always NULL, and thus there is no point
in making the change.
Do you know if these come from the first or second change in my patch
(I guess the second)?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
