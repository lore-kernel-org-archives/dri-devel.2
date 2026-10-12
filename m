Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D076BCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E5310F194;
	Mon, 12 Oct 2026 14:48:51 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54B8610F1A7
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816520; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=E2i5GqBvMV0nAE7o5ughBk4Vjgk+POyiZmheKdK4blPHMx8rKKOWk4z/OaKP4wtpmu9RkMce5qURBCmBDBAOOVVrdZb7mvZHD2i5EsQQeRoxpIDhCeZhLuwGpLCdR41G90bNsed1QrTXb7M0sf2Pv3eUJDYMGzD/osV9jOr9ibY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816520;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ShEH6DLHKaOUBeOh6vzWeLYbnwZ5VEXVABDAJAv4pdw=; 
 b=NWqMXfCveqxxuEp77bxsC+3/rC/NdEh4vEo+H2uqD1JkGabcyDgz9/WFdYFoTqoxwufvVY7HtUqxUTUdk502nFXJ311BOfxPBVeZHcQSUGfFPjzCpLj4jXtxBvOmy2bz1EgEvgHWJVqDpvsVfsYfGbgaRh8ScEamBRZhNiVcsQc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816520; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ShEH6DLHKaOUBeOh6vzWeLYbnwZ5VEXVABDAJAv4pdw=;
 b=XFyh/Y7Qvvql9sSYroBQL0DHxhxcd2r56Xefstv/qxwOui8MhzeUinJtkflMm4Ji
 W2qpodA6WCmA1L4SOs4R2aRP25+61DRLJ++qCktuIzLcHdxNHZryhzVw2dfZTzuMz8A
 E/+tBwoODhLENcdWIVV7IKB6hmgts5zdx6Zxhahk=
Received: by smtp.zohomail.com with SMTPS id 1791816518810799.0691997814432;
 Mon, 12 Oct 2026 07:48:38 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:47:59 +0100
Subject: [PATCH v15 07/15] drm/panfrost: Explicitly enable MMU interrupts
 at device init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-7-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
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
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMalO+3/H7GJymWE6mVixkzf/fWuf6pWSV48
 nEWmjHvffSJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGgAKCRAOJn5M7lND
 PdJ6C/9k0mi9vpbxr81l7Du3OWpv6BRgYIahYFH8cjlZIjqMawg1o/2yrv6tZOkr8ks7mhDcbwT
 3zpqqjPuD7ivIzo62oQa9bo5xI9i1J0AB9QO3hWbrEsbPTQemZEYI3qfOBVJQczyj796sIDmL5U
 9q4H2OYaSCGTKIq/qMdOIAiehE1/GrmD9Arjg4NR21O/ZUUHshRRMqzJGzxSrpPYaQYwPzJ9gKf
 As6f+ZY5mWPIamQSCL7Z1MjCflej3XmeabshLkx+9EZsSTR3ttdNRU7/t0DsQDg6mJmmTcyBU/W
 gbvGNmf/FIuW2W+saEzEcVCaxPQvfg8IHocC6pDuDESWdZUwv3RyKIQIrmHcEMmshrIo/4mejQn
 OwWRrZ1jroYLb6QFLI2srqJHQLBe4YN6leQbHb+83tSsTKasqwSuZPTlYRmTa74XRVZYOI9An+S
 T3M3VrC9UaSb9VyIExqB0EBf5mI0QUhXgBGEUUbDebRl3Re5BY+1UjZyuNk7CKF09138I=
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

