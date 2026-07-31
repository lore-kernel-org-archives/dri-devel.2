Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C95FC55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 06:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E1910F17A;
	Fri, 31 Jul 2026 06:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHgHg1Ma";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A429610E168
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 05:31:09 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so299890f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785475868; x=1786080668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WUyp9U7dXdiG+QsLynyvNf4in1b+6GPKTpacp6ZUx0c=;
 b=tHgHg1MaFwtimnsgkpbXNTW6T3aGht9EjVy6u4bHxVcIEp6AXsodwCCj/wPA2itrWN
 NDn4jVXAjagA8gH4A51PRk6bkbTmsCGtR5eS/C/Lxa3aUmD0SNdc5rNQhepARdTcx6IK
 oJPRql+3Rj5Emr39sMnKYgpnLe0KoBdLrPfoh1G7XomYxouSE0nwgm7VBUKdMa/w4/ob
 GSEDaNaHTKKv3Mpz7rfF+pLks451DHa8hGsLLthaZVd3BJ79LIWQFH7bCtSl6/wpJZVq
 /Xw3NSCi3P9L3B5fstQbg6YJDzFbUDAXg4yYuEvCPIFALZq3Fmb1xuW9O0d8uKX048Ve
 +1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785475868; x=1786080668;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WUyp9U7dXdiG+QsLynyvNf4in1b+6GPKTpacp6ZUx0c=;
 b=GcO5CR/dGSXjsCVR3IAQI6sEDR13frb52PViRGzlib0kaV2rtvC4ltsrfKVnPpQ9tM
 QPHHT8ww2YT4nA6p+ShskJ2yZfk6hLYaEgt09yYbCafqo89YgDEqzE5lqion4Aebj707
 gfhvKbL0CQXAh9hfbjwWEmIuVz4upiYzH3MG6jjXjhbNL7vtg3a2RhkhqGAaNd+ldywg
 Nwr/sQK6pB13QpyY38p8Lj1IbGhUanisYuRYfCYYjBV5nBQ2ezdTS5eOouwCPJkdnZDQ
 T18zNDBWUCNPLT9/S+iUWwzernOjvGQkVl3sMt9CPJp5e2kWwAPJdEhXqLsuzQs38dhL
 0HBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RofVBDoQTQ3z8cAi3a8jm3kGHbV2LyLBWMrI4IgSVOQMQjaKt4aUOPb5ql8pputLhSv2qzzsBv4on0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYdi11LOMcRWHTLvuPESLGxmQkBfMpRyTg5m53NCXBX9hUvulD
 3Z3wH5n4VpJYxT9/23KhV275uG8iByq+ymNs6gS4kzWq9YaG3ZbA0OHU
X-Gm-Gg: AR+sD11vhS3YqeJ/zNoSyMo90dRXT/jpJlOzI05pmfFiRiApAmMttBsvRFzNe8SmRZW
 zEGrVdVFFNDX1GsgJzFHzKoRCMDNSxcUL4P2PXAb1ejbzJJ9oAxj7CWvR63zalx3rsPXncC1puR
 rCj/L6kRTuTHF59HXdBpxHybvZuXtpUMshFgUucjAu28tM3l8qCoqp1/efLyc5Fnds+24L3N5XO
 x3Pph7Az79laAacIbPocCurf67YHjdGPzEIPCvoyIEUty3BvS4ttASVWjZrWJjt9GoZtd3R7j6G
 PKjukDrwKvlSw4mrDAZRUp/PGX46wPpAiSFNgZ6UXzgtXo/3Iu5bWZlIG8PDJT3+7or3Gcf0LH2
 s4DKTM0+IebPBq1lK8kTtdHgX09MzxIulhk5BNcxLkAsUvBYl/nrXh2fw6M1EzY/LG4I4kdWgU9
 4yrqHQLV5Xuk4Xz8k0y0OB4/eemFSqry7jWRVs+AmCVtaZGDgYR8KeJSAq/2IrJiRA9lSv9HgIz
 SbNrayRqdbjqFYpo9qA2sSabkn+JBxeEmoFCahQ4oZKzOBFSY9LWKaTIdO1yXA=
X-Received: by 2002:a05:6000:40dc:b0:47f:9d0e:f8f with SMTP id
 ffacd0b85a97d-47fd2aea087mr1700034f8f.26.1785475867744; 
 Thu, 30 Jul 2026 22:31:07 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a5a4sm345470f8f.20.2026.07.30.22.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:31:07 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] ttm: Add error handling for ttm_pool_mgr_init()
Date: Fri, 31 Jul 2026 07:30:36 +0200
Message-ID: <20260731053047.24503-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:54:16 +0000
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

The ttm_pool_mgr_init() function can fail, but its return value was
previously ignored in ttm_global_init(). This could leave the pool
manager in an invalid state while the system continues initialization.

Fix this by checking the return code and jumping to the error path
on failure.

Assisted-by: OpenCode:1.17.8-Big Pickle
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..c880a0430363 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,10 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ret = ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
+
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
-- 
2.55.0

