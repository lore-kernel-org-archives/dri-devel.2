Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A298EC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 11:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F217C10E5FB;
	Wed, 26 Aug 2026 11:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nkeYywBj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86A48952F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=mDBT0y4CQaDDC0iV3ivBJAKjXjAA2GuZiocMc8fGFFs=; b=nkeYywBjnLAG9XQvSrzvj/vM81
 AC0D3khBYW52boaKC6MbgWS6UGYVPRWDTNvmBsj+ZCaLnbGFKNIegs9H/+S0439XkznEFDT5m4Mm/
 nbcqsdxKur6T737/V6SggLaZJx56VrpLnGR9+/0w6ipP9NX8U/+ofWd/Kb31WGq19tB1+3CG+PIOr
 KrNP09qeri4Ue2XbdoFCpIURx0oB24kS5zRqP9ZOvWZ+7Iu+3a0aFqIyGHSHMpxa7pWnIL8polS4s
 6rRbGxrDRYNBIJpyphEv0RJB1nnOROiiFhghAjNtogp9UM4GDAfkKMGUynR99/z7FPjRZa4HlKuZx
 9jt67Fxw==;
Received: from 179-125-75-211-dinamico.pombonet.net.br ([179.125.75.211]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wzC5y-009WKN-VD; Wed, 26 Aug 2026 13:47:07 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 26 Aug 2026 08:46:58 -0300
Subject: [PATCH v4] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-drm_pending_vblank_event_leak-v4-1-f8de8b996b9d@igalia.com>
X-B4-Tracking: v=1; b=H4sIADHSjmoC/43OwU7DMBAE0F+pfMbI3rhx0hP/gapoHW/TpalT2
 akFqvLvOOUAiEM5jjR6MzeRKDIlsdvcRKTMiadQgnnaiP6IYSDJvmQBCmploZE+nrsLBc9h6LI
 bMZw6yhTmbiQ8SazqnryDtnYoinGJdOD3u/+6/8rp6t6on1d0bRw5zVP8uB/Ieu39dytrqaVqD
 LSuBeV0/cIDjozP/XQW61iGn1z7iIPC4VZZg0jK+sMfrvrmGm0fcVXh7LYBB8YY69UvblmWTxy
 GiSh7AQAA
X-Change-ID: 20260728-drm_pending_vblank_event_leak-a36cedb296ba
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Melissa Wen <mwen@igalia.com>, kernel-dev@igalia.com, 
 sashiko-bot@kernel.org, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
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

When an out_fence_ptr is provided but DRM_MODE_PAGE_FLIP_EVENT is not
set, a drm_pending_vblank_event will be allocated. If later, there is an
allocation failure or another failure at setup_out_fence(), that event
will not have base.fence set and it will not be released at
complete_signaling().

Release the event and set crtc_state->event to NULL just like in the
DRM_MODE_PAGE_FLIP_EVENT case when there is a failure at
drm_event_reserve_init(). That is, prepare_signaling() releases the
event and there is nothing to be done at complete_signaling(). Use
drm_event_cancel_free() as that will also undo drm_event_reserve_init()
in case it has been called.

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=1
Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v4:
- Rename label to err_free_event.
- Use crtc_state->event instead of a local variable e.
- Link to v3: https://patch.msgid.link/20260817-drm_pending_vblank_event_leak-v3-1-7582b24447d0@igalia.com

Changes in v3:
- Use a label for the common exit pattern.
- Link to v2: https://patch.msgid.link/20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com

Changes in v2:
- Fix UAF when DRM_MODE_PAGE_FLIP_EVENT is used.
- Link to v1: https://patch.msgid.link/20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com
---
 drivers/gpu/drm/drm_atomic_uapi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index ae7667d1072d..8c0eea2fed4a 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1458,10 +1458,12 @@ static int prepare_signaling(struct drm_device *dev,
 			struct dma_fence *fence;
 			struct drm_out_fence_state *f;
 
+			ret = -ENOMEM;
+
 			f = krealloc(*fence_state, sizeof(**fence_state) *
 				     (*num_fences + 1), GFP_KERNEL);
 			if (!f)
-				return -ENOMEM;
+				goto err_free_event;
 
 			memset(&f[*num_fences], 0, sizeof(*f));
 
@@ -1470,12 +1472,12 @@ static int prepare_signaling(struct drm_device *dev,
 
 			fence = drm_crtc_create_fence(crtc);
 			if (!fence)
-				return -ENOMEM;
+				goto err_free_event;
 
 			ret = setup_out_fence(&f[(*num_fences)++], fence);
 			if (ret) {
 				dma_fence_put(fence);
-				return ret;
+				goto err_free_event;
 			}
 
 			crtc_state->event->base.fence = fence;
@@ -1531,6 +1533,11 @@ static int prepare_signaling(struct drm_device *dev,
 	}
 
 	return 0;
+
+err_free_event:
+	drm_event_cancel_free(dev, &crtc_state->event->base);
+	crtc_state->event = NULL;
+	return ret;
 }
 
 static void complete_signaling(struct drm_device *dev,

---
base-commit: 4d4be202165e832d74849b4a68e289a2a377039c
change-id: 20260728-drm_pending_vblank_event_leak-a36cedb296ba

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

