Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A167FCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038D410E647;
	Tue, 16 Jun 2026 08:55:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="McZHolCG";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5C0010E647
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 08:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781600139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mAyn5kESksTVfnvqgVzJ356M4lj5kuXhDk0e0cXq2jQ=;
 b=McZHolCGsMFk5qu5/iM0IQO9X+IzQg+/3Q0UQzlKEi2CD06QmW6qIhU9uOqcqRDvhEHimK
 mfY1Lp0ZI0k9o/0q7ERnd9Zpj33aJsUyVo0zb05FrgXChw9qUm6hgI2OpXY4zI09xmeOvm
 rCOjFkOPInYvLls7foMwBEbLxSoVsUk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-c_TU-RRgOAandjODOpiknw-1; Tue, 16 Jun 2026 04:55:36 -0400
X-MC-Unique: c_TU-RRgOAandjODOpiknw-1
X-Mimecast-MFC-AGG-ID: c_TU-RRgOAandjODOpiknw_1781600135
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b3ec3f7fso27841205e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781600135; x=1782204935;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mAyn5kESksTVfnvqgVzJ356M4lj5kuXhDk0e0cXq2jQ=;
 b=D1GXcsWAdRwpRQ0cvrAH/lg7HZG8iTfNwcwbHUUMm/H9m6qhAy1ESIT2EMqLWHYeXG
 LaGvyrBwYWyQe/5TlagAnF+jr/oi9sVzvwiX9Bi2k4WpEy5zkou5wYtWS5J0D1WhPQ6l
 0ghUkF+8Hs67nAz0NIDuZuY8RwFPUhulyCUQC+bKaXEoCjoe1Lo1T6gFyMePyvP0HJXT
 /sAm1/WvcgwFsbQZx4VO+xlA0XOHd/lKOhtU6m6ALl1XE/Q5gfwN5PvrYFgOz+dNgr4e
 oNo2w1TO2BCTtCCSyUik+H/Jdo/9d7LdVgXQup7IcJhDxI5OQtZwCg2OrM1xtA65XT9p
 qMjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vbkTvc7c4+M17or3cDMD5F97oYI84Mr/FNSr02qyN6gXc75eLKqf+7g9hgDsPilXACdoZgsY3bAw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi0TiB7/PZgzxmUb854Y68eLdQ6L1wZ76r7l+rXFcmyWA2lti7
 +v4k5ymDA3SHRPXJQFh4U1j50GYh/j+CsAmHRJbGFvGZiogDZkGGNAb559wsRH0yY2hBDs/TRNE
 LzX8A4fKkBF1lvPo+vi0Wd1NWy78k9U7hnZiL2/wFKF7GJ6UgwUyngQ2UQHmjMiWzrJIiL6bVop
 Blfg==
X-Gm-Gg: Acq92OFt5WLq0Mof67A9uR9wFaJcw6LKZu2nPr2uq3l9kdEcBrALFHzWNV3qVVOsPMz
 0xjGcEzUR3hoxHRhizSEmOCS8mi8ckAsrbrc6hWpBW0N4FmLSWMiN/2tya6WvPyVbMynrpVPxAT
 S1cIJtHavQ3BYDvg07O/RUuh6uD8zWNjQ6p++DNFJPW6bB+Q1EdX240ZCc4J3Gln2Be+nzzr4qE
 VGqQTFZEVbLPiFlCuPkae25QY9TYjRk/9w2c7eyNo2UC4H/ZDE1z2rfv2ULU0567ZWMuGRb9EPX
 5whqU+01vUI/Oewxexwt2uch5Z1So9eR3cWt1hX+5bjYh124Is6deinYzzBYr4XvtoYbDVCRt3L
 voKqM2WypzkESOLNiy0uWxl7tjzW11WU56ViH5dJNvh3wBukW5tK7iAjE4XiXM2LZ5y3QbmCOOD
 awrAlg
X-Received: by 2002:a05:600c:6812:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-4922ffb7525mr40889405e9.26.1781600135008; 
 Tue, 16 Jun 2026 01:55:35 -0700 (PDT)
X-Received: by 2002:a05:600c:6812:b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-4922ffb7525mr40888885e9.26.1781600134534; 
 Tue, 16 Jun 2026 01:55:34 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f450sm46481919f8f.10.2026.06.16.01.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 01:55:33 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>
Cc: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de,
 Alberto Ruiz <aruiz@redhat.com>
Subject: Re: [PATCH 0/2] drm: Add driver for the Solomon SSD1351 OLED
 controller
In-Reply-To: <20260615181253.97551-1-amit.barzilai22@gmail.com>
References: <20260615181253.97551-1-amit.barzilai22@gmail.com>
Date: Tue, 16 Jun 2026 10:55:32 +0200
Message-ID: <87cxxqzwxn.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZpaQB8kmO4N0jqKP6ta3FjRRTr2l9dodKvy0_CDKqNE_1781600135
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

> Hi Javier,
>
> Thanks you for the detailed review and for the Reviewed-by on the binding.
>

You are welcome.

> I agree with folding the SSD1351 into ssd130x rather than keeping it
> standalone. My plan for the v2 driver series follows your two steps:
>
>   1. Add RGB565 support to the existing SSD133X family (so the SSD1331 gains
>      65k color), gating the format on a per-variant flag in device_info so the
>      existing RGB332 path is untouched.
>   2. Add a new SSD135X family for the SSD1351 on top of that, reusing the
>      ssd133x data path (the update_rect window logic is already
>      format-agnostic) and adding only the SSD1351-specific bits - the 0x5c
>      write-RAM command and its init sequence.
>

These make sense to me.

> I'm deferring step 3 (native 256k color) for now since, as you suspected, 
> there's no matching DRM fourcc, and I'm dropping the 0/180 rotation support
> to keep the series focused; it can come back later.
>

This also makes sense. Having 256k color support is nice to have, but so was
65k color for SSD1331, that didn't prevent me to add support for that family.

> Two things I'd like to confirm before I send the series:
>
>   - I have an SSD1331 panel, but it is currently unsoldered and I don't have
>     the means to solder it myself. I'm trying to arrange testing through
>     someone else - I can't promise it will work out. If it doesn't, the
>     SSD1331 RGB565 change would be compile-tested only (I do have SSD1351
>     hardware to test the new family). Is compile-tested-only acceptable for
>     the SSD1331 part, or would you prefer I hold that piece until it can be
>     verified on hardware?

That's OK. I've a SSD1331 that I used to test the SSD130X support when I was
working on it. So I can test your SSD1331 changes without any problem.

>   - Could you confirm the RGB565 byte order the SSD1331 expects? The
>     standalone SSD1351 code used big-endian (drm_fb_xrgb8888_to_rgb565be);
>     I want the shared conversion helper to match the SSD1331 datasheet.
>

If I read the SSD1331 data sheet correctly I see that it support different 65k
formats but it does support the same 64k color depth format than the SSD1351.

Only supporting that variant is totally fine so that you could reuse it for 
both chip families.

> Separately, I've sent the DT binding as a standalone v2. Since I dropped the
> width/height and rotation properties per Krzysztof's review, I did not carry
> your Reviewed-by forward - please re-review at your convenience.
>

Yes, that looks good to me. I already gave it my r-b again.

BTW, I just added some cleanup patches from Alberto that simplify how the driver
send multiple commands. Please base your v2 on drm-misc-next branch to ensure it 
does not conflict with your changes.

> Thanks,
> Amit
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

