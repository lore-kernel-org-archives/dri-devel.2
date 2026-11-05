Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834E606D83A
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J0c0xFPh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5ACE112790;
	Thu,  5 Nov 2026 15:32:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8F211279D
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:32:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C714B4078E;
 Thu,  5 Nov 2026 15:32:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B3E1F00A02;
 Thu,  5 Nov 2026 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892758;
 bh=wCMH9AgO82xnbm0KV3561iSj6j+Q5VgDWFvx4C/upjE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=J0c0xFPhJMDEeOch3/IWJieb7Regq3JP9mHU01CTa64L4ZEWWg3MY4W+V7mBFTJ3v
 Uha4OR90I29SN59hipMDLooo8FGc/SAVsdChk1i3jxS9SmMLP5vXl7casLNNEb8j8q
 BOr9Fdttx0Yks/dfvFI2arSrYx7HiXtPuWcEjdX7kBi4+NkfFTo9vzScIXiVEwMV7/
 IuilyijVFS8a2bTNVanoQBqnuOSXJg0uane3NOvdwYCg8mLaErJqaT7nK9uXm0EGNl
 STwAkFe5tOnXeXeMHAsc6W6nkjszFKfS8Y8QhMpEwhF0W4+GicduT+Q1iRJixV292h
 FiuZFOLQEsjQA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:49 +0100
Subject: [PATCH RESEND 40/83] drm/st7586: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-40-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1Y3WpKtFM53C/XhBXk/Ov3vJHuI2q9zvLiBIWptoT6M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFrxjL3n3/KCYY4LeLLaF1pziuqzKLy9wTO6ISujs8
 HheHnmmYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEwk9Apjfd3SZZG/50Zf3ZIj
 OXmeZlzfEo1bPH8+m93ZETurkSHr1cN9/yZbTdrQM2nzkh8eLxIZVBjr6yuMLKSn37Lxj7szv+v
 qBkOvK0cfeGlmLPRaojGLI/yV+ALj8/N8m7bNfr+gi7d0VgwjAA==
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
 drivers/gpu/drm/sitronix/st7586.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 28b2245f6b79..50b2e4c901ce 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -456,5 +456,7 @@ static int st7586_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

