Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93987606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=esLErEH6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B047F10FEE4;
	Wed, 18 Nov 2026 17:14:54 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13F810FEA3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:14:48 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6b88d143160so1522316a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795022087; x=1795626887;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=veMOh1w+VgYOzxTfgQ657fK24oJmuF7rksxyyZSHFRg=;
 b=esLErEH6goWv0XxndGWr6eaLL46MltWD8iEjfJ4Lc+qejiJwntW1uwZWY7Tj0rP0Ij
 XgNP4teTS4Gb7p8aPoKpIId/NC6hLXxtauBno/nkjxm8DUTfHomGCZF7oXuYqyJdl95W
 CpqOZcoZpCZNCwpzIOq6dwB+xMbGhf+/6MikA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795022087; x=1795626887;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=veMOh1w+VgYOzxTfgQ657fK24oJmuF7rksxyyZSHFRg=;
 b=PHbGLab2TD10A/7yyhotUTQMMK/yFabJ/3j5GRjFvlFOblWL1dj846S6OCmQ1A/5Pe
 x9ZMzVWdov/0mzPrcUyBl5BuJZkQ9AEL2lBjsCcpJxFgtrr+vkC1hJTP2vAc2y2lHC11
 QQnNmz8WTOt6a+CSU07w/bQHhTDqSrOdn+2mH4ngiN0SSYkFQrFryVk3fZfFb2wZajtK
 DLzNY9tx7nZk0KbK7wmDKwsIXg+wt8OlA7XiyH2jduXRXVBuSKU7mnAnWkubEl+upIKP
 xTSfz3DIrkFS4m1X8bBqXQTokGxAbW8VHvLekxdGHI41l+cccf6QmVoytBZVYj4nXXNf
 wuxA==
X-Forwarded-Encrypted: i=1;
 AL+hErHDFZnFug1V2uoLAAsqM2MWspwuuRrj4kDwnjC18YuHRl0SinWwnJ9BT7Y9XmckgJG4fKy+l//XaZc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yIibgTfyYswdfmJG/9kuPHYoazYHEx7+hlhALnK/Ruk/W6o9L
 oy+mZRQ9hTbxOgkwtb7FOdSikLWsLFMW24+jDb2Ewxz17NY6aV2qGLur3qyLUOwecac9QjwQD72
 91k5AJk4b
X-Gm-Gg: AYBFou0guaAx6UR6mEn02gSmiYpjFYLe0ozyj2TLl8GG8zT1WWSG4OW39+Q6+dVb/Ft
 6hXW8YR3GMOwGANf8NWeuK0q3frBeAt9GcCHoYfkvmYUN4hfAY3OlGu2094jP6qdpN7gu5p2aUT
 VgOhvr5Ve+OHKUOTd+gAkhKhuLhplpr8kklw2hs7VHRNXT0h4+PO9gKkOE6hI3wVuVc33NE0vat
 pU3gcNLV0JQs3/QBT0Dx7uJ1QJ9Dwefm2mwgbsP3MxqI7FlZIs7XAjex8MuLjr3gGRP/7yKVCPV
 za1scC1/G9AGTUsz2itx9oXvEkuECcdvV6ub0qZMuP/PcJkmfHjnWy5IMDAH19uAaZsReaqA+PE
 Mhdr0Zr8QJUD91C3zDNptZf8RsCSUlkIc7YcdUNUa9fMdStoRoSSRxBaW0rTPitKVZ9FN1h+33G
 oJuE73+soTCprxnMnIHI4hZWWSUixmMVURhbDXhIHV2L7Hh7Z2A5Fb796+wxlgVJX6eFcFbIoER
 7Y8d7eIvAv9C2OKQOxgdA5uAfAA1EKuQhirG9TOzC274e2pfH7NvWwVYh8kQrXB5k8wqLuUyIjS
 rFt6C7pl9vzyubvN8EDC54W2rbfBOzOO3jWk08YR9kXms7ez8m3iXhUi5A6btfJsSgkD
X-Received: by 2002:a05:6402:c4e2:10b0:6b7:8591:4824 with SMTP id
 4fb4d7f45d1cf-6b887ec8c9fmr2056958a12.37.1795022087064; 
 Wed, 18 Nov 2026 09:14:47 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com.
 [209.85.221.44]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b88a1eab52sm1345025a12.25.2026.11.18.09.14.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 09:14:45 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so840162f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 09:14:45 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErF96SX4QtrYhTSR8tL1q83064qeZ5qTfsF77XdM1KVb0CRUQihcV771UrD7NF4GlMcJUWsWteavCk0=@lists.freedesktop.org
X-Received: by 2002:a05:6000:4706:b0:48e:5df9:1ec9 with SMTP id
 ffacd0b85a97d-4a6389ee18amr7563261f8f.24.1795022084796; Wed, 18 Nov 2026
 09:14:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260716132334.1565183-1-johan@kernel.org>
 <anx_MPm2Y0RVwZ9h@hovoldconsulting.com>
 <avw_XKo3EzosfyIh@hovoldconsulting.com>
 <CAD=FV=X5DTqanxUBt9KoVh_93u9EUQm8_B2mnej=+-nxpA81gw@mail.gmail.com>
 <av1Q8B27DkF8Iv2W@hovoldconsulting.com>
In-Reply-To: <av1Q8B27DkF8Iv2W@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Nov 2026 09:14:33 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U9Npdo3da+Hr8sb0DiSrrwbVocMVyyUnieJONoZ=Q7EQ@mail.gmail.com>
X-Gm-Features: Aa3M54osESd_4l-ScPsWj48EQ0uAO7q3qxUcSdmQmSBrC9QG23r9DoJATcHJQCU
Message-ID: <CAD=FV=U9Npdo3da+Hr8sb0DiSrrwbVocMVyyUnieJONoZ=Q7EQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-simple: take i2c adapter module reference
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Johan,

On Tue, Nov 17, 2026 at 11:17=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Tue, Nov 17, 2026 at 08:24:53PM -0800, Doug Anderson wrote:
>
> > I took a quick gander. One thing I notice is that earlier in the
> > thread there is a Sashiko review [1]. It seems to point out a valid
> > problem here. I'd imagine that if I land this patch, I'll get a
> > nastygram from Arnd and his RANDCONFIG testing. Am I confused? Is
> > Sashiko wrong in its analysis?
>
> Thanks, Doug.
>
> Yeah, I took a look at that at the time and I believe the LLM is
> mistaken as DRM selects I2C since forever so the driver cannot be built
> without CONFIG_I2C enabled (and you'd have the same situation with
> the panel-edp change merged in July).
>
> I started cleaning up the I2C mess but got pre-empted. I don't think
> that should block this change.
>
> Johan
>
> > [1] http://lore.kernel.org/r/20260716134901.05E221F00A3E@smtp.kernel.or=
g

Ah, got it! OK, then

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...and pushed to drm-misc-next (not -fixes for the same reason I
didn't send the panel-edp patch to -fixes).

[1/1] drm/panel-simple: take i2c adapter module reference
      commit: eb2d05056f5c65fae6e88f6d935f3f7089badf00
