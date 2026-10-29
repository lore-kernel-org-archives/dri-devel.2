Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB7606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AaVoDevR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544A510E09B;
	Thu, 29 Oct 2026 23:27:53 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B85ED10E09B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 23:27:47 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c445c95d553so8160566b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793316466; x=1793921266;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lnVNxxbt+qbN8QJ5DPYiLdQeqrQxagvjKYBjiz3eH8c=;
 b=AaVoDevR5qcHHkkN5gps1d48Tkh6pYHBLJk7Uoetnjnze9pxYj8RrDUDtrgWJgV4Fz
 WUrYHJOSzm2cWUEjmg+YACowu0R1uxGIBJMhffXklIb8fCu7OY7/WgdRe6YnebHhob9C
 x0M40+2BSN5bkKHVI8luyPC9cuYHJY25o2bBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793316466; x=1793921266;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lnVNxxbt+qbN8QJ5DPYiLdQeqrQxagvjKYBjiz3eH8c=;
 b=U7l3+i9YGxTbr6q1Nbe9DWAPnXM8U7PdCFXJdvqR6PEq7f5gDAFqPyO8CrWI5pEuZV
 9yvbouR8WELCrKMc2hcV9RGj+zFep1GKdvmvbVWD/ohL07vrOZ5lmmkq6kOTPPVcFn4W
 g0U9aC24yQn9fDUejQGuA6gvgoeRhULCtlf82WhsV0yvnVHDvM2KIM4QdXSVXIyDgIq7
 1FAnogQb1pErqDBC30sQFlwFe2yhVu0JMQI5/N9iZTtetbSDqAFVrUpktBkx0j9foiqX
 l54JqgqKwkURf3oQDtDMAzhCAqQrkoy8F8EBxggKpsGaZps6uuCMhEmwPh1HUw4oaof9
 DEsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7DO+JZqCg74Kw/hzaOMPhc0R2AVlcX+kM7QWYq/jEyUPq9q1H4OEIoRZOTB27PQKEbAN3960BYFw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIsnKbO7w90EpO7obyuFhBjmzH1z/oDJ/HWw9xSNovZJH44cDp
 9iueque0syF7rDp2be8wWJaFsGH4vKZNTVa6krpvMBhaKNRptKVs+rVdY1Q7t4ZKulxZGl65OP1
 aqpLfBNPJ
X-Gm-Gg: AYBFou20pKjrdTkXICvBw1iTv3pJotW0drDNwYbOVCJOV478d1QJFWR1DgCHpFLK6oJ
 Ip9pLFCCTSO4lvE1MlaSOFijHXev0483k5jIOj6+ni40PAOy9zU1rBmlDS1rRYyPcsGi2+u3JkV
 eEVneEav/jnAG5zu1BShTqwkCw9ThbTe+tT/ckdTgLKCfcVq1c480mY1LX2Xk51eEKaRYgd4nLY
 l1V34qIxzDnUS6TlktJmeei+e/+279Mt7h4DEIcoXS1RjB9u+JcGMvfD23uoCfHll95wN0kxCVb
 U7Vz4IWgvdoxfIsHw7GK+CXqw5JrrKlyR1IPJP83eWn9lu4bk3NkRC/E7SD0ILPaKleSP9RD593
 Lo6mNcMdROx4TiyjeqxODraqB6gg1fJNB2Lf7FAhwuVfVyQpJaWI/zfs0cUGOIUb68EecKgzVgp
 /VeEjDfr7iYu+ts5NYGfJcBJai1MPxHsQr8AKiIuemkyGZ7EkE0Hfauq3c4FHHMog0go7zGlB73
 HOWRhUj67MBsfKhE+0ZtNIYW8Zn9+C9VfIlhRCcFXlFaGCtv6RbWRJENt2jjfUEHKdZaLYiwYra
 3h01bYDX4SFuFCNHDm8GldfHB1w8hmtGJOHaweWk2e6UkiANYK8LLzTYotJAPLjHloPh
X-Received: by 2002:a17:907:6e90:b0:c46:8c16:a656 with SMTP id
 a640c23a62f3a-c4ca7a86e7bmr45724766b.18.1793316466156; 
 Thu, 29 Oct 2026 16:27:46 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
 [209.85.128.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4caa337c09sm10224066b.14.2026.10.29.16.27.43
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 16:27:44 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso527265e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:27:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBw4SoTvMFASXpFZcXdwagy2yrk8mQeJm2fOQkXTmM61wawxoBNsczE4U9l7GEYDaKGWHG96wvHoWtc=@lists.freedesktop.org
X-Received: by 2002:a05:600c:4715:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4ac150b28bamr10449115e9.4.1793316462561; Thu, 29 Oct 2026
 16:27:42 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
 <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
 <auOyxKTuSNysAA3X@laptop-218>
In-Reply-To: <auOyxKTuSNysAA3X@laptop-218>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Oct 2026 16:27:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VV82NG1CAL9DtLeDYQdjC9Su6nYfLYbjzmhzEY9a0JSg@mail.gmail.com>
X-Gm-Features: AclHuK-RAnD-cE_PStAvE_4zQkeWnl1muDgR4l5_h3nIFbUe3wcXyeLuhes_lRY
Message-ID: <CAD=FV=VV82NG1CAL9DtLeDYQdjC9Su6nYfLYbjzmhzEY9a0JSg@mail.gmail.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Thu, Oct 29, 2026 at 1:55=E2=80=AFPM Alexandre Marquet <tb@a-marquet.fr>=
 wrote:
>
> > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/pane=
l/panel-edp.c
> > > index 94bc54c3833a..c92985363093 100644
> > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > @@ -2198,6 +2198,8 @@ static const struct edp_panel_entry edp_panels[=
] =3D {
> > >         EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d2=
00, "134WT1"),
> > >         EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d2=
00, "LP116WHA-SPB1"),
> > >
> > > +       EDP_PANEL_ENTRY('S', 'E', 'C', 0x9c0f, &delay_200_500_e50, "L=
TL101DL02-002"),
> > > +
> >
> > It would also be good to note in the commit message where you got the
> > timings from. Datasheet? Downstream code? Guessing?
>
> Both downstream code and guessing, as I could not get my hand on a
> datasheet. I will add an explanation to the commit description.
>
> Basically, the downstream code waits: at least 500ms before toggling the =
LCD_EN
> GPIO for power on; and 200ms after. I matched the 200ms to the hpd_absent
> delay, since in panel-edp.c, hpd_absent is also the delay that happens
> right after enabling the LCD regulator (or toggling the enable GPIO, as
> appropriate). Similarly, the unprepare delay is called just before
> enabling the LCD regulator, through panel_edp_wait(), which matches the
> way the 500ms delay is used in the downstream code.
>
> For the enable delay, I went with the smallest value that would still
> work, but I admit that I did not try anything below 50ms.
>
> >
> > I had my AI agent take a look for itself. It found evidence suggesting
> > the enable delay should be 97ms, not 50ms. The other ones seem to be
> > OK.
>
> In the downstream code, 97ms is the delay used before setting the
> backlight on. My understanding is that this should be used elsewhere
> (e.g.: in the backlight node of the device's DTS).

I don't believe I've ever seen a delay in the backlight node of the
device's DTS, so that sounds wrong.

The .enable delay here is described as:

/**
 * @enable: Time for the panel to display a valid frame.
 *
 * The time (in milliseconds) that it takes for the panel to
 * display the first valid frame after starting to receive
 * video data.
 *
 * This is (T6-min + max(T7-max, T8-min)) on eDP timing diagrams or
 * the delay after link training finishes until we can turn the
 * backlight on and see valid data.
 */

That sounds like exactly what you're looking for, no?
