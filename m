Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D2C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 152EB10F006;
	Wed,  1 Jul 2026 12:59:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZQ3/grps";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16F0A10F006
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782910751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ur8MN4EUxYcSiX5fbETtL9qCHrgMOm/kmA+W0CQuFpI=;
 b=ZQ3/grpsECYQexc3hXQcNoJAlD2FBoMa53j96SY8oSGTASYj4KntK9ulTEGe1crR8yBpa0
 3xgua7hg60XAICths+pVsGcyOZTNs8dMB3WA3qjBjVe9xpXizbR1i2bYfvNZzXMya296pQ
 l28xSxO/3nSxom+RViF4J0S9hyG1f0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-UZwKDvX_PPmWO4YAEmfxuA-1; Wed, 01 Jul 2026 08:59:10 -0400
X-MC-Unique: UZwKDvX_PPmWO4YAEmfxuA-1
X-Mimecast-MFC-AGG-ID: UZwKDvX_PPmWO4YAEmfxuA_1782910749
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-473e18559b2so428140f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 05:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782910749; x=1783515549;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ur8MN4EUxYcSiX5fbETtL9qCHrgMOm/kmA+W0CQuFpI=;
 b=m37oOwBiYKBdR+OfRgjBdf6cK85IC7QJuzf71pgH3geRGd5tqLgbc2ByHdnZRHbgmq
 eBLP10rEPIDd4Q0DbrfiZkNYRvymVIU58jctJphhzHaKG3DIgVgH0mUW/bqyZLdjunDE
 V5nxy9rYwWXG9NdR5w7bRt0NwUx+qxt2ZGC7RXzxQIbDyQmoQSd725JA4/gwcTuU36kv
 1lACf6+tXQM4hM0UubDC9HBruFt+94QGX+xud71ZXAoGMCgiDp4NkUPlU/elYDBHSMMQ
 JLJyZ6vQD7fHuy3UegSvRdrxBcYuar+fymMSFHJai+4SGyHzgnDw7w0asZZYrjCg4TVd
 jZcA==
X-Gm-Message-State: AOJu0YyGfEjy+8YRhnTRf2Oo7HiRaJ5+iiFkpCTCNqBb80JL44sqxBnO
 A/dKKXuLTX4o0p6zG65yKP7qP/Fj46azZz0QxtzqXH86HlbDXCZAQQ8UfYjjTKsUPRUdhA8oATz
 5wZ9xmMkjVvjXhAGE9tNZUefylRFjyAj7fR1zfIAHB+YcBgHgX3ibCXjgyxLSTDzsGHRv6Q==
X-Gm-Gg: AfdE7cm82XcYoFim1zHd9WMm2s36j9Tf1ikuC9XyJ0HL8VIPuwPiBdap41hbO3NUhqD
 pvHE0seESGuuHdx2DP6wExlCQ5LZ4Z5PXOoiC8aQEGa1o4s+kDkv7QyPKqGxsi7v4c6gm6E6/ko
 NowgjCkR7WAnvprxjl/vdAUA1GHAe1NMgVccRdTCa0F59rDPhEYyjvVWYbdlt0FulAoSSJy3Yf6
 9x49r1ZizjcGOPahcHxB/S8h8pxX5Ug6iZKg9so3eyAJFCL/szarWrAwlUUlVhF1JrZsDdgRM8M
 QTE14GMkyFWZlrCvJwjaj9RGukaTZeuh7yItr2UDrFmUriwctymMa6AoGcP/USPy5KBYaS3p+1m
 dzhPNBZVuY2XZ0W9m6fu8aAfP6dRq45+yRTp6y5HCgEMrsJRfOgbuosMHJcwGUkEb8/UNnA==
X-Received: by 2002:a05:6000:460e:b0:45e:eaed:afd2 with SMTP id
 ffacd0b85a97d-477b075db6fmr722961f8f.0.1782910748713; 
 Wed, 01 Jul 2026 05:59:08 -0700 (PDT)
X-Received: by 2002:a05:6000:460e:b0:45e:eaed:afd2 with SMTP id
 ffacd0b85a97d-477b075db6fmr722908f8f.0.1782910748219; 
 Wed, 01 Jul 2026 05:59:08 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cde2sm17027364f8f.20.2026.07.01.05.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:59:07 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, treding@nvidia.com,
 neil.armstrong@linaro.org, jesszhan0024@gmail.com, dianders@chromium.org,
 megi@xff.cz, igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com,
 agx@sigxcpu.org, kernel@puri.sm, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v4 3/3] drm/panel: Use drm_of_get_panel_orientation()
In-Reply-To: <20260701121055.192475-4-tzimmermann@suse.de>
References: <20260701121055.192475-1-tzimmermann@suse.de>
 <20260701121055.192475-4-tzimmermann@suse.de>
Date: Wed, 01 Jul 2026 14:59:06 +0200
Message-ID: <878q7udfxh.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fX-oFjmDERyhjFkrMsDP3j1tCrgY_1x9ZO-jf7oSJpc_1782910749
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

> From: Thierry Reding <treding@nvidia.com>
>
> The old of_drm_get_panel_orientation() function was replaced by the
> drm_of_get_panel_orientation() in the core DRM OF helpers. Replace all
> uses of the old helper and remove it.
>
> Changes in v4:
> - also convert anbernic, chipone and ili9488 panels
> Changes in v2:
> - include drm_of.h in all drivers to make sure the new symbol is defined
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

