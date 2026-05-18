Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27260CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 09:55:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8048C10E11A;
	Mon, 18 May 2026 09:55:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="YXsJ6C/3";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3FC10E11A
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779098137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xudk4GOO+l3lmPzk8MU5bwUvZOAX00ItJJurhMyKKiw=;
 b=YXsJ6C/37mywx5is64dbBQZ6Iz/5hQFyXyXp2NdFKQmuxMXhG4Vjyqxg/9IoM4ZOWGMbBL
 AABHo6/tK2bp5h12Q8qG6ikv965IgDTGO+8K0kEHytC4Dh63eDZeeAUGjxEhpl6VP9niIO
 E0z1knvDuK02OsOR0P+0Sw31pr6PYg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-UWQ7rouwMYOSjUQ21v7stQ-1; Mon, 18 May 2026 05:55:34 -0400
X-MC-Unique: UWQ7rouwMYOSjUQ21v7stQ-1
X-Mimecast-MFC-AGG-ID: UWQ7rouwMYOSjUQ21v7stQ_1779098133
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4411a36715dso1333250f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 02:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098133; x=1779702933;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xudk4GOO+l3lmPzk8MU5bwUvZOAX00ItJJurhMyKKiw=;
 b=ZCdd2SXJRTCMoQN0kKHo3xCZujdtu6kdNUJsimlLpPmqyUXVZjwJR1ES1XS9uVwWlY
 TLEmx3xdz9f187wGHxy01Z9Jx/gYV3u1kVLxaVE+CnGWe48ub/f60qU8WBK9C0SA+oSJ
 6o4fJgvtqbh3oU0IuQwGLr6tkPNVDTyAMOIKYaupixl3CP2v/4C2pDhu5qePqL2IjH0j
 UwdTzMpcGN8XLcacenH6+s6K/mylr55XXBpr0OjIaZ57CYcKKkg+xvJjV1z1rswIu5eP
 0qPfMY0KC3DnRyo44pJRaJ3EcHQdwytBE5Pz6iYmReOsb0/hQxg+rN4wvXvdhVwv5Esu
 zuoQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QY3PE03Kkr0ly6oICSHfUdCeu5T2AOodIhctiFC1X4J5yM20DbL5Mcseb92WXCN/iVaj92WIQ3jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMwF8jPQ1rolWxhOEM1KfToHTMeMSxAgUHvT3fK2IZ1cfQ5W87
 llsvZIsHWEa7DmKo5jcVzo/QD6tz2BIsMt50yp7j3pJiH+o+oERcvx1QpNmBy9+GI5X9t58hswd
 IJYnfPrN+hePjW7g3glUP58BIfOA3XFzu9vmL3eUh6d7kgNiXDs0znrOMbsg6OvqKfCcD+w==
X-Gm-Gg: Acq92OGpvhlQijn/tI7k2d9ngoZ7NSf8omc8MilA+ofTNL9cztfMtGxardBPB/qx8S2
 iF0uV6f21ZWU05t9Zax5dZSHZ8/wmh5dVAEME7A8SLH666pY428t734pqF9Pz9k7QZSIztWuAzs
 y5sOy6UHgbmQQw+xEmhPiBGY1t8rQJe4MHy0Zpw2Knu6jcsZ+lbBO1lwAL95yBpbtnTu+FxnpHW
 yYAMnFeFnzAiUryAXovtWubR2n2xm806iTq9thJTJuyiL1aiHuBMFSLtuyvtgGC0wFyhCg3VPSv
 DhDffm8OhAA3ve3S5pOb6jJFvZBYEBSw1KuNpywnrzxFO8OHnjAXqsM7ZPFjzjSjkBLF+/+8CfF
 3yFgHPNEqA38cbFFMgBsQaFk8oHCX7O/N45GBGhE48MvE8MPvEAXXl+2zTdfAiFSbVBetbokf9/
 9e3CBG
X-Received: by 2002:a05:6000:230d:b0:446:96b1:f5f with SMTP id
 ffacd0b85a97d-45e5c35da70mr19965380f8f.8.1779098133063; 
 Mon, 18 May 2026 02:55:33 -0700 (PDT)
X-Received: by 2002:a05:6000:230d:b0:446:96b1:f5f with SMTP id
 ffacd0b85a97d-45e5c35da70mr19965330f8f.8.1779098132650; 
 Mon, 18 May 2026 02:55:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39806sm35212353f8f.9.2026.05.18.02.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:55:32 -0700 (PDT)
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
In-Reply-To: <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
References: <20260324193011.16583-1-chauveau.julien@gmail.com>
 <87lddhxebe.fsf@ocarina.mail-host-address-is-not-set>
Date: Mon, 18 May 2026 11:55:31 +0200
Message-ID: <87ik8lxcrw.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fN7OlQq_r-OfDoq3mmOjrHAXiO6wO8Fun8q4qBmo31Y_1779098133
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

Javier Martinez Canillas <javierm@redhat.com> writes:

> Julien Chauveau <chauveau.julien@gmail.com> writes:
>
> Hello Julien,
>
>> The it66121_ctx structure has a gpio_reset field, and it66121_hw_reset()
>> calls gpiod_set_value() on it. However, the GPIO descriptor is never
>> acquired via devm_gpiod_get(), leaving gpio_reset as NULL throughout
>> the driver lifetime.
>>
>> gpiod_set_value() silently returns when passed a NULL descriptor, so
>> the hardware reset sequence in it66121_hw_reset() is a no-op. This
>> leaves the chip in an undefined state at probe time, which can prevent
>> it from responding on the I2C bus.
>>
>> The DT binding marks reset-gpios as a required property, so all
>> compliant device trees provide this GPIO. Add the missing
>> devm_gpiod_get() call after enabling power supplies and before the
>> hardware reset, so the chip is properly reset with power applied.
>>
>> Fixes: 988156dc2fc9 ("drm: bridge: add it66121 driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Julien Chauveau <chauveau.julien@gmail.com>
>> ---
>
> The patch looks good to me. I've also tested it on my BeaglePlay board.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-fixes). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

