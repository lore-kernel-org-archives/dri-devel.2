Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863D21077613
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 133C510E7B7;
	Wed, 18 Mar 2026 19:50:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyDLkgdp";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A87A10E153
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:36:20 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-829a9d08644so4061040b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773844579; x=1774449379; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T/zERP7+K/iV+VDILg//lKZjo5Bu+2vkBPqMNeIXFFg=;
 b=iyDLkgdpF2s3sNcKFSnfLZzoIpaIZL0BLfQq+35A7Gis0Esth/UjVU+oMHaXDRw/aW
 OSgk2Fh0Jz7nYiNxqzP8ihYrIr6g0d3GSOIuV1MYHdT2+KAjY9ZDENmMY1EBfCJ69gEI
 ChgNyUWcZGNKB75nCANHrqPSNghAB6ZOj1HyIy1u9p+Qi/yFJdFgwA0yuxw/XOqsKzun
 300x6koCxvFUqP1fqGltWOf8D9od3GtJersWA1sTCz+VLn8CdcIgCzilqmRPRvSUALdj
 Bf0Pus0//J38gkNX43OP0wNi+c0QeKKY9b7GBpIKWw7fkNjJP2s6Djk+cer4cYNUKNnd
 A6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844579; x=1774449379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/zERP7+K/iV+VDILg//lKZjo5Bu+2vkBPqMNeIXFFg=;
 b=kzyYgvJPlSGdsB/ACWqIeioAsFuOH73eh8xfmbgoUmdJqQoKLDGK8BgV+tWsybdeHb
 7UnYKhMwBj49tJASS/IKr0P8XEBjNzjFY19qzxJ8UYgaA87eyyz2MYWID4QDDyEKIMQG
 z6OupG2YBlWjAxg3JDv5SC4Z9ivpdAFe13hwSciwjOosmChe/OOEutVdYBH9VFy/+9rJ
 xnW7RE8+MEadzVZwT9sraL3lCLNwm0INYJwiojSYKXuEyG6pPzZbm6vqupZcFrQ+nqbJ
 cexiLu0OQfWnqcqAEomENTlqVCFujTNLiXbYFxcpEplibRvv3w/Z1mwODPJOnSleEP0N
 oi3Q==
X-Gm-Message-State: AOJu0YzLvpwI+Hl1Bl3RIXP8nrpSu8tADCYWqVFbWb9UXIz3Cet3IfN/
 /a9JXdpcwRctinHK+OCyQyMxj/tNaO0/iXfi+y4uwiHwktA8BeI+CY81
X-Gm-Gg: ATEYQzxLoBxjXd06+TQkiAS9Q2F3gFtM4p7DFYUidWQICi/zKyQR6HOf6rxSGFLf2Xo
 f5fPC65AoEpfQqZTjWGD1xVM0LJa+kiK8SGBBahTR12t+x7il1W76Jbr+PZaJdg3zHrZyGlpFaI
 tO6ja5gGRTHfTnwLinkmgOCsV/o0Ajm0+UxudP0n4HBRVPrHDyMACdyd4PlsOi4YFTuKpfA4Wsa
 dmJZqHfSjAbvPcjrguhjB1lyWUhJDiUWIirLZcF20OYsLEOwuDox6I2Euh9U5bFVLGAAdUNgwRX
 nD2FsHWbqMDaOErrkz6/vYt0hZqyyZKTost9KkhkY1yZRSCIrRMr1ykSqraWEm/tSPeY67yY6TM
 FtJGVSiY/ZlhIPWn5DtCkcF7RpKy3P9gwnKeEIE/Dd/E1KIu9cX/TXw0PRUt6tNCgb8CABFe8oU
 sgA5YavjKXlfr4q6UhMf8ANfGiEENGFLtiQ2aG7ZKzc61j1kuN
X-Received: by 2002:a05:6a00:1992:b0:829:8aa3:2ebf with SMTP id
 d2e1a72fcca58-82a6ac3955dmr3503745b3a.2.1773844579411; 
 Wed, 18 Mar 2026 07:36:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6bf0cf5fsm3767592b3a.61.2026.03.18.07.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 07:36:18 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net,
 skhan@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/gpu: resolve kerneldoc duplicate declaration
 warning
Date: Wed, 18 Mar 2026 20:06:12 +0530
Message-Id: <20260318143612.2533863-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

kernel-doc build with `make htmldocs` reports following WARNINGS.

  Documentation/gpu/drm-kms:360: ../drivers/gpu/drm/drm_fourcc.c:397:
  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
  Declaration is '.. c:function::
  const struct drm_format_info * drm_format_info (u32 format)'.

  Documentation/gpu/drm-kms:491: ../drivers/gpu/drm/drm_modeset_lock.c:377:
  WARNING: Duplicate C declaration, also defined at gpu/drm-kms:48.
  Declaration is '.. c:function:: int drm_modeset_lock
  (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.

  Documentation/gpu/drm-uapi:607: ../drivers/gpu/drm/drm_ioctl.c:923:
  WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:69.
  Declaration is '.. c:function::
  bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.

Add :no-identifiers: to prevent duplicate identifier generation and
keep the function documented at its implementation site.

No functional change.

Link: https://lore.kernel.org/oe-kbuild-all/202512302319.1PGGt3CN-lkp@intel.com/
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 Documentation/gpu/drm-kms.rst  | 2 ++
 Documentation/gpu/drm-uapi.rst | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 2292e65f044c..0f0f90b3186d 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -356,6 +356,7 @@ Format Functions Reference
 
 .. kernel-doc:: include/drm/drm_fourcc.h
    :internal:
+   :no-identifiers: drm_format_info
 
 .. kernel-doc:: drivers/gpu/drm/drm_fourcc.c
    :export:
@@ -487,6 +488,7 @@ KMS Locking
 
 .. kernel-doc:: include/drm/drm_modeset_lock.h
    :internal:
+   :no-identifiers: drm_modeset_lock
 
 .. kernel-doc:: drivers/gpu/drm/drm_modeset_lock.c
    :export:
diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index d98428a592f1..73b49e0dcda8 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -603,6 +603,7 @@ DRM specific patterns. Note that ENOTTY has the slightly unintuitive meaning of
 
 .. kernel-doc:: include/drm/drm_ioctl.h
    :internal:
+   :no-identifiers: drm_ioctl_flags
 
 .. kernel-doc:: drivers/gpu/drm/drm_ioctl.c
    :export:
@@ -761,4 +762,4 @@ Stable uAPI events
 From ``drivers/gpu/drm/scheduler/gpu_scheduler_trace.h``
 
 .. kernel-doc::  drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
-   :doc: uAPI trace events
\ No newline at end of file
+   :doc: uAPI trace events
-- 
2.34.1

