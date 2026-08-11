Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9FDC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7529710EE70;
	Wed, 12 Aug 2026 07:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FrhClwLM";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A643D10E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:46 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so1742805e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477365; x=1787082165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BuMfkemM9Oz2WhvZaC2ZnN/4G8tTmAb8WWo8t6gaQkk=;
 b=FrhClwLM6N2I+LJAexr2C9gDL/mwsuNSK3ydcKUGCOkFcc4SxgFb5KQX5EC14/6x48
 YdU3MlciG/OXJ/+TJnKqFMOwojtL33AVKiQM8CnzuxnroYjHhZiFTkux+pJtY00W7mkg
 ok6RIGhnGbCtjhUV9zNM3u475AtmPci2zmr+pxB71wUGryT0zAVzX1rJ7q/NWMlot1Iu
 OfBvxPHjx525/FRev7KP/Y5csHs+paNlegQedFeOEW7ZJi6gklcP9aUtxRizo1ekQoLw
 k/snaGq0Twi3XeU9jebamG5sHhRTzO8jiII0D1rEq+v7YqMRF77Y7PaOPxC2qBPCtCIO
 6vxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477365; x=1787082165;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BuMfkemM9Oz2WhvZaC2ZnN/4G8tTmAb8WWo8t6gaQkk=;
 b=HzDRZ5nfC6aBGnFaSqosfvfpX1HdzzFEnM/xbPbQyj0FvlmWDabLKslCT0ki8N9nd3
 hRNTsi5FOplI4ByQtTJ/941uUtr5DBG8wVVP/yH3mfBJt22qiKUUQBrCiaxiApGD6saK
 JzCyo6orllwLK/1N+1ItteQ/sOZZhkRnlThbrk21eBEet0E5w7OUpLEPVqumNnSOftPK
 54koVYY4cueHTakVb3s7A/aElXfOUN4A8mY2EmSq7KF+9oHEA/yyKf3mAStFHnFOpnUO
 imG1PMvbO/DL3m8/0X+G5OLbD+/s9N9c5O6KLgKi+3eWsBT5PyZsf6jxAXq4jf3n7+gz
 fnfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqp4vK1U7wOOaovSIPjcZ1nhgtbMf8yYmB/rOI2NN0vWb4wkgCoOgQm1Y2R5AY4xtXUjXgMZNmRnoU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMmwZh3YS4vcUD1/52JT9XixfcxJWZ/lpy1iURtKThkSVYqgH5
 /eZg0TnDy+T5ZNGjw0hZRwj/OZxD2ByqIV1opMZhCPIx6Ogri0CRmDRdRjq0nU5I
X-Gm-Gg: AR+sD13Qy68qlnMrKdFKpS31xtdnU295mkQTlfvkK7uIyPkjlUQwUH6SOV+y2I9moK6
 TaJEZx6eF6dRcoZewT9w7yh+Ukquj/1b6bC6iI4Y+ojXZhnuiipLTjazZDVcmiWg5t171wePw1J
 loS8qOpiC3laSdDjcd3RT4VSk5UG6EpuPdww71i9YBiWqDRbHSPGba3X0996A2RmTDygqipysZB
 KTm++g6d18Fk2imV1l26g/lqbEHpR51JogxcYCDA2B8DREjkfsYcHaegaRDTmOoRAo1vExNIHLT
 Q5MCZLJNREGbk8ZVcxIZngdWAn/TKHeYzEoRPKHD8x3HSh7JXHHZpHC39P/BZEmlhD3hTpdWRJN
 kP20sf8VtHvNJQsKTSqryUfEiair69Mm8H/1E97E5q5CKzGEAk3ZIUp65bhHBGLc4JHS5qUDzqX
 j8I9LsImbDA/5o+dRFvMXky3VmSqCRGXg4ftS2jWlGUWO33UvJpd+SvL3KqzDDR6PKP5PebQG17
 57K/nOlvG1UhCN5xpB5Njmzw6pt6lVWZrLZ5/NUOKJO5dpR11S3
X-Received: by 2002:a05:600c:c4ab:b0:493:aa0a:45ad with SMTP id
 5b1f17b1804b1-4997842c213mr78119195e9.2.1786477364935; 
 Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:44 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 6/6] ttm_pool_mgr_init() does not check return value
Date: Tue, 11 Aug 2026 21:42:21 +0200
Message-ID: <20260811194224.121597-7-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811194224.121597-1-megia.oscar@gmail.com>
References: <20260811194224.121597-1-megia.oscar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 12 Aug 2026 07:08:20 +0000
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

Bug: ttm_pool_mgr_init() does not check return value in
ttm_global_init().

Fix: Check the return value from ttm_pool_mgr_init() and propagate
the error.

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index d3bfb9a696a7..896b766712d0 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -96,7 +96,9 @@ static int ttm_global_init(void)
 		>> PAGE_SHIFT;
 	num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
 
-	ttm_pool_mgr_init(num_pages);
+	ret = ttm_pool_mgr_init(num_pages);
+	if (ret)
+		goto out;
 	ttm_tt_mgr_init(num_pages, num_dma32);
 
 	glob->dummy_read_page = alloc_page(__GFP_ZERO | GFP_DMA32 |
-- 
2.55.0

