Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338B3C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E7E10E899;
	Wed, 16 Sep 2026 08:56:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gApiYYno";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857FD10E899
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01755602CC;
 Wed, 16 Sep 2026 08:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EF21F000FF;
 Wed, 16 Sep 2026 08:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548974;
 bh=7ewVBRAhg20kC7/T7NeUBAQOwOw4jPpmrm5KCYBTkwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gApiYYno3Ahx3wYPMmHVy2JSx0gg75znqoZcp5UD0EMFT/QRI3R0oeR6Z3eWTicfp
 5gSryHqeTePJXFfpRVX2qyBxnAH3dWCT/aVeDIQz4DXqjU5lfRAL6zHhtwlPp3Knr1
 Nrc/WGCwPZrzI8Fu9f2JrtbYI0SCDBFe8jZ+2a6t1n32M/TbgzH4hAdfBJ/u1f89S/
 XbVweUOke1cXHfzEHqD2XiDBASU02UumDN55S0pnIsi2fecRiGO6eDmTp/Nq+by5Ny
 a+VVJXVHdsXvniCMN0tiOUl8sExAGSdMfjsnNsgDdjxhhBMgNDLSMgLbHheycInGFS
 GDTYpmovEnaGQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:48 +0200
Subject: [PATCH v5 5/9] drm/tve200: Switch to
 drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-5-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1192; i=mripard@kernel.org;
 h=from:subject:message-id; bh=iSjekm1M2b44gSVtYv32BSyf0Sv1BaeDsGWKrFDZQzQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqeud5im+/CwxZR9DmsXT9w0500vf3pCuMSKq+qX/
 sdunOBl2jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmstCbsWHLZgMRaS0Hs6sO
 U36m5SVyi8vrzo2SeFPIrmshXTl1xao71/8llU8PZfGotD03xc5ZjLHhxf+52yJf7LyXMde58UD
 oHhGthsmRV49q8lTsFXX+Illx+EN//5JI1/3vcmRCZryZYK0KAA==
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

The tve200 plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tve200/tve200_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tve200/tve200_display.c b/drivers/gpu/drm/tve200/tve200_display.c
index 90771464ac12..cc304af3e9e5 100644
--- a/drivers/gpu/drm/tve200/tve200_display.c
+++ b/drivers/gpu/drm/tve200/tve200_display.c
@@ -192,11 +192,11 @@ static const struct drm_plane_helper_funcs tve200_plane_helper_funcs = {
 
 static const struct drm_plane_funcs tve200_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
 static void tve200_crtc_helper_atomic_enable(struct drm_crtc *crtc,

-- 
2.55.0

