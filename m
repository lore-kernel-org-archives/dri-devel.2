Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE63CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 915B710E2E7;
	Thu, 18 Jun 2026 10:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="N7imRrVm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8637D10E2E7
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781779537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ex4FXoS07wD1HdVUSdQ/7roGTbJyzugyEwIGze9M3sg=;
 b=N7imRrVmILczqikPwhCiNpn4Dg+whX8BGM6RWweHZMdqL9CX+Oyib9O+lDHEw3KlTTu3JG
 xIb9NorUrX8ILkcxHmPbOXNLrCD5pH5MKrmmLksOidRmML+7o8v4G2ZZoXEDeteqkw7Clt
 8uEZ2qOzjnC2jDhZ7hfFpKO5Wk6DXIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412--OGEZvspPtGYRt-8op3VvQ-1; Thu, 18 Jun 2026 06:45:34 -0400
X-MC-Unique: -OGEZvspPtGYRt-8op3VvQ-1
X-Mimecast-MFC-AGG-ID: -OGEZvspPtGYRt-8op3VvQ_1781779533
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso764100f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779533; x=1782384333;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ex4FXoS07wD1HdVUSdQ/7roGTbJyzugyEwIGze9M3sg=;
 b=ROfyAeHCte44kUkdrfjJFKnSSdvI5cQ9eotHzmOaP0wVFDgNWhG/rUDDaTISNdhGk5
 Qjphcj2ebUn+Oq9GLPjH+SKn3b9h+3rFYy9QLWKers2U4zRSW+jPeVhOB6TZE4n8U+eK
 gAxTmUrFU9iiqcpHpmH76pER8jEAUhfEDQSCn+3N5oQB9jls/dR/+S0I7qlF8xfqbFE3
 UF20ImkD7bU1bcWvjdRRAW6XzvB9I5Pd/rl+bUFWUuYxW7dOzFaoH0pd+5Rr50NZxUFn
 DI47EE3zveoWSVs/OkiXMrpGEfURUC76kVB+GkG6KLZXHk0gnveqFicRfwGQanHPd2Lz
 eeQQ==
X-Gm-Message-State: AOJu0YzKzmdiMhTZf2Ff40epsFJrbmWNY9h3TzLKdO+x1wZ0rkO1PyF3
 r6GzV5izCL4wfL8JBZVx6MsOrjKkd5fNu/K/MJDr6JR0iG0F1kDZdN85M1SJpIgdwyn2skXaKm/
 OC2GYNgWqIRjToAd54pClPtfSj+KF+vunrBQCh/4o3xT82pLUwfnPrWj6t3rhlhFxQmZnMQ==
X-Gm-Gg: AfdE7cmkjOv39q2dyQ2k172B9JpnlUZ6uzd1/pMEmOId71zcrkbfUjEayuyeZoaOdZD
 yERCrlLSaz1fyHlSAMu9TZMOrTX5cNlIXQwk9uhDedKOUO72QvAxIh6RXcX5bh9tqHexERM0cpY
 g9whXr/MwMN6ErbhDjjfp+RhvvddO0QYYPiL+HXoEO5hOqfHN3pHxuvOKReAyzAXWnP2IxhgDVB
 KnQn/V5J4jpaiyjlOXXInrqh/vsroiXhZPk4OSDK+qiHBmsKzO5eOT0DsZWP0OwP51Z5MiWdq2V
 XHRvs4gtMH8Bkx09fTSbovY5O0lqcQ5Bawja3aI5QK971AcMs37kXd2/pWxp5ft5UOle9yfUX6s
 lLcYE1vjhvtcHUZCbmc3A6qoxib//8WTgMry8eRhkaXzBv6O6ok/9l+7sbUSpq29eKRe8WA==
X-Received: by 2002:a5d:46ce:0:b0:461:c779:1e45 with SMTP id
 ffacd0b85a97d-46235e9bae2mr9463941f8f.2.1781779532858; 
 Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
X-Received: by 2002:a5d:46ce:0:b0:461:c779:1e45 with SMTP id
 ffacd0b85a97d-46235e9bae2mr9463902f8f.2.1781779532333; 
 Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm64765302f8f.11.2026.06.18.03.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 03:45:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/sysfb: Avoid possible truncation with
 calculating visible size
In-Reply-To: <20260618084327.46567-3-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
 <20260618084327.46567-3-tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 12:45:29 +0200
Message-ID: <87cxxojfee.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J0zLSAYmNEzctILfOF7SSNxGgGJGBUPeSp9p5S-mofM_1781779533
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

Hello Thomas,

> Calculating the visible size of the system framebuffer can result in
> truncation of the result. The calculation uses 32-bit arithmetics,
> which can overflow if the values for height and stride are large. Fix
> the issue by multiplying with mul_u32_u32().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260617114027.1F2A71F000E9@smtp.kernel.org/
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> I've added Reported-by and Closes tags because this is a pre-existing issue.
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

