Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548E9C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509A110F130;
	Fri, 21 Aug 2026 14:40:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Og/Km4nY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD3DF10EFD2;
 Fri, 21 Aug 2026 14:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A50F941093;
 Fri, 21 Aug 2026 14:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1059A1F00A3D;
 Fri, 21 Aug 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323208;
 bh=yz488DmJnWVCw38MVen1WG9InBfyBikaSqjImiSrV6M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Og/Km4nYIcfbL3w2u92aLsSzKoJTyLqgVIqEnKyIeg5PoNp6JNalR5fabgx/xV96f
 rwtQziSueLHNB8WAy65330U/rZ1ZBUlPq6zoA/8H/dZV45e20auvdpyvyDKwdDXGzV
 wCR65MIBbla9M2pF/I0vOT3ygrrkR7yoNbc0LfLL0mQKcwyYWvVILenh9V6T3V0qPx
 wXzohugV63aD/HcQK1Z7gT/V+uzb3vyVPfrngwL68Ak1MaoFkqPEuhcQjaWb6FHQFk
 +eeJ/Sj0SUdiSG6wd8m6WmRUc0+7uZ+GIr+qjiOmQnn71BEQ7TluZ0uB3ByhAbd8hA
 2TnEHqIZUYi5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:55 +0200
Subject: [PATCH 19/70] drm/qxl: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-19-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1227; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uTrkjrzzF/DuDpEbmVjIeu1g1/HcC+KMsTAk14ivBrc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyQzBK/52eSS7htXOn97GtPdphsTajoaVtt9NUtZmL
 TbUzm/umMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOZEsDY0OVYur8r6fvCotgY
 NkmWSnlf3/CTk08fLkh/uVZq15LK1HVGokHZXbd/vvOZdush179FjA2fFm55eql7Tcn7jIlCG3b
 v7GYye/JqiXxzrdX0P8m++ULqEy2zcvhSjm9dlPnvaHSUvCoA
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

The qxl crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

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
index 7f4178800afd..7654575bcf00 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -416,11 +416,11 @@ static void qxl_crtc_destroy(struct drm_crtc *crtc)
 
 static const struct drm_crtc_funcs qxl_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.destroy = qxl_crtc_destroy,
 	.page_flip = drm_atomic_helper_page_flip,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 

-- 
2.55.0

