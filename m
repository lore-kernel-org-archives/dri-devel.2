Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB60C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BEB10E72E;
	Mon,  3 Aug 2026 16:11:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gh6Kg3TU";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18CA010E727
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:11:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso36281355e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773498; x=1786378298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hC6MJ8bwLjjZgLx3/Q1ZtCKaKlgeak/LeNvekOVJvKg=;
 b=gh6Kg3TUJ42ruiweCTB6GI2aAF/Bxd8f0JcdnyaTLGjNy9wYMDKM+TC7M8yJSImYoB
 OJZCANHtG7eqE2cAS9CdVuO9HHQGkjIF7EYzez5yNZict5R3m+QIrD9o+0xjZ/6TwOb+
 RybNV10LA6HZWutllNPSTEU0RGnaRCodkSkpth574C5GJ5Vx1FBoTk0T6flX5gzMH/Bd
 Hz80SKAAhDYCJUKdCR9K8Se0oEgM1Z6Al/7z9QhKvtQRMhjq5ZxKb0PuoqUHCOtwdiW4
 y+wZACzF3Hi9KqAT+PdfUJco1JiiIHydh4HlQMDKdf5QljpSH26ibw/+l+JZgI+YzvHA
 244A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773498; x=1786378298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hC6MJ8bwLjjZgLx3/Q1ZtCKaKlgeak/LeNvekOVJvKg=;
 b=cB87Cn7GKaX22Uh0smKTF64+Fj8alb16j0KWHWjaIxfg8laMVF1VhFSUdh5NXAT9Gz
 W+K97AjIz7VGB17RIsWFqXoFEj4th0KIZc0f2RSGRku4oTMFdjISPl1f7cOY8Os47NE8
 KiZssjg0s+lhf21OC83JuJFYrGBAJpKLArHxF/HSDW5BFLaHwANJCr77szXuJlGZUuDz
 9u7YAVVzzaezbmsBnbTCeF8DJQZMqnbgpivx/q0xLyzs+RS19LAqu2KP1EJezDCM5Vsk
 9TCnpm6L4HzZT5OM7OYFcuB8WeeVeXwIJz4qRplSci+If3PB6mrnraINRvJfq+nS5ZSX
 mYrw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUqX0sMnAh2LBwXlcOHxCynztJQrNqrHQPZCew4kuQQQS29lzGPVYUKlVj2EmPyPfWuoLrnNGtYHQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfrvS0aGWs5KMWxQor9RCGEnQEUpGZVCMuJTtQViaayrmXAUv1
 jRrZvi3EKICUpWKfX9sL1YCRVBvA2xRtCoGyj2T4JnakgN+kM5MP2QL8
X-Gm-Gg: AR+sD131+vwt4Fu1UDluRgCLRaY8UchK2S2BaVhmuSpXM/qjozZNIlwy2LPJkK5Z3kx
 dqmqw6r5TPN3x6YcmItn3IdGDD1TGMX2GIty/M1MJEUp1csgtdqNbtsa8CobR/cBglTn1xZIaOc
 rqsHqbendxbOpSr3y1EuxlA0VQz7uVgja7jTDJlYpDB0W85gGxaTIOR8+frYsbm6YymihYoyIx/
 dcR/xU1Zn28v5O8JobBu2N2OhY8azE23Ugn8QBztZi5NH2gmGu4s6AcD4lWUzbqFJBdG/cvgj9f
 CO6i/lSj31sM+MHxWWuvQFB/Nf0ohS6DhhCmyx5UTLiLv4yTYXKmI2hvhKSy6WK5SXmpvDsJPYk
 8SOtn+gWNGmjwhpwDSnkTnlk6gVnRKHueTZwFiW7LQ6LBZy/om7MdHi+dBcjUoApFBn2qh7DuHW
 LO7dCEZf1M7T6nn6pJf8T9RY92IO3K7pR3HS4VYGXw5kkLccEqr8qVhT+qkBgZnTcWwq5XFD7Jc
 Fr0MJngPPmfRD3voK9OJc8AK06gsrSU+mgVhqLL3OnVZ9HFVt88RAra28nmaH9OwRLHG4dDqWNg
 NEkPhIa7W7ugoWBiJVzYoZ4b6rSwyO/Zl543V2WY1MqXQ8+eMGsA4PklRmBV1RpYJyawyW2m1fI
 nJ+kP8kr2vvtxtjRB0y59fnb4ruycyt++BQhh+cBKhfLZncufNFjqzaDVSWLdwe0KBPm0vkOgII
 aDJw==
X-Received: by 2002:a05:600c:4e8c:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-4980c66c82dmr193167225e9.1.1785773498389; 
 Mon, 03 Aug 2026 09:11:38 -0700 (PDT)
Received: from jernej-laptop (APN-122-100-117-gprs.simobil.net.
 [46.122.100.117]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2da2sm3363735e9.3.2026.08.03.09.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:11:38 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: wens@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 11/13] drm/sun4i: Drop node references while building
 component list
Date: Mon,  3 Aug 2026 18:10:49 +0200
Message-ID: <759c74e3a22b97ca066ef7910ca4b91b852011e6.1785772659.git.jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785772659.git.jernej.skrabec@gmail.com>
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
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

Two references are leaked every time the display pipeline is walked:
the output port node in sun4i_drv_traverse_endpoints(), which was never
released since the driver was introduced, and each node taken out of
the endpoint fifo in sun4i_drv_probe(), which stopped being released
when the fifo was introduced. The latter is still safe to drop right
after processing, since drm_of_component_match_add() takes its own
reference.

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
Fixes: 8b11aaface2b ("drm/sun4i: Implement endpoint parsing using kfifo")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 8a409eee1dca..e9baca360160 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -289,6 +289,8 @@ static void sun4i_drv_traverse_endpoints(struct endpoint_list *list,
 
 		kfifo_put(&list->fifo, remote);
 	}
+
+	of_node_put(port);
 }
 
 static int sun4i_drv_add_endpoints(struct device *dev,
@@ -394,6 +396,7 @@ static int sun4i_drv_probe(struct platform_device *pdev)
 		/* process this endpoint */
 		ret = sun4i_drv_add_endpoints(&pdev->dev, &list, &match,
 					      endpoint);
+		of_node_put(endpoint);
 
 		/* sun4i_drv_add_endpoints can fail to allocate memory */
 		if (ret < 0)
-- 
2.43.0

