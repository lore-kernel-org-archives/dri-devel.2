Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89090F3028C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 22:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1FE10E102;
	Sun, 15 Mar 2026 22:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IIaa7nqr";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8B310E096
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 22:34:44 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-439b790af67so3700704f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773614083; x=1774218883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=22ovE2K16n5tTLqzy0s1QaiwyRfQv18z/gESU5TwKDI=;
 b=IIaa7nqr07F04l/oOoCQbsMd59tJNdYWgFgLX6iyJjtzV++deocZ32q+fWv4gR+wE+
 gJWYdidA6S9a/lLji9d30J3dlpCCa2knmpj2hpb/dLxmoKpA8/+p/N0hcpfiZ4p6aH8m
 FjWjlGzEZQ6nlGsr6MqlJOxRg+8yoBiZsPKjFwlM+vjDuzTYJaJkWOxb9atAVx/E6vLY
 277cD1iquZhEWZTH59cRTfuYE/vRFTgKhjbQPXCOLRiynFbgpTqLx9FnWkGu6RA4XQ6B
 d1jWF8ijHEtf5pC7zIWV7D+YogfA4QoFZojCPQqJ9fZeZRXuaS9PVRvfjMj6XARt7zxP
 O3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773614083; x=1774218883;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=22ovE2K16n5tTLqzy0s1QaiwyRfQv18z/gESU5TwKDI=;
 b=hby0EdUg4URHsIXMbpkUbcNzEFQsx3rEViEkm4LZ5qagr8yKjADwF6jEbTO9eudEtp
 LBwPX5t6+1yzrHI1Bs7NzkyXyAPcRbNgyOL4N+ZGMo1Zvsoi19cLjDNCvrOmU9wmaPkh
 ozCkgB15IvdsJQ1SkXL/GmWJHWDogRQhFLOhhl80pijy2VGUz7noXZFsurS6WAN/X+j5
 YiDB2lcgAGqDOrxsIunJnynHKhSIiMnsNMGoqozk5dnFfT0CEhHFuNG2hVVk77izntr3
 M9c7aDiYOdDKeh/+9DQI+X6iR+co+FBqmtPaNC1kcui2eREeG/9tyS5t6EJLs2cWiGPR
 QyDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWC+N6B/6ewQCXaY19mUq1p4H27Ij2v4tEQSBE4Q1OUKx18QqtwuTh8IdX8Q7/rhlGGD8hb+wQ5K2o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzybYaFWTshSc4m1p4iJISxn8WGPEpqtBHBt9zDh1NvjfvCB9AQ
 6mJdyRSzbuJPkL5GaPL++Peh31or95QEnL4ghR/ZpP6fT+PcFGKF2dqG
X-Gm-Gg: ATEYQzwG1v/G3fcN164tFFJJ1Sa0xpEKDY6Z1eHRHPjdQOkFWBq+rReOmU2EprB5ekV
 KDityF4t9nM3fReB5RUA01iSUmqKD/NPIQ7r8iHwBEHGaW9Cas60edJGeSzvBD61CiKlFZiy6w3
 tHILJgQhYSC04xj0+F/VuhPpeiCIWuPDIIS7a2iF99pYdLWzHJ92oUWejwDnaZvdqH5Ihg03GOC
 jD8jChCZnVddWghdOW6k5nTCiGneOLn1jBNKWv+uHi3W7nUO5uWfblj9QboU5K2NXBPj8zBiX9J
 lHL/PN/HpSxub1+CrAOUmIbPfmZdOJ7llJbLPdDlRfNt5rG/t1EgpJC/KouKH3daJA3CUhWCXiV
 kKZ05DqBZdECLQJzvTlX1l5ZWSwoBLs0hlxUFs69XZXlwiSAxlPMETmVG43LE99q+q5orrwcukW
 xNbig2h7Xy75uSz9X8PYjvoaegHyj/Fo2c4IzV0X7+nlHXmKQh0YnZf6he0PkdQbQkeFIKXjuUQ
 a5CgMVNN17dT2Qoc4n8
X-Received: by 2002:a05:6000:2313:b0:439:b775:fca2 with SMTP id
 ffacd0b85a97d-43a04dbb74emr19341850f8f.24.1773614082441; 
 Sun, 15 Mar 2026 15:34:42 -0700 (PDT)
Received: from localhost
 (p200300eba70b6e00ca7f54fffe019321.dip0.t-ipconnect.de.
 [2003:eb:a70b:6e00:ca7f:54ff:fe01:9321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe228986sm34022943f8f.35.2026.03.15.15.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 15:34:42 -0700 (PDT)
From: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Johannes=20W=C3=BCller?= <johanneswueller@gmail.com>
Subject: [PATCH 0/4] drm/amd: fix HDMI output with non-HDMI EDID overrides
Date: Sun, 15 Mar 2026 23:33:02 +0100
Message-ID: <20260315223307.45807-1-johanneswueller@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series fixes several issues that prevent amdgpu from driving an
HDMI display at its native resolution when a non-HDMI EDID is injected
via drm.edid_firmware or debugfs edid_override.

The motivating case is a Dell U3011 (2560x1600) connected via HDMI,
whose native HDMI EDID only advertises CEA modes up to 1920x1080. By
injecting the monitor's DisplayPort EDID (which contains the native
2560x1600 mode), the correct resolution becomes available. However,
amdgpu then fails to drive the output because the injected EDID lacks
an HDMI VSDB, causing the driver to treat the physical HDMI connector
as a passive HDMI-DVI dongle, and rejecting the required pixel clock.

Patch 1 adds an edid_overridden flag to drm_connector, set by the
existing EDID override mechanisms in _drm_do_get_edid(), so that
drivers can detect when an override is in effect and adjust their
behavior accordingly, without duplicating the override mechanism.

Patches 2-4 fix the amdgpu-specific issues:
- incorrect signal type selection when an override is active
- unconditional rejection of all colour depths when max_tmds_clock is
  zero
- force_yuv420/422_output flags being silently ignored when the
  display doesn't advertise the requested format.

Tested on AMD Ryzen 9 7950X (RDNA3 iGPU, DCN 3.1.5) with a Dell U3011
connected via HDMI at 2560x1600@60Hz RGB 8bpc, and another Dell U3011
connected via DisplayPort in the same mode.

This is my first code contribution to the kernel, so I would appreciate
feedback on whether I've gotten recipients and other procedural details
right! :)

Johannes Wüller (4):
  drm: add edid_overridden flag to drm_connector
  drm/amd: fix HDMI signal type for EDID overrides
  drm/amd: treat max_tmds_clock==0 as unconstrained
  drm/amd: fix force_yuv420/422_output being ignored

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  9 ++++++++-
 drivers/gpu/drm/drm_edid.c                    |  2 ++
 include/drm/drm_connector.h                   |  8 ++++++++
 4 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.53.0

