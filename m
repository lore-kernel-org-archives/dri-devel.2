Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B21CD6E55
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 00:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632F810EAB4;
	Tue,  2 Jun 2026 00:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="dVuw0den";
	dkim-atps=neutral
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com
 [209.85.214.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A1710EAB4
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 00:39:02 +0000 (UTC)
Received: by mail-pl1-f226.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so153334465ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780360742; x=1780965542;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6w06ogmSyOUDqfROn/IXRSTZpJwIS2exeRvCfITJeVk=;
 b=Qlw39VdZNpDPtVJa7YE9CZmg7emt0F1zZ+yFsujLHyxwejfN3pMOfGZI0C8hN9DUBu
 kTYhyf27B56a5cc7pvP92HCbmBlhumx9oCOEZhaVqSeMh9eiesVQ6klCBz5EPQlAHBOa
 q+6HlmMguz5civ0qjIe19BD+C7g1OcY3phawzgy8lj9gGtCSLp3IDVf6DPJmUjN63qT3
 xlhL8ypb0MlzxHYRIK3b/1GQTjrHUmRZRCpN7iWzgDfI2fGQQHuGz1oHM+H6v1j+knZ0
 n4XehK2usa1s/WgW5AXKMOJfYQFc473FT36Rs9+TqVWGc4bUqSR76YzDv3Y47qCHDPCf
 by2Q==
X-Gm-Message-State: AOJu0YwjahkFQuL6tJmNUIAtBapsJN0HyxJARCsYEN85mw40ZRlDi7S8
 EeSnIyu7coLFQc2xNbw0dKm2nqdSDCqP7eE/L21lApQQAFBgGvs2LgaCixURyVzA/pimW/p++kb
 Z5wCtRSBmK8AawQoMDtsjHEO6di2Makm0WFWAQs+/7CO8w8ybvxxZ8e4N80Vv53sRMv9hl/pQtc
 ynX8lRZTpFidYOw9QAFQnxfZEdPkSMNudiiITs1rXiNoKwfhc3t1hiPCXH+nSsR02OJeYg4Ml64
 7Qm+WCMoUD2b2X7H06Lkx+UN9iL
X-Gm-Gg: Acq92OFEEUTdekutAyau7bK4ZdZEygfw7GhkLF6EjDzBD2+N8fcXWPRIPrUAK8m7RnJ
 apLwNw8IP7h0k44H8aihpu5JbSdyPLokgQ2vWVWJQI1YgZHV5wj1aR7ErqrqYCtSoNaAyyVcm7W
 KyjZvi67Sx6Z8OgSdafEo2hTMFOM9YO0+Br06B9nHAnTrEWdY8Bg8wxMvEWMQRa7rkRhNK7WxXT
 Y0uefi0tozl8ydxVbZFjwCjQibpYKLKPGCEnLRkXQWF9QzYNCUy4JYvifQQwG8zn4lO0XFnEIZD
 o2FcEzKKFG4Ujm/F4vABg2FOyNCU+FshCswylSGhVjlUWGb5AlTnVP0tbuSSaQvnBQllaLzYemz
 weOxaI47/4Z3pGOxpx+Yb8WTvT4DakZWwv8rwx4UQH6V09VDQ0SR9HPQfrHpY60NoeUqYJRDokQ
 jdZ29OfrLMZhl1jbRgnK1H10dDf1lsysDViHrzbn3Na/dxEpqYuEjaY6krfULrBGYJCxlbSF+pf
 cg=
X-Received: by 2002:a17:903:fa6:b0:2bc:7d4d:3520 with SMTP id
 d9443c01a7336-2bf36885897mr149838175ad.40.1780360741800; 
 Mon, 01 Jun 2026 17:39:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bf239ea1cfsm9152465ad.9.2026.06.01.17.39.01
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2026 17:39:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cd14e88120so70269526d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1780360740; x=1780965540;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6w06ogmSyOUDqfROn/IXRSTZpJwIS2exeRvCfITJeVk=;
 b=dVuw0denWhpc8SXgSy/jh323G4H4qWI1/kKUiKCzvwPYDhlYP08IKRfVgGkMC/23ip
 0SW14+5lJpxl1u8r91lJk/YejVohaeNizkF17E5S1ndTFuBYhymHxOn0k5V+tmEkqhYb
 xSk29Ot874wP3GDCg2BCNDEFwLKsSEgOoQrLQ=
X-Received: by 2002:a05:6214:2f13:b0:8ca:16fd:7297 with SMTP id
 6a1803df08f44-8ccefd9294fmr272373816d6.30.1780360740610; 
 Mon, 01 Jun 2026 17:39:00 -0700 (PDT)
X-Received: by 2002:a05:6214:2f13:b0:8ca:16fd:7297 with SMTP id
 6a1803df08f44-8ccefd9294fmr272373326d6.30.1780360740034; 
 Mon, 01 Jun 2026 17:39:00 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([216.221.25.44]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea1cadd2sm108125616d6.24.2026.06.01.17.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 17:38:59 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v5 3/4] drm/vmwgfx: Reserve ttm object before resv usage
Date: Mon,  1 Jun 2026 17:42:02 -0700
Message-ID: <20260602004203.102901-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
References: <20260602004203.102901-1-maaz.mombasawala@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

We hit dma_resv_assert_held warnings in several places, reserve the ttm
base object when it's being used to avoid them.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c   | 6 ++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 1264a9ac4241..a69a6764ead2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -52,10 +52,16 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 		WARN_ON(vbo != res->guest_memory_bo);
 		WARN_ON(!res->guest_memory_bo);
 		if (res->guest_memory_bo) {
+			int ret = 0;
 			/* Reserve and switch the backing mob. */
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
+			ret = ttm_bo_reserve(bo, false, false, NULL);
+			if (ret != 0)
+				drm_warn(&res->dev_priv->drm,
+					 "%s: failed reserve\n", __func__);
 			vmw_resource_mob_detach(res);
+			ttm_bo_unreserve(bo);
 			if (res->dirty)
 				res->func->dirty_free(res);
 			if (res->coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 7b8163b5e501..d0c371df7e4c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
 	spin_unlock_irq(&du->vkms.crc_state_lock);
 
 	if (surf) {
+		int ret;
 		if (vmw_surface_sync(vmw, surf)) {
 			drm_warn(
 				crtc->dev,
@@ -138,7 +139,14 @@ crc_generate_worker(struct work_struct *work)
 			return;
 		}
 
+		ret = ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, false, false, NULL);
+		if (ret != 0) {
+			drm_warn(&vmw->drm, "%s: failed reserve\n", __func__);
+			goto done;
+		}
 		compute_crc(crtc, surf, &crc32);
+		ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);
+done:
 		vmw_surface_unreference(&surf);
 	}
 
-- 
2.54.0

