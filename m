Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kh2MkJX3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD6D1128A4;
	Fri, 30 Oct 2026 15:15:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6175F10E2B8
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B81D400A3;
 Fri, 30 Oct 2026 15:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1741F0093A;
 Fri, 30 Oct 2026 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373259;
 bh=vvMGgw/UWhNKnumvNPruPbXwq4kySYagxa1PP16pCSo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=kh2MkJX32+crun0SI/KFaM52xWrScDWiwOmumW1iw5yrIDOCQnqNDlSsUeT2EUoaO
 5x0ABBzWmnHT7Z83JkgDmkby/rgTtwpCpdHDAWiZ8EJrPhHxFLWwl1makwijTbQ+ub
 CZzzTq3t8yibo09TN7e3urLyJEzcRJEJtiWBhJvk7LAxqrH5TU36joRCV8xMTA4vjj
 X0FH/GYh5lO515fUv0lA8P+s+MYdDHFIx8kzx6VUQpUIGojZ0s1FCSlLpfUiT1P/Yq
 gMEdAHEUUVJxrlGqGDEZbxsact1VDLWh14rWxI9zVv/B0kPU+GNoLut7Ln7oSQU2/x
 S01cvjTrPRoWg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:37 +0100
Subject: [PATCH v3 07/37] drm/bridge: synopsys: dw-hdmi: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-7-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zB5zZb7uDUftvtyXTWfW3BgB2emc2ZjNXn3zpV0OD20=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtii0W5hN8lC7ea9o+eUEXdd0+VdPs35cT/HPrpFQE
 ClsLBbrmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABOpNGZsOLut5IKNSrhTYFFz
 0baakzHhMzeFRk4NvlmXerU3zKito9Xu4rKfC5ZZHbd9fWhxookRY8PhTSYMm+0iFDv59osF1O1
 b4Tr7Sp6301WLrFcn+r82v/8vZ1MwPU2xTDts4dXZT4733AEA
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

The bridge: synopsys: dw-hdmi connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 937d61c42b58..917cf764c9c5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2570,5 +2570,5 @@ static const struct drm_connector_funcs dw_hdmi_connector_funcs = {
 	.destroy = drm_connector_cleanup,
 	.force = dw_hdmi_connector_force,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

