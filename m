Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43428FE51EC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7975410F434;
	Fri, 24 Apr 2026 08:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4kLtZVB";
	dkim-atps=neutral
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com
 [74.125.224.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B905F10F434
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:57:48 +0000 (UTC)
Received: by mail-yx1-f43.google.com with SMTP id
 956f58d0204a3-651bf695701so6084425d50.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 01:57:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021068; cv=none;
 d=google.com; s=arc-20240605;
 b=ccxi7VSPbhLenzQyMuWa5ukD6Y6ViMZG+2K74RS5kd/bOk+6XiQDjDElD8/qk/QdCG
 r4o+Y4JhrwlZOUskhmfOjIeeF8mdsQ0A8ble+deJLDv7R1RHcvHo425IULgMMwDIJSiF
 RTyZY8YVs2LwYnrM/7n5ULy6hFl7gX3AzWDKTcZ0eNrNNSchpaAaxoGK1vO3c68e16y6
 BR4yFlRRaF3HJJ0QP82PMLFgygSb2sKmSBoNCKaVD1uutIMJhwqAnzEMi72Ey8zyIzOP
 aV0U2QsPCCVH0oorJZer6NXa6Y+3hHWeJZUZRx7md/zuof6OluNGOGszqjF1s0PK/1kr
 j7VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
 fh=fJPE10lexV9wcyVYo0AWyD8fBEgoMreSSx4yDEQzUlA=;
 b=EW0rwFjUW3Cei9Vcak2P1xJA9y0rbD/N2mJliAc9P8X8X3XVT6I52E3bWjy3tY/dHv
 OOjW8ICk4mcz3N1kyX19aN/5+JOd3BogH9yf+TEe1/Hn+3SEk2RDRQ1oG/hCifTrbfi8
 O/mY3Nx4iJA1TZEdPBh56o0+5A3tkJcDpkya04oc1PcOaG4a89XYTIWnnqg3rq5tvDP+
 bJtDkd3TDDhaJ/tFRIfCKHzz8lfMd3pMjQTFrb59yGx7xKBP4gKiwp7OQrXkrqB7DPEl
 dTIV3JUSqwb/Ct75YElyIMdKwBqu17JBYaaNGMjDQDrEmZZYHzOCaqxiiu7kicBkTNbW
 OACw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777021068; x=1777625868; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
 b=S4kLtZVBdnu469ciEvkq6GFU+fbSJ2zMsg4RXUMEjNWVlp75i1uHpk4dsQNNYDbu9a
 d8dG/vUHJYBxtRNtRpq9YDmofl/Et/2R8sep4T1gHQGOsnLbPM+PIGx3DuonFoZXwiGF
 vwCe3h3bqJt1Ei7wYD9qIod4cUabmuKv21EzTKkZKKaiLaAaW5JHDP97COGQKdll/knZ
 LKn7HQ1j0cwZ7c1q5Jtne2rMFV3m5FVYiVOtNIkidLw2SSUp5/UwoTiOPEGDQNnAo7Qf
 o/C/dXyG3UUFzLm/ggGnM2X2pg6mwwbH5GSW5LK2tI1hYgSpyXy/lRsW0lPaFYQywtkk
 mRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777021068; x=1777625868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMYh0A8RcacPfWSI+Rx9v4WksGDRAZdmkQHIl/OIKzs=;
 b=Q/8Mmvnh1KRmnGT0VdCwABTU1kcJvwBaQJX82AKC29NyQVzePX3/671/LOiiOh6Jvi
 BogjE1RO5SJANSfXXmbHKI+bj1SLEG+I/NOkiMOvim8dxhUE12V2GHVSlIbaESTwq7g4
 D3x52prnYkQS5tsg0RA9WT5lSXnyOMgQBgqhWJFfjD4Z9r1cBXJg3kg6cI1bq30c2R85
 u7Tmp8EJweemLpGeknTUfIbCfkjmiTetxGBqWYnKJBdNPoN8INheCECYprwSgGgEj+//
 wIaSlIE+0ieCYRH5msG5r6rqYPbY78hPcIDvlkOYjNhtJQWcgTD6XNVqN+KC9iPG3+bM
 Ur9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ91X3ZYgdX/Qr8U8VcIOr3sbED4qWtMhZz3IFnw86Yhv4XUWNg9/dEc29X355IpkVA0UsqzaEe9avk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLSuf07d+h5rXMgaFTUFJ5fbwGxidXjkFCq1ujMisDLYAke/Od
 VJqLXj7jZrb2DNxWVA1BKUc4WQrgwsiV3Ag9s2LNZ/uecazdVu+3FpgsBRGBpwuqhxPlmJfmf1d
 2ybZoI5cUmzujVQ2IbOFzNyPm/BwQf8g=
X-Gm-Gg: AeBDievLUpykj8clgXXG5MFyVF1bhIxn8hSpoVsapRSJPj6saY8P/DqUkurPjh7ZMsW
 ntX+8DpK3zCuJ+omoLyAaWfTQSleR5hLKo/Qfv66P04eivTf2Z9TcrbVnNbxZVJx0D+MH6zzwh5
 5oyzcLM6f1QgD6ZBpfV7YQWzHNN+jDFptL2xMTJ3ERGs4PxoFsgd/R7qKI0CfagXSrFZDUkYi8s
 wzy7DdSYwvet31aHbMd+PmWmXKGQmX7QoxiRLjUTU2pzROWiicCRsJZggKM3+EcUHkPypsdOYnu
 fh7ftNm3ITtr45z+oGmq
X-Received: by 2002:a53:d748:0:b0:64c:9ec3:d71a with SMTP id
 956f58d0204a3-65310a737b1mr21220612d50.48.1777021067703; Fri, 24 Apr 2026
 01:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260415190738.3821974-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415190738.3821974-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:57:33 +0800
X-Gm-Features: AQROBzCmQJ1EX2ApfnpwOngh9p6OkQ-4OwvW-Db64LtyYbRXyvs5_5WPx0t6Mt8
Message-ID: <CANUHTR-JSL0rkw1VbAa1AYFsp0NGF2Dz3X2AWmQFcJ=mm-nsxw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: dnfb: fix reference leak on failed device
 registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
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

Hi,

Please disregard this patch.

On Thu, 16 Apr 2026 at 03:07, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in dnfb_init(), the embedded
> struct device in dnfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   dnfb_init()
>     -> platform_device_register(&dnfb_device)
>        -> device_initialize(&dnfb_device.dev)
>        -> setup_pdev_dma_masks(&dnfb_device)
>        -> platform_device_add(&dnfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/dnfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/dnfb.c b/drivers/video/fbdev/dnfb.c
> index c4d24540d9ef..72a9c47418f8 100644
> --- a/drivers/video/fbdev/dnfb.c
> +++ b/drivers/video/fbdev/dnfb.c
> @@ -296,8 +296,10 @@ static int __init dnfb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&dnfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&dnfb_device);
>                         platform_driver_unregister(&dnfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, dnfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
