Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0D606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dwxNlTwW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7317610E4B0;
	Tue, 27 Oct 2026 21:18:01 +0000 (UTC)
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com
 [74.125.224.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E31D10F82E
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 21:17:53 +0000 (UTC)
Received: by mail-yx1-f100.google.com with SMTP id
 956f58d0204a3-6790844c9b0so264808d50.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793135872; x=1793740672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=01NOpgHWVqQgjTNsBgGAKMr4sobRWIoGGoSOs/pmDn8=;
 b=KBwcaQZJJzeiXukKaLcMSEVSY6WxOeVSlACHa0DWrTqIYhONeF5XfIPQxZA0Ok6iKX
 +uGCvcXd+c5q3pYbSUVpmfcR2E86CmSMjPum0fqXFaXLimNoiPSgaljXpng5SrhgoQbi
 5FCTxTegzUCoG0VUge6ycM7d4KaSL16vWivnnVwEAACITTVym/yyQImGE4h4dKxiuwXP
 oSdBA3RuKb3cSKOhD8noWzr8Oyw4h3SfnhhRTT5GVTkCyMgPVCdJ6QPi4k9uyoLzjoKn
 FABjWY6d3hwbGyRWm3I9QqD7P935v03G5KBRyjoU3F4jQ5oLHF4stkzsAGyNOaZzKC+f
 RsDQ==
X-Gm-Message-State: AFq9FYKAii6DRHKL3rIYGCTA3JICxkJu1sfnc3k5Z4mvOB5K/jy4MjB2
 brHGjSS/QejA/aEIQZLuuGTODQGE8S5+fJIeZa0BPWSXkPajJz4o1Uo9P/8MJgJClHveDDtXOk1
 OLnmOysrHEHaKLwK5DnWYmoHrE9v51X6j6YmCv+DGxVZ4LlTMzg9Tv8YNeXq6fW4eMxdNuxWCKU
 B84XhSseuue7CtoriMlxqDrQAZf0wQVe+bsXhQWuqBzXkTsNK53P/1INJksNAVyjEEjuBv/BoZM
 TyYqPGDQh4gMAruOpW2
X-Gm-Gg: AYBFou0Au3yRjprADwX59EjPaG+T4zqHyXW3ivZJH1wWSan5S1FFu9WP40F4SsCBMLA
 OF+RPkJsqlm8f1PyFj1ZO0HOmFDqXKb4GhWF09IoSsG98paj8ag5otCFbpA5MAtQDi49Yb953rh
 7pvmSEA56riN4APqhPZU75Pg6Be3rC2EQHIYYXiFmwtEoI3ntVLoQv6rCMCtgjgWg0TX8R8BGzb
 vKKfKiV62iiX5m4+Hzwru57yxX2U245+SG2w6zuV9DQEg9c6JwbDIQqcHVgEsPAPBA+/E+yXgdf
 ra0Z/ciBz7PEcMasRQcmBhSYyomnbNzp0icIlJRJ5X80P2femVjJg+P29cBzC/wdadsf63FmCPq
 YynjSCp55bsb+Yj84SQu00W3rOuOHaqL70FYUMsmW4tPRsZ+ViD0QzcCGyivNm3tnMNW45TU0TG
 rWnK08hbXg+25dEQ87FuStviMXak9YVQNMYio=
X-Received: by 2002:a05:690e:169d:b0:677:d849:d9a3 with SMTP id
 956f58d0204a3-67a7baa201emr726690d50.1.1793135872218; 
 Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-67a7a1ba533sm27971d50.40.2026.10.27.14.17.51
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2026 14:17:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso343096eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793135870; x=1793740670;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=01NOpgHWVqQgjTNsBgGAKMr4sobRWIoGGoSOs/pmDn8=;
 b=dwxNlTwWnAlxcuWwe/ZVi6EKL2CGCRducElm1dLe/t6txlrrnR5TlMLNMGSb+APqZ8
 ZC/La3EvN7FsJDPbIDq2wJ2XcCq8Ba5Bhlhq9+1cv3cBuG1r2Rs3RMLrkspuEzaumKxH
 +BF/KvhnFxZKkzzICYucvz3jxzCXr5DJkF6NU=
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-36a2039cb09mr850554eec.18.1793135870415; 
 Tue, 27 Oct 2026 14:17:50 -0700 (PDT)
X-Received: by 2002:a05:693c:2a17:b0:36a:1bac:6bf4 with SMTP id
 5a478bee46e88-36a2039cb09mr850515eec.18.1793135869562; 
 Tue, 27 Oct 2026 14:17:49 -0700 (PDT)
Received: from vertex.localdomain
 (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8c576ebsm35760859eec.3.2026.10.27.14.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 14:17:48 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 maaz.mombasawala@broadcom.com, yunfeng.li.nb@gmail.com, tomas@slax.org,
 Zack Rusin <zack.rusin@broadcom.com>, stable@vger.kernel.org
Subject: [PATCH 5/6] drm/vmwgfx: validate the framebuffer selected for cursor
 updates
Date: Tue, 27 Oct 2026 17:17:28 -0400
Message-ID: <20261027211729.646988-6-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027211729.646988-1-zack.rusin@broadcom.com>
References: <20261027211729.646988-1-zack.rusin@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Cursor atomic checks select an update path and look up surfaces through
vps->uo. That object is copied from the previous plane state and is only
replaced with the new framebuffer's object in prepare_fb(). Switching
between snooped surfaces and buffer objects therefore applies the old
framebuffer's cursor limits to the new image.

KMS clients can also submit a guest-backed surface without a backing BO.
The check accepts it, but the MOB update later copies from a NULL source.
Zero-sized MOB images pass the check as well, then fail preparation when
mapping zero pages, so TEST_ONLY accepts a commit that cannot succeed.

Resolve the user object directly from the selected framebuffer in both
validation and preparation. Apply the matching cursor limits, reject
zero dimensions and require a backing BO for GB-only and MOB images.
Recheck the backing BO in preparation before mapping it, while keeping
snooped surfaces independent of a BO mapping.

Fixes: 965544150d1c ("drm/vmwgfx: Refactor cursor handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 61 ++++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index f0661e5effeb..9e8ea9e07f40 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -89,10 +89,26 @@ vmw_cursor_plane_update_legacy(struct vmw_private *vmw,
 	}
 }
 
-static enum vmw_cursor_update_type
-vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_plane_state *vps)
+static struct vmw_user_object
+vmw_cursor_plane_user_object(struct drm_framebuffer *fb)
 {
-	struct vmw_surface *surface = vmw_user_object_surface(&vps->uo);
+	struct vmw_user_object uo = { 0 };
+
+	if (!fb)
+		return uo;
+
+	if (vmw_framebuffer_to_vfb(fb)->bo)
+		uo.buffer = vmw_framebuffer_to_vfbd(fb)->buffer;
+	else
+		uo = vmw_framebuffer_to_vfbs(fb)->uo;
+
+	return uo;
+}
+
+static enum vmw_cursor_update_type
+vmw_cursor_update_type(struct vmw_private *vmw, struct vmw_user_object *uo)
+{
+	struct vmw_surface *surface = vmw_user_object_surface(uo);
 
 	if (surface && surface->snooper.image)
 		return VMW_CURSOR_UPDATE_LEGACY;
@@ -642,17 +658,10 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	if (!vmw_user_object_is_null(&vps->uo))
 		vmw_user_object_unref(&vps->uo);
 
-	if (fb) {
-		if (vmw_framebuffer_to_vfb(fb)->bo) {
-			vps->uo.buffer = vmw_framebuffer_to_vfbd(fb)->buffer;
-			vps->uo.surface = NULL;
-		} else {
-			memcpy(&vps->uo, &vmw_framebuffer_to_vfbs(fb)->uo, sizeof(vps->uo));
-		}
-		vmw_user_object_ref(&vps->uo);
-	}
+	vps->uo = vmw_cursor_plane_user_object(fb);
+	vmw_user_object_ref(&vps->uo);
 
-	vps->cursor.update_type = vmw_cursor_update_type(vmw, vps);
+	vps->cursor.update_type = vmw_cursor_update_type(vmw, &vps->uo);
 	switch (vps->cursor.update_type) {
 	case VMW_CURSOR_UPDATE_LEGACY:
 		surface = vmw_user_object_surface(&vps->uo);
@@ -662,6 +671,9 @@ int vmw_cursor_plane_prepare_fb(struct drm_plane *plane,
 	case VMW_CURSOR_UPDATE_GB_ONLY:
 	case VMW_CURSOR_UPDATE_MOB: {
 		bo = vmw_user_object_buffer(&vps->uo);
+		if (fb && !bo)
+			return -EINVAL;
+
 		if (bo) {
 			struct ttm_operation_ctx ctx = { false, false };
 			size_t size = (size_t)new_state->crtc_w *
@@ -744,7 +756,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 	int ret = 0;
 	struct drm_crtc_state *crtc_state = NULL;
 	struct vmw_surface *surface = NULL;
-	struct vmw_plane_state *vps = vmw_plane_state_to_vps(new_state);
+	struct vmw_user_object uo;
 	enum vmw_cursor_update_type update_type;
 	struct drm_framebuffer *fb = new_state->fb;
 
@@ -763,7 +775,21 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 	if (!fb)
 		return 0;
 
-	update_type = vmw_cursor_update_type(vmw, vps);
+	if (!new_state->crtc_w || !new_state->crtc_h) {
+		drm_dbg_kms(&vmw->drm,
+			    "Cursor dimensions (%u, %u) must be nonzero\n",
+			    new_state->crtc_w, new_state->crtc_h);
+		return -EINVAL;
+	}
+
+	/* The duplicated plane state's user object still belongs to the old FB. */
+	uo = vmw_cursor_plane_user_object(fb);
+	update_type = vmw_cursor_update_type(vmw, &uo);
+	if ((update_type == VMW_CURSOR_UPDATE_GB_ONLY ||
+	     update_type == VMW_CURSOR_UPDATE_MOB) &&
+	    !vmw_user_object_buffer(&uo))
+		return -EINVAL;
+
 	if (update_type == VMW_CURSOR_UPDATE_LEGACY) {
 		if (new_state->crtc_w != VMW_CURSOR_SNOOP_WIDTH ||
 		    new_state->crtc_h != VMW_CURSOR_SNOOP_HEIGHT) {
@@ -772,7 +798,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 				 new_state->crtc_w, new_state->crtc_h);
 			return -EINVAL;
 		}
-		surface = vmw_user_object_surface(&vps->uo);
+		surface = vmw_user_object_surface(&uo);
 		if (!surface || !surface->snooper.image) {
 			drm_warn(&vmw->drm,
 				 "surface not suitable for cursor\n");
@@ -789,8 +815,7 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 					 SVGA_CB_MAX_COMMAND_SIZE -
 					 sizeof(struct vmw_svga_fifo_cmd_define_cursor));
 
-		if (!new_state->crtc_w || !new_state->crtc_h ||
-		    new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
+		if (new_state->crtc_w > SVGA_MAX_CURSOR_CMD_DIMENSION ||
 		    new_state->crtc_h > SVGA_MAX_CURSOR_CMD_DIMENSION ||
 		    image_size > max_size) {
 			drm_dbg_kms(&vmw->drm,
-- 
2.53.0

