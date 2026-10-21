Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02960606A330
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iiRQ/HCb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DFE11245B;
	Thu, 22 Oct 2026 09:42:12 +0000 (UTC)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D360E10FD97
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 11:41:59 +0000 (UTC)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-9907fa1d2d1so157970241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792582919; x=1793187719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BIPpbckw4KCv3KnM8UNOMNM81SAc/Xr6FmEH7qH71N8=;
 b=iiRQ/HCbz+8yCBvyU4r/TowKsX5jy+r7GnqJzrDJRFkb7p4pbfPkfxGvZwZXoTgZpy
 VNhQfs5zqYfdX8rNERfqKRF9ZSMHcBlwz1tAv9/8X3Skowl+45twlpumhiKM0oeyxe9u
 jzFj+uRBqIqJAQc0TRL2+ePw61kSlcg3poILy7IyHtJtPkrcw84TXFeohkan/HJcH9xW
 stDMHMVlF+EkzREBnEqiFyp7BHmIvlmESd5dfENsdCvbe8U2X939SQaTfvumF3wNV9g5
 Vd0Qd4/rYgZs+wNxvPfPW7WbmIGBH3DWBeSrbzVhtIqQ7AQetz6w8dVeBXSEG448tjcz
 WZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792582919; x=1793187719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BIPpbckw4KCv3KnM8UNOMNM81SAc/Xr6FmEH7qH71N8=;
 b=PVbnIsClr7Qn62c+jZaL0Ja+obDNLxaXkqKW363O9+b+pkkcTzFKuB1yhCKAGOZsur
 9LYxH+o7uVZ8GRbIjTuAq42MawCHds/+KzTLuWpGSZnyT83yHe2rTBzRjNTHlMsAhfUl
 91omqpai4lddaig5rLyvwikUBsU7fksKCv5LRFhEXV9k4ZgBwoPu3yEcMF8vX19cIJ4j
 41AJV5jwcUx/egNvbyHXIPURH0KY0FtuLbUrWxd3xd6ixYMaIv5dl3qnE2oQ56o31bD6
 R8QcT363+L4RZJIaxNbRcIbDIscpg7FGm60f5lo8Nh2lxTBzcOcuzGcvSsxodXmQVray
 1EQA==
X-Forwarded-Encrypted: i=1;
 AKwUvByhuwMzyaxxLPR45K2z9fBxg6GTzeeYe4EY0d48kkew5yGsV/6Pp49TlvvvXEZ4uraNoeG4Qs3ccC0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLePWbJLFLzFK0LMbZW+YVX6aoMhrhvmijvx0lib0w6JK+nxQQX
 ie/xnIlN+bRlLhKjT2RTWNCdFWSnftIwxuGXCRaAYNZXgzdw6cwwR5qp
X-Gm-Gg: AYBFou1tHPWbYqINn0P8Wn/2/uoVOBDPsH9qptEbh5cCEIgkrsXV3RUlcgB2hhmwbkY
 2xRm5bw2GKI+QexVwbNlzGwEotoM036gmbJzEFT5mG7pImQyhAwoh5QG+Q9vzeq+nMN3292qtBR
 YAAN5w+Ulhxpm80IcjqiUHyIlRObi+/ungrvsmIwQ0hquJUBBnmlmIMqjovchFdKr3T9jgFyyfN
 Vdmxv865donjCbmEiBP+o1qJWUiHWOsth83Xzyo7od4nI+bVXe/eVXUjW89RxR64o832dncsYf7
 ID6bxmCKG+QNhyqUaWP0LaTVtM7nNvn/IAfvw2xaU5yybVccYuv2rlD12LMm/3gsM5on1P/3gTt
 1EHP9fwx1shu/MSb9CEfRRxXq5aVX4749QlWwl/R3tW9oC2c0+Mn6ZHGsrG4rgHqRm5XYAifrqi
 /Pe7uOYjVuW3aOyng+9yoRUjpOhzqfQVvlgDA+vfqoy4xlQi/IGamdquEuKKe+H7PR+gfn0qaiR
 Qc//msmk5SbKLMIXVVllwnLcxK8zgqSjcxJSO9aIrOr/HlqiTebnkPJauqDegyjENfE0M8=
X-Received: by 2002:a05:6102:508f:b0:7cc:1ace:fd0b with SMTP id
 ada2fe7eead31-7cc925e41e6mr560431137.8.1792582918645; 
 Wed, 21 Oct 2026 04:41:58 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cc91f9c7f1sm2365006137.0.2026.10.21.04.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:41:58 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/radeon/vce1: enable the VCE trap interrupt
Date: Wed, 21 Oct 2026 08:41:18 -0300
Message-ID: <20261021114122.94008-3-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021114122.94008-1-mptagliari@gmail.com>
References: <20261021114122.94008-1-mptagliari@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:41:15 +0000
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

Enable the trap interrupt at the end of vce_v1_0_start().

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

Trinity/Richland shares this code and is covered by the previous
patch, but I have no such hardware to test.

Fixes: a918efab631a ("drm/radeon: add VCE 1.0 support v4")
Cc: stable@vger.kernel.org
Signed-off-by: Matheus Tagliari <mptagliari@gmail.com>
---
 drivers/gpu/drm/radeon/sid.h      | 2 ++
 drivers/gpu/drm/radeon/vce_v1_0.c | 4 ++++
 2 files changed, 6 insertions(+)

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
index bdfbcf14b..0866e7fb0 100644
--- a/drivers/gpu/drm/radeon/vce_v1_0.c
+++ b/drivers/gpu/drm/radeon/vce_v1_0.c
@@ -350,6 +350,10 @@ int vce_v1_0_start(struct radeon_device *rdev)
 		return r;
 	}
 
+	/* enable the trap interrupt so that VCE fences are processed */
+	WREG32_P(VCE_SYS_INT_EN, VCE_SYS_INT_TRAP_INTERRUPT_EN,
+		 ~VCE_SYS_INT_TRAP_INTERRUPT_EN);
+
 	return 0;
 }
 
-- 
2.47.3

