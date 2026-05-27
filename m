Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B84CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 14:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0483910E1FF;
	Wed, 27 May 2026 14:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="h4oOX0/g";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C404810E1FF
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 14:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779890647; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xz4i/ebKuyf6caCw+CVxi/qlAuSMIKGK5vMBqalHJSlk7sX0QslxPkCBkHuuBevZuGL0VtHiUvNPkdRggPA4Pcjr9GBtlCFYryDXCbsi3PDUQj+IBFAVxR9QlOscLSXNEH2UvYeO4kUlPl0nX3xt6CG0OMw0rTXbGHZzi92UhlQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779890647;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=FJVCfsO9fR1MMtto28iRXIlsu49zY0/C29vsmsa+GMU=; 
 b=OrGJ8DduJUpll5I6uTYZad5DCAS+JTg9H+xBirfvC62bVvOsYgqRLChasHdBZ8ET4H+68RapjoHCkVYKH8gTZdutvdkvMSgd9DXXn5+sDNUqiKwpR+ap/XadkJRUPC6CMowhrLT6chMktAW5miV62frXJ3/yU3/7+pQcu9+1xYY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779890647; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=FJVCfsO9fR1MMtto28iRXIlsu49zY0/C29vsmsa+GMU=;
 b=h4oOX0/gUvxzehYAZRplhydQWyQDP6XGl9ZRG9Hf9m/jesbXP44TiPLmMfs2sOaE
 CcFDKLsrG4VoRGKTl6QowLiJ4jSEv0EAQdYhLDzXJWEK1pceaCtxfDiTLu1eQPnZx/t
 9wd/P8adIdcF+3mj1YTJQ2IHFMU3SZ6bRF3pNxMg=
Received: by mx.zohomail.com with SMTPS id 177989064625077.556391634428;
 Wed, 27 May 2026 07:04:06 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 27 May 2026 16:03:42 +0200
Subject: [PATCH v4 1/4] drm/scdc-helper: Don't use ssize_t return type for
 scdc_read/write
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-scdc-link-health-v4-1-622ea40a1f59@collabora.com>
References: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
In-Reply-To: <20260527-scdc-link-health-v4-0-622ea40a1f59@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

drm_scdc_read and drm_scdc_write, both of which are only used within
drm_scdc_helper (although exported), use a ssize_t as their return type.

This would make sense if they returned the number of bytes read/written
on success, and negative errno otherwise. However, they return 0 on
success.

Demote them to "int" as their return type, in order to avoid needlessly
using 64 bits when less suffices.

No functional change.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 8 ++++----
 include/drm/display/drm_scdc_helper.h     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index df878aad4a36..8403f2390ab6 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -67,8 +67,8 @@
  * Returns:
  * 0 on success, negative error code on failure.
  */
-ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
-		      size_t size)
+int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
+		  size_t size)
 {
 	int ret;
 	struct i2c_msg msgs[2] = {
@@ -107,8 +107,8 @@ EXPORT_SYMBOL(drm_scdc_read);
  * Returns:
  * 0 on success, negative error code on failure.
  */
-ssize_t drm_scdc_write(struct i2c_adapter *adapter, u8 offset,
-		       const void *buffer, size_t size)
+int drm_scdc_write(struct i2c_adapter *adapter, u8 offset, const void *buffer,
+		   size_t size)
 {
 	struct i2c_msg msg = {
 		.addr = SCDC_I2C_SLAVE_ADDRESS,
diff --git a/include/drm/display/drm_scdc_helper.h b/include/drm/display/drm_scdc_helper.h
index 34600476a1b9..e9ccaeba56dd 100644
--- a/include/drm/display/drm_scdc_helper.h
+++ b/include/drm/display/drm_scdc_helper.h
@@ -31,10 +31,10 @@
 struct drm_connector;
 struct i2c_adapter;
 
-ssize_t drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
-		      size_t size);
-ssize_t drm_scdc_write(struct i2c_adapter *adapter, u8 offset,
-		       const void *buffer, size_t size);
+int drm_scdc_read(struct i2c_adapter *adapter, u8 offset, void *buffer,
+		  size_t size);
+int drm_scdc_write(struct i2c_adapter *adapter, u8 offset, const void *buffer,
+		   size_t size);
 
 /**
  * drm_scdc_readb - read a single byte from SCDC

-- 
2.54.0

