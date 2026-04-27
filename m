Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FBCFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B961A10E279;
	Mon, 27 Apr 2026 08:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="iP97adNc";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E28210E279
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777277200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cVy6fxdVL/jxfcclJHYJeCQAneyPN40NdtdVtLHQJOI=;
 b=iP97adNcHrB8061E6oK/uMYhnMlox9inVVSeSWRcOqIsy4mkEmk0kwDNxt2LZwC9u+XAuC
 8EUot1B/ZWroQI6va+gRfvjpD7vJJRSKqsyWyP0SqQ2tum6GKH9C6SS+suienl0CfaG9mM
 2eGhA286rA9Y2GKmGbfjeTOA87k7QfY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-215zB_M7NxOsq4I3HJpsLw-1; Mon, 27 Apr 2026 04:06:39 -0400
X-MC-Unique: 215zB_M7NxOsq4I3HJpsLw-1
X-Mimecast-MFC-AGG-ID: 215zB_M7NxOsq4I3HJpsLw_1777277198
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f504f6b75so5502040b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 01:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277198; x=1777881998;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cVy6fxdVL/jxfcclJHYJeCQAneyPN40NdtdVtLHQJOI=;
 b=AZq3/y7eW2ELaAdkGY7Hapqy3py5la7olc6scbkQBrw2Ixv4b6OKVDPhHFuZchdF80
 eq78Fjp1Aito5TGS28HAr4WQFBZEtr2X80EL7+rVfyH/kc91y6TxCXpochH0Jt9r4TAI
 37gYLz+KafbeeDR37e/ZbSpuBzv3S7mzRV1NzDqUfcPOlRpBlOK0PewT9ezqnOGPTfXK
 dLS/f+mST3/CLiQ++lloJuLR9JY9Rw+WguWF7eP8OQK0dhkBvgAwy6rCup3oR4JI+tKE
 u5/Z32HN1hKKcXhTYY4g3ksZ2rUKkRtshaM4ypArMuzKqJ2qolQUBYPWS16WuAbQeIB0
 fwRA==
X-Gm-Message-State: AOJu0Yy2WDPLam7VFq60LwsFixGpxQupD13JYsUpAByXjNg1B+ognR7i
 cC9wg3u4DQFUEPI0DEe0EPURWDlcvKOKRyDBsDqzgxUmL/h8llJu8SZtF7s8E+Ctg8dNQD9cq0E
 FZ09xzeViKg0cuyWk6WKcFiXp1WssqwjdDqL4R4nWn3iSelwmZiRdw4cdjKPBV5YDm9/wjw==
X-Gm-Gg: AeBDietapd1pUOZRJrIyoKUQQF3Qjzzkm84yilSjpch4yErq2+GmrmRJQFFvicXHJRK
 4fxc1LNnsOEG7w06+bx003EGOWq1cWQ0m/8Ur3bCPY5SfiNX1MQqnt5tn64en5cD7ZOpikpVB7T
 UValtVthUAyP71Kr1uUdRE1XoJCWMFGFjmIoh/3EYW8NL6xwyMz0mWex8exkb5nOGsDamEjoc2t
 HExsV7/OeDfXgM/v5z4dmgbq06B30Rg2uIMzfizwNZrD2f1+mkHSrxO/CDCgTHw8ZsIPcQZUxsF
 e8YSO+VJMcRKoFYi4r79bMEQqLMb23LH9XzYNQaJ1X/on5Z7cGcMV+OHMJZSkSUH+tkazulcii+
 RPqdvs94bQkhtJYFiGPZXgosmuAzRDOikb9cmmzOjT+VHfwEC/I/jUfzBuRk=
X-Received: by 2002:a05:6a00:2d03:b0:82d:6310:2efc with SMTP id
 d2e1a72fcca58-82f8c82d824mr41672304b3a.17.1777277198073; 
 Mon, 27 Apr 2026 01:06:38 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d03:b0:82d:6310:2efc with SMTP id
 d2e1a72fcca58-82f8c82d824mr41672282b3a.17.1777277197591; 
 Mon, 27 Apr 2026 01:06:37 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3fa2sm31598796b3a.29.2026.04.27.01.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 01:06:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 4/5] drm/sysfb: simpledrm: Support power management
In-Reply-To: <20260408120722.328769-5-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <20260408120722.328769-5-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 10:06:31 +0200
Message-ID: <87tsswomig.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HIKDvvnvddRi4P_5DVd-eedjfNt9Z_q4dnjEU4ffBVU_1777277198
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

> Set PM ops for the simpledrm driver. Suspend and resume the DRM
> state on systems that support it.
>
> Many systems lose the hardware's framebuffer settings on suspend,
> hence resuming doesn't work there. Yet some systems, most notably
> emulators, keep the hardware state across suspend/resume cycles.
> There, DRM's suspend and resume helpers bring back the display on
> resume.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

