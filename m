Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1379AF327B6
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E19310EB70;
	Tue, 21 Apr 2026 07:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qTq2C/Jy";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EE2410E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:45:02 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so47516635e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776692701; x=1777297501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lA60hJOVBSJE2U3bgFqAWxtT9r0e0fushLu59yGaJZQ=;
 b=qTq2C/Jy+ahwzTBRSzWUEg1deIHD/lY3ULAcyKplfZkQvYPoCEWLDCWLNhsyjsSFSa
 warNQJTi2H1qBF5yyfOjk9oY3yl8w7976thriINrbtAp6DUPrj1dOa5OlOM/eXmrUMT7
 RhSigKeckQPsNzB/OZi0hBgxtvU/fiMCuIRo9IkY8tQG7GRfUKY3Hc3h715vbN2nlHoo
 jIymmU0nxldIbvu1i1Gop6+rTkgqyJuVnIVh1OWperUI54gzDHC1O8J1YvP5x1TiHqvz
 RdRY92Clt5WONZ5Sj8l3TCdSrQ9GYTd20EK0PTyBQffnMy54FtACydz4VTlWj8FxGjYY
 sxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692701; x=1777297501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lA60hJOVBSJE2U3bgFqAWxtT9r0e0fushLu59yGaJZQ=;
 b=fnDKIwBB6VO1WEufv572V3NHbgBu/QaTy1gom0JMjsK/989qcTZ0BAUjldsGVo0vXs
 xUtdBJ8CrRFb//8CvQ1fMq+apf0+1vGC8k+pequ2D1tc1kzxBwhafT84Q2BmfztViO69
 yvVkcojjlpztGp0ZSlxNRg6p6Ju+dQENcFBqCpf3bsx0s8TD9cOURB3100ySIrBt7V7K
 57gMAym9OhX/aJkKW71ETKfDKqGM83Qzqv7d/hFpwrV341t0Hkvd7O/08APchAx8rUje
 8c1/YRL2p/vGafiHFBGnNpJNYR2ReioQLyZwWQX0zIy9sORK6dtFa2hoOrKlxnHGkVk7
 UXaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/T/6nmbE5nAXpqQmiylXwZ/cZdrhoNH8Iad7TCh495npldo1VvfKStXdwfq97QBudrQKmqTg5mcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxg6I/GSNcEkXf1srEoEho2jDXuHmQQT653/QHEqGIMEJuaSTUS
 jRzVBzqp0FHmSMqgGKtOwSHO3JbcbygIPumvAQ5tXAZox+j3it1bF3Sd
X-Gm-Gg: AeBDies/Wv8oVI4ac2Gql0LiXE2taYRMFDCture4sjqIWkrQWrM7ekBTAeADq4tlP4i
 2grFg007kWsLKq2P0sTGixQ1x5ADLjGGmIacQSy+JiSQnYrm8YHKgK/muecKW2p79EnYvdN/Zlv
 LWYxEeHTbOZNc1C4R1SNW6nqDxvcUkUlLC8C4ZRfP08rNPkBruo2jS2FTh2KnrLNvWF+o1NEGzc
 Wqa7lW8IOVzhSdH4hR5QU1codIVVTj0NbxpexWS2Ly2mMu/ANzR9POQDopccb+hUYhi8XhRLQF4
 xqgKder/OBIXAVi+EK9OSaP6ZBEsPJ+lowqXoDkD8ifovfmZQzHGgWDvq/tvD5afYiX8omegzhf
 bL/3GwwOefshoZzz03O9yNqN3lyWp+VINkzStUu/Tf20UJJ+ey0RlD036sbsJzmlcPpXXOuGJ72
 GujwYiNn8EKbO8YsPC+IvoUwAp8ZV8Mga4tvv8tZdL
X-Received: by 2002:a05:6000:1ac9:b0:441:1c06:17e4 with SMTP id
 ffacd0b85a97d-4411c061807mr2455722f8f.39.1776692700590; 
 Mon, 20 Apr 2026 06:45:00 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:45:00 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 1/3] fbdev: cobalt_lcdfb: Request memory region
Date: Mon, 20 Apr 2026 16:44:22 +0300
Message-ID: <20260420134424.77494-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420134424.77494-1-amit.barzilai22@gmail.com>
References: <20260420134424.77494-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Use devm_platform_get_and_ioremap_resource() instead of open-coding
platform_get_resource() and devm_ioremap() separately. The helper
requests the memory region before mapping it, which registers the range
in /proc/iomem and prevents another driver from mapping the same
registers.

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 308967b5096a..f7faa95fefd3 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -295,19 +295,13 @@ static int cobalt_lcdfb_probe(struct platform_device *dev)
 	if (!info)
 		return -ENOMEM;
 
-	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res) {
+	info->screen_base = devm_platform_get_and_ioremap_resource(dev, 0, &res);
+	if (IS_ERR(info->screen_base)) {
 		framebuffer_release(info);
-		return -EBUSY;
+		return PTR_ERR(info->screen_base);
 	}
 
 	info->screen_size = resource_size(res);
-	info->screen_base = devm_ioremap(&dev->dev, res->start,
-					 info->screen_size);
-	if (!info->screen_base) {
-		framebuffer_release(info);
-		return -ENOMEM;
-	}
 
 	info->fbops = &cobalt_lcd_fbops;
 	info->fix = cobalt_lcdfb_fix;
-- 
2.53.0

