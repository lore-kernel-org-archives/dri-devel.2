Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD746C88E7F
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBF410EFAD;
	Tue, 15 Sep 2026 14:25:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oXGHmp+A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FE510EFAD
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 14:25:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9327602C5;
 Tue, 15 Sep 2026 14:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A51D1F00893;
 Tue, 15 Sep 2026 14:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789482312;
 bh=M/pkIQDlWP4gRwaivkZK9LUW5QNDUPVGVc75vvJ5Yqw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oXGHmp+ACoctP9zzKUFFJsxKzL4vn4d4hIJ9Q44gJHiVEXQUfVadatZ5fGHwIsJtl
 hdgqusimy1XB8GQXij2NvUe4ac7fxq3ZI3LJVXn4RYyVbQ5SNBVFQwoD/qpkvF8QRM
 R5RASYvnSqcYAe2xN913iv7S8L68ZwwP7ra7a0qHAH/zNI2ubC3RW4V18D8T5/KxUs
 bBkpftuSh7bPlmI+iaQz5Zc+2IFw87hX1Chd0xerPBXQOYvbU37oeWBQOCpIiZxIt6
 HhHiNz/f0AbfYi+log911kMPpfrUvZvqCdg0VnFqbCooWinYDHcy8YhouDS8KXs4Zc
 2oOKRHIchJwgw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 15 Sep 2026 16:24:46 +0200
Subject: [PATCH v5 05/11] drm/pl111: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-drm-no-more-crtc-reset-v5-5-bda007735748@kernel.org>
References: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
In-Reply-To: <20260915-drm-no-more-crtc-reset-v5-0-bda007735748@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hhjhn0x9rDGC97PncQYlDng5RlZdJSac+QzeH2IoaaY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkrQ/WZLLb8C/rZ/2lvjnjr5Z47///efH84I3RZxMnoI
 3or/36Y3jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmYlLDWCtawiKxOzHmrot2
 kvXJRRd/tjEdL3h14OkCk3g5Fv2nFUKXVqttTg/9ucXxi2yMUGdNOWPD2bgZn7LXfnTikzV35oj
 9pnvdpCrL+3aDQSzj6od8f537HrAVVmsu9PJ/EDLteOHatwEA
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

The pl111 crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 8e5d662c23c8..163358b54517 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -468,11 +468,11 @@ static int pl111_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atom
 
 	return drm_atomic_add_affected_planes(commit, crtc);
 }
 
 static struct drm_crtc_funcs pl111_crtc_funcs = {
-	.reset			= drm_atomic_helper_crtc_reset,
+	.atomic_create_state			= drm_atomic_helper_crtc_create_state,
 	.destroy		= drm_crtc_cleanup,
 	.set_config		= drm_atomic_helper_set_config,
 	.page_flip		= drm_atomic_helper_page_flip,
 	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

