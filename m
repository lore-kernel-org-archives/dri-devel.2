Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63280CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E3410EDC5;
	Thu, 18 Jun 2026 10:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CAQ/J1hj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3642810EDC5
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781779603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JBl2ts2yYWW7grI0RMNRI+ZePWjfZxzm9ZlftbJqKkQ=;
 b=CAQ/J1hjnlJj86eiyH8DEhO4B3jb+yHsLY7spLiKFjASLLXrNx3iAL108gl9S5fb5cmq5D
 Hi/ZiNEtdhoFZSjT52cj83ItCWUiSTLBX1gqEXQ8cz2pOTwhVT/jDpAo2RE02gn4wmbbXG
 phGksWwRba4dl9w9VbmjZD4RbWjdNew=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-RIkw6JoPMTa6P0U5kFCsUg-1; Thu, 18 Jun 2026 06:46:41 -0400
X-MC-Unique: RIkw6JoPMTa6P0U5kFCsUg-1
X-Mimecast-MFC-AGG-ID: RIkw6JoPMTa6P0U5kFCsUg_1781779600
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-46010392f89so744988f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779600; x=1782384400;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JBl2ts2yYWW7grI0RMNRI+ZePWjfZxzm9ZlftbJqKkQ=;
 b=kPBir+SUNDIX979/q2lVYhh/x1ZZGqwzvlJPw5C64GD8WbHbFPKd8Y1DOBAS0K4WM7
 2jW0bL/vKLfOlgUmErnLExCeW1NZGrbZRLzhIVACYBF6AZX90wpLYk1HKDuzga6Ie9zy
 vTsRAxRvi6R5zd0o8cog7N9nAvwFcrzxslnVb4FS/sVK0KCaT/2kDVCPqvcbIz1FUvXV
 PJKYlziRJFOXE/OKvbozJVi2efp3iek/M2h89676ogOo+aXQCp35T0g458CSePMsn+aI
 kimT9B0ECTnsCquSwN/b78gbbboosjhQB14XEd+CHm4LcwDN9uQMdeG2CxqLn8bCiLrA
 9FRQ==
X-Gm-Message-State: AOJu0YwBx77XQLPwWZXriK6Pwxo1Wptia7Z66tcSE0bJdYclJpI03bS/
 KFfZ+TiSNm0wyQZYNzm7003U3/Q5918hKQdMWdnSqT9tIsARPXUdc8kE/L3xUTDXfTp+E24Dg5A
 rPtdQHJ8Le+3t5zVgNk3o8nSFhI0yu3ZTf8xc1oQcefZ/FhdPImaNN+K0elZYmcR3bxMvGg==
X-Gm-Gg: AfdE7ck56LYkHKEGepBl2yfBlAMpT1p/ubmBTcVCQo7p6PlmoEJzY73G87HhIsChxTs
 HaiXsK9T9M7S8B25sZ4lNYEv6DUBnkeyVRKhJziQ7UrqBV5/AG99ixPpwxcfGFQNatuU3r4vYQM
 OjKYIPHKJcaIosSNf+fp1wdNYt9w3A96xxix1xLMwM9h+stU7vZBX6BKHMVXZCOLX8oNEEnpigY
 GDMGTDltYFYDZRKAxpX2u7fh3Cmq5ePGdRaHWkMsQ3dwMhr1nx80aM6YUfVxNxzEcoiPEaNQ26m
 xj60l9I2J9H1iRGmUZpa+cNVLzdjbq+lm6PJ0bkHP418o8CSXewh3ScD++cQt5QtC0ZF9ZFQVys
 sBHMsx3ZUCaCEOp7jP9eEd1TMsoURZAQ+bIC0IJyDsJWJd1DHQ/o7H2YpxN/MqrZcgTJu5g==
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id
 ffacd0b85a97d-4623f3e0a31mr12353280f8f.13.1781779600407; 
 Thu, 18 Jun 2026 03:46:40 -0700 (PDT)
X-Received: by 2002:a05:6000:4602:b0:460:70d1:c75 with SMTP id
 ffacd0b85a97d-4623f3e0a31mr12353226f8f.13.1781779599890; 
 Thu, 18 Jun 2026 03:46:39 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm66965343f8f.28.2026.06.18.03.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 03:46:39 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] drm/sysfb: Avoid truncating maximum stride
In-Reply-To: <20260618084327.46567-5-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
 <20260618084327.46567-5-tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 12:46:37 +0200
Message-ID: <87a4ssjfci.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dXsBJzAur_qpqgT9K1VwWGRms4nhCHc7g3BiKg5XGjA_1781779600
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

> Passing a maximum as 64-bit type to drm_sysfb_get_validated_int0()
> can truncate the value to 32 bits. Use drm_sysfb_get_validated_size0(),
> which uses 64-bit arithmetics. Then test the returned stride against
> the limits of int to avoid truncations in the returned value. A valid
> stride is in the range of [1, INT_MAX] inclusive.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260617114016.5A5991F000E9@smtp.kernel.org/
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> I've added Reported-by and Closes tags because this is a pre-existing issue.
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

