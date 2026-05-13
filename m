Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285AECD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 12:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B1510E337;
	Wed, 13 May 2026 12:38:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PVE/bqoU";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B94F10E337
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 12:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778675931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDwCyOHYWgXUVJX/XSGIsohihSr8t7GG9xIFRvq8VH0=;
 b=PVE/bqoUJuYUe8ss+4HNfQpbSFVFGz0oNhzx6CdjiBYb0WecwphITHQz5zVaeWCaOftn6O
 pWeeYUKoRkcrwWvTfTq3sJUONpI8Z6yNR6dTqGSJEyfnT6Qgt1YdYkHlX1t5CdWD4VaCsy
 hRsAun+YI94vCSD9WkwDXYPQbwJAhPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-ndYDW0JlN8qLMzWl4aRkSA-1; Wed, 13 May 2026 08:38:48 -0400
X-MC-Unique: ndYDW0JlN8qLMzWl4aRkSA-1
X-Mimecast-MFC-AGG-ID: ndYDW0JlN8qLMzWl4aRkSA_1778675927
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48d035e8593so47030115e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778675927; x=1779280727;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDwCyOHYWgXUVJX/XSGIsohihSr8t7GG9xIFRvq8VH0=;
 b=n73+5sW3Pc6qaqxffQ3mSorBVo0ioyBtXkXG8wP7ZbOHVGmbbPyGp+EZZ+RJgbR9Z/
 aciGs8KgfWboJMhHA1NP+sqyWYpY6v6cjiezKsxmVOCPKkWBH/n4QSfMyJBePiIi/JwX
 zIY95GhXGnXceekctPNp9kKitmN9oB3NBHVPVNImVmgEtDjuBoxxRw6kBcN76VmcEvga
 KkVhegPdRFzIxkOZGMDfXIdwB/b/ZEdYbqTmGeSEafgKewCV2ME9hIC7UaiQzW3Vgm+B
 FPlg6JgEMI3ZBIh14GWVWOddsoALAWnCSQssY0g4oh2ph81z4mnuG+G205DaL2ABbAPy
 2O+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/Dc64TPtsgSXBeD1kHwjB/M7H5guDr0mb210NMz0PsdtGj+go1i42q8UoH3pVINy58ARaXWdgEcY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGc34C3NE6QcFJHuXsMO+4dV7+YydmHyOYGMaaxGxbQSrJ9rTa
 70O9CK5leXjybM7eAwiDWMxYPwmvM34ufHPfdWldyLb6hiPlZQNYFF0rXVqYflH7J3E+MX8Y6rT
 W7ReeC5fakqhXXlO0i581OJK6NxOzbyzz1W3j0GmqyFwJRPGAlKCfxTJNLFkycI3v9qi/GA==
X-Gm-Gg: Acq92OEXhw1TNGNRpWVtTFpmwXE4icjZWTcq713HhoDqg9D5qa8kHFH6MbAjy+L6OLf
 qGJF9+UfmzR0bqQcINl0u89AwhZXT8gIsGxrEaQp37ib2bJAeXvEVG5XmBHEj7wBKZQlIOr0UXT
 r04toYJ5Bs6R7d3HXPml1DQGO48VgJkji6ZY8eBCVosDY6H/3/omDtwklsfOQ7rMvFcZgyJudrG
 H8DjXPQZOAgVPi0oi3jNfmboUqC57rxtMtsV6cltZ0ANzEjX4oJ5EUWa6teBq2bftR0Oy8gmRcI
 syPh0UMYPabVmQbatHigScAE1E810/JxAn+8NguVfnLaumtqYJqPtkBjomlFmk+R505wWVISTsy
 Y7y2tIOGCJtH+xjaI2FOtG5P86GJ3vVhbCjaSeiaW6+o8P1dXlDF8uUSUr9oHNFIP8abhMFB2Kh
 Dd3zIF
X-Received: by 2002:a05:600c:811b:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48fc9a30a5cmr37250285e9.15.1778675926975; 
 Wed, 13 May 2026 05:38:46 -0700 (PDT)
X-Received: by 2002:a05:600c:811b:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48fc9a30a5cmr37249855e9.15.1778675926485; 
 Wed, 13 May 2026 05:38:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8e5f00e8sm42603785e9.2.2026.05.13.05.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 05:38:45 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, Robert Foss
 <rfoss@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann
 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/2] drm/bridge: ite-it66121: Set TX mode in the
 .atomic_enable callback
In-Reply-To: <20260513-huge-mongoose-of-wealth-464fac@houat>
References: <20260512132232.333654-1-javierm@redhat.com>
 <20260512132232.333654-2-javierm@redhat.com>
 <20260512-romantic-qualified-hound-b5f9b9@houat>
 <87tsscxxuy.fsf@ocarina.mail-host-address-is-not-set>
 <20260513-huge-mongoose-of-wealth-464fac@houat>
Date: Wed, 13 May 2026 14:38:44 +0200
Message-ID: <87qznfxz57.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PkYtfyoNxMwOclN7InKoZiE0PwMDr1QmvrNvuwQuLlM_1778675927
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

Maxime Ripard <mripard@kernel.org> writes:

> On Tue, May 12, 2026 at 08:54:13PM +0200, Javier Martinez Canillas wrote:

[...]

>> >
>> > Having some part of it in mode_set and some part in enable is still kind
>> > of weird. The best there would be to put everything in enable (and
>> > pre_enable), and drop mode_set entirely.
>> >
>> 
>> I agree that this will be the correct approach. I wonder though if could be
>> acceptable to land the changes in this series as a minimal fix for the DVI
>> mode issue, and then do further refactoring as a follow-up.
>
> The thing is that you're now making the driver and its interaction with
> the hardware more complex. Like, what would happen if mode_set is now
> called after atomic_enable? How does the hardware behavies if you modify
> the SII902X_SYS_CTRL_DATA register only after it's been enabled?
>

That's a good point.

> Moving everything to atomic_enable keeps things simple and keep the
> hardware access ordering the same.
>

Yes, I agree.

> And if you don't plan on sending that to fixes, the fact that the patch
> is small is kind of irrelevant anyway.
>

That's true too. I'll then prepare a v4 doing it properly then even if may
be a bigger refactoring.

Thanks again for the feedback and comments!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

