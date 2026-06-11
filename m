Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA93CD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:44:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F89510EDEF;
	Thu, 11 Jun 2026 09:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ctnpouTD";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6335B10EDA5
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1SIia4HOnRnNxMuugCZfZvhfm+zstNHW2PddKrs89mY=;
 b=ctnpouTD4SpVtLtaceUBxsvaxVk/L0kpI016u1/ArXgAz6sHbEKB4fQcXBsIS4CePsL6Pn
 e436ZW1bwOL+ILgDi5JCHqvg5aWlqBlIpYf2N1ticYAO4sYIYihXCtyiqiGWsQTiXunhqU
 JGyArJAgen0ossMXT2ee4eyQPmSNw3I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-DAsAuOf2PGmShaRZeahbTw-1; Thu, 11 Jun 2026 05:44:34 -0400
X-MC-Unique: DAsAuOf2PGmShaRZeahbTw-1
X-Mimecast-MFC-AGG-ID: DAsAuOf2PGmShaRZeahbTw_1781171073
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45efb6e60e4so6615971f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 02:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171073; x=1781775873;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SIia4HOnRnNxMuugCZfZvhfm+zstNHW2PddKrs89mY=;
 b=dzM/U1l5fEFtW+JFn9FVOUMzVAyIRLjY9elfeVe9aPsoYPpSaxLxGhrPG+hjzVNk6I
 MpkDTsp7HoFlDVqxG5UkGN7QK6pHVlBJRhd9rca+oZJUAdMrHgCfF4kfDYJO4MBLNHJu
 r8cx684BlxFAartWSj8tN49AizaUQ8APa9XmGbhZbHLOIPQqEYUbItlYfgYntzxmfvIV
 LWOz6xPeUq2WkJHrK/BOFo+I66Kb3BeO0yCc8ei/o7sdhqOHQbQxMvXAv32xxnsdo65f
 wuf95nSfuMR+WdOOOAJSIqqMW2EyJ7lpT8KW3Dberou9bcFmztHbwJbJKwJ8p1Uq8hxO
 0xYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u/RnfS4eEKZojlRkIZDNRr20ZzBn1O2fnMazW7jCpjJPe6uicaVlssD9MI/J6dCzgCjPDK8KmxrM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy08UC1qRDaEb+k+YwLQNtB82gOFEea/QhEDMa0DTTm/mk9B2ta
 RY1YLvcbI/j/IhOpYebKGFcJTbOrCnp5xbynJEqEn5aMxaJvxefLOMajrqTDT3A/yRSDF53VhNf
 34lgMpkd1Zr1UrtTAquMuomJY4/DUNdGlqntjatOFx79epniYkwTyC4GKdnhDWW5c7sOi6w==
X-Gm-Gg: Acq92OFwtp4BpU7USR/FeMSFMiLSTlo9LGJJbXa+eF3sKwcRGTUrK+6XF3bKlT05rj1
 QP25QEPC6eX4L1DApAXpO8S0VPAENAJtL7qrxs4hSedZnLp+k53C+3tTFw/IdThfujECJ+Rxfit
 //AjknzA5+/EzVma63gk0nYvnFSwAzaVlyrt3rVNZX5YnBMyrQgILJcjBwrVjgPvJKOcQsqkzpK
 iYGk+fY306W6nFRCzOoWz2TSsZ10cUY2Qu8edtuUVgyBh8pZNuRvUL1GCroL0UWtV6029nQOzmX
 joWg+cl0pqAq15sNVnYk8t28XjG+pQ+uLIaQ8cyi2KBX4bFeP60EUTCA7F25MEI1WGZ1nnXtnxM
 axESBESw4zL4w+J8DLt1eWRZwRR1xSvvYOvJpw2grRozv/zQZXot8sVwgebXhFPdh+6V5dbFOVr
 naw01Ewm6nMD1Zx2Q=
X-Received: by 2002:a05:6000:461e:b0:460:662d:e686 with SMTP id
 ffacd0b85a97d-46067599390mr3308754f8f.13.1781171072695; 
 Thu, 11 Jun 2026 02:44:32 -0700 (PDT)
X-Received: by 2002:a05:6000:461e:b0:460:662d:e686 with SMTP id
 ffacd0b85a97d-46067599390mr3308709f8f.13.1781171072292; 
 Thu, 11 Jun 2026 02:44:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm82178555f8f.13.2026.06.11.02.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:44:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 0/2] drm: Add driver for the Solomon SSD1351 OLED
 controller
In-Reply-To: <20260610164428.180091-1-amit.barzilai22@gmail.com>
References: <20260610164428.180091-1-amit.barzilai22@gmail.com>
Date: Thu, 11 Jun 2026 11:44:30 +0200
Message-ID: <877bo576o1.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kC2caeDWjoua1Q7g1RtLezAbJBigqEAUJF9JXLzPdXY_1781171073
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

Thanks for your patches.

> This series adds a new DRM/KMS driver for the Solomon SSD1351, a 128x128
> 65k-color RGB OLED controller driven over a 4-wire SPI bus. The SSD1351
> currently has no DRM driver; the only in-tree support is the legacy fbtft
> fb_ssd1351.
>
> The driver advertises XRGB8888 to userspace and converts to big-endian
> RGB565 on flush via drm_fb_xrgb8888_to_rgb565be(), building on the GEM
> SHMEM and atomic modeset/shadow-plane helpers with damage-clipped partial
> updates.
>
> The SSD1351 is implemented as a standalone driver rather than as part of
> ssd130x. ssd130x converts XRGB8888 down to a packed <= 8bpp hardware
> format (mono, grayscale, or 256-colour RGB332); the SSD1351 is driven in
> its native 65k-colour RGB565 and does not fit that pixel pipeline.
>

I think that makes more sense to have the SSD1351 support as a part of the
ssd130x driver, rather than as a separate one. There is already support for
SSD133X in ssd130x and this family also supports the same 65k format than
used by SSD1351.

The correct approach in my opinion to add SSD1351 support is as follows:

1) Add support for 65k (DRM_FORMAT_RGB565) for the SSD133X_FAMILY.

2) Add support for the SSD135X_FAMILY with DRM_FORMAT_RGB565.

3) Optionally add support for the 256k color format to SSD135X_FAMILY
   but I don't think there's a native fourcc code for this. So likely
   you will need to do a XRGB8888 to native 256k format conversion.

By doing this way, not only SSD1351 will be supported by ssd130x but also
you could make the existing SSD133X support to use the 65k color depth.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

