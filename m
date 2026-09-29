Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ED8C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 03:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4409210EC6E;
	Tue, 29 Sep 2026 03:45:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IE+IJiW7";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10F010EC6E
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 03:45:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790653532; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dA51Th++szXCcZXTAAjSK5g65MhU4yEaxN6HI3IM9DJomzsoFo3rv9ILjCYYSrJDvfA+nRWTeZpm4gKqIblJdtV8aka2fqefrcr9+/NEZXqVp+HuDMRFk71kl7Z7MF1eJ1QSm5ru5Wl+5J7Y6quvTX7NV0zzrgevDzO7dxNnRuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790653532;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YLJJEy7HObDD1CKVtOGtdrfPLM+ZQOVKX8SKLnJRFuQ=; 
 b=PVsdr98VIfSFdrZIP+KBnYsqSc2aiQjVmWklrCOgBkpwN+EWUj2gC6hTgCEC4BKkKHZVpXkFj3W0m1jSx8f0xCxqRwtREh2GVvwKAaXzO9ZxAWRtkDqUv9RkaFiKci6kQ1QJqlsh3zjMaPzA3zM6prApKi37ZiCc+1Lkc0E3vxU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790653532; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YLJJEy7HObDD1CKVtOGtdrfPLM+ZQOVKX8SKLnJRFuQ=;
 b=IE+IJiW7AQqwHQgqlXZ+5lTxjMYb3UmyyEakAxgQNy7xZAjBSwn7liRVFD0+bhIu
 3omyhI5Bbql2DpMqWM0GQWRvFZhCpKWJXWFtVwyxRapN9LonlGUYwrJKCmXXvZa6yw2
 Txd1dMEyqJv26YV+t4QmodduwViDZC/vl/IL+XjM=
Received: by smtp.zohomail.com with SMTPS id 1790653531178228.88974314019276; 
 Mon, 28 Sep 2026 20:45:31 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 29 Sep 2026 04:44:41 +0100
Subject: [PATCH v12 07/15] drm/panfrost: Explicitly enable MMU interrupts
 at device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-claude-fixes-v12-7-62beb08de207@collabora.com>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
In-Reply-To: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1801;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=rGbyQBkNbY5a1OXBSal5Mure3AlHLFxQtfgc5Bhzvks=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBquzQu+y05MqZ1J7fPyK/g2YGOhgI7tUe8Ewf/q
 4W1OKtMYLOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCars0LgAKCRAOJn5M7lND
 PVD7C/9fZDxjiVpSNnHROb8AbR5B4cCHlZqKBL80/c1qJOxwIKBSsR8jpwGVV1jfju9gd5gIt5L
 SPviAlCjE8hvr4d23onWS2ZWlZQqHu31HL3b6dq/dkVSgVhEGe4jUBRgBzjXE2bD9upQld+lebb
 7HwLh4oaIrrcl1Gdph+WqWmap1HBPliVDmGP/CTbgyAEm4bO6bGIcmfAUF/9qyH1glydt20Cnb7
 Ha2KJRmjRe0zKv4EAWXNNF0onajH3pvo1RDpqt1otLqLpJ7oTWHhoICOMFZM4n8GyvEuwOwaYc6
 y70NZDQQpT2/n6XbrwmOoyOafiWF9CZd/4gSmJ2lqyd7+vjkF2bjmG4fl6e4XwAyjuy3EUMxmS5
 BztLZUTg+uIjsz0d7E1RS987q8GBbClU1oSdJIMHBrEVDrlWfWrK6AYb8QIoTKbWL6DJQLRWL2W
 aODsni3UYZYmylKYlR5dMw2oVvP9a04IYYINtGXHm0nmaJyglX1jAjNgrxQ5WQgDs8sjc=
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

Because the device must be in a position to accept jobs between the time
drm_dev_register() is called and autosuspend first kicks in, there's a very
narrow window inbetween during which jobs targeting the tiler buffer
object would time out, since the device's PM status is 'Active', but no MMU
interrupts were enabled at device initialisation time.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 5c393ed6e310..faa62643caf1 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
 	WARN_ON(atomic_read(&mmu->as_count) < 0);
 }
 
+static void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
+{
+	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
+	mmu_write(pfdev, MMU_INT_MASK, ~0);
+}
+
 void panfrost_mmu_reset(struct panfrost_device *pfdev)
 {
 	struct panfrost_mmu *mmu, *mmu_tmp;
@@ -355,8 +361,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
 
 	spin_unlock(&pfdev->as_lock);
 
-	mmu_write(pfdev, MMU_INT_CLEAR, ~0);
-	mmu_write(pfdev, MMU_INT_MASK, ~0);
+	panfrost_mmu_enable_interrupts(pfdev);
 }
 
 static size_t get_pgsize(u64 addr, size_t size, size_t *count)
@@ -973,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	panfrost_mmu_enable_interrupts(pfdev);
+
 	return 0;
 }
 

-- 
2.55.0

