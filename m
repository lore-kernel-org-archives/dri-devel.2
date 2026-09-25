Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFACDCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9230210E86D;
	Mon, 28 Sep 2026 08:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mlopop8o";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DBC10F85E
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 07:25:06 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso3932805e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790321104; x=1790925904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jJsFR3C4BXwq6V8a4asvimu14gijx70uQQhfBt9Dfjk=;
 b=mlopop8o3CPIABgoNh77bfKzDcwZIKdAhhn6mKWFvsg1rOORpm31hv8r3TBsx7ufnp
 SsImscV1vY7dVleSbLs0kAvU3nBPFVyfvPzMZrXr2q+1VF2E1s+XGdhynOxbHSLcAxXI
 L9RrUS97DzYGLlbA8Eyrb4JZiw46D4dQzsCWipfv9TH1+6JwjsrYLLKg1W75xA5SLM8x
 W24gm78V36u5ez1jY0dZ/9AbgsNozlTv2i4bAOJCNrW1uqr/0gc1QAscB+doCkwMlp/y
 sjGjqlQv3J8iq4wAEQ9vPONkgiOEXhBQlq4H4BOZuWBap2Ap8W84EeJKcuDPFPh59AWh
 w2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790321104; x=1790925904;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jJsFR3C4BXwq6V8a4asvimu14gijx70uQQhfBt9Dfjk=;
 b=G1aJfZo8Tbcxw7Q0QDyeyMumIKoT2XpQb4qw1qaNoFa1BeXCC4nLLDmCC0YEb8cpQb
 w3YMjnK13PitNx4J5xsZO2XA0fS/gvclg73o75TKJvIDKTYV1ez5CeP+rRItGDsVkP6G
 UHaDv6ZSR9Blx1aS/cbr/WVSIWR7ulbqKj6vXSj8UU+lIsGv0JnfJ012xEnqfjqN67MB
 /oF6n6KD6gOxIaaTcz4/rNl2DCJImQYN4afolrR+/pVwblehcatdfhk8FPBnT8s+hUik
 wNRKB8DOjlV+iJXjWcP5R3eJJEFVHfGxaV2FRMvQ5yvd+J6QeyQ49HzxjrN906Avf8vP
 ABog==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdKI1PEaT9BL6tKX1dcHcPsd3gOG96d/yegOjiWQDFT3F2aHcZACInMJDGOVvLj+EaEPqErPIM1vA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nm3uK60qlsquutJV5G4eQOfqDDHjgvBVdeKxHAjFtDTU6Yz0u7
 ZnFI1bYcgf5O1OkCjN5Zo6zjStJ+PUQgbThM3RuUS6CqGZzjGaKIhDn/
X-Gm-Gg: AYBFou0zGLljuBGzSnMQeLVVuXB/j0pHMr/o5S1DdfAOl6RaeA9qsIlWL5g3S45c7gS
 aUQYxnHX9+r3IZ2GxvjSjHHsqg1mjisTOKwg0UMr+OV74ItZ0YKs9Evn6nn/Jeac9vtKZPqnZMe
 RgYFj0nKOlj19Q3+gSrbwGG+Dzh32oDbfa5RvOQ7s5TyqJ6I1q/Y6xelL993bbs41VFGDCpyy9E
 SkdkyfDzjf8pZxIFL6dTrfzoYBV6hT2plvFxrgXQBJAWY2W9AwwIYbZqDs+s+foF2VORq7qsr/L
 mkLhlMBBQp9jrd0GnbH/703SIVdMkJfNZ8e7cfWGZUXuo+w4u2P7fan5YaO5hOv0ZIbz6kYF6Y7
 CgKvMc6HHtImlyvg9N//gj8CN0wjBajdNJrm6Ky7FAItvls6IIpBXC57RaPwheduxVxn37cUgt+
 QmocvMEg7KuvDYP3IK/hi5SFdiRit9CorIvWPqm0I5hVxHJGn2tUVYR38dOvgpMA0iXHRjLvtLo
 bT7tw==
X-Received: by 2002:a05:600c:1546:b0:49c:fa20:cc00 with SMTP id
 5b1f17b1804b1-49fe66f4f59mr83248455e9.23.1790321104123; 
 Fri, 25 Sep 2026 00:25:04 -0700 (PDT)
Received: from abcmhome.hgw.local ([83.66.10.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5dfa6a7sm201790475e9.12.2026.09.25.00.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 00:25:03 -0700 (PDT)
From: =?UTF-8?q?Ayhan=20=C3=87i=C3=A7ek?= <ayhancicek@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 =?UTF-8?q?Ayhan=20=C3=87i=C3=A7ek?= <ayhancicek@gmail.com>
Subject: [PATCH] drm/amdgpu: extend MacBook VRAM-at-0 workaround to VERDE
Date: Fri, 25 Sep 2026 10:24:44 +0300
Message-ID: <20260925072444.18982-1-ayhancicek@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

The existing MacBook workaround reserves VRAM at address 0 for
Polaris ASICs when the iGPU is enabled. This prevents cursor
allocations from landing at address 0.

A MacBookPro11,5 with Radeon R9 M370X (VERDE) hits the same
failure mode. Hardware cursor updates repeatedly log
"DC: Cursor address is 0!" followed by
"DC failed to set cursor attributes".

Extend the existing workaround to CHIP_VERDE. With this change,
hardware cursor operation is stable, the cursor errors remain at
zero during repeated cursor movement, and cursor disappearance
and flicker are no longer observed.

Signed-off-by: Ayhan Çiçek <ayhancicek@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1bf2a42fa..9e7f9cc2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1086,6 +1086,7 @@ void amdgpu_gmc_init_vga_resv_regions(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_VERDE:
 	case CHIP_POLARIS10:
 	case CHIP_POLARIS11:
 	case CHIP_POLARIS12:
-- 
2.55.0

