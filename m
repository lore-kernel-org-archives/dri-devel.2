Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B603EA7188
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 07:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECED10E065;
	Sun, 19 Apr 2026 07:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwJMZOqk";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3710710E065
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 07:19:55 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36143b0dbdbso1061808a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 00:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776583195; x=1777187995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=16qfSjxADYNl7GtbwIc+kV6QZuKyBUiQ98NQ+hJo/bc=;
 b=EwJMZOqkjD8dSsWqBV9s5XFr7s1aonVsoX++DdAMxswiBWXD31WIQU2PQ7RbZKW2RJ
 Ww/VYzprm/am9ZCNI4BWtttUOpWB/Sy9TjuQS2rYc+6AIk5ozo6Z0qiS+cIgPxiajaVw
 C73Nf8rfEbV681aI6S6r2owKRxVYTlu9n09ufY3TBO1A4U4CKIsvsPUg/ML38foPPXKf
 L9opuLp/DcOlEhZKb+5UslMgKpxXK2B7m00NvI9u4tXgsqP3bG3Osc2Hy+Dw88a1VfWe
 ouRYUwBEGV/BPhWgWLE+XmLey7HC/FTh5tlnCvhHgtJUzOLWdRd1x0e7Fidpe1CtMLhJ
 g7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776583195; x=1777187995;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16qfSjxADYNl7GtbwIc+kV6QZuKyBUiQ98NQ+hJo/bc=;
 b=R+IDR0qgtzr/yYFavQh5iqmV4Xw9UzWNr7T9VScbuvIDWrrotJuD+Szy7+puGutEyy
 3cvyszdEThEDtE+eWuBIgreYQ/pg2cHHWdC3w/Hx9xRfeE7/0VA+m4lzFHZ0GCsdCkwK
 qFDzXK8LPvbey1RdHEaXFEaewDPGJfjKg6vUf6FoU4XHJqAXc+Yz3vG6GYuJ8uzFwc4w
 PO4gSZ1xSW5T0DclVfjl41piw6jDKKy33TcgXNMSuOGDMOn0OM2E9dOOhjGJOhHG4IWq
 lzzd3OCgovAhWV5gGIfG9AyyJfnQlTX4OitWNnj1SW8q1W+HKzOT1P6qqGoCSRLE6OVF
 vS7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8HdoZFlaLo/BaOShYKCY8OjdDPVkwlrxcfw7pCwWXppojV/7F36YybcZJyuJeLo4TsvPmEOFUwvLY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5aMpTjLTvrPTmDxT/DK+5zgH6owN9wkWTlWrMjjoRddKMuYQh
 LYuprC6XfJcl2cVDNkWg4zEr68zoy7WzEcq/NbAxCDSBP888+zmgkDg9
X-Gm-Gg: AeBDievsTmxUFzGDdlo4xXiIaoKvvJhKUNqY0UOLLBm0BiYqiLJ5RmUmJKxFmZ5shVW
 jLjfA6FYlr6e2i9JvmjbblVQdsaUcf/gyHgXz5AcRVj7PKqbDvmeT01Gy15imMKHAJDjkakslL9
 DLxZlZYSfyjkw+7EVw/ASCY9rHUVdGiHmjm8Re0flrGOuru156pm+95PO9fk4YSaqgov8s6aUsW
 2LsHyQ5HXZe9WB8RyYLLBFhU/CjmwiEJO7HetISOQeuI2FIgmHeTxs8CvjEyK6ivfZBas0mxXDX
 XC1soyYwvFFpHGCQKzC1Vk79ZL7/AyutgdnU4LmgLHPoWhHihy3EQHGa3laF79zQNykY5toqQ8b
 uXxXeTD1tPmvAHSg0LITQfw4BT1DwRCuiW/BJw1zQ/u+HDbIuQ9aYMa1fenOzvn8Ga31od7qGP9
 KB6iHvbQaGDjEyWpn8czy8ddj7SHwRgW74HEyh
X-Received: by 2002:a17:90a:c110:b0:35b:e529:2d60 with SMTP id
 98e67ed59e1d1-361403e1021mr8633079a91.8.1776583194604; 
 Sun, 19 Apr 2026 00:19:54 -0700 (PDT)
Received: from gye-SER8.. ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3614198f775sm7730486a91.16.2026.04.19.00.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 00:19:53 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: Oded Gabbay <ogabbay@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v1 0/2] Fix dma_resv_wait_timeout() return handling in
 rocket/panfrost ioctls
Date: Sun, 19 Apr 2026 16:17:14 +0900
Message-ID: <cover.1776581974.git.gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

dma_resv_wait_timeout() returns a positive 'long' (remaining jiffies)
on success, which is truncated to 'int`.
So userspace interpret that as an error.

Each patch explicitly sets `ret` to 0 on the
success path.

Gyeyoung Baek (2):
  accel/rocket: Fix prep_bo ioctl leaking positive return from
    dma_resv_wait_timeout()
  drm/panfrost: Fix wait_bo ioctl leaking positive return from
    dma_resv_wait_timeout()

 drivers/accel/rocket/rocket_gem.c       | 2 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.43.0

