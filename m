Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE1AC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4907410E2F2;
	Thu, 16 Jul 2026 08:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="IRD/IcD7";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7166710E2F2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784189118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Yikf99/9Ld+d4W8zaFV+rGr++MhANQSN5nr7zBuh1o=;
 b=IRD/IcD71SGApWmrEWuUQNiSJNBTnbcgJTiwin8dW1upSVz0yXPH50MrPqssaj4wfZZaw3
 traMixLxqYdhyF1nmsIdv6FrWqz7QoWgulH39j6MK2gRQt2JqjoNdelNEnLtum+ZIcBuCA
 CwUGw6BZwCONT6+blhDs/aM36vjOzMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-q_xk-HKCO9OygehIoUDW2Q-1; Thu, 16 Jul 2026 04:05:16 -0400
X-MC-Unique: q_xk-HKCO9OygehIoUDW2Q-1
X-Mimecast-MFC-AGG-ID: q_xk-HKCO9OygehIoUDW2Q_1784189115
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so90981565e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 01:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784189115; x=1784793915;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+Yikf99/9Ld+d4W8zaFV+rGr++MhANQSN5nr7zBuh1o=;
 b=J+WcD+EtM2ojy+RdOWXRrX41KZ/tdk0+KtHxrR6pBNQD2/rYkWwt4cDHP/FFSI0kWL
 IzhoIZoBbFE5kDwZMruHZ91vWBsle52NL6+bqALb2B++noOa/VSIR84/p8GLzXaCYmz2
 T8dj9q7iRz0/L/1u6hJxsCa0t2OEYxyVzZH8RNs7/osaxmoDkebRrTqjcSPwfWEo95YA
 6tfMMI7llmhQ11YDzzmq+uPdm3+FjEDVtPNTYi6bB64Kg+SgGREZVCxlMQWhqFWvKrPs
 c9jAfcKctYknSkY5o2JnKqeRhqJ+La0BlB2Gmf2ow1nP1bPSe8tgCjtl7OfoU0G/hxfw
 TPKw==
X-Gm-Message-State: AOJu0YzHaN3qXIf8n795Xh3GLY+By7HNgjxKlJ3uHZaWHMdDhXoq8fX4
 mMcR1lMt5JwiKh1KhY2dSllA7kShaPqBT8A9Xvqx4C9JavrtGhovnbyRwDbI7kX+gug8oKlcp/7
 spLgr6ncKCp7QPXFxW5VzOWV9lKqqlozSs3T8/FkZhuKtpYO9n/hyQ73l0fk7866KHgfiGg==
X-Gm-Gg: AfdE7ckafOCSU47aow1qSpk9avpc2h/UNiv6PyQHXL0WVbdM6DomfUIgZelhhnBTH09
 UhNm7Z9X2qw6C6MH6v9KSlLHiW5iKwxSTdT9AJlbqfuwQGeZ7T6G/umnsrIIdvo/XByVNrJmmZg
 Xu/cny+oz1WKy/JSbDUZUAdJ58zN2YBwCt+34Wn0zkU71nH5UvfM6v9uVhif5gljq+GjGeAf0Tl
 yKTcRGU0pDpNFSqgeK0C6XGI+5laBSmtza2KbliSZbDzzA/hL5jOHJXMjVk3PfGeB38Sqs9nLa5
 XkeaKKTQsDT9tLP3Mx4rLeKsXU+x+AlhbJgeTYsZxkBuU9JRTi3Tqio2NBpZ0GlvOngJmwJ5Vzm
 Wnm4HqRdfMtv4y4+4mf3nQav0NAHN4s7PNU1OgRqkdkZMr2FYwK/Ysd/2+Jw=
X-Received: by 2002:a05:600c:4fc4:b0:493:9cb3:53fc with SMTP id
 5b1f17b1804b1-495389d2bb0mr108778345e9.11.1784189114955; 
 Thu, 16 Jul 2026 01:05:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc4:b0:493:9cb3:53fc with SMTP id
 5b1f17b1804b1-495389d2bb0mr108777405e9.11.1784189113925; 
 Thu, 16 Jul 2026 01:05:13 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e0d9sm21740351f8f.2.2026.07.16.01.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 01:05:13 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel
 test robot <lkp@intel.com>, Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: Re: [PATCH] drm/solomon: remove unneeded variables in blit functions
In-Reply-To: <20260709-fix-ssd130x-v1-1-1272cb3dc85e@gmail.com>
References: <20260709-fix-ssd130x-v1-1-1272cb3dc85e@gmail.com>
Date: Thu, 16 Jul 2026 10:05:12 +0200
Message-ID: <87pl0nbbrb.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MpmU3dortAHshQevHLSOEtoSfym3gMXr1V04GS1Bk3I_1784189115
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

Iker Pedrosa <ikerpedrosam@gmail.com> writes:

Hello Iker,

Thanks for the patch.

> Remove unneeded 'ret' variables in ssd130x_fb_blit_rect(),
> ssd132x_fb_blit_rect(), and ssd133x_fb_blit_rect() functions.
> These functions initialize ret to 0 and return it unchanged,
> so return 0 directly instead.
>
> Fixes: 2258f03989af ("drm/solomon: Move calls to drm_gem_fb_end_cpu*()")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202606301409.I0ctsf41-lkp@intel.com/
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> Fix unneeded variable warnings reported by kernel test robot in the Solomon
> SSD130x driver. Three blit functions were initializing 'ret' variables to 0,
> never modifying them, and then returning the unchanged value.
>
> The fix simplifies the code by returning 0 directly, addressing the static
> analysis warnings while maintaining the same functionality.
> ---


>  drivers/gpu/drm/solomon/ssd130x.c | 9 +++------

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I'll push it to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

