Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFE606A334
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKvgfKgZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E031127AD;
	Thu,  5 Nov 2026 15:33:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C95112794
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D08894192B;
 Thu,  5 Nov 2026 15:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A921F000C1;
 Thu,  5 Nov 2026 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892787;
 bh=IqPuZDEqz7Hw3yyIdXCdTBxTNqansoOyTS6XivjULlE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IKvgfKgZyFyzOnPzaLrPJ4v/Ihx7GbXo4JDMQpohbUuWxY18E+1g813SNlhTgVaFc
 AmQK6p/0OFpeppRGMfqKL7EiS+6ZD5vDVqCIQlEicMZVSdzuDe/S1ucFpencQXG33e
 TVF3ckwLU0dOnH2A148FCAXFcjZ1dV0gFgwkiVvaYztuP91mgumciYQrioqMSj6dg1
 qWnjOWnq88K415A02xC24Q5c53SQPGBy3nUR68eNTQUTd6zEx8Q3jIUv2j7C+6IWZp
 arA/jprbOq8we7J+/fY4FOQP3DW/n21Uoxj2vflptI0eOhqDhp0X3UCA5T3I3nLLDw
 SDlr0Rp54Sp5A==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:57 +0100
Subject: [PATCH RESEND 48/83] drm/corebootdrm: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-48-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Javier Martinez Canillas <javierm@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; i=mripard@kernel.org;
 h=from:subject:message-id; bh=hfp7fIYX1stmALbb6s4vujdmPtNFhcTV4RjZK0GL5Pk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFny6e8P/Rl2+UIWv4HS53QZsX+9+Xmy8hGF7UschW
 +ui2nP6HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAik5YxNpxenPjKM9/Doyas
 1GxFoHb6QZvgaZuT3pwVv7jM2uFaQPhTPcmYwx81Dl773jShbSIvB2PD09j3oZX35+pvCf1s/E7
 LNIj7LaOuuuPh8+uDrnr9NfbVuMl76rnRSkbuiB1BPvNPBKsAAA==
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
Cc: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/sysfb/corebootdrm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/corebootdrm.c b/drivers/gpu/drm/sysfb/corebootdrm.c
index 853da9a609df..e7806a9215d1 100644
--- a/drivers/gpu/drm/sysfb/corebootdrm.c
+++ b/drivers/gpu/drm/sysfb/corebootdrm.c
@@ -422,5 +422,7 @@ static int corebootdrm_probe(struct platform_device *pdev)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(dev, 0);

-- 
2.55.0

