Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB77BC982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F417010E25B;
	Wed, 16 Sep 2026 08:56:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ad+kaMZ+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C597210E25B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:55:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AFA6C40981;
 Wed, 16 Sep 2026 08:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E84F1F00893;
 Wed, 16 Sep 2026 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548959;
 bh=Hi9Gq8AtwQMqq1vZlo602zpt9PYzF2R0ByaK08oRu+M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ad+kaMZ+Rb3fzU5l8yTKK32R60XdOAWNQrCZqOrqx/sjJ3TIsBsQH6E74nk2a+38/
 /RFB4ajKl0zTWwWM6iTHJnuNFsI5VgVfjOGNDkFvByAjngryxuw0kAfrFzZitx/k+N
 mCoInGzEsE7rycxwIPKyZwsxf1InUvF+qeRF4xq2H3w7hD/fp2xaNUi/w5fUtp1Reu
 s7n32CcJXbc6OiWg6aYnVb9i72g6PnHTKVcpnLNxHcbnvDi96s4uGwZ/i3PV8zTLiN
 PgRs9j7vW1Mo7C65vOBMGoph+YpXkofttUxLBFdjuVXU05AUJcMGJxVZDQmROLJQT7
 1olBujo2QL7NQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:44 +0200
Subject: [PATCH v5 1/9] drm/arcgpu: Switch to
 drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-1-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=mripard@kernel.org;
 h=from:subject:message-id; bh=D3v8Qnf8aU0iZMJJFrjvw/EXiYT1dqJCH7W3rGsKC5s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqcYzHRi3GirHr7v2v+QNzoiS9OvdjHefqh0/Lfg4
 TkvPzOLdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJvH/O2PBm5vbTaSn/1rHI
 q3ZyLb0tYlXQoBW6J+qX73nXN3oRi4utTi9ukd4xt9LEjHX3guMPfjA2vDy+rO+9yyq2XXVuNUd
 Ytkza6DmJP63o85b7vU5K13+clTJi9s0ofbu++cd9qfDJvfOXAwA=
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

The arcgpu plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index aaf814c622b6..cdbf28db8fa1 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -277,11 +277,11 @@ static const struct drm_plane_helper_funcs arcpgu_plane_helper_funcs = {
 
 static const struct drm_plane_funcs arcpgu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
 static int arcpgu_crtc_helper_atomic_check(struct drm_crtc *crtc,

-- 
2.55.0

