Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49612F53D9B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 21:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAA9D10E3F0;
	Mon, 16 Mar 2026 21:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dxmQz59M";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9BA10E3AB;
 Mon, 16 Mar 2026 21:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m/q+7C0Zaog1VOyG1eXLfECPXIueB2oChE1kJDq6XCw=; b=dxmQz59MVCjH85Q4grgIbC35Hh
 38jwQgCuYPd/dsIQUvbKH+myCnLsS0yQK7fd3HuaKl05Vrb1f9iMsh/IBBPVSc2CykJSqLfyPKT+a
 qnhyNgd0jqnDjg7vCtFYqgM1GPJogdajXJuLdKnqE2N134Zo300+vsSQnMJx5ikvDh1g9lLTUP2Xf
 J1qaHSh2PLnNZ1p7QHL4Wzov8Uj+3VQikl0Um4kNExtiNC2XywJ5X2AkGugIEoHbd1FS3rptMhuWG
 oSzP5bcTlE4snm18NdG/jSNaXAXF8Yl3OATF+HtnXnfK4GEvUZ+vrebBdjluKqK7eoYT047uTDV9J
 VqmdW6Lw==;
Received: from [186.208.74.38] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1w2F3e-00GhAw-3m; Mon, 16 Mar 2026 22:01:02 +0100
From: Melissa Wen <mwen@igalia.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 harry.wentland@amd.com, alex.hung@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, amd-gfx@lists.freedesktop.org,
 mwen@igalia.com, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/drm_atomic: duplicate colorop states if plane color
 pipeline in use
Date: Mon, 16 Mar 2026 17:52:06 -0300
Message-ID: <20260316210055.234498-1-mwen@igalia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For suspend/resume to work correctly, do for colorop state the same we
do for plane/crtc/connector states: duplicate the state of colorops in a
color pipeline if it's in use by a given plane when suspending and
restore cached colorop states when resuming.

Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---

Hi,

I've been working on making gamescope use KMS plane color API, instead
of AMD driver-specific color properties [1] and I found this issue
during Steam Deck suspend/resume process.

Initially I thought I should also set plane color_mgmt_changed to make
AMD driver reprogram the color state, but looks like it's not needed
(still testing). Therefore, I think the change here is enough to fix it.

It applies on top of drm-misc-next and is inspired by commit
6955d6bca053 ("drm/atomic: Add affected colorops with affected planes").

[1] https://github.com/ValveSoftware/gamescope/pull/2113

 drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
 include/drm/drm_atomic.h            |  3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 26953ed6b53e..683a0e207f71 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3751,6 +3751,13 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 			err = PTR_ERR(plane_state);
 			goto free;
 		}
+
+		if (plane_state->color_pipeline) {
+			err = drm_atomic_add_affected_colorops(state, plane);
+			if (err)
+				goto free;
+		}
+
 	}
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
@@ -3856,6 +3863,8 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 	int i, ret;
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state;
+	struct drm_colorop *colorop;
+	struct drm_colorop_state *new_colorop_state;
 	struct drm_connector *connector;
 	struct drm_connector_state *new_conn_state;
 	struct drm_crtc *crtc;
@@ -3866,6 +3875,9 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
 	for_each_new_plane_in_state(state, plane, new_plane_state, i)
 		state->planes[i].old_state = plane->state;
 
+	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i)
+		state->colorops[i].old_state = colorop->state;
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
 		state->crtcs[i].old_state = crtc->state;
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 0b1b32bcd2bd..96fd32a3e92c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1102,7 +1102,8 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 		for_each_if ((__state)->colorops[__i].ptr &&		\
 			     ((colorop) = (__state)->colorops[__i].ptr,	\
 			      (void)(colorop) /* Only to avoid unused-but-set-variable warning */, \
-			      (new_colorop_state) = (__state)->colorops[__i].new_state, 1))
+			      (new_colorop_state) = (__state)->colorops[__i].new_state,\
+			      (void)(new_colorop_state) /* Only to avoid unused-but-set-variable warning */, 1))
 
 /**
  * for_each_oldnew_plane_in_state - iterate over all planes in an atomic update
-- 
2.51.0

