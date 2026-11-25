Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BA606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xLUKz4tM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A481120EA;
	Thu, 26 Nov 2026 08:09:06 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59DE10FB95
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:24:18 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6ba1e22ff4dso6651134a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:24:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795605857; cv=none;
 d=google.com; s=arc-20260327;
 b=TCg1Yyi7ZLTNr8Rvp8FWMFIZ4whxEuasdsvr4l/oxnVerybJf6ZL0+qD08SMGByXFO
 sVyVb/NLC92pqJj26eZZRSRyJpx7IlrLS3tIJqrBj3F8Qu5gUOvpmX3EzKizHIRgy1sk
 KiMhEiV7xtr8p1K99eMy74MRkyU5xxhqPzfUr8icoEtPTaD6fEI3rmWaorxh7INRihKk
 Ls5h1/ErdP3OKh9rpXjFRAVPE/tZSJWx9Z7txvpwvPJAsfxmKxKaCVWie4ZyHQxJ/oEG
 ymikz4r9T3B9GeqHPCzm+v95O8V65YD3n901hqa72BIfkOSyx6b6dM+2JCsSGfFwl8dR
 f9kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bKcB04rSkuOWm7b4FPOKw09aZL7f06yLsTu8uJOudL4=;
 fh=sBTc3++QkhDY1hRhN5wnYtrSm7ux9GYketQuwZA4BYk=;
 b=gfOegREVuv81+fYaK+wh0c9iwJ86CPCIAX6d7yKkiv2AJnAYVud4s2IXIcR5n0BneC
 tHygox/Ml7J0JrnpJwG0EJQR/Z+CvK2nX5gzVMxth3Q34wg7O0olbkqduXFEY+Apc355
 FiJFzm/xAHCChGzP4AUpsa3FN6J/f/3gPCL4g25RB90AJ3v377NtZJCsLbRGDhxfr1UX
 Yk/FCmy40gTEFDes/ags++2U6rTbOIQkrDc3ejJU3wkHYj2wY524pRbQJVMv0bwa333K
 FNyd07+nmI/0Uy4x4/EA2Wmd2AT7WDXIWuNkzGvsWDuZVFw7JJ5wok8hvCYpiMledx2p
 cHDA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605857; x=1796210657; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bKcB04rSkuOWm7b4FPOKw09aZL7f06yLsTu8uJOudL4=;
 b=xLUKz4tMDvCCLWuAWNSnY/4NbA5xK+FbY9iTZ6IxPbqTmllBcjLuNB47r8LpKz7vwB
 Le4dFR/+STXI6m9B0jyh5xy3nU3nCX1MRrezLQbAR+DG0c9tYdHyUApcURk8F/qw8t99
 IPnWCvYCkaQw9jl0Vnnrr6x6mIsghncfnEC3DCT/QS6UgPmlSHvC9mfptTYb7WPy240N
 nuKCT45zxS5u+O390hd/luEn6LMGHNr4MzLOowN2bdd1CKtd4P0Mx7eH2vD5zOBOq2DC
 SE2z1jO6gfOZ4IopxGQ6lQSCNG7FFstdwEAbsQ28MIUgdUkP66/FFuZq/x/DD81lwk/n
 xphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605857; x=1796210657;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bKcB04rSkuOWm7b4FPOKw09aZL7f06yLsTu8uJOudL4=;
 b=1aGUls2LS7oIf9sNbAtMFotecSGPTpaDt7g0yDRQOX9maglf+X3ecNuH8qnT5DlrCr
 MUXSL0wxZH2tMaOI3zs1iTnSew5uPkvv2SIpttgirIC5LLkr7GuwWaNNy3Mg4KxWqx2c
 HtkPfm0z9g8WsiRQK6dw6hf9tK4gYl/lTrYVCA4bymoqEsBZ2rI+gHG9Skz9bqZ3Q0QW
 P8qJK5HMlJZ3hsRGxIC2CvQpAgm/IWfmS3ZaZmOoCAhAMYCzz4FGcHWMuXUJ/N+H+Vxy
 O29wAyb3KL8hc8vmc76/cUowExdhx2lcRjwFlnYvJLG/b++Wpqy9u/0qaK8rSMDK97CT
 mBqA==
X-Forwarded-Encrypted: i=1;
 AL+hErFgfu/3DetxQH+UhKiW574v01Q9K6K3VCXm1CXysQ42869Txycy2mRn29Jr4cUFfghGIDCZvLuUPVY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+a4GktVVgRYB9PiU8fedViKbzXBA9/uamIOrUWgTtweatBwMS/
 6JJ1y82H9hDk50XLSnzwSbk+Uxm5T5QqkygpmZqVIMVZxNcJ9yNM65a2IdHp0w6IKfBK9AgxYoc
 YSXHZ5QTnTHHPi3pHnBxnnaX7MJkT2tA=
X-Gm-Gg: AZFdTZc6ib0QCK6HGwwi9r6ozdjCgxv73cFSKsUi+9MSDaDU5ltrZA1Nh+LFagT8RTe
 IX6ZT6BjUAIlZysfkj70b8GelEYte3m6PpuuPtpZgqH4NS+FEnSmEpKXiqvF/lylWLP9Sw/4aKb
 FJaNM3pVchy5xDsJeAqe1CArpXBsLr2k2yKjP7I/xO3YxDGiTubpoTHxBNj3VJFCN7mCqTqAfh+
 1Ex8s+J4o6csDrY5ZjN01urdqFWaijKBnEPOt0J773VA18MqXoFeZCHteMV5PlbaOui7j4wjDC+
 5x8Pz+azQb1LN25j97ia2ILEMQqMsd6OwwwmYRXWmmZQ1S5zDw3Dqd1ukgLWaVN9CTHnBWzGuh5
 /qbfC0eLjqykFhSJBmJks3DZbph3syA0GCMsxR1SPtoOgaDv4bRarj3kFoZU3VNIlVs7rEPjs8a
 iZStTJVeaO99QPzvVDChV+ksvdtIPfRxdV6XY4k2tlDuRNZi/f
X-Received: by 2002:aa7:d287:0:b0:6bb:12db:8234 with SMTP id
 4fb4d7f45d1cf-6bb12db84e7mr1799402a12.2.1795605857019; Wed, 25 Nov 2026
 03:24:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Herman Semenoff <germanaizek0@gmail.com>
Date: Wed, 25 Nov 2026 14:24:34 +0300
X-Gm-Features: Aa3M54pJ_uqM-aO8I_etcGL7mZiC9V0bQpHkeguXT2AOfz945hpX194hsCU4hyw
Message-ID: <CAMnMt5aufzBXQvs2OeFpBqdh1_VgNUxstvkVX61dPPcfo94QOg@mail.gmail.com>
Subject: [PATCH] drm/ast: Optimize cursor updates and reduce overhead
To: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:59 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From f9574b5a246bf9021ea75f530a9a8ab7c9995274 Mon Sep 17 00:00:00 2001
From: Herman Semenoff <GermanAizek@yandex.ru>
Date: Tue, 24 Nov 2026 12:53:31 +0300
Subject: [PATCH] drm/ast: Optimize cursor updates and reduce overhead

On server platforms equipped with ASPEED BMC GPUs (such as AST2400 on
Lenovo RD450X), VRAM is mapped over a slow PCIe link with limited
bandwidth.

Currently, on every cursor move (e.g. via drmModeMoveCursor or atomic
commit updating plane coordinates without damage clips),
ast_cursor_plane_helper_atomic_update() invokes
drm_atomic_helper_damage_merged(). Because userspace does not provide
damage clips for pure cursor movements,
drm_atomic_helper_damage_iter_init() treats the absence of clips as a
full plane update. Consequently, on every mouse move event:
 1. ast_cursor_plane_get_argb4444() performs format conversion on CPU
 2. ast_set_cursor_image() recalculates 32-bit checksum on CPU
 3. memcpy_toio() pushes 8192 bytes over the slow PCIe link into VRAM
 4. Cursor base registers are reprogrammed

Fix this by only updating the cursor image and base when the image
actually changes (fb != old_fb, plane was previously invisible, or
damage clips were provided). For pure position updates, only update
the coordinates in the hardware cursor signature and registers,
skipping VRAM transfer, format conversion, and checksum calculation.

Additionally:
- Add DRM_FORMAT_XRGB8888 support to ast_cursor_plane_formats and handle
  it with opaque alpha in ast_cursor_plane_get_argb4444(), preventing
  compositors from unnecessarily falling back to software cursors on the
  primary plane
- Implement .panic_flush in ast_primary_plane_helper_funcs to disable the
  hardware cursor during kernel panics (CONFIG_DRM_PANIC)

Signed-off-by: Herman Semenoff <GermanAizek@yandex.ru>
Signed-off-by: Herman Semenoff <GermanAizek@aizekgroup.ru>
---
 drivers/gpu/drm/ast/ast_cursor.c | 39 +++++++++++++++++++++++++++++---
 drivers/gpu/drm/ast/ast_drv.h    |  1 +
 drivers/gpu/drm/ast/ast_mode.c   |  8 +++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_cursor.c b/drivers/gpu/drm/ast/ast_cursor.c
index 690d4cd1db5e..883d1e6f20bd 100644
--- a/drivers/gpu/drm/ast/ast_cursor.c
+++ b/drivers/gpu/drm/ast/ast_cursor.c
@@ -142,7 +142,7 @@ static void ast_set_cursor_location(struct
ast_device *ast, u16 x, u16 y,
  ast_set_index_reg(ast, AST_IO_VGACRI, 0xc7, y1);
 }

-static void ast_set_cursor_enabled(struct ast_device *ast, bool enabled)
+void ast_set_cursor_enabled(struct ast_device *ast, bool enabled)
 {
  static const u8 mask = (u8)~(AST_IO_VGACRCB_HWC_16BPP |
      AST_IO_VGACRCB_HWC_ENABLED);
@@ -162,6 +162,7 @@ static void ast_set_cursor_enabled(struct
ast_device *ast, bool enabled)
 static const uint32_t ast_cursor_plane_formats[] = {
  DRM_FORMAT_ARGB4444,
  DRM_FORMAT_ARGB8888,
+ DRM_FORMAT_XRGB8888,
 };

 static int ast_cursor_plane_helper_atomic_check(struct drm_plane *plane,
@@ -229,6 +230,30 @@ static const u8
*ast_cursor_plane_get_argb4444(struct ast_cursor_plane *ast_curs
  argb4444 = argb4444_dst[0].vaddr;
  }
  break;
+ case DRM_FORMAT_XRGB8888:
+ {
+ struct iosys_map argb4444_dst[DRM_FORMAT_MAX_PLANES] = {
+ IOSYS_MAP_INIT_VADDR(ast_cursor_plane->argb4444),
+ };
+ unsigned int argb4444_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+ AST_HWC_PITCH,
+ };
+ unsigned int x, y;
+ u16 *dst16;
+
+ drm_fb_argb8888_to_argb4444(argb4444_dst, argb4444_dst_pitch,
+    shadow_plane_state->data, fb, clip,
+    &shadow_plane_state->fmtcnv_state);
+
+ for (y = clip->y1; y < clip->y2; y++) {
+ dst16 = (u16 *)(ast_cursor_plane->argb4444 +
+ y * AST_HWC_PITCH);
+ for (x = clip->x1; x < clip->x2; x++)
+ dst16[x] |= 0xf000;
+ }
+ argb4444 = argb4444_dst[0].vaddr;
+ }
+ break;
  }

  drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
@@ -261,13 +286,21 @@ static void
ast_cursor_plane_helper_atomic_update(struct drm_plane *plane,
  unsigned int offset_x, offset_y;
  u16 x, y;
  u8 x_offset, y_offset;
+ bool update_image;

  /*
  * Do data transfer to hardware buffer and point the scanout
- * engine to the offset.
+ * engine to the offset only if the cursor image actually changed
+ * or the plane became visible. For pure cursor moves, avoid
+ * expensive PCIe bus transfers, format conversion, and checksum
+ * calculation.
  */
+ update_image = (fb != old_plane_state->fb) ||
+       !old_plane_state->visible ||
+       drm_plane_get_damage_clips_count(plane_state);

- if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage)) {
+ if (update_image &&
+    drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage)) {
  const u8 *argb4444 = ast_cursor_plane_get_argb4444(ast_cursor_plane,
    shadow_plane_state,
    &damage);
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 4f221b848d68..d846d5cf4f5e 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -542,6 +542,7 @@ int ast_sil164_output_init(struct ast_device *ast);
 /* ast_cursor.c */
 long ast_cursor_vram_offset(struct ast_device *ast);
 int ast_cursor_plane_init(struct ast_device *ast);
+void ast_set_cursor_enabled(struct ast_device *ast, bool enabled);

 /* ast dp501 */
 bool ast_backup_fw(struct ast_device *ast, u8 *addr, u32 size);
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 08db132acae8..f94f849d157b 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -639,6 +639,13 @@ static int
ast_primary_plane_helper_get_scanout_buffer(struct drm_plane *plane,
  return -ENODEV;
 }

+static void ast_primary_plane_helper_panic_flush(struct drm_plane *plane)
+{
+ struct ast_device *ast = to_ast_device(plane->dev);
+
+ ast_set_cursor_enabled(ast, false);
+}
+
 static const struct drm_plane_helper_funcs ast_primary_plane_helper_funcs = {
  DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
  .atomic_check = ast_primary_plane_helper_atomic_check,
@@ -646,6 +653,7 @@ static const struct drm_plane_helper_funcs
ast_primary_plane_helper_funcs = {
  .atomic_enable = ast_primary_plane_helper_atomic_enable,
  .atomic_disable = ast_primary_plane_helper_atomic_disable,
  .get_scanout_buffer = ast_primary_plane_helper_get_scanout_buffer,
+ .panic_flush = ast_primary_plane_helper_panic_flush,
 };

 static const struct drm_plane_funcs ast_primary_plane_funcs = {
-- 
2.55.0
