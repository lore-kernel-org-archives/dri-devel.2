Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B40FCC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1351B10E958;
	Tue, 13 Oct 2026 20:34:31 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA1B610E958
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:34:24 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6ae27f06c2fso470242a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791923663; x=1792528463;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YJ43Mh4hkAEjbaMZVv2fyyL/+b2N74lpzDGKc7Xi/bw=;
 b=NE+6vNvrhruu7M/8IIHbfSoe31gOlTzlrj7bRytD22Y/+S1ZQO/MrvEwuye8KZi98m
 +8McaHF+NkUUoJdueVg2lI6BtzRs7XEgUA1mBBZh/WKM0wHW1cy8w+eZ+BordnZiHQeM
 oe9FtyTsNHyNYeMDEUolso2T7K/CLK2v5reoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791923663; x=1792528463;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YJ43Mh4hkAEjbaMZVv2fyyL/+b2N74lpzDGKc7Xi/bw=;
 b=xfNCNEf6YyfiBIyHB5n89M5oLEkE94M3BrquBW1eCa6ysGnvklaYfZsvzE2DIDoGdc
 2pHqlAQ6d7ADX1Q07g1RrwvK/ApL+9/iS0eubXks/jb/6SUEb2rYv5liSVsy89Dzw8ud
 UWZWODoRNFuduke1WbwuQmG7hNHYfVZtL74T67NManlXyf8AQGLCYvNsLHZ8bOOZueFU
 xa0PYOm7jiK5fZtKNjprMKtxbYqIuBGE1X6BRKNhc974OLaN2P42Fyl+Alecg/9T2SS/
 NdLEuJ7mzx0Ld4XAU1CvB6jWoc/Auv46ofUKwHCdh3mKT7qR2Y6+0E+IAK2hC+gcmTGu
 oN7A==
X-Forwarded-Encrypted: i=1;
 AKwUvByi/ahrF+JaOfdKUp8FusWUpGw1UqqrftPe9k4/F1JtcLf4ABADqFpPDlxI+WV5yZRrObTQ/66ZbKE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJn5hBHO1MxvHhvyRhRI3QvJUhVC1MkeDwADTzJwyCaQeeuJKI
 Uf9A7TqPtRFBjjgakL0zK3nl3/ZlRf6vnE+AKiyqPvG8szRKfsrl1Yt6IZ9tFJV8Fk9XtveOmbN
 MMg5nnA==
X-Gm-Gg: AYBFou3F35yru3emoKUy81kWm8VMFJi1VOCkSKboCMDcZrW84FajZSdy9RneMiOLfzG
 7ehFsEvnYDeuqVXFBB7/KeBM880paNkOmQJ4ARd2doqTwZ4aKdVJJ6HCW21mWS4jVy4VFqdqSvy
 YX//ChmAvVJik7MlFvaXN93SAKvyb0HLPD6sgCRqL9/1avcPnNL9UKFg1Whui280LmeTXlX8ZDq
 iX+kafhkDGw2qy0ybEI7VSPshSZ0lykSk7kaSQEMr59Yg6r7H3wGz3U2cqRZ041fyMX6/pJC9ks
 SCn/zshJng2JU0oztzuhBALcQolWsd1Y4BvmWhUvR5+XXfiH1N0PQL0rxVRa6pmaK93RfSnCrSU
 gGYdTCCIkzSCwIjqIny/zAOh1Y8MLEZM4t5hXtVwLIRWY0982ge+qVTA/qIIpl6ygAIUaezQ98b
 Sy7zRiEyx6yTaBw5gZKXwEhojBlL+J/MKGJOulAHMhb8m2wN7r7D2XhZLeHp1iwjGDM/4FHFBOK
 rTv/xeONCwWSAZ5fDxmLgAv5JhGa6uJab1WfHyoXA52jTaJ
X-Received: by 2002:a05:6402:2115:b0:6a9:f88d:c092 with SMTP id
 4fb4d7f45d1cf-6b17c164de5mr11629450a12.0.1791923663149; 
 Tue, 13 Oct 2026 13:34:23 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com.
 [209.85.128.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b20388c1f1sm277404a12.26.2026.10.13.13.34.19
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 13:34:22 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso2945035e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:34:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz32AGJJBSVq6LLOjlxlJazN6W8wqpqbHgBXYTJjanhVmIm6naigGNVWh+i/HDk3fM5e2dxZF17J7A=@lists.freedesktop.org
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr285599465e9.19.1791923658971; Tue, 13 Oct 2026
 13:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAD=FV=VZs9bZciynpey2O6Yy5DQJqeq9Rgz_Ks6dgsBhVUkenA@mail.gmail.com>
 <20261013144849.343351-1-jerrysteve1101@gmail.com>
In-Reply-To: <20261013144849.343351-1-jerrysteve1101@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Oct 2026 13:34:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=PJEE=N59U3X6dRP4ewGyKKp-Aqcf-a-g+t2qzGWu6g@mail.gmail.com>
X-Gm-Features: AclHuK-Dtu3q0Rry6LALk96rDZTOsReRNnz9Mjq4nuu4DdDjwOgB1XlO8qwgef0
Message-ID: <CAD=FV=W=PJEE=N59U3X6dRP4ewGyKKp-Aqcf-a-g+t2qzGWu6g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add BOE NV140FHD-N43 panel
To: Jun Yan <jerrysteve1101@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, jesszhan0024@gmail.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, neil.armstrong@linaro.org, simona@ffwll.ch, 
 tzimmermann@suse.de
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

Hi,

On Tue, Oct 13, 2026 at 7:49=E2=80=AFAM Jun Yan <jerrysteve1101@gmail.com> =
wrote:
>
> > > @@ -1972,6 +1972,7 @@ static const struct edp_panel_entry edp_panels[=
] =3D
> > =3D3D {
> > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0xd497, &delay_200_500_e50, "B=
120X=3D
> > AN01.0"),
> > >         EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B=
140X=3D
> > TN07.7"),
> > >
> > > +       EDP_PANEL_ENTRY('B', 'O', 'E', 0x03f4, &delay_200_500_e50, "N=
V140=3D
> > FHD-N43"),
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "=
Unkn=3D
> > own"),
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "N=
T116=3D
> > WHM-N11"),
> > >         EDP_PANEL_ENTRY('B', 'O', 'E', 0x0609, &delay_200_500_e50_po2=
e200=3D
> > , "NT116WHM-N21 V4.1"),
> >
> > Things look pretty reasonable, but before landing I'd love a little
> > more background about this panel and where your timings come from. Do
> > you actually have a datasheet here, or are the timings a guess based
> > on nearby panels? This panel is also curious in a few other ways:
> >
>
> Thanks for your review.
>
> Regarding the NV140FHD-N43 panel: I could not find its dedicated datashee=
t.
> Instead, I referenced the similar NV140FHM-N43 panel [0], which shares th=
e same
> resolution but is 6-bit.

Hard to say how similar a "FHD" vs "FHM" model is. Panel makers
sometimes use very similar names for very different panels. That being
said, we can look at the datasheet you pointed at.


> As I understand it, per section 8.0 POWER SEQUENCE:
>
> - hpd_absent maps to T3 (200ms)
> - unprepare maps to T10 (500ms)
> - enable maps to T17 (20ms).

The above doesn't appear to be correct. See the kernel doc for all
these. Unprepare is "T12-min on eDP timing diagrams.". Enable is
"(T6-min + max(T7-max, T8-min)) on eDP timing diagrams or the delay
after link training finishes until we can turn the backlight on and
see valid data."

You got the right value for unprepare. Enable should be 50, though.


> [0] https://raw.githubusercontent.com/yjun123/e-waste/master/sunniwell-z9=
6a/datasheet/NV140FHM-N43_GZ.pdf
>
> Since delay_200_500_e20 is not defined, I'd avoid adding a new delay entr=
y.
> Reusing delay_200_500_e50 is acceptable and works fine on hardware.

...so "delay_200_500_e50" seems right for the panel you pointed at.


> > 1. ID (0x03f4) is much lower than other panels.
> >
> > 2. The EDID contains the string "STARRY", which is weird for a BOE pane=
l.
> >
>
> These two points are indeed strange and I have no good explanation for th=
em.
> That said, I found a third=E2=80=91party EDID for this same panel [1].
>
> It contains identical information to the EDID I extracted from the panel,=
 so
> this is not an isolated case.
>
> [1] https://github.com/linuxhw/EDID/blob/9c0c1bffc9c0f1cb2044115149a5ecb1=
652803f8/Digital/BOE/BOE03F4/C26FE7F0F22E

Fair enough. I'm just going to append a note to your commit message
that the timings are a bit of a guess.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel-edp: Add BOE NV140FHD-N43 panel
      commit: d81e2537f8082cf416e3de7bcf758191e8ef771b
