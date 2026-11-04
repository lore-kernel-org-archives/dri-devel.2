Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2756F606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PAITUGj0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A438112C36;
	Fri,  6 Nov 2026 09:18:43 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24DF210E4E0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 13:47:50 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490c1d337d8so124677f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793800068; x=1794404868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=chOAKJyoAP1QGXXxzfUXTvuj5Kz+HpMI3in4etcGZ30=;
 b=PAITUGj0K0eoCikQzNFNUrT7in/H5OkjVS1O+mELlrnbBvtKp5U5BHnnG/+ASiZUHY
 oNbuKznNtMwqiYaeolFa0225bZgbUKU9DyzfbXtjYBRYdPaJncsvobks4o2e+GHwDJR9
 XS9zFgXIDua8nt1HNMPVeWJf9CxgSHY5KJXFzL9Kgtb4limIrtWyq7RYEy5h9sCeZGep
 GIq6ZnJV2irSk++1ynfjC0lVRxPwa3Yf7c95Rir8AvKo2LGmExjpRTKK6hAgfB0u/ufK
 +0If1eQ9atMGqGGKXzDtqfC0yhA3x0GMrEgft3S7OkDxU/sDxer1ZudaVxp9mHccJLru
 3r1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793800068; x=1794404868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chOAKJyoAP1QGXXxzfUXTvuj5Kz+HpMI3in4etcGZ30=;
 b=gRYScmSEFkECtt0E5NgtQk9Iw2iZa/KHRvSqUnBT6Rl7l4S++32pnGJ1tlE+dAvl56
 4OxjDBvmeR0b3R/Dw0U3mPp7sEVVB70Kr2VMsMYF3qOpOcgqUENqZxSr2RmGpuHPoJ0c
 1EqCh9ASUlD43YAO838kR2Jh4AAJsVEy/NmHN3qccSrl2SIDxOnEESsam6d2D7eAxUuq
 vee3nxjoQho4oUjVJgdDqjsRi6ClpgY1wnKbjefKpelapKJW15W9doMjKo11biVHXhRI
 0xQNCevzzmjELqNw/TTgLJZ12LRQH/dfOFOnpGaQUE8dAcWmAZ273loqt++j6tKK5owv
 cZWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByGnd3W7JI/Xch7uCqWBUQ3s2tcglFLD6+FscZYPdtOMZzbxU5I+LHM21cQMPU1nhdjqhmFm+G7b1M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8+gG0B94OW/a39HFB3yPkIsvfJJLf8uaWQPMBaB7WU22Jq3nws
 YXMK6naJNPoGOgAiJHukcWdMaaG5rtY3QAo8piVSK+Z0kzT5Srs+IrHo
X-Gm-Gg: AYBFou0dIibbW2pESnIs0T3D9PKZAE9acHk6xeFG7odQidmO982F3KPJoTjVu+QBCSM
 xKVih5d7Wvz7LWMyErlGbMutLF6E2+2zuZMCojVb3qcsxg5CTf1Tc4F/hVwMvgUI9roXtBiGk2w
 oAWLsLuSSio5LGNBgycoXp+5WIvUXnAmMcBuNU1eu+RPNJigTKSJ4CEouhLrGxJQyFWXWg7Uy52
 10s+ju4PhBq9vjfjlbRKBX/4rdCdbCQNpf8Eqqsoz4XK1k13xKhnm4LLWh8juIL04Y9t/jwzqKl
 a4EaKEyQPZOET8StVEJtjwHSa17t6UzqcGMuZeIUwU2b0VdIUGgq3qd+MAUYB0pqas79baCy4q+
 0lEjU1IRC8A1Kf3Uf+zCTdaWvRzoEakn00tNlP2z0F0p1+ZR6LCuQ0NlAgtWVInSRDlHSnL0sGf
 i0z5RhR6VX3N49GabUHSQ7YWu//OWW6tN9MnP0E171ttTHXT6p4ijoXIjaodwuE8bw5bQ5zBcY8
 TlyhqbK2w4RertNvO9vnGgnhCqYHvQf4FbSes1pLNv5njXomz/QknboIIv2fwFoyxkstRSWg7iO
 QcM85wvzKflncTtKHSJM8kFHsiZ/ql7Z0UymbEUktWDxZiaeuaUm4JShK+bsUcZX8Xp9QXqypCR
 1ag==
X-Received: by 2002:a5d:5848:0:b0:48f:bb68:4e87 with SMTP id
 ffacd0b85a97d-48fbb6850famr8447369f8f.32.1793800068424; 
 Wed, 04 Nov 2026 05:47:48 -0800 (PST)
Received: from kreach.multipass (nat44-21-238.net.ruhr-uni-bochum.de.
 [134.147.21.238]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99d67sm4033718f8f.24.2026.11.04.05.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 05:47:47 -0800 (PST)
From: Jude Gyimah <jude.gyimah87@gmail.com>
To: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 rodrigo.vivi@intel.com
Cc: airlied@gmail.com, simona@ffwll.ch, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jude Gyimah <jude.gyimah87@gmail.com>
Subject: [PATCH] drm/xe: fix CONFIGFS_FS dependency
Date: Wed,  4 Nov 2026 14:47:28 +0100
Message-ID: <20261104134728.3723002-1-jude.gyimah87@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

xe_configfs.o is pulled into the xe module only when configfs is enabled:

  xe-$(CONFIG_CONFIGFS_FS) += xe_configfs.o

With CONFIG_DRM_XE=y and CONFIG_CONFIGFS_FS=m that line becomes xe-m,
which Kbuild ignores for a built-in module, so the object is left out
while the rest of xe still calls into it:

  xe_guc.c:(.text+0x217e): undefined reference to
    `xe_configfs_get_psmi_enabled'
  xe_guc_ads.c:(.text+0x1a28): undefined reference to
    `xe_configfs_get_enable_multi_queue'

Eleven xe_configfs_* symbols are undefined in all, referenced from
xe_module.o, xe_guc.o and xe_guc_ads.o.

Require configfs to be at least as available as xe, which is what the
stanza already does for KUNIT, INTEL_VSEC and X86_PLATFORM_DEVICES.

Reproduced on v7.3, x86_64, with:

  CONFIG_DRM_XE=y
  CONFIG_CONFIGFS_FS=m
  CONFIG_DRM=y
  CONFIG_PCI=y
  CONFIG_MODULES=y

Found with kreach, a static check that compares what Kconfig allows
against the symbols the compiled objects actually reference.

Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
Signed-off-by: Jude Gyimah <jude.gyimah87@gmail.com>
---
The checker is at https://github.com/JGyimah/kreach, and the
reproducer configuration for each finding is published with it
under results/.

 drivers/gpu/drm/xe/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..fe3061f3b4ec 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -4,6 +4,7 @@ config DRM_XE
 	depends on DRM && PCI
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
+	depends on CONFIGFS_FS || !CONFIGFS_FS
 	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
 	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
-- 
2.43.0

