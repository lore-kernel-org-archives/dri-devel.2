Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A7606A33A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrxuvDSA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EC010EEC9;
	Mon, 16 Nov 2026 10:31:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10E510EED9
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:31:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 554E7628BF;
 Mon, 16 Nov 2026 10:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9884C1F000C8;
 Mon, 16 Nov 2026 10:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825070;
 bh=/NAF00evtwUJz+8QgjO2Sfa88arXT+PN+BnlprHILcg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FrxuvDSAI/lJ+o3hNipJNQxzFRk083DJ4SIJQxHfqhF4tybd3QsXkoSjasfT1ZWz+
 jh60txMZMTKReu7eAFCjYTozx1P5RHU7pyGx65Ga3T+p+UARHAb0BeCjMTroDOh6/f
 Zd2G1CGpwaanKmgBQyT7VHkJMymAXCd3v6ggR1xskJQpd3M4wHUSr5fDKofZW2Pi+0
 3Tc6cFBQ84D4VgFFdEQ9fn/sDpjkiAUSqWUXP+5D6kWtYB25XWBAVfq28oPl+RAg1M
 eYRxMWNd8EVaV11S3Su4co1kzj/NKF2F2WnvuX/5Pp1V7Z7qXyeO+oBiJaNC9CZBXT
 B/0FF9yEXXFEw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:20 +0100
Subject: [PATCH v2 04/64] drm/hdlcd: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-4-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ilVpe9jMAFJudu/suPPnPawOCLJLqbzguigBAJseAis=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bjtqlbxv3LpjQ0iMsYZmphWTrdcjgYPOl0W3tG9Z/
 tnm0guPjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRGU2M9eXOejeSGLXiL67f
 eGhGWKG0rrSEpd6FgFm+mpaZ2z9eDl36cALr5bfBPiETsxvk2C3XMTYsMtSTtXO8dcvC6vsUw6/
 3VY2M1P/LL7+SrTc5VEAp1XNukek1RZW52ulRQq/qRP6fvAIA
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

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index f2bf9a61979d..8c48549abf11 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -316,11 +316,13 @@ static int hdlcd_probe(struct platform_device *pdev)
 	if (hdlcd_read(hdlcd, HDLCD_REG_COMMAND)) {
 		hdlcd_write(hdlcd, HDLCD_REG_COMMAND, 0);
 		aperture_remove_all_conflicting_devices(hdlcd_driver.name);
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_vblank;
 	drm_kms_helper_poll_init(drm);
 
 #ifdef CONFIG_DEBUG_FS
 	drm_debugfs_add_files(drm, hdlcd_debugfs_list, ARRAY_SIZE(hdlcd_debugfs_list));
 #endif

-- 
2.56.1

