Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FEEC53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 696EC10E0C1;
	Mon, 27 Jul 2026 20:46:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WIosT/Ov";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57E1B10E0C1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=yl0NUMr0TDqZO/IOU8fA9DWQn4BnbIyksUsi7vU4w4g=; b=WIosT/Ov5wZZCiXhk55/xVWVOA
 eIViSQ8E6CYKWKAtervfugn9S6xah6P4KmyuY3EqecmT+JguEKIyQ59cDgucnC67dQLQOq5aPfjCo
 /Iw6NBWO2gwJWs5bOlHIJ+5IVeGu3ptYrsZszNkRRLzgPJJfpcnBMVdCLUaafTRGN1XWXJsIWHJa/
 LSn8tpw9yNo/79/JrTSlBsMHtRxDKY+nv0rEPYUrLj7o4NnNCP+rCSU+n7DsPDgsU2J9w2B3IUgwG
 aJtRdQ9Oh735pWK2aItdew3e4yJNafzMRhWrwcmhD+3utWBqhWtCJViQ8JtYMDY2DF060wQl8qC0M
 X3Wgyoxw==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1woSDD-006gjL-44; Mon, 27 Jul 2026 22:46:11 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 27 Jul 2026 17:45:49 -0300
Subject: [PATCH] drm: Fix drm_crtc_commit leak if signaled when
 PAGE_FLIP_EVENT is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com>
X-B4-Tracking: v=1; b=H4sIAHzDZ2oC/yXMQQrCMBAAwK+UPTfQxrYBvyIlJJtVV00jmyiF0
 r8b9TiX2SCTMGU4NhsIvTlzWir6tgG8uuVCikM16E5PndFGBYkWpaB1JUVGiylGLvZB7q6GQCO
 ZsZ+0P0AdnkJnXn/7af47v/yNsHxL2PcPyXMzOH8AAAA=
X-Change-ID: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, stable@vger.kernel.org, 
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

Commit 1c6ceeee6ebb ("drm/atomic: Fix memleak on ERESTARTSYS during
non-blocking commits") fixed a very similar issue when the event was
allocated by drm_atomic_helper_setup_commit() itself.

However, if the event is allocated in prepare_signaling(), it will also be
set to NULL in complete_signaling(), which prevents drm_crtc_commit from
being put in __drm_atomic_helper_crtc_destroy_state().

Dropping the reference when the event is set to NULL at
complete_signaling() fixes the leak.

The leak can be reproduced by sending a signal to the thread using
DRM_MODE_PAGE_FLIP_EVENT and using a sw_sync fence to cause the atomic
ioctl to block at drm_atomic_helper_wait_for_fences(). It happened both
with amdgpu and vkms.

Fixes: 24835e442f28 ("drm: reference count event->completion")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index e997917819e8..7b951af5ab32 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1563,6 +1563,8 @@ static void complete_signaling(struct drm_device *dev,
 		 * to prevent a double free in drm_atomic_commit_clear.
 		 */
 		if (event && (event->base.fence || event->base.file_priv)) {
+			if (crtc_state->commit && crtc_state->commit->abort_completion)
+				drm_crtc_commit_put(crtc_state->commit);
 			drm_event_cancel_free(dev, &event->base);
 			crtc_state->event = NULL;
 		}

---
base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
change-id: 20260727-drm_crtc_atomic_commit_leak-4de5e75162b3

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

