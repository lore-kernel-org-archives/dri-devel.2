Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1CFC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4270610E374;
	Fri, 24 Jul 2026 00:00:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="cGp3TBsx";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DDF510E374
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851193; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hZFmM5vPl0SYj6YFlsYqnwvT3iFn6Vb54QTRGyH/QECnAUPvC8XGkOqTh16KLRyHKsQYzHdGUfEQRjAFsYLb5ldnLc5PQDmvGGssY3fc2DENmxgzzdyt+5MdKLgDHoXVihYjGD0IWK9xv7glegrXwE6vtKU24IFSSmsvYniWgVQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851193;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=; 
 b=DLApQv0kp2V8rigQA95i3OPWvaRXOfze/HdHxhU+aZrT7OMeUfkb89ylq7BAYs0RMvzfDl82mpy0xA28yakDkYz62H0hxNt29Jmhbi1MBEKeqnw3cqByzWPBJN/lf+vXLs8w0U0TNiacxFbaRtP6Khv5RbodGDpME7/lZ5SwzdU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851193; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=nzqJgETVkBIGkNjZS88+/BocleoPmjMybUJQH20vWSY=;
 b=cGp3TBsx1FPuYyXMnSDjSg3pKDDun1ZhiR/iDNppm23PqsotEbyaFX5TuVIY5NS+
 GEIb4XJUGxhH11ufc0e6iNCxuEJjjtmD6OuyeeXH2UFh+rIr55SBZC8RaMjWFBIc5QG
 Eqy6lKBJ6mPupgCAiGlYLsj7a3RxJJlfS+bs8aFg=
Received: by mx.zohomail.com with SMTPS id 1784851192170589.3654331289381;
 Thu, 23 Jul 2026 16:59:52 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:58:54 +0100
Subject: [PATCH v3 01/13] drm/panfrost: Check another bo field for cache
 option query
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-1-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Claude <noreply@anthropic.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=s+TFqnBLyffcvvRdt+XgtQK5ewLRucmgSP4lvTByoVM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqroT4QpjEyKhJbOJHCqUZ/aQmQeSIkJKDXG3
 Wm5uwwGXZSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PVVBC/9H/FKJsYL4jQOBDDJpIeAKslG7MoXaE58d7JGMq3kFEFL+GitO4mjkHcJLCG3UlmZPs7a
 DkWJQwHIXbWor3Tk3NEh79WNhSR6LxUWroLRUduc8y3E5C7x3THMiQOZOdsgH5moU1HraJSJRpQ
 SOip3IeiJsza2N48oo39CBKBqGEAvoSvnfPqAa7F13Xo05ZR01QSh7/7oaJXKkNyDmDxssXMPXa
 Ch5AA0ezN24DTKJ9/l46TmJh4GmxetZ/yx5AaQ8xKC86ZnJ318pZWQ6Uo4h1GWwuJiEJCy356pp
 HFpIwDFrBOA/Rd7J2hSJx0DrZ56OYkpXZpzl9puavVcbTu+O15o/hCU05K8h/XZgbXMBergqSl0
 /uSJMn0+0gH6Gw8OiP3OdsfnlEDO60wS1+t+jwkTo7FeKwcsbPc/KjGhb4IYMlhKbS6HjM95/ae
 z9Ws/YQ4EzI+w69erXgGDYA9tDcbgDs3Qt57nmEETJzlpY/3/XZub0q4W4oWRO8QaV/EE=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

When querying the properties of a BO, whether it was created in
Writeback caching mode for userspace mappings, is recorded in a Panfrost
BO's wb_mmap field.

Reported-by: Claude <noreply@anthropic.com>
Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88
Fixes: 62eedf1ccba5 ("drm/panfrost: Add flag to map GEM object Write-Back Cacheable")
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 784e36d72c2b..2e931fa90da0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -661,7 +661,7 @@ static int panfrost_ioctl_query_bo_info(struct drm_device *dev, void *data,
 		if (bo->is_heap)
 			args->create_flags |= PANFROST_BO_HEAP;
 
-		if (!bo->base.map_wc)
+		if (bo->wb_mmap)
 			args->create_flags |= PANFROST_BO_WB_MMAP;
 	}
 

-- 
2.55.0

