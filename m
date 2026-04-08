Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279A610F9973
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202E810E6D3;
	Wed,  8 Apr 2026 19:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="C2/pU1JS";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A8110E6D3
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 19:12:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775675564; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AMgmqzCke+qA4bmHc2k1KSadqTWg9hdJo7YqufJnaYIT6R37LIkiL9p3wE5XHKz3wNhX+JAKle+FLOYq7aS3rNap6QNv8wW/pyD4Zyb4M+rc8YX0n/WwGw7xepnlH8jfcwDOUA7i99hvDoG979yXTD3kl7uiJI1XBwCWCYHPOGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775675564;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=hD2RYdac2HAVJCq3NYFTwqMUeLsLEECmlHbXEKLWJw8=; 
 b=elPgzxuqH2kQkCm/s8+nqQuNIU8TrmdS30IjsX1ZDSvCW7ScgAEr9KX5mBRyI+1HxPRMLL9jBUEntmsdIIk8B8BOF66VfMRdz8N/sjUTq5YIno5Kzuz7j4iECAy5T28aa38NPuUdamZWa5yk+QsNuCDK9vEWsqBbT96prEmr8R8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775675564; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=hD2RYdac2HAVJCq3NYFTwqMUeLsLEECmlHbXEKLWJw8=;
 b=C2/pU1JSN2T7hWt8aqS+slKtLh2IfM2JvlGW1Y/YkPbvc9o5HU3sLG8YZpRcobKH
 3TssKr0EnbqhS+XV6i3rrPTa1X3rGbebbyONJDMwL01k/YCuuX0VOHqhqzKjk+wL5Z/
 ya5pA17mghzXTL7SQRMldoQldJCwHA+HY6xE0ZdI=
Received: by mx.zohomail.com with SMTPS id 1775675562642342.8141427039209;
 Wed, 8 Apr 2026 12:12:42 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 2/2] drm/panthor: Fix outdated function documentation
Date: Wed,  8 Apr 2026 20:12:24 +0100
Message-ID: <20260408191228.537625-2-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408191228.537625-1-adrian.larumbe@collabora.com>
References: <20260408191228.537625-1-adrian.larumbe@collabora.com>
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

'vm' is no longer allowed to be NULL.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 69cef05b6ef7..13295d7a593d 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1264,7 +1264,7 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 /**
  * panthor_kernel_bo_create() - Create and map a GEM object to a VM
  * @ptdev: Device.
- * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapped.
+ * @vm: VM to map the GEM to.
  * @size: Size of the buffer object.
  * @bo_flags: Combination of drm_panthor_bo_flags flags.
  * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
-- 
2.53.0

