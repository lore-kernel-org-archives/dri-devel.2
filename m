Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D419606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VH609/io
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931AD10EA0A;
	Fri,  6 Nov 2026 13:15:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3398C10EA0A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:15:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB457601BF;
 Fri,  6 Nov 2026 13:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85711F0089F;
 Fri,  6 Nov 2026 13:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970911;
 bh=UNidYHUJSYyhq9siTMLF7mDYm7Y5Q9326otOmNVXZeA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VH609/ioayjoOo75MfTHnYJKRzuQv5iqnJ+IHmBpL3a4EBpB58G5l5v28s6bpxbph
 co/uJ7jp/FgOrtDIpqTe3g77l+rctqJV4zaEny3K0bFUXmGIdUyQkgm+QJhjBHt8lw
 aH8NLGPGvLmrulqPxClmE95ALaoDZlAjBG/BXZQ7Af5y79GGOPr/h7+GOzQbCctTzS
 g4ibAnE+WTZiKNYBYG1gDg8CsqV1Lvroqd7xHF8qRD6o8mUKZPMwC5BnlCRPGlNjGU
 oPwKuVI9GRw+eLUZu/4Bm3KXUD//IJ9JQ+5103wDOFNztmhUgB5UyiEXNyA0VZgJyl
 PTiMlVHm70Jrw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:21 +0100
Subject: [PATCH v8 08/39] drm/bridge: Switch print_state to use bridge name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-8-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=mripard@kernel.org;
 h=from:subject:message-id; bh=jbJtM0qjKCUDFowQEXqQm1/W835e/rBoWMr+YxAXCCk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL2148/jc6VCB2fNCgybp85c/qbg27esfRbmGvzEly
 ZubfruKdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ/P3DWCstYviqOG/6NO8t
 29yT2LfwnXyaPOfO2pONd0+l9Wz+fI7zas2hds30+IxAK8WNlupJCYwNz4LjmH0+vLRQaIzpWxI
 89faOwzcdtd3ZJzxom9Jxpcp/s8y6a39Vc15vnJF088i1hEAtAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_bridge_atomic_print_priv_state() currently identifies bridges by
printing the symbol name of bridge->funcs using the %ps format
specifier. This produces output like a raw function pointer name, which
is not particularly user-friendly for debugging.

Since bridges now carry a human-readable name, switch to printing
bridge->name instead. This makes the state readout output more
consistent and easier to interpret.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 11aaa4ae5102..aed3fcf0e180 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -573,7 +573,7 @@ drm_bridge_atomic_print_priv_state(struct drm_printer *p,
 
 	if (bridge->of_node)
-		drm_printf(p, "bridge: %ps (%pOFfc)\n", bridge->funcs, bridge->of_node);
+		drm_printf(p, "bridge: %s (%pOFfc)\n", bridge->name, bridge->of_node);
 	else
-		drm_printf(p, "bridge: %ps\n", bridge->funcs);
+		drm_printf(p, "bridge: %s\n", bridge->name);
 
 	drm_printf_indent(p, 1, "input bus configuration:");

-- 
2.55.0

