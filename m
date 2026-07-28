Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54AAC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E9310E5AA;
	Tue, 28 Jul 2026 14:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KvTdKRlH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17FF10E92D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=WyaYypMu9GEX/jik9oVHBLv+UPV8MwQgAiUyGC1vieY=; b=KvTdKRlH5+ZsJOJrg+Pr073rdT
 NH+SZ1akyw3+/pcMcgVjMn0rfsXHGL6aDQOJRA0OVi6wHzACDzyQaTHLjp9bHrROG4mNoj10D+8/2
 pygh+TjLXw7rm9/Y7zq7/o4wt3sxAITPztPKtBG+Hex7YIVLDIVMeFFLdBVFLk63FGCXmUWWi4kqV
 Cck76n9mL5aLxj6OSx7q/zR6P3+BDxBL7lx8JK4iW2QRillRbL2Ex2tDcSm2ehI0wvaJ5mafgInLX
 HrL8CC/Hw6TGQaimZONPjCR8ZhxZgQvifXICu7Q65HwOeZBms0cd0NSCPE+1kW3chuhUM/IR3Vs/V
 CT5OlAYg==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1woiyg-0071wF-8I; Tue, 28 Jul 2026 16:40:18 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Tue, 28 Jul 2026 11:39:48 -0300
Subject: [PATCH] drm: Fix drm_pending_vblank_event in error path for
 out_fence_ptr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com>
X-B4-Tracking: v=1; b=H4sIADS/aGoC/yXMTQrCMBAG0KuUWRuoEVL1KiIhP591bB1LUoNQe
 ndTXb7NWygjMTKdm4USCmd+ScV+11C4O+mhOFaTbrVpO31UMT3tBIksvS1+dDJYFMhsR7hBuYM
 JiF6fjHdUjynhxp/ff7n+nd/+gTBvKa3rF570UH+BAAAA
X-Change-ID: 20260728-drm_pending_vblank_event_leak-a36cedb296ba
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, sashiko-bot@kernel.org, 
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

When an out_fence_ptr is provided but DRM_MODE_PAGE_FLIP_EVENT is not
set, a drm_pending_vblank_event will be allocated. If later, there is an
allocation failure or another failure at setup_out_fence(), that event
will not have base.fence set and it will not be released at
complete_signaling().

Release the event and set crtc_state->event to NULL just like in the
DRM_MODE_PAGE_FLIP_EVENT case when there is a failure at
drm_event_reserve_init(). That is, prepare_signaling() releases the
event and there is nothing to be done at complete_signaling().

Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=1
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17..aca35fb4b1f9 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1464,11 +1464,15 @@ static int prepare_signaling(struct drm_device *dev,
 		if (fence_ptr) {
 			struct dma_fence *fence;
 			struct drm_out_fence_state *f;
+			struct drm_pending_vblank_event *e = crtc_state->event;
 
 			f = krealloc(*fence_state, sizeof(**fence_state) *
 				     (*num_fences + 1), GFP_KERNEL);
-			if (!f)
+			if (!f) {
+				kfree(e);
+				crtc_state->event = NULL;
 				return -ENOMEM;
+			}
 
 			memset(&f[*num_fences], 0, sizeof(*f));
 
@@ -1476,12 +1480,17 @@ static int prepare_signaling(struct drm_device *dev,
 			*fence_state = f;
 
 			fence = drm_crtc_create_fence(crtc);
-			if (!fence)
+			if (!fence) {
+				kfree(e);
+				crtc_state->event = NULL;
 				return -ENOMEM;
+			}
 
 			ret = setup_out_fence(&f[(*num_fences)++], fence);
 			if (ret) {
 				dma_fence_put(fence);
+				kfree(e);
+				crtc_state->event = NULL;
 				return ret;
 			}
 

---
base-commit: df0311845915442ab75d03ee89fb443b444c1370
change-id: 20260728-drm_pending_vblank_event_leak-a36cedb296ba

Best regards,
--  
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

