Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FF8CD6E60
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C69010E75F;
	Mon,  1 Jun 2026 10:21:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Fh8kOxPS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D8EC10E75A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780309316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
 b=Fh8kOxPSn/lxFv1d61cWQt17Jk0urX8ZaNGsAfu9uWwe0lAGNTqQOlLIeHNNezYO4GWOIu
 u+SBHytoVl6cGzI25wkg1PAeZ5bfWdQW85bo1m6LoNSKiaKZ/jvj8hLA+qn05r5TwQbweq
 7fQ45+ybHAsleAk64lKuiy4wniYwpt0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-IRNVIVxhN5Csm76TmsXHsQ-1; Mon, 01 Jun 2026 06:21:53 -0400
X-MC-Unique: IRNVIVxhN5Csm76TmsXHsQ-1
X-Mimecast-MFC-AGG-ID: IRNVIVxhN5Csm76TmsXHsQ_1780309312
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a762bcc6so11284625e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 03:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780309312; x=1780914112;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
 b=J1U/7AoZI4pJ85NxegiPTxAdXO2l4hHlwjaVXVu1MNYFx9+SZSZ2nPL1vXKhHw8fcC
 APYkWS8HLbZfwz8l3oFtZSe0u/n5oZ/3ZxMu2f5HANA4xIiLsiiQG9I7RhzRnycr5TcT
 IXuvfUiORkOZxxFbFEJwo64h9fgMr6wSQPf8OOna9itgPL4zXqJ6il/qv60yYwfYRX+R
 kx2//QjVbfAnVRwe9IfVhP59G3fMbsJ57a+3KbtSQGgL3LPjj2vcenkfNyTVm3EkHYaE
 sBUa+jQiFdSxA2E2HE+VXiNXbX/MVGbu8wr/ePPwlCLiOZU+7k9Ak0itDvzm0agxMGsh
 cFsw==
X-Gm-Message-State: AOJu0YzvOKhXx0M4eFrP0uzhEROmG32NIowolkh+oHBceHaGyHokUAwC
 cLx8+5B/A0P1Ywrl3CHkpScLwOWO0kjhEzp7n4uktnDgM6wM5gmKdlGymoFg0pxSC8CAr1GedK9
 +kpXCxBRpEjgLBWY4ibJ3t6OxkEmDE7IUeVSMfEkfpQgjAK10ee7U974uHQYXGPHjXL4yNw==
X-Gm-Gg: Acq92OHTIXKtvodtpGZcaw58fl8akzj1QexCphKflu47MCkWJHCIu40qTWWJBEwrB7t
 JBMJRZvDaiHcfEhHoeBkoMj2QpBL1oVxXdOFw1sBhnopcFVzBQLn2jEL/S/AtYtzzYjwwjkRuDQ
 3FY7rCy+oLykeSuZKWFfH03qy+jPgZYb9FaObHclM7RpKsLz53vBUXJuO6VR7t1+JfYz1OSLXYf
 YaUVrwhn3b3vgvdxUEl/ttTS1I8RdZtPfbApBzjqitqAMu1zxazJU+rmSaV4fIRl1z8YmV1IF8b
 002qg3GC1c7yw4Q1jUSaj6bsgopKxdgcguvq85KdSee0Ls0lCQfcr0/WUlSlBprQTlveaiL+ZZX
 su68wx2ZVtpfcD2fVNQrW39CtvH82g7Oyz0Oern2QQd9phUVAu6SMp8ntNQke6hXykocryqzxWQ
 ejLNBW9jB/G6Bsp3E=
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id
 5b1f17b1804b1-490a292febdmr182719185e9.21.1780309311977; 
 Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id
 5b1f17b1804b1-490a292febdmr182718675e9.21.1780309311464; 
 Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68a925sm366735475e9.2.2026.06.01.03.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 03:21:50 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 04/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
In-Reply-To: <20260530185716.65688-5-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-5-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:21:50 +0200
Message-ID: <87pl2alfwh.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MB4EO9b1avt9TTE3MoFcMVjkIq_aqK6qzvmUaTRNJlY_1780309312
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

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>
> v2:
> - allocate before drm_gem_begin_shadow_fb_access() to avoid leak on error

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

