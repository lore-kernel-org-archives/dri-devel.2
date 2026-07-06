Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9806C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3076A10E8C3;
	Mon,  6 Jul 2026 10:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GylsO5V8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E05110E281
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783334805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3yUXT8ygGIwRfvHBxKy7x0rY1d4D5PmMqDi5qQR4k0=;
 b=GylsO5V8tgfmiy94a+PlHAq0HeJRRO2BdKLugrEOtAMdPLL2oMRfZ1WiLSriGJjDFeb+M2
 nGdtLA0cprLRFZGW+HBHfZ6wupy6JWs4QyYqaNlIrZelIEi1qjyfouFUNhOjHIvM5iOQV7
 +cy73KqOJQY7LiWi3yGPjGk5NdQr3hU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-McOijZUqOem80QsrGCR4Ew-1; Mon, 06 Jul 2026 06:46:43 -0400
X-MC-Unique: McOijZUqOem80QsrGCR4Ew-1
X-Mimecast-MFC-AGG-ID: McOijZUqOem80QsrGCR4Ew_1783334802
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-493bfc3b84aso12741475e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 03:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334802; x=1783939602;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v3yUXT8ygGIwRfvHBxKy7x0rY1d4D5PmMqDi5qQR4k0=;
 b=tMN8reE9j+zOQUkHixLzIGWHrVoV4ZFsc/mY2AbYtHqvHMX8CWTq2PzivjZgVHcLIA
 1UNMU3cKuCiLmFcldNxxrDKIfkccZ7FIHqmZ6WBsa03zFXTTjSq4EuN/nHsEdmGW+MxI
 iitYFwlLGlBt/XtDFC5y1RjJkaqjAZBagSZPtlpFMakZ1aLORmeiIfjcNs5ux7nlP5vk
 dXz2xfdK55ftdeLGGFn/8HTRguOYmo+XSq24J4n90XV0e5bVjLzBlSUpYR98W1t0HNgy
 dso51EIMWASdfDSO3bdIYpgOdvIqq/biyltNCJ1S55F+zUkBPZxZ7iFTkgeEkCf1wK9h
 yOhA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9q9riMPz5Bivki9wSRwDTJCFBMNCP+kBfykhVKCW6tLC3qWRiYRjjvDY2sZ3AXUfYAG5T7lBFL78=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYOUTfvvnwkG0uCbb1uHG8is4p+v4scLiDU/60LEbQR5l4YMe8
 zXOmxGLP23SKhLBznOKE7ryy5Y8FZ8Msg9Fv2KE0xbfumiClD/iLyfRbIN0MdEa77yqELkuO2wy
 wWri60YWjao1CLMyCANPHUh073lYGP0yl9zruPoeMW/0aqLYx3ROdQW2GYjOoIpj+xR0fuyaGuc
 gBlQ==
X-Gm-Gg: AfdE7cn4cJdBJgOO/hLBL5LdOnU4hQF1typtAKgcksJmhWoc+UlDt8Gnvj1m/nKfZ1b
 YOz/r0o23TF+AduBYkMnPTF91/G8oJ5OTphkyb0w7jE1kU3emYTeuWk3y4qDONDGzqasCsJ+bYM
 UBF/vUfP7Giu75hutbmD3uleE18VoIIqk+c5BQpKxt32kP2WMRhHeA2uJqMWNBLrjPgjw5l/ciS
 eVi1DNJNTfFgatWaa/aQoVAWM+ZVyLW6UpeCKP6Pa1PYZK1+LPruWirf7R7sAc/AwmGUhTk6BBG
 RbKnrfUS4tBpuaCRuw2lzQAvMyqF+YblC5YosamqgWDGkEYetHJBiCfKJQLE40N2PO+S/AGBpp7
 0oeSDnCysY0WCU+wv3UyHvDjA7f+SWQmNh43scG1bLdC2Jr93NS4lU8t7VHfqq/jpn5XxqQ==
X-Received: by 2002:a05:600c:8b17:b0:493:bdaf:83a7 with SMTP id
 5b1f17b1804b1-493d11f8c55mr115690225e9.28.1783334802403; 
 Mon, 06 Jul 2026 03:46:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8b17:b0:493:bdaf:83a7 with SMTP id
 5b1f17b1804b1-493d11f8c55mr115689945e9.28.1783334801980; 
 Mon, 06 Jul 2026 03:46:41 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b126sm23234060f8f.24.2026.07.06.03.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:46:41 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH v3 0/3] drm/ssd130x: Add support for the Solomon SSD1351
 OLED controller
In-Reply-To: <20260704080925.75113-1-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
Date: Mon, 06 Jul 2026 12:46:40 +0200
Message-ID: <87v7asbdkf.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 27xZzSdyBus5AznbBHOjlTRPWfZe-TNkbuQgaMwn4yw_1783334802
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

Hello Amit,

> This series adds support for the Solomon SSD1351, a 128x128 65k-color
> RGB OLED controller, to the ssd130x DRM driver:
>
>   - Patch 1 adds the device tree binding.
>
>   - Patch 2 switches the SSD133X family from RGB332 to RGB565, bringing
>     65k color to the SSD1331.
>
>   - Patch 3 adds the SSD1351 as a new SSD135X_FAMILY, reusing the
>     SSD133X plane/CRTC and blit/clear helpers. The only data-path
>     difference is the explicit Write RAM command (0x5c) the SSD1351
>     needs before pixel data; it also gets its own init sequence.
>

Great, this approach looks correct to me now. I'll review this series but
likely will do it in a few days.

> Testing:
>
>   - The SSD1351 (patches 1 and 3) is tested on hardware.
>   - The SSD1331 RGB565 change (patch 2) is compile-tested only; I do not
>     currently have a working SSD1331 panel. Javier has kindly offered to
>     test it on his SSD1331.
>
> Dependency:
>
>   The SSD1351 reuses ssd133x_update_rect(), which programs the column
>   and row *end* address as a relative offset rather than an absolute
>   coordinate. This breaks partial updates that do not start at (0,0). A
>   separate fix is posted at [2]; until it lands, the SSD1351 shows the
>   same partial-redraw artifacts. This series applies independently of
>   that fix, but the two are best merged together.

I just pushed this series to drm-misc-next, please rebase on top of that
when posting a new version.

>
> Backlight:
>
>   While adding the SSD1351 I noticed that the shared backlight path
>   (ssd130x_update_bl()) is only correct for the SSD130X and SSD132X
>   families, where 0x81 is the contrast command. On the SSD133X, 0x81 is
>   "Set Contrast for Color A", so brightness changes shift the color
>   balance rather than dim the panel. On the SSD1351, 0x81 is not
>   implemented at all and the brightness byte itself would be executed
>   as a command opcode (e.g. 0xae is Display OFF). This series therefore
>   does not register a backlight device for the SSD135X family. I plan a
>   follow-up making the backlight path family-aware (scaling
>   0x81/0x82/0x83 together for SSD133X, 0xc1 contrast A/B/C for
>   SSD135X), which would also fix the existing SSD1331 behavior. Happy
>   to reorder if you would prefer that rework to land first.
>

Oh, interesting. I think your call is the right one here and this
backlight logic fix / rework can be done as a follow-up series.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

