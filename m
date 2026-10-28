Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3B606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fK2vDaVj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF509112041;
	Thu, 29 Oct 2026 07:58:58 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3721F10E6C0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:16 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-36a1947498bso69977eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205975; x=1793810775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8CUKVtB3M6BDn+sfH3x5H78DsA3Gm3b6pTU7+cSsPOk=;
 b=fK2vDaVjLPEgXBZ8sJz1E/ZsgaQ+NWj+YQxqZgXvJ9+PcCmwXIZfkh05JyaR+0NnWd
 F6hS0owq1aMaZvjl4XQIr1YADMKjfzNPXDuOjBLYIGapmaJfqagnvWAwurZm74JopalN
 JHWmNs4jc2jjHo51tW00jhz6S2CDQ/ro31TQQi3IoFKD75Zx7Ee5Sl6tALNAm+XjaB6B
 Rhrpe1NwmL1BhYkmaqbe86SRVWgrMTQamvsaeLs+jgHRWdN4aUJ43C6+WUQYNHRZUDT8
 QkC6BzbhswIkLvMmbHkRRdZk/Cbbe01z3sZGh+kBh0UdENLUht5SLhnenJbanVHdk5AP
 Umzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205975; x=1793810775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8CUKVtB3M6BDn+sfH3x5H78DsA3Gm3b6pTU7+cSsPOk=;
 b=Shy6ZJB80SR5Dpp+92thWVM5cn6WOWJcS22boH18EbkECZSRcJSS+2ZEOl4ynlnKsi
 jpA1Ky1Bk7vlee6QeGGEhgL4p68pT3Puid93obE/c0lN76O6iGG2yOVIpW/ETTiGDcEC
 iT0mQNxDmDZPkBQGmPyY+8qAAGZUGI5FAR2i6O4EnLOIXE4G4ERjB9AVpAa+f9gsQmVi
 r5p86RW+TJ7F8sd0s4ipiZmKJ3ob4ALyPr3GoCa3b2umJi/O8Hyfvg4p8nNVZ16beX4x
 k3FdFnWXqxyNaqorTKF7QkQWvLpyOtVqVnbBI/ano4yGnLLmozrotq+z3/KkX80PrA1b
 u0vQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx81h1/6+347Pe1RdyEcs7MOjOonoOFSBGFmLEQu9zFo6CPVqyQvTPaWd/fJnT2Xgu6S33ErQ6Ydb8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKTxWiy63jwLVJmXm1L9FvAFhISgQNLt+qXRta7oZvqsk6dU8j
 M9Sivkb2as9UlZaf1VqIfE2XW359sj2VZ6Bk8hyvpB7312Qe4zN1DQOF
X-Gm-Gg: AYBFou2gJOi3P3nfnQd7L7Pu6vx1E+ocxvjI8225DQ/4b4INGaUYhUZzJVmb5ZfBPLZ
 h59sg/1IdT29t8Ps3MO0ADVk9w5XyMHhjr8H8oNpqwVZEPNvUpB3TkhtMeRdILw6PreIQ/cuJvy
 iyZ8sl7O+GQdojSZrIVkz9QFhKLwCCFlWR3wjmKPgKF/Po3W4efnewT9YO5wwk7BBFq4kdyBORf
 44tJGqLPOhHRg33krCce+uu4RlaUnyG+BqVPvdsAvgm8v712YgWLM3PGW9ipojo25FAvdbAn9gy
 a190AXwvp6QCFXBvGNFYO8jIjaFjiRSQeiNLNy00aKd1QRSrxGmeN3ofZFg2VMPeGS/JS7x0me8
 cq3Tsea7p7GxycV1HialtcnGUJxidUTpAlGTD+YXbuyup4XabzLuoE3Aeojbn1K4UIJt+QaJ7Yj
 PCgej5OmZnKgiXTpZU7/O9HWwDYckWCk/mgW6rkPmqrVu9t2ok4FpeD/0VV3nZrOf75b9Pwk26K
 Rnce63lV1wvExLkZhCZZHMWET7iUIET6uXAufwaD5Pp4kiEeTM/yUp5D3ZaXqv8+9jJhoWAzqEO
 DUMUZqjpReOz36kki/9YYs7vAjtterZaNMyAfvdej9mqPjVOzUyr1HBg8S/NTg2p0n6lxLQ=
X-Received: by 2002:a05:693c:88cc:10b0:366:6644:2839 with SMTP id
 5a478bee46e88-36a202bdcbemr4374221eec.3.1793205975183; 
 Wed, 28 Oct 2026 09:46:15 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:14 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] drm/vc4: dsi: Set the transfer result before
 completing the transfer
Date: Wed, 28 Oct 2026 09:45:26 -0700
Message-ID: <20261028164539.3471833-2-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028164539.3471833-1-henryzhang62@gmail.com>
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On an HSTX timeout the interrupt handler completes the transfer and
only then sets xfer_result to -ETIMEDOUT. The waiter, which may run on
another CPU, can wake up and read xfer_result in between, still 0 from
the start of the transfer, and report the timed-out transfer as a
success.

Set xfer_result first. complete() orders the store before the wake-up.

Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
Signed-off-by: Henry Zhang <henryzhang62@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 5ed3c35ee..aa2b46fb0 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1526,8 +1526,8 @@ static irqreturn_t vc4_dsi_irq_handler(int irq, void *data)
 		complete(&dsi->xfer_completion);
 		ret = IRQ_HANDLED;
 	} else if (stat & DSI_PORT_BIT(INT_HSTX_TO)) {
-		complete(&dsi->xfer_completion);
 		dsi->xfer_result = -ETIMEDOUT;
+		complete(&dsi->xfer_completion);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.47.3

