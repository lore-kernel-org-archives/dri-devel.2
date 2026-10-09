Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6178CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 12:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231881120FE;
	Fri,  9 Oct 2026 12:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IDhGGhDK";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808531120F7
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 12:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791549279; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TTgrlelX44J1g8iXpleatG0bLMAwO2G5PYnNxg3zLjoMtMottQMqCFZAVOZgUKGw6NhveYeW+WQHxvQiCor0tRszVTiOm2x7GSeNZ4AF1BcS93y6Guv3d6WON06tA4EzCIgeVys2NwMvIOVZwnyh4vCnnqcc31ZESIbAz5GLrLk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791549279;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ShEH6DLHKaOUBeOh6vzWeLYbnwZ5VEXVABDAJAv4pdw=; 
 b=LQKmrtFFqHDxMu80Hqa0wQd8y0LUyFB6WdKjYNLuhaGTW206x0Par+jM2HdkV+YEeMkbXBvFEpzaZvSy2bwsdrIQ3el2ZZ/LqHkShwBlAeffsuW0z3ynZAKmCSi4/qqjmbDZ30MO4N71HcaccSF0IlLVkFONfVXTtbyBzlQBcqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791549279; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ShEH6DLHKaOUBeOh6vzWeLYbnwZ5VEXVABDAJAv4pdw=;
 b=IDhGGhDKE8c4BfqYGrHiayEFkchfyKQGQYs5pkoTo9D2LbmdAkBT+CJ1s3Z+lNzj
 Q/47F+71dQUEWAdNN3SP11/r7FVVHIi3j8tmxgeah6XzlqOKLvmEqIjQCMSjrqixU0G
 3WkAYt6iRC9uqniniTMlrk1fC1xritxfzCufcqfc=
Received: by smtp.zohomail.com with SMTPS id 17915492782031001.7035613707259; 
 Fri, 9 Oct 2026 05:34:38 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 09 Oct 2026 13:33:54 +0100
Subject: [PATCH v14 07/15] drm/panfrost: Explicitly enable MMU interrupts
 at device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261009-claude-fixes-v14-7-cb743b3b973b@collabora.com>
References: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
In-Reply-To: <20261009-claude-fixes-v14-0-cb743b3b973b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=VRla/9/j1ctQPKkQlCz/7b+MRbrWbY6Dgj2B2Pzm53s=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqyN8u5bz0Mk8PoTUg1huv1XHwtf8FrUFjfotW7
 useNwSLB2KJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCasjfLgAKCRAOJn5M7lND
 PTAZC/9emK1CTRJABz0KJg+ZdZwDPGTcdcKieQ1XgLIaWIajcRHR3WBAlHSkwnVk7nS/s17t+ck
 BwnA9b4uNKTvQmdJx1ZGOTM/WRSAzH7s8V5OVgeu5FhzotvfiUZVolnb7LzxXAILICpDLn6958d
 81AlRVKGi/ZLsCgAXtLq5jPd/+h4+Ca3s9KdBcNtNniF1Mx3RoLOw4b4fcRQtYWeO2o4tFmoh1W
 tP0ifZJNQlJRQUB/7lr847AANeQS7fEIl4p8j5KdJGpL4xEzn6eMwdSjgTTr44gSbBkYWejlnzB
 DAXGxJcfCYAbX+9GpS3CJ2vCzdnuCZcJsEMTQr7vVOMhCjMrw6WbyImC9IkwpZFnkR0fxLDxrGJ
 icWEMyfVzEPCV9w2KHr9uePaaXPjf5ey5YpGeW3wbYKNttw2qkPY5sU2Dlcu261aRdMshr0/Bha
 on/vKsYk1SiUaGjfmY7VVj5UmB9hPm/ILD4ZlcEzmTs1vfjZebQ+zRlAYYzSMOajcTQVk=
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
Fixes: 73e467f60acd ("drm/panfrost: Consolidate reset handling")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
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

