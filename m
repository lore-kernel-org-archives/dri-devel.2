Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E028CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E2310F35D;
	Thu, 14 May 2026 22:46:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="MciDwja4";
	dkim-atps=neutral
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE7D10F35D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:46:10 +0000 (UTC)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2bc7b311e77so1587355ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798770; x=1779403570;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDKFuLv6AxprCwra6j671WX8fMGEO4TQYdVYH/Kucbg=;
 b=WinDouMv9W7RhHxp0mp4Mk3RgcQz1H2E8+dXV0QG1KBJi5tc3S3qxbmdAuEVKQYpmO
 OsU2l5PTVRYdAQ+FThTsTBb/FdJeq5bM8bA777YT6O9/eH04ADbwAXDkjgR4yKtRbGDr
 qTs2+aaFon9LxVn0l7wCiSxTHkEhWL6KRRbLuPwLuJU/W2eJa48NCmOZRWwsSVe0XHEC
 LYbe7pd6t5d5vi36A7xHZr2UZpeDrs7l93CB+AWnqkeOkfNCmpGoaks7P8e0upB+icVZ
 Xqmc4nWzdnxVWuQ1dF/gybBL/AJmB5N1zsd2CnrjwRp2TuNtc10fBSiRpRv0etvQlr46
 Zojw==
X-Gm-Message-State: AOJu0YxoTQ1EwDb4SrTEfJLENOmAqRO9Aj7qnqSLgMCHMOmqMabeHYsB
 RwOlrvG0jUtpwOGFOyH4grdCWNVUCKR+b0Lywkl0WbhgtnmYFHYG4zoo8FApig/gv2eB5hSY9OJ
 PlUVX1qzLNKvUmc4dSG+MoO+ttEB7snwCewTj5ueSvF9q+dWC71meHVJlEG+DYPmYv19iieEw1L
 SJ0S1LYWkJj7mCDBOGgrevuI1uh9Ji6IVeKaXlJLWCxSQIZP9z6Sr51UaXKSpuzfwwh2JTLoVnN
 KS13kNlknkmNxtN/6dCKPEo0WdbLKA=
X-Gm-Gg: Acq92OGsKswo/ts1LWtTiHPDC1/qxK5b/TDkRS1FJOQVlijxdPOOCCdv3Q63+reWZiq
 3mdUNG0N5Ggmz1RVVWfGfRyEOWg5P5oBKAXGjjV+o4cBzWYfLmwaGaGidIR8EwLi3fmsaqQO+eC
 HZzricvqaxYxYyvHNY68wX4OoRitPXJJg5pWWJ2npb9Nhgr0ZAn8e5GVchDzhjuH7ADS1GFxtII
 tuf9+oKlbiRjDcQPGXfGZCYGpqWmn6xUWxgi0Vw9Z725Fqbi0Ce8DSVIy2HQgyZX8KVXNwI4gU1
 JdrXXOO/VGTaJJKQ8gf2ePjl1HDQ/KFnWrp0rAp3bb9O2FVTfxGKH4EmjHMBR94unvUO51FXD+x
 aMTfAc8CTegxW4jgb6Sd8OXm0C+q9uXP+6v/1VnRvk3ozDt4vRCPm4UL7ewXWlIy9dj1TpGUVVM
 w0xCX1nuKj1A==
X-Received: by 2002:a17:902:f78a:b0:2bc:cf06:221c with SMTP id
 d9443c01a7336-2bd527d773dmr46191395ad.21.1778798769769; 
 Thu, 14 May 2026 15:46:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 ([144.49.247.127]) by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-2bd5c35d715sm3052635ad.24.2026.05.14.15.46.09
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:46:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2f1383b7439so285549eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798768; x=1779403568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UDKFuLv6AxprCwra6j671WX8fMGEO4TQYdVYH/Kucbg=;
 b=MciDwja4F1fcnJZKedEw7PcTlS3jDH9Q8/QCPv4gRl+Nfj+1ClGnsnpCOqor0AhQ4j
 jF9RyWVMyq6iopd+bnAElbd4TomNavA0/ve4GPsttCWGUsnYtA27aeDdEHdWfw35CS6N
 1kW8uZkfhC8TZnKKPEfJF+ER3boSH5bSabw4g=
X-Received: by 2002:a05:7022:4587:b0:134:d3bc:b4b4 with SMTP id
 a92af1059eb24-134ffa55146mr767672c88.4.1778798767904; 
 Thu, 14 May 2026 15:46:07 -0700 (PDT)
X-Received: by 2002:a05:7022:4587:b0:134:d3bc:b4b4 with SMTP id
 a92af1059eb24-134ffa55146mr767651c88.4.1778798767138; 
 Thu, 14 May 2026 15:46:07 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:46:06 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 3/5] drm/vmwgfx: Reserve ttm object before resv usage
Date: Thu, 14 May 2026 15:48:17 -0700
Message-ID: <20260514224819.3631763-4-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
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

