Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B0CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DFEA10EB68;
	Mon, 28 Sep 2026 18:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hANFZopc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B357310EB5F
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790619032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFTht72VGYwnHy4rRuIiS5N5orHNND6LgvZVdS8G2Q0=;
 b=hANFZopcyLedUQhKEQkdBlYiherp/C3nUQ747CxrT374lOZGGIv2QoZiZHPUNYOm+PIToz
 7dnnCCpihtUy32qnGza1WpDmtSh+RO8rPj1CFTfdg80p4y/4/N5n2pTYm2LF4gxQr0eT/D
 mPT76c9OZAGILFsF8fORK692OatNQRw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-v0uKlg-vPxyNTEYDvV-JOw-1; Mon, 28 Sep 2026 14:10:31 -0400
X-MC-Unique: v0uKlg-vPxyNTEYDvV-JOw-1
X-Mimecast-MFC-AGG-ID: v0uKlg-vPxyNTEYDvV-JOw_1790619030
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49fffa5de0fso25408105e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 11:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790619030; x=1791223830;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OFTht72VGYwnHy4rRuIiS5N5orHNND6LgvZVdS8G2Q0=;
 b=CZAqqmcjuJPaOTIxZUOrc0ZZTNzLoUgY5Y5BuCF0xb2JlMwasrwMriFz1y/QeW5WRS
 JoJlPDaqQFogqu7TnofuoJqSoOFzEYLHk3DS1/ZpmK3Vs38UnqKXaKK66zE45cfTExIM
 rnFY0bUeb7kMQY+Ft8tEhc5yjZruV+6ntOrvxKOMAxmk1TWasxsG/s+Ti6D6JBffMzGN
 ZuUeyyMsTwm1qtxwcYTfYeSE3lyQX7dkuW2QQzHkNa5C2LE1bgeol+hN13Or91OjzO7b
 m0rYc/ysRri4otGctC4ivl+p2n6DXUZmqzX6C9bA9yojgbhWyIvVa6BEpy8VyhR/QORt
 fBTg==
X-Gm-Message-State: AFuF++kyKNKOQsnq5QC5WULRrP0sKDy2M/RiZedm9R/C+/UMhfXnpSXr
 c7P+L5goepImC+S8UL/3BkHoU0CpJFs2Qbbn6TBeWhJx7lHkSebtCx5XiOBYaYqwJgd723tSRUR
 ELxzJWALKCqjx5L6Fs1idpeTGsuCoSInMZ8t/MvlFVujS5nT8h5ueYV1p9MtiOPcmO374HA==
X-Gm-Gg: AYBFou2bEX7qcgmDDEsAnSy9xByaSEHE7xJuHd/FV8VgNQDXbsugKWB58DKh71xc4Jw
 xeH5rDaOmtCKHgYz2Kto61oRXj6XIi6rZqGT44VyR4BX7aEI2xR3VQfmsjIAzfVJV5mZ/+hMsES
 R3eDWYoOMxIlc/r/uxpMydYkGERhyqUSYrjYTc9xpdUa+Ikq7ix/BY4iqvfOFdj5AtIXOFIJ8Sv
 2wK8XI66zFT6ILYmv8vII2P7cLgKhEiFHaTjkeeAfJ0aVJM/bLNaoCTyAGz9TB8yDUOiITKt/VB
 rcomr6GaNw+5bEvMEju7fIYsKdvvd03KM355GIGgyEXzYngFdMRU4Xl0ec4Be1nPuW1AysPF0yz
 zHx/yeHDli5sDxBwhh6VyuGmL8bmJeBXwxL3Pmi9lyZQWtkH9RFwIGzc1txSCiQudww==
X-Received: by 2002:a05:600c:4f44:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a0023f8d93mr91712445e9.2.1790619030023; 
 Mon, 28 Sep 2026 11:10:30 -0700 (PDT)
X-Received: by 2002:a05:600c:4f44:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a0023f8d93mr91712165e9.2.1790619029624; 
 Mon, 28 Sep 2026 11:10:29 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm9652415e9.4.2026.09.28.11.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:10:28 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, jani.nikula@linux.intel.com, Alexander.Deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v4 2/2] drm/fbdev: Move fbdev helpers into client library
In-Reply-To: <20260928080323.23909-3-tzimmermann@suse.de>
References: <20260928080323.23909-1-tzimmermann@suse.de>
 <20260928080323.23909-3-tzimmermann@suse.de>
Date: Mon, 28 Sep 2026 20:10:27 +0200
Message-ID: <xlv1zex1dz70.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k18k_GQjxeNkxXrRPOhSwC5aCkuZ1CwIjtdxgPn6d_s_1790619030
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

> DRM's fbdev helpers are for the fbdev-emulation clients. Move them
> into the client-library module. Fix include statements throughout
> DRM drivers.
>
> While at it, rename the files from drm_fb_helper to drm_fbdev_helper.
> The old name was too reminiscent of DRM's framebuffer code.
>
> The GEM support code for fbdev remains part of DRM's memory managers.
>
> v4:
> - fix the depedendencies from v3
> v3:
> - remove obsolete dependencies from Kconfig
> v2:
> - update armada und docs
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

