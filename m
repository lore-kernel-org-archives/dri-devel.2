Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330EEC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:43:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3492E10EDAC;
	Tue, 11 Aug 2026 21:43:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="fSMWW3Ym";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B580310EDAC
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786484603; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ISgiP2u5GzqMnR1P7aEvZX5azxcSskFyiv7heGIIAse4XwBWNGUi8u2HwZmyhN/6ZbxhIdNYhtApbYQHc0cfBYP7MT1r+imwStruaxmaeZ3Ur6nBnsuzK4RdPCkjNNQYU1KA++Flx+BrmWRXTRrvoZmn9jeivfZ+yjcHzmZiNfY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786484603;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=muYceFP4hb9L3wd98bHHDWoYdINHTQCu9tJ/IGc1GE0=; 
 b=lXpXkT5qMfswivosk+qLkeBYicGWkTwEw3uYT4qBBNCzEKJTUp1Bmyg20xsLooljVjzWMgZz5YBCNL+zVjd4rrM0X5FXT1dNnKLKQejCqJQ/+fTmCvQn4ssTLckLCLmkYvfzlY1aradvw2xJB5oNLsYS5XXf2RMummFT9cCeVlA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786484603; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=muYceFP4hb9L3wd98bHHDWoYdINHTQCu9tJ/IGc1GE0=;
 b=fSMWW3Ym0yNAoSNhR026yNoQKCTrOEYKmP5YIamNUxnE6JC6WHKHvAjBoNeCC2rm
 00guc5SKT1p785wl/NpcqKDuZbKRFZTgRtVZ13aXPJczalcSqGQta3+kXrV6Uxqcrxa
 H3NqHC9JaSNe8kv8PqO6ATnOC/yxXkx3ztzRQ9QE=
Received: by mx.zohomail.com with SMTPS id 1786484600848587.0791789316598;
 Tue, 11 Aug 2026 14:43:20 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 11 Aug 2026 22:42:20 +0100
Subject: [PATCH v5 11/11] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-claude-fixes-v5-11-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
In-Reply-To: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
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
 bh=BujlFQSZpxg9zUWbgekPbVBq4Vs5CwXd++tBrZUliMU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqe5cz2e8mDigV3mWTm5FmcLfp5DiEYfJ/NpTF3
 Sv2R3sT1+GJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCanuXMwAKCRAOJn5M7lND
 PR/IC/wJcVdvbLhmvGad+4uJPd8g6YUoNjpj4YMI1RYrT4avo6g/Yt6GdK9rVJ856HSkF+DNX8h
 hS4HbFK/f4WqQr0Q3fAhRa2yeV41aBDRmE9bKOSqBN45vlH2BJe1+d+mratQX2jNjHqJihcta+d
 C4wVz2V3np4XhJOzEKcqXWQBFmn6vhTfsnPdLWOIfG9/qQWKRGH951eWfeWx86QiFzWLQ1GM3sv
 wlUX/4kJjBYHYXcLle4EzBaijWzxgYlNl02G4SU96SaJJJIvaxuL04C30eWUTEvxCAxa0YL/K1j
 drkTxKj7nFt8B0q8PCqBjHIMjJoW7iQv2xIkjgSdciGL4CeY66JwXOLk8QUvY5fwr2w6g/F6OUc
 BLMl/B5eUe4yxtPEbJbvXlK1gypXi4PdPqQXPcgMMHPiSntgtAFsrm9CYtW0rX0SruSt3d15cqd
 h+06UWGBcVgBtAUVpM1WPi2xUpftjI/77sykhupwppc1wiBvBVQIv+45nhN8NfA7roO7s=
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
index ff23b1a979bb..2949ab3ca055 100644
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

