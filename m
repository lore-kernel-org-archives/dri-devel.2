Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48DAF3D5FF
	for <dri-devel@archiver.kernel.org>; Sun, 29 Mar 2026 09:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 439AE10E44D;
	Sun, 29 Mar 2026 09:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msuQp7ZQ";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA97D10E004
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 14:14:38 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so27997465e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774707277; x=1775312077; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nwy/UmHbJ5FiDGqALH7aEuXNGDbK1H/xfH3WQB57VvA=;
 b=msuQp7ZQ7REi8DfyllUtO+dhSpNZB5+r40UGJUUZWVQ2v/f9yUGR9HXOJzZPN8U1+B
 72/4JqxNuz7xhDES2+0PyuuN4uL4F80MVMBBuNn0t1zVXlhtAsAQ2L85+ZCg8V516O0k
 uChTvQJGhWd/JkanSorZpXca2ejPumLHsZhijYAH8mmwe7vardVrIsfEohyr4/AHNqnq
 aJTwiacC55eh+LcOjOU9f1tvvvJX3xoyoz8m4/E069ctzAXoyvaVDR72Hj6+nw/CE1NM
 G1ZOtA0LHt8QdIzQdtPA8QScigmYP3EOxNQbHFRm9I67uicg4XvQ4uAriCD/0g3mslpu
 XhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774707277; x=1775312077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nwy/UmHbJ5FiDGqALH7aEuXNGDbK1H/xfH3WQB57VvA=;
 b=MpZNhOWVnDwliDXJUw/T/cT1Ps7AOysQ8XInMrKbluFPu2VaxXWpCqCG2Nux/jQ6vV
 XYf4gxyBKSy6Fd8+9/5QYcFXih1XaZdk8oMzqkMxTJ4bfPCGoWR4SJImZBGohprCrIHN
 +ELXhdwIP6hp2F7goFVUo28GkyYJUe0ZajppdigpXtUoEGRhaQ/R+qPXTokkX01yZqB2
 B44SI9Vee3Vdo9NuytOARp33QiTaVppRgiCwteGmQMTwF70ZR865KmIyFqNcRn5qDrP+
 UT7hMXi7DkXVJZiIbmN6xQ1p5ETOoyD2jNQOIXa4YotvTnhoybi6edDeNLd9+cVDFFB/
 4kUw==
X-Gm-Message-State: AOJu0YziaP/NJJC62jK0hSafD6ISz71f8qGXwyx1Yj2pyWuJnMRPTcIC
 sUbHqZxvx3N2JWJWq2cut7LiJT49wOjiUImKa0eyD/gs7jv3PbWBcgt3pzNDSNxE
X-Gm-Gg: ATEYQzxRqVh+4yB6JOKT/1WG8ghNp5L647MdaiQNhgkwJWjSHIWEKz13H4BebS3w+/g
 2Oc6e3DAvUlMgDFaPTW0XGwxmgt/d8a4FF6WWryA73LxbN7kI+lhv22zFxsS4g6D8Doh8X8V1Py
 M0NQkxh40fygWcpZ9BCxlY3ok7FcCgua2nJTJZiNgwse3uQ+xKCk4EbTmZPnS1/7ALKzNwQBnMQ
 fW3F3YyO+J89gzccGPMJg4QhO+t77/u0aEJvGJzU3n0bf2CtymrN4ZnI9/8QV51xp8Tu54aWvSt
 Z3Eur88EvRyy0T820OIjEghwcwgRBWBRuFl6uj0T9FfUgiypnr1NuNhEkkPwVZmre2vRcktlYuV
 MTZMK8KYejeN1XdKlFBwzC+VAdDKb+aX0sAU3PQhfuI6U41AM1azfqn7ZANRmGUghpeWuf4iNp6
 hOI5pd9NUymHIH6bpoi54Bmq4/D7TuGSXQiWvBn9sjmrdhhl+yERAGKfkCOA==
X-Received: by 2002:a05:600c:1d15:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-48727edf4f5mr100763635e9.26.1774707277018; 
 Sat, 28 Mar 2026 07:14:37 -0700 (PDT)
Received: from rhel.homenet.telecomitalia.it ([87.13.132.253])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48730628efasm80210335e9.5.2026.03.28.07.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 07:14:36 -0700 (PDT)
From: Adriano Vero <litaliano00.contact@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Adriano Vero <litaliano00.contact@gmail.com>
Subject: [PATCH 1/2] drm/edid: populate monitor_range from DisplayID Dynamic
 Video Timing block
Date: Sat, 28 Mar 2026 14:20:26 +0100
Message-ID: <20260328132027.22383-1-litaliano00.contact@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:53:39 +0000
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

Some eDP panels report their VRR limits only via a DisplayID v1r2
Dynamic Video Timing Range Limits block (tag 0x25), without setting
DRM_EDID_FEATURE_CONTINUOUS_FREQ. drm_get_monitor_range() returns
early for such panels, leaving monitor_range zeroed.

Add drm_get_monitor_range_displayid() and call it from
update_display_info() immediately after drm_get_monitor_range(). It
uses displayid_iter_edid_begin() to locate Dynamic Video Timing blocks
and extracts min/max refresh rates, including the 10-bit max_vfreq
encoding signalled by block->rev bits [2:0]. It is a no-op when
monitor_range is already populated by the classic EDID path.

All drivers reading display_info.monitor_range now receive correct VRR
limits from DisplayID-only panels without any raw EDID access.

Byte offsets verified against parse_edid_displayid_vrr() in amdgpu_dm.c.

Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Adriano Vero <litaliano00.contact@gmail.com>
---
 drivers/gpu/drm/drm_edid.c | 68 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index ff432ac6b..d2c360178 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6504,6 +6504,71 @@ void get_monitor_range(const struct detailed_timing *timing, void *c)
 	}
 }
 
+/**
+ * drm_get_monitor_range_displayid - populate monitor_range from a
+ * DisplayID v1r2 Dynamic Video Timing Range Limits block (tag 0x25).
+ *
+ * Some eDP panels report their VRR limits only in a DisplayID block,
+ * without setting DRM_EDID_FEATURE_CONTINUOUS_FREQ. drm_get_monitor_range()
+ * returns early for such panels, leaving monitor_range zeroed. This
+ * function is called separately from update_display_info() as a fallback.
+ *
+ * Block payload layout (block->num_bytes == 9):
+ *   data[6]       min_vfreq in Hz
+ *   data[7]       max_vfreq low 8 bits
+ *   data[8][1:0]  max_vfreq high bits (when block->rev & 7 is nonzero)
+ *
+ * Byte offsets verified against parse_edid_displayid_vrr() in amdgpu_dm.c.
+ */
+static void
+drm_get_monitor_range_displayid(struct drm_connector *connector,
+				const struct drm_edid *drm_edid)
+{
+	struct drm_display_info *info = &connector->display_info;
+	const struct displayid_block *block;
+	struct displayid_iter iter;
+
+	/* Only run when the classic EDID path left these zeroed */
+	if (info->monitor_range.min_vfreq && info->monitor_range.max_vfreq)
+		return;
+
+	displayid_iter_edid_begin(drm_edid, &iter);
+	displayid_iter_for_each(block, &iter) {
+		const u8 *data;
+		u16 min_vfreq, max_vfreq;
+
+		if (block->tag != DATA_BLOCK_2_DYNAMIC_VIDEO_TIMING)
+			continue;
+
+		/* rev bits [7:1] must be zero; payload must be exactly 9 bytes */
+		if ((block->rev & 0xFE) != 0 || block->num_bytes != 9)
+			continue;
+
+		data = (const u8 *)(block + 1);
+
+		min_vfreq = data[6];
+
+		/* rev bits [2:0] nonzero: max_vfreq is 10-bit */
+		if (block->rev & 7)
+			max_vfreq = data[7] | ((u16)(data[8] & 3) << 8);
+		else
+			max_vfreq = data[7];
+
+		if (!min_vfreq || !max_vfreq)
+			continue;
+
+		info->monitor_range.min_vfreq = min_vfreq;
+		info->monitor_range.max_vfreq = max_vfreq;
+
+		drm_dbg_kms(connector->dev,
+			    "[CONNECTOR:%d:%s] DisplayID dynamic video timing range: %u-%u Hz\n",
+			    connector->base.id, connector->name,
+			    min_vfreq, max_vfreq);
+		break;
+	}
+	displayid_iter_end(&iter);
+}
+
 static void drm_get_monitor_range(struct drm_connector *connector,
 				  const struct drm_edid *drm_edid)
 {
@@ -6691,10 +6756,9 @@ static void update_display_info(struct drm_connector *connector,
 	info->height_mm = edid->height_cm * 10;
 
 	drm_get_monitor_range(connector, drm_edid);
-
+	drm_get_monitor_range_displayid(connector, drm_edid);
 	if (edid->revision < 3)
 		goto out;
-
 	if (!drm_edid_is_digital(drm_edid))
 		goto out;
 
-- 
2.47.3

