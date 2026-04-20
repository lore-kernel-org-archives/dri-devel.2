Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3069F327B3
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E141010E804;
	Tue, 21 Apr 2026 07:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DsKNtSOr";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E7010E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:45:03 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso6143415e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776692702; x=1777297502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrWPe/JKeOuhvC8+0ejqxf3TznZ/FI4EAfyXVKA2D+g=;
 b=DsKNtSOr7JdswKjfL6kcN44cBM+uw7QgdSZ3D2gtED8B73RQMJ15Y8PVVQpQ7C6/xm
 p0XoSQ+Y5r+3XN5jZUVIDFuBhopEbMwEJmPZ3pNUaLcI/WIigNv7+T3vaqefM6GWRp2r
 1r3u/Hk2w2wkr6mhpqP7vYiE6KD7s8s8yXam8ir1e3TSBlCXEDwZTpGnCYDcfrABISuq
 uPSy/JRKXTcT5tlANBT/ksoIPaDFK9tr+k6kF8s43mfRirXuFHt5c21dzqufCTK5ImDX
 1+tNHXWNEx0wLAbmIbw8isqkMWAQ1LkFr+yLr/TW+UEzuQSr1eVsti0WOYrig9X05xE2
 rp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692702; x=1777297502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zrWPe/JKeOuhvC8+0ejqxf3TznZ/FI4EAfyXVKA2D+g=;
 b=VfMGUUzX74Q/68gkhuo9ClVMePOG1Ihu+M+5cx/Cig4u95pbUWh38+dy2fJy/Q3z4Y
 eT0dCGQG+s0Fiigcg1Vj4/4f6yu949SRcLknr1SJm4sUrdbfD05xwJZmATxvtsciotyR
 mKMzXWcUoGJBocvgivIP4MPpP8FZ5W2WKjoo1B+6hExENP0bfwcA9zA5ODVNc9zYUvTZ
 LDCb9TYRsbcMLveQBobNwNiI5AuyqPyvmN50olAeQ3/f04IXml7Ah0hSUwoTSy+l5Cfy
 0tCTcN2+TNCdmJR9NnZ7r/5CMGMXkzKbL+FkbKtE3e/RfJxvQ3ZQVCSBoQEv4nbb1zsd
 gbCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SXBP0HXWtq0A4Swz6SEinvEk2VOunQq125MDZNQ5/rfqS8/yS3MWgrAaJPpxxDpU/U3tACs/BT1o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxILFguajZ4Fk/5le3eeRgOEvf8olvYWIrw2XWWXFndUHx8VGRM
 UED4OGxQatEUltzQqJZ8X0NwxPkZFCksIHdYoGBd3D3v8KD5vFSAH3/v
X-Gm-Gg: AeBDievcfRYiCvmsy6W7mmP7nptdgp227gGUeKjT1zClAKmLeRhJmI0vJx8RdR+QOlv
 204DS9D0h91s9XWn//+bS/1Zlquezi/+GsyOVE9cD/OBBeRCiUsmj0+gKT7q8Re+0KdsgQcsolx
 tHZa0op1Ba82oiltdoJhUTDEb1UiK39VzLMwS5sTmAD1g4j7yizOO+VEsWFIZDvsbCIyBca5P1Y
 xDh/gaVz1M6EKTELPdJXqqtfe+hqkIoaFtlN5p8TPDi0i9EtzEd2WSS0mCA5DUuVJPDT595hnMg
 EuyqBYURmr0gmyXBBhDPPsb5e99NtIBGnYTqWNrwJZ1oXafBvrn9haSUHyB0bvJnxp2e/73vNC5
 BCDvyjdWdKSGtq435hYWa8ftLb4bilUIRkcGCSmS2Vy/67QA5/rLP7uqUSRVirosih3V+9sRG68
 JeZ+trQzn/paMggpFjfz/dPJH08e60HvrfzIRDEzdm
X-Received: by 2002:a05:600c:8183:b0:486:fe39:28b7 with SMTP id
 5b1f17b1804b1-488fb752e3cmr161475825e9.9.1776692701909; 
 Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 2/3] fbdev: clps711x-fb: Request memory region for MMIO
Date: Mon, 20 Apr 2026 16:44:23 +0300
Message-ID: <20260420134424.77494-3-amit.barzilai22@gmail.com>
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

Use devm_platform_get_and_ioremap_resource() for resource 0 (the MMIO
control register range) instead of open-coding platform_get_resource()
and devm_ioremap() separately. The helper requests the memory region
before mapping it, which registers the range in /proc/iomem and prevents
another driver from mapping the same registers.

This makes resource 0 consistent with resource 1 (the framebuffer),
which already uses devm_platform_get_and_ioremap_resource().

Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/video/fbdev/clps711x-fb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 5e61a349a4ab..7a7db7100499 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -216,12 +216,9 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	cfb = info->par;
 	platform_set_drvdata(pdev, info);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		goto out_fb_release;
-	cfb->base = devm_ioremap(dev, res->start, resource_size(res));
-	if (!cfb->base) {
-		ret = -ENOMEM;
+	cfb->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(cfb->base)) {
+		ret = PTR_ERR(cfb->base);
 		goto out_fb_release;
 	}
 
-- 
2.53.0

