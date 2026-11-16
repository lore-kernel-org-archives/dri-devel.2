Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3723606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOVJ0sdt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B83010EF27;
	Mon, 16 Nov 2026 10:34:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4860110EF21
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:34:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 18F8040B96;
 Mon, 16 Nov 2026 10:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FE81F000C4;
 Mon, 16 Nov 2026 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825266;
 bh=cPxw3aYYBLigADTcI4SlIXlMJEXTrBE7jDrQPVYxnU4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=GOVJ0sdtju6lmhH4mnC2M8/hc8nGzWyPAeJGJdQ6QYDbymuSXh/78YO6nkU3+RHAn
 etwarNaJknJNmss++RCkt7e77eyGQPmRwFBv/MCA9X6djidOUCA0Hgo8vXexeR2BzZ
 pprJbgHe06wHZixllvDmQ82EueSccudOh7vA0bftCreCWaEsDcQWXa14VWcVaz2aHV
 xMW3WY00IELWgAgvfXMCphgq6zw3eQsmiL5xGQ3F13T/n5Ge4wGebwZarPDyzKQLn7
 NNCuu119R1zavT/mOFMuMBVARumhQiyWmhaQXjCeCdApRN+ZDR2qQp+fMQ+3nEwVOI
 jA5j1yMTVbw+Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:20 +0100
Subject: [PATCH v2 64/64] drm/xlnx: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-64-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=mripard@kernel.org;
 h=from:subject:message-id; bh=r0hztRW4DDqV9eS0f2XpGO8RAVKHrIWpOTA2mtUThbM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bse4ZCbOe9r3YYvjm/hCtZC5nz3vTzw7K5GDb21d9
 Vbu8sCqjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCREinGWim/45t1zxr6bjOy
 2NGw9f+sz1tWpylVtx53vZfq+iT5KptCxKWMIpH6+e9So04ExKWsYGzYKr9l24UAlgWmOa/4tFk
 6Pv/4c/Um8/f9JsmG3tEuD3YJ7b3Jb5ugWpZ+8MXPSU29bocB
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index 5274bd3f9078..c123ded46f4c 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -522,12 +522,14 @@ int zynqmp_dpsub_drm_init(struct zynqmp_dpsub *dpsub)
 	if (ret < 0)
 		goto err_poll_fini;
 
 	drm_kms_helper_poll_init(drm);
 
-	/* Reset all components and register the DRM device. */
-	drm_mode_config_reset(drm);
+	/* Create the initial state and register the DRM device. */
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_poll_fini;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret < 0)
 		goto err_poll_fini;
 

-- 
2.56.1

