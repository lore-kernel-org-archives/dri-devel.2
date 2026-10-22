Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFD606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jGS1hOPn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 119E51125BA;
	Thu, 22 Oct 2026 12:36:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118781125B8
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EF1D941318;
 Thu, 22 Oct 2026 12:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572351F000C1;
 Thu, 22 Oct 2026 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672541;
 bh=fP5ZzG5BYOMroj/BMRw+mELsCATZtgVgFGFS4DYQl5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jGS1hOPnRXFGVD1R3LkWAYbznU5X/7dUdRu45ImGy5L3gzhnKMatoJTEMC6WE3ZzZ
 XUcMe08szLU+S4OoVl86pRcT+6cG2SLcijdpp96PtMGE4VT/s0t895Nv6B4uw8Bma9
 mQ3Ad/Dn7vTlgDycS+Grn4PAm7lmQFswk3PCsyYAiSKz6KPwdxf1DGCGklyHX/auvS
 aE4uq5PEl3T2aZmc1etbhv/sf388jeibPmdcM+Bgf+nRM1vdX1Rcpavnahs4Gw9z+Q
 X9qMfyBqUiFFOtVphFwa4BgFB7XU6hrK81xUznpt5mAV7kL4V+SrdKYxaf8kKUaN1M
 9wd6yY2iGy+tA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:31 +0200
Subject: [PATCH v2 32/59] drm/tiny: arcpgu: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-32-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alexey Brodkin <abrodkin@synopsys.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lRmM4tqeA3Vt8gf7dUtrCiy7xIkgvbo20a7VjxyAHLo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGaf2aCykmmq5vRHm37NPSXgbLs+vedin6/IvfYYr
 nvvJL7adkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJLK9irGaX+nMrx7CwuIs7
 S9PMlTOkKjJRcdOSXW84d5skGM/sTjoqd0lD9ma/9ALOrUJBnw7yMdbpb6yX5fNfeuH+YY2sl2u
 7viye/CStzvSD8OqFWvxLNbZ3tssvNv04S04rX519vTwHSykA
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

The tiny: arcpgu connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index cdbf28db8fa1..32f6e98ba9c5 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -99,7 +99,7 @@ arcpgu_drm_connector_helper_funcs = {
 
 static const struct drm_connector_funcs arcpgu_drm_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

