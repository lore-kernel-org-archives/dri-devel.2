Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D2AC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0EB10EF5E;
	Thu, 30 Jul 2026 14:38:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FphIM6kT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602F710EF5E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:38:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 472B54140B;
 Thu, 30 Jul 2026 14:38:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF091F000E9;
 Thu, 30 Jul 2026 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1785422293;
 bh=0E+QD8gxr4D/OdNrn5ht/mu3mgWqf0Kx55F+gk5K9+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FphIM6kTfDgL6DYBsY9wSQFZFqztrkjj6IBh1PxMWbn6yYsqfA6HLEFiDydWEoDM2
 3Rz/xV+5k2so+n9zMZw28hTaxvFaCs/jT92Pbxzl3/AVA7BWkEc4X/pnzCs3w1WzxF
 493+K5Mgn0GlQL3jT0H3q0JL8vq6KeMlBSt1dXco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 7.1 389/744] drm/sysfb: Return errno code from
 drm_sysfb_get_visible_size()
Date: Thu, 30 Jul 2026 16:11:02 +0200
Message-ID: <20260730141452.556710663@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
References: <20260730141444.267951807@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 7bab0f09d753f098977bbba3955d694c2e2c25da upstream.

Change the return type of drm_sysfb_get_visible_size() to s64 so
that it returns a possible errno code from _get_validated_size0().
Fix callers to handle the errno code.

The currently returned unsigned type converts an errno code to a
very large size value, which drivers interpret as visible size of
the system framebuffer. Later efforts to reserve the framebuffer
resource fail.

The bug has been present since efidrm and vesadrm got merged. It
was then part of each driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Link: https://patch.msgid.link/20260618084327.46567-4-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      |    2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c |    2 +-
 drivers/gpu/drm/sysfb/efidrm.c                |    7 ++++---
 drivers/gpu/drm/sysfb/vesadrm.c               |    6 +++---
 4 files changed, 9 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -50,7 +50,7 @@ struct resource *drm_sysfb_get_memory_si
 int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si,
 			    const struct drm_format_info *format,
 			    unsigned int width, unsigned int height, u64 size);
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size);
 #endif
 
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -71,7 +71,7 @@ int drm_sysfb_get_stride_si(struct drm_d
 }
 EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 
-u64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
+s64 drm_sysfb_get_visible_size_si(struct drm_device *dev, const struct screen_info *si,
 				  unsigned int height, unsigned int stride, u64 size)
 {
 	u64 vsize = mul_u32_u32(height, stride);
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -150,7 +150,8 @@ static struct efidrm_device *efidrm_devi
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize, mem_flags;
+	s64 vsize;
+	u64 mem_flags;
 	struct resource resbuf;
 	struct resource *res;
 	struct efidrm_device *efi;
@@ -204,8 +205,8 @@ static struct efidrm_device *efidrm_devi
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -400,7 +400,7 @@ static struct vesadrm_device *vesadrm_de
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
-	u64 vsize;
+	s64 vsize;
 	struct resource resbuf;
 	struct resource *res;
 	struct vesadrm_device *vesa;
@@ -455,8 +455,8 @@ static struct vesadrm_device *vesadrm_de
 	if (stride < 0)
 		return ERR_PTR(stride);
 	vsize = drm_sysfb_get_visible_size_si(dev, si, height, stride, resource_size(res));
-	if (!vsize)
-		return ERR_PTR(-EINVAL);
+	if (vsize < 0)
+		return ERR_PTR(vsize);
 
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, stride=%d bytes\n",
 		&format->format, width, height, stride);


