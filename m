Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389B7C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D68B10F084;
	Thu, 17 Sep 2026 19:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iAR2/6yS";
	dkim-atps=neutral
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EEE10F084
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 19:15:25 +0000 (UTC)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a60591bb18so868493a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789672523; x=1790277323; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
 b=iAR2/6yS2LRdsTLru3rvafZOFu5L8Nn/Rw0XQarPxcvuYNhLm8G7c/31K2O+DOw2Uu
 zExKri7Z/6IbD6lEjejm/uCcO/crSs1SkUWPtgJIMxK5P/qDNOJ6ifqg3DzFGeJxaH8v
 QmvYqo6nUdaXB2kA5XZjBnOjbviE2A/QbY5J6/GytyLPX4iASH91vWTPH9Boigv2KP/w
 S5xRZTjZkDcprW+Ih6eX+l6rJd+niQMPcQFRyhSoaF+Bwvxai75mKK6/nFD+VvgBIBFw
 8iVXnsWnKxbyCXIVfl0er9tKMMNQoUWneo7wuLxweXjnVs92oSsG35B3t9n3olxDgYoI
 xCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789672523; x=1790277323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UVO42avi1AUnneieHW+g4jz1dvgdxwcJ0ctKNKrRziI=;
 b=zo84SJ+3NdQphg5I55Rl22VDg3Fs5lIV51Gr+pkT/PWbOx0GvngYh/jAmXlCeFImcE
 xu0tTxg8y4d9RWnkXG5U3cFSWxfbM9kKGnktKkWam7XNX75qNH1Mc3qe0xzMtSCtA/nL
 yAIn/RA5tXCeEiDIBh4lWOG+Y4hVOgNuvbRYLljryvTEYqIP6HEB9lxKDsAu3cnWH1io
 TI/i9Td+HyKrTvHG285ZvBMeu1/rKNtlAAp7HhbDb0iXdQN8SQ1FHsEkJinc6As25lF5
 5i8x6J9XJp303QaePSA00bzGqwcoLLzBYt9pyj+AeM7CjV7FXy/2vh1Qg1ShkTEiofIv
 KVDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxm6xqNMrumsPp5brD0f0VHDHYjA+lmvNGuPEG7XCbWYtJgn9ICj53FT3JutwgQt3oaU8lCt0D4S3w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8AyXGPDZQVqUlstjb3zci25DDPzCzGqNBEgOZUcIeU/t5yOmO
 djit3peY82zmlegTq7JL891624ZqiBPeR9AudKpa/vC11wNkuERVB68S
X-Gm-Gg: AYBFou0CY4NZ8UV9B/ptDb4v3S09qFTCU3WiftDVWEF4mtqTn2EBet999GX2y7/7SSy
 s7VnfdVgu6knmtSVXyEFm36adtFsYoVl1Ufw9xiBN4uo1oHsQxecpBNMjDP5GonsEKR91hudFN1
 xbrunuWso7SC1EqR5isy9RDkfe2NY2ZXY8fBXYMAxlSrNuy0Gdq0gQQpApv/CbYNFWMiuZ9qFAT
 3frRorvSYQSI7M8ZeMrrK0j0JBkZ3zvX6gVNXJkDUmfjhM/xU73HOULt3nZBpFHXITf7bzbAmjW
 fp0RUFHOXdJWiUWyeAXF2COS8sDcoviePwA2HKs7NwWpVN5nKN3SgotzB2IYwbY9GBO7i1WJI9D
 GBZ5wqP7TLfQ0A6O/0O2KoeR9VSToYs93ArGGE6tx0O5e/56jYP2pO2ioMhUbJvgD4LZLGea+wV
 qvOTJI/EZMC2UryVhXBv/u7WOCYAsvOnr8D2OBkwE8S0Ekkv4JxPZEK/3xwmkojvniUO8=
X-Received: by 2002:a17:907:9703:b0:c24:6382:2648 with SMTP id
 a640c23a62f3a-c2a16403e1fmr9238266b.5.1789672523059; 
 Thu, 17 Sep 2026 12:15:23 -0700 (PDT)
Received: from cartold ([77.213.69.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de454b4csm333264166b.17.2026.09.17.12.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:15:22 -0700 (PDT)
From: Theo Andersen Carton <andersen.theo@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kai.heng.feng@canonical.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Theo Andersen Carton <andersen.theo@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: skip the noirq suspend reset for a
 switcheroo-parked GPU
Date: Thu, 17 Sep 2026 21:15:12 +0200
Message-ID: <20260917191512.38838-1-andersen.theo@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
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

amdgpu_pmops_suspend_noirq() resets the ASIC unconditionally. When the GPU
has been parked by vga_switcheroo it has neither power nor a PCIe link, so
the reset cannot reach it: pci_set_power_state() reports the device as
inaccessible and amdgpu_asic_reset() returns -EINVAL. A failure there
aborts the entire noirq suspend phase, and with it the system suspend, so
the machine cannot sleep at all while the GPU is switched off.

amdgpu_device_prepare(), amdgpu_device_suspend() and amdgpu_device_resume()
all bail out early on DRM_SWITCH_POWER_OFF. This callback was added later,
for an unrelated reason, and did not inherit the check. nouveau guards
every one of its PM callbacks the same way.

Bail out the same way here. On a single-GPU system switch_power_state is
never DRM_SWITCH_POWER_OFF, so this is a no-op there.

Found on a MacBookPro11,5, where the Radeon is powered down through
apple-gmux so that the internal panel can be driven by the iGPU instead.
Every suspend failed in amdgpu_pmops_suspend_noirq() while the card was
off; with this check a full S3 cycle completes.

Fixes: 9e051720f9d3 ("drm/amdgpu: Ensure HDA function is suspended before ASIC reset")
Cc: stable@vger.kernel.org
Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 5c33c19fd9bc..d9d794a7db96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2664,6 +2664,14 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	/*
+	 * A GPU parked by vga_switcheroo has no power and no PCIe link, so the
+	 * ASIC reset below would fail and abort the whole noirq suspend phase.
+	 * Bail out like amdgpu_device_prepare/suspend/resume() already do.
+	 */
+	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
 	if (amdgpu_acpi_should_gpu_reset(adev)) {
 		amdgpu_device_lock_reset_domain(adev->reset_domain);
 		r = amdgpu_asic_reset(adev);

base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.55.0

