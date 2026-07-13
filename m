Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3E1C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F5C10E84A;
	Mon, 13 Jul 2026 23:52:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hUKlz+1N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923B910E39D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 23:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q4zTrWvspNQOgrPNXPQgwUnNIIyzAJpXvOzRD+1kkDU=; b=hUKlz+1NmtrWamYNsg0GEbavcL
 BQynWoe02rtU60Yu0q7Ar9Q7qB7IwroP2H2r+F2CGC3VvpGQpYqynh0NeXoN7dK/sIdR55LsUcAvv
 +58M7demEIl1IkmkWmKa0/QP4rSJDop7S69plPoSBuZorre336Mk4x9e5rC5ANksD13FT+hLjg7Jo
 d5ARjwIrYD8wo9cD9EoMDnfodxtKgnQSMpdU8dkI/dNq36NuJpyiGXTNbi0S3LjxMS0mnrNN39UZS
 gwQBd30ktodFiAs0iOy83ZrTEu0T7R/PFUybMVR21ymG1hs2yBoawO1um4uSvp4UTvdQvR1eSzlWw
 Hp8DL8KA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjQS5-00EjJa-7v; Tue, 14 Jul 2026 01:52:45 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Alex Hung <alex.hung@amd.com>
Subject: [PATCH v7 2/9] drm/amd/display: use drmm allocation for writeback
 connector
Date: Mon, 13 Jul 2026 16:51:44 -0700
Message-ID: <20260713235153.3862650-3-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713235153.3862650-1-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
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

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Currently memory used for writeback connectors isn't freed on driver
unbinding, leaking the memory. Use drm_device-memory allocation
function for the writeback connector, making sure that the memory is
freed on the driver unbinding.

v2: Fixed missing parameter

Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: John Harrison <John.Harrison@Igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 67b825cbb88f..1fd48e28f5fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -96,6 +96,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
@@ -2597,7 +2598,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		link = dc_get_link_at_index(dm->dc, i);
 
 		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
-			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
+			struct amdgpu_dm_wb_connector *wbcon = drmm_kzalloc_obj(adev_to_drm(adev), *wbcon);
 
 			if (!wbcon) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
@@ -2606,7 +2607,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
 				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
-				kfree(wbcon);
+				drmm_kfree(adev_to_drm(adev), wbcon);
 				continue;
 			}
 
-- 
2.43.0

