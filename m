Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EADC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F3710E16F;
	Wed,  1 Jul 2026 13:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="M/X2u51W";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E367F10E16F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782912199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POBMS69xaTAlDO61cGtQgpgznOnVcF/ICKu09umviWw=;
 b=M/X2u51WWZo68HjOG3/sj9DApOwnM2DpscoxQB651UPfHigvl6Ltt9K90Sa4V/HWsqVTVS
 nwDxzPqChmXwl1sYKFWJr0So8kL5VAN2CIPlF7UK86OqIfsqE3yPI/GVBECsmIHUY5wrXC
 Lvcm6cTeZaXKB9cA1VjrLfkDzEdRL3E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Qn8fbkMQOcaRjrUP50xvIQ-1; Wed, 01 Jul 2026 09:23:18 -0400
X-MC-Unique: Qn8fbkMQOcaRjrUP50xvIQ-1
X-Mimecast-MFC-AGG-ID: Qn8fbkMQOcaRjrUP50xvIQ_1782912197
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-473de38dcfaso432575f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 06:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782912197; x=1783516997;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=POBMS69xaTAlDO61cGtQgpgznOnVcF/ICKu09umviWw=;
 b=XWaZG124H0B3BW2ZR6QmckBhAQvG1zhTAae/OAcg5iYds8sbu62Ejl2nx0qjsHCznL
 OiAfKu3c0E++9ZriybgZcR/JqJYvFuDw2qqfkANpEBRlvrbJajh47qgo3W3V5UcWnY1j
 roTEp6UkDQSl2jlxN4jhn7km3MqhRigu2WgFGsSGjU/H90muOVfnUiZhRMH3ioGJkCGv
 VSkqlk9g2vdrwZDdHxSEXErZe9/1xLA69Uc+QlGHFEXFrCzqO/fg/lkZ6z/XXJ6rJssa
 wjXsWl1k2KHmU2uOriRr5pHqP7MDnfwQKtMckzL9bTohZkAPQP6/21KE382E8SGc+8A2
 WGxg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqX3C3QigGXq1FghZ5vS6N5nffgUSk/ueDO1UUH3AY63HrKDr9UTz1TVF5+Irrk5TZ70u6kMopgh4s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdAuT4XBHgYzku22xoBDgIfWWZ1Zf9t/NRf/UdhDvdNWMaR950
 rDu/lvOQrhNO6VQ5sPhGxyZ5TCvnZPfqSiB3C4cVqmZNNC5xjVbANznpa35K3JX1Oy7ZmPOZJ4l
 yLglrQWOePo0odohvm1AUXV0XGmOpEfmthopOOmBvMRiLK4sH9Y5CsYE3OytJ5SNJGOahEQ==
X-Gm-Gg: AfdE7ck4heL08TC8sWJb1IOKAstxOGg+OhamawqQVqO4NOG2qlv3wWbosYdp7HEL6uF
 XQwvbvBGKC1ER6+DLnNNzatfO5Au1pNBZ/0NhiPfAb3S7YJlzTiZ3IeFkjfFG98wEWqvJxFaXbA
 Cbio+5LfZWCTWTSoI05vujR08EBtpwjfjXWLnskdOIKvVYK02k0qra1+aO0TP76JQblAVj3mxAj
 saXlJHDHSoyuwYii7H6G79hvTPGpR6UcXTPn8kWGEaWS5O4IWVFAN/Hv+ykpDhkcZaMGBVT35Vm
 +/HCfjMvu9SJVz2CJVwLX4YzW+w80NPEPgk0+SOz092ib6qEsK4/wU3v7Bp24KtU79mTn00WVYI
 Z1KfjCr4XVuWsrxLtSJTEGvElmSLYCL8P47eBTsMd/jCDSDQwYIZ8VhrvWPzzTaOyNC321w==
X-Received: by 2002:a05:6000:18a4:b0:465:ba53:a006 with SMTP id
 ffacd0b85a97d-477588e7d03mr2696730f8f.23.1782912197078; 
 Wed, 01 Jul 2026 06:23:17 -0700 (PDT)
X-Received: by 2002:a05:6000:18a4:b0:465:ba53:a006 with SMTP id
 ffacd0b85a97d-477588e7d03mr2696673f8f.23.1782912196607; 
 Wed, 01 Jul 2026 06:23:16 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cdccsm15726626f8f.24.2026.07.01.06.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 06:23:15 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 0/3] drm/ssd130x: fix column and row end address in
 partial updates of ssd132x and ssd133x devices
In-Reply-To: <20260622122604.32500-1-amit.barzilai22@gmail.com>
References: <20260622122604.32500-1-amit.barzilai22@gmail.com>
Date: Wed, 01 Jul 2026 15:23:08 +0200
Message-ID: <875x2ydetf.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iP3095cbw1sRsbmXT45yM9fN2yKkfY7w1Z6Jx72_JpY_1782912197
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

Amit Barzilai <amit.barzilai22@gmail.com> writes:

Hello Amit,

Thanks for your patches.

> While working on adding SSD1351 support to the ssd130x driver - I
> noticed that the area of the cursor was refreshing in a weird state.
> I would fill the screen red while the flashing cursor was on the screen,
> but the screen wouldn't refresh the entire 8x8 rectangle each flash. 
>
> After reading the SSD1351, SSD1331 and SSD132x manuals and manual
> testing on the SSD1351, I was able to be sure that the problem was the
> end addresses of "Set Column/Row Address" being sent as relative addresses
> instead of absolute addresses.
>

Indeed.

> I assume these bugs went under the radar because testing would usually
> be done where the dirty rectangles would start from the 0,0 coordinates.
> In these situations, the bug would be invisable, since adresses relative
> to 0 are the same as their absolute value.
>

Yes, I believe that was the case. Thanks a lot for fixing these issues!

> It is important to note that I didn't test these changes on a SSD132x 
> scree0n or a SSD133x screens, only on an SSD1351. Manual testing is
> advised.
>
> This series contains the fix for ssd132x_update_rect, a simple clean-up
> patch for ssd132x_update_rect to keep the function clean, and the same
> fix on ssd133x_update_rect.
>

For the whole series:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I plan to push them to drm-misc-next rather than to drm-misc-fixes, since
these have been long standing bugs and the changes are likely to conflict
with your SSD1351 patches that are in-flight.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

