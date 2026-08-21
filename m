Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D35AC5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D4610F29F;
	Fri, 21 Aug 2026 14:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NkWEuPGz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 591F610F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3898A4376C;
 Fri, 21 Aug 2026 14:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9759F1F00A3A;
 Fri, 21 Aug 2026 14:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323218;
 bh=pjAN7eodGlGLHtVx+XM8vJ/Xz8WbREep66H3ITM4vbs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NkWEuPGzQEg81pBaJJnutHFemQBq1IboJp/758ybUUJiJMkjsvdmtr/TkVCUhK74m
 FHJFbo16Y9urhTwf/VRS9gaqfxnOeDYTpWvOiRINFkM/JUOsrR5N2Z+WtzET8xgII0
 3jgG3S5wVhnje1WMyVeDedhJz/hZ7sjbXpa+okG1zF1ifoMk7qJ0zmQUWme6xJB1J6
 loXOf6RsozOsfrBlZVsA0R1Qc7hefoCmj+yxxcBaJZk0/ca9p4fnedSvnBXkFuRizt
 ZaVLDGiQsIZMP5IcfG+3YvFGtKjxAX/68a+RF5sYEBVBj/3wl4j0gWs2f0+8L11Cdn
 aIIadwL49bibg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:38:59 +0200
Subject: [PATCH 23/70] drm/sitronix: st7571: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-23-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kioH4+Fn6UAjK9+2JyURxyXiLC5U+FGyJdMKN2bLSwU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyUxb6y5VG9/91Jxo2KUd/5CnYVemk7WJXc/jcJM3p
 nzb/O50TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgInc38RYZ1CQ+rbQMPy24wGz
 4yb3515sYv5iPLejZs6VPTpzYrJTjquqMW69kJVUZDaj7sCzWMNSxvrwAN31V4Xbvz/6vJeN2+G
 cgE3YxXP8Rn9Ci02X1E3+6zJhf92pwNr6jZOfW7hOFT4dogcA
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

The st7571 crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 20954c33eca9..fc3ba5e8600f 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -422,11 +422,11 @@ static const struct drm_crtc_helper_funcs st7571_crtc_helper_funcs = {
 	.atomic_check = drm_crtc_helper_atomic_check,
 	.mode_valid = st7571_crtc_mode_valid,
 };
 
 static const struct drm_crtc_funcs st7571_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

