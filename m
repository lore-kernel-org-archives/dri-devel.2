Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC0BC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D321110F483;
	Fri, 28 Aug 2026 20:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="W7yu8tNZ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8779D10F483
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950744; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X9spkr2Ocmtom2DanSSZZhGGQjGWSDPy3nB/g2/k4C7W7XlaZ+19pW6KPIoR+5f99E5ipYdtj4Y283m5Ua6Chs528MNQYQ/jpwNPRMDE5vHZSFWDdeP2h8fVeyl0Nv/Dx0L5xtZrxQ705ZovA7tmY02REF+jak+RUmCV3NmTQeg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950744;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1Tq6zEmNykIv8XKjKfzLV2GzV9wqZVjqsPfLMZwAlS4=; 
 b=VwYFYMjFpc2Y3CYjsVM2laGi2VELJEwfOhNJ1VM1/EHvT8WMrIk7BHtThu9WSCECaI4UP/ynWoi8ZvuyfjJPKVVQT/FmjCGBTU+7EVVH7u8UMQ5Y2gQkmFuXRiBAlrNzDLgLxvmvTOgbPc3b038TArjEcYT/p7DKgsguyJsY1jU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950744; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=1Tq6zEmNykIv8XKjKfzLV2GzV9wqZVjqsPfLMZwAlS4=;
 b=W7yu8tNZ0+Eoj+gfHAaJ1RQoXCQZjzIX5HYt1NMdUVFtaOgjHHwWKYcO8SqBQFZp
 G/zCf7IDJG+/kz7M+UxAvrjgKHSZzAETmpd2tuy1eoZmk9E+mSj31HBsoJPZWmW6J5D
 vLzWT5wvfvMYLCKNxkcjafzaHNjvme0qVRpnectE=
Received: by mx.zohomail.com with SMTPS id 1787950742651206.60696803607289;
 Fri, 28 Aug 2026 13:59:02 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:57 +0100
Subject: [PATCH v7 17/17] drm/panfrost: Bump driver minor to reflect new
 DUMP IOCTL req field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-17-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=AypLoSBm1KPHQD9f+Zcdy3AMlNPgjcCvidkbs8KFBCQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYu/gflAZtsy7HEi7wI9v6QOZYtEPO7MtvfZ
 VutA2fFM4GJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LgAKCRAOJn5M7lND
 PRZqDACHXdBfI5pKk0hnkDTJK2w+CfC7JD7ODcaPuxHFr7RMLyIR/z77PoTQvQ7vpeBzAVKPJYM
 w2wY/CKutk+juwjKzqqX6Tn+XMSdlGqecwMJdpJ3KBSMR2HT37ylgofDc5uLXugvFrxLqhq/KOc
 qqKPU5++Hflg+VIqtZ0IfKMWAXpNSXXeI2rPz6HnPrug17Iqe+iAV8JzXWHUqVQ89w5MUOZG7gi
 WHcdR+go5+rCJ3paUX03Ky+Ov6Nsc0SA81si9+B4LlrydLjT9yB2fKBe9xCui9qrsU/JRbVIhFt
 Bw/EHUG7OSVUXi2WMHW2BR9ljHgWQfElgDh3Hip90m2vBm9iU9/gbS8eA6yy7PNkrcbhyRmeloQ
 wDgKJubu0R7Z/ioURNG8ALASJY28SZFCkVxBBF7GFXCHfllfu4Qqk73TTthgFcTegWXhCQTNYx8
 IQ1K+3bEvJMrUCJXlCtEADx00dxnG3PQHzNH9IRz4iGjyvOl495Rej3H0Mg5vcvw2ngMw=
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
index 571a26b84126..7869a0cfc4c3 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -808,6 +808,7 @@ static const struct file_operations panfrost_drm_driver_fops = {
  * - 1.6 - adds PANFROST_BO_MAP_WB, PANFROST_IOCTL_SYNC_BO,
  *	   PANFROST_IOCTL_QUERY_BO_INFO and
  *	   DRM_PANFROST_PARAM_SELECTED_COHERENCY
+ * - 1.7 - adds PERFCNT_DUMP req hw_reset field
  */
 static const struct drm_driver panfrost_drm_driver = {
 	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,
@@ -820,7 +821,7 @@ static const struct drm_driver panfrost_drm_driver = {
 	.name			= "panfrost",
 	.desc			= "panfrost DRM",
 	.major			= 1,
-	.minor			= 6,
+	.minor			= 7,
 
 	.gem_create_object	= panfrost_gem_create_object,
 	.gem_prime_import	= panfrost_gem_prime_import,

-- 
2.55.0

