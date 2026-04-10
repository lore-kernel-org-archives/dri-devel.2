Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A35F45A0F
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3F0810E9D8;
	Fri, 10 Apr 2026 21:28:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y3Et7+6X";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A40E10E9D8
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 21:28:25 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43d5ec211abso1325500f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775856504; x=1776461304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cMYMwDgqRuj4p13g34/4ImBkrRkjiSUEbDo/cw8pGuI=;
 b=Y3Et7+6XfJkbqgX33cGkHKCGS2aO0BXKY8PJdfIv2tYL9qosGdwmJn6mhIZ0i8yvXk
 Ifnm5tdLWCJ7FM182PiGZA1vPA3MEU5Eu0kH7Apyar1B8Gf6WQVvHBJiFG0tay3RE7Na
 RBpgo0ulUP9MjL4L4kw+fBbsFjMyn4n9ENK8hgzfWZMpz0Xlw2CjVizHQTUpcnPC6H5w
 AgL5e5kdCe65zxBGPHI9juua7MZrktO69Gv2KzQ6VP+deeg1HtRtT4/wc2yQfEg+u4+y
 VKLRtTrtg5hJLB+GKOj3CcUFFyxkj7aIw9guC77VPlreDcWp/w/H612TIFvv6d3tC6rH
 BpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775856504; x=1776461304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cMYMwDgqRuj4p13g34/4ImBkrRkjiSUEbDo/cw8pGuI=;
 b=CPzZt3K+kXH/0jhbM6rRrCWkWU6gNeKINvlb0aykkfqtd3UT/9gATqLy33fLk3W/KX
 le9p8+5epiPJ305h1JLISctFCuenZN/W1FES2k/0Q1sBxFLIp/oxfSb6NN46w+eNVNrj
 jQIPmVulQ1sAIO36VDrODhELjW+7sWIanu465XmZ9RO9i+aoZM3OukuJCcXLjkaSV3B/
 vfoVLWV0Spq+pogKkz09lcenK2G1U+PMHwujHz8Crgs3LcsXaRUAVNqmFp0vhau4XHJ2
 TnVTy0pTzdIJZYLt/aYaISQa1rfbksxVU7pBPfsG+4agqDKJox1WbNSheGyr3K7ZND/5
 hK4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT2De4aeumA0ZfbSd3o3z4aP1IbqUeMp+1sMvR2LHEncFwhjea+OAnyU8KMnBAtFoc+yimQaQ8mzI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxb9eK3OnbQ+6EtKdN+XnD+A4fnXRCypcyYDBM2yrc4UgkT86Gn
 sZb1L/isWjEPx1iKfl8U3zuAYnPzjm6jkCaaWrp3c0wQGzsoZihjUZDq
X-Gm-Gg: AeBDiet/Kgh9JoTxcZFhP+ysxvf5G3gTd7pHdDeZGD5NFdGWYY4n+MgoX9rP/gnitVw
 l8GJH1p7hZFsFr525UP5iBzvr5CfWR7/jKJcWu6GOhAHrNRjvkhZUta9KdQFZJOjc/nhlYFCwLQ
 f6H6hEv4LKbGOxeieHNjAA6ng8wX2z/nxm3qrOmnvdAHwhRWj7Kf7spy0Q90Lts/bCddS6mRrFV
 kRFtDwvtGsPQYGkiN4oLfq7hZYxkBzGVXp5ZVwzTwg2RCzOze8b8pH+DCl6UhhaTtoViPaUiWVZ
 hMDEjpdu8XN8hPA6hbfNeQcHd18UuzHEmt3XeE04NhQzlgaAD9BbU90fLrnXdx5yAX7vtB/qJii
 pnJOa3LWXKe96udHbzudqXBNiixFOU68rcQ3Ilnl5V7X9qpGcv/BwaNY6PoWn6J2uOQ/MJeg/Nl
 zCyn6m9sHXGsMb7JHDpkFv7qt22N7LmDnmbRy0f8sQNdJE0cVjvV4opB3BJqk=
X-Received: by 2002:a05:6000:4007:b0:43c:fbde:3101 with SMTP id
 ffacd0b85a97d-43d642e7cc5mr7285078f8f.41.1775856504051; 
 Fri, 10 Apr 2026 14:28:24 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:d356:742:cb75:6153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e50015sm11205992f8f.27.2026.04.10.14.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 14:28:23 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@ge.com>, Martyn Welch <martyn.welch@collabora.co.uk>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 3/3] drm/bridge: megachips: remove bridge when irq request
 fails
Date: Fri, 10 Apr 2026 23:27:59 +0200
Message-ID: <20260410212801.413827-4-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410212801.413827-2-osama.abdelkader@gmail.com>
References: <20260410212801.413827-2-osama.abdelkader@gmail.com>
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

when devm_request_threaded_irq fails in ge_b850v3_register remove
drm bridge before return

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index c9e6505cbd88..b54b6a9c9307 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -261,6 +261,7 @@ static int ge_b850v3_register(void)
 {
 	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
@@ -277,11 +278,14 @@ static int ge_b850v3_register(void)
 	if (!stdp4028_i2c->irq)
 		return 0;
 
-	return devm_request_threaded_irq(&stdp4028_i2c->dev,
+	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
 			stdp4028_i2c->irq, NULL,
 			ge_b850v3_lvds_irq_handler,
 			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
 			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	if (ret)
+		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
+	return ret;
 }
 
 static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c)
-- 
2.43.0

