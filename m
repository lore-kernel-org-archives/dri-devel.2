Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191E606EEAF
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bp/aPeUA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455F8112764;
	Thu,  5 Nov 2026 15:30:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03C95112777
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21CD960A07;
 Thu,  5 Nov 2026 15:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531DF1F00919;
 Thu,  5 Nov 2026 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892617;
 bh=wYlrDbfZKbiUUduhrjo8be3m9UAQA5iV14plflcbeiw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Bp/aPeUAg7cBjr5ovLe/rVnSJe2Gfjy6F9iky8xiSPixVGd0D0v2UE0tf138jjrqz
 kW3g9mjoww5DWgpf97S6mzvw0/K0N7fomXKiGWxLNBQAILl0r2YDndW+qQrAx84dCW
 vPkhTx/9v5fX5z+GR9gCGuFPgaRGmWrg4eKd7tNN6ONcwezpzmB8VumgsESFhEFX/3
 p7aQXbubfqQ4T0eNNRGukbOFMyY7eqW73BbmmS6vA84Teai3mlBPgb0ZWLbRJRev/6
 wKWRAB8gW/wYcfmpiWSqa0hVnLi6By0VEnw3PTS6eCG4PFajLWg/Vm4i7AO8dkO13d
 TQKsQ9SyeqhZg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:10 +0100
Subject: [PATCH RESEND 01/83] drm/adp: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-1-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <k@chaosmail.tech>, 
 asahi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=mripard@kernel.org;
 h=from:subject:message-id; bh=59FroMEoM8DobxGK+qYZEmLe1JeVhpd3TzvlRh+kQ9s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFtyt1niz1b3Y+47lH55bN1SiG9c32xuet9lovTD1n
 HyN2tK6jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRX9mMDa37Ur6dWCW8rfh5
 omRKgc8096D1r40m7Po/e8rm6QWTguUcplhc7GvwfZv63k/N9YNxCGPD+Q9/51v23Nx6REM7sbx
 HN9Lp5KnVvtdafRc1/Jof/onPPcfoSPNT1TUueVIC088euj0fAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
Cc: Janne Grunau <j@jannau.net>
Cc: Sasha Finkelstein <k@chaosmail.tech>
Cc: asahi@lists.linux.dev
---
 drivers/gpu/drm/adp/adp_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index fdf0e6316175..795e8a5d3b13 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -451,7 +451,5 @@ static int adp_setup_mode_config(struct adp_drv_private *adp)
 	}
 
-	drm_mode_config_reset(drm);
-
-	return 0;
+	return drm_mode_config_create_initial_state(drm);
 }
 

-- 
2.55.0

