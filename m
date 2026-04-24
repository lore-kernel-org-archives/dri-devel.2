Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400D2FE51E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFB210E3A9;
	Fri, 24 Apr 2026 09:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mvuJbLRC";
	dkim-atps=neutral
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6D810E3A9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:04:43 +0000 (UTC)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-65427236e94so4831396d50.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 02:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777021482; cv=none;
 d=google.com; s=arc-20240605;
 b=J+hxw7j4xJiLEe5ln+0CH3S+A4lrUyT/Bdqf2tx6BfjIlJTgJX/iWgLvaMd02K2ZFz
 BkEFEQmTKUyq3YdAh8ZnYUyaXkBql4oV5MBzZKt/dbIk91YJK0/TbZYqZI9K/TJ/6bv4
 IZDCjScMlaW4PJVQYg9N/cCO1qIXtpYgXjFn4ycpDPGnuR0WwIjPb41aUwrwPTGkAdqR
 /RlS9xGhuTIglpL7jNZ5/AsnRd0uEWnq/ZqkDIXWSnXSfT/VHF0+c1aGvgO8eASM5alX
 WRLKjfWStWx7LHpC9WgR84rVLvevvX2TNW5awGseG4RE4oPbMXhk7yN4bwzFWaj+URu5
 E4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
 fh=zf2PighFW12vmYnWN+qLnHte4uv/Pab/DCvkgWcgBOQ=;
 b=V01vWlqsb7wFnYHsGvwgGWh5R3D77R8KOLOt3z1O727v9G/q9M5SCpUWkuUOTY9UMg
 u1sO2OecL+P6QCEXHTmGfNM4FTRYZLQqU6Cf3QrDBsQ624qlF5auPIybwJKhVjTz0nrO
 XEfu4/DCU7m1xR9/tgypqApyFCDTLvnqrsg2657qv0aC59hvdhy/pVRUMBXvnEOb/YKp
 aPVMMVIYJF9lBYZ6rMlzdxTM0HIUlrtzJl4me2GCuPcYDxbfPBt8rCfys19cNpF0C0b5
 ZnHkLHzxhAQFAdNLdPY9JDE1GzzUpEsMLWFb3OdotQGuJNwJhZJJwWcT+nrykK8IGe26
 1oOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777021482; x=1777626282; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
 b=mvuJbLRCspMeJC9sAlXnllmtqwSdcln8xtxILtqIAncISksxMONyCE2uipnpqJ4Zvo
 ikEwFv7bwer/mMLslbBOHtNXPj0/i4XCZ4uYoAMEKEznD15ynwqE4ICsuGdTuvwST8Sn
 Md31yjlbkwJoWC3/wn0kxudGhJH3CNNT078SwM4dI+qL+r7qPWCBbcrXVhd3Fbofg3wD
 TRoT93NGekZ73WpoLWeQbKqXWBkEC+9roTa4+V6tkFEjgx9owRd/eJKJDwKk1hW7re9a
 5DgV5bDJN9nIgG2C4NlN42npTVQ9iCOtz4ZcciTk2q8A5uztJ+mKvIWxiNvE4Gtp2VNj
 unwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777021482; x=1777626282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=10qs2iwkS/eyNLtJNpVSp8xONvcrn//8/hAjXSFPo+c=;
 b=DMzBKFikF21FhCfcofqgVd0AC0L7iLNms0phRGTnn6GfAGdXnOHekGgOlhuGRk9HbN
 eeZyJQLPoJgFseVZ8CZW24DiK+pvE46lshxutZZWFYYCMz796PpdBlryXQp3w//42k7w
 eCG4bmO+fwX1YiGwluaktw6OpBdkcdw8zJd11JNQMtzD7pc21L0vHo8/WTzXnnfX4+mA
 n32Z+YXbjO4LDN3MfEEuq4oYA1wC0EC9PVkVaqHbDlk3NFwu3UBTn5FFVxVB7koTZamJ
 c8w9Thgw+2b2eCZ3jXBVIwKmSeGWDVrTlpEpfmGpo3UyptKwq+Rr0/FoSXqtogNDxTPW
 UNew==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BgP9YCJNcRwCaqM6xX5naQq6kjeTd1l26aXKsxbFeAriv5dwY/3LqxYcL5p2O99J41rFfJ8uHaDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVqYdTKYuFmAhMdE5Sc+tIv+r3DbDvDzJb0Ow5pYTdbOXtQaTF
 9MelR2eVJOHKIjjULbDWABq9mWzVX6fzHbc6ux9aBv1QWKt8t1QS35TuTw2XW2Mx19LR++WnVa6
 1f2OyT5zHdJGWytcu5/nShafmySORebs=
X-Gm-Gg: AeBDies3wOBq7cEA3XSivHFm4EfK2UAoL+HouQklSmiraxeDpBoX9BlTkoh4hP/iccc
 QL5cWtM7jHtwlpCMx1CPq/hyC5t8B+T0GumLKEyXVbBPH1eDXPmXkBxsSawgeAMASFN67l3nY0u
 ouUQWfmdaEYIePZjC/ccSoUyMV+LU42aDz/Ocwc3Wfov0gbKWUeOkr7jwD4sNS4Hil5rLq+YiLc
 UR6kgnmxpKVqWhmRzJJP33M2jH9fl3xH10878t8y5ExDTHgzlLl+BNncS6QSDCjsQVGax1Yq9g2
 lB8N0FTf1ncus+xoNoAv
X-Received: by 2002:a05:690e:4141:b0:653:3f1a:798d with SMTP id
 956f58d0204a3-6533f1a7f4bmr26739134d50.23.1777021482431; Fri, 24 Apr 2026
 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260415191306.3837839-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415191306.3837839-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 17:04:28 +0800
X-Gm-Features: AQROBzD3ciSHDJ4yZ2SN0KweOJ4wwJwZ7CklV1Yarwt6T_p1EdetKVc2Xh8dTK8
Message-ID: <CANUHTR_zY8f3eGUJwzcq_rAe=XfturfT5N=E3fYLyaYXqGV4Tw@mail.gmail.com>
Subject: Re: [PATCH] fbdev: q40fb: fix reference leak on failed device
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

On Thu, 16 Apr 2026 at 03:13, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in q40fb_init(), the embedded
> struct device in q40fb_device has already been initialized by
> device_initialize(), but the failure path only unregisters the platform
> driver and does not drop the device reference for the current platform
> device:
>
>   q40fb_init()
>     -> platform_device_register(&q40fb_device)
>        -> device_initialize(&q40fb_device.dev)
>        -> setup_pdev_dma_masks(&q40fb_device)
>        -> platform_device_add(&q40fb_device)
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
>  drivers/video/fbdev/q40fb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
> index 1ff8fa176124..0151a41267b3 100644
> --- a/drivers/video/fbdev/q40fb.c
> +++ b/drivers/video/fbdev/q40fb.c
> @@ -141,8 +141,10 @@ static int __init q40fb_init(void)
>
>         if (!ret) {
>                 ret = platform_device_register(&q40fb_device);
> -               if (ret)
> +               if (ret) {
> +                       platform_device_put(&q40fb_device);
>                         platform_driver_unregister(&q40fb_driver);
> +               }
>         }
>         return ret;
>  }
> --
> 2.43.0
>

After re-checking it, q40fb_device is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li
