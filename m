Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C45CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB8D10F469;
	Fri, 26 Jun 2026 07:53:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lcYBgwVL";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21A210E258
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:18:49 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-463f1165e16so120265f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782415128; x=1783019928; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tTyM35y6Mbrz+qoI5NtVOHtNU0+Ypkllq1+98zXeje0=;
 b=lcYBgwVLLIfmiSKnSf9JqYRPlKcxkdB9ZufSDi3nB8mQwAfm+eamevUFLVBUqaQXxR
 WI7fiMi0orH0rXvGBcIW3aKiPHydO7i71AZ61QLxtahsGBA1Xlu4rB/XzhPa6P5Hn3Mp
 8E93Oi90yh5NHcIqwJtzuellL8/KzkHb1RoU7q4FhRUt6yT6qO4qQ2QXCVlg7gnMkxB6
 NyOdkyngjpJ88FguceB4ZVfemjEoxr3nz6fjDlFOyIu0PpWUj+UJIZHvF6QwkiIruA2U
 7rrEGtftiVsHwFvYd9pzuofC7+eU2QWVKuh4OnkIHwsdAoHUG2q//I3aYmUkZgKLup6z
 owFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782415128; x=1783019928;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTyM35y6Mbrz+qoI5NtVOHtNU0+Ypkllq1+98zXeje0=;
 b=NYU5llveEIAK1HP+I4uBlByp+X+jPDgAavFEN5Gbsc+LCelElSEVPy2WlhLuFUeqp8
 2ypNZbFSnEERc14JMfvaSp65HMO7UQsaKGkhj/RKif9FjSmoES4ZJIp90KE1V/srVsiM
 1BM4ePZ/S1MVKhIsC+Bo2QHSZFpwpYWXwIhnYWCaMKIc6H8r687eNkvuxzC3gs/ArYkE
 ZbmnfJ5o035FS6793QA81zd97rFh8V3Mf+ZUpk/ecSUJRYFu204RU9zhbBtwkVhdLheX
 s3CXRnbSKluGRlwrApe2eBep5spY6eGHvavYwKDXMXk6Q1A/rdirJ3AIgEmwWNZk+lsx
 IQUA==
X-Gm-Message-State: AOJu0Yz/EuAYVvk3MWV9IfamXE8SmKbDlmxBNaBcBujfXvyC7eLr/mxW
 EEdvTGfcmqQ3nNbjaAIt2n2xLd1m+ywXS/0+QL2jD3wG+ebFFmE6sAi0Y6V0bna5
X-Gm-Gg: AfdE7cn1JBfSSTsMlyVnsNnuoROwOLZh1AccGCZ+ZLKz98mf8PMSzs6baQ1PFPfu7lS
 6HyI283azmIjkSaQJ3hrplaL7aPMCM5q6tnhQFElMs4TG64tzZSIFmVwLSVWprDzEOS+zg0nUCb
 rTPFOmH2o6PaSz77CNGLACaf75yXy68SG/Edhnff6CnNvuE4uRVBeamghnKj5xSJlQaJIWfEEFa
 f0ByRC6tcvS05qIXM9uwrskbO3GhG+PTlFFNa/eBDVeDbZ7OwJ7VXwUzOI2xQKVBmkaHCBvruZ2
 HJjy39y/GGDmC9PTa9k8TmtGzRX/VwUedTBBVXIPT22+JsVD0kmopFBnAF8tmg98mLhAl5xxMgt
 mD+Bg/w2B0UH88cEsA//wPH8lib/4okWsiN09lCCwL3XacuEq4OFGWUpm+iah/PaoOyAWqwzkxI
 aj3ak7vtu8TfveNFZR89A3pjMOejnQGvPDlHi2hNb3B8yZ7NOXMh+cPSLoCwldRK81cgp7fv+oI
 7U3
X-Received: by 2002:a05:600d:644a:20b0:490:a298:acf7 with SMTP id
 5b1f17b1804b1-49266899f6dmr42968995e9.17.1782415127585; 
 Thu, 25 Jun 2026 12:18:47 -0700 (PDT)
Received: from torre-GIGABYTE-B550-AORUS-ELITE-V2
 (212.pool95-21-2.static.orange.es. [95.21.2.212])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492691f60bcsm16514615e9.1.2026.06.25.12.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:18:47 -0700 (PDT)
From: =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?=C3=93scar=20Meg=C3=ADa=20L=C3=B3pez?= <megia.oscar@gmail.com>
Subject: [PATCH] Memory leak error in qxl unbind
Date: Thu, 25 Jun 2026 21:18:12 +0200
Message-ID: <20260625191812.70066-1-megia.oscar@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

I discovered 64 bytes memory leak when qxl unbind is executed.

Checked with echo scan > /sys/kernel/debug/kmemleak

You need to apply
[PATCH] drm/qxl: fix use-after-free in qxl_irq_handler on PCI
before test it.

Assisted-by: OpenCode:1.17.8-Big Pickle
Signed-off-by: Óscar Megía López <megia.oscar@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 278bbe7a11ad..15191efe9f7e 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -401,6 +401,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
 
 	list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LONG_MAX);
 	ttm_pool_dispose_list(pt, &dispose);
+	list_lru_destroy(&pt->pages);
 }
 
 /* Return the pool_type to use for the given caching and order */
-- 
2.54.0

