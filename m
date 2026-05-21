Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECBCCD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 22:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F0C210F422;
	Thu, 21 May 2026 22:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="GtB4dia2";
	dkim-atps=neutral
Received: from mail-oa1-f100.google.com (mail-oa1-f100.google.com
 [209.85.160.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E8410F422
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 22:35:10 +0000 (UTC)
Received: by mail-oa1-f100.google.com with SMTP id
 586e51a60fabf-435153d9b68so4593118fac.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402909; x=1780007709;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDKFuLv6AxprCwra6j671WX8fMGEO4TQYdVYH/Kucbg=;
 b=IK48NkFeROOZa2mYkL5OJVezvp76tSJFdTLtiNn5GnZEz5Ig6Kbli5Te6CUMza45JT
 JtChjyJFc5DOD+fJOnuAAk9JlGUyPMfgHK+DxVC7m8lSdjamjG+uzZqArxPfwjQjSGpG
 4o2KbKPLo3tLBfTHF/AFTLkmx/qOBisPU1gEzNDuxcIj1+U/q4Wwehi3OAR1JHJ5f57E
 RLYZ8WPv3R7zQfzPygpFA6SMquwhW03Xu4v+2G0aVU0JVchKsG2l41OyAlqctOgneWaz
 YuWRtAhicOZz4s6UQTCp5wH2JhS/0cLD8xNQosOWgyk+Lb/Oq/sFx19LdiDQe/OcCR0j
 MncA==
X-Gm-Message-State: AOJu0Yy3iyIHa1tNhoc3yZn4BnlZQnaMFSVd6zVTEI8jWw6FSmLTN3P+
 7Yl7ZmlhpYDD4vy01jCFgVYfGH458RUmgPLcGGOS2URzLJF/oFWzffUX47DXygTMZdASULQOD/p
 OEo2BoX1EaXV0irFYlAJ3N4wzPs6it69jqH0DvZEhiw5Sl1N43iYIxJrpLXiMXVEpaV69PUl3Gy
 +nklmMHMeC0RthZ8Up/Bu5sqVrJZrQz0xKKIF5P80BeCiYkOFaoQPWJs4hPOWDdBO2OhK27hWoX
 zXpAb4eDfaun0bdYPrlF7plx2ET
X-Gm-Gg: Acq92OH8r2mpj8wKZ+VTaEW6Mh/bK+qA2euZpp549AeY896f+ulQi7riegeGyp2K3WI
 eqemI/YROdrBKmphuf2lY5Kencc/7gO3n0nN9Cu6EhWsFaHIt+N2NbPNdo7MNFaalqSUQUEbu+o
 kYQJD0c+UczyWBWceVk28GBMA85lyx9/98JqaMorfrt+1/n5myCu2zGkgv79VHhkCWrpLUVDQ/I
 93aoKBuzx/Pa5puKan/JEMmPMbNfWP1Tgebet3RuoHiMNEhew25VxnmJ5TMvY6dQRhM3f3rA835
 HMhOcErmUnph2XthZv+nHPIdCQCPqHWKKy92lLQ+np6LSpnf6uQOjeMpt26ZudeYf6b9HmvR2sY
 d5o/2zdAC3oor53ivsMt3RyPay+OBdnHuLNHTqAwettcoBwuppw4RjO3uFZWW1T/lAqkJx3xS7k
 m/UOqdYq8ozwS0q2Gdo0HuxXxDsaXKAU5bfDZCTRtY6r7ftR0Q8fQeKJg4837VD6KX
X-Received: by 2002:a05:6820:808:b0:69b:34db:20d4 with SMTP id
 006d021491bc7-69d7ec40c0dmr598345eaf.32.1779402908862; 
 Thu, 21 May 2026 15:35:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69d809c481esm25172eaf.18.2026.05.21.15.35.08
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 15:35:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5165d10e036so100634321cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779402908; x=1780007708;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UDKFuLv6AxprCwra6j671WX8fMGEO4TQYdVYH/Kucbg=;
 b=GtB4dia2/JuzDdXfN0ZvBJQQl8bU1PFX5AdjegYiXSh6hw3iQuS5w8GMr1yj3IkW9J
 UBFiP/Am0z18102B+o0rSJlgGDaoN6NJCKzwnoVGIthcQEeff8FB8A5SdU3LBnztqH+k
 X4b7L/b4kap3bTBs2iWVy7+EkNafm/GwVjyNI=
X-Received: by 2002:a05:622a:8d04:b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-516d4b14caamr14281331cf.4.1779402908026; 
 Thu, 21 May 2026 15:35:08 -0700 (PDT)
X-Received: by 2002:a05:622a:8d04:b0:516:d4b1:48e4 with SMTP id
 d75a77b69052e-516d4b14caamr14280891cf.4.1779402907484; 
 Thu, 21 May 2026 15:35:07 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-516d6438582sm3351451cf.19.2026.05.21.15.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 15:35:06 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v4 3/4] drm/vmwgfx: Reserve ttm object before resv usage
Date: Thu, 21 May 2026 15:37:55 -0700
Message-ID: <20260521223756.627311-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
References: <20260521223756.627311-1-maaz.mombasawala@broadcom.com>
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
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c   |  2 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 9c7a73c0b0dc..6817e0b8ce99 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -55,7 +55,9 @@ static void vmw_bo_free(struct ttm_buffer_object *bo)
 			/* Reserve and switch the backing mob. */
 			mutex_lock(&res->dev_priv->cmdbuf_mutex);
 			(void)vmw_resource_reserve(res, false, true);
+			ttm_bo_reserve(bo, false, false, NULL);
 			vmw_resource_mob_detach(res);
+			ttm_bo_unreserve(bo);
 			if (res->dirty)
 				res->func->dirty_free(res);
 			if (res->coherent)
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 7b8163b5e501..da6ccd5e318e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -131,6 +131,7 @@ crc_generate_worker(struct work_struct *work)
 	spin_unlock_irq(&du->vkms.crc_state_lock);
 
 	if (surf) {
+		int ret;
 		if (vmw_surface_sync(vmw, surf)) {
 			drm_warn(
 				crtc->dev,
@@ -138,7 +139,18 @@ crc_generate_worker(struct work_struct *work)
 			return;
 		}
 
+		ret = ttm_bo_reserve(&surf->res.guest_memory_bo->tbo, false, false, NULL);
+		if (ret != 0) {
+			drm_warn(&vmw->drm, "%s: failed reserve\n", __func__);
+			goto done;
+		}
+
 		compute_crc(crtc, surf, &crc32);
+
+		ttm_bo_unreserve(&surf->res.guest_memory_bo->tbo);
+
+done:
+
 		vmw_surface_unreference(&surf);
 	}
 
-- 
2.54.0

