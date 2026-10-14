Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A313BC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD9D10FEF4;
	Wed, 14 Oct 2026 17:30:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEEB410FF07
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 327A060238;
 Wed, 14 Oct 2026 17:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8631F000C4;
 Wed, 14 Oct 2026 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999017;
 bh=PooN6P7ztemwYEWi1zRPguzcVfVU9XHWk3Gp1kNBBXU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=B+0ji8Wp5BiBjyg3qCmaskAJHF7aj8mHINbwAa2ZDpdaSuFebuO81VojZ7SfvLCOo
 ab3uYn4nTQSBTfatMJeucDttMq2sZzqrMhCA5JMvIdM04eZEz1JId3tU4wSLh28vMu
 /HRw3Ea5X1IQA/abrzIuPD2iA3GEq/CW8odinEprQWDVPe2P3F/tQY/mI4XBAd2sWS
 61VXd9jgWmHskffjNvkUZxkTZ6b2PE+AcRrq43DTIDl80+g/AuZgqigPoJKCyCSchN
 xNJ2eDZyXOpj7HMUOK12pdjD5bqQwnSDGWb7xr1hbpCIUP5nFb5ukId9b7WcP9b8rF
 yuMSDrrOiC8GA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:14 +0200
Subject: [PATCH 51/75] drm/vc4: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-51-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223; i=mripard@kernel.org;
 h=from:subject:message-id; bh=b9YAWWdU6K2oRGXtkgHWz8EUS2rOYasKrZLQfQ+CAlA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndyekaD02n3H4LlvYBaM3lmn8pZ/1PppHn/33RIJHS
 LAi7EZWx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIEyPGhm98i9hXL8u9yjxr
 2s+zfItD4jZdlLIzu5/0Wr9/P1NV3rybJ2zq13zp+GDv4KzyRvzcfMZa4ebkPOfXtuIrd/3fFZs
 vHNWl+CN6/6y9ekq196am9Ex/fXeCg8+01729s3M+G/643KYAAA==
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

The vc4 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
index b53c3635ce67..54f952e4b1ac 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock_output.c
@@ -15,11 +15,11 @@ static const struct drm_connector_helper_funcs vc4_dummy_connector_helper_funcs
 };
 
 static const struct drm_connector_funcs vc4_dummy_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
-	.reset			= drm_atomic_helper_connector_reset,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 };
 
 struct vc4_dummy_output *vc4_dummy_output(struct kunit *test,
 					  struct drm_device *drm,
 					  struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index c469f8b1068b..642953cba25f 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -376,11 +376,11 @@ vc4_txp_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs vc4_txp_connector_funcs = {
 	.detect = vc4_txp_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static void vc4_txp_encoder_disable(struct drm_encoder *encoder)

-- 
2.55.0

