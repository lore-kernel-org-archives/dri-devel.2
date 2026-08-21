Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F30C5DF96
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2770310F2E1;
	Fri, 21 Aug 2026 14:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YhiaWSlt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CB4F10F2D1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:40:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E472F61879;
 Fri, 21 Aug 2026 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FE01F00A3A;
 Fri, 21 Aug 2026 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323251;
 bh=fw+N1+rxPxHvKFfuGjIbAqU78dD8++uydqQ0YHOwVSA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YhiaWSltH4Noc/TUnhT8jztUefZydT3nI4EmHkiH2t3ZAaW+IM7agHoh8A6dJ1RfZ
 eIn6q4Gcg/dZIry5HidMFGTcL1gXOqxty8U5AEP/lg/keWhke/FyiZCcuXRCmHK4Ow
 1C3MsznPZ3dw1fsZXKN7eqLYpSTssQeEcxalIVw62LFSr0lHdNqH40OJqLKVVv0BsV
 Jthxhqgk389xwZMhpUVzn/3e8W5uW9AQpl7svVL2ZEz+1Wdqw2cOX1sfrqgkgbNRPW
 fQV+VCZpeCVGBuYJNfU7h6qDFDZqPm2r/V2dSf+2BbVwnVsUS4vC3YHq3eUhluTmAU
 FtwZcJJReTNBQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:13 +0200
Subject: [PATCH 37/70] drm/vbox: Switch to drm_atomic_helper_crtc_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-37-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=mripard@kernel.org;
 h=from:subject:message-id; bh=eqKBydhwBTWSNEjZ289G4meh/Z7oE1qMZZ1OMH+dYDQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyRxZ2WfkZrDbrayoYTBSZsrmrhfNWZhxeEnBjeQ/5
 aoK7xo6prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwES0LjA29E+vP2Ir/nRSbN9u
 S6+HUxa+OMUdZj/DnOvsK0fZ9Swr0nKXsoQlRslu7r7rb+urZjCXsc7ALSm893f5lq4p3+JOWe3
 +WBPY+N2NvaNjySHHz4tCtBvNIjiyKkw+Nl1llU3o4vzQBQA=
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

The vbox crtc implementation uses the deprecated
drm_atomic_helper_crtc_reset() as its reset hook.

Switch to drm_atomic_helper_crtc_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 8e4e5fc9d3c5..d2d75367b077 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -248,11 +248,11 @@ static void vbox_crtc_destroy(struct drm_crtc *crtc)
 static const struct drm_crtc_funcs vbox_crtc_funcs = {
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	/* .gamma_set = vbox_crtc_gamma_set, */
 	.destroy = vbox_crtc_destroy,
-	.reset = drm_atomic_helper_crtc_reset,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
 };
 
 static int vbox_primary_atomic_check(struct drm_plane *plane,

-- 
2.55.0

