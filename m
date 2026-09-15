Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E80EC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9BA10E304;
	Tue, 15 Sep 2026 16:37:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oJYD3ymT";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A80CD10E2B9
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:37:41 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so125645e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789490260; x=1790095060; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Nm5rOlIrEcg8aEx9ayIxOdzc2+zyQmd9qJF3zn77mz8=;
 b=oJYD3ymTK0NvevT9mu65VpLT281RvFM+JlfsTa6iT/KuWgkOVF8QFjZd6o4BgW16Fm
 Zk+vN2ZFePWorPD7Xt+XWKqXwn/SkXMCF/AIfIlvWn/UwlMmipxwZYWaEb10/ljRtAKB
 /0jZy5uMxu+4k/f9lg4pe0GFkJPfdtUWsHhj/eoShwkRPDCVRhnQRYp0Gh5kY0i1S4GQ
 dFSu0DNoBr9kWY5MdP1b5vEBXdlPxoa/SKlxysOXemyS3LeU0Q7AwiikTZlqJry3KC0J
 D+F4Fnbr1yRnSIUyoMpdbOOMwz/ofilNbEccDGycdV0YK+WUhgxXYs75MUCjBZE0KuEb
 dTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789490260; x=1790095060;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nm5rOlIrEcg8aEx9ayIxOdzc2+zyQmd9qJF3zn77mz8=;
 b=N3z4EmP3XVjcLHW0tF8g/1cwQk9+sq5yJKy99YynfIOD1ZcHgz0MOjFcc6q0GboFDL
 sd+P6BCekpatYTypRurcbZNsJO6WBatAdyDpbsgJimWilKR9FsIjgcGt2jHITBBAXMOV
 wiKbNRS4agRba6TSfd9wR9ZYkHJrIPVfXXGLTWVJjQJY24Rn2F3IE8XyvNbvBb2oFg2p
 Qd8n68xGxevLxLSbuXlmIvsCl7uPbaatCoeqAq2l+EoPezUXsDQF2zJPb4B2L4/w2mKF
 wuhJh+zSSYptlV9rAMgBv/oakvJenUUZr/YJUYLEk3wsj8meuPfzgJttxbOHFMxJpihO
 QBqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwi+5mJzVriXS0CNn3GsYTCm6iUuwGstJ6Be0oGqBgY0MKPGKndxBXy2e9jtqfr2GFSHDyi/jkFJbA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l9rVVZk2c80Y+dKOdTe4gozlEc8lqxvYdCSatBle5af79PhX+Y
 q3DmRcJ4u3d64w11/Cpdcq9+rx7VkpOcN/guFm9kROcrWwsS8PA5KZf0
X-Gm-Gg: AYBFou3hAdUiz1J7E/jWzVDf4hB8nh1YDa8JeASOG9wtZQSZOH+rIEDStsf+AUwKHlG
 61N6rU6bGACzFlLm7LjOOK6IW3XPwj09t/C//6b0XM8R78669WCJfrpn/+7d5539u2BMKLuWxtL
 fxy+VHNmb8+XmWNoG4TEqA+Ufn1iRsb69Sg2y0qyHT/npcP5crp0S8Ahua3v1aGMSAkrEPkjt8B
 dX17Ygaxcyttfqh/mjbkAT+ZST8tdynMY/zNmD6PXnpHtozhbX3HeilW/gXWED3O1BRWiOvhQlj
 VcEj2XB0+1h1eI50tYlz/qvlKELJ9uHW/LVlgVfgMEx4CMdFOgon6kBwbUionRFktZQRqn1REUp
 3+k8LWFtCjToEMT+Fdc/KRCGaTAjExCptOe5smh809+wjHKPUGRHqLIKeO+j/g2EaMmkxzdxgv9
 oOVaC9akk45kAo56t39DsxNAG4WWxVYq9fq6EodfTIkoe3weIs4RU5GNLLu6QcoAgh7y8=
X-Received: by 2002:a05:600c:8716:b0:49e:6692:27fd with SMTP id
 5b1f17b1804b1-49e7a657f9dmr229988985e9.2.1789490259811; 
 Tue, 15 Sep 2026 09:37:39 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83fc368fsm177635e9.3.2026.09.15.09.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:37:39 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:37:36 +0300
From: Dan Carpenter <error27@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/ttm/backup: Add a missing tab
Message-ID: <aql0ULKgvUzqxBn9@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

This tab was accidentally deleted in commit a8efc69a65fb ("shmem:
provide a shmem_write_folio wrapper").  Add it back.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_backup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_backup.c b/drivers/gpu/drm/ttm/ttm_backup.c
index 0c2d53a13b2a..658eeab73255 100644
--- a/drivers/gpu/drm/ttm/ttm_backup.c
+++ b/drivers/gpu/drm/ttm/ttm_backup.c
@@ -160,7 +160,7 @@ ttm_backup_backup_folio(struct file *backup, struct folio *folio,
 		if (writeback && !folio_mapped(to_folio) &&
 		    folio_clear_dirty_for_io(to_folio)) {
 			folio_set_reclaim(to_folio);
-		ret = shmem_write_folio(to_folio);
+			ret = shmem_write_folio(to_folio);
 			if (!folio_test_writeback(to_folio))
 				folio_clear_reclaim(to_folio);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
-- 
2.53.0

