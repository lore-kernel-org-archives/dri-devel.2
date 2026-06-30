Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4EAC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1DB10EBA5;
	Tue, 30 Jun 2026 08:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="JreTj6T8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9476910EAB6;
 Tue, 30 Jun 2026 08:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782809001; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dpeSZUqWu9VeVkqC+4CiwXRICbALPa1Tfqd/ZfdhGNTX0v3qLmkIm/qA0a0zaNQPluRoXatNgBWNKGEUnwvYQoqLqyv2POj6dswGLNO7pvdW5RULUW9OEj/nk8I8hBkwC2kd+OkEGgl9nmmPDHdNBFffMnvFFlpbx2ohpRR+SqY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782809001;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Q8f2EsqKLRe+tQXLFAig19c9Q5xOO/Wt20rxfXGTR/A=; 
 b=cusNpiCVda7n36kOUGW4DNN9+HFq2IzQXukXbPq0VglwiIXUKcflWglvuyKaIp+jOeeAmQUJNDRC4pMT5JKa3gPCuGUakSngHI/BYm/O9EFNjDjcCKs8SOdcq05xFGgxGJTIpaqHKoHShlh3pJbGXFzIVPlxA8XWdYHpeIohT00=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782809001; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Q8f2EsqKLRe+tQXLFAig19c9Q5xOO/Wt20rxfXGTR/A=;
 b=JreTj6T8tJz5wDSFzR5JaRy1dygg1dTg17T6ZQ523Pyz3s8cvD9QGQFzeCf4KZh/
 Kz8vzW1+ohmml0IIpzpZAIxtHiLJ/TM48CVW+hpApgGszLjohG7lnUtLq1sYD2dvPsl
 C2bPBoRWj8vIPzy+HKQa5ib7Shp/SyMvNm8SqA70=
Received: by mx.zohomail.com with SMTPS id 1782808999164311.43609918761;
 Tue, 30 Jun 2026 01:43:19 -0700 (PDT)
From: Robert Mader <robert.mader@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Robert Mader <robert.mader@collabora.com>
Subject: [PATCH v1 3/4] drm/i915: Add DRIVER_PLANE_COLOR_PIPELINE driver
 feature
Date: Tue, 30 Jun 2026 10:42:28 +0200
Message-ID: <20260630084229.529682-4-robert.mader@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630084229.529682-1-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
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

Which is now required for DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE.

Signed-off-by: Robert Mader <robert.mader@collabora.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index f06b2e8cf7d4..346b3a45d0d8 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1875,7 +1875,7 @@ static const struct drm_driver i915_drm_driver = {
 	.driver_features =
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
-	    DRIVER_SYNCOBJ_TIMELINE,
+	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_PLANE_COLOR_PIPELINE,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
 	.postclose = i915_driver_postclose,
-- 
2.54.0

