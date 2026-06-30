Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA05C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F73310E981;
	Tue, 30 Jun 2026 08:43:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="BaPycrm8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A5110E981;
 Tue, 30 Jun 2026 08:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782808995; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VHAMUoWtmMhpc06Nw1/FdZnm2hZcoJw0Wyo96nCvRZdafwSqJXws1pzbNWYtlhg0+vQgMXW1jjPZl9pmucERSFsTJA+09+ePp7D6Xov1iZclpGwiAyDKOWKMg0rBxahclBqlBfSo5OyuYJKlI6Znp7t0sO/MazYvvTrbNV3jQYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782808995;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=dho6eaKW6g4mq9zlGSqLgonoD5ZztOjMKvpGLJ2w9eg=; 
 b=D0oMROKsyIapPK3u8Z9r6WAATF5n1F5pKlRvFM6tfI5X2hfPssb1eM+PuMFmaPMJw22gpf+B5q7EB/PNLfN8GHwSChPtmdmjnLH+DJgFIN+hwLA/hOkPizlSQfi7gcHSrJJbPIZd3vThyDAcbFCEPXBEmAceNkRoeqGlpUzufrI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782808995; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=dho6eaKW6g4mq9zlGSqLgonoD5ZztOjMKvpGLJ2w9eg=;
 b=BaPycrm8eeKs4a7YKk9YTkt4WA7DW2X46m0rk39FGujcAUiuLsW4D0wflPT7XFqk
 DOVY44nXwlpoUUpr+5anY37aaDsyo3blUJ1B9e78z498EaSdBwfrnv+N3f1++GzCDko
 PCpK5hxpLLkd7ZEvh+VGdOmJ9gClgauBmoOQ9KcE=
Received: by mx.zohomail.com with SMTPS id 1782808994187223.04701426459064;
 Tue, 30 Jun 2026 01:43:14 -0700 (PDT)
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
Subject: [PATCH v1 2/4] drm/amdgpu: Add DRIVER_PLANE_COLOR_PIPELINE driver
 feature
Date: Tue, 30 Jun 2026 10:42:27 +0200
Message-ID: <20260630084229.529682-3-robert.mader@collabora.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1781c0c3d010..87e676abe151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3083,7 +3083,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ |
-	    DRIVER_SYNCOBJ_TIMELINE,
+	    DRIVER_SYNCOBJ_TIMELINE | DRIVER_PLANE_COLOR_PIPELINE,
 	.open = amdgpu_driver_open_kms,
 	.postclose = amdgpu_driver_postclose_kms,
 	.ioctls = amdgpu_ioctls_kms,
-- 
2.54.0

