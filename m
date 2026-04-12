Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFC7E937E1
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 12:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA10910E2A9;
	Sun, 12 Apr 2026 12:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l162obLC";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DFE710E2A9
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 12:06:58 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-358d80f60ccso2385405a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775995618; x=1776600418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=96a3K+dWsyVQ0u2hcswt9wA9QXsiax09F0/1rMk4SCI=;
 b=l162obLC9XPSsfs53Zc5x50Fv6t0xEf2prCW0hhYMm9eSMq+Qr9Ugc5eM5FWp9174I
 VQTMmQcMjwe9iJRfFswxj5tdge50pcF+5SCiClfTTO5Yp19BTvgLyDaCwrjk1TWGvd74
 aszloDM95IhkA3zhRSKLSofL311naJDIYEX26lzwfH7MrrjI6Ldu7Sse/YBKOjTWuEgQ
 J6EYy7JecPJpqwP30V2s69eCM6Drd/yoe+C/qB/eZtABkQ1Eg8Jjp3AEHOK/fCqDpFB6
 nQUO955BI5gfO9n3eTjWoFU78ghrAr3NnQJTKX8QSufzvY96foAvc6Ov2WMBwn6JD1J4
 7lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775995618; x=1776600418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96a3K+dWsyVQ0u2hcswt9wA9QXsiax09F0/1rMk4SCI=;
 b=XAVzudfx1pCap7fncnWDr2HNmpgj97uKKpNpeCaBZZFyKZxtmHCLbXy5eG45Beq7nN
 xxoD27V9DfOImXuBZzWunsewmemKaulLxqwq1Ake5WZLt+fT4o4UlS6XfA4uiGIfMVIU
 x5gx7HHuyyXd8trPdob5EgwKd4O2rJwWqYwbBIInNO1q92lN1zl4PsIcyD9/Qj8X10GO
 Zst7wu14J3uTMkSkZnFpKpV8WFYn9fseHDggP+EwIjhSm30OMZliaxlaFXbRKNw4hIDT
 gHvMNaQXJ1HbkFvvow+JzaI2a92YcMKshEPl4bGfI7pIjNJolZ1wjPHBdeUt7Q7wrpFF
 MItw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p9xAH7im1M9XXg4gC70B4j26HabMUo8rllPFDYoF4PgSxN9fP8H7c1yEzhKlmmSsXoSWeVDSUBxA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRHlKIwdx6p1Qpy+zhb5UrtWc7rwjjS9sXgP+gEZxr/O4T75U0
 ZCpT+IC1/7BUKWxElVw20FeA5Ua3yDAhTtmKwqwi3tQ/OZCgCtMWanvF
X-Gm-Gg: AeBDievJVtY2Aen5EieaJ+RrTR4zDvPLF5sgEvDI7tpKPyAl254cqI1wfS+1UL0JeIp
 J0T7ReucQbMPJtZ/AtkStJD4o1BgJ2QPUTDEaDWzON1W+h+1x4OwS0hwd1Elp6+LAN3zVTfQncz
 RPNYOnoLM5Qn5gfa5xExJ6lHgap1lN33kQ5Kn0pPuYLdAvvSEAFHb4I2BFaKMdDOL0jw6eoIWcH
 py3OraPf6MuN2n2l3cMQg9JstZ22qdX4Y6fdlxJF6qcQSNXRERe8gVJeRserNoMwwV6LSySz/Ly
 0Gdw1UjtMkA0Bvvmvi2myJ5VVMfqa4DK9QXgEsTlKKiV9L6+fSMwTzGzlreD3/xJmYAYajFT6xL
 0TGiTX94OtjgQyq+alzwD23z0Hq1fWJpyvzCiC431Y3hvDk5oVlIhl2qV0/Bec7EmoNElPg/qE4
 ZKGGG+ksqp79GFi/k=
X-Received: by 2002:a17:90a:ec85:b0:35d:a542:2dc5 with SMTP id
 98e67ed59e1d1-35e4254116emr9347519a91.2.1775995618057; 
 Sun, 12 Apr 2026 05:06:58 -0700 (PDT)
Received: from lgs.. ([199.182.234.55]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm144261a91.1.2026.04.12.05.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 05:06:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mark Zhang <markz@nvidia.com>,
 Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Date: Sun, 12 Apr 2026 20:06:43 +0800
Message-ID: <20260412120644.2449624-1-lgs201920130244@gmail.com>
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

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), if host1x_device_parse_dt() fails, the current
error path frees the object directly with kfree(device). That bypasses
the normal device lifetime handling and leaks the reference held on the
embedded struct device.

Fix this by using put_device() in the host1x_device_parse_dt() failure
path.

Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/host1x/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 723a80895cd4..f97567e6ae87 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -452,7 +452,7 @@ static int host1x_device_add(struct host1x *host1x,
 
 	err = host1x_device_parse_dt(device, driver);
 	if (err < 0) {
-		kfree(device);
+		put_device(&device->dev);
 		return err;
 	}
 
-- 
2.43.0

