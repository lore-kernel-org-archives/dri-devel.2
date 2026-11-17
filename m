Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1D606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 00:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CsyHdCyc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCE710E3F4;
	Tue, 17 Nov 2026 00:58:57 +0000 (UTC)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BF210E3F4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 00:58:51 +0000 (UTC)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3b09c07b3d2so2593136a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794877131; x=1795481931;
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:dkim-signature:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/3+pirkV4hU8kigPdQ2cmat+uB7P3s7EMoAEVIGakSQ=;
 b=udwzTk6gG013yAnWbd9CIlP1yajawTjdMe7n+iat1M5ee359TIrmYcOeemtlSEhOtz
 CW+E2spbmGPSKW/Uv5cGbqaA2Nsuw7sVWGYpQ91ZF+NeWcnSdIpI8quCQCIWlyR4/zdN
 0t+zjcx8i5+GXMs0GxhiWyke4VxUKfGgNC5++RG92FEDesSg5R3J5dx3MknJkGhv6tNz
 RXwuMHxpgjxdR9/XYuGjHru5JARBTPyNXNOWQbujagk1Qxa3IwUxdKK9BbTtllZ1BvgC
 e2wwlxvEqYsaGpUUXhk5j45nE5VK3GbULrwBdt06tIBDCOiQiRkrJ6opQNA1Twt5DVYB
 Yh5A==
X-Gm-Message-State: APuU4Z+2XlgkhyB9y9VI30TXJFnb8czLoImKZ8HDW0b77/eYNHKIB2IQ
 o/mO+onwSzIaIPPWMSbCVvdJLb2YZtgCJev0lEkjdj+8d7aoWqK4IFGhry7hZuKy/ulucv5qaZ/
 qNzby94C/l7kPxfkXAm1mWYkITJblKlF4wrQZVrCVWoT+0niAYklYRrRgTSUqLuSli98pOtVm2L
 24/241PD5da0q3pdjG94t5lnIph4qNCzPORAw5YWBfAMC3LynVtnzQ3A8db33V2zCY0MTHxeqQA
 PYdgCkMPAxg9Mju2FADIZ4sOMmp
X-Gm-Gg: AZFdTZeuJeUV8H0cGTktuQbgowpUqbUPDXrkCpsZJdD6EsnlAA9u9sIoKghv1iFBX3A
 suxDKrSwoYuCgM3r2Vafr7+UjivnA06IUdoMfcAnLU0h5c7RulGAt0E6fPK8QFiCaH34KrqvHmQ
 RXdoNOW04Q2A01ADEkIsrTccuQCtE7StmG8/eZf6P0DXL5wNwFxtDrD34WVtBiHhCDsTXD4IjIi
 YO5e2BckDzO+FXmAhnbIV+5uy24sgVUnnBP1nr6pvOoRfTjvgvzw07HseZ54ZVeP4e9p/fJK2R3
 Wer12tgqgOsalChrALFpb3GKa8UaKiLTvQ1PPmNqAb3fmRdi7wPwwgRxiCOMe2OxIaEEXzAfd5n
 OZ6Zz6jFbB19hjFYqSqDeP1M7EMpmquA5vjyRN8NHePkd8aCnBrArx0fr0MixtPsd2gZY0ErUmH
 whB4v/fKZWZVUH3+H4sb6eQx1TNDd6JFeGQ9XnI6gb
X-Received: by 2002:a17:90b:3eca:b0:3b0:b64e:1e34 with SMTP id
 98e67ed59e1d1-3b1b0ba6480mr10969837a91.51.1794877130989; 
 Mon, 16 Nov 2026 16:58:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b1b24cf7ecsm6428616a91.2.2026.11.16.16.58.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Nov 2026 16:58:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so4131029eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794877129; x=1795481929;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/3+pirkV4hU8kigPdQ2cmat+uB7P3s7EMoAEVIGakSQ=;
 b=CsyHdCycEcovfw9+Ck5SAy+yQSlO/Q5HEE2z3SfsAU2W07vze0cbGfC2X38UOmqwKh
 vOKM5tz7Z5ORcu2dVjyUTBSb5ExQPKphHzNLpwlDJV5WROglwoWAkrbRAud1jCp4tT2L
 M2nZs1jBfjnlHXP0e6GIcJ77ot0EQEAERURh8=
X-Received: by 2002:a05:7300:c88:b0:36d:7f5f:7e97 with SMTP id
 5a478bee46e88-37967dd734emr17153077eec.40.1794877129296; 
 Mon, 16 Nov 2026 16:58:49 -0800 (PST)
X-Received: by 2002:a05:7300:c88:b0:36d:7f5f:7e97 with SMTP id
 5a478bee46e88-37967dd734emr17153021eec.40.1794877128298; 
 Mon, 16 Nov 2026 16:58:48 -0800 (PST)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm69147547eec.21.2026.11.16.16.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:58:47 -0800 (PST)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v7] drm/vmwgfx: Reserve ttm object before resv usage
Date: Mon, 16 Nov 2026 16:59:46 -0800
Message-ID: <20261117005945.806941-2-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We hit dma_resv_assert_held warnings, reserve the ttm base object when it's
being used to avoid them.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
2.56.1

