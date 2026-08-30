Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A80C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83EB710E696;
	Mon, 31 Aug 2026 07:00:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NgBoCVqk";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE87B10E1E3
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 15:16:36 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d91ded8174so2083645ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788102996; x=1788707796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Y0V8OHugwHV1knNa61KDiXTkjr/SgExhgiHseoKDWc=;
 b=NgBoCVqkFP6yl5p8ez/uREH/tNn83JO+llQF+GuD2zyFpZm7x/PwTPIh9Fax6arxk/
 S3Zg77KauwfjZ5PoAKLMZ1sx+bwOiMR3lMIiXBb4p2HzIlXGN3bOSSSW57iPHPgo3aD3
 eE/Fk8pLfUPFSRpJ8g3I6/SuYACJe0VzS+fYrLJM/VPq/kblGUu2b6V22oRUmwYR01ka
 Go8sZfRrMeISu9gc7vbzvsFFW96KqLXI+WTLimPYi31zhOiOJDRFHTPgVmYEk8B5qDmf
 Rb38CSrCQab+qeLUPxYvGui4PfV2l78gsyg/UhPrBom3eorl45FFlFAzMDuq24VIfgo5
 rJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788102996; x=1788707796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Y0V8OHugwHV1knNa61KDiXTkjr/SgExhgiHseoKDWc=;
 b=mZlBlhhKx0IjFtHW+m7+mekptzp01Cu07neAqGVlf59oD19PqBuM7eQ3uIOIVDPr23
 JA2Fu/xuL1Sfks3MBF7DkACdtGngq51XME9+ix9m6eD71HiY3w6AdY7n2s+/A4ROaDWF
 tJwEWVkjrdhTrI6VGfvMAkphK9PIAyo2x1Z6G14VgLshxQ5PqvnRv8ma56P6G+kTP09c
 /CN6qH1ygjG7znNZ19qqMBicYUKBM9uOy76D6mk7tyePAXg3BLnAnq1N8W8LEMOgHjse
 qwztmLGPfS8OaGWZSPFgWyEwzPCl2t9O7g4jNb78yqq36E6TL7Mo9dQKG8Tk2GRhyJBW
 Svhw==
X-Gm-Message-State: AFuF++mhRe16R6GZlSZlaLM783EXnRNXgzPB8vSOyK9CtlUfdqnLLQW4
 PRQwLfQprGvO0MqJ149MkurLpbEis724VKXTbPK73qdvfwwCivQhHqS/nTuEjt57a9Q=
X-Gm-Gg: AYBFou0azBwuDZFw9owPX6k0PF424mNESf8CqqksuITrP99t7lLZfQDRN4xk7CRyIIm
 yU0cBX/V5wglWXmXvx8c5yaNtLusKYpdRIdoBAiVEZwhN1yOiEDrDPwifZtGrGn8umwpqOuGRh6
 txFC2n0MxluQvsagOZbdExuiH4oxzYRry0jT2H1LNiDn4A1x0Ykvt4Nt1VU2/8mSiEfC0F2bEio
 55bPiXbexLSec0cZESt5PG5R07FgTPiATjWTzEO+qZt+cxbc0W1ahaHy7YtyZwCqjTF1f/FVAgB
 g86JgvLniK/qJsvOJo5rZfBulnOeY25Hc3kSVy+ZtDwhQYohyG+4RPBdEdFANH6b7wC6QmP/5zZ
 Ojfx4rB9kYay8lQEgz46YkJKOrB9TD7SLTDuLzCH6ZCQvbHe2drEp2pnXWbG245MfY1WxtsvH6U
 BZGdLm7Sf3a684vcG3oNL+TvfUb1T/cvwteIVx+W/q29HYF4kzK8d4y0pmWxgxnDc0QvUBrS1WT
 S8K1Et8QA==
X-Received: by 2002:a17:902:d4d0:b0:2d9:efc:f206 with SMTP id
 d9443c01a7336-2d90efcf77amr54121145ad.13.1788102996267; 
 Sun, 30 Aug 2026 08:16:36 -0700 (PDT)
Received: from ebizmis.com.com ([61.136.101.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75963b5c2sm22821015ad.30.2026.08.30.08.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 08:16:35 -0700 (PDT)
From: fausten <yunfeng.li.nb@gmail.com>
To: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com,
 zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, linux-kernel@vger.kernel.org,
 fausten <yunfeng.li.nb@gmail.com>
Subject: [PATCH v4] drm/vmwgfx: Treat zero SVGA_REG_CURSOR_MAX_DIMENSION as
 unset
Date: Sun, 30 Aug 2026 23:16:19 +0800
Message-Id: <20260830151619.2452307-1-yunfeng.li.nb@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <ef11cc4a-fbaa-415a-bda1-2ac491f3b5e2@broadcom.com>
References: <ef11cc4a-fbaa-415a-bda1-2ac491f3b5e2@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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

The cursor plane code validates cursor dimensions against
SVGA_REG_CURSOR_MAX_DIMENSION before every cursor update, and
rejects the update with -EINVAL if the cursor is larger than the
reported maximum.

However, this register is only available on hardware versions 18
and above, which introduced cursor MOBs. Older hardware (e.g. a
VMware Fusion guest with SVGA version 2) returns 0 for it.
In that case every cursor update is rejected,
and the log is spammed with:

  [drm] Cursor dimensions (64, 64) exceed device max 0

The visible symptom is that the hardware cursor never appears at
all on VMware Fusion guests (SVGA version 2), making the mouse
pointer invisible even though the input devices work fine.

Treat a reported maximum of 0 as "not implemented" and skip the
dimension check in that case, restoring the pre-existing behaviour
of accepting the cursor.

Tested on VMware Fusion with an SVGA version 2 device where the
cursor previously did not show up.

Fixes: d5ed8749168a ("drm/vmwgfx: enforce cursor size limits for MOB cursors")
Signed-off-by: Yunfeng Li <yunfeng.li.nb@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

---
Changes in v3:
- Use an explicit cursor_max_dim > 0 comparison (Maaz).
- Fix the comments: the register requires cursor MOBs which exist
  only on hw version 18 and above; it is not Fusion-specific
  (Maaz).

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
index d1e7df500..3d4660684 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c
@@ -237,8 +237,10 @@ static int vmw_cursor_mob_get(struct vmw_cursor_plane *vcp,
 	mob_max_size = vmw_read(dev_priv, SVGA_REG_MOB_MAX_SIZE);
 	cursor_max_dim = vmw_read(dev_priv, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-	if (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
-	    vps->base.crtc_h > cursor_max_dim)
+	/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
+	if (cursor_max_dim > 0 &&
+	    (size > mob_max_size || vps->base.crtc_w > cursor_max_dim ||
+	     vps->base.crtc_h > cursor_max_dim))
 		return -EINVAL;
 
 	if (vps->cursor.mob) {
@@ -748,8 +750,10 @@ int vmw_cursor_plane_atomic_check(struct drm_plane *plane,
 		u32 cursor_max_dim =
 			vmw_read(vmw, SVGA_REG_CURSOR_MAX_DIMENSION);
 
-		if (new_state->crtc_w > cursor_max_dim ||
-		    new_state->crtc_h > cursor_max_dim) {
+		/* Cursor MOBs, and thus this register, exist only on hw version 18+. */
+		if (cursor_max_dim > 0 &&
+		    (new_state->crtc_w > cursor_max_dim ||
+		     new_state->crtc_h > cursor_max_dim)) {
 			drm_warn(&vmw->drm,
 				 "Cursor dimensions (%d, %d) exceed device max %u\n",
 				 new_state->crtc_w, new_state->crtc_h,
-- 
2.33.0

