Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44FACD98D6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162C710EE10;
	Thu, 11 Jun 2026 10:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ieBjdwc6";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE2810EE00
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781172732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
 b=ieBjdwc6wqKBKPFZy30ARGnn3RTFJF5UQ2IyUD8GOP5OQN2DTP5LetZeRvW3CiRx3KPMWj
 NWajnAil7BUrqFTeUpZkgu20ogPiEM7IFGNrMcK5W3hxymlyim8/MBTpzCAiH5Ey5NHO69
 RmPVZQGOCYzDzm2qk1rW/Ciw7TLo0qU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-o59iPzfhOOi3O8_I0DgbHQ-1; Thu, 11 Jun 2026 06:12:09 -0400
X-MC-Unique: o59iPzfhOOi3O8_I0DgbHQ-1
X-Mimecast-MFC-AGG-ID: o59iPzfhOOi3O8_I0DgbHQ_1781172728
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a060eb84so49692835e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 03:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781172728; x=1781777528;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
 b=gYNlZg3vDm04RGLJyAhTDhB5C39FByXR3ll01DsGRm91Qsx3SQUAW62xz6MItm8k0e
 8rLOxy3GT7RplOwo/AoNsu9V30ULuUNJkn8i9YJKXvmePdXF3GPyB4yn38ETJ1WvqSBb
 ihqLuyPvD7p04p/rXYtEbD2o7AmsW0ykr43bdx3KEyKRpHS4XjBU5hivKaB3JQD4EMus
 CwLIBjXvMZBZ3r+dD9V+wnDHFxCQ4xPymXleV3SoyTQBO1pIybYEYfCZhNZGeFmez1ew
 sUjkbk/Y/1DyNeL64KeseJdKW3RMNcWMtogj2x/roOUceDd1VuEm/neFiwfuDbut4vc6
 ljaA==
X-Gm-Message-State: AOJu0Ywnelx/Hn+edR8WWBfqLYW5d89bwaalhn5XiJyr//SkybYOqSwI
 CC67LtB6t5c2d1izVsUf10bEuLzVZYxkalrY5ukfoSBfnzguaDyqAFqMAYSLP89grjFDezxGAM8
 2W198HCfFE4H2IwUXbLDmHwzPgwtKVHMWLZZDGSft2uRnl2XuFvkFKdE13fz9i7tLcnJQ2w==
X-Gm-Gg: Acq92OGMT8QWqI3imyztCtEC35G6Dw2tjdXSFwC52sMi5QrM+HMpk3ykIEbf38TUUuD
 Jmyj2s/+l9iBGlJkuHyxmmQEiteYjhN0pdrAM+SxMKvOsohanCX9gWVETUmG8p7azWhY8GBVsax
 Wb1oEhS1AYVjWf3YHvQxNwvn8ve4uR2rc4Ar1RRp1SUaxYOJ2RHIX+7dr/KZHYofIOZhhQD/y1t
 XJIBdwZRQRWZy9lEqKMTodG2e+KjVVQ8Ulmp4CvXXn6nv+tBm9INFzyoIc46uj3MdenpzOK0RHt
 6RTUeNMp/UCspY2bYWFHwXYvteiGDFZr8v0CZIo0f7+ZNqlHEnYutRvDy7OBXkpZAdZMK9TzpUr
 9QKkKNdViQY3HQ6kWeRIJFZe+drOWVXFMpzfwCho9aTuW232bHKfqgw/l561gY5DR0mfaj4T+NF
 643kZGPuyw2TQjzcg=
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id
 5b1f17b1804b1-490e5607e3cmr15876055e9.26.1781172728112; 
 Thu, 11 Jun 2026 03:12:08 -0700 (PDT)
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id
 5b1f17b1804b1-490e5607e3cmr15875655e9.26.1781172727683; 
 Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d09a85sm51975965e9.14.2026.06.11.03.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
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
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/15] drm/vboxvideo: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-4-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-4-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:06 +0200
Message-ID: <87se6t5qtl.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bWHVZcL3SIznDE6Ez1yvmwNbspZbynZ2lT3JJHLuwLo_1781172728
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
> will then do a full display update.
>
> Test the flag in the primary plane's atomic_update and do a full update
> if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vboxvideo does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> While at it, also replace uint32_t with the preferred u32.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

And for this one as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

