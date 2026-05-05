Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09048FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 01:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D17210E02B;
	Tue,  5 May 2026 01:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EuUxjCw+";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B22110E02B
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 01:35:17 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-67b7c77865dso5975206a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 18:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777944916; cv=none;
 d=google.com; s=arc-20240605;
 b=Y/SmKXLQYzVeDBzeCsD7JvkrEvM0oY4BkbjIELHCK/6qD5eFADUzFaHMxRQs431LNw
 KOob5M++NB/gG2esKZhnq8TqfZ83phLs0Yl3H+PJSEyiCRct+1fGZLARBsCJH4iartcr
 Ml1paG0LWt2aNkhU/gm/CUdEQw1vZ4QKYWmZTZbwtI1XM5MWG5Gnh+Q6SwbSrSt3n5+9
 IV18Tanj06Ds5gXosP/8D4j7CKp3HtW/R6s+BceO3cPhFrzbI1EuQREiEg5V9PQfnWwP
 ZuNmWbcQ30RyG8ilsz6IAsU+jAwHghCwhFWjZSARTVm55GDIqCeGe1WwI6/Wjka1l+pE
 9RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
 fh=e9dJIEZIQfH72bUlLrNN1plDhAXVPTzgXb66IXtaKh8=;
 b=VnjN3OoRQfLNwHjGnrVFdU+uC2Oj37UCYE/E7C0QYbr3WXQXknpAbNIDurp5JVs8v6
 hjQdW0D0MS7HxADzyEQ9+d7PCdQKa8rqcHUFlRF1ktTne5UKGnDolchdgPJTeB4UigMN
 sLJb9Xzmmx0fNP0TV6AAxByEZs5TtqBtw+elCiph197uMTIFWdaSkYw4MY+mJkKj9IAA
 KTtsp8yy5xLrvCNXphOpX//FPQrOM3knDzHv/bTrcWDrIF7tYi3QDT9bKt9KEBq9lgp9
 LcgZ4yy3gnubHZzNO13lqqaGB1kbQMwy+buWOUaESH6YqB0rDkjX4PsoysIhuxJV1OCy
 Su4A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777944916; x=1778549716; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
 b=EuUxjCw+3EBf36fJW4EFbaIf2kx++LmWRw4Hz5B6rKVOjMSI2Hf7bcF/cB5OJnFuFj
 kklE8K4z80LFkhlZU/w7vy5yaf9DuucG02Xk06946zZUy+rU2Y4ecxGjV9p9BSioQvCX
 sJuLEJEW9u1Awol49CdDRSywxwhvwBnK62M0KIRIQl34M5nhoZLnZIdO5QJZ8Wck5dYl
 cdiN6w5nLU7NvwUCu72PemlRTjsywvLZMqx79xyWgeFq9nKIMQonJyx6my/15BeQQ6Pl
 Gz+TZRNwWsF3uTjC8TTrOnq4qztehT4omo4q4Cf8hwTNGscZwkCkgC4cmA9JEsOaYBuV
 o2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777944916; x=1778549716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDHOgdXFt80PHMEfunn52M5XiYd9+W5iA1+SEBfCX3E=;
 b=Z73AtcHhfgeeX8cTJrcyy77WaaOYSmN/gv9xMHaE90lCIXo+AtP2AtDEFuU7zUVF90
 TUkAqWz5RWOpOe77uYY+QLHz/WUu2vvyInM3saLAg2hEwE0QXMHpt+Cj2sbVsayp0Ki/
 rratjgoINMcIwrjjCA4XeC4jgFzi9fdHhPGqjBW9XaXRN/ksNMfDiB7iCInQDeSP554i
 q2I1JYxQlJLUhr/k7MIqU8i5j3Mp2ta3Kp2sfbp5g0oDnMJsbnkHZs8YFEeV7DDWKo3R
 +SWIJ51xI53ES/SMobMjU1E0CRyqCuPXJNhrb0/GDqvyAycsVq4cA33hJoYcQPLQXTwF
 nF9A==
X-Gm-Message-State: AOJu0Yx+uG8loJ/9zwaihFhjLoqiW25mjHvU6QmBErxgg+MqCxtGrZ4F
 ebIccw+6WdwaIIpNqFN62HANDCQON9jUMhVkkuYX0eLYVG4ba9+sOA8KnTSRpT4qDOtPsLqCoVX
 xFWGWO0gGxyELJNHTJCqE+CfXMFQxj8k=
X-Gm-Gg: AeBDietm0QfhDCg7076Lqk4TzeBXxpo25yhqZibv4o8XGsITCxoX/0AOFNO7Lg4Rvzk
 XXoybd0yx1RcC3fFBG1A9RJZieDwXHT3J4CqftfYYRzoVeJ1y775/HvuUCYmRpRruq6bcgo28+u
 b/SkWsNDfQfj1jUop0LZOCcR0SPEf6mlOSyVA8EUg+nE/Pb09i+kmHEhgI3Elt3exSx2zWi+hnn
 JcrBfajITCPusDMhuVaDaD3VzURt5yh6qw4lt1Kp4shDrA+ImT7H82DlDSQzaJ76FP7i8NRwqeL
 I953IcFtfOi0f5thGMM5H1j1Sz4=
X-Received: by 2002:aa7:de0b:0:b0:671:eac2:d328 with SMTP id
 4fb4d7f45d1cf-67ccaefaf3cmr314795a12.10.1777944915515; Mon, 04 May 2026
 18:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260420051926.28276-1-dbgh9129@gmail.com>
In-Reply-To: <20260420051926.28276-1-dbgh9129@gmail.com>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Mon, 4 May 2026 21:35:04 -0400
X-Gm-Features: AVHnY4KSQRmYHcWc5pFC71533222Sqo3b2fvZ_q6cpLcxIlxtJdMnRaLtwGrjsU
Message-ID: <CACrCO_UxBpMD9f2j3Dv2tB+OVHDgWKk=z_8booM5HkhRG+Quog@mail.gmail.com>
Subject: Re: [PATCH v1] fbdev: savage: fix probe-path EDID cleanup leaks
To: Antonino Daplas <adaplas@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>,
 Taegyu Kim <tmk5904@psu.edu>
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

Dear Antonino and Helge,

I am sending a gentle ping on this patch. Please let me know if you
have any feedback or if any changes are needed.

Best regards,
Yuho

On Mon, 20 Apr 2026 at 01:19, Yuho Choi <dbgh9129@gmail.com> wrote:
>
> When CONFIG_FB_SAVAGE_I2C is enabled, savagefb_probe() can build both an
> EDID-derived monspecs.modedb and a modelist from it before later
> failing.
>
> The normal success path frees monspecs.modedb after the initial mode
> selection, but the probe error path only deletes the I2C busses and
> misses the EDID-derived allocations.
>
> Free both the modelist and monspecs.modedb on the failed: unwind path.
>
> Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
> ---
>  drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
> index ac41f8f37589f..c2f79357c8da0 100644
> --- a/drivers/video/fbdev/savage/savagefb_driver.c
> +++ b/drivers/video/fbdev/savage/savagefb_driver.c
> @@ -2322,6 +2322,8 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   failed:
>  #ifdef CONFIG_FB_SAVAGE_I2C
>         savagefb_delete_i2c_busses(info);
> +       fb_destroy_modelist(&info->modelist);
> +       fb_destroy_modedb(info->monspecs.modedb);
>  #endif
>         fb_alloc_cmap(&info->cmap, 0, 0);
>         savage_unmap_video(info);
> --
> 2.50.1 (Apple Git-155)
>
