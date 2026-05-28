Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3078DCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 20:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EDA10E33A;
	Thu, 28 May 2026 20:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGnTJWYt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4859410E33A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 20:15:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6F0B40E46;
 Thu, 28 May 2026 20:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443431F000E9;
 Thu, 28 May 2026 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1779999321;
 bh=wngop8rY/CemTIB4JW0B/JXyJl0KO6CCakAUSNB/adM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VGnTJWYtlyzszgLldQUVQGeSu27iEVwTyiygVETRa1qZ9/YGIMFQ3ex73HEOb/CtN
 V7bO81ZzwaCq/O5fbdDEpMqdvQA0cn3ZisASKqCt7mStH2LdbCLRX/bEY7+qKaiQu3
 cfAxMfT1y1xnJi7hlJP/FsbbaKzsqHPdm/YYm2yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>,
 Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/377] drm/vblank: Fix kernel docs for vblank timer
Date: Thu, 28 May 2026 21:44:23 +0200
Message-ID: <20260528194639.114698063@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3946d3ba99342f3b9996e621f05e7003d4308171 ]

Fix documentation for drm_crtc_vblank_start_timer(), which referred
to drm_crtc_vblank_cancel_timer().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20251106152201.6f248c09@canb.auug.org.au/
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patch.msgid.link/20251106073207.11192-1-tzimmermann@suse.de
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 61e211fd3c9c8..451ec96202266 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2258,7 +2258,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 EXPORT_SYMBOL(drm_crtc_vblank_start_timer);
 
 /**
- * drm_crtc_vblank_start_timer - Cancels the given CRTC's vblank timer
+ * drm_crtc_vblank_cancel_timer - Cancels the given CRTC's vblank timer
  * @crtc: the CRTC
  *
  * Drivers should call this function from their CRTC's disable_vblank
-- 
2.53.0



