Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39681C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E3D10E36F;
	Tue,  8 Sep 2026 14:36:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YQTo86ut";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F4C210E36F
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 57BDD42A75;
 Tue,  8 Sep 2026 14:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAE41F00A3D;
 Tue,  8 Sep 2026 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788878159;
 bh=WrDnBXEUES0WR7P2lhOYTykVEKJTOaUBbf8pmdHPY8w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YQTo86uttUuej6wyqqArJ3CYc0uDeSMFp/a5qkibb7fPRf5M6xc28Gs/Bp8rawv3P
 0VWSNs4c5rm/SEjEF/m2CRu+kHn+EeaNrmpsBRZrht85WnlyEfLnLzCfo0YOC0D1Dp
 7HuEdeF8C19gVgpYS+XzNPn+X7PR5TAAfCADprzU5iHzHEe+I9gFP1nkN3CuyE/OgV
 OocdfikL8wzCMbfT7JQeD1CxQt3T4Mwc7a7mbmONzX+Xx70v24DGtjVLwxqjtR00s9
 ck3dp+su78kZFrg2YJoSfxvSV3u0eOHcUnLTy7tiuCD+zoa/ob1TqHSO0L3IBCx4Oy
 RlfoFdqd6jzjQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 08 Sep 2026 16:35:11 +0200
Subject: [PATCH v3 10/11] drm/vkms: Switch container_of helpers to
 container_of_const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-reset-state-flag-v3-10-905570f387a4@kernel.org>
References: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
In-Reply-To: <20260908-drm-reset-state-flag-v3-0-905570f387a4@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T0/yZbif8qvMhUYbKQ5OZSohlQVc+4QmXLfUx6lhP6s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkLZOWP7ZpwiOfxzckvD/6sfH3mvX1iRceslvTPqnluK
 2reXH22tmMqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMxHoyY51Gxp/H4ocac9kl
 p5mdPMt2mGtZnn+8r2pL9F/eZsNJvz0/VT79mRl+aau3zLkaRjnnp4wNlzW1TNmvxs8smDf7AeN
 Wc/Mt4sqvLshr6rCWcttcqvJcJ/X66WO/6Xr7WlbztZ9y0z8EAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

The vkms container_of helpers use container_of() which discards the
const qualifier from the input pointer. This prevents passing a const
state pointer to to_vkms_plane_state() without a cast, for instance
in atomic_get_property which receives a const drm_plane_state.

Switch all four helpers to container_of_const() so the const qualifier
is properly propagated to the result type.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_drv.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 381483aa4fb0..dea6cad3f1b9 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -248,20 +248,20 @@ struct vkms_device {
 /*
  * The following helpers are used to convert a member of a struct into its parent.
  */
 
 #define drm_crtc_to_vkms_output(target) \
-	container_of(target, struct vkms_output, crtc)
+	container_of_const(target, struct vkms_output, crtc)
 
 #define drm_device_to_vkms_device(target) \
-	container_of(target, struct vkms_device, drm)
+	container_of_const(target, struct vkms_device, drm)
 
 #define to_vkms_crtc_state(target)\
-	container_of(target, struct vkms_crtc_state, base)
+	container_of_const(target, struct vkms_crtc_state, base)
 
 #define to_vkms_plane_state(target)\
-	container_of(target, struct vkms_plane_state, base.base)
+	container_of_const(target, struct vkms_plane_state, base.base)
 
 /**
  * vkms_create() - Create a device from a configuration
  * @config: Config used to configure the new device
  *

-- 
2.55.0

