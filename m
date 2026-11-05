Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EC606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfWnXMJc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9649810E246;
	Thu,  5 Nov 2026 14:21:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49C0211245A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 924E160136;
 Thu,  5 Nov 2026 14:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3231F000C1;
 Thu,  5 Nov 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888496;
 bh=AbZaAGC7BAEhzBfzGlO413AhHsrID12pXk6YaQvNDSI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jfWnXMJc61VogvIlUzBg4Ar2B8hk5G1TEqZxFHyh0bOMEG96hevvHXdtCQyifhat9
 mp9srb7j4sDUgnVgvWUKqk/bvXL06dT+xmcdPbuym/zauw0h1UPU8ik56hlD1M460L
 iwuD0tv4x3ugR3tt8COXUwnwEXQzRfOcgd7KoU3sNuIyG5iXcGcW+16Ro5YJlMniF8
 hjM85sjlgi3ldzqIj50GB3QsrLe4MUc9jmyTfxRarTZpaGDlukrwzxviHXC16H81eK
 XEL7jAfEJrNHAa8Yu0GoKFsgQ9asdjDSeWUsqMpyJe/rm8n/0C2gYkqarI40jCaCE4
 axNfMIlz0BDGA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>
Subject: [PATCH 2/7] MAINTAINERS: Move Keem Bay DRM under drm-misc
Date: Thu,  5 Nov 2026 15:21:22 +0100
Message-ID: <20261105142127.708219-2-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Intel Keem Bay DRM driver is excluded from drm-misc in MAINTAINERS,
implying it is maintained through a separate tree. However, no dedicated
tree is documented in the MAINTAINERS entry, no pull request has ever
been sent, and around 60 patches have been merged through drm-misc. The
driver is de facto maintained through drm-misc already.

Remove the drm-misc exclusion for kmb to reflect the actual maintenance
path.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Anitha Chrisanthus <anitha.chrisanthus@intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6856dd5a2b74..f25c296665e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8896,5 +8896,4 @@ X:	drivers/gpu/drm/etnaviv/
 X:	drivers/gpu/drm/exynos/
 X:	drivers/gpu/drm/i915/
-X:	drivers/gpu/drm/kmb/
 X:	drivers/gpu/drm/mediatek/
 X:	drivers/gpu/drm/msm/
-- 
2.55.0

