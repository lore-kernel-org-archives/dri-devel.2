Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969E606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=O+5ubAVa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75B6610E440;
	Thu, 22 Oct 2026 17:33:13 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0D810E3FA;
 Thu, 22 Oct 2026 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Kbja+mW/RKd0mqSMoqWV/SzERghJ7cvWSAD3gcCcv60=; b=O+5ubAVaxlL7v3s9sd9wNC/W3i
 K9cfVBeFWVdp4dXQOPmm4oQYxGNXWWku8Nxqtu/ZhOPAiufd2caTfgJ3SNRcmfVBh6BJluE8luh/W
 tT2LyPKKF0efKdv72Qzj5nl4XKVh+PeZkyBjhUX0CCuOHzMCUqQQ1hnLAKiiBlHPV20hL5kKRPxbE
 LkkrVbamM7VA6maLx+v55EC3brpsDrpNwxi9o4uE0NYgDpjtvgBP+JokadCdITjoMlQl08QqbbTDO
 ql4yc1+W91r997kMr3I1cqFGKsAmtJpsYf7L+0tnmSCJ5TB54Ko3LX36S/KkyMTWFaWHW75WUOae0
 U7ABqLBA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJwf1-0071LK-LD; Thu, 22 Oct 2026 19:33:04 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Mattia Tadini <info@mtsistemi.it>, Roman Li <roman.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 George Zhang <george.zhang@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Leo Li <sunpeng.li@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Albert Esteve <aesteve@redhat.com>,
 Geoffrey McRae <geoffrey.mcrae@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add null DC check to hpd init
Date: Thu, 22 Oct 2026 10:31:54 -0700
Message-ID: <20261022173154.2318054-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A bunch of the KUNIT tests (dm_test_hpd_init_*) expect that the init
function can be called with adev->dm.dc set to null. Indeed, the
dm_test_hpd_init_fini_with_connectors test has a comment explicitly
saying that the null is intentional. Unfortunately, since the patch
mentioned below, the first thing that the init function does is access
adev->dm.dc->link_count. Thus it is a null pointer dereference and a
boom (at least if running with KASAN).

I'm not sure if a null DC can ever occur outside of the KUNIT tests,
but there is presumably a reason for the KUNITs explicitly testing it.
So add a null check around the link_count loop.

Fixes: e38159437a91 ("drm/amd/display: only clear the hotplug sources the ASIC has")
Cc: Mattia Tadini <info@mtsistemi.it>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Albert Esteve <aesteve@redhat.com>
Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5b4ff079cd55..427f7bba343d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -989,18 +989,20 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	 * has rather than over the whole enum: the unused slots of the DC
 	 * interrupt table hold dummy handlers that assert when touched.
 	 */
-	for (i = 0; i < adev->dm.dc->link_count; i++) {
-		const struct dc_link *link = adev->dm.dc->links[i];
-
-		if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
-		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
-			drm_err(dev, "Failed to clear hpd source=%d on init\n",
-				link->irq_source_hpd);
-
-		if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
-		    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
-			drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
-				link->irq_source_hpd_rx);
+	if (adev->dm.dc) {
+		for (i = 0; i < adev->dm.dc->link_count; i++) {
+			const struct dc_link *link = adev->dm.dc->links[i];
+
+			if (link->irq_source_hpd != DC_IRQ_SOURCE_INVALID &&
+			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd, false))
+				drm_err(dev, "Failed to clear hpd source=%d on init\n",
+					link->irq_source_hpd);
+
+			if (link->irq_source_hpd_rx != DC_IRQ_SOURCE_INVALID &&
+			    !amdgpu_dm_irq_set(adev, link->irq_source_hpd_rx, false))
+				drm_err(dev, "Failed to clear hpdrx source=%d on init\n",
+					link->irq_source_hpd_rx);
+		}
 	}
 
 	drm_connector_list_iter_begin(dev, &iter);
-- 
2.43.0

