Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9892CC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6B6A10E391;
	Tue,  8 Sep 2026 07:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qk8o1e1Y";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E707F10E233
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:18:13 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c263110a8cdso222402666b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788783492; x=1789388292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oMsCw8GiZTKqLZR6QIiDUwMuQHXPEn7isoxeheHJ5mw=;
 b=qk8o1e1YCR1uaWFFEgSDx1I83pQm0aY6d2BvYLl2yxBEUC+DQ4RZRIf3wnhTy77pDk
 lgPKkvbcC2Ek7MWtHJxIJuGWdkkVjkg8UrogfKm169OCfzcw3zKS9QWyWh0LAwYJpwRa
 N95NB247LCxmOrEYVEIIuSkPDOxIPA06BVO0nvDZbTfzn2hY3JScxtV+U1eTW63K2ky2
 P+JtP575LUzSE2aF1eDwyvpT6yRvlccth17ATQRcYA3pTAg6TMszvUXRpT9nZiexVK+P
 Kmy/Wbp2+mPA0by6fRDkV4aHKOIw6gYAuIQ+8cm5wElko+BWuGlkg4KWNusJPTQWXqwX
 /tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788783492; x=1789388292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oMsCw8GiZTKqLZR6QIiDUwMuQHXPEn7isoxeheHJ5mw=;
 b=TisUgajR0iaA+FZ6DSx15D6QaWBOSd7w6TRMz/3T8uDMCb5jMiI3QYvRiQzDshid3s
 IIrrvtDTGIFdOainaacGwbInizJOLhRBpmsNIFexShqInM0r4x5U5L9isvF+vLQDZ9tk
 attyDZgAUuWH6i6W9IheHAmU+huZIwio7dUXhFrIb0lyLDg+7t3b9N4zcgKimVcRa/Th
 lhW6I/uhSCddaIiZ6JDhVMApdxLQQseA400LJT7GSCQ0blZ9wUXoyh53cmSQFEo1YiLo
 BgfQgZ3m+t99njyuhgllelsax4OzI3zch0fzjU7pIZh03lK3q+LFuq/MkoV36jGaOGhJ
 p8dg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZO3KNvsgjdfGZgs7OW7lVjnx73Xl6iNs+ZOgZSikKjkeA7Z+33GIhjL454Hv2y9Wb51ONeC5p8rI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l20tEEbmegyAp7gOCThcD0DkrzQqnkiOpk6mObCAaL/0/vwzh8
 4wYGo0EnJbRriYoDNMek/9pXpe9nV91jY4woIAYjQNSjyrakHJ0i40inEHiXqQhJ
X-Gm-Gg: AYBFou2e9ALKKcokwG7mqC/QnMjczInD+nezEirlKa39rtlr2+qM3H1YyF+9EEGxMeT
 jZz5MXaCjLJo8MFyMayGJnRSrGVL2qxP1cTR8BPovZ2x62NH+1ZPg2AnqhUgn8DagGw4R/zGDFW
 b2QQmNsTY8m6bTnFtSB+jNVNgZome51nTetO+QyDhYUAXbid0qWDVZF9BSR4+8pQyxFFpoZu2yG
 eCDkt/3mDQMcQ8WQpSJuIuV+sTlyQKCW5kiejifeY9g0xtrQP0zfxZKUZdpPL8lVp7L+cWtgnty
 v0s5Tmby0poDoICdcWyTGOpTWCfyxv9nwquprAVPpndL9/CPc5pxt8IyIQ2ZnRTBOGdhk3atRPm
 rOnCyU3Sa9X7yVBbYmbqem1raA8x5xSLTI7RsvqqWDnR0DuiH5Iz26gd1nQzEoo17YHzGFPTnmy
 x7P4+AFuxIuBfQKTwHqoDDbTWPiSTrzFk+fFGZwh7c6pVIYnU6Ow3eFXLjCafuUqioJRZ1Hz0=
X-Received: by 2002:a17:906:2099:b0:c28:f9e4:836c with SMTP id
 a640c23a62f3a-c28f9e49c9dmr85196166b.28.1788783492029; 
 Mon, 07 Sep 2026 05:18:12 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5921e2sm466938166b.46.2026.09.07.05.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 05:18:11 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Roland Scheidegger <sroland@vmware.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Thomas Hellstrom <thellstrom@vmware.com>,
 Jakob Bornecrantz <jakob@vmware.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Zack Rusin <zack.rusin@broadcom.com>, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH 5.10/5.15] drm/vmwgfx: drop dma_buf reference on foreign-fd
 prime import
Date: Mon,  7 Sep 2026 15:17:49 +0300
Message-ID: <20260907121751.126950-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

From: Zack Rusin <zack.rusin@broadcom.com>

commit f739416dc555fa205a785e5135d73fa39b26f35d upstream.

ttm_prime_fd_to_handle() returns -ENOSYS when the imported fd's
dma_buf->ops do not match the ttm_object_device's ops, but does so
without releasing the reference acquired by dma_buf_get().  Any
unprivileged renderD client passing a non-vmwgfx prime fd through the
DRM_VMW_GB_SURFACE_REF{,_EXT} path leaks one dma_buf reference per
call and indefinitely pins the foreign exporter's GEM resources.

Funnel the error path through the existing dma_buf_put() so the
reference is always dropped.

Fixes: 65981f7681ab ("drm/ttm: Add a minimal prime implementation for ttm base objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260505222728.519626-6-zack.rusin@broadcom.com
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80888
 drivers/gpu/drm/vmwgfx/ttm_object.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/ttm_object.c b/drivers/gpu/drm/vmwgfx/ttm_object.c
index 16077785ad47..39ddb74ad07f 100644
--- a/drivers/gpu/drm/vmwgfx/ttm_object.c
+++ b/drivers/gpu/drm/vmwgfx/ttm_object.c
@@ -658,14 +658,17 @@ int ttm_prime_fd_to_handle(struct ttm_object_file *tfile,
 	if (IS_ERR(dma_buf))
 		return PTR_ERR(dma_buf);
 
-	if (dma_buf->ops != &tdev->ops)
-		return -ENOSYS;
+	if (dma_buf->ops != &tdev->ops) {
+		ret = -ENOSYS;
+		goto out;
+	}
 
 	prime = (struct ttm_prime_object *) dma_buf->priv;
 	base = &prime->base;
 	*handle = base->handle;
 	ret = ttm_ref_object_add(tfile, base, TTM_REF_USAGE, NULL, false);
 
+out:
 	dma_buf_put(dma_buf);
 
 	return ret;
-- 
2.43.0
