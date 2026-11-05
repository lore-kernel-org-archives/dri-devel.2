Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE13D606A330
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SvLx4EhU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1710D1127B5;
	Thu,  5 Nov 2026 15:33:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDEC711279F
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 630FF60254;
 Thu,  5 Nov 2026 15:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930511F000C1;
 Thu,  5 Nov 2026 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892831;
 bh=R7KrM62yOUnHV6hFnbb0NxCK9rX7uFEJAKwlauRxkr8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SvLx4EhU5Q8m0KUIP19TFYJwiEVWkxm80n2QLYX9dLpn0yaPwZa4CgJ7xdgBFmMRF
 l/xj51jhCc4ATSDUECztmpaousQ6br4gubzo9L89Xwv8aGLCtmx6Sg8eyV9mBou4rt
 pjjY3Jw0rfGVqwKO1/WLGxShfeifqsFqPh7jnJWkLdLN/4geUv9jo1oDFOTopslUy5
 IhRiZBOEpQ8gUA6emxRQreCxfU8qwVnAaScKxQmI3s0F+d7YwrhSJSnFmH5ezpE+R2
 nBQRkBzRLhTBl0tuQELndZHtT3L4jD4NW9nbE+kbLcQQBNQUdeHqHRsdiUXJaIN05k
 ytANuaNvyG4Bg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:09 +0100
Subject: [PATCH RESEND 60/83] drm/arcpgu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-60-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alexey Brodkin <abrodkin@synopsys.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5/f03Tk0Wk2udtHv3JSSEV8nNIWe6ZeW9WHn4aW5TzA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFnyv74ktSNkk+sqcw7zp46NT7z9ITz4lsUFSxPXC4
 ley+hy5HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiW9wYGx7pSic5l8ednbls
 F3fl0Zam/7eEjk9blrvNftNZ/57f2pzFPZcVa9a/mt9Xayg2/30aD2OdvWnEngKebQIz04qY5mw
 9VPMvbmnMBsmLG++dK7Jd1HxfPy92zqP9N7lmfxUTtU3buPktAA==
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
Cc: Alexey Brodkin <abrodkin@synopsys.com>
---
 drivers/gpu/drm/tiny/arcpgu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 32f6e98ba9c5..08747a98ff3b 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -417,5 +417,7 @@ static int arcpgu_load(struct arcpgu_drm_private *arcpgu)
 	}
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 	drm_kms_helper_poll_init(drm);
 

-- 
2.55.0

