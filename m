Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C22C5CFEB
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E5410EE60;
	Wed, 12 Aug 2026 07:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPHYLmHu";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F6210E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso1945605e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477362; x=1787082162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4v0iZboq/uLDu8mV5Gkz82xHeLB+QGVZ8axU862tksE=;
 b=mPHYLmHuJKBwC8I7UqKXStZZL5QVwlOIZE2OzjB9o5W0ir6wsGhvaVcCuaZmmZcj6V
 QCsM7PFwqD2BLB/ykELQCCT1qFrjIIsfN0JY7TDig9KXDn7sW7lqpgUQfi1YhDuxA/H/
 2QoukCoigiotUSWsHxgRbA6LcJS+tRiwMA+T4s60rlUNBA/FID9okAtQ5nhPtm6zrZtn
 9p5lK7jskngaGcTXOvpvWQQcYPvzgYfamoj5fTnjGeF6V6oZEjpYN14pmAkPEY0smlNh
 2+hQiXlJElo22xnrBTHUxb4qFcQkIytCCEJVoG7hCTH7kODntaQai2/qQpZYKJuNqZFx
 yq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477362; x=1787082162;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4v0iZboq/uLDu8mV5Gkz82xHeLB+QGVZ8axU862tksE=;
 b=Egjsa41UVrckn+mJ7KeBe1h3HFKel9615gvtZj907jBPu3mwYR8CxTfD8ho2ePXmpc
 FU235Pz+F+nk4hu3Q4Pu1UxTeN3L0IT7X2drXIFZUgaRbMLBKxUiNP/cjdrN3R9RYTmJ
 zW0D/+t5aZA7i2y148GXdZhUao3/Nq/1zYUvoaMYqyRaIs8Wq7di6MoydEWnr0UGYFzt
 xpN+OMTcCTJ91Qe5NDOfVLJt4pMgC5mVQOfM4gi5NOFVfL6hDMzQ2FCO22aw//p8f3gI
 d6uBIc3Qha3YAt4+OymX3dv2MOwKK8wkABsvtCtveeI56Rdp0mmlcNRnSGgkHkTjlKYz
 WASg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfkqGOrc8JnBpU3cOHblk/HbWpOKy/5RpoqQvUBsGprvHdLQyTaI0nyBzJ4dLkCs21F5OwiarW5cI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybpoZG8YhGDKVKPUaiyTyoh5JSIwEl0fwBnUJshli1SjguItms
 wui05OwGfQoSVzkGUlBmIvRrwC2NScVwACYKKSCcijJXlAa2cF37zarl
X-Gm-Gg: AR+sD11of9Qz2XuMe8LhMZXvJYtHcjSVE9AJTQ/ZmH8HFwWtd5WTu5r7LhsfG7Z/dG7
 hjqk+GQ0ng0i+qYiniVG/H/DZBZMjFI45zMW8QEmPTmQ9YJqHErjLsqFUwPW9xQ3UG6Fq4A1evS
 WS3eeRj05NqjyEBGONDNnVM4dfGcwCc5pZ/pMmxvtxsr+K+aW2Kn/5utQ36aRBpvBJ6pmCAPMoj
 30jyAA07AmTKMKbbo2aUBf/O1R2sJxaT8NAw7oefq8OM9/+s8N6pcq7+R2K2po0nyn/UiCjBkAf
 Hc2fS0h2zGOuk4FIjwvQvJQsRwE7cKfLja1ab1800tGj7Svj6IR1ubcFrB3/6sIWGsXG3rOiiVj
 m/Bq9gBaB7XNDPEaRkbCM8kqxINe6u7scso1KVp04PTIV5d9/2/KpYgmtIWZOQDb1FMpoGN7css
 9//zfCIFez5q4aLlA4OBrLojO07a4t9Iu3+fw7g8jsmRENc1n3Gj2+1HYxz+lYDiYqwo5ytzRdU
 fYgIoMK75+wEM3avGCE9zr9DpG/8YUmEawDISPDjmGGFgNIs37a
X-Received: by 2002:a05:600c:34d3:b0:499:6eac:36d2 with SMTP id
 5b1f17b1804b1-4997846d9c5mr93834455e9.17.1786477361645; 
 Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:41 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 3/6] ttm_pool_fini() does not destroy list lru
Date: Tue, 11 Aug 2026 21:42:18 +0200
Message-ID: <20260811194224.121597-4-megia.oscar@gmail.com>
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

Bug: ttm_pool_fini() does not destroy list lru with list_lru_destroy().

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8637f7942347..87c843f52736 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1232,6 +1232,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
 	 * that no shrinker is concurrently freeing pages from the pool.
 	 */
 	ttm_pool_synchronize_shrinkers();
+
+	for (i = 0; i < TTM_NUM_CACHING_TYPES; ++i) {
+		for (j = 0; j < NR_PAGE_ORDERS; ++j) {
+			struct ttm_pool_type *pt;
+
+			pt = ttm_pool_select_type(pool, i, j);
+			if (pt != &pool->caching[i].orders[j])
+				continue;
+			list_lru_destroy(&pt->pages);
+		}
+	}
 }
 EXPORT_SYMBOL(ttm_pool_fini);
 
-- 
2.55.0

