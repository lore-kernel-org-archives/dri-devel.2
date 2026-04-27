Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4F2FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 735F910E5D5;
	Mon, 27 Apr 2026 07:37:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZdEJ6Frt";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9578810E5D5
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777275473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nQ56kkjKRg3okx4YSXRJZ7M+kkFW1HDAAwVC30lNr1U=;
 b=ZdEJ6Frth2IipJyc/37krqQGV7/WbQ34Fp2FxGb2oXRBOzaxj3FbL+wid1wE/nIbpweQ+y
 S+wB89dTUo/bjKiFUaIooBnwJH+SCzNVFRqyhIVbx+jlY3rJhfNy+IFHXdSbqjnlMfUgxE
 1aAmW64cKcY7dwRovhvmHn70iAahfJY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-x7wDNnIoNRaWrFvhjqe6Wg-1; Mon, 27 Apr 2026 03:37:49 -0400
X-MC-Unique: x7wDNnIoNRaWrFvhjqe6Wg-1
X-Mimecast-MFC-AGG-ID: x7wDNnIoNRaWrFvhjqe6Wg_1777275468
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d9f68d00fso11557013a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 00:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777275468; x=1777880268;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nQ56kkjKRg3okx4YSXRJZ7M+kkFW1HDAAwVC30lNr1U=;
 b=i4aNpxIhhdQhDrKudtdsDErxFXl2d6FXX9IbaHCZdXKfkZzgyGc+96Jj32tIZPECAv
 y7rYK3OXme0jL1hmcfY2qJ4DTUgpxEkfEh35y4GoxQQVxaVAgE5n+TQw2dbO95VjPvTc
 hBCmBeFiPOOpoewc+AdfVSwVFASznJ2kvFPayoCdMuB+/FkxyqGtpnVcGVT7Vf0TcMHJ
 9XojE6WoAAygtEtxVNOtcw5Z7nCGY0VU7H9om7a68sr/4cYFTMXm5BFKFSbXF6nvIcD/
 MZpKIrM1DkqG4EQhSgOpPYBhnEq2hWPhcPKBThGy1Tu9F7VzQMYBurtIvdH9f44a6L2w
 kIHg==
X-Gm-Message-State: AOJu0Ywx34p2L9ofHZQGDsMrRZG6+pzrvXB/LheWJYvdfYABNY945wiO
 p5b29DZyX3tU27xo33FcaMOzU4POlDFckOsUAwDF9K0Z33ZjLfjxPwR2xVGI1U2S+fbCXezK6mv
 1X8L/ZkUbfFS5b5gALMvExZ566n+ZMxwW5CU8qP8I86IOrUlKXZopjQDSNNYag/P1pvyStQ==
X-Gm-Gg: AeBDiesNO9uf4+DXiKO93PsRFD7goHXZ02h6dObWWBWF+FUMfPJPg4JV7uhIkLlVO3m
 +MLJMPbC5OOWLveRy3MqIZuk+7AhqeMySd0306ciZ/ERRd1FoAuys019lJ8sR01n0XUttrUn6Ag
 sAzlZYIL8IJcvUtpzPVe9/8MpD4MkSfjEdBZgBL+WT/xxoXF3vhxoDXdaClkQIBIHt4pRohWigJ
 6v4w7NSTvJFST03p4aTJFRR1wVnBe+WWB9q1JP6Z1vFAV33ynjAb/NUEJE238hV8d3cUli5Bs9+
 TaEe7k56VDG2vg4acWvTer5Sj5wldEbYD5R2tdVlzneyV7dog7M8hDOfzjEMSg/f4sD2+SPWRkO
 Le1oEdOM5BX3uYX+vYbGcQ9kf5946R0+T527qyyMFSp2QNCqvBPChlHdohYk=
X-Received: by 2002:a17:90b:48d2:b0:364:7464:12a3 with SMTP id
 98e67ed59e1d1-36474641333mr4006498a91.10.1777275468425; 
 Mon, 27 Apr 2026 00:37:48 -0700 (PDT)
X-Received: by 2002:a17:90b:48d2:b0:364:7464:12a3 with SMTP id
 98e67ed59e1d1-36474641333mr4006477a91.10.1777275467877; 
 Mon, 27 Apr 2026 00:37:47 -0700 (PDT)
Received: from localhost ([149.6.131.75]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa30047sm305655145ad.28.2026.04.27.00.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 00:37:47 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 0/5] drm/sysfb: Support basic power management
In-Reply-To: <20260408120722.328769-1-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
Date: Mon, 27 Apr 2026 09:37:41 +0200
Message-ID: <87340gq2ey.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z8h2-wChCVvmSVSMDNs9Evy_LU8QirV8VXhjjSKKL1U_1777275468
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

> Add callbacks for suspending and resuming to the sysfb drivers. The
> helpers store and restore DRM state across the suspend/resume cycle.
>
> While most hardware loses the system framebuffer setup on suspends,
> some systems do retain the configuration; notable emulators. Adding
> PM support makes it work with DRM.
>

Interesting addition, I wouldn't had thought that the state would be
retained during a suspend/resume cycle. But I guess that makes sense
for emulated devices.

> Tested with vesadrm on qemu's bochs device.
>

You tested with vesadrm, do you know if would work for the other drivers
too ? I guess that there is value in adding these to all these even if it
might not work outside of emulators.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

