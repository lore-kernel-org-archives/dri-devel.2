Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29A8C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAB010E43D;
	Mon, 17 Aug 2026 18:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Lu7z3KMT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D43D610E430
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=gtm9xUw2u/GN7ZmZC4DeoeJKYlW2jBvNe8u6Se+tv5c=; b=Lu7z3KMTjGulART6X0qUh9y0XW
 O/nxih5ZXMbMjuMmguisqXZuOCFnNXYVIDYvBBh8sBarNOLQPTwxzZFSrXNsz/+1jRULqla2Giyt0
 LchXOGaVybHdj5nnbP9iGYP0vGtGnhaVkuOatNGlliygs9/q6QkGVF16jVB4LkeMxhdAFttdmKvmM
 mEN2B5/3EQ5mkB7Mc68Ui5NG9FeKsnx4kNswPVy4pp2grJGMr2/KfI5Nsy+TbRarKDMvF0JsguZmg
 x3WtVKvG5CK1QHj0jBta2bH07kikK30Jw3vF0oxuWLdzxo5A2SyJPc4NYXKbc5WdSiLZKTLHZ7EgZ
 v31ZXNIg==;
Received: from 189-69-160-4.dial-up.telesp.net.br ([189.69.160.4]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww2Kw-004rtf-GR; Mon, 17 Aug 2026 20:45:30 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 17 Aug 2026 15:45:20 -0300
Subject: [PATCH v2] drm/atomic: remove bogus check for file_priv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-drm_atomic_bogus_check-v2-1-2b9e60f32a7e@igalia.com>
X-B4-Tracking: v=1; b=H4sIAMBWg2oC/4WNQQ6CMBBFr0JmbQ00BcWV9zCEtNMBRi01LRAN4
 e4CHsDlS95/f4ZIgSnCJZkh0MSRfb+CPCSAne5bEmxXBpnKIj3JUtjgaj14x1gb346xxo7wIVR
 e2LwxBRGVsI5fgRp+7+Fb9eM4mjvhsNU2o+M4+PDZn6ds8/6eTJnIhFY2N1ZpUni+cqufrI/oH
 VTLsnwBSOqRU88AAAA=
X-Change-ID: 20260729-drm_atomic_bogus_check-456d5fb6eee9
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Melissa Wen <mwen@igalia.com>, kernel-dev@igalia.com, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.16-dev-62088
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

Since file_priv can never be NULL at prepare_signaling() as it is only
called by drm_mode_atomic_ioctl(), remove the check.

If that was not the case, skipping the rest of the block here would cause
the drm_pending_vblank_event object to leak and fail to set up the fence in
case out_fence_ptr is set.

Since the check is unreachable, there is no possible leak.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Change commit message to indicate this is not a reachable leak.
- Link to v1: https://patch.msgid.link/20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com
---
 drivers/gpu/drm/drm_atomic_uapi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index e997917819e8..657c15474ed5 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1445,9 +1445,6 @@ static int prepare_signaling(struct drm_device *dev,
 		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
 			struct drm_pending_vblank_event *e = crtc_state->event;
 
-			if (!file_priv)
-				continue;
-
 			ret = drm_event_reserve_init(dev, file_priv, &e->base,
 						     &e->event.base);
 			if (ret) {

---
base-commit: ab243f74ab4084ca5c8dec608cb5b0deb27db067
change-id: 20260729-drm_atomic_bogus_check-456d5fb6eee9

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

