Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECE7CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C1910FE8A;
	Wed, 14 Oct 2026 17:27:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FD510FEC4
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:27:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6EAE142AE6;
 Wed, 14 Oct 2026 17:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C406E1F000C4;
 Wed, 14 Oct 2026 17:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998872;
 bh=iErB+7poN/9QizfKp4fIibySNTItelnX+9zPhtlM1gc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=AUQdiJlIUWH1TD3WqLXs54P19O6MuiISiIibQn8AZcShLf0JCu2LtuMe6afoEYzHE
 LEDMQxArZIwUbfJ9YByjtSBcno2BRHC42fRcWCL6RYw/QQ0G8/vIbGQewxSECEqeSs
 H6JBei6dR0NbWqXP6gEY8T14yancT4aJNtnSBkw2ezfL7QI5Vc1/Pk7TFqc/dxXfA8
 uXh9lNrJ2XOIujtsfaZ6gXURcAYSg2jLa2Td38u3C4Rd/M5ySMIPjd0v+K8JL5ZQaO
 7UMJWq1lh4JH4Zd1JbCuUREJt3xxXJV/LPC4oJzgeCGW6SPx+q6S+XxhWeEjNpyHjd
 NQiWt3sEw91pg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:34 +0200
Subject: [PATCH 11/75] drm/bridge: lontium-lt8912b: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-11-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Francesco Dolcini <francesco@dolcini.it>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=mripard@kernel.org;
 h=from:subject:message-id; bh=28P5WoWXYfCUslxKk53bFFrM3RbefJXyeUELUXkki9E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd/v3s/xO+S35eVHHD+41EYt3fwr7uc9k2SP5+7wn2
 SbFcXZZdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJsB9kbJiaXOr8VHS2y4d8
 /fALc+eeuXQ7vELnQ/0c59ZbLT+elzFv71lY6DN7c+BkTZlLL+xnTmSsj5j971QZ92zTc4GHn29
 8Vb+ooOdjXdPqIKGSms3LL9sqGJd9rHLatH3O/67geam7go6pAwA=
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

The bridge: lontium-lt8912b connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Francesco Dolcini <francesco@dolcini.it>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index e347d04b7b2d..a4d05dcba9e0 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -414,11 +414,11 @@ lt8912_connector_detect(struct drm_connector *connector, bool force)
 
 static const struct drm_connector_funcs lt8912_connector_funcs = {
 	.detect = lt8912_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int lt8912_connector_get_modes(struct drm_connector *connector)

-- 
2.55.0

