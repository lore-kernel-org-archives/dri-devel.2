Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936AFC44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047FB10E427;
	Fri, 17 Jul 2026 10:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SxwyDjuM";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DEF10E427
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:46:24 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5b01146b205so5567784e87.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 03:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784285183; cv=none;
 d=google.com; s=arc-20260327;
 b=lvFe8aHDnD4cFK0T3Dy6HV+sn+X+mXJz2p6KAjmSVDSpLEEfb5AUals7HdDmZAVYRx
 QlCsrbhqwNHOEx/MUpN0xGVAqtnDKC4I4knWnFy1HlwrA2cDW8WUaFRImO7o4DxUv5sR
 7ekDz3lPGd2i6JZ6Q59LIQAyrbFhoU4p3I0BWcBDA3lDRWG2n3Rsn+Y03sco9tEDVisV
 wNoxDqIn3Rv+7chmrVCR54ETCwZTyGJRQ3ZOJMaaBtAcpD0gNmpD2M0cE9Ba8enaebL+
 Hi9CUHTRIpgOMUqhcuVInx4U5zGzDygyj+cyERuqetR5I+pHYyB6JiaaNMvAhNf1jaj6
 zAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YHbZnUgfhySQwLZmZxFG4/4tCoDafXP3bzmxOBvVJ8o=;
 fh=WPdTBFEKs0vFjbrFegYXS1FuS3VesTcjYiSpkHYhSsM=;
 b=seBL/Xctk1ZAHCdP92jjBBP4iiesR5GUZWC1nP/t5UbnB4lNA2kzbTZyesB4KEPd0e
 mvMMYSsWYFVkvTQNBfQR4GmlgQOhZFJDAm165PLULSvqsBu8JcK0b/ge8sbAWOwo8JJN
 YsRnCD55xZ0f4+MFlJ8pTcDlEuHd+TRbf3Umw3f5sLZ/cxBRCjGCiY9pKtXRyDjrWo+e
 bdyezTn0JLTxgS6NJy27knAyZxB+g/5vQGxxMk/UjVp5eJZdlRd8AcdFtRo9Anz7DHR1
 zWdjPgPgS7WDa4ebGpuZeOm1aJA9Fg+NkeMiXctRbtOLpOQGBuU7u/CLUAl1a6arYwCp
 +3kg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784285183; x=1784889983; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YHbZnUgfhySQwLZmZxFG4/4tCoDafXP3bzmxOBvVJ8o=;
 b=SxwyDjuMfDxkb4GmmafBISECHGjC28UeeidivOv/POvMEQo1xRNvYL+K7T4l3nQ1W8
 F+oGaGvfvxs+W45F31JkbkV/pd8FQdE5bcn+wdr8HfxX1oygYc5Xw4dlDID/9kawTZVV
 ERBNvt+FTa4zS8KDKj1pJZtgdhOxKRDIphcVptKBIZQXLcdXx1RvqfZXnoOc0JSRzOgJ
 +jQQbOZlgs72/Y/B5WPEIwNBPm7RsGrHBdQ1HEhdkFbeOfKt44MzrM3vS69NHJ2QqNDs
 sChyHTyEyFLxIVi6D4XeQQRK1JmYCLpA2mDHfuwhcmKs3xYWG+C9U/wSbBmdNQDTCI+S
 AGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784285183; x=1784889983;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YHbZnUgfhySQwLZmZxFG4/4tCoDafXP3bzmxOBvVJ8o=;
 b=T2m2MunlFxrMTH0HctC1df9oACxM3SCKv0Foor1/raH2ePU7FjyVNocJeo2SS4QiHb
 LR1S6hUN6763YULtiBGpY0LceZ7zgXSA/mcHXjES5nqh/gcN7FqoE1YZPnB1wt3zc/e7
 XNSqlgNAUdcZSjss/3URBBDOAarIev6jKOabAcit5TLRUdtENbk3qKsLzgbOQXEKpyvo
 qMXjwSghFGfZxntLS2V9CKeSVydW+VVlcZZI+xSbhHF5Btb3/Tvh3NL37KB0OVybRrOO
 iGNE8r1cBG4lyeZItTYigPaQhovgS6xE6/75RbGmy87P20WE0CszJAQXlG4R2M9PzGat
 xNIA==
X-Gm-Message-State: AOJu0YxFQtDK8KdVc4dCDZLGw1fwP85eydJcM+bUWTuHCP/RF2O/b1wM
 D3QE/f1h6YmvYKTYzUscP+9I7NBuFXsvlGIj+bW5ojmBpky+w96Yc/dFS2C3qbvbKEdqVbor09n
 O/9zoqAS0fYEZCcqZSsatX6FQLprfVH4=
X-Gm-Gg: AfdE7clhAVnUIkie9i1kSZWQJ/aJLVkDUMZ9vNANaVRJNIfyte4+XOchK9JpT/uR4Xp
 OoaKbyqGirqDRe8kgAjLu1BrCJ8xCM1RT0uVBi34sVY2c3WUcg3xrknwcMQgXLM9F1AyjlxzEUP
 GW1o3BAKpEA21g+oxfDkvQNPKOtPquE/pe4vPdMbwWmv+p6+mSt3iHcCPLQtNUWxPEV6XWwxVim
 3VgYULYOPM6VzVbtXg/l71g/d13nqYEV/Jp/nQ25tKF8yfMaL8c7u9/2jIQWkIqidpzNr2J8m/I
 voZb1i7LsozzDU2zziwIFyTZ8Ib6hBrz3jh1nEG/N2bqUDvefv3N/hkAiQKYB55l5bOnpLYBLvj
 Y9S4p
X-Received: by 2002:ac2:51cf:0:b0:5ae:b136:acdc with SMTP id
 2adb3069b0e04-5b28f9a589emr536086e87.35.1784285182682; Fri, 17 Jul 2026
 03:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
 <20260714101146.200416-3-kieweg.leander@gmail.com>
 <d817d031-6ef2-4909-81cb-a9d417550dd8@suse.de>
In-Reply-To: <d817d031-6ef2-4909-81cb-a9d417550dd8@suse.de>
From: Leander Kieweg <kieweg.leander@gmail.com>
Date: Fri, 17 Jul 2026 12:46:09 +0200
X-Gm-Features: AUfX_mw8ch0ZGElQgNP-r5TJUFlhtJZKGB1M8n9Xm63PvlrnxX6RSRURqwTyDwk
Message-ID: <CAMwcS0h--iZtjVZUeeHmoV4MngfW_f9auAseBDhqXMGc_zqVqg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drm/glanda: Add initial DRM driver for GlandaGPU
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
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

Hi Thomas,

Thanks for the detailed review, going through each point:

> Please use drm_device.dev instead.

Will drop this field and use gdev->drm.dev everywhere instead.

> Synchronization happens with drm_gem_fb_begin_cpu_access(). No need to
> take the lock here.
>
> > +     ret = drm_gem_shmem_vmap_locked(shmem, &map);
>
> This vmap should not happen here, but in begin_fb_access.  We have
> helpers that set up the mapping for your driver. Take a look at
> DRM_GEM_SHADOW_PLANE_HELPER_FUNCS and DRM_GEM_SHADOW_PLANE_FUNCS and the
> drivers that use them.

I wasn't aware these helpers existed, this looks like exactly the
right fit for what I'm doing (software render into shmem, blit into
hardware VRAM on flip). I'll switch to
DRM_GEM_SHADOW_PLANE_HELPER_FUNCS/DRM_GEM_SHADOW_PLANE_FUNCS and drop
the manual dma_resv_lock/vmap_locked handling entirely for v2.

> That's confusing. Each pixel is 32 bit. But each color channel is only 4
> bit. So there's a 20-bit hole in each pixel, right?   Why don't you use
> 16 bit per pixel?

You're right that it's wasteful as-is. One thing worth mentioning
though, my VRAM write port on the hardware side is a fixed 32-bit
Avalon-MM slave without byteenable support. The hardware itself
always reads the lower 12 bits and ignores the rest, so that part is
fine regardless of write width, but I'm not certain the interconnect
would reliably place a 16-bit write into the lower half of the
32-bit word rather than, say, the upper half depending on address
alignment, without byteenable support to make that explicit.

I'm already planning to update the hardware to accept XRGB8888
natively, which will need the full 32-bit width regardless and
removes the CPU-side pixel conversion entirely, so I'll leave this
as a 32-bit write for now and address it as part of that hardware
change rather than adding byteenable support for what would only be
a temporary fix.

> I don't think it is possible that new_state is NULL.

I'll drop the redundant check.

> No need for this function. drm_gem_fb_create_with_dirty() is exactly
> what you're looking for.

Thanks, I'll drop glanda_fb_create()/glanda_fb_funcs and just assign
drm_gem_fb_create_with_dirty directly.

> Drop these ioctls entirely. As I outlined in my reply to the cover
> letter, these will not work with DRM as they are now. Especially since
> you're using gem-shmem as a shadow buffer. All your rendering happens in
> system memory in user space in software.

Agreed, as mentioned in my reply to the cover letter, these are gone
in v2.

> This function is going away. You can open-code it instead.

Will do, thanks for the heads up.

I'll include all of this in v2 along with what we discussed on the
cover letter thread. Thanks again for the thorough review.

Best regards,
Leander
