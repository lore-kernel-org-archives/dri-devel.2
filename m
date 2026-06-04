Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6324CD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 17:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC3510E3B2;
	Thu,  4 Jun 2026 17:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Di0y255M";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56BCB10E3B2
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 17:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780594592; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OMnNGLGG53U94c7xEB0m3gMLae/8GLdv7UaaFWFWmp0JgBaRKUbWKBr0mSNUy8qhyIvCsfQgTao1d85QbE7oMrM5s86ClAUuuHx+ix7fagUvcMe1nXspEz1dHTSCLXbD4fayiBZffNuwcuSl0qXdRdDqenrSd3pjmddZcLXVv14=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780594592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=j9sHSUi3PmhX9PYpd3gB8oPKmw+NZRiTKgTWp5KmbvY=; 
 b=JUmjweEeyxiq0iBBF27fVcu1pMn0kl6VAm7dgY3qCJqx6v/kjvV2KXZm0i21CWEySpXxV0i5Kd9hip8YC0m5MOwxh1GVopiKvzErHqX3P+kMie0+hLKGOVA2bE1cJdNzbfsyhZhyJtC9cLqM2DQIlNkjmq24otZkqWUhdgjQQrA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594592; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=j9sHSUi3PmhX9PYpd3gB8oPKmw+NZRiTKgTWp5KmbvY=;
 b=Di0y255M//6qV35Smt1zgjoUJtsh79i52Kp+OgbqvOdFA6MYuEG2ausbIiiXuBNR
 CkLfpACoCZ2P3kVF+Io4tfyi5+J1P8mLiOYUKChO5ZxOIpXNLyQyOtW1XmoxpRwtdgv
 gPz/rFJLqcFlWrTZcF/Y2gwE6sXmILKTvmhexA7E=
Received: by mx.zohomail.com with SMTPS id 1780594589499864.5746767377244;
 Thu, 4 Jun 2026 10:36:29 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Thu, 04 Jun 2026 18:35:26 +0100
Subject: [PATCH v2 7/7] drm/panfrost: Explicitly enable MMU interrupts at
 device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-claude-fixes-v2-7-57c6bd4c1655@collabora.com>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
In-Reply-To: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2429;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=dumRWtp4ks0Q+DvO95uLv2aU5B4lPaQ5XXruf50mea0=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqIbd8qyzpVeiBvyKn6MXpEAqRsQQX5nUMCyQRg
 564/zYNLAWJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaiG3fAAKCRAOJn5M7lND
 PSfWC/9Al1Q6ur7ppUBvtcaB8NA6FovK3aFRf3VHVnhXhJsAvU89a9nlIFuF/7R3ualt7/1M1/H
 rj8Pbsx5R7XDUhUfkWqivODBS9G7DXU5EkV5nbNwYkp0c2eczI282ho1xa/8JE4Ech13MvbcZRX
 wLUdCoZRwfKRgsKrw5k71u97ohv0j0UhnZp0CJv8i0OPedmONGUKEa1BATIZ271lZINMNrsOfZM
 uJDyTM+mQBraRCVQLQwMZBPylMZxAQ/lsVbX1XAQBZxJQF8GjFaK48p7DUBVJ1Z8PC7N6e0LC9o
 /eDI76PwbGjpXIRmqf0Yd6FAy141V2WuLLzBfwIFuPo4cTkRQBhrUdgVQG8xQVqvZflLEErwXqJ
 EkSsg4vYXOAkXNbSMCB5oklgSeE1H66VBkttvFwUL1IcuE9ih43+5K/P/LniSwKAs/X+JMELaMV
 ZUYNfreOpESciYPt4Jr/e2uzE86vRWhrmOYWFTlpbQ57c3N4NIgmI0VvL5e5Pg7WjYLuk=
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
 drivers/gpu/drm/panfrost/panfrost_mmu.h |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..0e1ad6256c2c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -336,6 +336,12 @@ void panfrost_mmu_as_put(struct panfrost_device *pfdev, struct panfrost_mmu *mmu
 	WARN_ON(atomic_read(&mmu->as_count) < 0);
 }
 
+void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev)
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
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.h b/drivers/gpu/drm/panfrost/panfrost_mmu.h
index 27c3c65ed074..3140eb4fea0f 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.h
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.h
@@ -12,6 +12,8 @@ struct panfrost_mmu;
 int panfrost_mmu_map(struct panfrost_gem_mapping *mapping);
 void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping);
 
+void panfrost_mmu_enable_interrupts(struct panfrost_device *pfdev);
+
 int panfrost_mmu_init(struct panfrost_device *pfdev);
 void panfrost_mmu_fini(struct panfrost_device *pfdev);
 void panfrost_mmu_reset(struct panfrost_device *pfdev);

-- 
2.53.0

