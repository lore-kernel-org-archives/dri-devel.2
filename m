Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341BEC88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678D310E3A4;
	Wed, 16 Sep 2026 08:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WhGdKofG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FB310E899
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 08:56:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E54C642A30;
 Wed, 16 Sep 2026 08:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453251F000FF;
 Wed, 16 Sep 2026 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789548970;
 bh=6YK5H9L8Sp0PRNzd3JLep8Fa865u/iCDpkhJ7GoHMF4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WhGdKofGFG3oMQSk18PJC4lfz3PChoYr8z824ucumYeAdWxwOoYP/XzFUjU1SzeZm
 6QB5aT9jWAcsFx2FUKj406OW+NURj6b5oCm7mqQXXEGYcmVXdLGVbw6J9g4HVzYKPJ
 RLj+pMjeW2KaYP5+hF0hwLDJhI9hZkYip3H3vkz6xVdI8srySrYtPYyH6Cgg39PEBo
 NQ1/n95NewKAuEL3dqi5dDMS50OdUmOtLvuUY5BY32PzkYPbXDH3FTQSq7YH1pCupp
 zkAWLvfKhCRAhmQdn79LdDuyRA2+NrPJVNsYZI4WisvFqxbe4+hTQZj6zo7IilzCZY
 rrdINMqplXFiw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 16 Sep 2026 10:55:47 +0200
Subject: [PATCH v5 4/9] drm/pl111: Switch to
 drm_atomic_helper_plane_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-no-more-plane-reset-v5-4-f590d2003f2c@kernel.org>
References: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
In-Reply-To: <20260916-drm-no-more-plane-reset-v5-0-f590d2003f2c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=mripard@kernel.org;
 h=from:subject:message-id; bh=vk8VEQY22uZ/oN21W634ChCP7BwXZTGPTaXjpWQeemw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmrIqeeZbO4vE74w4szlww/brbkTa+vid+UuVBL7WpYc
 KHjjv0/O6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEXHQZKxmlOVO1fObK7OOa
 +1iDJ5Ftu+KkTR5HnBib/aoVczzFjgckf53GcnnV3Qvz+5lWnrJvZqwzXp8XM+Nb6VX+t9rO0/0
 u2L1VlOosu1iZtEuoQWXB0tYQ7u1HOEv2TbkoaXN8vl9NagAA
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

The pl111 plane implementation uses the deprecated
drm_atomic_helper_plane_reset() as its reset hook.

Switch to drm_atomic_helper_plane_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/pl111/pl111_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 1a22bbfa135a..f5fe5c5e0df3 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -487,11 +487,11 @@ static const struct drm_crtc_helper_funcs pl111_crtc_helper_funcs = {
 };
 
 static const struct drm_plane_funcs pl111_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_create_state	= drm_atomic_helper_plane_create_state,
 	.destroy		= drm_plane_cleanup,
 	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 

-- 
2.55.0

