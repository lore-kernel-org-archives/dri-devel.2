Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05169C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 05:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5EF10F778;
	Fri, 10 Jul 2026 05:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="pIT2k1c5";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 972BF10F786
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 05:50:44 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2caea3f742bso5695575ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 22:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783662644; cv=none;
 d=google.com; s=arc-20260327;
 b=EPuQEatqM4+bm6tZvlgB/YKvnIjCPFFmIAWujWgNf/X4Xtrn+biztMGx3VMVbRxnPe
 u8DYedkMup5jLAmZZx2UDoLn5bx9QrqV4AJAzwL/ey1/jCo5Ks3MtRVtC7pf670npxyC
 kI4zR1TXmQ2y27qAY2U+cVT9QgSUmKVMdwzvAcXuKgGK/tSjV45torHswEAX3ikG0P36
 iF0DnbEkSV0CTGDSASRjJU7x7jvMfxZk6N90kiCK+Tr9bQTRSbMP3U6694AMzT/VfUtR
 Vy1D1atzCu8gMyIhLvSLWaYrYdg7BiPnxMnITo/loffmGDIoLMPKiN/echN08gz2NA+5
 tvWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8DddMInZ7IA1pfySnmNQl3FXCwNGcPaWp2vWIBS2398=;
 fh=0a0YLEIhnY09ThETYeAJPAkcKHHsOR3JYKq8+2xBbmA=;
 b=W54VeCe9NMxzII9fKGJHqJbSv3ajKdY3vtnQRGwMGgID1VI5GBCK6yrrcI81koHQ4V
 NRhSVY0EN0wo0s8z/kdmKU1gJcfCiKerbbZcIOIkmMv+3IbRM+eZCDaufsOVd/IrbxeL
 vRMGYsYXuFID5Wb1KBWntm0zPqDPjiFgOJN3w7I+CJYB0kpwXddkvOXs/2zbzSaLX55Z
 O44EZtpZ+7WEylO1V1MOt792fSvhYdzaT0S59Zd7GK/e/buYREVuiRcOijYod6WJZ/NY
 MVHMhMY91fsZPYKydxAlOFlp/YtsgrIsbZ3h8JPTlq/jXzXZ0wm5/erh4R2OniBi5mBC
 NjKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20251104; t=1783662644; x=1784267444;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8DddMInZ7IA1pfySnmNQl3FXCwNGcPaWp2vWIBS2398=;
 b=pIT2k1c5ZLtx/C0PJnBDB/ieOSlwq7ZkYUGFN6AOH9zKFrPsHzGRdwtdTdA87HqKho
 8y/EQDLCYOlpCz2KwW+TyDjkv1pXARAjU19qaLncJTBnhKQZpfHkx6F9Nkmqcn00puqK
 79Rma5S29ESIRw59826i/ivZ+Ig42xK77d6rpoj+718LnL2V2bE/aFGDgEZBHiCVvAQP
 vkzJXwAvbblwgaLqjKibX3rblZc78nXSpSDcnbMwRFoCJL4f2SRrGKswXFJy2QgSfq7S
 OtpoYHBnU95qCLdc6zZml5S8ATZ3ubgV0U4E9sADEfxZ6zrMfC1vRCN5a9k6ZRIt521V
 mIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783662644; x=1784267444;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8DddMInZ7IA1pfySnmNQl3FXCwNGcPaWp2vWIBS2398=;
 b=FJHWllKH5MgPSO1WTNYIasGzdLHA3dcCHvc4UK43SHkl6S+70Rm8WDdC5Smogq9UQS
 TkLs2fgXOVUVqJ+h8lZmueC5wdxy5+pJNzVL6vRPrgyNgpT2ciQOYOwI+OGZBr9A8J6M
 SxSP3lQC4aCFkMB/UtHJav89Z/w+7pfIQgAy4J9EK5XOXT2fsXoFzqe7JQnTL20SKnpW
 B3m8Eo0CDSRDgo44kr6+2G41LSRruShVPlD24YO+YrV8sqwfqMfYO3qQHdIeFtHu0Kxk
 R39ctBqPmeKjTOdLCWwouL+pbMBpLRLS/kaJ4mek7ci3oRbdBOrJbTkqbagwBwUwLOuK
 gphw==
X-Gm-Message-State: AOJu0YwsHDx7YFUVd8HSkTNLzwiVPR1FGt9pPQdVi54L/J+dJyGL2VKu
 Y0/jQ1enZ0anwxsiB/Uz05npEV9pXmycBhAot4ax6iackvbp01DA3srVzz38HOeatymCR/7h6i7
 YTM5UvpGONTbZPvjHzKFq8lbXDX+5suI=
X-Gm-Gg: AfdE7cmzEBwf6qJiLUWhiJi1ReEmDDjGajqT5eQ4shoc4SCHmF8IeTtpInybB0SJqSR
 O7a7Lt1T38O9B97AivWR68xBp0ALCaTUnm0zgfbYOjdrzw8uORxyQKjcLDqYwYUmLB/QTAJubqu
 /FGGqDxE6zr+FOlRPbKQCRbr9I7pmxhvFyI0hSlVAMvqllsFPtynZpuj3uX+s8ZcexoCyMETjKH
 FBoYP3JkCENECw3tKuQBGPLbbbyVl5/TT6qPn/7bXrpcvo7kjwid0sfSqJzeXli7UdLhpl9hFcd
 CkYZFCSLeQOfG/adzB5y3vKkJjpbTA==
X-Received: by 2002:a17:902:f78b:b0:2ce:6d4a:5b8a with SMTP id
 d9443c01a7336-2ce6d4a5c71mr61147605ad.38.1783662643951; Thu, 09 Jul 2026
 22:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260709205538.73157-1-zuiderhoekl@gmail.com>
In-Reply-To: <20260709205538.73157-1-zuiderhoekl@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 10 Jul 2026 07:50:31 +0200
X-Gm-Features: AUfX_myPorv7UXy0UOv5TQvSWql4a3XLrVFEv1QWo1DUc3NB-2t7-ryf9s8Kppg
Message-ID: <CAFBinCDVn0+m1MybMvoNOXyNk+8KuxQrxrou=KseHue+EZbP5g@mail.gmail.com>
Subject: Re: [PATCH] GPU: drm: meson: inline call to drm_simple_encoder_init()
To: Liam Zuiderhoek <zuiderhoekl@gmail.com>
Cc: dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, khilman@baylibre.com, 
 jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hello,

On Thu, Jul 9, 2026 at 10:56=E2=80=AFPM Liam Zuiderhoek <zuiderhoekl@gmail.=
com> wrote:
>
> This commit inlines the function drm_simple_encoder_init for the meson
> driver. It replaces the simple encoder init call with drm_encoder_init
> and a custom cleanup struct.
>
> Signed-off-by: Liam Zuiderhoek <zuiderhoekl@gmail.com>
What about meson_encoder_dsi and meson_encoder_cvbs?
For all three there's already another series - maybe you can help review it=
: [0]


Thank you and best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/20260531073532.8609-1-namanarora0=
29@gmail.com/
