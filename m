Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5710EE7E350
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 08:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7391210F43C;
	Fri,  3 Apr 2026 08:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbOEHNWn";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BEED10EE46
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 23:07:41 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488879b2e6aso1607895e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 16:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775084860; x=1775689660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gplhIhka30fCTHztnccDVASgUT+mUdExnrkX1KszwRQ=;
 b=SbOEHNWn541bUkP1Tj9bpi+EDTKQmWbetWpvs0vtBG6cKGV10N99bqfB2l4SvQlXCt
 qI7V22xG9XiaBRXLCnfXiRUS34yGLaeFk9Sh7hjBZkRDbUN2HE8OeqDoafnCa2lWS+dP
 6tZ5NcXm+EVV8hij8o7gFGKRX8x32IH9ooH22GguKWWDYGonFHoZ9KLo/syZh2kpTDPL
 VBzvIw5/gtSn8g86eCcAB1jpFk6JRlfpXxjg5qsxEzpXZK3T1xkqHzNV46CIdSXOgU8n
 8iNVaFNm/StdYMbbWSYp3bf8mORzeERtHfcSBoAa41zY+PbCExqJg8zKjVEkhn7RFvns
 Anlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775084860; x=1775689660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gplhIhka30fCTHztnccDVASgUT+mUdExnrkX1KszwRQ=;
 b=cffMgdYwuHtvLFsz2RheXoT36xIIAncf2vS/l/CTk6rEmL+AnrmzrXY4FeDvGVs/rj
 DioZoXeVBF0PTtCSfp4DPCRCmdzoDQKDHcUunedLc72w0rn5DxKsNlokcyOXIxwkKt2t
 eAZBIy+8kv93nSEmLtyQkwnTyteO5Tvh7rSX/Xn4jERjV9IfEyl/o3WULm6muWXWAEO3
 Cnyo5MBetCia04F5sXFn9aEdwTsZ7a5iATXf40abUgURgAbC6hRF2zdxvxD9avtuCWNu
 8XtO6UKD8i9quuoTmhZ71LY5NBBi1njI77EgE17rFa0NIoNgz4bOLUvclVaODtgdQjMS
 7sGA==
X-Gm-Message-State: AOJu0YwfN2MN0qn3nOqJ+s8KFvV3YodXbtuA8/9DkGs5sD3xBSaQP8bU
 bxqJc/4UbBmbvAB4pPceMBU7SNQv6xxEVfcoLM+7WJuC3yrj+B3O/s3LT+XqyYOg
X-Gm-Gg: ATEYQzwNnSP872rA+HlzqwceV6nCOMJeTJJlO0ktgU8ZAQ8eJ7Vcwi07Svl7HqLE5Lr
 p8qs90KRfv6u/QMFEN0TCcJnk1rPjzJaxzRXAo46rbEYgQuFPwLB204Zerr7gx+Tt7Ns7NPaObj
 qCEoNoEZsBNdZ0i0820PtOcaWGX6Y101sUqPfLBbEzzG5hKh9bNLs/qrdEI+GVVsejbyvVKOUXP
 M3FHPpo8eCe7yFxw1c4Fbr+DcRmUZ6B0SohLJr+v2M9Z2DtiwmHE3ANyc4tAlIj0GRZC95FXzvm
 /eNGxRmhycUlFECgUvb70K96gGj3nasP9+mAFc+lv2HYPayrgjnAi3Lhd+dWDZIfKN530kCd/J4
 QM+7US0rAnfLj13QE1kyZFDElcacqWs+Ro4oaNCEHc2sg7sxcH1/L60zc0JA4k6pWJhb2MG53ZO
 S5PGSUo3K8vvLB4nXy7DfUZPMrXw5oCTJghmzWPhDwMcFQrUFgujN9ylxWGQ==
X-Received: by 2002:a05:600c:e40b:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-4888355df67mr68048095e9.4.1775084859578; 
 Wed, 01 Apr 2026 16:07:39 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it ([87.13.132.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887ad1cd86sm53682845e9.5.2026.04.01.16.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 16:07:39 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] drm/edid: populate monitor_range from DisplayID v2r0
 Dynamic Video Timing block
Date: Thu,  2 Apr 2026 01:07:24 +0200
Message-ID: <20260401230735.4866-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260328132027.22383-1-litaliano00.contact@gmail.com>
References: <20260328132027.22383-1-litaliano00.contact@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Apr 2026 08:59:17 +0000
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

Some eDP panels report their VRR limits only via a DisplayID v2r0
Dynamic Video Timing Range Limits block (tag 0x25), without setting
DRM_EDID_FEATURE_CONTINUOUS_FREQ, causing monitor_range to remain
zeroed after drm_get_monitor_range().

Add displayid_is_dynamic_video_timing_block() and
displayid_parse_dynamic_video_timing(), following the pattern of
displayid_is_tiled_block(), to separate block identification from
parsing. Add a __packed struct for the block payload. Call
drm_get_monitor_range_displayid() from update_display_info() near
drm_update_mso().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603300847.vflE6oJO-lkp@intel.com/
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 drivers/gpu/drm/drm_displayid_internal.h | 14 +++++
 drivers/gpu/drm/drm_edid.c               | 67 +++++++++++++++++++++++-
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
index 5b1b32f73..5988e9b89 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -145,6 +145,20 @@ struct displayid_formula_timing_block {
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
 
+/*
+ * DisplayID v2r0 §4.9 - Dynamic Video Timing Range Limits Block
+ * num_bytes must be 9, rev bits [7:1] must be zero.
+ * When rev bits [2:0] are nonzero, max_vfreq is a 10-bit value
+ * formed by max_vfreq_lo and bits [1:0] of max_vfreq_hi_flags.
+ */
+struct displayid_dynamic_video_timing_block {
+	struct displayid_block base;
+	u8 reserved[6];
+	u8 min_vfreq;
+	u8 max_vfreq_lo;
+	u8 max_vfreq_hi_flags;
+} __packed;
+
 struct displayid_vesa_vendor_specific_block {
 	struct displayid_block base;
 	u8 oui[3];
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ff432ac6b..24aa37bea 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6504,6 +6504,70 @@ void get_monitor_range(const struct detailed_timing *timing, void *c)
 	}
 }
 
+static bool
+displayid_is_dynamic_video_timing_block(const struct displayid_iter *iter,
+					const struct displayid_block *block)
+{
+	return displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
+		block->tag == DATA_BLOCK_2_DYNAMIC_VIDEO_TIMING;
+}
+
+static void
+displayid_parse_dynamic_video_timing(struct drm_connector *connector,
+				     const struct displayid_block *block)
+{
+	const struct displayid_dynamic_video_timing_block *dvt =
+		(const struct displayid_dynamic_video_timing_block *)block;
+	struct drm_display_info *info = &connector->display_info;
+	u16 min_vfreq, max_vfreq;
+
+	/* Already populated from classic EDID descriptor */
+	if (info->monitor_range.min_vfreq && info->monitor_range.max_vfreq)
+		return;
+
+	/* Specification requires exactly 9 payload bytes */
+	if (block->num_bytes != 9)
+		return;
+
+	/* Specification requires rev bits [7:1] to be zero */
+	if (block->rev & 0xFE)
+		return;
+
+	min_vfreq = dvt->min_vfreq;
+
+	/* rev bits [2:0] nonzero: max_vfreq is a 10-bit value */
+	if (block->rev & 0x07)
+		max_vfreq = dvt->max_vfreq_lo | ((u16)(dvt->max_vfreq_hi_flags & 0x3) << 8);
+	else
+		max_vfreq = dvt->max_vfreq_lo;
+
+	if (!min_vfreq || !max_vfreq)
+		return;
+
+	info->monitor_range.min_vfreq = min_vfreq;
+	info->monitor_range.max_vfreq = max_vfreq;
+
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] DisplayID dynamic video timing range: %u-%u Hz\n",
+		    connector->base.id, connector->name,
+		    min_vfreq, max_vfreq);
+}
+
+static void
+drm_get_monitor_range_displayid(struct drm_connector *connector,
+				const struct drm_edid *drm_edid)
+{
+	const struct displayid_block *block;
+	struct displayid_iter iter;
+
+	displayid_iter_edid_begin(drm_edid, &iter);
+	displayid_iter_for_each(block, &iter) {
+		if (displayid_is_dynamic_video_timing_block(&iter, block))
+			displayid_parse_dynamic_video_timing(connector, block);
+	}
+	displayid_iter_end(&iter);
+}
+
 static void drm_get_monitor_range(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
@@ -6691,10 +6755,8 @@ static void update_display_info(struct drm_connector *connector,
 	info->height_mm = edid->height_cm * 10;
 
 	drm_get_monitor_range(connector, drm_edid);
-
 	if (edid->revision < 3)
 		goto out;
-
 	if (!drm_edid_is_digital(drm_edid))
 		goto out;
 
@@ -6757,6 +6819,7 @@ static void update_display_info(struct drm_connector *connector,
 		info->color_formats |= DRM_COLOR_FORMAT_YCBCR422;
 
 	drm_update_mso(connector, drm_edid);
+	drm_get_monitor_range_displayid(connector, drm_edid);
 
 out:
 	if (drm_edid_has_internal_quirk(connector, EDID_QUIRK_NON_DESKTOP)) {
-- 
2.47.3

