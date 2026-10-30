Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA737606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 23:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=E6+/+P4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2876E10E284;
	Fri, 30 Oct 2026 23:37:27 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F393810E284
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 23:37:20 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c423b145922so162916366b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793403439; x=1794008239;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F6RKSKoXJzKlNaMzDigqrXvD7n1HyX5zOJi75UDgxuY=;
 b=E6+/+P4bv8MIlw5+yvAiNZ4xCQBcuMZnEtDZ5aTytIJ0jzzj2FCs6vK1xttsNReKUj
 WFIxshnEe1Kh3Sc1hmjibc3+kNMU3RPzRJh6M+iWe41eDeGXkQFVs40zYzyfF9Z64vYD
 pbAz/ZY5aL3WtBk1vHDsG1Xmnf9kPDeD6vUcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793403439; x=1794008239;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F6RKSKoXJzKlNaMzDigqrXvD7n1HyX5zOJi75UDgxuY=;
 b=RURkhKUpt7FrE8YAG3CTE+Jh2Ko1lhW0X1L34fwWt1lb/TrYJ29XsqdxxXkd5czx4R
 p1ht6H0khBCLHhjgye3jK5C0fqYE2uVpe62a8AOchB015KH6xf72AiCBEAL1i4UXjWYo
 DPOVkWjsbJOBDxEskTmCgCBCuaJKF4REj09flyI6SGqFV5j3i9V4mzW/vaPa6BmkNtVb
 5NV11Umj+IdNEJhN6wxSEqBnl//qTIGybI7awmR+COwhKbm/VIfap7LZzVRDKllA+ymg
 egoc5dApWYHFOT6jh1n5SksNr7T7I9xRbMi7uhZWRC7xgjYmCSP82J+w/N3hk5icOg08
 uH2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBydyR8HufEIWoS1LZmEv25uFm7fKjZq2b8KjeF2RNk5zHiqivWZ4+m0LmlbS3JTFumDrpuaUQmTaLc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLPH2s1pJ3iZea1Tqf/v+0InufiWILrGIg/au3HfQ/ZmiW6uTxx
 AuGaPX5IMgeAKKpnA4gtlpDeuHUH0AANto9xaXwTnUV4OgWzZg1331Q9pt+gd3ukSXK6RAzvzJS
 K2F6a6A==
X-Gm-Gg: AYBFou0kxHEg512narP5Cz8wRQl7GzV7xQTRnO7GDmpo0gp7RVFzRN/rWe3RbQB7X10
 G+yc/bJ8j/3x3GoFFJMqYUAKm6j2U6XvLm/06TvYwJKJOY/wu+cNCFAnM0HXUPC53ZUAahWzeGR
 FIi2VNXmEuLB8AT/7zKGCIYdN67/OE6tGM/z/+erEr50UQX5vlxdy2ncIivWNAB3eKyfWULPjQ7
 OHeH9LdOlUS2BuG8XuwYADgpUhs7UyzOQVnrjyrXyoW7UZSJh3YF9fQ7mDg9bJJC85qDPUgJ17b
 HeiiPJBm2PmgOVrvds85oev3LboGrJiysN6n1iWeLpRX+ozIj4I3DWlLsXiIafG7AiTQ6aat10O
 8yQ2yQJbghzTuMZWZZupt7g0rlHTS42qDkwcYC5AZooDz6dMhGzqed3sjtCZ8QV9Q9ajgQhopF7
 N8dF4xZ67pA3U5/EXDGY0tGAeXNCgOoit1kXq9uqxmD0eVJFRhy2b8W5okKxSbUzIxk0X5GC2Za
 5SPeyOTs8X9RzFAsW91YTP7EAvAoY8g0HXaO4P8ah08lEF5i6J0XEdp//Tyh0Nc7xrq2CvsQxF/
 kkcNx6R090vs68NNgDQdCwvwQaZtdtzsX70h1Z/+XVrh3MNQaXHkmcnHJ4X25GDCAUpS
X-Received: by 2002:a17:906:99ca:b0:c31:c767:adfb with SMTP id
 a640c23a62f3a-c4ca7432ef7mr332433666b.0.1793403439282; 
 Fri, 30 Oct 2026 16:37:19 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4cabc18e78sm122479866b.9.2026.10.30.16.37.17
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 16:37:18 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso1212857f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 16:37:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwOU+Gy1GybYPmRdvc/yt/Splue1dBPBNIuRQtPOYAMCMwt0HLvUE4Wc4mxh/umNQSst3H4dSrzNxw=@lists.freedesktop.org
X-Received: by 2002:a05:6000:47d4:b0:48e:60bf:4177 with SMTP id
 ffacd0b85a97d-48e6e3024f2mr6586994f8f.9.1793403436187; Fri, 30 Oct 2026
 16:37:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
 <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
 <auOyxKTuSNysAA3X@laptop-218>
 <CAD=FV=VV82NG1CAL9DtLeDYQdjC9Su6nYfLYbjzmhzEY9a0JSg@mail.gmail.com>
 <auUTV87eElVyIeTw@laptop-218>
In-Reply-To: <auUTV87eElVyIeTw@laptop-218>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 30 Oct 2026 16:37:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X24gZgixqSb4SoD2wYt93Z9tDO5dyaeg=jdH4wUwk81Q@mail.gmail.com>
X-Gm-Features: AclHuK-J1ggLxz07KiiLvF7KuKegFXEk98IgNkkyMHaorZ-92pfQb4x0ipGnZnQ
Message-ID: <CAD=FV=X24gZgixqSb4SoD2wYt93Z9tDO5dyaeg=jdH4wUwk81Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel_edp: Add SEC LTL101DL02-002 panel
To: Alexandre Marquet <tb@a-marquet.fr>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Lukas Timmermann <linux@timmermann.space>, Henrik Grimler <henrik@grimler.se>, 
 Hendrik Noack <hendrik-noack@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Fri, Oct 30, 2026 at 3:00=E2=80=AFPM Alexandre Marquet <tb@a-marquet.fr>=
 wrote:
>
> > /**
> >  * @enable: Time for the panel to display a valid frame.
> >  *
> >  * The time (in milliseconds) that it takes for the panel to
> >  * display the first valid frame after starting to receive
> >  * video data.
> >  *
> >  * This is (T6-min + max(T7-max, T8-min)) on eDP timing diagrams or
> >  * the delay after link training finishes until we can turn the
> >  * backlight on and see valid data.
> >  */
> >
> > That sounds like exactly what you're looking for, no?
>
> Indeed. Also having the 97ms value from the downstream code in .enable
> removes the guessing associated with the 50ms in my initial proposal. So
> I will implement this in v2.
>
> Any preference as to where I should put the new delay_200_500_e97
> panel_delay struct? I was thinking after delay_200_500_e80_d50, but
> I noticed that the delays are not strictly in alphabetical order.

Yeah, it's a bit of a mess. Probably they need to be fully sorted as
you said, and I probably should have been enforcing that all this
time. If you wanted to send a patch sorting them, I wouldn't object.
;-) Otherwise then after "delay_200_500_e80_d50" sounds fine.

-Doug
