Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A8606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iJNAonnn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BE361129DC;
	Fri, 23 Oct 2026 07:28:24 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD99B112524
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 11:48:20 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-77bf892b496so598308137.0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792669700; x=1793274500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cG+5kIyh0kWAXD1Yf0rWfPRytbtZEq2h4IvreLdn/S4=;
 b=iJNAonnnzXgm40q8uQj4Ij/lO7pqaigYIXUWgD2UT1/S+86wnyZjf9bwL6AD67qm2P
 px8iOu/diRKkKzdySlXWnTEL8S1m7prGOX0wb2NPuVbq1J7VV1kYExf/yncl5pxW0Z2A
 TvLEAjEmemF7p/eSyRR7P67xK9BN1TQ6nxv6AeFRCIdGLx6GaVXZRV/PuyHzoSazf2eV
 GxFmU6apg9puxZjS3Ih3PyNHSqUorVTzr1Yq8ILNYCFwYj9zzBsUO0qqvX/rs9wNs2d4
 Y7+5jcTyCZfvE8XJiHxRWC4C4sb/AESWoky40vylUYmBP3lTzsAb0oFmUO6mhHo/l9ms
 5UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792669700; x=1793274500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cG+5kIyh0kWAXD1Yf0rWfPRytbtZEq2h4IvreLdn/S4=;
 b=G5ODoFHIT7JAdB1Efs2r9uTCa5uDuJKJ2w6L10FCfv2zBWU6ifJz+8wUC5m8s5bcGi
 cIl3qDn3Bi/pjZWcfXRFj8kvvzyXXgeRv1aqeiiQWKiNVhoX7q6QbOYZz7KbdSwtEMiF
 mpGpliFD16qOQ3k4SZoWOhetQ14bZWvP+5JnFHoKcW5neV37+ClgPh9+Raj8aOBl0LJ1
 TeYxrZKQtbEjjr/TX+uy/L+uo1s8iW2F3fyUc5N3VINO0kvhZEjbG4shOayPttrcVk09
 krjq2bJJ6sVnvvRNREjRhejQOEl0vmxKEcP7nMfCILaUKeleWty7+y9WwkYpEi7ETenF
 gV0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/FmkjbZlGK0Z3HAyClxj/PFsHMKU7VXg7zBuWI3P0aGqCFUp7z9xaNv09AZoVa38+StkHhlj2xzg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI/NCr31drAuJWFGgINN3aJc00+vfTTe9QIlxTwfxl2+aicYUDa
 jlpAXScUlqdTgrV5j2LVLsr5CmTrDMQ/yS6iqHHcRshp8jBK9lpuZvmI
X-Gm-Gg: AYBFou3/iAHzveSU1MD2QZuHeUGYA7GJARaVPeISvCv8dnSFPurcIUZ3ABuFhbflJVi
 ME1RNmF3mXBrz3jLUbCAtpMbcwAYGuxewSNRaJDcLGkhG60yGLibPDT6uZUkt9ruybYGPjO3Xxy
 sVfZq17fK+0OKNjl9Cby5tP5PET/ODkakksLScDH7W7u9AO1er8i7X2kU2yhImOq7xS7y/oNvzZ
 ZoaBnT2RD7zqHAHK3L9sXIn91FDxnnywxJv2HqeVUiM9k6zXf8AMWvU0xOgWKL2hSv3FlIQ2b+Y
 +0n3BUifUk2ApfEGmNGLK1YmU9PrCr24l31JbuwsWEpV+TkJXiSxeen+3A/Io5TEgMo7r4IT2P5
 F4FqLL2QQGAxDcrVHdqfkgaupsz89cUYT5dVsR43awAbAozhXvpRxg6uU1Q71B7cjEIdZI7QD68
 91MV9vhRcCHHPYDPQEUD7roDWjAe26HeygpAzymfuWLuoMnECQuXG26Eqlfp1RKz76Wtu2/8R/t
 P8dBeRzVIojJbkZl1crUMf+Q819vjZOh9F1VKkzinDs97RWFW78sCAXPEMuUzgMHVNDszE=
X-Received: by 2002:a67:e711:0:b0:7a1:fa0f:1106 with SMTP id
 ada2fe7eead31-7cc927ffae5mr1735239137.36.1792669699746; 
 Thu, 22 Oct 2026 04:48:19 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.104])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d117c005sm6177793241.9.2026.10.22.04.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 04:48:19 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/radeon/vce1: enable the VCE trap interrupt
Date: Thu, 22 Oct 2026 08:47:47 -0300
Message-ID: <20261022114754.865669-3-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022114754.865669-1-mptagliari@gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 23 Oct 2026 07:28:18 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

vce_v2_0 sets VCE_SYS_INT_TRAP_INTERRUPT_EN in VCE_SYS_INT_EN so that
the VCE_CMD_TRAP emitted after each fence raises an interrupt.  The
VCE1 code, used by SI and Trinity/Richland, never does, and amdgpu's
vce_v1_0 does (mmVCE_SYS_INT_EN, 0x8340, i.e. byte offset 0x20d00 on
SI).  VCE fences are therefore never processed from the interrupt
handler and are only noticed when a fence wait times out.

Enable the trap interrupt at the end of vce_v1_0_start().  CIK also
goes through vce_v1_0_start() (via vce_v1_0_init() and kv_dpm), but has
VCE_SYS_INT_EN at a different offset and already enables it in
vce_v2_0_resume(), so only do it for VCE1, i.e. before CHIP_BONAIRE.

Observed on a Radeon HD 8870M (Cape Verde, 1002:6821) with VCE firmware
50.0.1, Mesa 25.0.7 radeonsi and ffmpeg h264_vaapi on Debian 6.12.113:

 - Stock driver: the encode hangs after a few dozen frames ("ring 0
   stalled", "ring 3 stalled", "GPU lockup"), and the reset does not
   recover ("failed VCE resume (-22)", "ring 0 test failed").
 - With the hardware ring semaphores of the VCE ring disabled as a
   workaround, the hang is gone but encoding runs at 3.9 fps
   (~256 ms per frame), consistent with fences being noticed only by
   timeouts.
 - With this series: 640x360 for 1800 frames, 1280x720 for 900 frames
   and 1920x1080 for 600 frames, all in real time with no decode
   errors, and 191 fps at 720p / 91 fps at 1080p unthrottled.  Four
   runtime suspend/resume cycles with an encode in between also
   worked.  No lockup, reset, WARNING or error in the kernel log, with
   DPM and runtime PM enabled.

Trinity/Richland takes the same path and is covered by the previous
patch, but I have no such hardware to test.  CIK is not affected.

Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>
---
 drivers/gpu/drm/radeon/sid.h      | 2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
index f9267b026..ba322de84 100644
--- a/drivers/gpu/drm/radeon/sid.h
+++ b/drivers/gpu/drm/radeon/sid.h
@@ -1878,6 +1878,8 @@
 #define	DMA_PACKET_NOP					  0xf
 
 #define VCE_STATUS					0x20004
+#define VCE_SYS_INT_EN					0x20d00
+#define		VCE_SYS_INT_TRAP_INTERRUPT_EN		(1 << 3)
 #define VCE_VCPU_CNTL					0x20014
 #define		VCE_CLK_EN				(1 << 0)
 #define VCE_VCPU_CACHE_OFFSET0				0x20024
diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/vce_v1_0.c
index bdfbcf14b..09fc1572a 100644
--- a/drivers/gpu/drm/radeon/vce_v1_0.c
+++ b/drivers/gpu/drm/radeon/vce_v1_0.c
@@ -350,6 +350,15 @@ int vce_v1_0_start(struct radeon_device *rdev)
 		return r;
 	}
 
+	/*
+	 * Enable the trap interrupt so that VCE fences are processed.
+	 * CIK also gets here but has VCE_SYS_INT_EN elsewhere and enables
+	 * it in vce_v2_0_resume().
+	 */
+	if (rdev->family < CHIP_BONAIRE)
+		WREG32_P(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN,
+			 ~VCE_SYS_INT_TRAP_INTERRUPT_EN);
+
 	return 0;
 }
 
-- 
2.47.3

