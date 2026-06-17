Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95ADCD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 309F910EFC0;
	Wed, 17 Jun 2026 11:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YZ9I49cK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD0D10EFC0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781696708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFpuqaDieAHnE3Ar5B8cZarVK1thuyCr3IXVZ5S3Hp4=;
 b=YZ9I49cKIiBTXmqzG4HejnbnW3hBa6Eai8lzJvoakUhb/9DGk5gavolSNbGQ2uZWgD2PXo
 MzOEqtIIodc7GHp2z1Nxfnk9OVmDgsHtx/8ALVM1uE70ji3BuhMXDlOkdyJqQs94AgQKmu
 nKj6O0vaBoGyZeNeoKsq0bnAOyfcfTs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ES_mg8fyPk6asUVFGdxwZQ-1; Wed, 17 Jun 2026 07:45:07 -0400
X-MC-Unique: ES_mg8fyPk6asUVFGdxwZQ-1
X-Mimecast-MFC-AGG-ID: ES_mg8fyPk6asUVFGdxwZQ_1781696706
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-460153ce644so4145741f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 04:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781696706; x=1782301506;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZFpuqaDieAHnE3Ar5B8cZarVK1thuyCr3IXVZ5S3Hp4=;
 b=e7mIYE04RgoUVwKdQb/JVTkBVHg/xXQka7FipbBUCygOTuBXTX0Qr2KGtLN7tU/GMq
 Q7Rd506IaPSxaBqsjGkOsB4hBYQ7LpPfMWR1FiVB2wPcEDcZlMww5P4KV85xNRp2ARcP
 Q7X2o723oV9E5zup3l7edD/un9j0Zx8cvuRRLPWrr9nxDwD0beb5KLlrbiWfMFdjfmE7
 WrvS0Pkv0YLresFSce0yisW0fAZ251Oa2hFazyaVXv1jX/cydxgIGY++HnTh/0m9tUNu
 r/N6bMp5bWXdUQLTfVi3/ThhsqXFrXcJFHuqX4P3SEN7EvZfQMQJJQaYCQzPrr/CMn8M
 V6bA==
X-Gm-Message-State: AOJu0YywgOXfhxoKgXYsNvVozSw0bmjBLXg6Q5MSpQsYCSoyV4oEBTzU
 uCwyfKp70ItahUCtP5Ln5T6Jcg0Ek1wJWKFESkJHIQuB2MUaZ9T/vjsXnu4KnjYCX8qqTywdmhR
 fAJwd0anMbQIqzJ5mEkQ7RqAS/Wig1UMmSjXuay3cGs2nDre49KDukc0T6ln6me5gA38oPQ==
X-Gm-Gg: Acq92OEdgq6lZFWJDY9jBlFMDsMSTyQcdb3v35dg0i2+erjxSvgR1ukO79PfSi79Xy9
 duwcXIUxqywQLCe/nN/E71YFyltN65rBrI6pxsOnM+Q41wqwNbUE5Sc8bzJ6ZHM/VDMA/RZPdAL
 3+F9uF1WUYpgPe8TMJdGMwc6RpP6FGHYRr6lC8/YM6lYTxC/5wEn1TK2PVYiQn/Xqgx05kJ6Ko6
 S8mgP0KZO43Zcl8OKnWpYea2V6JP7jJkfpmUpusKCRgzPuuFBKoD9WarnuQOxaHfxXWVu7qWU+J
 S78wvcLSCUTmGOrZe+N4xxk+bdHhgtI2Rn1j5Sd3TnXsrUnodIZcEMSNeJUgURxnb7YbzdYFGho
 eqvFRzkken3L+wL7a31awdV6b5ZA5sknwr3PolLIdfttd3nprhS0ilH3hLfU9m7Z0pn0hLQ==
X-Received: by 2002:a05:600c:6089:b0:490:b8c0:d46a with SMTP id
 5b1f17b1804b1-4923412f185mr46138905e9.22.1781696706230; 
 Wed, 17 Jun 2026 04:45:06 -0700 (PDT)
X-Received: by 2002:a05:600c:6089:b0:490:b8c0:d46a with SMTP id
 5b1f17b1804b1-4923412f185mr46138295e9.22.1781696705767; 
 Wed, 17 Jun 2026 04:45:05 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm137247345e9.14.2026.06.17.04.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 04:45:05 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sysfb: Return errno code from
 drm_sysfb_get_visible_size()
In-Reply-To: <20260617112932.511657-3-tzimmermann@suse.de>
References: <20260617112932.511657-1-tzimmermann@suse.de>
 <20260617112932.511657-3-tzimmermann@suse.de>
Date: Wed, 17 Jun 2026 13:45:04 +0200
Message-ID: <871pe5z8zj.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AC4eca0jM8DOQVdfHgZxFQBYkm3vN9vF3EmKUdbdJIY_1781696706
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

> Change the return type of drm_sysfb_get_visible_size() to s64 so
> that it returns a possible errno code from _get_validated_size0().
> Fix callers to handle the errno code.
>
> The currently returned unsigned type converts an errno code to a
> very large size value, which drivers interpret as visible size of
> the system framebuffer. Later efforts to reserve the framebuffer
> resource fail.
>
> The bug has been present since efidrm and vesadrm got merged. It
> was then part of each driver.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

