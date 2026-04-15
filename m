Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AEBF41986
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE13510E6C9;
	Wed, 15 Apr 2026 11:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="YkQdqWyy";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B0A10E6C9
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776252572; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kN+rdMA+nsF6yDQNDjX9M9/h2F4KncCn534h8uPTvFJyo9eZmbGJLysNP5HIUwincczBtTPbkQgdCvhEyB2QIdJR2+oJj7mWGJ4AGBiQSwu6bRE5W0CFDgax5Se+V1brskJrB9P0y7kIL3Dj3MiQAKkc2HxYsGbYF+SE+cFkLEE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776252572;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=wBbhOd9N1ulj8HlqwKZuLm9O6XwurhYVgjsddamL+4o=; 
 b=RR4pEhHxBY3x4eWkz4SDwBDGZ29ornRLUiQ7E0RgW8KFwctUovRoqobJRrELeCeTHVg9JiZKkoTP8tMP6hTLwrMnbl+i9p0X5riVKNsWinbcxciI4yzHznsyxD40z3LQnoXrC1c29jv4cm3ppUYwKxUbf2NHhb4Q1dMiNhPScjk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776252572; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=wBbhOd9N1ulj8HlqwKZuLm9O6XwurhYVgjsddamL+4o=;
 b=YkQdqWyyA63br34NJ/gjS0feJF3YfyLiakZO5cGXM51a200k6Le5OaSW6aavzP5Y
 /6HJPfAREE6TZjG0LgPOcjGOLJSJ7BM2xFVRWJrgiFD4P1mbww95+L3vSKjfkBYG8B7
 B2FpAZCijdqFBfgTvhbWA7aFLPjHQ3zYkVyykiuY=
Received: by mx.zohomail.com with SMTPS id 1776252571658869.4891831938455;
 Wed, 15 Apr 2026 04:29:31 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 6/6] drm/panthor: Bump the driver version to 1.9
Date: Wed, 15 Apr 2026 12:28:50 +0100
Message-ID: <20260415112900.681834-7-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112900.681834-1-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
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

Bump the driver version to reflect the new MMU info query ioctl
parameter and the VM_BIND map sparse flag.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index a8090bc4e33c..c8fb63ede62c 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1787,6 +1787,8 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  *       - adds DRM_IOCTL_PANTHOR_BO_QUERY_INFO ioctl
  *       - adds drm_panthor_gpu_info::selected_coherency
  * - 1.8 - extends DEV_QUERY_TIMESTAMP_INFO with flags
+ * - 1.9 - adds DRM_PANTHOR_DEV_QUERY_MMU_INFO query
+ *       - adds DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE flag
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
-- 
2.53.0

