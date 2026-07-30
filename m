Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C3BC54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C056910E6B3;
	Thu, 30 Jul 2026 08:07:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ANgJVxJF";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F61110E6B3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785398842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBck6paOE0M0Ra9bOgFPOF/il0J8O4K8s30LrHyhZdQ=;
 b=ANgJVxJFefNPV1cwvEolFHdyUhTkAZPEbdG3IZX26JQzABtvwir+vctbXg1UU1r8n3SYua
 /2dVFNG04+8k59bSoL7sXtjE4ukUQD61te07tXBFP9D3FHYT7p3UtQgS+x24dB0g6Ql33D
 lluOiE5YKNaxqyTrbM/cVD49iHFa5OM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-3sXrk0kxM4CVXh39_7NyTA-1; Thu, 30 Jul 2026 04:07:17 -0400
X-MC-Unique: 3sXrk0kxM4CVXh39_7NyTA-1
X-Mimecast-MFC-AGG-ID: 3sXrk0kxM4CVXh39_7NyTA_1785398835
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4954fd771baso3528885e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785398835; x=1786003635;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KBck6paOE0M0Ra9bOgFPOF/il0J8O4K8s30LrHyhZdQ=;
 b=TJRrBH06wVvhgdLMhBDU+98hNHUzhmZG1oPYe/00coz/d5xIlKhrgS5EFWabMqM1UX
 6hM4U/p8qxh5PnmtXzfVCuUIbMOyj5YmLXfiPQkEOx7uRGBuKPlWhDss2d8GMgYEdh+j
 Shz4Lsgm8yfDDhpvIJg/6YhyRFFjYtozfv9oOIS8fE+QeiFMOH4GIdvvwJYoaLA0/18O
 Dok0iJxQt2S0+7gv89mrrU5B11ahHwMwmE75WUqOqQjVcfoT/ZyFlOMxdSCA4wpIpRtg
 QVVS6gxHYkz3ooeiSUnDhwmuxIPDefGvVQ2c9d2hj95d8syQQqFDsapIQXaGPir65bxO
 KsiA==
X-Gm-Message-State: AOJu0Yx1jzySX+35iKmHy6+74xvb5pQ3Boofnj6kwaX6vVqJtF7WlOHo
 HfdDTRlRvuosxvxSAuP9MEPpxLQxnHQ5A1SufjirTSC6LRF10keyu1BlpEmoV1gmvRftxdIiDgL
 mkcotGRA2j/Kzcjm0WBAP02chqFme/TaHBweHqmMNWGalVONLTOpwGOev+z2Wxvir2LfNRQ==
X-Gm-Gg: AR+sD10TedyKuntfW2pN0DJuJHqKjdyjVDf4sXN1q2NCgSa6MPIpIkCjLyfZVBYftzn
 AZchsY/GR8OIMFamZlNUk5IshuAoRqVOpZCQrioFxLFJkpNIA//GpQm0TBz+TqVOdWWkIcqm2jq
 OW+9DPnZdS15zGWeTpYSOEcS+ESLAgTa8UYPAyZMkEGDWwdexZqjvmtYkDB0NGZBcigOtyiQ40K
 EubZgl9XMCdhny7YyTgdtzAa0s2baWr3DVjABKnEacQqZ67R+/G/vsWYFVgre8jS0ju2sIe8pJ5
 OHTKLTD6NYtzdNrXLq84Y2LWr0H5yJKQPN7R1nwGhU1LTrEIWQCQEVy4650OhPn139yDBwl8TYB
 93C5ITkb21LfttU79setEnotN3u5Z9OdBsJQv/8JRYA68aH7B9sdXcxtEc00=
X-Received: by 2002:a05:600c:19d4:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49801e8992cmr15690895e9.0.1785398834604; 
 Thu, 30 Jul 2026 01:07:14 -0700 (PDT)
X-Received: by 2002:a05:600c:19d4:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49801e8992cmr15690255e9.0.1785398834081; 
 Thu, 30 Jul 2026 01:07:14 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498019b55cdsm20712735e9.3.2026.07.30.01.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:07:12 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Amit
 Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 2/2] drm/ssd130x: Add per-family update backlight logic
In-Reply-To: <20260729053054.29374-3-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
 <20260729053054.29374-3-amit.barzilai22@gmail.com>
Date: Thu, 30 Jul 2026 10:07:11 +0200
Message-ID: <877bmcew9c.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MKH6G5DE2aG-9iaAHtLhgSF7PgivhEF2EJ6rjpXGRM0_1785398835
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

> ssd130x_update_bl() runs for every SSD13xx panel, but it only works for
> SSD130x and SSD132x: it writes the single global SSD13XX_CONTRAST (0x81)
> command, which those two families expose.  SSD133x has no such command --
> it has three per-channel contrast registers (CONTRAST_A/B/C) that must be
> scaled together -- so ssd130x_update_bl() has no effect on it.
>
> Make backlight_ops.update_status a per-family choice.  SSD130x and SSD132x
> keep ssd130x_update_bl() because they share the SSD13XX_CONTRAST interface,
> while SSD133x gets ssd133x_update_bl(), which drives the three channels
> through ssd133x_set_contrast().
>
> Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

