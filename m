Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91A606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F36B10F996;
	Wed, 25 Nov 2026 02:19:31 +0000 (UTC)
Received: from yocto-server-2.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11B1610F995
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:19:29 +0000 (UTC)
Received: by yocto-server-2.amd.com (Postfix, from userid 1009)
 id 6BF2BA0DD6; Wed, 25 Nov 2026 02:10:17 +0000 (UTC)
From: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: drop duplicate hotplug uevent on DC resume
Date: Wed, 25 Nov 2026 02:10:17 +0000
Message-ID: <20261125021017.603857-3-Jyotiranjan.Bhuyan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125021017.603857-1-Jyotiranjan.Bhuyan@amd.com>
References: <20261022094835.591175-1-jyotiranjan.bhuyan@amd.com>
 <20261125021017.603857-1-Jyotiranjan.Bhuyan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_device_resume() sent a device-wide hotplug for every DC resume
in addition to the event from dm_resume(). Drop that DC path so a
resume reports a hotplug only when dm_resume() sees a sink change.

Signed-off-by: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
Patch 2 of the v2 series. This hunk was part of v1 and is split out here:
https://lists.freedesktop.org/archives/amd-gfx/2026-October/155562.html

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b24ccdd958a7..f070b713ce4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4778,10 +4778,13 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 #ifdef CONFIG_PM
 		dev->dev->power.disable_depth++;
 #endif
+		/*
+		 * Display Core detects sink changes and sends any required
+		 * hotplug event from dm_resume(). Avoid sending a duplicate
+		 * event here.
+		 */
 		if (!adev->dc_enabled)
 			drm_helper_hpd_irq_event(dev);
-		else
-			drm_kms_helper_hotplug_event(dev);
 #ifdef CONFIG_PM
 		dev->dev->power.disable_depth--;
 #endif
-- 
2.43.0

