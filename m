Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5394FC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6023310F393;
	Thu, 16 Jul 2026 16:07:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MD3OjAY8";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9644210F36B;
 Thu, 16 Jul 2026 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=Z7nNq9lLK+w9Z+e1sxK+eA5MYoTrZRPzvFVVcsZGLaE=; b=
 MD3OjAY8a3w0bF7eF/5dBzK622IdFY9HF1qec69RLyYvVbY4cefsG18CUmDnWscHckeYwF7oRfLHV
 4evY8IIPB6e49qMu6AtLVQL8QN9cRdq261D1UQpNOSIIrDkJ4QHK+XiARwEOPmVCrM1t7z9wOZ2xu
 onSFtwU78wMKAl3SUgVfTmgRZZ6D0zFoWUHN4ZY/vqj0FTSs2EKp527HBkOXJqPTdXUxLch+uCgfu
 ZIQJ3kRFqtK8hTjzhPgMXQPU4VhD45sv8rcq+TSgypmCrFlkmBj6s/VHSsHiZUYx7nEsvOtDdPm6K
 9651vm73QYrGBB94j5PZ2MJM04TCZ439nA==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObk-00G01i-Bb; Thu, 16 Jul 2026 18:06:44 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 "Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
 Alex Hung <alex.hung@amd.com>, Simon Ser <contact@emersion.fr>,
 Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 12/20] drm: Add helper to extract a 3x4 matrix from any
 CTM matrix dimensions
Date: Thu, 16 Jul 2026 18:03:09 +0200
Message-ID: <20260716160556.227556-13-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
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

From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>

Add a common helper to ease the conversion from both 3x3 or 3x4 matrices
to a CTM 3x4 matrix. This is handy for code that needs to handle both
dimensions.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 include/drm/drm_color_mgmt.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 5140691f476a..51279267ed3f 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -66,6 +66,40 @@ static inline u32 drm_color_lut32_extract(u32 user_input, int bit_precision)
 				     (1ULL << 32) - 1);
 }
 
+/**
+ * drm_color_ctm_to_ctm_3x4 - Copy CTM matrix contents to 3x4 dimensions matrix
+ *
+ * @dest: The destination CTM 3x4 dimensions matrix
+ * @src: The source CTM matrix (3x3 or 3x4 dimensions depending on @ctm_3x4)
+ * @ctm_3x4: Boolean indicating the source CTM matrix dimensions
+ *
+ * Copy the contents of a CTM matrix from @src, to a CTM 3x4 dimensions matrix.
+ * The source matrix can be 3x3 or 3x4 dimensions depending on the @ctm_3x4
+ * boolean argument.
+ */
+static inline void drm_color_ctm_to_ctm_3x4(struct drm_color_ctm_3x4 *dest,
+					    void *src, bool ctm_3x4)
+{
+	if (ctm_3x4) {
+		*dest = *(struct drm_color_ctm_3x4 *)src;
+	} else {
+		struct drm_color_ctm *ctm = (struct drm_color_ctm *)src;
+
+		dest->matrix[0] = ctm->matrix[0];
+		dest->matrix[1] = ctm->matrix[1];
+		dest->matrix[2] = ctm->matrix[2];
+		dest->matrix[3] = 0;
+		dest->matrix[4] = ctm->matrix[3];
+		dest->matrix[5] = ctm->matrix[4];
+		dest->matrix[6] = ctm->matrix[5];
+		dest->matrix[7] = 0;
+		dest->matrix[8] = ctm->matrix[6];
+		dest->matrix[9] = ctm->matrix[7];
+		dest->matrix[10] = ctm->matrix[8];
+		dest->matrix[11] = 0;
+	}
+}
+
 u64 drm_color_ctm_s31_32_to_qm_n(u64 user_input, u32 m, u32 n);
 
 void drm_crtc_enable_color_mgmt(struct drm_crtc *crtc,
-- 
2.53.0

