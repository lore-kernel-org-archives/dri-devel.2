Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A9606D80C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j3OODWw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42EB810F8B4;
	Tue,  3 Nov 2026 22:42:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C665010EE3E;
 Tue,  3 Nov 2026 22:42:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FA6A60A6A;
 Tue,  3 Nov 2026 22:42:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5523B1F00A16;
 Tue,  3 Nov 2026 22:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745741;
 bh=0sdOH+ree5IgSPVQKTOIGghF0UA7yYGr+BoCWpeeYkw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=j3OODWw5Srwk+0gbX4fyeLkLjZvFoO6R0yB4+xMzR8P/p///RRFdepCpbPXSBgM3l
 +yNqBT9AaqMvua1u+Mi/APYqqzvs+QC5lEMqPR2VJu9jUsuGlRaK2mmH5+Z/jrQS5I
 S2IvZmvzmEuWMHa8M5I8Yot7Mc/NF+DQP1sItWdZgS3GeQuF4pyy0XWKKo6OcJlirU
 HXZBrslBY8ifd31JeUokHTeUfyRgHNvpfgg8mMqT4h+nIsTHwxdiRAvwVibOHwurAY
 8VHKoF+iwJ6VVxZ/cgyd42tihAf3cQaIb/ihdiYteZrSH8HKjopnyJLihisQOReD87
 dlHd5wuE8ChNw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Tue, 03 Nov 2026 16:42:04 -0600
Subject: [PATCH v11 03/12] drm/amdgpu: Check bios_scratch_reg_offset in
 backlight level helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-superm1-backlight-property-v11-3-00cce7b2ba22@kernel.org>
References: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
In-Reply-To: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ensure adev->bios_scratch_reg_offset is non-zero before accessing
scratch registers in amdgpu_atombios_scratch_regs_set_backlight_level(),
so they are not accessed when they were never set up, such as in KUnit
tests.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v11:
 * Clarify the commit message
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 27c0dc8f6137a..2d8c2ba04e670 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1622,7 +1622,12 @@ void amdgpu_atombios_scratch_regs_engine_hung(struct amdgpu_device *adev,
 void amdgpu_atombios_scratch_regs_set_backlight_level(struct amdgpu_device *adev,
 						      u32 backlight_level)
 {
-	u32 tmp = RREG32(adev->bios_scratch_reg_offset + 2);
+	u32 tmp;
+
+	if (!adev->bios_scratch_reg_offset)
+		return;
+
+	tmp = RREG32(adev->bios_scratch_reg_offset + 2);
 
 	tmp &= ~ATOM_S2_CURRENT_BL_LEVEL_MASK;
 	tmp |= (backlight_level << ATOM_S2_CURRENT_BL_LEVEL_SHIFT) &

-- 
2.53.0

