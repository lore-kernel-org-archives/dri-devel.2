Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A25C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2CF10F09E;
	Thu, 30 Jul 2026 21:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ehf9umZG";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914D010F09E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:17:40 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bf83925ddaso142437e0c.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785446259; x=1786051059;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KsxnwQkSoj5Yu5lyZLJh7OL3IOh+0W8XUWScYjwRS8s=;
 b=ehf9umZG+dUcuKi7fHT/+ppB1LhvK6IlMgom2TL6kvqQ0RWQ4xQO8CCow5mnmQ6i3D
 fsxfa8wNhUXsCs3KlpgcicDSTx020iAEktdjj+SiMJGrwQEerXJjJ/Fbu8dl0YrrqZ9O
 flSMebDw9WrHA7wN0tKB0XQLPS/jt5BPKzL4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785446259; x=1786051059;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KsxnwQkSoj5Yu5lyZLJh7OL3IOh+0W8XUWScYjwRS8s=;
 b=NwKnlFfS8fb3/j4OmEYFRKYlHuMwwDd/oLCKxpevbSunXjbWKhUJWJHmsbk1SRkZyy
 iwls7whOWyfe3049zVlHla5qtxpjKQYxJeapirhCGNIOheKW0JNSimCarj3NfbBeTWE3
 +htedOToBfhBT3xpM1L29CuhgayrrZQ+B0VDKeo+vKrEBFe0CL6Rf5EMHnJ2tyvhAdeQ
 R3phtAI4XhJgq+f8p8kg9Lai09s0Lw5lZxy26rW7MxBkIpu6swXT9TYxgOnwcf+2Q0uz
 GEs/pkJtz9FRwcuA5fnlKBP3fkhrzahmWQUluvb5MC8roNVVVWYGUwoMXSPQ2e8R6M28
 NzGg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzttAmxFchJKW07kyDoxZ7DZ32JZLnwsKAaMYtjYK6LUsNX0AiNdyMm0dRDoJOah2DQdtIRLbhClI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxIztvKfjOWDwknixNms/Ok0y0w1i06iGBiZ1+pFYvEeaM5q42
 LR+zWz2l/WW1ngnHfBQsKuWfxcaroXlCuNY9YYXx7Yxk57WCihZTCv1han0QadBkhKF+hTgXwji
 E8i0=
X-Gm-Gg: AR+sD11piIBKbUdhzzKCMJC7mORthHEVYeh0VG6NQJ4ooemK0TyMdHjsQKeuC2s6EZz
 6gGcXdm4sfcrsU+3Kdz/7o7dBFCJKRaMBU9CarhmjVF4s1PR1kXN7dF9I4s4iTsoJ+EMSkbdCCy
 MXf3shPJL4UIly+bvpPVwoQlut/KD9OFYwi1Zug0gtgy26owyVpGnRdmlmXjTPaUU1Cr/Wd2ogU
 zGmLO2GltB3vvAOOCVXHvy4D7Ju4XidSYBySk8YFeFBNMBUs7CMIZU0XqD3anmGI4P/+HOKjyQs
 /Oe+JHagpGN6qjvjuUOJBFnQOBAFjTBxkRZFVNFG/D5x5FMtb37TDSK7FTtMTRHh6gGpktl8sGm
 bggje5Xl8f46UC9BIOk+SLpWP2OLiDNq0RBU3fNs0jcyg3wZPgxAuwNNO7rKu1K5rYibXs/WWdy
 LzjqYm9NKbkKAl2gx4YML942xez88LjsIwgHkYCrSHZY6JOpOmsWsUyoCkRZ49rz61AbtVJNAJX
 1g/G+uHDJ0i025Dg8wG7anubsQuAni4eakEnQ==
X-Received: by 2002:a05:6122:3a0a:b0:5bd:a7e6:10bd with SMTP id
 71dfb90a1353d-5c365d7d91amr1377371e0c.0.1785446259222; 
 Thu, 30 Jul 2026 14:17:39 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c36656847dsm2552655e0c.6.2026.07.30.14.17.38
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 14:17:39 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-9673385b1efso60836241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:17:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoKjxIM2K16QsWWIBpqXveDk+kLyzPcryFjcQCElcLZjxilRLcInOCApk3zWBfMPD4gahuzEPTCcK0=@lists.freedesktop.org
X-Received: by 2002:a05:6102:cd3:b0:6d8:89a0:4ae4 with SMTP id
 ada2fe7eead31-7574fc68471mr1533995137.18.1785446257786; Thu, 30 Jul 2026
 14:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260723131649.134127-1-panchuang@vivo.com>
 <20260723131649.134127-11-panchuang@vivo.com>
 <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
In-Reply-To: <CAD=FV=WPC92HLyRbo72KK5E9jTQ2TZN9F9gogZk7oNfpat4YRg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 14:17:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
X-Gm-Features: AUfX_mxGLBBQUs73dU2ol2hZTy7FureftPnEC87KAZz6Fp4s1IFXqKjCQQty6Y0
Message-ID: <CAD=FV=Uud3YA_eQ12SM9MUSLQSmzDY1f_V0HnSCUUXOHSY1aDQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/bridge: ti-sn65dsi86: Remove redundant
 dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
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
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Fri, Jul 24, 2026 at 7:11=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, Jul 23, 2026 at 6:17=E2=80=AFAM Pan Chuang <panchuang@vivo.com> w=
rote:
> >
> > Since commit
> > 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq(=
)"),
> > devm_request_threaded_irq() automatically logs detailed error messages =
on
> > failure. Remove the now-redundant driver-specific dev_err_probe() call.
> >
> > Signed-off-by: Pan Chuang <panchuang@vivo.com>
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll plan to apply this to drm-misc-next in ~1 week unless anything comes=
 up.

Pushed to drm-misc-next:

[10/10] drm/bridge: ti-sn65dsi86: Remove redundant dev_err_probe()
        commit: 9c950822f0fa923ccd344d7a143872d25efe89a3
