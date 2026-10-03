Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3C9CA5FF7
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 17:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D2B510EAFC;
	Sun,  4 Oct 2026 17:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPtFxPI0";
	dkim-atps=neutral
Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DBFE10E2E0
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 09:35:02 +0000 (UTC)
Received: by mail-pz2-f6.google.com with SMTP id
 41be03b00d2f7-cc75f2924abso329642a12.1
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791020102; x=1791624902; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rBI89OF+N0vXnxCESFaz463auJhNn0qQwp4320r4m4Q=;
 b=dPtFxPI0XW4lfOnv4NXT93E3wf7QtME/wOetegol3+qFwBE1a8Ms8SmU31mdScmO6i
 FWZiIQIzomgBNTocZtNvzldkA1LFx00OYHE6MjyTg780lIRs76Sbmkr2oTOY3Z5/JdHc
 yYt5TUPxio3QLQZ8CsC/dpw4nbZqFPfFJ0lpcrB4cvrqNoIfRHJNpGVPf3RjjEyAR0gB
 PWTFyU6kGN+3MxHGwcZh/wZ2InDLp0EkAmTuwW3qHVXY4vkYZe6K3AGhukDBv6R1sN/X
 xD+0tTSuq3mx54gBwYyt+zvk56MWFpuZDTr6eO1oKqWlJYmc1l5zEJzgel2V5yCrLsPu
 Lykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791020102; x=1791624902;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rBI89OF+N0vXnxCESFaz463auJhNn0qQwp4320r4m4Q=;
 b=wjjoOBG9iieK+qaAxmpu43SCrDMf+OO5JR2Cs9HgFMJehrDas0fUaFILeyMQ9YdBll
 /bAmqGJ7ZPkaQpbqRiYm2znFK87sNJfzU+UtHWzHrnCRDIveERutBDjWsWur7VSn6z/R
 yihmlgzcA4YW4M4+mhhHndhG3x0U0AYbJRvO+2EYhpzvzMvEXADFifbpLtkbeRNxx5eg
 WBuLZwrtBxrVCbL2G1PilspT098Ob/5iQ12jm8/oiH38KKo46dXXb1PKvzZSm589EvHW
 HtCmJBGiZ/6GoqmQUWu/uahY8J9WRwT+2W7agw3WdSJKBixrrWrvGvQAWYBr8UzO0ECh
 L9sA==
X-Gm-Message-State: AFuF++nduLUh1vPt0Pzb77XGn84KC1RQdzbDLfrc5Pf771QDcFe8Qseh
 0nyyYZpBavNkUilue1Tp+WOXGVDrU3szqsmbCOaK/M+c3Xf88Zup8GkTYR3nacyNHUyCk3/b
X-Gm-Gg: AYBFou2uLg7hdFcRAgiI5Cbsagq/3a4ciC+gqhdYzXOpjRvk9meq44aZVl+WObzBgES
 eyKqc37iP2Rx0XPj+hC87QHtq6iGOCugnjps7jrsWVeKIaMJgWM5jOUHOqh/UIOx49r25XET5yg
 tj6Gv3FLAZBRPIh1pGHBhVY0Fpi7l1y8ghbSE8YI74lfBU6Gm6B8CAPpA2FQ3332YSDEj1yL+LV
 3Of+sX385bghy6ph7juI5fpzpCjWwRHBWIwjib7pUaUowjrGUD4DKfGJhH09gT3z0Ueim4JJ2IA
 pe9XWPzcBI6vdvhlFQH1WdsB7hyjAUbmMmfwq3+v9T2SSwSw53/ktEkLyoxsKHKkWkYFroj3mI8
 hBjsFJbn/wRFuI3ZA+XJ/3xnHdzc3pdBP48z5SUWuEknCOsoMxAO/vZ08+/q7BHxGwopXXSdgRG
 sV/UirlUPAcFaqpCvYETqUq26QjdN9eEnhfMs9dBnORN1sDxQayBrBD0p6jnJzxlU=
X-Received: by 2002:a05:6a00:1d92:b0:881:2a66:405f with SMTP id
 d2e1a72fcca58-88af6657eadmr5005327b3a.39.1791020101535; 
 Sat, 03 Oct 2026 02:35:01 -0700 (PDT)
Received: from localhost ([129.227.235.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88d3b82bafesm46732b3a.13.2026.10.03.02.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 02:35:01 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>,
 Xi Ruoyao <xry111@xry111.site>, Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 Sui Jingfeng <suijingfeng@loongson.cn>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Evanshenf <archwse@gmail.com>
Subject: [PATCH 1/2] drm/loongson: Fix double free on BO initialization failure
Date: Sat,  3 Oct 2026 09:34:58 +0000
Message-ID: <20261003093415.e64386de1e64-1-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 04 Oct 2026 17:18:49 +0000
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

If ttm_bo_init_validate() fails, it drops the buffer object's reference
and cleans it up through the supplied destroy callback. lsdc_bo_destroy()
releases the GEM object and frees the enclosing lsdc_bo, so freeing it
again in lsdc_bo_create() causes a double free on a synchronous failure
path.

Let TTM own the cleanup after initialization has started and return the
error directly. Keep the explicit free on drm_gem_object_init() failure,
which occurs before ownership is passed to TTM.

Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for one
selected dumb-buffer creation. The error reached userspace, the destroy
callback ran once, and no handle was published or tracked BO retained.
Normal buffer creation, zeroing, mapping, readback and release passed.

AI assistance was used for the ownership analysis, fix, fault-injection
tools, build and test execution.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index d7441d9..88536e2 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device *ddev,
 
 	ret = ttm_bo_init_validate(bdev, tbo, bo_type, &lbo->placement, 0,
 				   false, sg, resv, lsdc_bo_destroy);
-	if (ret) {
-		kfree(lbo);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return lbo;
 }

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.43.0

