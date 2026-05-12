Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DA7CD4F24
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3607910ECF2;
	Wed, 13 May 2026 07:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Z/SusmNw";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C479010EA9C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:01:53 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2bd5658b901so749117eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1778594513; x=1779199313; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vlzeRCGXQHDoiU445JgrUjhM/Fxu9dKmbf7Dmmy0kyk=;
 b=Z/SusmNwF31P68pAKe2k8W39rXvuugNryDxWSPItsAOlULDYvjhtdgeCXh1UgGxYXx
 x2X9VsX5DcGWBGGl7l0EQquK+Xbxd7Tlbg8x1z79MkheyYwT4z6pLFp4mBbaHkEcrh7m
 TB/4d47gidyqXO2ZfNmYX0QZ9D5sLnk0M6n81e90Zt3zRg9FTFgQGQ49nmR/xyKPQ11L
 mOb/2djxdwlvkTWL5GDdqG2Jcgm6RjWQrGGS4+DWsU0sWU1pC/gWNM+9Um6rVFvem/FA
 PpAIPKHN/XsmfnUr1SfcilmtbrnjaB2l+597mloAM8oVnuo3Qn409vgCDNvrADfOxkQo
 0/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778594513; x=1779199313;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlzeRCGXQHDoiU445JgrUjhM/Fxu9dKmbf7Dmmy0kyk=;
 b=IxxQ6tDCyBaTWI2gPMPyW7v6uZusiPXW4ovRZQEMlfPN6pBfsoIIQ+2/RvhwYn2o6J
 SooHMT2D63yYs7LYB2XTMhw5Ex8KnTTzwBO8y9rCh1/dvm64ScFYke+kUYtDHvigF80e
 R8aG0hsMrAG1STU7DqR52Uu/OFITcTZXfLO4ir7n4k3ThSfL4xuQEp7WPjXimm6HBVqF
 iXMbGKT/8PuQ4ZXHwPty7sKCy6chxvB+Fby9TDt+twrYdFaidVKmAs2LXVcGN1GaK0ge
 Y6IKv8CpQ86oDjgf2ZxIHeIRJ4Ym/PF0IV5wPbh4ev492Zp3GikYSnB4IhBAm6qilPW9
 w2IQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Cm/TJKPalQ12vjUIiAGle+dPAayUttPujy1Nzrxo8SKgGhWhdOn6sqr9LzzLaEJgIcz+7DzHy+oc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz41BTk4FL3N8K8sbZF7ffJ2+c5WFe5AyShMDzv4si0Qso7MOcf
 vdzPPYWEJFfu7wThdymGtadVqpb+uYoATuozZsTgeQcP4bhyY4ZDUOPu6Zc/D6UdIH0=
X-Gm-Gg: Acq92OFeZT3tlJeZVTGaAtdMaCRt5AoCJM4ZWrI2jALppYMm6PzIPgtcfFnocyV55Cf
 Sb3L2gw52ch0WD3rOrVaCNoRylOK56jadXJyhA2MImDUR8OyUKm+MXHsgYr4AG46vdKVZ/63zA7
 O2hPuUZvbXXaBf7hsZOCKTkQrFVv8KCNUKCvnXAJuoV4KFL/g134y9SaS+dTVdVXx1g/yKQy41Q
 pwtTXs/Sz6OjlaD/B08h+qIhE35FPI96KVKoN9BHBiXSM0mYwr71g+b/rNMW/0hpzKi/2fjrjIM
 l5vLsWhPQlK+M+IN06JQ8zc9dRQaN3P1PiXKI0nbIh2O8oIRp2bjpE2W+EUQvO6m/3PWMZ+WVp5
 cKiWRK4lACJX9MVio6r+7G97L5eR/V5+0jeUfdeK2bCaoxUjOW0mTmq6D/OdFS/Fz3QrNCWY7ah
 vPRaDHsqum2X5MCfUYvBtBBe9PXukMm1KUD4ERZaunbcMV194ygg==
X-Received: by 2002:a05:693c:2c02:b0:2d4:62f0:b2e1 with SMTP id
 5a478bee46e88-2f564430643mr5786104eec.0.1778594512263; 
 Tue, 12 May 2026 07:01:52 -0700 (PDT)
Received: from Haru.. ([2804:1b1:f980:4df5:7d73:b89a:b932:2c0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm22377608eec.23.2026.05.12.07.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:01:51 -0700 (PDT)
From: Leonardo Cesar <leonardocesar@usp.br>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Leonardo Cesar <leonardocesar@usp.br>, kernel test robot <lkp@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix inconsistent indenting in
 amdgpu_gfx_ring_preempt_ib
Date: Tue, 12 May 2026 11:01:29 -0300
Message-ID: <20260512140142.6610-1-leonardocesar@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

Fixes a whitespace indentation issue reported by the smatch static
checker tool.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605081621.Euvx7ORX-lkp@intel.com/
Signed-off-by: Leonardo César <leonardocesar@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f7ebead09..d213a0cdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2725,7 +2725,7 @@ int amdgpu_gfx_ring_preempt_ib(struct amdgpu_ring *ring)
 	}
 
 	/* deassert preemption condition */
-    amdgpu_ring_set_preempt_cond_exec(ring, true);
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
 
 	if (i >= adev->usec_timeout) {
 		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
-- 
2.43.0

