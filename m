Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DFEC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE6E10F2C0;
	Thu, 13 Aug 2026 10:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Cch1nbNV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED5610E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618625;
 bh=KvwsAYDk+lrfMWGaKagitWYN8fUVhylr5egO46S4+Vk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Cch1nbNVjxVFVcPMfvI90Q4qrJRDDuwrhdJ4HiR3WPaWls8OqRRcLwyehLKnUGjVk
 J0A23oPWz6ZhptMhf58NgxgQSfAjJc8uEYclOw4vyDivUZwYxy/FDA4079b97b2y7G
 sX2JppLWgnzqbf2spEH2mCXuZBkJ/OX/C3qKkOO8DMji9M4hqloEIaO2VqGwHis7U/
 MjCmX5lDUj178oFna6ixQQl6RkLWuW7P6yg3Pf5ImdU6lZYvlleC5wvBXrtNq6SScF
 mrQzgFrRPsB//hY0DswaYIKXiRVF7sY0VH+3357daLIlHyhKLWvK7bDBNiO43rDUjY
 OTfC9u5J+Qkcw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EB49517E0FEA;
 Thu, 13 Aug 2026 12:57:04 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:02 +0200
Subject: [PATCH v3 04/17] drm/panthor: Make sure reset requests in the post
 reset path are not lost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-4-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=2210;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=KvwsAYDk+lrfMWGaKagitWYN8fUVhylr5egO46S4+Vk=;
 b=uCok+ec3UUGlIrXDLejRNputl1IO8+txbtqLKeud/m4cZnjRRq3+ySOjjDTvx2+pN+gUcI84K
 Umi4ompnJXBAh39MziZimQmdT8GARhtUVLXyyhs1mRLHds+PaF25eru
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

In theory, there might be MMU/FW faults happening after the FW has
successfully started, and since we clear the reset.pending bit after
panthor_fw_post_reset() has returned, there's a short window during
which a reset request can be ignored.

The other case is a reset condition in other subcomponents that would
not prevent the FW to boot, but given what's currently done in the
post_reset() helpers, I don't see how this can happen. Anyway, it's
probably safer to reset the pending bit just before the SOFT_RESET is
issued, so there's absolutely no timeframe during which a reset event
can be lost. The risk is an infinite reset loop if the reset condition
doesn't prevent the FW to boot, and keeps happening in subsequent resets.

Fixes: 5fe909cae118 ("drm/panthor: Add the device logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index 1a8f5ac24399..ffaff8c7088e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -156,11 +156,18 @@ static void panthor_device_reset_work(struct work_struct *work)
 	panthor_sched_pre_reset(ptdev);
 	panthor_fw_pre_reset(ptdev, true);
 	panthor_mmu_pre_reset(ptdev);
+
+	/* Reset the pending bit just before the SOFT_RESET to catch any reset
+	 * condition happening in the post reset path. If we're in such a bad
+	 * state we can't even resume the FW, we will bail out and unplug
+	 * anyway, at which point the reset work is disabled, which should
+	 * prevent an infinite reset loop.
+	 */
+	atomic_set(&ptdev->reset.pending, 0);
 	panthor_hw_soft_reset(ptdev);
 	panthor_hw_l2_power_on(ptdev);
 	panthor_mmu_post_reset(ptdev);
 	ret = panthor_fw_post_reset(ptdev);
-	atomic_set(&ptdev->reset.pending, 0);
 	panthor_sched_post_reset(ptdev, ret != 0);
 	drm_dev_exit(cookie);
 

-- 
2.55.0

