Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0ACCD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 769DC10EA6C;
	Sun,  7 Jun 2026 14:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nbTfJ5O4";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD5CD10E851
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 19:37:44 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-36d98b68d68so2111383a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 06 Jun 2026 12:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780774664; x=1781379464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UuRt/g8i0auxT0ERqPZin1Efu8KJFx+z2i1UbznRwKU=;
 b=nbTfJ5O4YnzCSTtJrD0EFdQr3utt1XCzgzpPpLXhilEYEp4p29CBCXhtXwpbFDYE2T
 CVR755YljGMzxNNpFjKnCbzo6ly+/WaajuDWNP0sPZ8H8l62gu7iXSwiJLsAiAClYuLa
 HuL8xwcWomshl99Kxnlszxz/0I7VDi0iNGZORbYwV+gcjteQB/3xsLv3Ov1Hn0/uY2sD
 U8833s7972dzoUHYSTn9ZJ79oInj3YSPfL9RTUspADUDqnsYG7dFjRG5a2xNzYPUA7kQ
 BkdYhc30dLoecKvpUXE3KXiCbfJsAGxioQeThNg98UEN6je4f6AXgJ7eSGEdrS6x0Hqq
 oRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780774664; x=1781379464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UuRt/g8i0auxT0ERqPZin1Efu8KJFx+z2i1UbznRwKU=;
 b=l9Kll5XyaR3UWn3TLdXPu6jJHkyRyIS+fUikREZm0sxFu17jOV11vw1b7Bz6DK2WB1
 uvFOPaujATPntUFHDBYUBDUY/Ze2QQxLlZ9X5LAt7wpNQoMvuit6NqfEjfzeTe22It+l
 Kzuf4KkGWfRRel+xfqIlIg/ejSi7EzWLo6zjRf7PIM4JDjfyQvPDDYmbnUaf+F6orfGc
 dGxJ8RjBmADMvwscYxU0vVMkKEKG0nr0DzaF1otiwx12uiQJyFIXtuKT1yO8/kY/G7H0
 Gh58i5GXPECDrUXFMSYpqA+n141jNyBod85SETpzTgAvi2tuOvyFSFxjIkSxsj2QhpRe
 yYiA==
X-Gm-Message-State: AOJu0YwumQglgxE/RTzQ7Gfhqne91BpDc89F2+drVda2dENANn5No0yw
 vxp42tY/qPfdhGQv8tb1mgvJ1HbsPBGmzOlaaNZ6U+cl1Po31RKFytog7in4Xg==
X-Gm-Gg: Acq92OG+JviKB0TicfwEidSRC9JXhjDUhff3zajbnF6M4ADtKYAvW9jknYXOuHwkQFz
 1uuqPfQII4LCHRcKP+AujECRiGMyaO0TRTii0ewXWEgu4ct6wmv+Hw5p/rBHU2Wg8UXf4dglz4H
 zjKn5Oo0g+4JE3xEN6Sd0yEgD4cZrNW2mjnZs3WRf7zkRZ1LhjWxBnEHaFeys1Syz2aTn4aF26Q
 kuenxULWGTqtDmxUlqPznWJ82KQvhkReJ3nJJ8gkvbVJeOQfJwJi8iT0Bhb0gGMhAxrtoS0AKG8
 z6m702ixJcfqCwHL4aUUGY8wBWejouOKNRm7KZFRKN1kNbi88r51fc+BySvXx35C46BkHKOD88f
 Qwhnu+9NlfS+h1jJzuaBflGgNGPaJPMv2pSnq+qwsYQyM7/CJpGQk/lPPdShoF+pM25CLlLhIg/
 CJGQVtOgsIxqyLjpNDlYPvtQP6g6kmy/w3FgJUMrNaiV5xxY4gKzBg19UerF/YssYpZsvWDOlbx
 hTA4yvAwXgVt72tD2sAmqEpV2Rs8QScAOfT/oTDwlc5uBq03SZK9w==
X-Received: by 2002:a17:90b:4b87:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-370eec1272dmr9975318a91.8.1780774664126; 
 Sat, 06 Jun 2026 12:37:44 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA..
 ([2409:40c1:400d:d07e:31c5:fce9:e168:2f2f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37135861581sm3003643a91.2.2026.06.06.12.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 12:37:43 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, robert.foss@linaro.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: replace
 deprecated DRM_ERROR macro
Date: Sun,  7 Jun 2026 01:06:19 +0530
Message-ID: <20260606193625.24465-6-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606193625.24465-1-piyushpatle228@gmail.com>
References: <20260606193625.24465-1-piyushpatle228@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Replace DRM_ERROR() with device-aware drm_err() using bridge->dev.

No functional changes.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 2d02cc69f237..a34212f10b6d 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -168,7 +168,7 @@ static int ge_b850v3_lvds_create_connector(struct drm_bridge *bridge)
 				 &ge_b850v3_lvds_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
 	if (ret) {
-		DRM_ERROR("Failed to initialize connector with drm\n");
+		drm_err(bridge->dev, "Failed to initialize connector with drm\n");
 		return ret;
 	}
 
-- 
2.43.0

