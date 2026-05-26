Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB5FCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 10:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4E710E480;
	Tue, 26 May 2026 10:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WbaKozvu";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C998410E480
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779791635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MZLeaQH6dFx4A3siWeeBaKKVFSf9fS72LAcJjC0fop8=;
 b=WbaKozvuqhKo0legUjuSNLfZVRz9HehB9t14OmasAizfOaXnb9+TBsj6Wlibq/f0E1zm1H
 nMst2d0coSWbu/oTR4bF6fXNdKrR7fdnC0DD7i5H/UaYrSqSnpf2InFIYPQ/seXKdw+LaB
 aw9VGLi6VWnBXC1voRvDaiSnkSXr4uM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-lLHkzTr7OKyemJXXdE4iUg-1; Tue, 26 May 2026 06:33:53 -0400
X-MC-Unique: lLHkzTr7OKyemJXXdE4iUg-1
X-Mimecast-MFC-AGG-ID: lLHkzTr7OKyemJXXdE4iUg_1779791632
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so8452438f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 03:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791632; x=1780396432;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MZLeaQH6dFx4A3siWeeBaKKVFSf9fS72LAcJjC0fop8=;
 b=K1m1Fz8059hY9tJ3ICX7ISJ1KsyGSuwtPj4j5co9kTyRMGDaoNA7jq5GF/TnbnsfNU
 aGNevuiEI21lXJT7Uly7otSOIKtcDw6uy7bbtGKaMZiyhePEG1AMLRBlGhaoHOfdAr93
 ywLWpKMiNoUyhQZgu3Szicqovw8m6HGyTNV01qev5jQUw/4zfM+/twqPBdL+kh+/T/i9
 lHa+Pg0z0X+CLscfV+xSSk7Xi20NV5V4B9+Ncp6SGIew6MJ7OqkAdsWXneBXGxSsomqj
 IOzIzqLW7yBLwj/ow069hxQnCEAWQIQlry00xCn49H61Yi3aTyV8CUBtZx9x3DbQ2ihw
 ZUOg==
X-Gm-Message-State: AOJu0YwIQYYsFuftx/pRiQI7Fklozf4QjIlsDlScL2nI3OL/kYFmaLpw
 jnshM19TWh2G+BmBjIQ7MWcLjxR09Nz0mmDXbIVxweM9cGRl2ZvH/XVJecsd8aFpkc+MvI8fyd0
 tJBpfmJtKBF0hMj4yQsk5JQkwl9tvZb0ATySmbA0U1u1o/+C92rXb0LwRR3+MiTQmdvnfbFqEem
 AfpA==
X-Gm-Gg: Acq92OHyd5N1Xbk1rrE844O94AThEof2y764tjrUaRgLBx5TvYmQrw+TUfY7Dh4YqAH
 gxCn1csTf50yKWrG6TU05n38E6p4k5zzqsek7pU9WlwizQCh21NaSMTG0KjPbtrsIGETmSZ0gCL
 XHuey1HmXIgfRwl41j2wqpnXv8KYh4wRHZ99jNpzkb449fwBq1L1vCt6o0ANaiXItXlu+HtiSX/
 UXFevNfv9Ii6VXmCVycFfp//eXoxLEpPqaKUBInLhwzkAMD3NFWfHFns0EIHDXKaFKB1mkYncMj
 NXuWlcByd+isFO3bBNxKn5HFd1TZY+OlG+46wkcfSsBPuYWdaGbG6W0RtlJEDzqiqn8d4e31gJ5
 g/WLr5ffquzL+i79YwO9Z5PZL3zGuaDK94yBbPLntk2n/kgF0+lFqqakZ7/J8AuX/8x0q7E3Czl
 nZoRaE
X-Received: by 2002:a05:6000:2383:b0:43d:73d4:b2f with SMTP id
 ffacd0b85a97d-45eb38ca94emr31549001f8f.39.1779791632409; 
 Tue, 26 May 2026 03:33:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2383:b0:43d:73d4:b2f with SMTP id
 ffacd0b85a97d-45eb38ca94emr31548959f8f.39.1779791631873; 
 Tue, 26 May 2026 03:33:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm33219861f8f.30.2026.05.26.03.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:33:51 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andrzej
 Hajda <andrzej.hajda@intel.com>, David Airlie <airlied@gmail.com>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Phong LE <ple@baylibre.com>, Robert
 Foss <rfoss@kernel.org>, Sen Wang <sen@ti.com>, Simona Vetter
 <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v5 0/3] drm/bridge: ite-it66121: Switch to HDMI helpers
 and fix DVI output
In-Reply-To: <1f0d964dcf8a32297b9d5a854309c736@kernel.org>
References: <20260523-it66121-fix-dvi-mode-v5-v5-0-33b4468162f9@redhat.com>
 <1f0d964dcf8a32297b9d5a854309c736@kernel.org>
Date: Tue, 26 May 2026 12:33:50 +0200
Message-ID: <871peympdd.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fKqGnTCx6lq-FGW8JR9RWx6Hrt6M2D2w0xYWmHaCe34_1779791632
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

"Maxime Ripard" <mripard@kernel.org> writes:

> On Sat, 23 May 2026 12:40:57 +0200, Javier Martinez Canillas wrote:
>> Display output does not work when connecting an AM625 BeaglePlay board
>> to a DVI monitor, because the DRM it66121 bridge driver assumes that
>> the sink type is always HDMI. This patch series fixes the issue.
>>     
>> Patch #1 reworks the driver to use the HDMI helpers instead of open
>> 
>> [ ... ]
>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

