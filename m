Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E5EFB5EAC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 04:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6584010E1A2;
	Tue, 17 Mar 2026 04:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fm/Ugq0N";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0717110E1A2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 04:00:46 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2ae3a2f6007so42768985ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773720046; x=1774324846;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fi+k9jVt6BrKHmKcd0MUUmIWC23KS6caLRUR6qHsl2M=;
 b=fm/Ugq0NSMK6ArQeaPgvKmYupxu1i3OB2Z3Yb5E91UHTSlVHCZZ+secV3yUXtXsxOa
 hnxe6wa0FLD/lWJAbnw26Szu9M2eSnHud3PaXJIVokJ1Lvqh03x2Ot4XWTgXfIG1O4hy
 E+xEGCKhoDq3IhrU4osy5wlh8u4drBMstRiT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773720046; x=1774324846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi+k9jVt6BrKHmKcd0MUUmIWC23KS6caLRUR6qHsl2M=;
 b=TE0UEb9TKfb3toLTjXSWOs2lYZm5U58k0Ou5p/tTTirHDE2jeMpEjMew05xXpwyFcT
 6/VVht2LitAXSj92hUZoOzpJhSPMSiPUlNmn4eHTX1EJhbDyJTGaFbHFrMEkPckMxxff
 oJzfiJeDCdaIbLCWs2Jbj9g609/rR4pfjlg9WQRoYh6TbF5yXtKwmkQoawuvNuV3lDr8
 bR5K/UGZHF5awC1GRUyx7/L3naVZqLeTXnZby8U3VacxfBZtc/372Anp59rYQM8A2hsm
 EvJVg6BRbctDm/VIjBtlr/Mn0wslx8UOgpRx4YhZv81xEQfT59f6rwGnRC1BIJUuNr65
 i/tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyXcMZXjKM8/4oTNjeb57HlmUPP9xHNer4gUy4swAvkAUlOXs1MoOsmDsz/CkfaUYtTPQYwvtaV+4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0Fb6Bt05Q9n456DViRwcxzCN+Iiv92DnyUo9OAXcyF7HavCU5
 FCSS/gXwqFAT5Bs+Q9i2qqgf7USC4WonEK6bEn0g1KimGkfEN1bDWXKS7lC2Yu31pA==
X-Gm-Gg: ATEYQzzDeCg7vW5h41O5x4FoGd4wacxl5Hd2PO3DeGjo+KTUQdzto6WsoRuUP7FMPXd
 fFI2/qh6xjPuNGBcDq5Vya1U4zgfeTiE91YLYEgwDM8u2GxFvasMIIkYXnZRvQ90KumhdbZOCID
 aUdUtZahOyxD4O8a+gJOlbOvN0U8DNsyqmhHG+o/NHpvV/uDUCXn4jbD//EAw00CmsiD4SA2g0v
 jzMzti8IjOuo0yCI97uQQl7X/33CTiWFTLBP9FOmUoUVQRJo/jEyCcG8hTckuloKI8WDMe+6vYK
 y0FKsdsbe4aa6Zkz0HT5LXuMCuAnQP8jJj7oV/tdc9HseRZvVRCdyo2jPrVv9B84xcBPMhwmgzb
 ApgDfFTCDXUnAQWTcWr+nNEo+qw8pzpCOqt26gpRzxfHPtVWetkw4BOVHC2wg49EOp+Wf9UU5c7
 W23Z+EhYlMlFXHp7qcjPbPq6lH9+7MKgbttAaw+Zn5zBf0M7MFDQEAlaAfRDZRVFb2shZlXqTQu
 R4v5jqm
X-Received: by 2002:a17:902:e951:b0:2ae:c5fc:b2ea with SMTP id
 d9443c01a7336-2aecab1ef18mr170084665ad.30.1773720046451; 
 Mon, 16 Mar 2026 21:00:46 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:a064:c65d:a199:5cb6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b05f0ab17asm45335195ad.37.2026.03.16.21.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 21:00:45 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chen-Yu Tsai <wenst@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gem-dma: set VM_DONTDUMP for mmap
Date: Tue, 17 Mar 2026 12:00:32 +0800
Message-ID: <20260317040034.617585-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
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

When the mmap function was converted from a file op to a GEM object
function in commit f5ca8eb6f9bd ("drm/cma-helper: Implement mmap as GEM
CMA object functions") some VM flags were not lifted from drm_gem_mmap():

  - VM_IO
  - VM_DONTEXPAND
  - VM_DONTDUMP

VM_DONTEXPAND was added back in commit 59f39bfa6553 ("drm/cma-helper:
Set VM_DONTEXPAND for mmap"). VM_IO doesn't make sense since these are
memory buffers, while "IO tells people not to look at these pages
(accesses can have side effects)".

Add back VM_DONTDUMP. This matches the behavior of most other GEM
implementations.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index ecb9746f4da8..1911bf6a6a3e 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -534,7 +534,7 @@ int drm_gem_dma_mmap(struct drm_gem_dma_object *dma_obj, struct vm_area_struct *
 	 * the whole buffer.
 	 */
 	vma->vm_pgoff -= drm_vma_node_start(&obj->vma_node);
-	vm_flags_mod(vma, VM_DONTEXPAND, VM_PFNMAP);
+	vm_flags_mod(vma, VM_DONTDUMP | VM_DONTEXPAND, VM_PFNMAP);
 
 	if (dma_obj->map_noncoherent) {
 		vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-- 
2.53.0.851.ga537e3e6e9-goog

