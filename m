Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B440CC531FF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8E910E610;
	Fri, 24 Jul 2026 00:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="TpYEfkio";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 890A210E60E
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:00:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851225; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M5Z7MsWG6+EVe7qg5Sh7qB2xnvsxyCP1ADq0Mh+AMd9kAyObv0DmeJop7axtex+XEeDv0j5CqdndDAyKQa81rWJua26g2+PRfpZTLWAwADx1U4vXjyG2xjfAfZIh26gqlg51+pnGH7zNz3VNqcrU/a8SGCBL04OfTpCox09WxsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851225;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MBgoPp5s7KIQWnhfEKXF0hJxZFpuwcxeEJcGxa4bIhs=; 
 b=TLAbSUl+raKUqNS5zYfyuS5QiyQKrSQRJOM9WJFScZvPImWczpwZ9UO3eyPb/1oZbIFLK0tWojDYpyoBIBXAwfdKvE9HbaNoFPwI6BpKapuTz+dSQR2X7vzYmF9CqM3Y2UwgNBLuj4I7UbFLFYVmEja6MjDKBGDD97AuciUVMww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851225; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=MBgoPp5s7KIQWnhfEKXF0hJxZFpuwcxeEJcGxa4bIhs=;
 b=TpYEfkioORXRSzKM5Ac3YFa3UAYcB3oAeJSYYiFgcUrdArqM1ceqemG2YHgtmJs1
 i51sDtqMAqq5qYGlRdmKpJ5BXbnS60NuC3nuzy9JdrxrhFaw8WVBm1f80oNevAgjiKo
 1MgAji/O19Hh1licTzAs7KlYExUKiFmJURvY+hoU=
Received: by mx.zohomail.com with SMTPS id 1784851223294979.3334303946799;
 Thu, 23 Jul 2026 17:00:23 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:58:59 +0100
Subject: [PATCH v3 06/13] drm/panfrost: Explicitly enable MMU interrupts at
 device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-6-542af61abd0f@collabora.com>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1739;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=b3rUBnUVHsxL0qbL84XxzR6UioXNuBd6TsgNEfCQOaM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqroVZoewLayjRfqnPMhaE7VHdHmo5GlzECEJ
 PQPsGEfUfuJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6AAKCRAOJn5M7lND
 PZyNDACzJp1A/MDQrQlmshjGtC4icMDlPYF7mvgrKgRKtS9NF3A0JmgADuoSGq2ELoGG+/3cqRe
 6T49Xxp9ddVWYR8WTbQGZEG/HZgTLrknBGuBz2mBkGVQj4K1bMjhimarkw66p1D9Pk9Xa3DOGCD
 17E7L04SBqRE5tBVf0WJIbHxNxjo2IN4wgnEwwV3adl8n+PsjADaqbRF0MqMKiQdUyT9bX01UTU
 Xa4XC5AmXyC4Zz/hec3eI0x5LwSacXX0X0bj7OxnOfFdHOeB6xrU9N4BjEFUZhb7i5XE55dk5Z5
 IvHGOvH4QOLIg06Rp7FgbMJq76UUEP76S93UGJy9aEfuRydvd/un54NNvnmaE4pLbWnxg7s+RMe
 e1uHqC2bmWxdYtkW0WvnVxWGbsez5MVMopXv8Fj61vpDRJ//tOvzfhDu0inUQ3c+s7KfaV55vk/
 bEGm1s7GeyA4/3EeBQRxkVUWaoJb4aIszinvae0aZXzNfi41vZy5Cug7bA/BakW6Ii9os=
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

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..bb6c1614964b 100644
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
@@ -970,6 +975,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	panfrost_mmu_enable_interrupts(pfdev);
+
 	return 0;
 }
 

-- 
2.55.0

