Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05581C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439D210E480;
	Wed, 16 Sep 2026 08:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G8wGR225";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA1A10E899
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E79DA602CB;
 Wed, 16 Sep 2026 08:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111581F00893;
 Wed, 16 Sep 2026 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548978;
 bh=OMSM5ETAig3ne/WCqT/aUItapBPKYtGu63Zaw01qDRs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=G8wGR225VROUFk3ZD6SEqrdcuf5V68/lJl6gW5rC+xG+MlDh6M5zxrAf17nL9Ijsf
 12T51+S8G9LvHM+SUgOP3EbrLAjrKptoHsqTbmRpEhEgzZaTkIJCcaFyGsmYQc8HJB
 GVvCS7BPx8It8SE5/h4+k7butKTCSi+91bNlWlwLV2l1SToXeXaMp/Xhoj52jnPqd6
 B/H4aIWccHunpmfMQEtMXPSkPZkV5p9hPVmUe6eHi4j/e71XAAHldu8tLunGhmtAlS
 d7wXHN7zAUVArxdE4bNlvggEVPJuu5qPt2Y3ILcNTVh71BQLWY203l8fGXxid3gwpv
 QObQpcitgFYPA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:49 +0200
Subject: [PATCH v5 6/9] drm/xen: Switch to drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-6-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eCeLBI+UfxS8Zu/tIhZhRYxoocYv4q4I478KldpRPYw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqfV3yysesjv83EJ44UjbU1GTfOYgi+svHTVXMpZn
 iXqY8T9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRt5MZG7rPPFaZLbvWaqvy
 xqnqdrf9PPe07lzqndG7aa/qqlO33XhDdx2/syXSbUbuIpEXP6uaWBkbzkrb7LVn6t/U3M/1TX0
 Fx91O7V3nnG/VvBTdqNLyYn7oMl2peVc3Bgryef1KOfg5JosRAA==
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

The xen plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 1f65fc407d77..d193f60fad22 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -343,11 +343,11 @@ static const struct drm_plane_helper_funcs display_plane_helper_funcs = {
 
 static const struct drm_plane_funcs display_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
 static const struct drm_crtc_helper_funcs display_crtc_helper_funcs = {

-- 
2.55.0

