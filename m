Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA781C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 497D010F417;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="VcZiWLR9";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59CE410E696
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:54:38 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260706134552euoutp01782edfe91306e41b5d442d78f47bdcc2~-t1TaejK50794907949euoutp01Y
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 13:45:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260706134552euoutp01782edfe91306e41b5d442d78f47bdcc2~-t1TaejK50794907949euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1783345552;
 bh=ErriZGqRy74klS/BGsnM/dm0czi6mfJXOhBZOSLRGoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VcZiWLR9Pn7nWwj1WsXkosTvYJdS/cGdU7ksGk+D+qULvIUgT99jtAUBr2DjDw2KF
 VitQavxz8De83coP4oe0XvgcIpghIAuZTuLuArsp5HnM4RwdZygG/L9QJIPNzPdDEV
 W7CORB3IgFiLNreHPPlao8cZMd8OeogR/6oetYrs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881~-t1S17Cu50969609696eucas1p1B;
 Mon,  6 Jul 2026 13:45:51 +0000 (GMT)
Received: from AMDC4670.local (unknown [106.120.77.38]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260706134551eusmtip12cc8cdb10d978e06968eec143b44d9d4~-t1SUbju90595805958eusmtip1A;
 Mon,  6 Jul 2026 13:45:51 +0000 (GMT)
From: Jan Niedziolka <j.niedziolka@samsung.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 k.tegowski@samsung.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 a.fijalko@samsung.com, bartlomiej.k@samsung.com, Jan Niedziolka
 <j.niedziolka@samsung.com>
Subject: [PATCH 3/3] gpu/drm: Add drm_notice logging when drm_mode_create fails
Date: Mon,  6 Jul 2026 15:34:41 +0200
Message-ID: <20260706134515.3369960-4-j.niedziolka@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706134515.3369960-1-j.niedziolka@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881
X-EPHeader: CA
X-CMS-RootMailID: 20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881
References: <20260706134515.3369960-1-j.niedziolka@samsung.com>
 <CGME20260706134551eucas1p15c82b3c36b5644c1111663938c1dc881@eucas1p1.samsung.com>
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

Add logging to have it printed when mode creating fails. As the NULL return has
been present here for a long time, it's better to keep it as it is. However, a
simple drm_notice() print should be helpful when such fail happens.
At the same time, adding drm_notice() to drm_mode_duplicate() allows making use
of *dev parameter and at the same time, keeps the further drm_mode_duplicate()
references stable.

It's a matter of discussion whether NULL or error code should be returned - the
latter might be more elegant and secure, but introducing it would mean breaking
internal API (current references). It's a cost which might be considered, if
needed.

Signed-off-by: Jan Niedziolka <j.niedziolka@samsung.com>
---
 drivers/gpu/drm/drm_modes.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 049d77e75ddd..fc6d974e3948 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -646,8 +646,10 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
 	 * return directly
 	 */
 	drm_mode = drm_mode_create();
-	if (!drm_mode)
+	if (!drm_mode) {
+		drm_notice(dev, "Failed to create a new display mode\n");
 		return NULL;
+	}
 
 	/* the CVT default refresh rate is 60Hz */
 	if (!vrefresh)
@@ -881,8 +883,10 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
 		return NULL;
 
 	drm_mode = drm_mode_create();
-	if (!drm_mode)
+	if (!drm_mode) {
+		drm_notice(dev, "Failed to create a new display mode\n");
 		return NULL;
+	}
 
 	/* 1. In order to give correct results, the number of horizontal
 	 * pixels requested is first processed to ensure that it is divisible
@@ -1458,8 +1462,10 @@ struct drm_display_mode *drm_mode_duplicate(struct drm_device *dev,
 	struct drm_display_mode *nmode;
 
 	nmode = drm_mode_create();
-	if (!nmode)
+	if (!nmode) {
+		drm_notice(dev, "Failed to create a new display mode\n");
 		return NULL;
+	}
 
 	drm_mode_copy(nmode, mode);
 
-- 
2.43.0

