Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44682C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A7A10F373;
	Thu, 16 Jul 2026 16:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fNEaXoLb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B676E10E596;
 Thu, 16 Jul 2026 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=3keGy35/vbpaTq8L7yU1Q8SyRrmA1TIJh1qN1u58y2g=; b=fNEaXoLbbaOLxG2Ko3WEWwXiSt
 RcXG6oSeqC1XNN42CWTHCIBwK4phnKzrOp/kXLI473QMBSixwl11mztJYW4Dz4Xdjcw8uOjsJu1jt
 hpuXXHYj8e3zwURLJ6yHO/Co+ApoXwTdyqtwlac4R6P2R8JS8nmUlMw3lHMWAT+AcnOjkOC1jAN8Z
 NPzfX/r9wPoQ0WMSQD1wCSC0i8Ktdonp/yAyy6wI4SNYGk4Q/xCTV8h9O5ZKohhsBCUJKqe9hVg2e
 o5c4GpnTXmJ55+l9zPyddP4DchyEzKVOl+pAWUb++8lsz4NujakWK4+tTQNrQLYLsNOAApKKg9/U3
 xEoggmVQ==;
Received: from [178.139.170.72] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wkObB-00G01i-05; Thu, 16 Jul 2026 18:06:09 +0200
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
 Louis Chauvet <louis.chauvet@bootlin.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 01/20] drm/crtc: Add color pipeline to CRTC state
Date: Thu, 16 Jul 2026 18:02:58 +0200
Message-ID: <20260716160556.227556-2-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716160556.227556-1-mwen@igalia.com>
References: <20260716160556.227556-1-mwen@igalia.com>
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

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Add a color pipeline to the CRTC state to allow post-blend color
pipelines.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 include/drm/drm_crtc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index 152349f973e3..30afa05b7c0f 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -274,6 +274,14 @@ struct drm_crtc_state {
 	 */
 	struct drm_property_blob *gamma_lut;
 
+	/**
+	 * @color_pipeline:
+	 *
+	 * The first colorop of the active color pipeline, or NULL, if no
+	 * color pipeline is active.
+	 */
+	struct drm_colorop *color_pipeline;
+
 	/**
 	 * @background_color:
 	 *
-- 
2.53.0

