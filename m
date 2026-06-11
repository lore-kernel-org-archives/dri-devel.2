Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB4ECD98D4
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2E010EDFA;
	Thu, 11 Jun 2026 10:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="HicNd6JZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B5BA10EDEC
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
 b=HicNd6JZir8vw4Eq455JYwYL+pMz2TlhhlTk83uOYYtOCT86RfNRcsjVRuXwQ8QClvWnHQ
 Jvi0FQKhz4eXrunUZHYXiPTZkEozSxM19l9e1DSH/FZT3j1+ncRdE56+dH76Yr+twKcKTC
 XdEg1kFj4b03KnEmhObJSTgcksC6DQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-1WIjDIEkNZuZi5rfpKTdvw-1; Thu, 11 Jun 2026 06:11:28 -0400
X-MC-Unique: 1WIjDIEkNZuZi5rfpKTdvw-1
X-Mimecast-MFC-AGG-ID: 1WIjDIEkNZuZi5rfpKTdvw_1781172687
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460198535bcso5015262f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172687; x=1781777487;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
 b=ChhuV29x1TbSuIMQTKFVds6LHPo/BJULxuJkzbAlY5iUQq+ZWTFq1TBay4MeEBmF0p
 Jdi7y+kMmJruy1MbUHUiCqJu7vJ+Vuk6C7MlbPS0QbCs/HX0KtQu7OJXSF7RU57/KwBh
 sw7zXrLgDfP8bgIB9PJ6KEQOqaZfNqT1qzkLUe4QXBomsp/MKMx5q/iD5sMYzwUFIZuL
 WlMRlw8hMeVYGmUkL3Qij1PpcNalpsAMs4mj47R6aCYHgvhONBySwX1XTy2+H2gDfebh
 Xo5xdnPXhp5XE+v4crMo3STDusDhPY6HHSz/eLlruzr6tufnVoFfwajnSP9J9M2z/fSl
 lM5Q==
X-Gm-Message-State: AOJu0YxlfqsE1J9rCmYTZXX6wRtn0NqjVw+wGxPEmILqwISaIVqXHUeQ
 aJG6P6sJgVF1XqclIJmV7zAzxIES5XIv2dto43zY9a0oTUsMZFiG+kARGfM/utWW2lcx4FfskX1
 X9opl2mU6T5s7aaZTKiDIKOrOMb/4DW98WMc2LQo9si0JOUuQQue37Fm+jXYBZQxdbA3Lpw==
X-Gm-Gg: Acq92OHIynHy2E7/SBXabgWeNb8bINoDxQ0de7fq4B9qh4/COXJux+bk101c0nsTDEA
 NCu2QQ9uoqDCR7uI3j4sMtpfH99iwXbV9Zo+VT9rflJaPWTbI7ceV2AGMEkzsF2IZIzIOsS9hcI
 RxE8SPVUAa+7muJcDhfTxa9vdIdOQd3SqQEKR5xrXkVRlsN6a4+/bMeVXRAmksSmMtQ0fxXae65
 tbrYWBSWl239tZynw5GUoGXFV9dyFu6Wa9jKSzjCEjNNS83DdtgR9zxw3pF7J1qDdF5Y1n7Gmwy
 p0Mohv0Nu0BZ5L5VeTfgKr2gbsUMScehKLVphlOwpGldlEcepKmfxOOxZRcFMj8rJ6FbTiDfTlD
 oNoIo4KXGxmo8k9c25sjJIge7lL9oyedbUbY75zcvMW6ROvc2xDS+71yq43t+3UbBqGr9no7Ry0
 rfimCdnn+thS2DLCk=
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id
 ffacd0b85a97d-460677b28camr2150192f8f.40.1781172687244; 
 Thu, 11 Jun 2026 03:11:27 -0700 (PDT)
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id
 ffacd0b85a97d-460677b28camr2150129f8f.40.1781172686816; 
 Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4b18sm63288157f8f.10.2026.06.11.03.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v5 02/15] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-3-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-3-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:11:25 +0200
Message-ID: <87v7bp5quq.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7z1kMKDkC60HW2uE-gK47brdamJWjhlfh5Fb766HPdA_1781172687
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

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update. Commit 35ed38d58257 ("drm: Allow
> drivers to indicate the damage helpers to ignore damage clips") introduced
> ignore_damage_clips to selectively ignore damage clipping in certain
> framebuffer changes.
>
> The i915 driver does not modify the flag, but DRM's damage iterator
> will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
> right before drm_atomic_helper_damage_merged() guarantees that it
> has the correct state. The i915 driver does not do this elsewhere
> so far.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Same comment here than for patch #1. I don't think this is a fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

