Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EE5C44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 12:15:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6799B10F8CB;
	Fri, 10 Jul 2026 12:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UVukj9lc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10EC510F8BF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K/2IUjuQFRN5BUekpnXW3zn6NsNjr1nAgceJob9Gnyc=; b=UVukj9lcgepyviWzN+PbhvGf5x
 yqFlE1R4MH0ltYy4obju13kyuUdWFAHBOanQlHPsqW4/o2pinZnAfJIxEnV6RO8X7fDksSu9Vz6cY
 DPc92uhNMxQNlgOzbNGnN1pC/zBzx69Yv2MoeE9eXgVm904Q4zgi2cxwZxj21aYoxsb8zDv9hFV3+
 MqYD1Vay80MdZc5iSh3Sn9tYBpykPazlkc+qgM4VwwrsRdc7fBkOu6e7IYbuyqIXZ3rzFx5zcDQCb
 /WCLNeo4HMIvlgUGY7hZ4SEgIFAD+dC3ljjfUCdH4qO6m9cbAAtS5/V4C5bYH1xDgR36Mv5AAtdhS
 omxHnL5Q==;
Received: from [189.7.87.67] (helo=prince) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wiA83-00Cfnf-Tq; Fri, 10 Jul 2026 14:14:52 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] drm/panfrost: Remove unused scheduled_jobs list
Date: Fri, 10 Jul 2026 09:14:21 -0300
Message-ID: <20260710121423.2820472-2-mcanal@igalia.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The scheduled_jobs list head was introduced in commit f3ba91228e8e
("drm/panfrost: Add initial panfrost driver") but never used. Remove the
dead field and its initialization.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 1 -
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 7fed22d555a5..d0a23c51be39 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -218,7 +218,6 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	int err;
 
 	mutex_init(&pfdev->sched_lock);
-	INIT_LIST_HEAD(&pfdev->scheduled_jobs);
 	INIT_LIST_HEAD(&pfdev->as_lru_list);
 
 	spin_lock_init(&pfdev->as_lock);
diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index ec55c136b1b6..1fe1554f2652 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -156,7 +156,6 @@ struct panfrost_device {
 	struct panfrost_job_slot *js;
 
 	struct panfrost_job *jobs[NUM_JOB_SLOTS][2];
-	struct list_head scheduled_jobs;
 
 	struct panfrost_perfcnt *perfcnt;
 	bool profile_mode;
-- 
2.54.0

