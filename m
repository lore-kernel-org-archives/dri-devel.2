Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D623606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfCBuvag
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7199A10F1C1;
	Thu,  5 Nov 2026 14:21:38 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8360410F1C1
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3574443508;
 Thu,  5 Nov 2026 14:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9248D1F00919;
 Thu,  5 Nov 2026 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888492;
 bh=Y7OD9oB886FwBnycpBk0+BY40U4Vvyo1LuEZ9Ir1Vh8=;
 h=From:To:Cc:Subject:Date;
 b=WfCBuvagCDjHRn7vDxVO8Iww3+kLM/4GmaSLvSxMt5CgrQK3PchbERn+qOrKhxu0h
 szJain4pvhpIgwSET0liJcgmKWbg3nc1TcBf1aV4DxWhl7vfRvTiZzsMYC+TEYHPvG
 XRRYullTlf4tZR50x9K5Qm/zx8gtrlIRnV/y19N7I/s0Mgpv62tYkLNvQCsp50nsbC
 B2JqIL+oei5RHjbO9Bm+Q4FtTIrLMEKldRhA62DFrTVl58MeBrGUfjsBk+VwfjVPWc
 mQGouDG3ea7LE1bb7wHlgBKaKVGZ1mJwI2aObZORuJmqJIjCQNHEVnwSp49sP2Bo+y
 YAuhl48E6BAGw==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/7] MAINTAINERS: Move armada DRM under drm-misc
Date: Thu,  5 Nov 2026 15:21:21 +0100
Message-ID: <20261105142127.708219-1-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The armada DRM driver has its own tree entries in MAINTAINERS, pointing
to Russell King's drm-armada-devel and drm-armada-fixes branches.

However, the last pull request from that tree was sent in July 2019, and
more than 80 patches have been merged through drm-misc since then.
The driver is de facto maintained through drm-misc already.

Remove the dedicated tree entries and the drm-misc exclusion for
armada to reflect the actual maintenance path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Russell King <linux@armlinux.org.uk>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c10342aa32f3..6856dd5a2b74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8893,5 +8893,4 @@ F:	include/linux/vga*
 F:	include/uapi/drm/
 X:	drivers/gpu/drm/amd/
-X:	drivers/gpu/drm/armada/
 X:	drivers/gpu/drm/etnaviv/
 X:	drivers/gpu/drm/exynos/
@@ -16153,6 +16152,4 @@ MARVELL ARMADA DRM SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Maintained
-T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-devel
-T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-fixes
 F:	Documentation/devicetree/bindings/display/armada/
 F:	drivers/gpu/drm/armada/
-- 
2.55.0

