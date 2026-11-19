Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE5606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJOHzLs8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CEB61123DD;
	Thu, 19 Nov 2026 13:35:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4359D1123DD
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:35:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 544EF6181B;
 Thu, 19 Nov 2026 13:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DA91F000C6;
 Thu, 19 Nov 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795095337;
 bh=4ERNklaAp5e3SE8OkVHFrJXTcqhWx+IsuYEXKtunHJ8=;
 h=From:To:Cc:Subject:Date;
 b=FJOHzLs8Z3noXFjDSYJCJzFHQeONK1dbwAHoyFT8fKB6HOTFwZCEDWcock9CVvYtM
 HmaiPb5fXumS9ODpUj/liytYPYH4ooZyQInoL+pDpvo49wTza42xijrfwqPDHJsgj4
 bQfsebqnomsvIV8FkG43MD2Thp19EYie9PgVwkJX6tv3cezBeEhG3+6hVYtS3+6m2z
 je5VUx6S28oE3o6gkJV8WHbbTTq26jFLZjGuRBPne3xjIXUvX2FXPBhW8H08nmbJuD
 +wgz+zzb2Qe+2vEylkH6Fx+UeCfTznk5d6VVcFvrP8HB+3eZJDgvbymtTjNyFZEAuP
 vw9Wa+1uIb+wA==
From: Maxime Ripard <mripard@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Robert Foss <rfoss@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] MAINTAINERS: Add Luca Ceresoli as bridge maintainer
Date: Thu, 19 Nov 2026 14:35:33 +0100
Message-ID: <20261119133533.520180-1-mripard@kernel.org>
X-Mailer: git-send-email 2.56.1
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

Luca has been one of the most active reviewers of the DRM bridge
subsystem without having the maintainer status.

Add him as a maintainer to match the current situation.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58afe23cea51..346111c44951 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8943,14 +8943,14 @@ F:	Documentation/devicetree/bindings/display/atmel/
 F:	drivers/gpu/drm/atmel-hlcdc/
 
 DRM DRIVERS FOR BRIDGE CHIPS
 M:	Neil Armstrong <neil.armstrong@linaro.org>
 M:	Dmitry Baryshkov <lumag@kernel.org>
+M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 M:	Robert Foss <rfoss@kernel.org>
 R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 R:	Jernej Skrabec <jernej.skrabec@gmail.com>
-R:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/bridge/
 F:	drivers/gpu/drm/bridge/
 F:	drivers/gpu/drm/display/drm_bridge_connector.c
-- 
2.56.1

