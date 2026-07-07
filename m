Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708BC44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC0910F42C;
	Thu,  9 Jul 2026 07:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UkBl0tJA";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F064A89C68
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:05:51 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2cc97653887so27511735ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783436751; x=1784041551; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P7sw/zFWz1DYg+oB/zADus9gwMJ9dh4VTu7P7+4JaS0=;
 b=UkBl0tJARuAvsksw4uCVz/hOacMRly1HX7uhdZ9zrqFyrS1KAb7cnITMsfzdD7Wgfa
 XLHK3RWBdfEa4yVpMgAYoR04+CZK8Ricu0656aj5PgjoUfjc6MdX+BBI58JQluql6bXS
 Pv94GWGNCOVGCqaqWycGwE6VzCBiU/3ZSMN11wKPnjyLR61U7pWknfbYr6O9SmERM0/3
 hn6ShRSYGWDKQHK6QkZ3KaIpanByMradvLE+efMuRm8YhyjdToF1wtxO0cRUpHkhTMkK
 GGSJ05QcSuV0vc3RyHq0BMFHCWIzgBdfq5tIu+UifLnzwztfOx46GLiqoPXOU6aQOuVP
 gWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436751; x=1784041551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7sw/zFWz1DYg+oB/zADus9gwMJ9dh4VTu7P7+4JaS0=;
 b=On+86gj9aRswJglpbYvCBFjPFk6xmmoZIDzK/33jjLRYSlWitRa9wzX/N1k6khotQW
 g6yRHi8JNLBnC2Fu2746qpHRbPjku9IxfnZMQr0l5oKzJnJb52lWI53zOHDhptfXQspT
 JlnEdcQrsieFDqA1dbH3SpYsiDWh83UUxZv2PS5MtSzX2Qq46yIc5M1iEbHOpT/6EIA1
 8DK8pUsDOiTyb+ZzxNJn984Yq7dLpZ41Rz3O6WX20DW85b2q+pY3WXQwORzLyOJ03UsN
 587cvuAxg28w8pgnuHoQ61E6TpZF7q+KnhqAjl+WSoCMNuZnwdrRxyUYXdAB/Fbmi6/p
 JjfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZO5NMFadLF5PgoOz8BYHc5/nQn1Ukv/slyaJGmD91vil0DAGmg9IrR9ctZcnSyr+79WdpVFbCCmQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9itRZy3c66LKmVnkzct32qrKBAC9Z9SkUWbMab5NaGI8/Rnhu
 H7DsapUYKUQcSlcFH71nY/2x0BYszr4aaTJyBQ8tOkyKQSA3YoZOHjID
X-Gm-Gg: AfdE7ckksIpkqirNtkSlD4s4P6AptOAY9NThz+epqAMny8wTyDQ+jyCX+Zpkvs744OL
 cG89tWyqrO60Qy2G6wWs1Y8zzrTTciJrDJcfbhSPr9TOxNA7C+vH/2XMXv+a6IXecFMlh8W2kAh
 n7+UKghSgrVi0yuXI4wEplsoYvHGCHrivvJ/mH0yZ4a5PPkWYCkZ/M1c354sL499JkFS+QZLqoj
 qTnGsKDKmxCYlwgfle/xaahnfYwDXhwPbcciqIr3AmAn4rcnzbaH7lqarXFNa03bXWzMDG0IrU6
 4QVgV5wQcZiRTwgtL0V1alTFKyMeWlENfD3wHzLFd/tmhVoniArXH/crxGcovc8K+0yv+i/FXfv
 Ypwrns3IPaRTXwv2YzrPB4I0wenXCF2V/NAxZQXVdSinJzLxSgiCqMnht/CK68adlfhYcxkBFkN
 GaJu20nEr+EiHwTA2clUBPHFIVnAjGkFi4
X-Received: by 2002:a17:902:d547:b0:2ca:e1eb:174d with SMTP id
 d9443c01a7336-2ccbe71f801mr56490205ad.20.1783436751131; 
 Tue, 07 Jul 2026 08:05:51 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:239e:a31b:1d0d:374f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf77e4sm13747065ad.22.2026.07.07.08.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 08:05:50 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: mombasawalam@vmware.com, krastevm@vmware.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/vmwgfx: Handle MOBs without page-table BOs
Date: Tue,  7 Jul 2026 23:05:44 +0800
Message-ID: <20260707150544.2272933-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Single-page MOBs and small OTable bases use depth-0 page-table entries
and do not allocate a page-table BO. Their existing teardown paths were
written to tolerate that by checking a local BO pointer before reserving
or fencing it.

Commit 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
changed pt_bo from a raw TTM buffer object pointer to a vmwgfx BO pointer
and converted those local BO initializers to &pt_bo->tbo. That
dereferences pt_bo before the existing NULL checks, so depth-0 MOBs can
crash during OTable teardown or MOB unbind.

Keep the previous conditional behavior by deriving the TTM BO only when
the MOB has a page-table BO.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 668b206601c5 ("drm/vmwgfx: Stop using raw ttm_buffer_object's")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
index de7a504de9ce5..7cfd96e6e3489 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
@@ -204,7 +204,9 @@ static void vmw_takedown_otable_base(struct vmw_private *dev_priv,
 	if (otable->page_table == NULL)
 		return;
 
-	bo = &otable->page_table->pt_bo->tbo;
+	bo = NULL;
+	if (otable->page_table->pt_bo)
+		bo = &otable->page_table->pt_bo->tbo;
 	cmd = VMW_CMD_RESERVE(dev_priv, sizeof(*cmd));
 	if (unlikely(cmd == NULL))
 		return;
@@ -555,7 +557,10 @@ void vmw_mob_unbind(struct vmw_private *dev_priv,
 		SVGA3dCmdDestroyGBMob body;
 	} *cmd;
 	int ret;
-	struct ttm_buffer_object *bo = &mob->pt_bo->tbo;
+	struct ttm_buffer_object *bo = NULL;
+
+	if (mob->pt_bo)
+		bo = &mob->pt_bo->tbo;
 
 	if (bo) {
 		ret = ttm_bo_reserve(bo, false, true, NULL);
-- 
2.51.0

