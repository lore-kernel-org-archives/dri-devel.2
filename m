Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75355CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A23F10E5B6;
	Mon, 18 May 2026 09:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UG32ST08";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3792410E5B6
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779096141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lQO1/7FO9sTnoT11sCio/KFSKpDAF4QkGjd6FaweRXM=;
 b=UG32ST089IXKKhnfQSt5dTXJjTnvcrfjWxqasGKDVG1fBpj7WLckDvFUevUp/G/F8ohV9o
 lb+wAjLbyGTZ0Kcv4t/RhHd+97R0ntVVAnZQJ5iu2VTcnQCh2YN/Her6VHS4tlzNNrmHI7
 A0MIP1rV5QVroBOxCP91eUEyRXqD8Pc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-S5S8OOppNLSSXqmmK4lGyA-1; Mon, 18 May 2026 05:22:17 -0400
X-MC-Unique: S5S8OOppNLSSXqmmK4lGyA-1
X-Mimecast-MFC-AGG-ID: S5S8OOppNLSSXqmmK4lGyA_1779096136
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fd8162ed7so16512395e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779096136; x=1779700936;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lQO1/7FO9sTnoT11sCio/KFSKpDAF4QkGjd6FaweRXM=;
 b=klCmOZ6A6M7VLZOl0C4KHdzTErZS+yC2WTvzLyvIO7JQUui1iOrTpdycxCjw+LP0C/
 /MJYE/nyfCwsQaNYD100151Awkds/Jsk0+P3uONZf6gL8aFpZUv4hAFgG84I63tigluN
 +yZLII6auwokq7BXNMcnPu7aTRJkO5dRURcI+AWhMrmxnxu3MsW7ZY39ab4kESbNb37j
 7ilqunN6gK4XWLmWA0eJKTBYAiN8I5SsRQ4T5UkZoQm0ZYjFLRuR5QZ1N7yH53BHRw8/
 PcJgH9DsqaLSKynqoWf1NL0nUSKLMeUCSth7U9YkwfQ5qxTv4NX0V42mES9xIekqjzt4
 2JtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ta6hVVq3Z/fosdH1dqsw3gCTTxpmfNbfxP7XxNmKCe56oL/eh+iqL2IKG1/7Z4EHNEwTkeWxVUok=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG/3ChnslsGSknZjH3W3Q7pM4JIbOoMHtbYN529e3NGP9CPkAx
 wtM2hZhDhHkQMzaaCC9ZIku6s/bFOsckm/3ALb35+v/xUGjdoNvRQ1dnk8mrEd7XmFrriOizMZj
 zK5XsMi1avl5IUePK83AhaE/RHSpA3sLwoUZVqqhdT/1C0kF1fvMNTlCABFTj0uii6bVL9A==
X-Gm-Gg: Acq92OE3bJdFiKDUSScoP52U6wx9ZLzOjjiPz7LmFy6TClF+QMVRFyn/n9aAqmMnbQQ
 NLYJUf4/0CY/7BeGILNbrEJBKSZagdTtknR6H8jXqyJaNamwPVzkKPE6cRPsjSJixMhIh6QukcR
 LctJqQPalNlKHqDsTyp7qeT3lc7pTJx97G299gsxra4nwk0V0hENkS6A28WK5fP0EejhF6sMPjU
 /RpYMse70tPe9f21Zr8bY3UavI2t8xq40ayHjfrUC845+DFdVe7riTp3Aa+45iMYmdWyuF79hcu
 XXrGc1WAH++oNxnpfjzEOCT0Nn/U6nLTT8CWxVg8nfuTaRKZEfUJCplNNgx4FqK/NFqRFWcRd3H
 BC/Im2OxST0zgw6pY+roNOOyzOdtDC5qAXS7dybxn1GUTFL9IryoNXLEHKBW22Gyvkux9f1K7O1
 UMHnGkU/VBrYD/irg=
X-Received: by 2002:a05:600c:858d:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48fe651c8b1mr148072175e9.27.1779096136165; 
 Mon, 18 May 2026 02:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:858d:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-48fe651c8b1mr148071815e9.27.1779096135715; 
 Mon, 18 May 2026 02:22:15 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fea52a0bfsm114035395e9.0.2026.05.18.02.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:22:14 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Julien Chauveau <chauveau.julien@gmail.com>, Phong LE
 <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Julien Chauveau
 <chauveau.julien@gmail.com>
Subject: Re: [PATCH] drm/bridge: it66121: acquire reset GPIO in probe
In-Reply-To: <20260324193011.16583-1-chauveau.julien@gmail.com>
References: <20260324193011.16583-1-chauveau.julien@gmail.com>
Date: Mon, 18 May 2026 11:22:13 +0200
Message-ID: <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: px25HeEOy0KQL9RBwVb-h8WFmcrmFcY1R_i_lEold3Q_1779096136
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

Julien Chauveau <chauveau.julien@gmail.com> writes:

Hello Julien,

> The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
> calls gpiod_set_value() on it. However, the GPIO descriptor is never
> acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
> the driver lifetime.
>
> gpiod_set_value() silently returns when passed a NULL descriptor, so
> the hardware reset sequence in it66121_hw_reset() is a no-op. This
> leaves the chip in an undefined state at probe time, which can prevent
> it from responding on the I2C bus.
>
> The DT binding marks reset-gpios as a required property, so all
> compliant device trees provide this GPIO. Add the missing
> devm_gpiod_get() call after enabling power supplies and before the
> hardware reset, so the chip is properly reset with power applied.
>
> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
> ---

The patch looks good to me. I've also tested it on my BeaglePlay board.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Tested-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

