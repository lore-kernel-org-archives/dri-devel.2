Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4FB606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UuE0GR0n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A413110FBB0;
	Thu,  5 Nov 2026 14:21:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED8C10FBB0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:21:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2634E43EE8;
 Thu,  5 Nov 2026 14:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850B81F000C1;
 Thu,  5 Nov 2026 14:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793888511;
 bh=xVsn5Kxzaz40rCzXYq0YK8MSVUYNe930U1ctswhPCYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UuE0GR0nNYazST1MPjLLYRSlYCaToluYyIXu5DxGlVoMj6AGNYI3G9MO7ECzlr7H/
 OPgRWrzXicfflEm731ejYyavNapkFDhB9OUZYyjMmDNT0Suqok34WuCXpGNJVVqTlB
 ffZr6JuLZpaZBD0BZbX25FXC2tmbzfF562K11AIUHo1vCuIC1VTuqsxScw3QBkCC8y
 gNgzRU6FXrhWclV3iiilJrKn5/bQlBCpeRO7WkVQ2pi/gldcmojQYdKcmsrLDgq2j1
 fMsffnIHbR2F7iTSsTH8bt+GAw6BPrPOK5xjVsppFAQOUhWLdADDScoJVHKe1fC41E
 XH17gzrcucakA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <dev@lankhorst.se>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 6/7] MAINTAINERS: Remove myself for VC4 DRM driver
Date: Thu,  5 Nov 2026 15:21:26 +0100
Message-ID: <20261105142127.708219-6-mripard@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105142127.708219-1-mripard@kernel.org>
References: <20261105142127.708219-1-mripard@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I have not been actively involved in VC4 maintenance for a while. The
driver is in good hands with Dave and Maíra.

Remove my maintainer entry to match the current situation.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maíra Canal <mcanal@igalia.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dcaab8bd5f6..ba7c1f71f6ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9211,5 +9211,4 @@ F:	include/uapi/drm/v3d_drm.h
 
 DRM DRIVERS FOR VC4
-M:	Maxime Ripard <mripard@kernel.org>
 M:	Dave Stevenson <dave.stevenson@raspberrypi.com>
 R:	Maíra Canal <mcanal@igalia.com>
-- 
2.55.0

