Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDB6C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 10:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15D910E0AB;
	Mon, 14 Sep 2026 10:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MiwHHjjc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2EB10E0AB
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789380841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A+kBrLbXZDXCaO+NKnjivo+lZ1mE9aDypzcLuokSB2w=;
 b=MiwHHjjcZAev7JRclyQGT3iOGSSnUXG+XJVI0khnf+Ebze8UW33pBc0PiRGekESmpytG6B
 1Y9CvWsFVYsUtyulehCbXOy/2I9RHLfy6QleNK2KJsQCURKCC7vN5cjKZ5lyI+Bx585/NR
 MoKtcUTNiVuIDI0PR2vmnLlxshEaeo8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-bCV1H9yZPBuxVqr_RpZmOg-1; Mon, 14 Sep 2026 06:14:00 -0400
X-MC-Unique: bCV1H9yZPBuxVqr_RpZmOg-1
X-Mimecast-MFC-AGG-ID: bCV1H9yZPBuxVqr_RpZmOg_1789380839
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e76a80fe5so12209145e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 03:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789380839; x=1789985639;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A+kBrLbXZDXCaO+NKnjivo+lZ1mE9aDypzcLuokSB2w=;
 b=C7xRzEdF7AjgVwbfoYvp54WttwKtmxsWshb7BtPTxJOE2vWmO1+kYchPa/AEYeVIc9
 ynGSiMyI7//1tODEOc0LAojp+BJki7tfpwkEVSz8/K/ZP8b9xClb05PbVbUAcSXBTtnD
 zCY3k+/37jS/h0pzWT7Yv1kYH4EpkHqJ9h6+/oXy3TpnEv+11AStiLndtU1LFIWsPFRI
 BMNx4UbszkSabzKNT79qzQmgnkejJViMWuN5uSpkQDH120pGV92EB5CL+i8VPI0kLEum
 rruK/gskSosxS25WvB1ObdleXwmnV/UViZUxE721wE7ppcjMJh3Tp0PwM+7D4kf7nlfo
 6OCw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuT+xwQNaq/xz8JBX0c8jpjX8psk6UKXlO8Djn2AQKbJRkOkScwvlbJ2G9H9bQr6qtcYdme9Q/KoQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lLtv0ekwtW96W1uAkU1iBp0wDDx2kF7o/tWzNaO6NGRIwW/qa/
 QS3LjGhf93CSV1lejw6lugICEum2X7LE8O6B6O8lpV/3L/iKBh3ogZ0LHUhCLtE7U2U+MGIe4g5
 /DvRVvxzQVFRKg3nRypLU6bqTg8ouSyinFCIys9OGv7JmkILlpalDJeKI6S0XC10wj9bCwQ==
X-Gm-Gg: AYBFou3qEXx5q5V2GSNlIG9LMDdjasKmybw1+s2VPZ+qbhnYMFWOuU4ofsqJcfoiFlj
 6KP1iV2mWsJZFp691GLyBLlkVNXBQ57se7X0XerfCU9Bb+J/F9h0RuvBDzAJWYmPCJFxV5FT3dF
 kw9Qyso1o44Wl+eqABY5VcTwXavv5VTYjMMVzcZ2RNfhu9OqQ5OQ/NLbIv3BrNvcAeMlDA2UP9a
 eUQKA6p4W+zp8soG72V83e5KDmptTskH6jtsDQjHFPIJfa3QANjfAxR3RcLUzJ1gvV3dUG1m2xY
 SmtG8rEYCVF5ClW0MDXOGdOK54B7ql+qbCsPWyT3nkQGPD6/QL3o3Y4AN+a8bcFP9/BrgOcW0P9
 tMCBLE3Un/3PcXXKUiaHTVtkX+KOcgPWfVdT9KdsqrdqKFFpAvZvHKMHIrg==
X-Received: by 2002:a05:600c:46cd:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49e7a66b2bamr22984885e9.20.1789380838760; 
 Mon, 14 Sep 2026 03:13:58 -0700 (PDT)
X-Received: by 2002:a05:600c:46cd:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49e7a66b2bamr22984415e9.20.1789380838387; 
 Mon, 14 Sep 2026 03:13:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e636f7fa2sm307694265e9.15.2026.09.14.03.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 03:13:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: Re: [PATCH v6 0/6] drm/ssd130x: Add support for the Solomon SSD1351
 OLED controller
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
Date: Mon, 14 Sep 2026 12:13:56 +0200
Message-ID: <87mrtk16or.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HU1StnKcv5BTzPNXYAyEUZ0gJ1ku4Y2kBju0ozXzJVo_1789380839
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
>   - Patches 3 to 5 are preparatory cleanups requested on v3: constify
>     the ssd130x_write_data() 'values' parameter, convert
>     ssd130x_spi_id[] to C99 initializers, and reimplement
>     ssd130x_write_cmd() as a variadic wrapper around
>     ssd130x_write_cmds() so a single loop remains.
>
>   - Patch 6 adds the SSD1351 as a new SSD135X_FAMILY. It gets its own
>     primary plane update/disable, encoder enable and backlight
>     callbacks; only the callbacks with no family-specific logic
>     (ssd133x_primary_plane_atomic_check(), ssd133x_crtc_atomic_check()
>     and ssd130x_encoder_atomic_disable()) are reused as is. It also
>     sends command parameters on the data path, handled in
>     ssd130x_write_cmds() via a new cmd_params_are_data flag; see [2]
>     for why the split lives there rather than in the SPI transport.
>
> Testing:
>
>   - Patches 1, 3, 4, 5 and 6 are tested on an SSD1351.
>   - The SSD1331 RGB565 change (patch 2) was kindly tested by Javier on
>     his SSD1331.
>
> Thanks to Javier, Andy, Krzysztof and Fabio for the reviews.
>
> [1] v5 of this series:
>     https://lore.kernel.org/dri-devel/20260823111959.17029-1-amit.barzilai22@gmail.com
> [2] Command parameter path discussion:
>     https://lore.kernel.org/dri-devel/20260811122603.30773-1-amit.barzilai22@gmail.com
>
> ---
>
> Changes since v5 [1]:
> - Patch 6: move the zero length check to the top of
>   ssd130x_write_cmds() so it guards both command paths, and comment
>   the len == 1 early return.
> - Use the "Assisted-by: LLM" attribution form.
> - Rebased on drm-misc-next.
> - Collect Andy's Reviewed-by on patch 2 and Javier's on patches 4, 5
>   and 6.
>
> Amit Barzilai (6):
>   dt-bindings: display: Add Solomon SSD1351 OLED controller
>   drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
>   drm/ssd130x: Constify ssd130x_write_data() 'values' parameter
>   drm/ssd130x: Replace positional ssd130x_spi_id[] initialization with
>     C99
>   drm/ssd130x: Implement ssd130x_write_cmd() on top of
>     ssd130x_write_cmds()
>   drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
>
>  .../bindings/display/solomon,ssd1351.yaml     |  42 ++
>  drivers/gpu/drm/solomon/ssd130x-spi.c         |  25 +-
>  drivers/gpu/drm/solomon/ssd130x.c             | 421 +++++++++++++++---
>  drivers/gpu/drm/solomon/ssd130x.h             |  10 +-
>  4 files changed, 433 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
>
> base-commit: 766bfba0f3bae329f99b42dcabc3ef11fa368f0b
> -- 
> 2.55.0
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

