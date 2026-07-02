Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E1BC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD19010E48B;
	Thu,  2 Jul 2026 09:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ArDRZeEM";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C7010E48B
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782984227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zTpKuSZrhsxPxzQIZfaOOpTGT1+k7Nb+QD5Zs9kC3Q=;
 b=ArDRZeEMsM8tWleiE/e6bp/PpjNnkLUzQZGnudVZ44PlqsxnBeL4eFSFlQ9Zaq8ugSu6Ro
 JcyjA8WiCkv4aD7r1KOQUJtVv0KztqxO+BfgY0DLpsixahO5vDT2/FkMLuSy0rQ6zRPcfj
 y1PELSB4khV1wSMyawwfOV9MKvzkT+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-TxND7iHJOxe6ohB0A0yrnQ-1; Thu, 02 Jul 2026 05:23:45 -0400
X-MC-Unique: TxND7iHJOxe6ohB0A0yrnQ-1
X-Mimecast-MFC-AGG-ID: TxND7iHJOxe6ohB0A0yrnQ_1782984225
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493a6fe9ebdso9996205e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 02:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782984225; x=1783589025;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4zTpKuSZrhsxPxzQIZfaOOpTGT1+k7Nb+QD5Zs9kC3Q=;
 b=jzmTP2aov8Mwsf9D30L4fU+3f1eyd8fWy3a84WwoICB8pWsAa0EBo1m5RE3/V+v8if
 qRh1LnezaU5824J7DPBxZod4N4ywsogpTsH7Bk963l8R/S9tX6/tkO7WZ6eBowpMMVuT
 8H80UN8c3gDpS7RCuCBYsUN6L3UsCX9WFCXse+Y8iIN4VvMeWxuLbqzUaoruXyDcdZss
 GtgX7CP3vlnMjA8mRkTfAf+KFjBz6JTgXouzv4k30x0e7FJFJdHgh4h2ZIbWsrLXCBvQ
 uIHlLaZ2lhT2q+L2lSOfgflAcNMtX6d2bxYQtNv6Xdhpy0+0zqHpBqywhozgcGm+sDAo
 mHMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+I+Hs6GsgDMjnVMLtxH5AOHbSbGLY/XzdpTw8mXXLLl/aGtLrItJRUp6c8Y1usDPTo7UmDKZGiiNk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrnkmlhMrV6VdMbL9Cjdkq4nA7QpRGFbmm3HR4LwWVRwnnzHwF
 o83MPjEcZusJk/VM+LXxqBa+8H/WGIPfiChwCgmujqf3Bq7fndt7HJvkePn7zKO8aFtEDoMjxpz
 UL9z1i6dxC7c+SYFrm9S7Po6ltApS6JDM9lkJVg0SUYe9BgtVSwRx9RhYyhh6HbL9tWv2zQ==
X-Gm-Gg: AfdE7ckgTUD0kdHxCKOiFiJljRSNWoqkyzHz02NNHgaVRc8e8s8hkAhJHUj6S/828So
 AB1gpNILKYhD90gT1/0xYXUwtSlqAvidrcOdI2xR24SSaBTyma7hEP9IUw7CJBd8ZdIGG+rduJm
 hq/moi9RZ8l9yhhlQoVY0FvLU1QnF/wDMUH0grM4nq/M4UAMdfP28eXym8XsMGX6q6S9rk9vQk9
 am1TGIf28D1Xk9hQH/U+glaV3SUDCsGF/QWducKiI6nsvDZH9znA6xN62ISjg4OkawNNzRN3WoJ
 PgzOV7hXnTwfuh/DOGBOYieYjmZnRVTNdFJ/SlYJS6kexpgckqROCBLvLPJUwNrV/emBjSPZYLC
 +9UgqNQtAh3ONBT/F2ziz1Txugn5/FdB6BTfcyWFBGPDYYkJ7SGWyK6jxWx243PMhNE35HA==
X-Received: by 2002:a7b:cd83:0:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-493c2b4fff8mr50363705e9.13.1782984224695; 
 Thu, 02 Jul 2026 02:23:44 -0700 (PDT)
X-Received: by 2002:a7b:cd83:0:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-493c2b4fff8mr50363325e9.13.1782984224177; 
 Thu, 02 Jul 2026 02:23:44 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6368f89sm30642055e9.8.2026.07.02.02.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:23:43 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Diogo Silva <diogompaissilva@gmail.com>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Diogo
 Silva <diogompaissilva@gmail.com>
Subject: Re: [PATCH v3] drm/rockchip: Remove dependency on DRM simple helpers
In-Reply-To: <20260608124018.480365-2-diogompaissilva@gmail.com>
References: <20260608124018.480365-2-diogompaissilva@gmail.com>
Date: Thu, 02 Jul 2026 11:23:41 +0200
Message-ID: <8733y1d9sy.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YNMEhqDlXO9q4Q452KrVfSXsvo3Xjs1wKCJIZsf1Mks_1782984225
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

Diogo Silva <diogompaissilva@gmail.com> writes:

Hello Diogo,

> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the dependency on drm simple helpers from rockchip
> DRM drivers.
>

I think that would be more informative to say something like following:

This patch removes the drm_simple_encoder_init() helper usage in the
rockchip drivers, by open coding it and using the encoder atomic helpers
directly. This is a step to eventually get rid of this simple KMS helper,
once all drivers that use it have been converted.

> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---

The changes look good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

