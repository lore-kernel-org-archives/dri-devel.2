Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFACEC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 02:55:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 047BC10EA73;
	Wed, 29 Jul 2026 02:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ZU4r8lHZ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 868F110EA6F
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 02:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785293695; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cQ8sZJIutw2aqIK/Y3gzTvEmVh8aE6ia4JzXggra33IZqDZRQIK6YGUuJ1we0SsLbcT6D+y5GtUQC1WosyzjNwDww1bvsMQ+9oUgsh0Y7j09Wlvg9Higa1XWFtuEjCyekf9tGBOUz2QzvSoSrryo3ijL8QMqpdIbBG4rjReyb70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785293695;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=oiYbBKD6ZY+jwgFsAD9KN+Mmq6A7JTPK40kyIvdjJeI=; 
 b=ZPpD5WEXVsmY7hXXSq+pB155gaJme4d9vam+SZHh6mfguVnXioTD9mQgveleij/ceSm0DY07+wAYGX7BIADtD7YeC6J3wwg4hNq+TGe4Qhh7oz6h9i5yfS+jirS76WUV8xjtsJ9toTdu4L7VPV//N2+kj0bTVmq9iep8e9MknY0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785293695; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=oiYbBKD6ZY+jwgFsAD9KN+Mmq6A7JTPK40kyIvdjJeI=;
 b=ZU4r8lHZvdZ7evlLbeXXKWJvSMf0U0jS8QDHLmMrSdD5oW72mX8n58gGrKnzwzsG
 s5Rj3yan06A+PXMr5+f7brErJDq23y1zNWC6sQMqkl8kuE6lp7KSszonhpJcZ5DeRnX
 11GwBtG5R+X9eDFjY/6mfjijSSzgs2lSvpBnC/80=
Received: by mx.zohomail.com with SMTPS id 178529369282118.5347202918598;
 Tue, 28 Jul 2026 19:54:52 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 29 Jul 2026 03:54:18 +0100
Subject: [PATCH v4 06/13] drm/panfrost: Explicitly enable MMU interrupts at
 device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260729-claude-fixes-v4-6-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
In-Reply-To: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=J6nU29PKwOnLrEaVubTgA9gTgNhKP8lp81h/14jKNeQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqaWtX37kzAJQmfPr7Zx3tD8JXjs1Ja8SXCctO1
 PYZIZ/4x8eJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamlrVwAKCRAOJn5M7lND
 Pa47C/4vxiRfNFZ7ArpFHlW1W80rWx6gNOfhmVr4x4gsPdvzGGzMua4xbsknQOoSmXJ+EChN5ka
 yS/HD+SDREl+qQN4NWA2ScmFVg8b7kFolPKbayuTDhcs/F4kB1OWOQWq1CUDjBf7SoSVIB74+Xm
 ZCSPohV5K+HjreWhgmEApixtlDWjbyjA562POIJA9Ivucf8kSUhIPIKHvRDZvfnz1WRyF+jJM/Y
 vA5YYGu1iWr1UCxIoD402MNYBoQm75h9oN8GemJsdKEd1orOwcCCINn5oRGruvx/XyUBqVfqHO+
 sqHDJVvkQy8XTFeDpMdREYVI5h/TzXMmQ5rKHZs+OCETgrh2hhs1KRvNsL9wLVZVH6Id137jvlJ
 QyEltIXBsqBYgpTjih6eehfKvqTrmGGHdWqy2Ybc6P3bWskMb/Ba94C/mPSpTQapSVB96oaKo8A
 zESDdy12fCDITA+n2WU7h1P3VerXFit1jN3CVu1VgPdo1i1T4SKXLfIHyLapEKPsOegGg=
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
 drivers/gpu/drm/panfrost/panfrost_job.c |  3 ++-
 drivers/gpu/drm/panfrost/panfrost_mmu.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 35ff5b0f0013..bda1494eb430 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -871,7 +871,6 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 	js = devm_kzalloc(pfdev->base.dev, sizeof(*js), GFP_KERNEL);
 	if (!js)
 		return -ENOMEM;
-	pfdev->js = js;
 
 	INIT_WORK(&pfdev->reset.work, panfrost_reset_work);
 	spin_lock_init(&js->job_lock);
@@ -906,6 +905,8 @@ int panfrost_jm_init(struct panfrost_device *pfdev)
 		}
 	}
 
+	pfdev->js = js;
+
 	panfrost_jm_reset_interrupts(pfdev);
 	panfrost_jm_enable_interrupts(pfdev);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 4a3162c3b659..aad0cd31516d 100644
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
@@ -880,6 +885,9 @@ static irqreturn_t panfrost_mmu_irq_handler_thread(int irq, void *data)
 	u32 status = mmu_read(pfdev, MMU_INT_RAWSTAT);
 	int ret;
 
+	if (!pfdev->js)
+		return IRQ_NONE;
+
 	while (status) {
 		u32 as = ffs(status | (status >> 16)) - 1;
 		u32 mask = BIT(as) | BIT(as + 16);
@@ -970,6 +978,8 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
 		return err;
 	}
 
+	panfrost_mmu_enable_interrupts(pfdev);
+
 	return 0;
 }
 

-- 
2.55.0

