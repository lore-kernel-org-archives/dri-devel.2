Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D55606A336
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oldc6Aux
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E361127BE;
	Thu,  5 Nov 2026 15:34:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E4C1127BE
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB4B760A74;
 Thu,  5 Nov 2026 15:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D621F0093A;
 Thu,  5 Nov 2026 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892863;
 bh=6iVnu8b8HrnN0YSTkkS8klqLYwNfa1Aghu5nlxuCeSY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oldc6AuxSMQrjIvmy8Foed4lSKELXGQkioJRM7aOGFu0QwSoAz2L6hMfAAPNlgInI
 lGWORSdaum4XimiFqknXdtIumMa7FeL4XraT2Wp4pWXz7UuO+myeWndR8O+VRqveGn
 KlvCtYbcf7g9kSGN5HmfcBmmbitRNmbKu/Aie/pkDpWqhxJ0hMxz9Bn9lOnY0OOnyh
 jjItjtY3oqAYmD0NJcjvT3tLzmcM5kmUBbqVdr3PSgClKtY0ZMrbwr/KBsEV3aFlYE
 4nDVNqYUdqjolwU0uAqtfkpqar2qz+5r0FkYZll5IrmdIRFJNuxQsN6DWyXwPbXey9
 4/MtVHP4nXu9A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:18 +0100
Subject: [PATCH RESEND 69/83] drm/mi0283qt: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-69-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=mripard@kernel.org;
 h=from:subject:message-id; bh=K4rITA8eRMGwuhlChs81WUwd9KuWDZHRufOsBKNEGoo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvwuqT417zrjHWGV051C6cvSel8E9t7Q2H1i18Ff3
 yU8w85zdExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJ1P5lrE/Oz735ymbl1Qib
 1AWb3i23tPA/dU3+a/aEHWJ8bfZvqzalWsUG2asz1zw6e5zb72PXf8ZaUcnZ30IkN0lo281avmn
 K8xtvdFgv8nW973H9bffuopzY/3gNWYfbvW3J5+cnrNuv6GsKAA==
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
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/mi0283qt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index b0121e89e2dc..cf53509044d1 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -331,5 +331,7 @@ static int mi0283qt_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

