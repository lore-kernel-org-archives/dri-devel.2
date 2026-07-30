Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02648C54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2740110E0D9;
	Thu, 30 Jul 2026 01:45:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="pmvUDSNY";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BC710E0D9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=31
 ighRi8aQ4WlZtGE99myZmDJwJ9xfAY8cV/6j/n0lQ=; b=pmvUDSNYFH6OG++oqx
 h8nrqqlDknb7m0QM5DxTzbaeoKmNSVDVa45k2VO1i2cYoCxCaEEMotnQLGmCh8Oy
 iuPhBhIK8a9S09+OMMN/X8tDMv2wgMrk39zg162XjnBGR81WgajanjZystSk12es
 ALK9pfD/Wc9OlTH/lTEvymPtw=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD30QuJrGpqUpb_Kw--.23314S2; 
 Thu, 30 Jul 2026 09:44:44 +0800 (CST)
From: oushixiong1025@163.com
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v3] drm/log: Fix division by zero when scale module parameter
 is 0
Date: Thu, 30 Jul 2026 09:44:40 +0800
Message-Id: <20260730014440.66323-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD30QuJrGpqUpb_Kw--.23314S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3Zr1kZw1rKw48WF17ZFb_yoWkGrg_WF
 4fXr9xWr4DCwna93W5CF1xtr9YkF909ws5Jr1DtFy3J3s7ZrZrCryqgFn3ZF1DK3W0kr9I
 va4DWr1xA3Z7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8a0PDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-QyDkmpqrIw2fgAA3I
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

From: Shixiong Ou <oushixiong@kylinos.cn>

The scale module parameter can be set to 0 via kernel command line.
When scale is 0, scaled_font_h and scaled_font_w become 0, causing
a division by zero in the rows/columns calculation.

Since the scale module parameter is read-only (0444 permissions), it
cannot be changed at runtime via sysfs. Clamp it to 1 once in
drm_log_register().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v2->v3:
   Clamp scale once in drm_log_register() instead of introducing a
   drm_log_scale() helper, since scale is read-only at runtime.

v1->v2:
   Introduce a drm_log_scale() helper.

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 294b3be1a6b3..46004abd4e61 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -424,6 +424,9 @@ void drm_log_register(struct drm_device *dev)
 {
 	struct drm_log *new;
 
+	if (!scale)
+		scale = 1;
+
 	new = kzalloc_obj(*new);
 	if (!new)
 		goto err_warn;
--
2.25.1

No virus found
		Checked by Hillstone Network AntiVirus

