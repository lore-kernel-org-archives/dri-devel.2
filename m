Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30249C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D9610F1A0;
	Fri, 31 Jul 2026 07:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NoPi5OCn";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C922210F1A0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785482414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dj8rz8VUz5drdM9tkyErMU4LmSj7E0FEy06SzAi9zFE=;
 b=NoPi5OCn0h3WDX3JFCmdG3hPD59OFTRKVlsJ7SGMaYIANEJpfBWXGVg0i2oGeaSPYd8YUk
 0O3u73Lw3jfOFcE+9EsLFuoQACuDOvHfVctBGHalTSdiCD+7EtOgUpmeSWliVE6k1Vk4HY
 XKtMJ2YOoUFXdFm3IlL7exgn2dUA7jA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-ALHEUEaIOZSP0Q9CqFQ7-Q-1; Fri, 31 Jul 2026 03:20:12 -0400
X-MC-Unique: ALHEUEaIOZSP0Q9CqFQ7-Q-1
X-Mimecast-MFC-AGG-ID: ALHEUEaIOZSP0Q9CqFQ7-Q_1785482411
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-473ac08a6a4so523850f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482411; x=1786087211;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dj8rz8VUz5drdM9tkyErMU4LmSj7E0FEy06SzAi9zFE=;
 b=Gee1vXpeYvVr80hZ0S8RkeZlnYBRnaZa92bKeZ1cc9Kt1YkdUn4DefQd2CI9b43VoJ
 LwxLgUKE4quBesf/PhCvuBVCjQHehFlxByEMwsqzv6uekMea7iYP60QSUTjniKjHTWiB
 s6VTAmix/cEtaKhCkT5afniQBy3oq1tR6eXsrpw0muLKJKKQNOK1tn55hpoy48WHNrtQ
 RwK4g9WbFN7u88x0fsVj92XXbljDS7QnNvSblPpt6xWJ8JtbCtvHwAuxo1/CF8SvxoGj
 v4piL2uI3BtrbTYgZm0OSO88y0JFso3gWnc+5uov21g7bUo2s3+C148oPB1WKEDyvFd3
 at1Q==
X-Gm-Message-State: AOJu0YwNIV4BarkXL3vYEY6d/40f3Ij/97j5bNEDBMsKsm9iw2p+LO9X
 IGA8180Z1r5AIWyB2WVKhhLbyRmFCN4ADi+wSMyQQS1akz0cI4YsuV2bNU6weJdmw0NKH2Bh/uz
 coRhFYQlzJQ8WoqHCndN6RuiZ5/LUHfZpijoKTq0VpUZUISfIqtdIKRt+dozAbcvLLQJfZQ==
X-Gm-Gg: AR+sD13/jg2bemXlhHhJLWStDQeVyCquUk3vc0tO8MyGTJxgMHDX95EijHhBzwji+hF
 G5jq6+VW4MOCfCfiAj/0Gu+DBojDQXOd6LMGIFNJ04oS+ImssMcDFQIUx27ZspSNlEVxF/mgY9K
 dKbzsKy//e5VThLkw9/4kIwalCA11YQgy6CM7TbPMAPdMb6pqVyBkxjxi3oUTq6rR1huDQYJB1F
 KMm4r9ADek8xofqbn5BRFjl7GCQdHy3ReCB/poMSxZDfUKA/6tRVj6/VVTpwEtEriw4q6qm5bjK
 h9LmumvyVVgJ3MWG82W3TjWhMGhWAiqE8bN/kBzUUnjIXZ190Y1UV0K9avpIgaWGsBMIRP7NG//
 MDQFr2xg0ANjxT+lc33crPdyxI+nh
X-Received: by 2002:a05:6000:4a10:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-47fd2ab9f6cmr2051934f8f.9.1785482411151; 
 Fri, 31 Jul 2026 00:20:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4a10:b0:474:b860:b7b1 with SMTP id
 ffacd0b85a97d-47fd2ab9f6cmr2051861f8f.9.1785482410614; 
 Fri, 31 Jul 2026 00:20:10 -0700 (PDT)
Received: from localhost ([84.78.248.203]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm1592645f8f.20.2026.07.31.00.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 00:20:09 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Amit Barzilai <amit.barzilai22@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Amit
 Barzilai <amit.barzilai22@gmail.com>
Subject: Re: [PATCH 0/2] drm/ssd130x: Wire up ssd133x backlight/dimming
In-Reply-To: <20260729053054.29374-1-amit.barzilai22@gmail.com>
References: <20260729053054.29374-1-amit.barzilai22@gmail.com>
Date: Fri, 31 Jul 2026 09:20:07 +0200
Message-ID: <874ihfeic8.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5Dh8omyufHfwqRaxnFowwbmNVs0KZhvBNLMrTrDVDNU_1785482411
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

> The ssd130x backlight controller adjusts brightness by writing the panel's
> contrast, but ssd130x_update_bl() writes the single global SSD13XX_CONTRAST
> (0x81) command that only the SSD130x and SSD132x families expose.  SSD133x
> has no such command: brightness is controlled through three per-channel
> contrast registers (CONTRAST_A/B/C) that form a white-balance calibration
> and must be scaled together.  As a result the backlight device registered
> for an ssd133x panel had no effect.
>
> This series adds ssd133x dimming:
>
>   - Patch 1 extracts the ssd133x_init() contrast magic values into
>     ssd133x_set_contrast(), which scales the per-channel calibration by a
>     requested brightness so the white point is preserved while dimming.
>
>   - Patch 2 makes backlight_ops.update_status a per-family choice, so
>     ssd133x uses a handler that drives the three channels while SSD130x and
>     SSD132x keep the existing single-register path.
>
> Note patch 1 changes the ssd133x power-on brightness: it previously booted
> at the unscaled (full) calibration and ignored the contrast field, and now
> honours the shared default contrast of 127, i.e. half of MAX_CONTRAST.
> This is intentional and matches ssd130x, whose contrast register also
> defaults to mid-scale, so all families now power on at ~50%.
>
> WARNING - NOT TESTED ON HARDWARE: this series is compile-tested only.  I do
> not have an ssd133x panel, so the runtime behaviour -- in particular the
> ssd133x contrast scaling and the new per-family backlight update -- is
> unverified.  It is posted now so that dependent work (ssd1351 support) can
> be based on it.  Review and testing by anyone with the hardware is welcome.
>

I've reviewed the patches and are quite straightforward so I think is safe
to merge them. I'll wait a few days in case someone else have comments but
feel free to post your ssd1351 patches if you have them already, just note
in the cover letter that depend on this patch-set.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

