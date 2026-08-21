Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4182EC5DF89
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEE0410E2E2;
	Fri, 21 Aug 2026 14:41:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mRhYLdQL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5AB10F13E
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 612C943931;
 Fri, 21 Aug 2026 14:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AA91F00A3A;
 Fri, 21 Aug 2026 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323237;
 bh=d5JaTRZiaqGtEalztRFV6iIrV7NPi17fwFWkVnysNBc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mRhYLdQLWN6tY2FXouzUYo7Qe+siBQPU47DQ4f2E3udgZVU1w5hmOB1cMEFP/jvga
 pIw82bii3FsRnFoa/WHmA9j7FtcSaqTH1RSMn6ihfHamQF59eqerK9kbOx+WBwNuYn
 PC+m0lhR1hAc+1abM33M9ToAtMOCkGbpZaK3Noy/5ExfAbH9cNmJzj5CRmRXQrnNNm
 wZXfHynXT7OHvWNMlv/WWgAnSh7mQjzDK6RnuggKQt0eMu0ukz5YNIl0ZH63Lke7R5
 tE5CkZso8WCKY6XExKKLXaK53cDiTOt8W0DTGspk4cnfOlUgjOJYaSlCZvwi7+/pA3
 IdoNK2Iex0LHA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:07 +0200
Subject: [PATCH 31/70] drm/tiny: appletbdrm: Switch to
 drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-31-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Aditya Garg <gargaditya08@proton.me>, Aun-Ali Zaidi <admin@kodeit.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mripard@kernel.org;
 h=from:subject:message-id; bh=Y7bmma8T5+328+en6Bwu6EjxGTvp8CcouJkzRh26+k4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyWwOsRxcjTfEbKPWmf7U3R69YjvHFe2Ys0esgyfZq
 Zrn+Sl3TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgImsuMJYX5B0g2mXxZ//DRoa
 dvZnF279pCDy0l69akPx2SdCV62K5kb/2rf1q5kx6zM/ibqJHSx7GBue7ZjgsPR7i5pKdIpxRMv
 djucp3ze3Jjt6PdtTWx2d89hLdGn38unbr/oevnxuga2cyhEA
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

The appletbdrm crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Aditya Garg <gargaditya08@proton.me>
Cc: Aun-Ali Zaidi <admin@kodeit.net>
---
 drivers/gpu/drm/tiny/appletbdrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index cdd35af49892..94bad6dc720e 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -596,11 +596,11 @@ static const struct drm_connector_helper_funcs appletbdrm_connector_helper_funcs
 static const struct drm_crtc_helper_funcs appletbdrm_crtc_helper_funcs = {
 	.mode_valid = appletbdrm_crtc_helper_mode_valid,
 };
 
 static const struct drm_crtc_funcs appletbdrm_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,

-- 
2.55.0

