Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7798FB44B4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0561910F2B0;
	Fri, 24 Apr 2026 06:43:16 +0000 (UTC)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FF9210F2B0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 06:43:14 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-56f8c77ca6aso5073091e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 23:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777012993; x=1777617793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oJXSFX8PKzcLFcm7xTXFNvyUHwCzfrNVzAXd7R67sg=;
 b=ZYPm9Vd6kWow+JYllN1TRiD5abt0FMmvFjvjoDfM7dq+G7Wl4xa0cNAibQ2CNvtbC2
 GiHGsJ05/oT2DUp2JSwO1B6zbdV+0ckDA8efKil1WfU17aJoZloTpLXLLK+p+dlfGawX
 xAMMiAPPgllhHhhvJIh8peBaElz6om83ZAvlSC01QepcVRSMmVMIrLArX9noF2aE1Vus
 9g3WI0s98JcmOEWZAqA7RVu/Okz+HoI9rprmxvXnNMScE4Ardglq93NVUkXFgwcgFKnd
 IkBwk1m0a8wrtRQoBNJXUaLH6Zzd3Oq0XCYUZmPOtNQNZ7HcLqcG4H857bOIBUeyDkt7
 u0lw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IgdZMg8X2xGtvMFLw0YBEMEhEl3tyftUgv8vVx+oakrhQOvzO5FJ7kWhJiQ+UlVFaEsdlVZP+gQI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTNgml0651hhVzMjgss5VOpE271R514Al/44uKmbvjV3ucZPSL
 PFS8K7VBjWg6U4w+o+qENqosM7tMBEzvkdcJLsJ9SUdrS4WZ+pgkpy2g3lmiSTzzrJs=
X-Gm-Gg: AeBDiev31AeRVBBVIP4yQUN3wWmSbGpDyIz0vxT2dJVCxpcGC68e0yLok8Ry8Q7QTAP
 Q7fpxP+vKoQ9XkmK6PFAFyqKJIN25CtMt8BRidALdmO32xToEEGb77oPzR1Kd4lk3BRiCwGppE1
 4e1ZkEAitBn9AyPkswiePeh3CGprBiIQ8UUGChdiOFCmSGAII+lnRZqsMm6EOalpWXwZTZ8nfuW
 WtJxB9PfPpjLys1GZGxEfG2TOmWt04ZKLKOPEhSA56K7DA4xhTmJLVDoge3lKtQGVfvAu7hWgiJ
 WIPHBPTs8ykMTJUXmIEDLlBbyl7p9+gAewDCpGLutXETQUNaLju2ARjKhXszn292xGj0rf56ABA
 5bNTqwgN/3FTZU4TZncMrFMcRjeJfvoab708nd2ryhDy6us0TCaaspylXvx5NZu9x59Sg8l35K8
 LAPshqYgoa2Sow1lBKL/hyjrCXkUCDBdf9/KUsA6aNB1drs5KREX4f7yWVtr2mMMcK7UHjYZkU5
 oYnj521Dw==
X-Received: by 2002:a05:6122:4d0d:b0:56b:5893:d042 with SMTP id
 71dfb90a1353d-56fa5a8ee80mr15756806e0c.12.1777012992892; 
 Thu, 23 Apr 2026 23:43:12 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-958909bd5e4sm10780770241.6.2026.04.23.23.43.12
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 23:43:12 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-60591ade110so5134490137.1
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 23:43:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ81Gn1Al7PbepjB37oZxdDMfWbXM43RLmUvmmdlmwf2aR9AfIuvaQOsonHC1TFvrkeWXpSGo5uKeNE=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3e26:b0:60c:bca6:8198 with SMTP id
 ada2fe7eead31-616f54a0df1mr16521159137.10.1777012992325; Thu, 23 Apr 2026
 23:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260423205531.49971-1-deller@gmx.de>
In-Reply-To: <20260423205531.49971-1-deller@gmx.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2026 08:43:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
X-Gm-Features: AQROBzD-bUctc5D-Bc0eMK2oVZmhH3jTRhq2Qclb0vv_xr_vyYpPVe9rCYI5UQ0
Message-ID: <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Thomas Zimmermann <tzimmermann@suse.de>
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

Hi Helge,

On Thu, 23 Apr 2026 at 23:04, Helge Deller <deller@gmx.de> wrote:
> This item is tagged for beginners, so often people not familiar with
> the fbdev drivers think this is an easy task, start up their AI tools
> and blindly send in the generated code as patches.
>
> The problem:
> - Those patches often introduce bugs, so
> - ideally want the code tested, since ressource misconfigurations

resource

>   often lead to failing drivers
> - The patches are often unnecessary, since in the old machines with the
>   old graphic cards resource conflicts usually don't happen as only one
>   graphic card can be used at a time anyway.
> - and today most relevant drivers have necessary patches already
>   implemented.
>
> So, let's get rid of this todo item and silence the steady stream of
> stupid patches.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

Thanks for your patch!

> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -448,22 +448,6 @@ Contact: Thomas Zimmermann <tzimmermann@suse.de>
>
>  Level: Intermediate
>
> -Request memory regions in all fbdev drivers
> ---------------------------------------------
> -
> -Old/ancient fbdev drivers do not request their memory properly.
> -Go through these drivers and add code to request the memory regions
> -that the driver uses. This requires adding calls to request_mem_region(),
> -pci_request_region() or similar functions. Use helpers for managed cleanup
> -where possible. Problematic areas include hardware that has exclusive ranges
> -like VGA. VGA16fb does not request the range as it is expected.
> -Drivers are pretty bad at doing this and there used to be conflicts among
> -DRM and fbdev drivers. Still, it's the correct thing to do.
> -
> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
> -
> -Level: Starter

I am not really against keeping this item. But as the related changes
are not pure refactorings, and cause a change in behavior, they _must_
be tested on actual hardware.  I guess making that explicit would be a
bit silly (heck, all changes should be tested).  And bumping the level
to intermediate might send the wrong message, too (starters don't need
to test? Doh...)

Thomas: do we still any hardware for which there exist both DRM and
fbdev drivers, and the resource management is missing in the fbdev
drivers?

> -
>  Remove driver dependencies on FB_DEVICE
>  ---------------------------------------
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
