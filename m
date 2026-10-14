Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC700C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4149710FEB0;
	Wed, 14 Oct 2026 17:29:11 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D1010FEB0;
 Wed, 14 Oct 2026 17:29:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A3E860229;
 Wed, 14 Oct 2026 17:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8801F000C7;
 Wed, 14 Oct 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998944;
 bh=Q3zMshmFGLjHYUyh0j+F4xwA1uMU6pU+18/2kyrzuXA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=crigrfwThb7rPlMlYA0dm6grWRXl4paK3a+/DuywknHCp+uEl0RsA5A002BQmCoyr
 OXbLJzOz7Osz7M89oXr6VZIzPbTv4MdXWGrO4zU8BJDWDubr5Hw0OVbRTMwEr67seZ
 YqM9U4/oD89roQnyCSLLBuAhPy/F29wrj5Az70y4TPiVj65vWKhOSKHpz4xVM4H12I
 jmW6hSz2Ef97+Ghm4XWmHj6pDIE8w+3xNqDF2AMzpZU3RGsTynkyvndALmb7/9bjz3
 tBAKpZam22t5hj03fYzUFLl0OX+oypZOV2f1qnjtDPGyiZvyV+NtqSUbyu3uAZZvIb
 OLjQQtXZo55Iw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:54 +0200
Subject: [PATCH 31/75] drm/qxl: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-31-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pQyNtLFsY90O8SQ7JhPYrL5wwHyW8gswquII9q9OtYk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0cc4PtpcM8z1nN3a5bowZkBEtXt1mfqP53c/mKGv
 WVx/mrmjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRLeqMDX9/Fh3cmuJ/2d3G
 b/NmzkPntD+les/3OXxwe/Ldz6se8iQmyJ05WMH7rW/V/U81kucX1zA2LG+Y5secOnGdHusS2zl
 cpyL1ldxXHTFY4R361oOrpeltw5U9ky7Zyi51Pyt2qbvs6Y4dAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The qxl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 63fc7c6a7f1a..204c47d61373 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1139,11 +1139,11 @@ static void qxl_conn_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs qxl_connector_funcs = {
 	.detect = qxl_conn_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = qxl_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int qxl_mode_create_hotplug_mode_update_property(struct qxl_device *qdev)

-- 
2.55.0

