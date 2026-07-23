Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EACC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40BF410E612;
	Fri, 24 Jul 2026 00:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="IuhtBI6l";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B86F10E612
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 00:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784851263; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hSOgKXuwLBFdqbhX0WfEWdQ45xp/JT15+Ex41KvSX0YVRrHYT211sO+kF4BStTUcI1bK8/WkyT9pZ2AifrvGjWvtZ6+3/BbdJPIaMT/3YFV2q+x2vdIE5OzvC92ts9iRy5iWh75H4XMyHBLyhjCQxQuH8dkYTGJ+wUr8R57zLEw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784851263;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=HRjmNl6oGYjPmGh29rfIzZ5tyavjk0dZYPg1zwYttLo=; 
 b=Wl9no7p4lczCwl/0Eg7ndXqodr/7r6R9l6+RJm76qkg9W/XYIESs6Z/EgcBoUFSDeO6gbJXI8+ZlpHqMx22bmY3jrj7EA/JGx74H2LUpJrJQcIDbeNiqZByv4+kKJVeBDkHvyVstALKiY1Mh2ZUG+3j5Mz8AnTOMhld2ce7O9CM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784851263; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=HRjmNl6oGYjPmGh29rfIzZ5tyavjk0dZYPg1zwYttLo=;
 b=IuhtBI6lAHInw7j1RjgDQzZLqWwd8tWk0AYaXFYnPaIg9x0y+/WfQdS+0AJ/bDJV
 cf15pQgrPFUbGbmdzwfK1TxKZ17f/iK6UlBxClx+OTsVXgqZlzNy0hJVtCfZJnSKCzL
 e1Cd24H+DarPqAhp860L3xcVlo41MJ9hYOAORb8o=
Received: by mx.zohomail.com with SMTPS id 1784851262206180.63091262766852;
 Thu, 23 Jul 2026 17:01:02 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 24 Jul 2026 00:59:06 +0100
Subject: [PATCH v3 13/13] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-claude-fixes-v3-13-542af61abd0f@collabora.com>
References: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
In-Reply-To: <20260724-claude-fixes-v3-0-542af61abd0f@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=0nSYYdP+Vk0D9tHhyK5Rd2zCsph/BYAPaERTuRr0yfU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqYqrpy24c7GsVf4slbr08YVEHOS658ldj4XFJT
 Ulsna2hjqOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCamKq6QAKCRAOJn5M7lND
 PT/3DACWj6XO0VR2o2QhSYtUkwW8smg5AmuMPF+gNRi71lary98UFO6UcKiQkHAGY5ha6y07/jo
 U4Tr8Yi0NF2QpBfhbCCNtUqVMMiF6uHTNEHb2MhVboTST/rCul+76vXjPOWwaXTWv6D+o+c4OZA
 sLvQLrZdmO0zlKGM2x864uDtwzI8McfltIiVpLqDSsVf1VW+soIM4O9gye/09Lzi9KgMJpIymhT
 MUD44To+nqo/CtzA+/Lz+ERXFUOZNx3MFXgktuyahOlctjZgfwmM9jlSjLYVfjXX8MHwrxw8Xto
 OkMXXWwuLdUbiuOYFYfHXmurdIyholh6RZDCtdU6B9bBrZXSl0a7IP9yt26AaxGaEnn5c8NXyHH
 yJtAGtZC/g+j7UeMFNxjknnpb7okMs60cJrCKSDhgrKfLOJS8v/D8O1mOlpOko3aol/EkmcHhyp
 E1CEdvxjrRAFsfqnHOyD1kmMv6dpSJobs0GvNEAYbzEdxqLKJLOw8BBLN215aRXprvOas=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

Expose expanded PERFCNT_DUMP IOCTL interface to user mode.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index e04eb416ea0f..d9d41236cc71 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -936,6 +936,7 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req hw_reset field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -948,7 +949,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,

-- 
2.55.0

