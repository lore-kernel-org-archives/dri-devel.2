Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC040606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VTaZFF/K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0076B10EF20;
	Mon, 16 Nov 2026 10:33:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8D810EE6A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:33:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70EE943C23;
 Mon, 16 Nov 2026 10:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF091F000C4;
 Mon, 16 Nov 2026 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825208;
 bh=uHeAS1OD5csAjrNv2BLWSyP7HOHZUd2Im5PvMQjQSHs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VTaZFF/KKoNP6jRQHurmIoURF2cPwZjYBAMQ5irPqv9zLNJDjzL7xQ8oidW/ARh5S
 5KtGrHw+mBZ/YxduykwyQfJu6F2r1RA4Mco8S+jXMvPHPn4kjPDqhkxU8RuVh+J5w4
 +2HJUxrAS97nXJMtSPiuJKLkpPxLPTQH9FfabU73D6Re1QKm6O+KMUXk8UACwAsh3i
 4tdmRcMtCfU2YTRfZ5A3RSb48AGJRMms5mQWUmh688b2gm6WGFmWwjqs2XLOgrLLrW
 IYeWkeLAV90gyOGnzI9gJPDo5vrVV3NLb8TjJ3DZsGiFIQb6IyWJ96N85xxPhiFF7R
 mtHgGkd9GhgIg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:03 +0100
Subject: [PATCH v2 47/64] drm/gm12u320: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-47-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=mripard@kernel.org;
 h=from:subject:message-id; bh=kjBxV9Rxk0B/SC1PWT+i8pSDygx9B9DuRLCilWuFAGQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bocU7ZygdfDFEsn55qkPlFVadLO6D05uVfzx6Xzjw
 b+SG08EdkxhYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJrHZkrFPv3/5C+fvf1qCU
 rhkCnTMfPKvQmZ7Wquzr1xoU/MWxxFFwyT/heH+Pd89FTmd2+CwqZixiDtg8+3UQV+ruBXfOZ5x
 Z9Km+xnVb+9IVk24t+xS03m1l0kNVsfVvfS2///Zd1cdw5wcA
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
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/tiny/gm12u320.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 5c4004346ff8..527b830e4465 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -770,11 +770,13 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 
 	ret = drm_connector_attach_encoder(&gm12u320->conn, &gm12u320->encoder);
 	if (ret)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	usb_set_intfdata(interface, dev);
 	ret = drm_dev_register(dev, 0);
 	if (ret)
 		return ret;

-- 
2.56.1

