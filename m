Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E5FC5CFCF
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AF310EE49;
	Wed, 12 Aug 2026 07:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mx3/7GjR";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F8410E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 19:42:45 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so985335e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786477364; x=1787082164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F8qrj8CmLGjwQMZeVA2ZOifuwHu1xiIsioWlV9Mw2Jg=;
 b=Mx3/7GjRZ/lqIqA5H2sHr7RqE+C8d1yiWP6Qrz/O4iyFAdCmqfJQLT66Fwos/p1xfH
 O34/EHt9Opn+O25wwObO2RxDpL1IWYnjj77lJ9tsiLBHoWnju3Z9fy9nsJca1iS7ViAT
 0/rVElLUmeKHO0e0sPfbisncy2tTNI1HZ2ND4r0stwvMZEx1vUVNtxLA6VY8OeSs5HcX
 Eohb616jXdolTmafzg/q0vdiSb6K1ydzIuFdfY0jYN0zNc8jdWesJVFaQVhmgbmbIU8X
 Yo4RBsJSE5HWfrgws3U/HMAnfI8iPIzDKWYJxuMJiXN+JIwMdBGnqaqpFhmIKF+krlN0
 Gztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786477364; x=1787082164;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F8qrj8CmLGjwQMZeVA2ZOifuwHu1xiIsioWlV9Mw2Jg=;
 b=GiEy1rYF/MPNqcQ3g9yTxS2zkEfP5AJLKa2GD5lgbsmyHfC2MKl3R5njTF+bgLBxV/
 bOoaFzmL8AlW5QWefHFmsz9YCuxghwbjkoRW7c237mh5kbw2tkCzBR13gH087/2wi96L
 afKGYM00uHZKYJ/6foScAKIyPE27FHhuM0pTHnLwLJYcNQWPoG9ClQAh8U6+jjDpk3hY
 Xq63fXCY9mR9B7DrngU3I+XmoX1C8CTERRx1/Vsbmj8srRNkfJFe6csCgXAnABBWxGGi
 4hwyas9fZ5qx2LhXltLzKLb1yGcVHnDb40OgxiDHBhnG83HJM83hMAbChNDa6ZRN574y
 ulwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHtyg/qAGE8FCagxITegn/IxI6Jewd2pRdp7XMKL80MwW8D0yioJ00IJVv9nWBrhgJaF5DL4SEjCI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx2geuhftIsYgirRW30b53GF21OGBVsD0KjPEEYLTJjJbKaBLN6
 ao4rS/jH/Y6pnKlkhxqR8JYnChFLoYIiyX8enD/gpnTLHqWdaaQA00bB
X-Gm-Gg: AR+sD13cF8In1XJXWbJS4uOVMZYNiQ2p7fLn78C4MwN+7jQGx8HxhrjIdnbtY/+BYLQ
 60Q6wegHQ2cQk8CZJfavq3OEpOg729DRG/6PCuDL4XHzPR/uVmekpH0DnKryS6TAp0FtdlH1iXG
 FC7n9pNIbY7A2bfkKP5nrBfAte6reoUKx4L6boJnkeulU4s6hpTHuKg601IjayVT7AhagO44wnb
 IbceKy0eCeBLhGkA7efbZS4sXVoY8BhGhauBCCvvVLUwX7MBuJxlEb1oNKNosg3aFw9i+gP9lX0
 8UYoHiqNOZ7dXVB/9PDyE2czQVityPnUwkveKe7n2uFR7e+shJeBQYuw0/K/iNx1Wm5oLRCuCDE
 EDnUSkZPVADX4aET6oY0bRzkrJKXnrNEkASwpPbAqoTzyXWCLVElLGS5hJCoN2BF7280tb2LrkE
 LVOLdjlNQSrcoeBzcZp8/BCpUtmDIUq3YeD5gKd6MOT6CJwJDYwc6kXhVO7z1W4fwHU0IjiZ9tA
 owZYWbzYv9X8ybksgnjcfqFkBz6um3pL/ygF/IiaSWgTUzY/kVU
X-Received: by 2002:a05:600c:1d0b:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-4997a5f2427mr38053465e9.3.1786477363864; 
 Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997adad05esm3986195e9.3.2026.08.11.12.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 12:42:43 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>, 
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 stable@vger.kernel.org
Subject: [PATCH v5 5/6] ttm_pool_mgr_fini() does not destroy the list_lru
Date: Tue, 11 Aug 2026 21:42:20 +0200
Message-ID: <20260811194224.121597-6-megia.oscar@gmail.com>
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

Bug: ttm_pool_mgr_fini() does not destroy the list_lru.

Fix: Add list_lru_destroy() after ttm_pool_type_fini().

Assisted-by: OpenCode:1.17.18-Big Pickle/DeepSeek V4 Flash
Assisted-by: claude.ai:Sonnet 5
Cc: <stable@vger.kernel.org> # 7.1.0
Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 74d8770f41d8..876b6d3a632d 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -1572,16 +1572,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
  */
 void ttm_pool_mgr_fini(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NR_PAGE_ORDERS; ++i) {
-		ttm_pool_type_fini(&global_write_combined[i]);
-		ttm_pool_type_fini(&global_uncached[i]);
-
-		ttm_pool_type_fini(&global_dma32_write_combined[i]);
-		ttm_pool_type_fini(&global_dma32_uncached[i]);
-	}
-
 	shrinker_free(mm_shrinker);
+	ttm_pool_type_fini_and_list_lru_destroy(NR_PAGE_ORDERS);
 	WARN_ON(!list_empty(&shrinker_list));
 }
-- 
2.55.0

