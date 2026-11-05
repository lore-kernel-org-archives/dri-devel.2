Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EC606A331
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ed+o32wt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E4221127BA;
	Thu,  5 Nov 2026 15:34:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75DB1127BA
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D0B4240020;
 Thu,  5 Nov 2026 15:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358FA1F00919;
 Thu,  5 Nov 2026 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892852;
 bh=8Pgjx1xcYDAPSCXDa8m0AgWNO0ch6wJe5roTrUBiTx8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ed+o32wts1/0h/v4fWD5KZ3zs15pkG3pbfZ//rZlD5IsqWEnqi+pbIy8yQsTpC67N
 EkMFlmvrvL5WxJYXgdDVjOR3Ak0wlkO/0Aoqfpxm7q53ahu5hCf0aXYs0qnj/i/zLM
 HzQXGEz72+eLE7evKHn+R3HvUrWGrUvaVJO6lLOpum8YWIc4zQFhbzlg34fAx0ydoM
 CrCUQtDOsb0y69nuhFBgVmSmTyODXtXYU/Q7jGefhVEc29rN3Fko+gU7VhvStqJyIW
 VT5zcE2r50Vnco7+YUiEC3G3733hTQBuWTRc492LospdbL03DdAOJofrNUH03DHsZz
 +3iCHanpITWrw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:15 +0100
Subject: [PATCH RESEND 66/83] drm/ili9225: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-66-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 David Lechner <david@lechnology.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XUsRgW3nW26XJMVtAzrWr2M7HTNlpky3lh2xGSBm6ds=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvxqDehffS9TJn3XcoZfJQXN+h1OyclJa4Ld4r1CJ
 ln8vhPcMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACay+Cljw/PSyP23Gg/z7f+X
 /CIkXsEzpvYKt6a9l5zGgl9Td3Zd/+4lGMQ80/7R5hdbDlxjSLX0Zmx4yfmXnWHX5eaThtWft7Z
 t3+Brmh1vFHOfJTMibGWVwqWkaxOephhVLr7HmWucKXve2RIA
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
 drivers/gpu/drm/tiny/ili9225.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 5bf52a8fd75b..3b1f3b9a0abe 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -519,5 +519,7 @@ static int ili9225_probe(struct spi_device *spi)
 		return ret;
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

