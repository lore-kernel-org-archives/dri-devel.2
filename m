Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265E4FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8168710E5E5;
	Mon, 27 Apr 2026 08:07:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CtIMzxf0";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E81A10E5E5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777277231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5gKznBol/LYrW+4yVKoHbKfOnsDINRJ1D4UBm+CrUhw=;
 b=CtIMzxf0SiYSxROAmRzqqEaNHIvI31Q6tIr1FMPMPA2I6fIOX5byp1odTtogVM3FvzvooQ
 7sZKGLA/ZBv9GlmViX0u26vSm3IOwKQJTGhGgNmVW/PSafrY3fbhPJ5L6xHSO8tQMBP6qb
 WnAWaoXQAilc/YWeXlPOTA/AtcDRY+I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-5pUzFVoVM4uWlVG-1oma4w-1; Mon, 27 Apr 2026 04:07:06 -0400
X-MC-Unique: 5pUzFVoVM4uWlVG-1oma4w-1
X-Mimecast-MFC-AGG-ID: 5pUzFVoVM4uWlVG-1oma4w_1777277221
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so90597825ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 01:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277220; x=1777882020;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gKznBol/LYrW+4yVKoHbKfOnsDINRJ1D4UBm+CrUhw=;
 b=oVmQtl5YD5xU+DFib8qJz41yx4gy8D9ORa8SgdUBWimVegIvwoDrwzRGAN21z9U2xG
 3KaVgWPgo6bKCAsiEINnAbI3NBK44hMmuWGNI5PD4xEP/GvES0wB8gNu6GN5p8O3j3nG
 vijAGYJwcJecGmR2KlEKmv44SliNF65/YISyqAFwOol863+NqpmJeBzYo2SN9SfZe9r6
 LHOUyhqmUHB7nqEqwn6Jr7JKY2lrKAZwHxABzx/4/Cvy0pQmFYnsX/eLeouf8t3c//BE
 +0Og4zPeuN4QFty1p6m24d2qhFU/dPri5ayUMPnqnEhWQCBvs30g5L9bEkwLQ5d1AwI5
 MtHw==
X-Gm-Message-State: AOJu0YxQBhMPXnVnMOkXdFy+J/ftmYzLKEcN50ArsNXJd4GRTBbQ2bjm
 20r6ccUbJqlZYSTI0NV+71PmC+MrgLRoO4VAoXkewvH4+ztBBkmyGMI9WfF2Ag1D39raePI8UhK
 /+f+UKXJYLNWtK0viS3DBYpsX8Pukp8gAeNGCa/Qyn3VctfWMCo1GKOBjwvmSYKsqvc5Gx37JAN
 DYHQ==
X-Gm-Gg: AeBDievPCfXWGOWTbhvoz9Lu2zr8/yMTkxv8uflqMszz64xJN1kFk/fm/FWhTHXmXjG
 wy2y7pZ0UpZFT3TYFyIzFnuRLxxjZoIP9KHTqXjt6wwHTvYXjJCLcvj60h67TuCcsXw3TPKN/rp
 jkBxsQsjlbfoaOEZh516RTdX4I3fch33MfDEuDsbShEKj31CUOPFq6SjnOMqk1qhQUAgNmBDnv2
 Wo0XnBeBcgFnDaXkOrFT57igrCj46Ijfr+Y96X5Qqvg0O/dk49LCS2BnXGt750x1FYJ5iFo1b22
 ROkd7zrdiQDlxcsNBTevAZ4s0SGu0367NzNF1R4KnvtTiPtVp50i6DoBGood3e3XODwHMypcRo3
 Chb5bztALDFuHRlrf0FB/m57UD/I098eREw0BdEMBsusapudkPRKGUcN4M8c=
X-Received: by 2002:a17:903:b8f:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2b5f9fc0641mr424621815ad.31.1777277220228; 
 Mon, 27 Apr 2026 01:07:00 -0700 (PDT)
X-Received: by 2002:a17:903:b8f:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2b5f9fc0641mr424621475ad.31.1777277219721; 
 Mon, 27 Apr 2026 01:06:59 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa174c3sm294859805ad.21.2026.04.27.01.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 01:06:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 5/5] drm/sysfb: vesadrm: Support power management
In-Reply-To: <20260408120722.328769-6-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
 <20260408120722.328769-6-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 10:06:53 +0200
Message-ID: <87qzo0omhu.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 85hOVTj6ZbrHM7A5OpCw7wMi8pSSYah1GvNOmEy6Wbc_1777277221
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

> Set PM ops for the vesadrm driver. Suspend and resume the DRM state
> on systems that support it.
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

