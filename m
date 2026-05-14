Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04723CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C32810E3B4;
	Thu, 14 May 2026 15:31:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="H7/NlaBL";
	dkim-atps=neutral
Received: from mail-dl1-f99.google.com (mail-dl1-f99.google.com [74.125.82.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4676F10E3B4
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:31:24 +0000 (UTC)
Received: by mail-dl1-f99.google.com with SMTP id
 a92af1059eb24-132d1b2519eso2423059c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778772683; x=1779377483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiiMwMQkMF4onXIChH1lYTnku8BmtUUkKPq5vqd+58k=;
 b=sRDgIKiaY+uYQ5F5oa4No2kbw6S96DNRBtg8RZ1ypOr+1ThRjIqhy7wLKxcyRCZNet
 mHK1m5Uquun4raLbkiBYlAm5nCOp4uxt6bIya4DgrXkbKtpDj3oJnJBE314TFvvQTS+S
 HQ2zsXY5fL6Qq+hMF3H/EmFYAt/UUCBdwacU6scrJQrtqHoI1+k0dscYMq3Q/1fMsgSr
 FdcziqEaS3ABb3bo+IittcKDEIlJjiHgUMl1C+aNapgFfAvMYtuxgcxFtxiyxt5fN7ru
 65vzyTp7e6NNJL3jBXYAHL6YIfRIO/Fcp6o8qrp1Lo37c+PHnDU9AHkPbR8mwv7fxqhG
 K5ew==
X-Gm-Message-State: AOJu0Yxd2sUDHfrgt/yayT4PQAFHfoCYqexx3s67wo+cIBOQq/5/7PuA
 qiqhkZ8OZW89XyaRK0JtDAXyxvVXVMXhWd/3s4O4NVktv/l87W+zl/39bCQ5FiYzOPF9+pkN7ht
 UlydyNc7iQnb6N3WyT/NCNJiwQ+tV+PRHgvrI0/qPRO1l1rouM9oNzOyACBWsyY333HpL4gC+ak
 PlcSYCk66sTumN+0awpyJUe99aw6L/fmegvZr6ixDOqiAfUDxYd6QZx9LtF8FpLqVVlAtujFqot
 szIZR1/KEvg34OIGjnQ
X-Gm-Gg: Acq92OGrwqrkmh2S3PGXBxKQ2R76Xowu/D/BG5vP3H90px44KxraCsvDsyH9tqF7p70
 gohZvBuKl9loxFSaetPa4gaSySQdsOdYn/ZWBG7mxCbrMXTIBAFwe/ME2K1N2XNHkg/78jYbWTi
 4jbUvL5dlkVO00WX9eXhzQ2MEVD8tLj530TBsZidkFKrOCSd+Kmg3tcUDEqC8PK6b87GtolknqQ
 T3G6GdYQyod1MchkhUGKhbdWc5dR7/N9SlKfqhWwJJHSFA1A95N9UeoIHU6/uUDbGLtlEcotL3P
 0gTxiv6f6RkNz5ZKM13Cjzr6G1Ku26cXedFC50xpqAsEQpJpzwU9uwZjA//lWv9AvuRardxSVw9
 1jRJ+GSSmzddkEiJr6bJhzrFXuncQJIYSQ1c2hgzgu/HfgV9EKG4ySpOdEZ/IyY+cQf2UzWhBEC
 olrMWyqxbsyrSUw4++pYQM7zn856+E+nECuq5x3brcHRQmRUZbzHswfve+VeiLW8Ej
X-Received: by 2002:a05:7022:e984:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-1349ad7e67emr4683613c88.39.1778772683218; 
 Thu, 14 May 2026 08:31:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-134cb5b5ffcsm349042c88.0.2026.05.14.08.31.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 08:31:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-639389de134so370496137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778772682; x=1779377482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tiiMwMQkMF4onXIChH1lYTnku8BmtUUkKPq5vqd+58k=;
 b=H7/NlaBLcTXJP4Kd4txxSL3tPtBiJpCoZ+fzDV3vPl3wasiY7MPcKJhey+hLO3Ngl0
 +/sGOK3V4ZDfLbAoE80Net8f1G46InIdvXEUUvOaEPmpOePAoByPBQGaS/dTd+1eaDo1
 KND+Qre7qpCBsbz+ZGZde2JuM1fYN3FbCkBUo=
X-Received: by 2002:a05:6102:cc6:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-637a9af9d40mr3785853137.20.1778772681671; 
 Thu, 14 May 2026 08:31:21 -0700 (PDT)
X-Received: by 2002:a05:6102:cc6:b0:635:1bc8:3563 with SMTP id
 ada2fe7eead31-637a9af9d40mr3784708137.20.1778772672413; 
 Thu, 14 May 2026 08:31:12 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bc83b85asm268098085a.25.2026.05.14.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 08:31:11 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, michael.banack@broadcom.com,
 Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Never destroy STDU zero's Screen Target
Date: Thu, 14 May 2026 10:31:03 -0500
Message-ID: <20260514153103.1465013-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.54.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When some VMware clients connect to a VM they query the existing screen
target information to create a window of the same size. If the VM
display is asleep and the CRTC is disabled we don't have a screen target
and the client will not create a window which may lead it to have no
way of accepting user input.

Without input the VM cannot be awoken and the user is left with a blank
screen. This can be overcome by using the 'Send Key' command from the
client's application menu but this is not an ideal experience for users.

This can be fixed by always leaving display unit zero with a screen target.

Fixes: 7ef91dcba172 ("drm/vmwgfx: Don't destroy Screen Target when CRTC is enabled but inactive")
Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 4139837f4caf..5ad7e942ceb8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -448,6 +448,13 @@ static void vmw_stdu_crtc_atomic_disable(struct drm_crtc *crtc,
 		    !new_crtc_state->mode_changed)
 			return;
 
+		/* Never destroy DU 0's ST so that the VM client always has a
+		 * window to accept input from. Otherwise we may never receive
+		 * input to wake the VM when the CRTC is disabled during idle.
+		 */
+		if (stdu->base.unit == 0)
+			return;
+
 		ret = vmw_stdu_destroy_st(dev_priv, stdu);
 		if (ret)
 			DRM_ERROR("Failed to destroy Screen Target\n");
-- 
2.54.0

