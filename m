Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E976FE51E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0382710F448;
	Fri, 24 Apr 2026 09:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PbRgLfBL";
	dkim-atps=neutral
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627F810F448
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:00:17 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-651c366f7efso8002259d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021216; cv=none;
 d=google.com; s=arc-20240605;
 b=Qd06SSVqnJJYtf34AQOVY6MeTSAVtno/nFBUC2Yd2svnWRRggGrRjd66LYV9tR3W0J
 qyAucFg4KX/B+qWwMpIt2HiWQg6KxkFSudqEiqw1qK+7UhIangxu14r4LSBmYoYIxBrz
 EPkQ3feYwsUiNj0CjzvnqdFMRM/TlxynSSC5UD49NxkZRluZVDNJSYi26CfIqGTFxWzW
 vqN9gXKC/SRk7HWZZO2DIDb1LS92Kk2EYhlzprFJiJ3ESaes/lOfq0UPMYVXgsWrm1MG
 PkqSF7RGNX8gvTlS7ihvr4oF5cewOeAi/hrokJ6uPJYx1LafA9gHPlsnjkb5uOjlNmDt
 oItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
 fh=tdjElNSctrJ5vj1P95tH47+m0BSNlZ+2sSLoUXGW/2M=;
 b=UNF7UHvrHzVeiVoPkukMhjc7cMHzhRgRHJl/QfNqGLxXFgr8Sy1SWQMt2LGt8Q0Bfz
 hpzoU0jJz4Y5Hp1nbHFhZZ/iZb+K2JSJp/SxHZ2lVrADdLBFsJiISFiGVe1nAPdRXPAh
 oTvfb6Zwydqu/1fwPH1vcG8RQOXRl+IIPvkb8Ia8MAqlHC2viKyUjP59zEnRepJYT7Sq
 7N0+fjNX3SNTN8IYRwQrL+7RXsdhZw6JZQF+fVl6I75h2BN0I3vk6+U1Z2uTz9KfHrYb
 L1ig/UiFWhUx9Z+IMJAtgCxcp4vOVB/PR46plu90FoHjUYQWLkow3/66mn5/FArPSM62
 nsAQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777021216; x=1777626016; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
 b=PbRgLfBLIcIZA6FxV7PcZfBoH34FjPILy9H+adIE4Y6N0LVUjO5L6cKAwNeCKjlNRY
 76p9s00CPuIg6lJ6AjgB87x3H0AywGT5dNKHVvXh7tX/qlOl+IvYnETy4QXmmJNp9fss
 L+5fq0qg3LvJObvn2OIjsTtGhRtkKSV+QpbHwJawY+bq/XU0TjSHpiywCOa5wA5XsuRw
 p0OpnTk9W1+wrGnz3Ot9E8mlGyDK4MFwWUAax8VNYs9LjFEqOz9h2ivXSV/6pXLRrsnl
 2qUGDhBXFHJWOZv6pNsoy5mbk+PlUO/l7ji4ahhgabUkHDdpVwjmBfSetljxAqIUY+lP
 pp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777021216; x=1777626016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMhVWR0mg6d0bsMxu4OxDI/s6SgSzPlLJoRVMia7Nt4=;
 b=EAUVc2lujDbxNQ+hQqrK6F+MAKc8XaKyRDV7y9ZKiQ8GOemvSWzcD9CPiY6EvMRlWc
 7KYku3ZriexgCrMQuZniKcILhRAh9Dr/8Mkjo6f3dwTUs+Pj13d/iE805awJUvXSnVLJ
 9W61MFQ0BZMAtqRfI6Y67/5zfJDxiQMSRv4yLAhwP1p6BAFe2/RwYymIfDy/CSwxPZkP
 qyIQ8w8O3b4swxGAzeH6toaXZP4MwD+noMeOgBimXnXWQt+QRlMfa1EcSqzZk63K7GHf
 l9OrexgwVgbrwmj5K+c1VN4gQ/BA1RPUEXPBBK0GoNYrA+3rFMxXymnAt2nh3px65aHC
 GrDA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87uLaEBwt1Ox9l1wyS7owQ9kiCdPW4KuH5cUm4n8OWMuFyCcP9VesM1TKCJXe72+khcJCeyufvoeU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5+q0FdV1DfO38feChSdyk1faZbcBwpuUNTanbnpqqa1tvp4MX
 YqM/quvzI+2Xs9ZtyuIII6c0fNrp0kCPX3g3OF125m05BcXZw0S5ShX5vFa9PkR8kBpRhOkL/u0
 uHGIIveDmbqQcN0tca3n4sexbPbwC6PM=
X-Gm-Gg: AeBDiesIpAl1LrmUVrjvZCvQ6A2fqbrvKjr8YqjYRG+IHc1ve+VhYZk26RvQcB/kPwC
 RDzq9Zp+7gyrDKfOUarnEA38j+Ozn2HZNjs/ZSqL7VhedY5noRAkYaf34ea8vxS0n9e4irpujeO
 XZEwriGnOLSc9KTciBJNYmZ2WAusEwf6CHY3GB5rN/qwmP9T2+P/RAd+gGmg7rcYJriFrNRP4XK
 J5FYRfnVWMeDvWUxNC91Kde9Rg4BVOYHi9knZxl3vsvFiqyYjo3dSJimqnoGTKpBruxo6HM5ILq
 iEzGztsbCnpSLZoAH/38
X-Received: by 2002:a05:690e:d0a:b0:653:1945:8fab with SMTP id
 956f58d0204a3-65319459b3cmr27855758d50.43.1777021216403; Fri, 24 Apr 2026
 02:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260415191003.3829558-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191003.3829558-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:00:01 +0800
X-Gm-Features: AQROBzDRuc7ifOf5Jk1J9tOCgnKOvndIrCp42i0bqZ5GOvl-P0LF9lO5bb2Mf9k
Message-ID: <CANUHTR_2RuqR95v3zRzqBsy2txTq2nBghi9PhMj_ek4VEBCHdQ@mail.gmail.com>
Subject: Re: [PATCH] fbdev: hitfb: fix reference leak on failed device
 registration
To: Helge Deller <deller@gmx.de>, Guangshuo Li <lgs201920130244@gmail.com>, 
 Andriy Skulysh <askulysh@gmail.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, 16 Apr 2026 at 03:10, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in hitfb_init(), the embedded
> struct device in hitfb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   hitfb_init()
>     -> platform_device_register(&hitfb_device)
>        -> device_initialize(&hitfb_device.dev)
>        -> setup_pdev_dma_masks(&hitfb_device)
>        -> platform_device_add(&hitfb_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by calling platform_device_put() before unregistering the
> platform driver.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 048839dc548a5 ("video: hitfb suspend/resume and updates.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/video/fbdev/hitfb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
> index 97db325df2b4..29708c2d506d 100644
> --- a/drivers/video/fbdev/hitfb.c
> +++ b/drivers/video/fbdev/hitfb.c
> @@ -495,8 +495,10 @@ static int __init hitfb_init(void)
>         ret = platform_driver_register(&hitfb_driver);
>         if (!ret) {
>                 ret = platform_device_register(&hitfb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&hitfb_device);
>                         platform_driver_unregister(&hitfb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, hitfb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
