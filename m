Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48085C5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 549C310F302;
	Fri, 21 Aug 2026 14:42:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MCx1wzr4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4772F10EEA5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:39:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EDDC41847;
 Fri, 21 Aug 2026 14:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3281F000E9;
 Fri, 21 Aug 2026 14:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323194;
 bh=x1mgI2fZT54f9HrvSa16vHpwerZizUlIS6tfngSfVXw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=MCx1wzr4VFgci9nqr5vT0RN0+4KbYZRQ0tk1c5lXrv2CTMyNZgks3D30bwqc7ZcbK
 xAsvMNVd1qOmCQ485UA0NmR4qDzlXp7qcr1D56s8jJKhX9xvXy+r51veOOCyXT8xY4
 VGoLhcFgRDc761FFP78HFktqSEbNINaZ9yV9RbvLXnUFhBqO8qNBp/lpZHXTzdZi3e
 pcSZ/N9AoQFs/ltMOqKsjoEAf9I4k7YnNWA1s4yACxyvlmRItxRAUzN7E/w/WCCbMF
 M/HqXE0OYGOMkVGtcypi2bhjQf0KlBJKsQxSZGrkMp4KR9nO2FWqufrX48InZRGd82
 35aP+oj6Ail6w==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:49 +0200
Subject: [PATCH 13/70] drm/ingenic: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-13-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=mripard@kernel.org;
 h=from:subject:message-id; bh=9s0b2WoVTn/Tu5Xko3JwjBbS4nM3EquEKacg7YZMpNE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdSX+lt26U7z64aWk4743vK9/HZjFsMeHO/RmnXpn67
 0nFy/CAjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRf5mMDS0mV/8dvVz4udG+
 I0180o0dJ6JkrP7wa77bIMX7iGdSTKHrzenanA+LQ8w+bZ2ewCOjwtjw5N7jfUujemeF878xFA7
 fcURK9IZbpFnW3JIjSZVvDU62LFz2v0O+4PbpZbJmta8n9gUDAA==
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

The ingenic crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: linux-mips@vger.kernel.org
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 738a80b2550f..67374c611583 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -995,11 +995,11 @@ static const struct drm_plane_funcs ingenic_drm_primary_plane_funcs = {
 };
 
 static const struct drm_crtc_funcs ingenic_drm_crtc_funcs = {
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
 

-- 
2.55.0

