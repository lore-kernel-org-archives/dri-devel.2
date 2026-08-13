Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D54EC5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7C3110F2A1;
	Thu, 13 Aug 2026 10:57:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Qih0xgbN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58D9010E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618626;
 bh=Errsu9GFDWfK0z5mH/zvEVz/71ISvAg4XKJzEn3gCLg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Qih0xgbNBTmxBp68V8DmtIP9jKjPCIiINtC6T0KkagjjkxPQV3rCtLcnZHjC5t7rc
 QXQejYD18aeQHJ7jUmFfdLfX9zZgRKEZzDT2WE4JmbYYtlmCPlncD7MWyC+hVIdf2X
 Urdhu4b/pM3n9rUYKk6TDNPkJG3PwQndxn7G0i3ioqA6UkVPNLJNjhdq3ag/Qe+pU8
 igC4FQaCSr8Px8yLHiYRN8TD+c69mjv6goVvhFgpqPz0g+SB87l16Lh/QplGDMfm1W
 YMe9+XaSuMHtO2sCAWZfm8V7EeolR8lMZ1MW9JdHKAm12sxrKsozrPGUNY1I5MIOe/
 ss25BSLL6ia9g==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9B53017E107E;
 Thu, 13 Aug 2026 12:57:05 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 13 Aug 2026 12:57:03 +0200
Subject: [PATCH v3 05/17] drm/panthor: Flush the cleanup_wq in the unplug path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-panthor-unplug-fixes-v3-5-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
In-Reply-To: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=2353;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=Errsu9GFDWfK0z5mH/zvEVz/71ISvAg4XKJzEn3gCLg=;
 b=nc3euCWw3cScJh3kNrwZZq3PxRoduOjxqM6FMRqPfzIO7rRSDDrrGwK4tKS0USsiFrMDmVXnN
 l6jr8+sPL5KAlqtp5WJ2a5YN+oI4Y2uvq9bAW/Y0VNKpjUJ32/6iDfu
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

If we don't do that, we might face various UAFs, because the resource
referenced by these work items might be gone by the time they get
executed.

In each subcomponent making use of the panthor_cleanup_wq, we add a
flush_workqueue() at the end of the _unplug() function. Note that this
assumes no more work items from this subcomponent gets queued after
that point, which is not yet guaranteed, but this will be fixed in
upcoming changes.

Fixes: de8548813824 ("drm/panthor: Add the scheduler logical block")
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com?part=2
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c   | 6 ++++++
 drivers/gpu/drm/panthor/panthor_sched.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 0182b72f1932..0b862d3c3605 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -3365,6 +3365,12 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 		}
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	/* Ensure any pending job cleanup work are executed before returning,
+	 * otherwise those might access objects that are gone if the work is
+	 * executed after other components are unplugged.
+	 */
+	flush_workqueue(panthor_cleanup_wq);
 }
 
 static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..f18b2e03f2fd 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -4074,6 +4074,12 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
 		sched->pm.has_ref = false;
 	}
 	mutex_unlock(&sched->lock);
+
+	/* Ensure any pending group release work are executed before returning,
+	 * otherwise those might access objects that are gone if the work is
+	 * executed after other components are unplugged.
+	 */
+	flush_workqueue(panthor_cleanup_wq);
 }
 
 static void panthor_sched_fini(struct drm_device *ddev, void *res)

-- 
2.55.0

