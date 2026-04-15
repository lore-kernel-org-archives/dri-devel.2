Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5529F8A147
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 08:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD8C10E845;
	Thu, 16 Apr 2026 08:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=metarealtyinc-ca.20251104.gappssmtp.com header.i=@metarealtyinc-ca.20251104.gappssmtp.com header.b="K+Xe7zoN";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F272410E226
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 13:06:32 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-8c6f21c2d81so507848485a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metarealtyinc-ca.20251104.gappssmtp.com; s=20251104; t=1776258392;
 x=1776863192; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjPmFnZ3ltIWGyywLfHNdU76wOgW6psantaHXQ/II4o=;
 b=K+Xe7zoNRu+e1trCX8cBigbG2i+SuXKh6e9Jz9T9kJIkQuAdMVSlNUGTfqE4zxCeuE
 hp8c8TqmlIqYlO+Rb9DOJZe4qQzo9HDlS7m3S+0W8mDyhDPN++GO3pi9OYQYZm/2Webk
 v99og+cNgQH7pIUYFwRh34uq/TgQqh5AWkLlyf1X5KPm5PolyW3zaxIttgXDmmKHrHHC
 781Zzk6h4zx3RaFXfMuUZ4aO1O+do7NVEkveaJFimt5kB96WIu50h6YwP9wMHTWUoKMw
 1xsMMYYSD+trosp9s3/PhU38AXeFJjmvyamO7p4JghLzxpEdNdgQW8h9R1l1juMag9YU
 FgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776258392; x=1776863192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AjPmFnZ3ltIWGyywLfHNdU76wOgW6psantaHXQ/II4o=;
 b=Ckii2BvCoklWs7xplC5p4AHeY/FovK43yOLMUWg65lSqLejR/wyXGXTjX4cfTjC9eY
 nxyoSXg32FCj79MS6bmufLTdckzs7eDyS7yfCu6MA7XF1owBJMDNx/QuUJuSPbrnPauL
 SZ+bpXazjqVDECbNhGFkbdgq3/0P0u+0vPjL6RUhjaZHpGfPTpSz/eQA30z/vnbueFhR
 i2SM2o0wAmAkb3cwEN6SHisi2V7VkVjwzITuGuwi8A43q3OmoXcAmAUYi8iKG16WgwIM
 QPIPjx4FZhMqta7v7/yuzCvACvA7xQN3gvTe8Nlj7mSRsN9LMND01Tfa58zMtvged55B
 Lepg==
X-Gm-Message-State: AOJu0Yz0d1O9V0yeVJ5hUR0A99jvdak+/2337vAMN0IFV8dNN6vgmZMc
 Hq/fjm2T3xcbihWJYUW17uFICRgPeADr7rpQP55PZFaRD6/8un+YiK/MUGCQlKYFfVY=
X-Gm-Gg: AeBDievetJfIyMKfUifqt8rYN5LoN8nE9ASt/Bl3uNoFuhdrfNXCsvwnfGhDluxFmRH
 zPkWz+M4PdKO1j2hhcSHcf82uRjQ4KoB+RvELz4EN2y93Scu159aIolt5L/MsCOgKUL8V973QaK
 1/WUbwpa4yyc7RB+T91M9V7Gf9IezqP9ihP3WePK+C8Oc7xk3WVw/f8dtFuLzEtzhQnMiCmemIo
 NMwP6MUCpTKMe9Z7z9Gq5hKB0chH5bI+i7Q65spqVxD2ZYjhc6s4PT7vO1UtsJ6CAzxVdGFBxpN
 iB4i5lG8ZX3If2ymYHNW57wXa1BCzGgTZYOiF4Rsq5EDm3R2bT695+dWGtvLwVF1vmnRND46eBB
 WQWyjIRKBUVBPsNtQlvUht8XCV+qBsBn2sCdE+v9H8W4saBsiBBLRB6uQiZohBsP/1aLclhkL4b
 Y+ZwkzwuY6V7Kjy3FdeUn1gmvIuiw3R/4fnCDZwUEHJIakLj29CKg19pZhMgqFnu0lZ65wil/OZ
 1jt075w5hglP/Nmg8Z9NOjd5EaPRhom4bzVLmXaa5Q=
X-Received: by 2002:a05:620a:290d:b0:8c6:ff8f:58af with SMTP id
 af79cd13be357-8ddcf7ab003mr3225225285a.51.1776258391861; 
 Wed, 15 Apr 2026 06:06:31 -0700 (PDT)
Received: from jake-laptop ([2607:fea8:e5:500:8e39:827f:e928:9eb7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4f31f95f9sm125192385a.43.2026.04.15.06.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 06:06:30 -0700 (PDT)
From: Jake S <j@metarealtyinc.ca>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, rodrigo.vivi@intel.com,
 Jake S <j@metarealtyinc.ca>
Subject: [PATCH 1/2] drm/edid: populate monitor_range from DisplayID Adaptive
 Sync block
Date: Wed, 15 Apr 2026 09:06:25 -0400
Message-ID: <20260415130626.10523-2-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415130626.10523-1-j@metarealtyinc.ca>
References: <20260415130626.10523-1-j@metarealtyinc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:39:27 +0000
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

The DRM EDID parser only reads monitor range (min/max vfreq) from the
base EDID Display Range Limits descriptor (tag 0xFD). Many modern eDP
OLED panels ship with a DisplayID v2.0 extension containing an Adaptive
Sync Data Block (tag 0x2B) that declares the VRR range, but no base
EDID range limits descriptor at all.

This leaves info->monitor_range zeroed on Intel/Nouveau/etc, while
amdgpu has a private workaround (parse_edid_displayid_vrr). Add generic
drm_get_monitor_range_displayid() so all drivers benefit.

Handles both tag 0x2B (Adaptive Sync, CTA-861.6) and tag 0x25 (Dynamic
Video Timing Range Limits, DisplayID v2.0 section 4.5).

Only fills in monitor_range as a fallback when the base EDID parsing
found nothing, preserving existing behavior for panels with proper Range
Limits descriptors.

Tested on Dell XPS 2026 (Intel Panther Lake, LG Display OLED eDP,
3200x2000, VRR 20-120Hz via DisplayID tag 0x2B).

Signed-off-by: Jake S <j@metarealtyinc.ca>
---
 gpu/drm/drm_edid.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/gpu/drm/drm_edid.c b/gpu/drm/drm_edid.c
index 68390e7..ebefd18 100644
--- a/gpu/drm/drm_edid.c
+++ b/gpu/drm/drm_edid.c
@@ -6567,6 +6567,57 @@ static void drm_get_monitor_range(struct drm_connector *connector,
 		    info->monitor_range.min_vfreq, info->monitor_range.max_vfreq);
 }
 
+/*
+ * Parse DisplayID v2.0 Adaptive Sync Data Block (tag 0x2B) as a fallback
+ * when the base EDID has no Range Limits descriptor. Many modern eDP OLED
+ * panels only advertise their VRR range via DisplayID, not base EDID.
+ *
+ * Also handles tag 0x25 (Dynamic Video Timing Range Limits).
+ */
+static void drm_get_monitor_range_displayid(struct drm_connector *connector,
+					    const struct drm_edid *drm_edid)
+{
+	struct drm_display_info *info = &connector->display_info;
+	const struct displayid_block *block;
+	struct displayid_iter iter;
+
+	if (info->monitor_range.min_vfreq && info->monitor_range.max_vfreq)
+		return;
+
+	displayid_iter_edid_begin(drm_edid, &iter);
+	displayid_iter_for_each(block, &iter) {
+		const u8 *data = (const u8 *)block + sizeof(*block);
+		int len = block->num_bytes;
+		u16 min_vfreq, max_vfreq;
+
+		if (block->tag == 0x2b && len >= 6) {
+			/* Adaptive Sync Data Block (CTA-861.6) */
+			min_vfreq = data[2];
+			max_vfreq = data[3] | ((u16)(data[4] & 0x3) << 8);
+		} else if (block->tag == DATA_BLOCK_2_DYNAMIC_VIDEO_TIMING &&
+			   len >= 6) {
+			/* Dynamic Video Timing Range Limits (DisplayID v2.0) */
+			int offset = ((data[0] >> 3) & 0x3) ? 5 : 3;
+
+			if (len < offset + 3)
+				continue;
+			min_vfreq = data[offset];
+			max_vfreq = data[offset + 1] |
+				    ((u16)(data[offset + 2] & 0x3) << 8);
+		} else {
+			continue;
+		}
+
+		if (max_vfreq && min_vfreq && max_vfreq > min_vfreq) {
+			info->monitor_range.min_vfreq = min_vfreq;
+			info->monitor_range.max_vfreq = max_vfreq;
+			break;
+		}
+	}
+	displayid_iter_end(&iter);
+}
+
+
 static void drm_parse_vesa_specific_block(struct drm_connector *connector,
 					  const struct displayid_block *block)
 {
@@ -6756,6 +6807,8 @@ static void update_display_info(struct drm_connector *connector,
 
 	drm_get_monitor_range(connector, drm_edid);
 
+	drm_get_monitor_range_displayid(connector, drm_edid);
+
 	if (edid->revision < 3)
 		goto out;
 
-- 
2.53.0

