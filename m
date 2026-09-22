Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3008C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F09110E659;
	Tue, 22 Sep 2026 06:38:59 +0000 (UTC)
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4168910E659
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:38:58 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c7e8a17839so752982e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790059137; x=1790663937;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pE43WIP/B8Af0zd1OEayR+RwR/Tk1IZvZVkio3avLM0=;
 b=ym0MnNn7r/d1YdsAp52NJ4iz2sIcwOcCwHlW55Ix3qBaJcc5Ltw5GNQPrtDKEHSame
 4jpet/U5qJ+CC5m+vmG+L5z/t4fE9OkMCpqD4VorWeztHrhPB1/wCowVsuoBGj4RvAb3
 qtHCpPJ2C+CZ5WCJwmj0+WoE8Aj2ib/PN5ss4kCfRH1Ny1UPv9yy3ymFf99L1KbnKSHL
 iZsFD+4lppJYjIk/q3V3regA5IfsG4x+Z5CXPGk/WKW+pA/FIPCzNqVD+v7KbKadEW5W
 IFyoGx6I4JqLcqL5pqVMbl04KoUqAz54ycGR+RSFI3+l1qXXuoNJZ8Sm4i12TEuqopde
 PAVA==
X-Gm-Message-State: AFuF++lkF3ZOG4Sz+zP3LtWNmvTNVWgF16/CyEHNCejZC+VtBpE7RQs+
 LqDUdvWHTDXGVtMiYnLMMVDoeQDzqUBVQVMfBUy0Nl+bARPPds0fvfLdrSFMZBc57ws=
X-Gm-Gg: AYBFou396OCVxxJMaEOO7csUWHISLso6gfKkOSP8W6i833ZGjz05mFfkfy50AjqojF6
 V6AqZpGP0GC9ZOvaHSi6jT6X0kDQHYplGVxZSTFXRmegSOjEtIw4iDHpGzq8elLfq/NC0dW+PFF
 cJqJw0gIvGOnwQ0lEfDfjxWVvYlR2id2Mu1L26LuO/gQ7zO5gWgZm8vxmFtnRp4vW7UAhAnf0MQ
 O1AnB1GD518YTPsY824Rxl7wtGH61LeVJjArFiAM8rhG+17ErdTI0ttFf5Y9rRDvWOyQe8w23lH
 9cLvT/vATp0xrQPM9r5p/k2ZqPBC6MkWHUlJKv0c5IqDOxeBixdFNH7+Vhh40EOym7fezgCYynF
 NoXbYDtTNYptiVYA4J8vf5DbstAGov3t5pewnox+O+vW00cN2CXHsNmJm8KqCq3MHj43B65o5Ft
 29u+JfhkCwhxoFoJNwqKPJvgoqpIv8NKidzo5OBS1nmmdDOW+7egzCR1tIFHN7Cj28mZOWJXroX
 7NNWSxA4MrEL4hErjeYPqnOgYOAFA20hyncBn0X
X-Received: by 2002:a05:6102:418e:b0:7a1:f2b4:dae0 with SMTP id
 ada2fe7eead31-7aaa02f27e7mr1496053137.13.1790059136909; 
 Mon, 21 Sep 2026 23:38:56 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com.
 [209.85.221.176]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7ab18447b24sm779015137.10.2026.09.21.23.38.56
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 23:38:56 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5c83fbd23a5so552636e0c.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:38:56 -0700 (PDT)
X-Received: by 2002:a67:e886:0:b0:7a6:3df6:ac95 with SMTP id
 ada2fe7eead31-7aaa080ecc4mr1420444137.35.1790059136564; Mon, 21 Sep 2026
 23:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260910181918.31551-1-marek.vasut+renesas@mailbox.org>
 <20260910181918.31551-4-marek.vasut+renesas@mailbox.org>
 <90a90fbd-63e7-4f85-ae8c-335b664e485c@mailbox.org>
In-Reply-To: <90a90fbd-63e7-4f85-ae8c-335b664e485c@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2026 08:38:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVjAv56=91_xXTTErAfS1brS7-s-4ZPHWB=eCpoF_KwEg@mail.gmail.com>
X-Gm-Features: AclHuK-rpqNNs63WVNzxtY1Too0qJAazs_ikggL609BMVbx2GdHhFI8yN8r-DE4
Message-ID: <CAMuHMdVjAv56=91_xXTTErAfS1brS7-s-4ZPHWB=eCpoF_KwEg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/panel: ilitek-ili9882t: Add support for Ilitek
 IL79600A-based panels
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

Hi Marek,

On Mon, 21 Sept 2026 at 22:32, Marek Vasut <marek.vasut@mailbox.org> wrote:
> On 9/10/26 8:18 PM, Marek Vasut wrote:
> > The Ilitek IL79600A display controller is similar to the ILI9882T and can
> > be supported within the existing `panel-ilitek-ili9882t.c` driver.
> >
> > This patch extends the ILI9882T driver to handle IL79600A-based panels,
> > such as the 10" Raspberry Pi Touch Display 2. The IL79600A uses a similar
> > command sequence and initialization flow, with minor differences in power
> > supply configuration and timing.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> > V2: No change
> > V3: - Rename ILI79600A to IL79600A, there is really no ILI anymore, just IL
>
> Is there anything missing in this patchset or can it be applied ?

I don't know: I think you should start doing cover letters ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
