Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ECDCD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 12:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF2B10E5C8;
	Sat,  2 May 2026 12:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="KH3+Iwab";
	dkim-atps=neutral
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDA310E5C8
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 12:13:46 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777724024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Fv9ANxoEXrJtQ42FBdd7xju+ouJmyQSyIcqfR7al/c=;
 b=KH3+IwabzQKYT0Bo9H+H3OSvvlqon/GATLmavjjC1jtoD69F+b11yP7Y0V7kYt8/aPvhGJ
 J42OKHRhEOQDrziuEcc8t1L7yDbcrodfjIHV3CAE3otKQvtpmm+85dUxpZGdLX17LvsElj
 FnBS+HcwxOp7UU7sccDL6lFz/6ve7o4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Eric Anholt <eric@anholt.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, stable@vger.kernel.org,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vc4: fix NULL dereference in vc4_hvs_unbind
Date: Sat,  2 May 2026 14:12:53 +0200
Message-ID: <20260502121251.39206-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=thorsten.blum@linux.dev;
 h=from:subject; bh=XGytLSpCy9xgPusgWlXyFNDJcqnNgBnFVfmi4WwGiUQ=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJlfXzlH2FxsyOraNNE86c+LeJdUwfPfqwr4VKayegXul
 X6/yIKjo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYy5wYjQ9+Tjq2bGKvErzEU
 BDg//Jdz4OyKxA+L/17h5/D5XrhLoYbhf0CF8Frm1Xd4/MUenb+3Z53CqlfbHp5vmFmhGqO9Npu
 fhQMA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

With 'dtoverlay=vc4-kms-v3d,noaudio' and 'hdmi=off' on Raspberry Pi,
unloading the vc4 module calls vc4_hvs_unbind() with
dev_get_drvdata(master) returning NULL.

Return early when 'drm' is NULL before converting it to 'vc4' and before
dereferencing 'vc4->hvs', preventing a kernel oops.

Fixes: c8b75bca92cb ("drm/vc4: Add KMS support for Raspberry Pi.")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/gpu/drm/vc4/vc4_hvs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index ee8d0738501b..9cb66f696fc7 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1753,10 +1753,16 @@ static void vc4_hvs_unbind(struct device *dev, struct device *master,
 			   void *data)
 {
 	struct drm_device *drm = dev_get_drvdata(master);
-	struct vc4_dev *vc4 = to_vc4_dev(drm);
-	struct vc4_hvs *hvs = vc4->hvs;
+	struct vc4_dev *vc4;
+	struct vc4_hvs *hvs;
 	struct drm_mm_node *node, *next;
 
+	if (!drm)
+		return;
+
+	vc4 = to_vc4_dev(drm);
+	hvs = vc4->hvs;
+
 	if (drm_mm_node_allocated(&vc4->hvs->mitchell_netravali_filter))
 		drm_mm_remove_node(&vc4->hvs->mitchell_netravali_filter);
 
