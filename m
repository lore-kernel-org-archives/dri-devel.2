Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49218606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUmW27sB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6909C11277C;
	Thu,  5 Nov 2026 15:30:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E82191125FB
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EBA360A07;
 Thu,  5 Nov 2026 15:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9221B1F00A02;
 Thu,  5 Nov 2026 15:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892632;
 bh=4ZXkRrSh3hQhAL8mvalidLg0M81jXCN214hK6/Hkt7w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nUmW27sBUrIc0hLNGUbqwedEQo2w2t/9Xvf6IsNy2I4V4cst4bbpriuTMBjPx1lS7
 owol6UoToUXjy5JgvQM1BX8LHhJ7jb95WoY3Xalw/04lR3tKbVg7+EMYuUsqvmt3Ev
 j/CbaNp68H2s0o81hJVpK+bMH6U/9E8Hjk2zMSqiFXViaChhHn+CfpIq8iVaowm+HK
 ARRT2p3I7Kt4iyTxS8b++3tmLOrqjFEGckKfbqD+HjnAd96Fc+5forBhS7EF9/zdkS
 yIAU5Bri27814AG6voNMd3lVX6NfpMNIph1Y7cPZ0+3l2jbQHlaxKOmN0PxohESRBG
 i2FTpGASSMMBg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:14 +0100
Subject: [PATCH RESEND 05/83] drm/hdlcd: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-5-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Liviu Dudau <liviu.dudau@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aaoN2s+KoMKL8fYeE6V5zgcj8hX6dhgF6xNELbuY0Qk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFtzfrS1/4Ff3vZuLGqw5Xs0VX+/7X3SxvVN80MWFj
 ILv7aZc65jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATacphbHjYYqZ762LcxIcB
 VjM35ty0FfB+f+fNa7MzLH2HNkuG39ostllr9vntu7rzvmzX9Fl87yBjndESn097Lnu0LTzh3bd
 6+4NaYaOLGyI0TJft8Hm+6ViVot6T/cpNvNsdT05aGxW1IT9tGwA=
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
Cc: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/hdlcd_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 340b1bb38bf9..58ee8ad1d2ea 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -319,5 +319,7 @@ static int hdlcd_probe(struct platform_device *pdev)
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_vblank;
 	drm_kms_helper_poll_init(drm);
 

-- 
2.55.0

