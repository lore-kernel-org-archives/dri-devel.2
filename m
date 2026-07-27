Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03309C53209
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 18:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0B510E6B5;
	Mon, 27 Jul 2026 18:22:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Zt/rY2BO";
	dkim-atps=neutral
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com
 [209.85.160.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1104A10E6C8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 18:22:06 +0000 (UTC)
Received: by mail-oa1-f97.google.com with SMTP id
 586e51a60fabf-45133d2974fso2550590fac.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785176525; x=1785781325;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/VXGpjIF3MCq8IhizSoA9M+xPGqF5Kv0emvq7imghmU=;
 b=ryiwhVeZQpgdDTmfD1wQDAvzs45i7gsc9ImVZu/Sg0HYVIikWEexaqLAZhl/GJnPhw
 5Vc8JOY9huA4tNWaCy88n/ibo+7UwzIfzHNhLAdsYiYHMFMSxcJ+uM0fbL/VCM2l3r61
 duzRdtyG+otHYEu1sZozMOrrYuTrniNlvGcSnxiUbR2FjriXZ57kwMNRqcUV0ML23+x/
 Tmtm0mINbXGL//GjzyieZ7QnM53WHlS3SfSDvzpebW5V6gYlOD804X/ymfYbhSmISMSR
 7kXFkrCSOgGEhDVF7vUMwqQa709G03eGsESuEaHfs44EATS+S8V/bXvZgR6PhAEHlmM2
 wE8w==
X-Gm-Message-State: AOJu0YxyklL23DOL6uED2PUioH3hChnqMzcEUVpLX/30gAH2YExi8iA3
 sxRigKeE2Nl/MFDrZL6dViOvtYeA1PnQX2InwXP9I8k3fAcDX3oaU2aX4Zod1gCLXJeRW/iFOOT
 O19U6WTPP9AwuzFV80ytIdz8vmbXTcyO8CGog/54BYd7ABE9mw0sN64nukoGxARXQ8ZerHi8afA
 /7ECa6qH4r7FdNP5808BVpsFH3LE8B+bcBBoMhNNiCqHwVbnb7byHD4tGxBsCZATYr+PIijrfq6
 CRRmF27E1ZNCOdKNe/vYwP0PAvV
X-Gm-Gg: AR+sD10F12LnZkuFPRRK5FF7Vf7+SclBgYQBiPngWbqipfhS5+3Y5RZ1LWGzZm6KZb2
 C8xcclCJ6MYVuri1lQa+gH8zl2re8LmqqJ0TPq7Evid7kkbuPi1KwdG2Scoujh9ia9CTvtkQx3T
 yGB9vu//YqvFNH72BFSoG2mqlzkLrWbtNO9+T9XXZp1no2yipBaVLMUxi6w5BBZR+uTfTqhoqpy
 8wUTgR4Fez5UR7V0ozUfggL+FyQYzkIc1b7bo+unqlxdkmAMOiOgUchCIGqg27HomK6qAQJMdyb
 OryeylO3drjqUr6vL5D5GC+DS4ZbS3ukyUwkSrzPtG7JeefqAttA21OCLqU8Yxa1+KBsmXzfc84
 17p94osEyMFRn/T3uhyIMxEcVCK5LqyGuTe2NJOnWrQmEL2PvG5zFZAC73IZ7G5ty2kWpFoBLBd
 pqx7XsJXUk7WFzgtc3CwgR/kgYsUJJxtR4egTVKGcE
X-Received: by 2002:a05:6870:610f:b0:439:b99e:441e with SMTP id
 586e51a60fabf-4585dfef1d2mr503448fac.1.1785176525060; 
 Mon, 27 Jul 2026 11:22:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-4579d8052cesm1232203fac.16.2026.07.27.11.22.04
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 27 Jul 2026 11:22:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c15c6a68406so209323466b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Jul 2026 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1785176523; x=1785781323;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/VXGpjIF3MCq8IhizSoA9M+xPGqF5Kv0emvq7imghmU=;
 b=Zt/rY2BOPnAlzxLCQ/JW5xw6AaO5c70HXCp1eXrMVfSwuxTHwQn6bpZTQ2xV5dvt1B
 Pzc75Uf9CA/3ngeH/JXBTlI9KSOTLFGQPW2mFopTzhjxlssNqz3Xz9K1wCsRF72P+L3V
 RQXL9iTk/ezQcyMew4ADufyjLITMz3Q+Ci25A=
X-Received: by 2002:a17:906:9fca:b0:c19:6117:b2bf with SMTP id
 a640c23a62f3a-c1f1f0a766cmr465621366b.54.1785176523270; 
 Mon, 27 Jul 2026 11:22:03 -0700 (PDT)
X-Received: by 2002:a17:906:9fca:b0:c19:6117:b2bf with SMTP id
 a640c23a62f3a-c1f1f0a766cmr465619866b.54.1785176522773; 
 Mon, 27 Jul 2026 11:22:02 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f5e717da4sm82222366b.4.2026.07.27.11.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 11:22:00 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v6 3/4] drm/vmwgfx: Reserve ttm object before resv usage
Date: Mon, 27 Jul 2026 11:26:21 -0700
Message-ID: <20260727182622.236086-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
References: <20260727182622.236086-1-maaz.mombasawala@broadcom.com>
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
index 9c7a73c0b0dc..3a739a761f3a 100644
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
index 3d0d5dfa869f..ef163d4b64d1 100644
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

