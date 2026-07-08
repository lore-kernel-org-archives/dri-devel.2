Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7627C44506
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 19:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D433B10E663;
	Wed,  8 Jul 2026 19:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="kL8PxL5Y";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FF410F278;
 Wed,  8 Jul 2026 19:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VKSrdgcaQ2t3VcbsZUUWHukOs2eulpMLQGxwH2uEukw=; b=kL8PxL5YdL3OHyr9wMyU91xhcz
 PkROQuwGsoM7m2TckbSRTu+TZ6XoeB8m0ECUjvwsoSn+ACwL7Z5IFiV7PiPiXGYYmx9IDstlp2c/P
 1WsLcTo3RBOgTCQfJ4NLE76DYH++21oHsvBtR7hn9RG2wFVLvuz9m6lizhfr2ygVnI7NvywdkvsQ9
 pNYuSMiSQJDDJXkYxVt1qN2PECG0BWUQGpGX+xao87DeNS0+RI50C4Uyn+M78DY9wW+ZsWqBR3EZd
 yGvniZFhwm5mEMAGbfLH6E46jjl2Rxs4B34IKlZy4hi14sQoFWTuNIq3pMkUJVTWURC4E9IHmNDQ1
 YRYBeEXw==;
Received: from 100.red-79-144-92.dynamicip.rima-tde.net ([79.144.92.100]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1whYC6-00BtrH-7d; Wed, 08 Jul 2026 21:44:31 +0200
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
 John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 12/19] drm: Add helper to extract a LUT entry from either
 16-bit or 32-bit LUT
Date: Wed,  8 Jul 2026 21:37:27 +0200
Message-ID: <20260708194343.2578387-13-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708194343.2578387-1-mwen@igalia.com>
References: <20260708194343.2578387-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a common helper to ease extracting a 32-bit LUT entry from either
16-bit or 32-bit LUT entry. This is handy for code that needs to handle
both bit widths.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Co-developed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 include/drm/drm_color_mgmt.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 51279267ed3f..3d0117aae342 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -66,6 +66,33 @@ static inline u32 drm_color_lut32_extract(u32 user_input, int bit_precision)
 				     (1ULL << 32) - 1);
 }
 
+/**
+ * drm_color_lut_to_lut32 - Copy LUT entry contents to 32-bit channel color LUT
+ *
+ * @dest: The destination 32-bit per channel color LUT entry
+ * @src: The source array of LUT entries (16-bit or 32-bit depending on @bits32)
+ * @index: LUT entry array index
+ * @bits32: Boolean indicating the source LUT entry bit-witdh
+ *
+ * Copy the contents of a LUT entry from the source array, to a 32-bit channel
+ * color LUT. The source array of LUT entries can be 16-bit or 32-bit width
+ * depending on the @bits32 boolean argument.
+ */
+static inline void drm_color_lut_to_lut32(struct drm_color_lut32 *dest,
+					  void *src, int index, bool bits32)
+{
+	if (bits32) {
+		*dest = ((struct drm_color_lut32 *)src)[index];
+	} else {
+		struct drm_color_lut *lut =
+			&((struct drm_color_lut *)src)[index];
+		dest->red = lut->red;
+		dest->green = lut->green;
+		dest->blue = lut->blue;
+		dest->reserved = lut->reserved;
+	}
+}
+
 /**
  * drm_color_ctm_to_ctm_3x4 - Copy CTM matrix contents to 3x4 dimensions matrix
  *
-- 
2.53.0

