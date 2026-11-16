Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16710606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nw0Bql9h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0600010EF08;
	Mon, 16 Nov 2026 10:32:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0654710EEFB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE0DB41ED2;
 Mon, 16 Nov 2026 10:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536BB1F000C6;
 Mon, 16 Nov 2026 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825153;
 bh=SeA023brq4F2V6AUUVd4VJUo91BEUFaxp9HCTfQ4yD4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nw0Bql9hCxcZLMjS/6n4jJ16kHhJ1fTd70Ewfx8wXRSlZPvAkUR6FTxiHUUv8XR3Y
 jAldUndQ0NMUQ8YUzfAhkqHfOKJzjIlqOXDoI6rGAXbsUhS7cKXSVXCgOjJX/oZhZU
 s1sG+woadmDYFDBsDukF6IT2lkWMdtZ4RHXxWr7L9VWbg42Caf9Sxo0CrTjLj9ryj+
 qr7NPbO+91FSx2UvzJEZ8zBnesRl+KS7XWFG6uCPhY/tuzGc/2qOIE3Age4ePThFp9
 GuEZ1Cw4WEywP4jpTuUkYgovkjREWLSiZwqjp+zHq0iAxHR/5Ft/3XZ5g40eB6vnB/
 jkyt/T13n8Ftw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:46 +0100
Subject: [PATCH v2 30/64] drm/st7735r: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-30-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=mripard@kernel.org;
 h=from:subject:message-id; bh=NZEOQ3SaC+dFTcashR18ymsbkMXy1NJQ3cQ0Zw3w0fE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvt+eLV9UZDDmZvGTnr29ot2uikn8l3+uG3OlsbcJ
 D+DLRtfdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ+DYy1hln7fm7QjPWIfNE
 7s0dnkcnSp5fbLGU+Uwy+5zYkHU5R36dWv61qvVtbX3UuY29JeJ61Yz1jt0Tjs18zlT0IcX52x+
 VLzsvci9/OPPD9w3Kkut6nkVMZenNdZ1YyiTZMDH+3Pxl5hduAQA=
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
Cc: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/sitronix/st7735r.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0..e6c77b01dd38 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -333,11 +333,13 @@ static int st7735r_probe(struct spi_device *spi)
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		return ret;
 

-- 
2.56.1

